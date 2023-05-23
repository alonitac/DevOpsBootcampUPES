# AWS - EC2 and EBS - multichoice questions

### Question 1

Your app is deployed in eu-north-1 requires 4 instances to be considered healthy.
Which of the following deployments is fault tolerant in case of AZ outage?

1. 2 instances in eu-north-1a, 2 instances in eu-north-1b
1. 4 instances in eu-north-1a, 4 instances in eu-north-1b
1. 4 instances in eu-north-1a, 4 spot instances in eu-north-1b 
1. 4 instances in eu-north-1a, 4 instances in eu-north-1b, 2 instances in eu-north-1c

### Question 2 

Your naive cloud architect suggests that they should automate the backup of your EBS volumes to the same availability zone (AZ) in which EC2 instances were running.
The idea is that this would ensure that you always have a backup copy of your data in case of an outage or failure.

What would you tell him?

1. EBS volumes are automatically and redundantly stored in multiple physical volumes in the same availability zone, you only need to enable the "auto replicate" toggle.
2. EBS volumes are automatically and redundantly stored in multiple physical volumes in the same availability zone as part of the normal operations of the EBS service at no additional charge.
3. EBS volumes are automatically and redundantly stored in multiple physical volumes in the different availability zone as part of the normal operations of the EBS service.
4. EBS volumes can be redundantly stored in multiple regions as part of the normal operations of the EBS service.

### Question 3

You private and public DNS of a running ec2 instance are:

- `ip-172-31-46-24.eu-north-1.compute.internal`.
- `ec2-13-49-241-109.eu-north-1.compute.amazonaws.com`

1. The private DNS can be resolved from your local machine.
2. The private DNS can be resolved from within the instance.
3. The public DNS can be resolved from your local machine.
4. The public DNS can be resolved from within the instance.


### Question 4 

You are trying to connect to your instances over SSH but failed with "Timeout Error". What most likely is the root cause? 

1. The instance is not running.
2. You are using the private IP from your local machine.
3. You are blocked by the security group rule. 
4. You don't have IAM permission to connect to the instance. 

### Question 5

An EC2 instance applies 4 different security groups. 
Naive cloud architect wanted port 8080 to be opened in the machine, 
so he went to one of the security groups and added a rule that allows inbound traffic on port 8080. 

What are the potential risks associated with the architect action?

1. Other instances that belong to the same security groups will also be exposed to port 8080, potentially creating a security vulnerability.
2. The rule may not have been added to the intended security group, leading to unintended access to port 8080.
3. If the security group is used across multiple regions or accounts, the port may be exposed to machines outside of the intended region.
4. None of the above 

### Question 6

A financial company was expanding its trading platform and required a low-latency, high-bandwidth network for their AWS infrastructure to support high-frequency trading.
They found that their current network configuration was causing delays in processing transactions, leading to lost revenue.

To resolve the issue, they can: 

1. Use placement group of instances to process transactions.
2. Use IOPS optimized instances.
3. Use larger instance type.
4. Use load balancer to balance the load evenly.


### Question 7 

How can an instance be copied to another region?

1. By creating an AMI and copy it to another region.
2. Using the `aws ec2 cp` command.
3. There is no way to copy an instance to another region.
4. By detaching the EBS volume, migrate it to another region, and attach it to the new instance.
5. None of the above. 

### Question 8

As a system administrator for a large company, you were tasked with choosing the most cost-effective pricing option for a production server that required 12 CPUs for the next one year.
After considering the options, you decided to purchase:

1. Spot instance
2. On-demand instance
3. Reserved instance
4. Marketplace instance

### Question 9 

You are tasked with setting up a new web application on AWS.
The application is expected to receive a high volume of traffic and needs to have low latency.
You know that the application requires fast storage that can handle a high number of read and write operations.

What EBS option would you choose to ensure optimal performance for the application?

1. EBS volume with magnetic hard drive
2. Store all the data files in the ephemeral storage of the server
3. EBS volume with provisioned IOPS
4. EBS volume with general-purpose SSD

### Question 10

You need to ensure that your company's data is stored on physical hardware that is not shared with any other company due to a compliance requirement.
What option should you choose?

1. Put the hardware inside a private VPC
2. Use a dedicated instance
3. Use a reserved instance
4. Use a dedicated instance

### Question 11

How long does EBS remain unavailable while taking a snapshot of it?

1. The volume will be available immediately.
2. EBS magnetic drive will take more time than SSD volumes.
3. Depends on the volume size.
4. Depends on the actual data stored in the EBS volume.


### Question 12 

You need to run a compute-intensive job over the weekend. Since the job can be restarted if it fails, you are wondering what would be the preferred way to launch the instances to reduce the cost while ensuring the job completes within the required timeframe.

1. Use the spot instances
2. Use the on-demand
3. Use IO optimized on-demand instance
4. Use compute optimized dedicated instances

### Question 13

Given a default security group which allow outbound traffic for all ports and protocols, and blocks any inbound traffic.

If an outgoing request is allowed, but the inbound traffic on that port is not allowed, how can the response to the outgoing request be returned?

1. The response will be allowed to return to the instance even if the inbound traffic on that port is not explicitly allowed.
2. The response will not be allowed to return to the instance.
3. It depends on the instance virtualization type.
4. None of the above is relevant

### Question 14

security group to other security group 

### Question 15 

you want to run high cpu load instance, which instance to use? 

What is the best EC2 instance class for a server that continuously has a heavy CPU load?

    C5
    T2
    R5
    H1



### Question 16 

How do you connect via SSH to a Linux EC2 instance with an EBS volume if you lost your key pair?

    Stop the instance and create an AMI image. Launch the image using a new key pair.
    Contact AWS support. A support specialist can remotely restore access to your instance and send you a new key pair.
    You can not connect to this EC2 instance. The key pair is displayed only one time. If you lose it, you have lost all access to this instance. Connect the EBS volume to another instance to recover your files.
    Attach the EBS volume to a temporary instance launched with a new key pair, and overwrite ~/.ssh/authorized_keys using the same file from the new instance.
