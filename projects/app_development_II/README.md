# Deploy applications in AWS and Kubernetes

**Note**: Can be done in 2-3 groups!

**Never commit (and push) AWS credentials! No credentials file is needed to be placed in the repo directory.**

## Background

Your goal is to provision the object detection service as a scalable, micro-services architecture in AWS and Kubernetes.

## Guidelines

1. Deploy the `frontend`, `yolo5` and `polybot` services as `Deployment`s. Don't forget to configure [resources allocation]()(don't give more than `1000mi` CPU for request and limit) and [probes]()(you may write some python code to handle probes).
2. The `yolo5` Deployment should have a horizontal pod autoscaler (HPA), min replicas is 1, max is 5. The average CPU utilization is `500mi`.
3. Store the telegram token as a `Secret`, and define a `volumeMount` and `volume` in the Deployment manifest to mount this secret as a `.telegramToken` file in the container's file system.
4. Deploy a stateful mongoDB app using a vanilla `StatefulSet` (utilize the [Grafana manifest](https://github.com/alonitac/DevOpsBootcampUPES/blob/main/tutorials/k8s_storage.md#persist-grafana-data-using-statefulset) we've seen in class) or [Helm chart](https://artifacthub.io/packages/helm/bitnami/mongodb). 
5. Expose the `frontend` add using an Ingress. 

## Test the app 

Make sure you are able to communicate with the service using both the Web UI or the Telegram bot.

Test your app under scale, make sure the yolo5 service is scaling up and down properly. 

```bash
pip install locust
cd projects/app_development_II
locust
```

Open http://localhost:8089. Provide the host name of your server and try it out!

# Good Luck
