# Kubernetes core workloads and components

A **workload** is an application running on Kubernetes.
Whether your workload is a single component or several that work together, on Kubernetes you run it inside a set of **pods**.
In Kubernetes, a Pod represents a set of running **containers** on your cluster.

## Deployments

The Deployment workload in manages the lifecycle of a set of replicated Pods (same container image), ensuring the desired number of replicas are running and handling updates and rollbacks of the application.
Within a Deployment, there is a ReplicaSet that acts as the underlying mechanism for managing the desired number of replicas and container version. The ReplicaSet ensures that the specified number of Pods are running and handles scaling, rolling updates, and self-healing capabilities. 

**Deployment** is a good fit for managing a **stateless application** workload on your cluster, where any Pod in the Deployment is interchangeable and can be replaced if needed.

Follow:    
https://kubernetes.io/docs/tasks/run-application/run-stateless-application-deployment/

## Service

In Kubernetes, a Service is a method for exposing applications that is running as one or more Pods in your cluster.

### Define a service 

Applying this manifest creates a new Service named `mynginx`, which targets port 8080 on **any Pod** with the `app: nginx` label.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mynginx
spec:
  selector:
    app: nginx
  ports:
    - port: 8080
      targetPort: 80
```

The Service abstracts the Pods behind a single DNS name (simply `mynginx`) and an internal IP address. 

When performing an HTTP request to http://mynginx:8080 from within the cluster, the `mynginx` perform load balancing between the Pods that are part of the Service.
When the HTTP request is made, the Service's **load balancer** distributes the traffic across the available Pods based on the configured load balancing algorithm (usually round-robin by default).

Kubernetes also tries to distribute the Deployment's Pods across different nodes within the cluster to achieve **high availability**. 
The controller for that Service continuously scans for Pods that match its selector (a.k.a. **service discovery**),

Follow:   
https://kubernetes.io/docs/tasks/access-application-cluster/service-access-application-cluster/


## Use Port Forwarding to Access Applications in a Cluster

Follow:    
https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/


# Exercises 

## Try it yourself

Create a **Deployment** of 2 replicas for the [2048 game dockerized image](https://hub.docker.com/r/alexwhen/docker-2048).
Expose the Deployment with a **Service** listening on port 5858. Visit the app locally using `port-forward`.


### Further reading and doing

Node port different type of services 


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

