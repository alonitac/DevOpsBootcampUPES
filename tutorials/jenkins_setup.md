# CI/CD with Jenkins

## Install Jenkins Server on EC2

Jenkins is typically run as a standalone application in its own process with the built-in Java servlet container/application.

1. Create a ***.small, Ubuntu** EC2 instance with `20GB` disk.
2. Connect to your instance, download and install Jenkins as described [here](https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/#downloading-and-installing-jenkins) (no need to install the EC2 plugin).
3. On Jenkins machine, [install Docker engine](https://docs.docker.com/engine/install/ubuntu/). You may want to add jenkins linux user the docker group, so Jenkins could run docker commands:
   ```shell
   sudo usermod -a -G docker jenkins
   ```
4. Install Git if you don't have.
5. You'll need your Jenkins server to have static public ip address. From the EC2 navigation pane, create an **Elastic IP** and associate it to your Jenkins instance.
6. Open port `8080` and visit your Jenkins server via `http://<static-ip>:8080` and complete the setup steps.
7. In the **Dashboard** page, choose **Manage Jenkins**, then **Manage Plugins**. In the **Available** tab, search and install **Blue Ocean** and **Docker Pipeline** plugins. Then restart jenkins by `http://<ip>:8080/safeRestart`

## Create a GitHub repository with a `Jenkinsfile` in it

A **Jenkins pipeline** is a set of automated steps defined in a `Jenkinsfile` (usually as part of the code repository, a.k.a. **as Code**) that tells Jenkins what to do in each step of your CI/CD pipeline. 

The `Jenkinsfile`, written in Groovy, has a specific syntax and structure, and it is executed within the Jenkins server.
The pipeline typically consists of multiple **stages**, each of which performs a specific **steps**, such as building the code as a Docker image, running tests, or deploying the software to Kubernetes cluster.

1. Use your docker project GitHub repo, or create a new GitHub repository for which you want to integrate Jenkins.
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
