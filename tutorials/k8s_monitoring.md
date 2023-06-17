# Kubernetes 

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


