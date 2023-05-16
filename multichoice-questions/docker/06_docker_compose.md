# Docker - compose - multichoice questions

Consider the below YAML:

```yaml
hosts: 
  - google.com
  - apple.com
  - amazon.com  
spec:
  image: busybox
volume: gp2
nothing:
```

## Question

What is the data type of each key?

1. `hosts` is null, `spec` is a list, `volume` is string, `nothing` isn't valid syntax.
2. `hosts` is a list, `spec` is a dictionary, `volume` is string, `nothing` is null.
3. `hosts` is a list, `spec` isn't valid syntax, `volume` is string, `nothing` isn't valid syntax.
4. `hosts` isn't a valid syntax, `spec` is a dictionary, `volume` isn't valid syntax, `nothing` is null.

## Question 

Which of the following option(s) is equivalent to `volume: gp2`?

1. `volume: gp2`
2. `volume: 'gp2'`
3. ```yaml
   volume:
      - "gp2"
   ```
4. `volume: "gp2"`


Given the below `docker-compose.yaml` file:

```yaml
version: "3.9"
services:
  app:
    image: "ubuntu"
  redis:
    image: "redis:alpine"
    expose:
      - 6379
```

Answer the below 2 questions.

## Question

What is the network used when deploy the two specified services? 

1. The default docker `bridge` network.
2. Compose automatically creates custom network for this project. 
3. Networking is disabled in this compose project.
4. None of the above.

## Question 

How can the `app` service access the `redis` service? 

1. We need `redis`'s IP address.
2. By `redis:6379`.
3. By `services.redis:6379`
4. The `redis` service is not accessible from the `app` service. 

