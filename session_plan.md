# Session plan

## Teaching guidelines 

### In the main class

- Lecture and discussion (slides)
- QnA session
- Solve problem together 
- Students code review 

### Discussion norms 

- Allow everyone to participate
- Try to define technical terms before you use them (e.g. Production, Load balancing, Instance, HA).
- When being critical to student's code or work, make sure to be respectful.

## Session notes

- :mortar_board: - self-paced tutorials (+ multichoice questions + exercises )
- :clapper: - slides
- :interrobang: - QnA
- :mag_right: - code review, demo

| #  |  Date | Notes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|---|---|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1 | 	1\6 | :clapper: Course intro, :clapper: What is DevOps?, :clapper: Linux intro, :mortar_board: Linux intro, :mortar_board: File management                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
| 2 | 	2\6 | :clapper: Linux processes, :mortar_board: IO redirection, :mortar_board: processes, :mortar_board: package management, :mortar_board: env var, :mortar_board: Bash and other shells (no self-check and ex here), :mortar_board: Bash conditional statements<br><br>In processes tutorial, you can demonstrate the [Graceful Termination](https://github.com/alonitac/DevOpsBootcampUPES/blob/main/tutorials/linux_processes.md#graceful-termination) section in class and discuss graceful termination (this is how it's done in k8s) <br><br> :heavy_check_mark: Compile `strace_ex` and upload to public bucket in AWS. Replace `<group-repo-link>` with the object public link. |
| 3 | 	5\6 | :clapper: The OSI Model, :mortar_board: The OSI model, :mag_right: Sockets, :mortar_board: Networks and Subnets <br><br> In the demo sockets, you can run the server in an EC2 instance and send the instance's public IP to the students in the chat                                                                                                                                                                                                                                                                                                                                                                                                                              
| 4 | 	6\6 | :mortar_board: DNS, :mortar_board: HTTP, :mag_right: Network Security, :mortar_board: SSH <br><br> In the beginning of this session, create with the students Python virtual env (venv) in their PyCharm. They will need it later on in the HTTP tutorial <br><br>  :mortar_board: Review [Network Security](tutorials/networking_security.md) together with the students, demonstrate different encryption on your machine (symmetric/public/digital signature)                                                                                                                                                                                                                   |
| 5 | 	7\6 | :clapper: Intro to cloud computing, :mortar_board: Intro to cloud computing, :clapper: EC2 and EBS (**demonstrate to your student how to launch an ec2 instance. Discuss features that was not covered in the slides**), :mortar_board: EC2 and EBS                                                                                                                                                                                                                                                                                                                                                                                                                                | 
| 6 | 	8\6 | 
| 7 | 	9\6 |
| 8 | 	12\6 | :mag_right: Intro to virtualization and containers, :mag_right: Demonstrate in class how to create containers from scratch: https://ericchiang.github.io/post/containers-from-scratch/ (directly using linux kernel features), :mortar_board: Docker containers, :mortar_board: Docker images                                                                                                                                                                                                                                                                                                                                                                                      | 
| 9 | 	13\6 | :clapper: Docker networking, :mortar_board: Docker volumes, :mortar_board: Docker compose                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| 10 | 	14\6 |
| 11 | 	15\6 | In ELB tutorial, let some of your students display in python application console under load (when the load test is running), terminate one of their instances, discuss the results.
| 12 | 	16\6 |
| 13 | 	19\6 |
| 14 | 	20\6 |
| 15 | 	21\6 |
| 16 | 	22\6 |
| 17 | 	23\6 |
| 18 | 	26\6 |
| 19 | 	27\6 |
| 20 | 	28\6 |
| 21 | 	29\6 |
| 22 | 	3\7 |
| 23 | 	4\7 |
| 24 | 	5\7 |
| 25 | 	6\7 |
| 26 | 	7\7 |
| 27 | 	10\7 |
| 28 | 	11\7 |
| 29 | 	12\7 |
| 30 | 	13\7 |
| 31 | 	14\7 |

