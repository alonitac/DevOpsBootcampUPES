# Kubernetes storage objects and volumes

## Distribute credentials securely using secrets

Kubernetes **Secrets** are a way to securely store and manage sensitive information such as passwords, API keys, or certificates in the cluster. 
Secrets are encoded as `base64` strings and can be **mounted as files** or exposed **as environment variables** within Pods, ensuring secure handling of sensitive data without exposing them directly in the application's configuration files or Docker images.

Suppose you want to have two pieces of secret data: a username `john` and a password `39528$vdg7Jb`.
First, use a base64 encoding tool to convert your username and password to a base64 representation.

```bash
echo -n 'john' | base64
echo -n '39528$vdg7Jb' | base64
```

Here is a configuration file you can use to create a Secret that holds your username and password:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: grafana-creds
data:
  username: am9obg==
  password: Mzk1MjgkdmRnN0pi
```

To create the secret, you can apply this yaml in the cluster. 
Alternatively, you can create the same Secret using the kubectl create secret command (and skip the Base64 encoding step):

```bash
kubectl create secret generic test-secret --from-literal='username=john' --from-literal='password=39528$vdg7Jb'
```

You can consume the data in Secrets as environment variables in your containers.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana
spec:
  selector:
    matchLabels:
      app: grafana
  replicas: 1
  template:
    metadata:
      labels:
        app: grafana
    spec:
      containers:
      - name: grafana
        image: grafana/grafana
        ports:
        - containerPort: 3000
        env:
          - name: GF_AUTH_BASIC_ENABLED
            value: "true"
          - name: GF_SECURITY_ADMIN_USER
            valueFrom:
              secretKeyRef:
                name: grafana-creds
                key: username
          - name: GF_SECURITY_ADMIN_PASSWORD
            valueFrom:
              secretKeyRef:
                name: grafana-creds
                key: password
---
apiVersion: v1
kind: Service
metadata:
  name: grafana
spec:
  selector:
    app: grafana
  ports:
    - port: 3000
      targetPort: 3000
```

## ConfigMap

ConfigMaps are a mechanism for storing non-sensitive configuration data in key-value pairs, which can be used as environment variables or mounted as files within Pods. 
ConfigMaps provide a convenient way to manage and **inject configuration settings into applications**, allowing for easy configuration changes without modifying the application's container image or restarting the Pod.

In the below example, you create a configmap that will be injected as a file to the grafana container,
in a directory that grafana uses to define data sources.

This approach is known as Infrastructure as Code (IaC) and will be taught later on in the course. 
Defining a grafana datasource as YAML instead of through the UI allows for version control, easy reproducibility, and automation, enabling efficient management and deployment of consistent datasource configurations across multiple Grafana instances or environments.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: grafana-datasources
data:
  datasources.yaml: |-
    apiVersion: 1
    datasources:
      - name: CloudWatch
        type: cloudwatch
        jsonData:
          authType: default
          defaultRegion: <your-region-code>

```

Change `<your-region-code>` to your region code in AWS. Apply.

Let's see how to use the applied configmap in the grafana deployment:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana
spec:
  selector:
    matchLabels:
      app: grafana
  replicas: 1
  template:
    metadata:
      labels:
        app: grafana
    spec:
      containers:
      - name: grafana
        image: grafana/grafana
        ports:
        - containerPort: 80
        env:
          - name: GF_AUTH_BASIC_ENABLED
            value: "true"
          - name: GF_SECURITY_ADMIN_USER
            valueFrom:
              secretKeyRef:
                name: grafana-creds
                key: username
          - name: GF_SECURITY_ADMIN_PASSWORD
            valueFrom:
              secretKeyRef:
                name: grafana-creds
                key: password
        volumeMounts:
        # name must match the volume name below
        - name: grafana-datasources-vol
          mountPath: "/etc/grafana/provisioning/datasources"
      # The secret data is exposed to Containers in the Pod through a Volume.
      volumes:
        - name: grafana-datasources-vol
          configMap:
            name: grafana-datasources
```

Visit grafana (`port-forward` it locally), explore the CloudWatch datasource, permissions error? Give your node's role read permissions over cloudwatch!  

## Persist Grafana data using StatefulSet

When deploying Grafana using a Deployment (as we did above), the problem of non-persistent data arises, as each Pod in the Deployment has its own ephemeral storage, resulting in data loss if the Pod restarts or scales down, requiring additional measures such as using a persistent volume or external storage to ensure data persistence.

**StatefulSets** are intended to be used with **stateful applications**.
The administration of stateful applications and distributed systems on Kubernetes is a broad and complex topic. 
In this course we will only see the canonic example of persisting volume in k8s using statefulSet, without digging into details :-(

Before we start, we need to enable the EBS CSI plugin in EKS, allowing the cluster to create EBS for individual pods (should be done only once per cluster).

1. In your EKS cluster main page, choose the **Add-ons** tab.
2. Choose **Add new**.
3. Select Amazon EBS CSI Driver for Name.
4. Add your cluster node role the `AmazonEBSCSIDriverPolicy` permission.

Before you apply the below manifest, delete your `grafana` deployment by:

```bash
kubectl delete deployment grafana
```

The below example **will create an EBS volume in AWS** which dedicated to store Grafana data for a single pod.

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: grafana
spec:
  replicas: 1
  serviceName: grafana-svc
  selector:
    matchLabels:
      app: grafana
  template:
    metadata:
      name: grafana
      labels:
        app: grafana
    spec:
      securityContext:
        runAsUser: 472
        runAsGroup: 8020
        fsGroup: 8020
      containers:
      - name: grafana
        image: grafana/grafana
        ports:
        - name: grafana
          containerPort: 3000
        env:
          - name: GF_AUTH_BASIC_ENABLED
            value: "true"
          - name: GF_SECURITY_ADMIN_USER
            valueFrom:
              secretKeyRef:
                name: grafana-creds
                key: username
          - name: GF_SECURITY_ADMIN_PASSWORD
            valueFrom:
              secretKeyRef:
                name: grafana-creds
                key: password
        volumeMounts:
          - name: grafana-datasources-vol
            mountPath: "/etc/grafana/provisioning/datasources"
          - name: grafana-storage
            mountPath: "/var/lib/grafana"
      volumes:
        - name: grafana-datasources-vol
          configMap:
            name: grafana-datasources
  volumeClaimTemplates:
    - metadata:
        name: grafana-storage
      spec:
        accessModes: [ "ReadWriteOnce" ]
        storageClassName: gp2
        resources:
          requests:
            storage: 5Gi
```

Make sure the statefulset was created successfully, and the pod is up and running.  

# Exercise

### :pencil2: The StatefulSet task in the official k8s docs

https://kubernetes.io/docs/tutorials/stateful-application/basic-stateful-set/


### :pencil2: Communicate between containers in the same pod using a shared volume

https://kubernetes.io/docs/tasks/access-application-cluster/communicate-containers-same-pod-shared-volume/

### :pencil2: No space left on disk - increase the mounter EBS

You notice a "No space left on disk" error in the Grafana statefulset pod logs.
Increase the size of the mounted EBS volume in the Grafana statefulset to resolve the issue and provide additional storage capacity.
**You should achieve the change without causing downtime or deleting the resource**.