# CI/CD with Jenkins

## What is CI/CD?

CI/CD stands for Continuous Integration/Continuous Deployment.
In  short, the CI/CD process involves the following steps:

1. **Code**: Developers commit and push their code changes to a shared repository.
2. **Build**: The code is automatically built into a deployable **artifact**, such as a binary or a Docker image.
3. **Test**: Automated tests are run to validate the build and catch any issues.
4. **Deploy**: The build is automatically deployed to a **test or dev environment** for further testing and to validate that the changes are integrated with other systems.
5. **Release**: If the tests pass, the build is (automatically??) released to **production**.

The goal of the CI/CD process is to automate the software development lifecycle, from code to deployment, to increase efficiency and speed while maintaining high software quality.

# Jenkins 

**Jenkins** is an open-source tool that is commonly used to automate the CI/CD process.

## Install Jenkins Server on EC2

Jenkins is typically run as a standalone application in its own process with the built-in Java servlet container/application.

1. Create a ***.small, Amazon Linux** EC2 instance with `20GB` disk.
2. Connect to your instance, execute `sudo yum update && sudo amazon-linux-extras install epel -y`
3. Download and install Jenkins as described [here](https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/#downloading-and-installing-jenkins) (no need to install the EC2 plugin).
4. On Jenkins' machine, [install Docker engine](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-container-image.html#create-container-image-prerequisites). You may want to add jenkins linux user the docker group, so Jenkins could run docker commands:
   ```shell
   sudo usermod -a -G docker jenkins
   ```
5. Install Git.
6. Create an Elastic IP and associate it to your Jenkins instance.
7. Open port `8080` and visit your Jenkins server via `http://<static-ip>:8080` and complete the setup steps.
8. In the **Dashboard** page, choose **Manage Jenkins**, then **Manage Plugins**. In the **Available** tab, search and install **Blue Ocean** and **Docker Pipeline** plugins. Then restart jenkins by `http://<ip>:8080/safeRestart`

## Create a GitHub repository with a `Jenkinsfile` in it

A **Jenkins pipeline** is a set of automated steps defined in a `Jenkinsfile` (usually as part of the code repository, a.k.a. **As a Code**) that tells Jenkins what to do in each step of your CI/CD pipeline. 

The `Jenkinsfile`, written in Groovy, has a specific syntax and structure, and it is executed within the Jenkins server.
The pipeline typically consists of multiple **stages**, each of which performs a specific **steps**, such as building the code as a Docker image, running tests, or deploying the software to Kubernetes cluster.

1. Create a new GitHub repository for which you want to integrate Jenkins.
2. In your repository, in branch `main`, create a `Jenkinsfile` in the root directory as the following template:

```text
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'echo building...'
            }
        }
    }
}
```

3. Commit and push your changes.

A **GitHub webhook** is a mechanism that allows GitHub to notify a Jenkins server when changes occur in the repo. 
When a webhook is configured, GitHub will send a HTTP POST request to a specified URL whenever a specified event, such as a push to the repository, occurs.

4. To set up a webhook from GitHub to the Jenkins server, on your GitHub repository page, go to **Settings**. From there, click **Webhooks**, then **Add webhook**.
5. In the **Payload URL** field, type `http://<jenkins-ip>:8080/github-webhook/`. In the **Content type** select: `application/json` and leave the **Secret** field empty.
6. Choose the following events to be sent in the webhook:
    1. Pushes
    2. Pull requests

## Define the Pipeline in Jenkins server

1. From the main Jenkins dashboard page, choose **New Item**.
2. Enter `AppBuild` as the project name, and choose **Pipeline**.
3. Check **GitHub project** and enter the URL of your GitHub repo.
4. Under **Build Triggers** check **GitHub hook trigger for GITScm polling**.
5. Under **Pipeline** choose **Pipeline script from SCM**.
6. Choose **Git** as your SCM, and enter the repo URL.
7. If you don't have yet credentials to GitHub, choose **Add** and create **Jenkins** credentials.
   1. **Kind** must be **Username and password**
   2. Choose informative **Username** (as **github** or something similar)
   3. The **Password** should be a GitHub Personal Access Token with the following scope:
      ```text
      repo,read:user,user:email,write:repo_hook
      ```
      Click [here](https://github.com/settings/tokens/new?scopes=repo,read:user,user:email,write:repo_hook) to create a token with this scope.
   4. Enter `github` as the credentials **ID**.
   5. Click **Add**.
8. Under **Branches to build** enter `main` as we want this pipeline to be triggered upon changes in branch main.
9. Under **Script Path** write the path to your `Jenkinsfile` defining this pipeline.
10. **Save** the pipeline.
11. Test the integration by add a [`sh` step](https://www.jenkins.io/doc/pipeline/tour/running-multiple-steps/#linux-bsd-and-mac-os) to the `Jenkinsfile`, commit & push and see the triggered job.

## The Build phase

The Build stage specifies how should the code be built before it's ready to be deployed. In our case, we want to build a Docker image.  
Let's implement the Build stage in your Jenkinsfile, will build an app called "Yolo5". 


1. The complete source code can be found under `14_yolo5_app`. Copy the app files into the Git repo you've just set in previous sections.
2. If you don't have yet, create a private registry in [ECR](https://console.aws.amazon.com/ecr/repositories) for the app.

3. In the registry page, use the **View push commands** to implement a build step in your `Jenkinsfile`. The step may be seen like:

```text
stage('Build Yolo5 app') {
   steps {
       sh '''
            aws ecr get-login-pass..... | docker login --username AWS ....
            docker build ...
            docker tag ...
            docker push ...
       '''
   }
}
```

You can use the timestamp, or the `BUILD_NUMBER` or `BUILD_TAG` [environment variables](https://www.jenkins.io/doc/book/pipeline/jenkinsfile/#using-environment-variables) to tag your Docker images, but don't tag the images as `latest`.

3. Give your EC2 instance an appropriate role to push an image to ECR.

4. Use the [`environment` directive](https://www.jenkins.io/doc/book/pipeline/syntax/#environment) to store global variable (as AWS region and ECR registry URL) and make your pipeline a bit more elegant. 

#### (Optional) Clean the build artifacts from Jenkins server

1. As for now, we build the Docker images in the system of the Jenkins server itself, which is a very bad idea (why?).
2. Use the [`post` directive](https://www.jenkins.io/doc/book/pipeline/syntax/#post) and the [`docker image prune` command](https://docs.docker.com/config/pruning/#prune-images) to cleanup the built Docker images from the disk. 


## The Deploy phase

We would like to trigger a Deployment pipeline after every successful running of the Build pipeline (`AppBuild`).

1. In the app repo, create another `Jenkinsfile` called `deploy.Jenkinsfile`. In this pipeline we will define the deployment steps for the Yolo5 app:
```shell
pipeline {
    agent any
    
    stages {
        stage('Deploy') {
            steps {
                sh '# kubectl apply -f ....'
            }
        }
    }
}
``` 

**Note**: to keep the Jenkinsfiles as clear as possible in the source code, you can change the Build pipeline name to `build.Jenkinsfile`. 

2. Create another Jenkins **Pipeline** named `AppDeploy`, fill it similarly to the Build pipeline, but **don't trigger** this pipeline as a result of a GitHub hook event (why?).

We now want that every **successful** Build pipeline running will **automatically** trigger the Deploy pipeline. We can achieve this using the following two steps: 

1. Use the [Pipeline: Build](https://www.jenkins.io/doc/pipeline/steps/pipeline-build-step/) step that triggers the Deploy pipeline:
```text
stage('Trigger Deploy') {
    steps {
        build job: '<deploy-job-name>', wait: false, parameters: [
            string(name: 'YOLO5_IMAGE_URL', value: "<full-url-to-docker-image>")
        ]
    }
}
```
Where:
- `<deploy-job-name>` is the name of your Deploy pipeline (should be `AppDeploy`).
- `<full-url-to-docker-image>` is a full URL to your built Docker image. You can use env vars like: `value: "${IMAGE_NAME}:${IMAGE_TAG}"` or something similar.

2. In the `deploy.Jenkinsfile` define a [string parameter](https://www.jenkins.io/doc/book/pipeline/syntax/#parameters) that will be passed to this pipeline from the Build pipeline:
```shell
pipeline {
    agent ..
    
    # add the below line in the same level an `agent` and `stages`:
    parameters { string(name: 'YOLO5_IMAGE_URL', defaultValue: '', description: '') }

    stages ...
}
```

### Fine tune the Deploy pipeline

Review some additional pipeline features, as part of the [`options` directive](https://www.jenkins.io/doc/book/pipeline/syntax/#options). Add the `options{}` clause with the relevant features for the Build and Deploy pipelines.

## The build deploy phases - overview

![](img/build-deploy.png)

## Security vulnerability scanning

The [Snyk](https://docs.snyk.io/products/snyk-container/snyk-cli-for-container-security) Container command line interface helps you to find and fix Docker image vulnerabilities.

You must first to [Sign up for Snyk account](https://docs.snyk.io/getting-started/create-a-snyk-account).
Make sure you've installed Snyk on your Jenkins server.

1. Get you API token from your [Account Settings](https://app.snyk.io/account) page.
2. Once you've set a `SNYK_TOKEN` environment variable with the API token as a value, you can easily [scan docker images](https://docs.snyk.io/products/snyk-container) for vulnerabilities:
```shell
export SNYK_TOKEN=mytoken

# will scan ubuntu docker image from DockerHub
snyk container test ubuntu 

# will alarm for `high` issue and above 
snyk container test ubuntu --severity-threshold=high

# will scan a local image my-image:latest. The --file=Dockerfile can add more context to the security scanning. 
snyk container test my-image:latest --file=Dockerfile
```

3. Create a **Secret text** Jenkins credentials containing the API token.
4. Implement Docker image scanning in your pipelines (where?). Use the [`withCredentials` step](https://www.jenkins.io/doc/pipeline/steps/credentials-binding/), read your Snyk API secret as `SNYK_TOKEN` env var, and perform the security testing using simple `sh` step and `synk` cli.

Sometimes, Snyk alerts you to a vulnerability that has no update or Snyk patch available, or that you do not believe to be currently exploitable in your application.

You can ignore a specific vulnerability in a project using the [`snyk ignore`](https://docs.snyk.io/snyk-cli/test-for-vulnerabilities/ignore-vulnerabilities-using-snyk-cli) command:

```text
snyk ignore --id=<ISSUE_ID>
```

**Bonus:** use [Snyk Jenkins plugin](https://docs.snyk.io/integrations/ci-cd-integrations/jenkins-integration-overview) or use the [Jenkins HTML publisher](https://plugins.jenkins.io/htmlpublisher/) plugin together with [snyk-to-html](https://github.com/snyk/snyk-to-html) project to generate a UI friendly Snyk reports in your pipeline page.

## Pull Request testing

It's common practice to perform an extensive testing on a Pull Request before the code is being deployed to production systems.
So far we've seen how pipeline can be built and run around a single Git branch (e.g. `main` or `dev`). Now we would like to create a new pipeline which will be triggered on **every PR that is created in GitHub**.
For that we will utilize Jenkins [multi-branch pipeline](https://www.jenkins.io/doc/book/pipeline/multibranch/).

1. From the main Jenkins dashboard page, choose **New Item**, and create a **Multibranch Pipeline** named `PR-testing`.
2. In the **GitHub** source section, under **Discover branches** configure this pipeline to discover PRs only!
3. This pipeline should be defined by a Jenkinsfile called `PullRequest.Jenkinsfile`.
4. In `main` branch, create the `PullRequest.Jenkinsfile` as follows:
```text
pipeline {
    agent any

    stages {
        stage('Unittest') {
            steps {
                echo "testing"
            }
        }
        stage('Lint') {
            steps {
                echo "linting"
            }
        }
        stage('Functional test') {
            steps {
                echo "testing"
            }
        }
    }
}
```

5. Commit the Jenkinsfile and push it.

From now one, we would like to protect branch `main` from being merged by non-tested and reviewed branch.

7. From GitHub main repo page, go to **Settings**, then **Branches**.
8. **Add rule** for the `main` branch as follows:
   1. Check **Require a pull request before merging**.
   2. Check **Require status checks to pass before merging** and search the `continuous-integration/jenkins/branch` check done by Jenkins.
   3. Save the protection rule.

Your `main` branch is now protected and no code can be merged to it unless the PR is reviewed by other team member and passed all automatic tests done by Jenkins.

Let's implement the pull request testing pipeline. 

9. From branch `main` create a new branch called `sample_feature` which simulates some new feature that a developer is going to develop. Push the branch to remote. 
10. In your app GitHub page, create a Pull Request from `sample_feature` into `main`.
11. Watch the triggered pipeline in Jenkins. 

### Run unittests

1. In the **updated** app directory (`14_yolo5_app`), you are given directory called `tests`. This is a common name for the directory containing all unittests files. The directory contains a file called `test_allowed_file.py` which implements unittest for the `allowed_file` function in `app.py` file. 

2. Run the unittest locally (you may need to install the following requirements: `pytest`), check that all tests are passed:
```shell
python3 -m pytest --junitxml results.xml tests
```

3. Integrate the unittesting in `PullRequest.Jenkinsfile` under the **Unittest** stage.

4. You can add the following `post` step to display the tests results in the readable form:
```text
post {
    always {
        junit allowEmptyResults: true, testResults: 'results.xml'
    }
}
```
5. Make sure Jenkins is blocking the PR to be merged when unittest is failed!

### Run linting check

[Pylint](https://pylint.pycqa.org/en/latest/) is a static code analyser for Python.
Pylint analyses your code without actually running it. It checks for errors, enforces a coding standard, and can make suggestions about how the code could be refactored.

1. Install `pylint` locally if needed.
2. Generate a default template for `.pylintrc` file which is a configuration file defines how Pylint should behave
```shell
pylint --generate-rcfile > .pylintrc
```

3. Lint your code locally by:
```shell
python3 -m pylint *.py
```

How many warnings do you get? If you need to ignore some unuseful warning, add it to `disable` list in `[MESSAGES CONTROL]` section in your `.pylintrc` file.

4. Integrate the unittesting in `PullRequest.Jenkinsfile` under the **Lint** stage.
5. (Bonus) Add Pylint reports to Jenkins pipeline dashboard:
   1. Install the [Warnings Next Generation Plugin](https://www.jenkins.io/doc/pipeline/steps/warnings-ng/).
   2. Change your linting stage to be something like (make sure you understand this change):
   ```text
   steps {
     sh 'python3 -m pylint -f parseable --reports=no *.py > pylint.log'
   }
   post {
     always {
       sh 'cat pylint.log'
       recordIssues (
         enabledForFailure: true,
         aggregatingResults: true,
         tools: [pyLint(name: 'Pylint', pattern: '**/pylint.log')]
       )
     }
   }
   ```


[comment]: <> (### &#40;optional&#41; Run integration tests)

[comment]: <> (`curl -X POST -H "Content-Type: multipart/form-data" -F "file=@11.png" localhost:8081/api`)

### Run tests in parallel 

Use [`parallel`](https://www.jenkins.io/doc/book/pipeline/syntax/#parallel) directive to run the test stages in parallel, while failing the whole build when one of the stages is failed.



## Use Docker as Jenkins agent

Using Docker for build and test pipelines you can benefit from:

- Isolate build activity from each other and from Jenkins server
- Build for different environments
- Using ephemeral containers for better resource utilization

![](img/jenkinsagent.png)

Let's create a Docker container that will be used as a build agent for the `AppBuild` and `AppDeploy` pipelines.
Take a look on the following Dockerfile:

```dockerfile

FROM amazonlinux:2 as installer
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN yum update -y \
  && yum install -y unzip \
  && unzip awscliv2.zip \
  && ./aws/install --bin-dir /aws-cli-bin/

# this is an example demostrating how to install a tool on a some Docker image, then copy its artifacts to another image
RUN mkdir /snyk && cd /snyk \
    && curl https://static.snyk.io/cli/v1.666.0/snyk-linux -o snyk \
    && chmod +x ./snyk

FROM jenkins/agent
COPY --from=docker /usr/local/bin/docker /usr/local/bin/
COPY --from=installer /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=installer /aws-cli-bin/ /usr/local/bin/
COPY --from=installer /snyk/ /usr/local/bin/

```

This dockerfile uses [Multi-stage builds](https://docs.docker.com/build/building/multi-stage/). Familiarize yourself with this technique.
The dockerfile starts with [`amazonlinux:2`](https://hub.docker.com/_/amazonlinux) as an `installer` image in which we will install `aws` cli and [`snyk`](https://docs.snyk.io/snyk-cli). After this image is built, we will copy the relevant artifacts to the other main image: [jenkins/agent](https://hub.docker.com/r/jenkins/agent/).
The `jenkins/agent` is a base image suitable for running Jenkins activities.
In addition, we copy the `docker` **client only** (as we want to build images as part of our pipeline) from [`docekr`](https://hub.docker.com/_/docker), which is a Docker image containing `docker`. Feel confused? [read more...](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/).

1. Build the image from a machine with an access to ECR.
2. Push your image to a dedicated container registry in ECR.
3. In your Jenkinsifles, replace `agent any` by (read more on Jenkins [agent directive](https://www.jenkins.io/doc/book/pipeline/syntax/#agent)):
```text
agent {
    docker {
        image '<image-url>'
        args  '--user root -v /var/run/docker.sock:/var/run/docker.sock'
    }
}
```

The `-v` mount the socket file that the docker client is using to talk with the docker daemon. In this case the docker client within the container will talk with the docker daemon on Jenkins machine.  
The `--user root` runs the container as `root` user, which is necessary to access `/var/run/docker.sock`.

4. Test your pipeline on the Docker-based agent.

## Run agents on a separate EC2 instance node

Jenkins [EC2-plugin](https://plugins.jenkins.io/ec2/) allows Jenkins to start agents on EC2 on demand, and kill them as they get unused.
It'll start instances using the EC2 API and automatically connect them as Jenkins agents. When the load goes down, excess EC2 instances will be terminated.

1. Install the `Amazon EC2` Jenkins plugin.
2. Once installed, navigate to the main **Manage Jenkins** > **Nodes and Clouds** page, and choose **Configure Clouds**.
3. Add an **Amazon EC2** cloud configured as follows:
   1. Give it a **Name** as your choice.
   2. Keep **Amazon EC2 Credentials** `none`. Instead, you should check **Use EC2 instance profile to obtain credentials** give appropriate permissions to Jenkins` server Role (full permissions JSON can be found in the [plugin's page](https://plugins.jenkins.io/ec2/)).
   3. In **EC2 Key Pair's Private Key** choose your existed SSH key-pair credentials, or create one of you don't have yet.
   4. Under **AMIs** click **Add** and configure the AMI as the below steps.
   5. In **AMI ID**, search the ID of some `Amazon Linux` in the region you are operating from.
   6. For **Instance Type** choose an appropriate `*.micro` type.
   7. Choose an existed security group id for **Security group names**.
   8. Since the above AMI is based on Amazon Linux, **Remote user** is `ec2-user` and **AMI Type** in `unix`.
   9. Under **Labels** choose a label which will be used in your Jenkinsfile.
   10. Set the **Idle termination time** to `10` minutes.
   11. Init script is the shell script to be run on the newly launched EC2 instance, before Jenkins starts launching an agent. Fill the script yourself such that pipelines could be run successfully.  
   12. In the **Advanced** configurations, under **Subnet IDs for VPC** choose an existed subnet ID within your VPC.
   13. Set **Instance Cap** to `3` to restrict Jenkins from provisioning too many instances.
   14. Under **Host Key Verification Strategy** choose `off` since we trust Jenkins agents by default.
   15. Save you configurations
4. In order to instruct Jenkins to run the pipeline on the configured nodes, put a `label` property in the `agent{ docker {} }` setting, as follows:
```text
 agent {
        docker {
            label '<my-node-label>'
            image '...'
            args '...'
        }
 }
```
5. Test your pipeline.
