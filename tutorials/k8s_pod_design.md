
## HorizontalPodAutoscaler Walkthrough

Follow:  
https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/


## Assign Memory Resources to Containers and Pods

Follow:    
https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/


## Assign CPU Resources to Containers and Pods

Follow:    
https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/


## Configure Liveness, Readiness and Startup Probes

Follow:     
https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/

> The following sections can be skipped:  
> - Define a TCP liveness probe
> - Define a gRPC liveness probe
> - Use a named port
> - Protect slow starting containers with startup probes


## The Zero-downtime Deployment challenge

Under `13_zero_downtime_flask_k8s` you will find a simple Flask webserver, designed to support live- and readiness probes.

1. Make sure you understand the logic and the `/ready` endpoint
2. Containerize this app and push to a public ECR.
3. Deploy the app using k8s **Deployment**, and expose the app using **Service**. In the meantime, **don't** add any probes or resources allocation for the container.
4. Generate some load on your app by:

`kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.2; do (wget -q -O- http://<your-app-url-and-port> &); done"`

Replace `<your-app-url-and-port>` with your app URL.

5. During the load test, perform a rolling update to a new version of the app (new built Docker image). Change the Python code so it can be seen clearly when you are responded from the new app version. e.g. return `Hello world 2` instead of `Hello world`.
6. Observe how during rolling update, some requests are failing.
7. Use the `/ready` endpoint and add a `readinessProbe`, you can also use the `/` endpoint to configure `livenessProbe`. Make sure you gain **zero-downtime rolling update**, which means, all user requests are being served, even during an update.
