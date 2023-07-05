# Kubernetes 

[Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/#what-is-ingress) exposes HTTP and HTTPS routes from outside the cluster to services within the cluster.
An Ingress may be configured to give Services externally-reachable URLs, load balance traffic, terminate SSL / TLS, and offer name-based virtual hosting.
In order for the **Ingress** resource to work, the cluster must have an [**Ingress Controller**](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) running.

Kubernetes supports and maintains AWS, GCE, and [nginx](https://github.com/kubernetes/ingress-nginx) ingress controllers.

## Deploy the Nginx ingres controller

**Done only once per cluster**

We will deploy the [Nginx ingress controller behind a Network Load Balancer](https://kubernetes.github.io/ingress-nginx/deploy/#aws) manifest.

## Expose the 2048 game outside the cluster

1. If you haven't done it yet, deploy the [2048 game dockerized image](https://hub.docker.com/r/alexwhen/docker-2048) as a Deployment in the cluster.

Now we would like to access the 2048 game application from a domain such as http://my-2048.upes-int-devops.com

2. Add a subdomain **A record** for the upes-int-devops-23.com domain (e.g. my-2048.upes-int-devops.com). The record should have an alias to the NLB created by EKS after the ingress controller has been deployed.
3. Inspired by the manifests described in [Nginx ingress docs](https://kubernetes.github.io/ingress-nginx/user-guide/basic-usage/#basic-usage-host-based-routing), create and apply an Ingress resource such that when visiting your registered DNS, the 2048 game will be displayed on screen.

# Exercise 

### :pencil2: HTTPS 

Generate a self-signed certificate and private key with:

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${KEY_FILE} -out ${CERT_FILE} -subj "/CN=${HOST}/O=${HOST}" -addext "subjectAltName = DNS:${HOST}"
```

Then create the secret in the cluster via:

```bash
kubectl create secret tls ${CERT_NAME} --key ${KEY_FILE} --cert ${CERT_FILE}
```

The resulting secret will be of type `kubernetes.io/tls`.

Inspired by https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/service/networking/tls-example-ingress.yaml, define your ingress to accept HTTPS requests.

Force your incoming traffic to use HTTPS by adding the following annotation to the ingrass object:

```text
nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
```



