# Docker - images - multichoice questions


### Question 

How many layers is the image `sonatype/nexus3:3.41.0` composed by?

1. 3
2. 4
3. 5
4. 6

### Question 

Given the bellow directory structure for a Go app: 

```text
.
├── app.Dockerfile
├── cmd
│   ├── client
│   │   ├── main.go
│   │   ├── request.go
│   │   └── ui.go
│   └── server
│       ├── main.go
│       └── translate.go
├── go.mod
└── go.sum
```

The app should be built with a Dockerfile named `app.Dockerfile` (instead the default name of `Dockerfile`). 
Which command can build the app?

1. `docker build -t myapp .`
2. `docker build -t myapp -f app.Dockerfile .`
3. `docker build -f app.Dockerfile .`
4. `docker build -t myapp -f app.Dockerfile ./server`

### Question 

Given a linux machine with OS architecture of `arm/v5`.
What happens when running the following command: 

```bash
docker run nginx:1.24.0
```

1. The command fails since this architecture is not supported by the `nginx:1.24.0` image.
2. The running succeed since this architecture is supported by the `nginx:1.24.0` image and docker automatically selects the image that matches your OS and architecture.
3. The running fails. Although this architecture is supported by the `nginx:1.24.0` image, you should tell docker this type of OS and architecture.
4. The running succeed since your OS architecture is not matter. The container can be run everywhere. 


### Question 

In the terminal, you are current working directory is `/home/user/app` and you want to build a Docker image for your application located in `/home/user/app/src` directory.
The Dockerfile is also located in `/home/user/app/src`. 

Which of the following command(s) will build the app? 

1. `docker build -t myapp .`
2. `docker build -t myapp ../`
3. `docker build -t myapp src/`
4. `docker build -t myapp /home/user/app/src`

### Question 

What is wrong in the bellow Dockerfile:

```dockerfile
FROM python:3.10.15
WORKDIR /test
COPY ../tutorials .
RUN pip install -r requirements.txt

CMD ["python3", "app.py"]
```

1. The workdir should be `/app`.
2. The base image `python:3.10.15` doesn't exist.
3. Docker doesn't allow copying files from outside the build context (`../`)
4. The `CMD` should be `CMD "python app.py"`.


### Question 

What happens when you run a Docker image that was packed with a Linux kernel different from the kernel of the host machine (the machine the container is running on)?

1. System calls will fail frequently.
2. The docker daemon will not let you run the image.
3. Images don't contain a kernel — all containers running on a host machine share access to the host's kernel.
4. The image will run smoothly as the docker daemon deals with kernels compatibility. 

### Question 

You are told that the `python` docker image consists of 8 layers. 
You build a new image according to the following dockerfile: 

```dockerfile
FROM python
WORKDIR /test
```

How many layers your image will consist by?

1. 8 layer since `WORKDIR /test` doesn't add new layer.
2. 9 layer since `WORKDIR /test` adds 1 new layer.
3. 10 layer since `WORKDIR /test` adds new 2 layers.
4. You can't know the number of layers. 

### Question 

In a Dockerfile, suppose you have the following line: `COPY app/ /usr/src/app/`. 
Assume the owner and group of `app` directory on your host machine is `elvis`, which its UID (user id) is 1000 and GID (group id) is 1000. 

What will be the UID and GID of the files in the `/usr/src/app` directory in the resulting Docker image?

1. `0`.
2. `1000`.
3. Files in an imag"e doesn't have UID and GID.
4. None of the above. 

### Question 

Your Flask app is expecting an environment variable called `FLASK_APP`. 
How can you define this variable in the build time, within your Dockerfile? 

1. By the instruction `ENV FLASK_APP=app.py`.
2. By the instruction `ENV FLASK_APP app.py`.
3. By the instruction `ARG FLASK_APP=app.py`.
4. By the instruction `RUN FLASK_APP=app.py`.


### Question 

Given an image called `curl-tool` built using the below Dockerfile

```dockerfile
FROM ubuntu
LABEL description="Containerized `curl` tool image"

RUN apt update && apt install curl -y

ENTRYPOINT ["curl"]
CMD ["google.com"]
```

Which of the following `docker run` commands will be running successfully? 

1. `docker run curl-tool`
2. `docker run curl-tool github.com`
3. `docker run -it curl-tool /bin/bash` 
4. `docker run curl-tool ls`


