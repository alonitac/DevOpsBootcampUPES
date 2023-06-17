
## Distribute Credentials Securely Using Secrets

Follow:     
https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/


## ConfigMap

Follow (only "Define container environment variables with data from multiple ConfigMaps" section):   
https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#define-container-environment-variables-with-data-from-multiple-configmaps


Follow (only "Add ConfigMap data to a Volume" section):    
https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#add-configmap-data-to-a-volume


## ConfigMap and Secret - try it yourself

In this demo we will deploy MySQL server in Kubernetes cluster using Deployment.

All Yaml files are under `k8s/mysql-configmap-secret-demo`.


1. Create a Secret object containing the root username password for MySQL

`kubectl apply -f mysql-secret.yaml`

Now let's say we want to allow maximum of 50 connection to our DB. We would like to find a useful way to "inject" this config to our pre-built `mysql:5.7` image (we surely don't want to build the MySQL image ourselves).
For that, the [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) object can assist.
In the `mysql` Docker image, custom configurations for the MySQL server can be placed in `/etc/mysql/mysql.conf.d` directory, any file ends with `.cnf` under that directory, will be applied as an additional configurations to MySQL. But how can we "insert" a custom file to the image? keep reading...

2. Review the ConfigMap object under `mysql-config.yaml`. And apply it.
3. Complete the MySQL Deployment under `mysql-deployment.yaml`, such that `MYSQL_ROOT_PASSWORD` env var contains the secret value and ConfigMap is mounted into `/etc/mysql/mysql.conf.d`.
4. Make sure the new configurations applied.

