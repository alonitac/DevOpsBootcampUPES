# Kubernetes 

### Install Ingress and Ingress Controller on EKS

[Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/#what-is-ingress) exposes HTTP and HTTPS routes from outside the cluster to services within the cluster.
An Ingress may be configured to give Services externally-reachable URLs, load balance traffic, terminate SSL / TLS, and offer name-based virtual hosting.
In order for the **Ingress** resource to work, the cluster must have an [**Ingress Controller**](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) running.

Kubernetes supports and maintains AWS, GCE, and [nginx](https://github.com/kubernetes/ingress-nginx) ingress controllers.

1. If working on a shared repo, create your own namespace by:
   ```shell
   kubectl create ns <my-ns-name>
   ```
2. **In your namespace**, Deploy the following Docker image as a Deployment, with correspond Service: [`alexwhen/docker-2048`](https://hub.docker.com/r/alexwhen/docker-2048).
3. Deploy the Nginx ingres controller (done only **once per cluster**). We will deploy the [Nginx ingress controller behind a Network Load Balancer](https://kubernetes.github.io/ingress-nginx/deploy/#aws) manifest.

We want to access the 2048 game application from a domain such as http://test-2048.int-devops-may22.com

4. Add a subdomain A record for the [int-devops-may22.com](https://us-east-1.console.aws.amazon.com/route53/v2/hostedzones#ListRecordSets/Z04765852WWE8ZAF7TX92) domain (e.g. test-2048.int-devops-may22.com). The record should have an alias to the NLB created by EKS after the ingress controller has been deployed.
5. Inspired by the manifests described in [Nginx ingress docs](https://kubernetes.github.io/ingress-nginx/user-guide/basic-usage/#basic-usage-host-based-routing), create and apply an Ingress resource such that when visiting your registered DNS, the 2048 game will be displayed on screen.

[Read this resource](https://aws.amazon.com/blogs/opensource/network-load-balancer-nginx-ingress-controller-eks/) to enable HTTPS communication with the above provisioned service. 


## Helm

Helm is the package manager for Kubernetes.
The main big 3 concepts of helm are:

- A **Chart** is a Helm package. It contains all the resource definitions necessary to run an application, tool, or service inside of a Kubernetes cluster.
- A **Repository** is the place where charts can be collected and shared.
- A **Release** is an instance of a chart running in a Kubernetes cluster.

[Install](https://helm.sh/docs/intro/install/) the Helm cli if you don't have.

You can familiarize yourself with this tool using [Helm docs](https://helm.sh/docs/intro/using_helm/).

### Deploy MySQL using Helm

Once you have Helm ready, you can add a chart repository. Check [Artifact Hub](https://artifacthub.io/packages/search?kind=0) for publicly available chart developed by the community.

Let's review the Helm chart written by Bitnami for MySQL provisioning in k8s cluster.

[https://github.com/bitnami/charts/tree/master/bitnami/mysql/#installing-the-chart](https://github.com/bitnami/charts/tree/master/bitnami/mysql/#installing-the-chart)

1. Add the Bitnami Helm repo to your local machine:
```shell
# or update if you have it already: `helm repo update bitnami`
helm repo add bitnami https://charts.bitnami.com/bitnami
```
2. First let's install the chart without any changes
```shell
# helm install <release-name> <repo-name>/<chart-name> 
helm install mysql bitnami/mysql
```

Whenever you install a **chart**, a new **release** is created. So the same chart can be installed multiple times into the same cluster.
During installation, the helm client will print useful information about which resources were created, what the state of the release is, and also whether there are additional configuration steps you can or should take.

You can always type `helm list` to see what has been released using Helm.

Now we want to customize the chart according to our business configurations.
To see what options are configurable on a chart, use `helm show values bitnami/mysql` or even better, go to the chart documentation on GitHub.

We will pass configuration data during the chart upgrade by specify a YAML file with overrides (`-f custom-values.yaml`).
This can be specified multiple times and the rightmost file will take precedence.

We want to change the chart's values such that the below architecture will be deployed in out cluster (Multi-AZ DB MySql cluster):

![](img/mysql-multi-instance.png)

3. Create a file called `mysql_values.yaml`, and override the chart's values or [add parameters](https://github.com/bitnami/charts/tree/master/bitnami/mysql/#parameters) according to your need.
4. Upgrade the `mysql` chart by
```shell
helm upgrade -f mysql-helm/values.yaml mysql bitnami/mysql
```

An upgrade takes an existing release and upgrades it according to the information you provide. Because Kubernetes charts can be large and complex, Helm tries to perform the least invasive upgrade. 
It will only update things that have changed since the last release.

If something does not go as planned during a release, it is easy to roll back to a previous release using `helm rollback [RELEASE] [REVISION]`:

```shell
helm rollback mysql 1
```

5. To uninstall this release:
```shell
helm uninstall mysql
```

## Stream Pod logs to CloudWatch using FluentD

### Fluentd introduced

[Fluentd](https://www.fluentd.org/) is an open source data collector for unified logging layer.
Fluent allows you to unify data collection and consumption for a better use and understanding of data.

Here is an illustration of how Fluent works in the k8s cluster:

![](img/fluent.png)

Fluentd runs in the cluster as a [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/). A DaemonSet ensures that all **nodes** run a copy of a **pod**. That way, Fluentd can collect log information from every containerized applications easily in each k8s node.

We will deploy the Fluentd chart to collect containers logs to send them to [CloudWatch](https://www.elastic.co/what-is/elasticsearch) database.

1. Visit the Fluentd Helm chart at https://github.com/fluent/helm-charts/tree/main/charts/fluentd
2. Install the chart in **your k0s cluster**.
3. Watch and inspect the running containers under **Workloads** -> **DaemonSet**. Obviously, it doesn't work, as Fluent needs to talk with CloudWatch.
4. Review the CloudWatch plugin in https://github.com/fluent-plugins-nursery/fluent-plugin-cloudwatch-logs.
5. Create a YAML file called `fluentd-values.yaml`. You should override the [following](https://github.com/fluent/helm-charts/blob/main/charts/fluentd/values.yaml#L379) default Helm values, by:
```yaml
fileConfigs:
  04_outputs.conf: |-
    <label @OUTPUT>
      <match **>
        @type cloudwatch_logs
        log_group_name <log-group-name>
        log_stream_name <log-stream-name>
        auto_create_stream true
      </match>
    </label>
```
While replacing `<log-group-name>` and `<log-stream-name>`.

In addition, search the Helm value that entitled to install fluentD plugins, add the `fluent-plugin-cloudwatch-logs` plugin.

7. Finally, upgrade the `fluentd` release with your custom values YAML file.
8. Observe the logs in CloudWatch.

### Visualize logs with Grafana

1. In your k0s cluster, deploy [Grafana](https://github.com/grafana/helm-charts).
2. Visit grafana service (either by port forward or ingress), integrate the CloudWatch data source, display cluster logs.

### Fluentd permissions in the cluster

Have you wondered how does the Fluentd pods have access to other pods logs!?

This is a great point to learn something about k8s role and access control mechanism ([RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)).

#### Role and ClusterRole

_Role_ or _ClusterRole_ contains rules that represent a set of permissions on the cluster (e.g. This Pod can do that action..).
A Role always sets permissions within a particular _namespace_
ClusterRole, by contrast, is a non-namespaced resource.

#### Service account

A _Service Account_ provides an identity for processes that run in a Pod.
When you create a pod, if you do not specify a service account, it is automatically assigned the `default` service account in the same namespace.

#### RoleBinding and ClusterRoleBinding

A role binding grants the permissions defined in a role to a user or set of users.
A RoleBinding may reference any Role in the same namespace. Alternatively, a RoleBinding can reference a ClusterRole and bind that ClusterRole to the namespace of the RoleBinding.

---

Observe the service account used by the fluentd Pods, observe their ClusterRole bound to them.

## Elasticsearch on K8S

Familiarize yourself with the ELK stack:

https://www.elastic.co/what-is/elk-stack

**Note:** this chart should be released once per k8s cluster (the same Elastic will be shared by all students).

https://bitnami.com/stack/elasticsearch/helm

Deploy the Elastic chart. The following configurations should be applied:

- `coordinating.replicaCount: 0`
- `ingest.enabled: false`
- Enable Kibana
- Enable ingress (use the installed nginx controller)

## Kibana setup

Visit Kibana by port-forwarding the service:

```shell
kubectl port-forward svc/<kibana-service> 5601:5601
```

Then go to `https://localhost:5601`.

### Send logs to Elastic

Update your fluentd chart to send logs to the elastic instance you've just deployed.


## StatefulSet

Follow:  
https://kubernetes.io/docs/tutorials/stateful-application/basic-stateful-set/



