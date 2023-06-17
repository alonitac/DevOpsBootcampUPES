# CI/CD with Jenkins

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
