# Docker - Compose - multichoice questions

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

## Question 1

What is the network used when deploy the two specified services? 

- [ ] The default docker `bridge` network.
- [ ] Compose automatically creates custom network for this project. 
- [ ] Networking is disabled in this compose project.
- [ ] None of the above.

## Question 2

How can the `app` service access the `redis` service? 

- [ ] We need `redis`'s IP address.
- [ ] By `redis:6379`.
- [ ] By `services.redis:6379`
- [ ] The `redis` service is not accessible from the `app` service. 

