# Pod Design 

In this tutorial we will take a closer look on Pods design and characteristics. 

## Pod resource allocation 

Pod resources allocation in involves specifying the amount of CPU and memory resources required by the containers within the Pod. 
Proper resource allocation is critical in production systems! it allows an efficient resource utilization and ensures that containers have the necessary resources to run effectively and scale as needed within the cluster.

### Assign Memory Resources to Containers and Pods

In this exercise, you create a Pod that has one Container. The Container has a memory request of 50 MiB and a memory limit of 100 MiB. Here's the configuration file for the Pod:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: memory-demo
spec:
  containers:
  - name: memory-demo-ctr
    image: polinux/stress
    command: ["stress"]
    args: ["--vm", "1", "--vm-bytes", "150M", "--vm-hang", "1"]
    resources:
      requests:
        memory: "50Mi"
      limits:
        memory: "100Mi"
```

The `args` section in the configuration file provides arguments for the Container when it starts.
The `"--vm-bytes", "150M"` arguments tell the Container to attempt to allocate 150 MiB of memory.

Save the above manifest and apply by `kubectl apply -f memory-request-limit.yaml` 

View detailed information about the Pod:

```bash
kubectl get pod memory-demo --output=yaml
```

The output might show that the Container was killed because it is out of memory (OOM)

Now try to create a new pod while specifying a memory request that is too big for your Nodes... what happened?

### Assign CPU Resources to Containers and Pods

In this exercise, you create a Pod that has one container. The container has a request of 0.5 CPU and a limit of 1 CPU. Here is the configuration file for the Pod:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: cpu-demo
spec:
  containers:
  - name: cpu-demo-ctr
    image: vish/stress
    args:
    - -cpus
    - "2"
    resources:
      limits:
        cpu: "1"
      requests:
        cpu: "0.5"
```

Use `kubectl top` to fetch the metrics for the Pod:

```bash
kubectl top pod cpu-demo
```

## Configure Liveness, Readiness probes

Liveness and Readiness probes are essential mechanisms in k8s to ensure the availability and proper functioning of applications within Pods.

Liveness probes are used to determine the health of a Pod's containers, **restarting the Pod if the probe fails**.
They can perform periodic checks on the container's internal state, such as checking for a specific process or making HTTP requests to a designated endpoint.

Readiness probes, on the other hand, determine whether a Pod is ready to receive traffic.
They help control the traffic flow to a Pod by indicating when it is prepared to accept requests, preventing traffic from being sent to Pods that are not fully operational, mostly because the pod is still initializing, or is about to terminate as port of a rolling update.

### Define a liveness command

Take a look on the below manifest, try to think what is going to happen after the pod creation:

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    test: liveness
  name: liveness-exec
spec:
  containers:
  - name: liveness
    image: registry.k8s.io/busybox
    args:
    - /bin/sh
    - -c
    - touch /tmp/healthy; sleep 30; rm -f /tmp/healthy; sleep 600
    livenessProbe:
      exec:
        command:
        - cat
        - /tmp/healthy
      initialDelaySeconds: 5
      periodSeconds: 5
```

Apply the manifest and wait about 30 seconds, observe how k8s restarts the pod when it fails the liveness probes.

```bash
kubectl describe pod liveness-exec -w
```

### Define a liveness HTTP request

Another kind of liveness probe uses an HTTP GET request. Any code greater than or equal to 200 and less than 400 indicates success. Any other code indicates failure.
Here is the configuration file for a Pod that runs a container based on the `registry.k8s.io/liveness` image.

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    test: liveness
  name: liveness-http
spec:
  containers:
  - name: liveness
    image: registry.k8s.io/liveness
    args:
    - /server
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
        httpHeaders:
        - name: Custom-Header
          value: Awesome
      initialDelaySeconds: 3
      periodSeconds: 3
```

The liveness image is a Go server designed to fail after some time... you can see the source code for the server in [server.go](https://github.com/kubernetes/kubernetes/blob/master/test/images/agnhost/liveness/server.go).

Apply the above manifest in your cluster and observe pod.

### Define readiness probes

Sometimes, applications are unable to serve traffic.
For example, during rolling update, after the pod received SIGTERM from kubelet, it is good practice to stop serving request since the pod's containers are going to be killed soon. 
Sometimes the unavailability is temporary. An application might need to load large data or configuration files during startup, or depend on external services after startup. 
In such cases, you don't want to kill the application, but you don't want to send it requests either. 

Kubernetes provides readiness probes to detect and mitigate these situations. A pod with containers reporting that they are not ready does not receive traffic through Kubernetes Services.

Readiness probes are configured similarly to liveness probes. The only difference is that you use the `readinessProbe` field instead of the `livenessProbe` field.

```yaml
readinessProbe:
  exec:
    command:
    - cat
    - /tmp/healthy
  initialDelaySeconds: 5
  periodSeconds: 5
```

## HorizontalPodAutoscaler Walkthrough

Follow:  
https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/

# Exercise 

### :pencil2: The Zero-downtime Deployment challenge

Design the simple flask webserver (`simple_flask_webserver`) to support readiness probes, as follows:

1. In `app.py` create a boolean global variable which indicated whether the webserver is ready or not. 
2. Create a new endpoint called `/ready` which returns 200 in case the service is ready based on the variable you defined.
3. Inspired by the example under `graceful_term_simulate/server.py`, configure a handler for `signal.SIGTERM` (this signal will be sent by the [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/) to the pod during polling update). The `/ready` endpoint should return 500 after the container has received the `SIGTERM`. 
4. Specify a readiness probe based on the `/ready` endpoint.  
2. Containerize this app and push to a public ECR.
3. Deploy the app using k8s **Deployment**, and expose the app using **Service**.
4. Generate some load on your app by:

`kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.2; do (wget -q -O- http://<your-app-url-and-port>/status &); done"`

Replace `<your-app-url-and-port>` with your app URL.

5. During the load test, perform a rolling update to a new version of the app (new built Docker image). Change the Python code so it can be seen clearly when you are responded from the new app version. e.g. return `OK!!` instead of `OK` in the `/status` endpoint.

Your goal is to be able to perform a rolling update with zero-downtime (without losing any request).


[//]: # (## :pencil2: Init containers)

[//]: # ()
[//]: # ()
[//]: # (## :pencil2: Container lifecycle )

[//]: # ()

