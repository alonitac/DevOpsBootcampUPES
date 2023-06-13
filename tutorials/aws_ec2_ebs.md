# Elastic Cloud Computing (EC2) and Elastic Block Storage (EBS)

## Elastic Cloud Computing (EC2)

Amazon EC2 (Elastic Compute Cloud) is a web service that provides resizable compute capacity in the cloud.
It allows users to create and manage virtual machines, commonly referred to as "instances", which can be launched in a matter of minutes and configured with custom hardware, network settings, and operating systems.

### Launch a virtual machine (EC2 instance)

1. Open the Amazon EC2 console at [https://console\.aws\.amazon\.com/ec2/](https://console.aws.amazon.com/ec2/).
2. From the EC2 console dashboard, in the **Launch instance** box, choose **Launch instance**, and then choose **Launch instance** from the options that appear\.
3. Under **Name and tags**, for **Name**, enter a descriptive name for your instance\.
4. Under **Application and OS Images \(Amazon Machine Image\)**, do the following:

   1. Choose **Quick Start**, and then choose **Ubuntu**\. This is the operating system \(OS\) for your instance\.

5. Under **Instance type**, from the **Instance type** list, you can select the hardware configuration for your instance\. Choose the `t2.micro` instance type, which is selected by default. In Regions where `t2.micro` is unavailable, you can use a `t3.micro` instance.

6. Under **Key pair \(login\)**, choose **create new key pair** the key pair that you created when getting set up\.

   1. For **Name**, enter a descriptive name for the key pair\. Amazon EC2 associates the public key with the name that you specify as the key name\.

   2. For **Key pair type**, choose either **RSA**.

   3. For **Private key file format**, choose the format in which to save the private key\. Since we will use `ssh` to connect to the machine, choose **pem**.

   4. Choose **Create key pair**\.

   **Important**  
   This step should be done once! once you've created a key-pair, use it for every EC2 instance you are launching.

   5. The private key file is automatically downloaded by your browser\. The base file name is the name you specified as the name of your key pair, and the file name extension is determined by the file format you chose\. Save the private key file in a **safe place**\.

      **Important**  
      This is the only chance for you to save the private key file\.

   6. Your private key file has to have permission of `400`, `chmod` it if needed.

7. Keep the default selections for the other configuration settings for your instance\.

8. Review a summary of your instance configuration in the **Summary** panel, and when you're ready, choose **Launch instance**\.

9. A confirmation page lets you know that your instance is launching\. Choose **View all instances** to close the confirmation page and return to the console\.

10. On the **Instances** screen, you can view the status of the launch\. It takes a short time for an instance to launch\. When you launch an instance, its initial state is `pending`\. After the instance starts, its state changes to `running` and it receives a public DNS name\.

11. It can take a few minutes for the instance to be ready for you to connect to it\. Check that your instance has passed its status checks; you can view this information in the **Status check** column\.

### Connect to your instance

Open the terminal in your local machine, and connect to your instance by:

```shell
ssh -i "</path/key-pair-name.pem>" ubuntu@<instance-public-dns-name-or-ip>
```

## Amazon Machine Image

An Amazon Machine Image (**AMI**) is a pre-configured virtual machine image used to create EC2 instances.
AMIs contain all the information needed to launch a new instance, including the operating system, application server, and any additional software.
AMIs provide a fast and reliable way to launch instances with specific configurations, making it easy to replicate complex environments or deploy new instances with consistent configurations.

## Instance lifecycle

When you stop an instance, AWS shut it down. They don't charge usage for a stopped instance, or data transfer fees, but do charge for the storage for any Amazon EBS volumes.

Each time you start a stopped instance, you are charged with a minimum of one minute for usage.
After one minute, AWS charge only for the **seconds** you use.

For example, if you run an instance for 20 seconds and then stop it, AWS charges for a full one minute.
If you run an instance for 3 minutes and 40 seconds, you are charged for exactly 3 minutes and 40 seconds of usage.

If you decide that you no longer need an instance, you can **terminate** it.

### Stop your instance

1. In the navigation pane, choose **Instances** and select the instance\.

1. Choose **Instance state**, **Stop instance**\. If this option is disabled, either the instance is already stopped or its root device is an instance store volume\.

1. When prompted for confirmation, choose **Stop**\. It can take a few minutes for the instance to stop\.

1. \(Optional\) While your instance is stopped, you can modify certain instance attributes\. For more information, see [modify\-stopped\-instance](https://docs.aws.amazon.com/cli/latest/reference/ec2/modify-instance-attribute.html)\.

1. To start the stopped instance, select the instance, and choose **Instance state**, **Start instance**\.

1. It can take a few minutes for the instance to enter the `running` state\.

## Elastic Block Storage

Amazon Elastic Block Store (EBS) is a block-level storage service designed to provide durable and scalable storage for Amazon EC2 instances.
EBS volumes can be attached to EC2 instances as block devices, and can be used for a variety of use cases such as storing application data, databases, and backups.
EBS volumes are highly available and reliable, and provide features such as snapshotting and encryption for enhanced data protection.

### Increase size of EBS

Suppose after six months of using your EC2 instance, you run out of storage space on your data volume.
You decide to double the size of your data volume. To do this, first you create a snapshot (this is a good practice!), and then you increase the size of the data volume.


1. Create a snapshot of the data volume, in case you need to roll back your changes\.

   1. In the Amazon EC2 console, in the navigation pane, choose **Instances**, and select your instance.

   1. On the **Storage** tab, under **Block devices** select the **Volume ID** of the data volume\.

   1. On the **Volumes** detail page, choose **Actions**, and **Create snapshot**\.

   1. Under **Description**, enter a meaningful description.

   1. Choose **Create snapshot**\.

1. To increase the data volume size, in the navigation pane, choose **Instances**, and select your instance.

1. Under the **Storage** tab, select the **Volume ID** of your data volume\.

1. Select the check box for your **Volume ID**, choose **Actions**, and then **Modify volume**\.

1. The **Modify volume** screen displays the volume ID and the volume’s current configuration, including type, size, input/output operations per second \(IOPS\), and throughput\. In this tutorial you double the size of the data volume\.

   1. For **Volume type**, do not change value\.

   1. For **Size**, change to 16 GB\.

   1. For **IOPS**, do not change value\.

   1. For **Throughput**, do not change value\.

1. Choose **Modify**, and when prompted for confirmation choose **Modify** again\. You are charged for the new volume configuration after volume modification starts\. For pricing information, see [Amazon EBS Pricing](http://aws.amazon.com/ebs/pricing/?nc1=h_ls)\.     
   **Note**      
   You must wait at least six hours and ensure the volume is in the `in-use` or `available` state before you can modify the volume again\.


Once the data volume enters the `optimizing` state, you can use file system\-specific commands to extend the file system to the new, larger size\.

For more information about extending the file system, see [Extend a Linux file system after resizing a volume](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recognize-expanded-volume-linux.html)\.

**To extend the file system**

1. Connect to your instance.
1. In the terminal window, use the following command to get the size of the file system\.

```
[ec2-user ~]$ df -hT
```

The following example output shows that the file system size of the data volume `/dev/nvme1n1` is 8 GB\. In the previous procedure, you increased the data volume size to 16 GB\. Now you need to extend the file system to take advantage of the added storage\.  
![\[Display of file systems showing data volume file system size has not been increased.\]](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/images/extend-file-system-disk-space.png)

1. Use the following command to extend the XFS file system that is mounted on the `/data` mount point\.

   ```
   [ec2-user ~]$ sudo xfs_growfs -d /data
   ```

1. Use the following command again to verify that the file system has been extended\.

   ```
   [ec2-user ~]$ df -hT
   ```

   The following example output shows that the file system size of `/dev/nvme1n1` is the same as the data volume size\.  
   ![\[Display of file systems showing data volume file system size has been increased.\]](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/images/file-system-extended-disk-space.png)


## Create and mount EBS volume to your EC2 instance

1. In EC2 the navigation pane, choose **Volumes**\.
2. Choose **Create volume**\.
3. For **Volume type**, choose the type of volume to create, `SSD gp3`\. For more information, see [Amazon EBS volume types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html).
4. For **Size**, enter the size of the volume, 5GiB\.
5. For **Availability Zone**, choose the Availability Zone in which to create the volume\. A volume can be attached only to an instance that is in the same Availability Zone\.
6. For **Snapshot ID**, keep the default value \(**Don't create volume from a snapshot**\)\.
7. Assign custom tags to the volume, in the **Tags** section, choose **Add tag**, and then enter a tag key and value pair\.
8. Choose **Create volume**\.
   **Note**  
   The volume is ready for use when the **Volume state** is **available**\.
9. To use the volume, attach it to an instance\.
10. Connect to your instance over SSH.
11. [Format and mount the attached volume](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html) and write some data to the mounted EBS.


## Run application, open security group

1. Use `scp` to copy the files in our shared repo under `simple_flask_webserver` from your local machine to the instance.
2. Run the app by `python3 app.py` (install requirements if needed).
3. Define the appropriate rules in the instance's security group.
4. Visit the app.

# Self-check questions

[Enter the interactive self-check page](https://alonitac.github.io/DevOpsBootcampUPES/multichoice-questions/aws_ec2_ebs.html)

# Exercises

### :pencil2: EC2 pricing

Explore the [pricing page](https://aws.amazon.com/ec2/pricing/on-demand/) of on-demand instances.

Compute the monthly cost of the below instance characteristics:-

1. Instance run in `us-east-1`.
2. A 24/7 running `*.micro` instance.
3. `8GGB` of SSD gp3 EBS.
4. `50GB` of data transferred into the instance.
5. `600GB` of data transferred from the instance to S3.
6. `230GB` of data transfer out of the instance to customers around the world.
7. `8TB` of data transferred from the instance to other instances in the same AZ.
8. `1TB` of data transferred from the instance to another region.


### :pencil2: Control EC2 from AWS cli

Perform the below operations using AWS cli directly on your instance.

1. Stop your instance.
2. Start it.
3. Add the tag `ENV=test` to your instance.
4. Get the Network Interface id attached to the instance.

### :pencil2: Change instance properties

1. Change your instance type from `*.micro` to `*.nano`.
2. Change the availability zone of your instance.
3. Add a tag

### :pencil2: `boto3`

`boto3` is the AWS SDK for Python, which allows Python developers to write software that makes use of AWS services.

1. Install it by `pip install boto3` (it's recommended to install it using PyCharm's terminal in an existing Python venv).
2. Write to python code that:
   1. Stop your EC2 instance.
   2. Creates an AMI from the instance.

## Optional practice

### Network test between two instances

Work with a friend on the same region.
Use the `iperf` tool to measure network performance between two EC2 instances.
You'll measure the bandwidth and latency of the connection using the `iperf` output.

1. Install `iperf` on both you and your friend machine:

```bash
sudo apt-get update
sudo apt-get install iperf3
```

2. Some of you should run the server:

```bash 
iperf3 -s
```

3. The other participant should run the client:

```bash
iperf3 -c <SERVER_IP>
```

Make sure the appropriate ports are opened.


### Encrypt EBS volumes

1. In KMS, [create encryption key](https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html#create-symmetric-cmk). Make sure your IAM user can administer this key and delete it.
2. [Create a volume snapshot](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-creating-snapshot.html#ebs-create-snapshot) of the EBS you provisioned and mounted in the previous section.
3. Create an **encrypted EBS from the EBS snapshot**. Use the encrypted keys you've just created in KMS.
4. Attach and mount the encrypted volume to your instance, as follows:
   1. Generate new UUID for the encrypted disk by:
      ```shell
      sudo xfs_admin -U generate <device-name>
      ```
   2. Copy the generated uuid, and add the following entry to `/etc/fstab`:
      ```shell
      UUID=<device-uuid>  /data  xfs  defaults,nofail  0  2
      ```
      while `<device-uuid>` is your generated device UUID.

   Make sure the data from the unencrypted volume has been migrated successfully to the encrypted volume.
5. In KMS page, disable your encryption key. What happened to the data in your instance?
6. Stop the machine and start it again, [what happened](https://docs.aws.amazon.com/kms/latest/developerguide/services-ebs.html#ebs-cmk) to the data in your instance?

###  EC2 instance metadata

EC2 instance metadata is a service provided by AWS that allows an EC2 instance to retrieve information about itself (**from within itself**),
such as its instance ID, hostname, and IP address, without the need for authentication.
This information can be accessed using a special URL or by using the EC2 instance metadata service API.

There is a static IP address reserved by AWS to retrieve instance metadata:

```text
http://169.254.169.254/latest/meta-data/
```

Connect to your instance, and use `curl` and the instance metadata URL to retrieve:

- Get the subnet ID of the instance
- Get the instance tags
- Get the list of available public keys

