# Prometheus on K8S

[Prometheus](https://prometheus.io/docs/introduction/overview/) Prometheus is a monitoring platform that collects metrics from monitored targets by scraping metrics HTTP endpoints on these targets.
Prometheus is shipped with an extensive list of [exporters](https://prometheus.io/docs/instrumenting/exporters/). An exporter is a pluggable piece which allow Prometheus to collect metrics from other system (e.g. databases, cloud services, OS etc..). Some exporters are official, others developed by the community.

1. Deploy Prometheus using the [community Helm chart](https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus).
2. Deploy Grafana and visit the server.
3. In grafana, configure the Prometheus server as a data source.
4. Import one of the following dashboards:
    - https://grafana.com/grafana/dashboards/6417-kubernetes-cluster-prometheus/
    - https://grafana.com/grafana/dashboards/315-kubernetes-cluster-monitoring-via-prometheus/
    - https://grafana.com/grafana/dashboards/12740-kubernetes-monitoring/
