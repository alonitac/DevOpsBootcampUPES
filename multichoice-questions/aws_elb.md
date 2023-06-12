# AWS - Elastic Load Balancer - multichoice questions


## Question 1

You are designing the architecture for a web application that will be deployed on AWS.
The application consists of multiple services running on Amazon EC2 instances. The services communicate over both HTTP and TCP protocols. 

Which type of Elastic Load Balancer (ELB) would be most suitable for this scenario?

- [ ] Application Load Balancer (ALB)
- [ ] Network Load Balancer (NLB)
- [ ] Gateway Load Balancer (GWLB)
- [ ] Classic Load Balancer (CLB)

## Question 2

In the security group of an Application Load Balancer (ALB), port 80 is configured to be open for incoming traffic. 
However, in the security group of the EC2 instances hosting the application, port 80 is not allowed. 

Given this configuration, would a request from a client to the application succeed?

- [ ] Yes.
- [ ] No.
- [ ] Depends on the configuration of the network access control list (NACL) associated with the LB.
- [ ] Depends on whether the ALB and the EC2 instances are launched within the same availability zone.

## Question 3

After experiencing a DDoS attack during the night, you discovered that your instances are accessed directly using their public IP addresses, allowing bypass the Application Load Balancer (ALB) that routes traffic to the instance. 

How can you overcome this vulnerability? 

- [ ] Place instances in a private VPC.
- [ ] Configure the instances to accept traffic only from the ALB using security group rule.
- [ ] Block any incoming requests during nights.
- [ ] There is no mitigation to this vulnerability.


## Question 4

You have set up an Application Load Balancer (ALB) to distribute incoming traffic across 2 instances.
But when you tested how does the balance load, you've noticed that requests are always routed to the same EC2 instance.

How could that behavior be explained? 

- [ ] The ALB uses sticky sessions.
- [ ] The ALB was created in a single AZ.
- [ ] One of the instances has failed to pass the health checks.
- [ ] None of the above.

## Question 5

You are managing a web service that offer to two types of requests: short-lived requests that require quick response times and heavy, long-lived requests that involve significant processing and take a longer time to complete.
The service runs on multiple instances behind an Application Load Balancer (ALB).

Considering this scenario, which load balancing algorithm would be the preferred choice for distributing traffic to the instances?

- [ ] Round-robin
- [ ] Weighted Target Groups
- [ ] Lease privilege principal
- [ ] Least Outstanding Requests

