# Kubernetes

Kubernetes is shipped by [many different distributions](https://nubenetes.com/matrix-table/#), each aimed for a specific purpose.
Throughout this tutorial we will be working with Elastic Kubernetes Service (EKS), which is a Kubernetes cluster managed by AWS.  

## Elastic Kubernetes Service (EKS)

Follow the below docs to create a cluster using the management console:  
https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html

In order to get the kubeconfig content and connect to an EKS cluster, you should execute the following `aws` command from your local machine:

```shell
aws eks --region <region> update-kubeconfig --name <cluster_name>
```

Change `<region>` and `<cluster_name>` accordingly.

Read [here](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html) how to allow AWS IAM users and role access the cluster.


### Install and connect through OpenLens

https://github.com/MuhammedKalkan/OpenLens


## Install `kubectl`

1. Download the `kubectl` binary from [Kubernetes](https://kubernetes.io/docs/tasks/tools/#kubectl) official site.

(Windows users, put the `kubectl.exe` binary in a directory accessible in your PATH environment variable.)

# Kubernetes official tutorials

The Kubernetes documentation contains pages that show how to do individual tasks.
We will walk through core tasks. 

https://kubernetes.io/docs/tasks/

## Run a Stateless Application Using a Deployment

Follow:    
https://kubernetes.io/docs/tasks/run-application/run-stateless-application-deployment/

### Further reading and doing

#### Understanding [Kubernetes Objects](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/)

Almost every Kubernetes object includes a nested object that govern the object's configuration: the object `spec`.
The `spec` provides a description of the characteristics you want the resource to have: its **desired state**.

In the .yaml file for the Kubernetes object you want to create, you'll need to set values for the following fields:

- `apiVersion` - Which version of the Kubernetes API you're using to create this object.
- `kind` - What kind of object you want to create.
- `metadata` - Data that helps uniquely identify the object, including a name string, UID, and optional namespace.
- `spec` - What state you desire for the object.

**Labels** are key/value pairs that are attached to objects, such as Deployment.
Labels are intended to be used to specify identifying attributes of objects that are meaningful and relevant to users. E.g.:

- `"release" : "stable"`
- `"environment" : "dev"`
- `"tier" : "backend"`

Via a **Label Selector**, the client/user can identify a set of objects. 

## Use a Service to Access an Application in the Cluster

Follow:   
https://kubernetes.io/docs/tasks/access-application-cluster/service-access-application-cluster/

Notes: 

- Follow _Using a service configuration file_ section (use YAML file instead `kubectl expose` command).


## Use Port Forwarding to Access Applications in a Cluster

Follow:    
https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/

## Try it yourself

Create a **Deployment** of 2 replicas for the [2048 game dockerized image](https://hub.docker.com/r/alexwhen/docker-2048).
Expose the Deployment with a **Service** listening on port 5858. Visit the app locally using `port-forward`.

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


## HorizontalPodAutoscaler Walkthrough

Follow:  
https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/


## Distribute Credentials Securely Using Secrets

Follow:     
https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/


## ConfigMap

Follow (only "Define container environment variables with data from multiple ConfigMaps" section):   
https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#define-container-environment-variables-with-data-from-multiple-configmaps


Follow (only "Add ConfigMap data to a Volume" section):    
https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#add-configmap-data-to-a-volume


## ConfigMap and Secret - try it yourself

In this demo we will deploy MySQL server in Kubernetes cluster using Deployment.

All Yaml files are under `k8s/mysql-configmap-secret-demo`.


1. Create a Secret object containing the root username password for MySQL

`kubectl apply -f mysql-secret.yaml`

Now let's say we want to allow maximum of 50 connection to our DB. We would like to find a useful way to "inject" this config to our pre-built `mysql:5.7` image (we surely don't want to build the MySQL image ourselves).
For that, the [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) object can assist.
In the `mysql` Docker image, custom configurations for the MySQL server can be placed in `/etc/mysql/mysql.conf.d` directory, any file ends with `.cnf` under that directory, will be applied as an additional configurations to MySQL. But how can we "insert" a custom file to the image? keep reading...

2. Review the ConfigMap object under `mysql-config.yaml`. And apply it.
3. Complete the MySQL Deployment under `mysql-deployment.yaml`, such that `MYSQL_ROOT_PASSWORD` env var contains the secret value and ConfigMap is mounted into `/etc/mysql/mysql.conf.d`.
4. Make sure the new configurations applied.

