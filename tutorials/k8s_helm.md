# Kubernetes 

## Helm

Helm is the package manager for Kubernetes.
The main big 3 concepts of helm are:

- A **Chart** is a Helm package. It contains all the resource definitions necessary to run an application, tool, or service inside of a Kubernetes cluster.
- A **Repository** is the place where charts can be collected and shared.
- A **Release** is an instance of a chart running in a Kubernetes cluster.

[Install](https://helm.sh/docs/intro/install/) the Helm cli if you don't have.

You can familiarize yourself with this tool using [Helm docs](https://helm.sh/docs/intro/using_helm/).

### Deploy Grafana using Helm

**Note**: remove all grafana resources before continuing 

Once you have Helm installed and ready, you can add a chart repository. Check [Artifact Hub](https://artifacthub.io/packages/search?kind=0) for publicly available chart developed by the community.

Let's review and install the official Helm chart for Grafana: https://github.com/grafana/helm-charts/blob/main/charts/grafana/README.md

Whenever you install a **chart**, a new **release** is created. So the same chart can be installed multiple times into the same cluster.
During installation, the helm client will print useful information about which resources were created, what the state of the release is, and also whether there are additional configuration steps you can or should take.

You can always type `helm list` to see what has been released using Helm.

Now we want to customize the chart according to our business configurations.
To see what options are configurable on a chart, use `helm show values grafana/grafana` or even better, go to the chart documentation on GitHub.

We will pass configuration data during the chart upgrade by specify a YAML file with overrides (`-f custom-values.yaml`).
This can be specified multiple times and the rightmost file will take precedence.

We want to change the chart's values such that the below architecture will be deployed in out cluster (Multi-AZ DB MySql cluster):

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

1. Install the Grafana chart by:

```bash
helm install grafana grafana/grafana
```

2. Create a file called `grafana-values.yaml`, and override the chart's default values:

```yaml
persistence:
  enabled: true
  storageClassName: gp3
```

3. Upgrade your release by
```shell
helm upgrade -f mysql-helm/values.yaml grafana grafana/grafana
```

An upgrade takes an existing release and upgrades it according to the information you provide. Because Kubernetes charts can be large and complex, Helm tries to perform the least invasive upgrade. 
It will only update things that have changed since the last release.

If something does not go as planned during a release, it is easy to roll back to a previous release using `helm rollback [RELEASE] [REVISION]`:

```shell
helm rollback grafana 1
```

5. To uninstall this release:
```shell
helm uninstall grafana
```

Try to search and update the chart values to achieve the same results as the grafana you've provisioned in the previous tutorial. 

# Exercises 


