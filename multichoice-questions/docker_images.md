# Docker - Images - multichoice questions

## Question 1

How many layers is the image `sonatype/nexus3:3.41.0` composed by?

- [ ] 3
- [ ] 4
- [ ] 5
- [ ] 6

## Question 2

Given the bellow directory structure for a Go app: 

```text
.
|-- app.Dockerfile
|-- cmd
|   |-- client
|   |   |-- main.go
|   |   |-- request.go
|   |   |-- ui.go
|   |-- server
|       |-- main.go
|       |-- translate.go
|-- go.mod
|-- go.sum
```

The app should be built with a Dockerfile named `app.Dockerfile` (instead the default name of `Dockerfile`). 
Which command can build the app?

- [ ] `docker build -t myapp .`
- [ ] `docker build -t myapp -f app.Dockerfile .`
- [ ] `docker build -f app.Dockerfile .`
- [ ] `docker build -t myapp -f app.Dockerfile ./server`

## Question 3

Given a linux machine with OS architecture of `arm/v5`.
What happens when running the following command: 

```bash
docker run nginx:1.24.0
```

- [ ] The command fails since this architecture is not supported by the `nginx:1.24.0` image.
- [ ] The running succeed since this architecture is supported by the `nginx:1.24.0` image and docker automatically selects the image that matches your OS and architecture.
- [ ] The running fails. Although this architecture is supported by the `nginx:1.24.0` image, you should tell docker this type of OS and architecture.
- [ ] The running succeed since your OS architecture is not matter. The container can be run everywhere. 


## Question 4

In the terminal, you are current working directory is `/home/user/app` and you want to build a Docker image for your application located in `/home/user/app/src` directory.
The Dockerfile is also located in `/home/user/app/src`. 

Which of the following command(s) will build the app? 

- [ ] `docker build -t myapp .`
- [ ] `docker build -t myapp ../`
- [ ] `docker build -t myapp src/`
- [ ] `docker build -t myapp /home/user/app/src`

## Question 5

What is wrong in the bellow Dockerfile:

```dockerfile
FROM python:3.10.15
WORKDIR /test
COPY ../tutorials .
RUN pip install -r requirements.txt

CMD ["python3", "app.py"]
```

- [ ] The workdir should be `/app`.
- [ ] The base image `python:3.10.15` doesn't exist.
- [ ] Docker doesn't allow copying files from outside the build context (`../`)
- [ ] The `CMD` should be `CMD "python app.py"`.


## Question 6

What happens when you run a Docker image that was packed with a Linux kernel different from the kernel of the host machine (the machine the container is running on)?

- [ ] System calls will fail frequently.
- [ ] The docker daemon will not let you run the image.
- [ ] Images don't contain a kernel — all containers running on a host machine share access to the host's kernel.
- [ ] The image will run smoothly as the docker daemon deals with kernels compatibility. 

## Question 7

You are told that the `python` docker image consists of 8 layers. 
You build a new image according to the following dockerfile: 

```dockerfile
FROM python
WORKDIR /test
```

How many layers your image will consist by?

- [ ] 8 layer since `WORKDIR /test` doesn't add new layer.
- [ ] 9 layer since `WORKDIR /test` adds 1 new layer.
- [ ] 10 layer since `WORKDIR /test` adds new 2 layers.
- [ ] You can't know the number of layers. 

## Question 8

In a Dockerfile, suppose you have the following line: `COPY app/ /usr/src/app/`. 
Assume the owner and group of `app` directory on your host machine is `elvis`, which its UID (user id) is 1000 and GID (group id) is 1000. 

What will be the UID and GID of the files in the `/usr/src/app` directory in the resulting Docker image?

- [ ] `0`.
- [ ] `1000`.
- [ ] Files in an imag"e doesn't have UID and GID.
- [ ] None of the above. 

## Question 9

Your Flask app is expecting an environment variable called `FLASK_APP`. 
How can you define this variable in the build time, within your Dockerfile? 

- [ ] By the instruction `ENV FLASK_APP=app.py`.
- [ ] By the instruction `ENV FLASK_APP app.py`.
- [ ] By the instruction `ARG FLASK_APP=app.py`.
- [ ] By the instruction `RUN FLASK_APP=app.py`.


## Question 10

Given an image called `curl-tool` built using the below Dockerfile

```dockerfile
FROM ubuntu
LABEL description="Containerized `curl` tool image"

RUN apt update && apt install curl -y

ENTRYPOINT ["curl"]
CMD ["google.com"]
```

Which of the following `docker run` commands will be running successfully? 

- [ ] `docker run curl-tool`
- [ ] `docker run curl-tool github.com`
- [ ] `docker run -it curl-tool /bin/bash` 
- [ ] `docker run curl-tool ls`


