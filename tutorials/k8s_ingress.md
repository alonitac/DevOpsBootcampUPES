# Kubernetes 

### Install Ingress and Ingress Controller on EKS

[Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/#what-is-ingress) exposes HTTP and HTTPS routes from outside the cluster to services within the cluster.
An Ingress may be configured to give Services externally-reachable URLs, load balance traffic, terminate SSL / TLS, and offer name-based virtual hosting.
In order for the **Ingress** resource to work, the cluster must have an [**Ingress Controller**](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) running.

Kubernetes supports and maintains AWS, GCE, and [nginx](https://github.com/kubernetes/ingress-nginx) ingress controllers.

1. Deploy the following Docker image as a Deployment, with correspond Service: [`alexwhen/docker-2048`](https://hub.docker.com/r/alexwhen/docker-2048).
3. Deploy the Nginx ingres controller (done only **once per cluster**). We will deploy the [Nginx ingress controller behind a Network Load Balancer](https://kubernetes.github.io/ingress-nginx/deploy/#aws) manifest.

We want to access the 2048 game application from a domain such as http://test-2048.int-devops-may22.com

4. Add a subdomain A record for the [int-devops-may22.com](https://us-east-1.console.aws.amazon.com/route53/v2/hostedzones#ListRecordSets/Z04765852WWE8ZAF7TX92) domain (e.g. test-2048.int-devops-may22.com). The record should have an alias to the NLB created by EKS after the ingress controller has been deployed.
5. Inspired by the manifests described in [Nginx ingress docs](https://kubernetes.github.io/ingress-nginx/user-guide/basic-usage/#basic-usage-host-based-routing), create and apply an Ingress resource such that when visiting your registered DNS, the 2048 game will be displayed on screen.

[Read this resource](https://aws.amazon.com/blogs/opensource/network-load-balancer-nginx-ingress-controller-eks/) to enable HTTPS communication with the above provisioned service. 

