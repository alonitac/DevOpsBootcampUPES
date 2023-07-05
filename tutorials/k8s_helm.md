# Kubernetes 

## Helm

Helm is the package manager for Kubernetes.
The main big 3 concepts of helm are:

- A **Chart** is a Helm package. It contains all the resource definitions necessary to run an application, tool, or service inside of a Kubernetes cluster.
- A **Repository** is the place where charts can be collected and shared.
- A **Release** is an instance of a chart running in a Kubernetes cluster.

[Install](https://helm.sh/docs/intro/install/) the Helm cli if you don't have.

You can familiarize yourself by reading the main page in [Helm docs](https://helm.sh/docs/intro/using_helm/).

### Deploy Grafana using Helm

**Remove any existed grafana deployment, statefulset or service before you start.**

Once you have Helm installed and ready, you can add a chart repository. Check [Artifact Hub](https://artifacthub.io/packages/search?kind=0) for publicly available chart developed by the community.

Let's review and install the official Helm chart for Grafana: https://github.com/grafana/helm-charts/blob/main/charts/grafana/README.md

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

1. Install the Grafana chart by:

```bash
helm install --namespace <your-ns> grafana grafana/grafana 
```

Whenever you install a **chart**, a new **release** is created. So the same chart can be installed multiple times into the same cluster.
During installation, the helm client will print useful information about which resources were created, what the state of the release is, and also whether there are additional configuration steps you can or should take.
**Review this output**.

`port-forward` the grafana service and visit the app. 

You can always type `helm list` to see what has been released using Helm.

### Customize the Grafana release

Now we want to customize the releases app according to our configurations.
To see what options are configurable on a chart, use `helm show values grafana/grafana` or even better, go to the chart documentation on GitHub.

We will pass configuration data during the chart upgrade by specify a YAML file with overrides (`-f custom-values.yaml`).
This can be specified multiple times and the rightmost file will take precedence.

We want to change the chart's values as follows:

- Data is persistent, with disk of 5GB.
- The following env vars are configured:
  - `GF_DASHBOARDS_VERSIONS_TO_KEEP=10`
- Data sources configured as the [previous provisioned grafana](k8s_storage.md) (the cloudwatch datasource). 

Search and change the relevant values in the chart, put your changes in a file called `grafana-values.yaml`.

Upgrade your release by
```shell
helm upgrade -f grafana-values.yaml grafana grafana/grafana
```

An upgrade takes an existing release and upgrades it according to the information you provide. Because Kubernetes charts can be large and complex, Helm tries to perform the least invasive upgrade. 
It will only update things that have changed since the last release.

If something does not go as planned during a release, it is easy to roll back to a previous release using `helm rollback [RELEASE] [REVISION]`:

```shell
helm rollback grafana 1
```

To uninstall this release:
```shell
helm uninstall grafana
```

## Deploy prometheus using Helm

Let's review and deploy the Prometheus Helm chart (prometheus will be discussed later on). 

https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus

# Exercises 

### :pencil2: Add prometheus datasource as code

Update the `grafana-values.yaml` chart's values file such that the prometheus you've provisioned in the cluster will be added as a datasource in grafana. 

### :pencil2: Expose Grafana using ingress

Read the Grafana helm chart, serve the server behind your ingress:

https://github.com/grafana/helm-charts/tree/main/charts/grafana#how-to-serve-grafana-with-a-path-prefix-grafana
