# Deploy applications in AWS and Kubernetes

**Note**: Can be done in 2-3 groups!

**Never commit (and push) AWS credentials! No credentials file is needed to be placed in the repo directory.**

## Background


Your goal is to provision the object detection service as a scalable, micro-services architecture in AWS and Kubernetes.

Here is a high level diagram of the architecture:

![](img/botaws2.png)

## Scaling the app

In the service architecture presented in the previous project, where the `frontend` app directly sends HTTP requests with images to the `yolo5` container service, suffers from a lack of scalability due to the following reasons:

1. Synchronous Processing: In the current setup, the frontend app sends a request to the YOLO5 container service and waits for a response before proceeding. This approach can create bottlenecks when the number of requests increases. As the service receives more requests, it may take longer to process each one, leading to increased response times and potential timeouts. Additionally, if the YOLO5 container service becomes overwhelmed with requests, it may become unresponsive or crash.
1. Limited Concurrency: The frontend app directly communicates with the YOLO5 container service, which means that it can only process a limited number of requests concurrently. As the number of incoming requests grows, the service may reach its maximum capacity and start rejecting new requests, leading to poor user experience and potentially lost business opportunities.
1. Resource Utilization: With the current architecture, the YOLO5 container service must be provisioned to handle peak loads, even if the incoming request rate is much lower on average. This results in underutilization of resources during periods of lower demand, leading to increased costs and inefficiency.

By introducing an SQS (Simple Queue Service) queue between the frontend app and the YOLO5 container service, you can address the scalability challenges. Here's how:

1. Asynchronous Processing: With the SQS queue in place, the frontend app can enqueue the image requests into the queue and continue with other tasks without waiting for a response. This decouples the frontend app from the YOLO5 container service, allowing it to handle more incoming requests without blocking or slowing down the application. The frontend app can simply push the request into the queue and move on, which improves responsiveness and reduces the likelihood of timeouts.
1. Increased Concurrency: The SQS queue acts as a buffer, holding the image requests until they are processed by the YOLO5 container service. This enables parallel processing of requests, as multiple instances of the YOLO5 service can be launched to consume messages from the queue simultaneously. This increased concurrency allows for higher throughput and better utilization of available resources.
1. Elastic Scaling: With the introduction of the SQS queue, you can employ an auto-scaling mechanism for the YOLO5 container service. Based on the number of messages in the queue, you can dynamically scale the number of YOLO5 instances to match the incoming request rate. This ensures that you allocate resources based on the actual demand, optimizing cost-efficiency and avoiding underutilization during periods of low traffic.


When end-users send a message via Telegram app (1-black), the messages are being served by the Bot service (run as a Docker container in the Telegram Bot EC2 instance).
The Bot service **doesn't** download the video from YouTube itself, otherwise, all it does is sending a "job" to an SQS queue (2-black), and return the end-user a message like "your video is being downloaded...".
So, the Bot service is a very lightweight app that can serve hundreds requests per seconds. 
In the other side, there are Worker service (run as a Docker container in the Worker EC2 instance) **consumes** jobs from the SQS queue (3-black) and does the hard work - to download the video from YouTube and upload it to S3 (4-black). When the Worker done with current job, it asks the SQS queue if it has another job for him. As long as there are jobs pending in the queue, a free Worker will consume and perform the job. In such way the Bot service pushes jobs to the SQS queue, making it "full", while the Worker service consumes jobs from the queue, making it "empty".

But what if the rate in which the Bot service is pushing jobs to the queue is much higher than the rate the Worker completing jobs? In such case the queue will overflow...
To solve that, we will create multiple workers that together consume jobs from the queue. How many workers? we will deploy a dynamic model **that auto-scale the number of workers** depending on the number of messages in the queue. 
When there are a lot of jobs in the queue, the autoscaler will provision many workers. 
When there are only a few jobs in the queue, the autoscaler will provision fewer workers.
The Workers are part of an AutoScaling group, which is scaled in and out by a custom metric that the Metric Sender service (run as a Docker container as well, on the same VM as the Bot service) writes to CloudWatch every 1 minute (1-blue). CloudWatch will trigger an autoscale event (2-blue) when needed, which results in provisioning of another Worker instance, or terminate a redundant Worker instance (3-blue). 

