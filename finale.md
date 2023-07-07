# Final Project 

## Project evaluation criteria 

Your projects would be evaluated according to the below list, in order of priority:

1. Showcasing a live, working demo of your work.
2. Applying DevOps practices - containerized applications, app deployed to k8s, CI/CD pipeline, IaC, usage of cloud resources.
3. Demonstrating deep understanding of your system.
4. Successful integration of a new tool, idea, or extension within the DevOps workflow (see ideas below). Be creative!
5. Project complexity. E.g. security measures, scalability, zero-downtime, cost-efficient architecture.

## Extension Ideas

### DevSecOps

Embed DevSecOps tool to the CI/CD pipeline:

- [safety](https://pyup.io/safety/) to scan vulnerabilities in Python packages.
- [Bandit](https://bandit.readthedocs.io/en/latest/) to find security issues in your Python code.
- [Pre-commit](https://pre-commit.com/) to enforce some policy before committing a new code.
- [Black](https://github.com/psf/black) as a linting tool.
- [Chef InSpec](https://docs.chef.io/inspec/) to apply security and compliance policies.


### Jenkins

- Implement load testing in the PR testing pipeline.
- Create a [Jenkins shared library](https://www.jenkins.io/blog/2017/02/15/declarative-notifications/#moving-notifications-to-shared-library).
- Send email notifications to users

### AWS

- Protect your service using [WAF](https://aws.amazon.com/waf/) or [Shield](https://aws.amazon.com/shield/).
- Any other shiny service that interesting you...

### K8S

- Deploy some interesting Helm Chart in the cluster (Jenkins, etc...).
- Write your app YAMLs as Helm Chart.
- Run some [CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) in the cluster.
- Use [ArgoCD](https://argo-cd.readthedocs.io/en/stable/) to deploy your app.
- Implement some interesting [ArgoWF](https://argoproj.github.io/argo-workflows/).
- Experimenting with [Calico](https://projectcalico.docs.tigera.io/about/about-calico) to implement network security in the cluster.
- Experimenting with [Istio](https://istio.io/) to implement a service mesh.
- Expose your app through a secured HTTPS.
- Implement Pod identity in EKS instead using the EC2 IAM role.

### Terraform

- Provision the app infrastructure as a code.
- Built a dedicated "IaaC" pipeline in Jenkins

### Ansible

- Use some [devsec.hardening Ansible](https://github.com/dev-sec/ansible-collection-hardening) collection to harden the system

### Monitoring

- Deploy [Prometheus](https://prometheus.io/) in K8S.
- Enable backup/restore to from [ElasticSearch to S3](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html).
- Build some Kibana dashboard
- Improve the logs stream from the k8s cluster to Elasticsearch
- Create some [alerts in Grafana](https://grafana.com/docs/grafana/latest/alerting/) (e.g. high CPU rate, container restarts many times etc...)

# DevOps Tools Bazaar

- [Argo CD](https://argoproj.github.io/argo-cd/)
- [Vault](https://www.vaultproject.io/docs)
- [Nexus](https://help.sonatype.com/repomanager3)
- [Argo Workflow](https://argoproj.github.io/argo/)
- [Logstash](https://www.elastic.co/guide/en/logstash/current/index.html)
- [Vagrant](https://www.vagrantup.com/docs)
- [Prometheus Alertmanager](https://prometheus.io/docs/alerting/alertmanager/)
- [Terraform with Azure](https://learn.hashicorp.com/collections/terraform/azure-get-started)
- [Helm](https://helm.sh/docs/)
- [KEDA](https://keda.sh/docs/)
- [Istio](https://istio.io/latest/docs/)
- [Calico](https://docs.projectcalico.org/)
- [Chef](https://docs.chef.io/)
- [SonarQube](https://docs.sonarqube.org/)
- [Snyk](https://docs.snyk.io/)
- [Karpenter](https://karpenter.sh/)