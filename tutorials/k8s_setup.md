# Kubernetes

Kubernetes is shipped by [many different distributions](https://nubenetes.com/matrix-table/#), each aimed for a specific purpose.
Throughout this tutorial we will be working with Elastic Kubernetes Service (EKS), which is a Kubernetes cluster managed by AWS.  

## Install `kubectl`

kubectl is a command-line tool used to interact with Kubernetes clusters.

Download the `kubectl` binary from [Kubernetes](https://kubernetes.io/docs/tasks/tools/#kubectl) official site.

## Elastic Kubernetes Service (EKS)

**Note**: This part is aimed to let you feel how a kubernetes cluster can be easily provisioned using EKS, but **you should delete your EKS clusters after creation**. 
Throughout the bootcamp we will share a single cluster for each group.

Follow the below docs to create a cluster using the management console:  
https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html

Upon successful creation, you should authenticate yourself to be able to interact with the cluster.

The `kubeconfig` file is a configuration file used by kubectl to authenticate and communicate with the Kubernetes cluster, containing cluster information, authentication details, and context settings to connect to the desired cluster. 
Get it by:

```shell
aws eks --region <region> update-kubeconfig --name <cluster_name>
```

Change `<region>` and `<cluster_name>` accordingly.

## Install and connect through OpenLens

OpenLens is a recommended open-source Kubernetes dashboard, get it from:

https://github.com/MuhammedKalkan/OpenLens

## Authenticating to our shared repo:

Throughout the bootcamp each group work on a shared k8s cluster, as detailed below:

- **Batch 1**: `k8s-batch1` located in Ohio (`us-east-2`).
- **Batch 2**: `group2-eks` located in Ireland (`eu-west-1`).
- **Batch 3**: `k8s-batch3` located in Oregon (`us-west-2`).

Authenticate yourself by the below command:

```shell
aws eks --region <region> update-kubeconfig --name <cluster_name>
```

In order to shared the cluster peacefully, each one of you can work on different k8s namespace. 

**Kubernetes namespaces** provide a way to logically partition and isolate resources within a cluster, allowing for better organization, access control, and resource management.
Create your own namespace in k8s:

```bash
kubectl create ns <your-ns-alias>
```

Set `kubectl` to work by default against your namespace:

```bash
kubectl config set-context --current --namespace=<your-ns-alias>
```