The metric sent to CloudWatch can be called `BacklogPerInstance`, as it represents the number of jobs in the queue (jobs that was not consumed yet) per Worker instance.
For example, assuming you have 5 workers up and running, and 100 messages in the queue, thus `BacklogPerInstance` equals 20, since each Worker instance has to consume ~20 messages to get the queue empty. For more information, read [here](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-using-sqs-queue.html).

In the [TelegramAI](https://github.com/alonitac/TelegramAI) repo, review `microservices` branch. This branch contains the code for the above services, you don't need to bring your own code from the previous exercise.

## Guidelines

1. Create an SQS **standard** queue. Jobs that was not processed yet should reside in the queue for a maximum period of **4 days**. The worker has a maximum period of **1 minute** to process a single job.
2. Change the code in `frontend/app.py`, such that instead of communicating with the yolo5 service directly through an HTTP request (`requests.post(....)`), the service is uploading the image to S3, and sends a message to the SQS. 
3. Repeat step 2 for the `polybot` service. 
4. Change the code in 

It's good point to test your services locally. 

4. Deploy the `frontend` service as a k8s `Deployment` with 2 replicas. 
5. Deploy the `polybot` service as a k8s `Deployment` with 1 replicas. Store the telegram token as a `Secret`, and define a `volumeMount` and `volume` in the Deployment manifest to mount this secret as a `.telegramToken` file in the container's file system.
6. Deploy the `yolo5` service as a k8s `Deployment`, create an horizontal pod autoscaler (HPA) for this service, min replicas is 1, max is 10. 
7. Deploy a stateful mongoDB app using a vanilla `StatefulSet` (utilize the [Grafana manifest](https://github.com/alonitac/DevOpsBootcampUPES/blob/main/tutorials/k8s_storage.md#persist-grafana-data-using-statefulset) we've seen in class) or [Helm chart](https://artifacthub.io/packages/helm/bitnami/mongodb). 


### Test your app locally

9. After you've implemented the code changes, it is good idea to test everything locally. Run the `bot/app.py` service and a single worker `worker/app.py`. Make sure that when you send a message via Telegram, the Bot service produces a message to the SQS queue, and the Worker consumes the message, downloads the YouTube video and uploads it to S3.

### Deploy the app in AWS 

10. As mentioned above, all services are running as a Docker containers. Complete the Dockerfile of each service (except `lambda.Dockerfile` which is already implemented).
12. Deploy the Worker service to an EC2 instance
    1. Create an Amazon Linux EC2 instance.
    2. Install Docker.
    3. Get your repo code there (install Git if needed).
    4. Build the Worker image by (note that the build command should be run from the root directory of the repo, also note the `-f` option which helps when the `Dockefile` is located in a different dir than the build context):
       ```shell
       docker build -t worker:1.0 -f worker/Dockerfile . 
       ```
    5. Run the container such that it starts automatically when the EC2 is launches:
       ```shell
       docker run -d --name worker --restart always worker:1.0  
       ```
    6. Create an AMI from that instance and base your Launch Template on that AMI, such that when a new instance is created from the launch template, the Worker app will be up and running automatically.

11. Deploy the Bot and the Metric-sender services **on a single EC2 instance** (those services are not part of the autoscaling group). It should be similar to Worker deployment - each service in a separate Docker container that restarts automatically on OS reboot.

13. Use AWS cli to create a [target tracking scaling policy](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-using-sqs-queue.html#create-sqs-policies-cli) in your Autoscaling Group. `MetricName` and `Namespace` should correspond to the metric your Bot service is firing to CloudWatch. Give the `TargetValue` some value that you can test later (e.g. 10, which means if there are more than 10 messages per worker in the SQS queue, a scale up event will trigger).

14. Make sure your services are given the right IAM role permissions.

15. Test your application and make sure the autoscalig group react under load increase/decrease.


## Submission

# Good Luck
