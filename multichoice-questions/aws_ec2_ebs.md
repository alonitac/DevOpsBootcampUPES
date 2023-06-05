# AWS - EC2 and EBS - multichoice questions

## Question 1

Your app is deployed in `eu-north-1` requires 4 instances to be considered healthy.
Which of the following deployments is the cheapest and fault tolerant in case of AZ outage?

- [ ] 2 instances in `eu-north-1a`, 2 instances in `eu-north-1b`
- [ ] 4 instances in `eu-north-1a`, 4 instances in `eu-north-1b`
- [ ] 4 instances in `eu-north-1a`, 4 spot instances in `eu-north-1b` 
- [ ] 4 instances in `eu-north-1a`, 4 instances in `eu-north-1b`, 2 instances in eu-north-1c

## Question 2 

Your naive cloud architect suggests that they should automate the backup of your EBS volumes to the same availability zone (AZ) in which EC2 instances were running.
The idea is that this would ensure that you always have a backup copy of your data in case of an outage or failure.

What would you tell him?

- [ ] EBS volumes are automatically and redundantly stored in multiple physical volumes in the same availability zone, you only need to enable the "auto replicate" toggle.
- [ ] EBS volumes are automatically and redundantly stored in multiple physical volumes in the same availability zone as part of the normal operations of the EBS service at no additional charge.
- [ ] EBS volumes are automatically and redundantly stored in multiple physical volumes in the different availability zone as part of the normal operations of the EBS service.
- [ ] EBS volumes can be redundantly stored in multiple regions as part of the normal operations of the EBS service.

## Question 3

Your private and public DNS of a running ec2 instance are:

`ip-172-31-46-24.eu-north-1.compute.internal`    
`ec2-13-49-241-109.eu-north-1.compute.amazonaws.com`

- [ ] The private DNS can be resolved from your local machine.
- [ ] The private DNS can be resolved from within the instance.
- [ ] The public DNS can be resolved from your local machine.
- [ ] The public DNS can be resolved from within the instance.


## Question 4 

You are trying to connect to your instances over SSH but failed with "Timeout Error". What most likely is the root cause? 

- [ ] The instance is not running.
- [ ] You are using the private IP from your local machine.
- [ ] You are blocked by the security group rule. 
- [ ] You don't have IAM permission to connect to the instance. 

## Question 5

An EC2 instance applies 4 different security groups. 
Naive cloud architect wanted port 8080 to be opened in the machine, 
so he went to one of the security groups and added a rule that allows inbound traffic on port 8080. 

What are the potential risks associated with the architect action?

- [ ] Other instances that belong to the same security groups will also be exposed to port 8080, potentially creating a security vulnerability.
- [ ] The rule may not have been applied correctly.
- [ ] If the security group is used across multiple regions or accounts, the port may be exposed to machines outside of the intended region.
- [ ] None of the above 

## Question 6

A financial company was expanding its trading platform and required a low-latency, high-bandwidth network for their AWS infrastructure to support high-frequency trading.
They found that their current network configuration was causing delays in processing transactions, leading to lost revenue.

To resolve the issue, they can: 

- [ ] Use placement group of instances to process transactions.
- [ ] Use IOPS optimized instances.
- [ ] Use larger instance type.
- [ ] Use load balancer to balance the load evenly.


## Question 7 

How can an instance be copied to another region?

- [ ] By creating an AMI and copy it to another region.
- [ ] Using the `aws ec2 cp` command.
- [ ] There is no way to copy an instance to another region.
- [ ] By detaching the EBS volume, migrate it to another region, and attach it to the new instance.
- [ ] None of the above. 

## Question 8

As a system administrator for a large company, you were tasked with choosing the most cost-effective pricing option for a production server that required 12 CPUs for the next one year.
After considering the options, you decided to purchase:

- [ ] Spot instance
- [ ] On-demand instance
- [ ] Reserved instance
- [ ] Dedicated instance

## Question 9 

You are tasked with setting up a new web application on AWS.
The application is expected to receive a high volume of traffic and needs to have low latency.
You know that the application requires fast storage that can handle a high number of read and write operations.

What EBS option would you choose to ensure optimal performance for the application?

- [ ] EBS volume with magnetic hard drive
- [ ] Store all the data files in the ephemeral storage of the server
- [ ] EBS volume with provisioned IOPS
- [ ] EBS volume with general-purpose SSD

## Question 10

You need to ensure that your company's data is stored on physical hardware that is not shared with any other company due to a compliance requirement.
What option should you choose?

- [ ] Put the hardware inside a private VPC
- [ ] Use a dedicated instance
- [ ] Use a reserved instance
- [ ] Use a marketplace instance

## Question 11

How long does EBS remain unavailable while taking a snapshot of it?

- [ ] The volume will be available immediately.
- [ ] Depends on the volume size.
- [ ] Depends on the actual data stored in the EBS volume.
- [ ] Depending on the instance type the volume is attached to.

## Question 12 

You need to run a compute-intensive job that should last 3 hours during the weekend. Since the job can be restarted if it fails, you are wondering what would be the preferred way to launch the instances to reduce the cost while ensuring the job completes within the required timeframe.

- [ ] Use the spot instances
- [ ] Use the on-demand
- [ ] Use IO optimized on-demand instance
- [ ] Use compute optimized dedicated instances

## Question 13

Given a default security group which allows outbound traffic for all ports and protocols, and blocks any inbound traffic.

If an outgoing request is allowed, but the inbound traffic on that port is not allowed, how can the response to the outgoing request be returned?

- [ ] The response will be allowed to return to the instance even if the inbound traffic on that port is not explicitly allowed.
- [ ] The response will not be allowed to return to the instance.
- [ ] It depends on the instance virtualization type.
- [ ] None of the above is relevant

## Question 14 

You want to run high cpu load instance, which instance family would you use? 

- [ ] `t2`
- [ ] `x1`
- [ ] `c5`
- [ ] `p4`

