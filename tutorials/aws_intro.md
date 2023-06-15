# AWS - Intro to Cloud Computing

Cloud computing is a technology that allows businesses and individuals to access and use computing resources over the internet, without the need for owning or maintaining physical hardware. Amazon Web Services (AWS) is a leading provider of cloud computing services, offering a wide range of tools and platforms that enable businesses to deploy, scale, and manage their applications and data in the cloud. With AWS, organizations can benefit from the flexibility, scalability, and cost-effectiveness of cloud computing, while focusing on their core business objectives.

### Course resources:

[AWS official docs](https://docs.aws.amazon.com/)


## Region and Zones

AWS operates state-of-the-art, highly available data centers. Although rare, failures can occur that affect the availability of instances that are in the same location. If you host all of your instances in a single location that is affected by a failure, none of your instances would be available.

Each **Region** is designed to be isolated from the other Regions. This achieves the greatest possible **fault tolerance** and **stability**.

Here are a few available regions of AWS:

| Code      | Name |
| ----------- | ----------- |
| us-east-2      | US East (Ohio)       |
| us-east-1   | US East (N. Virginia)        |
| us-west-1    | US West (N. California)        |
| us-west-2   | US West (Oregon)        |
| eu-west-1  | 	Europe (Ireland)   |
| eu-central-1  | 	Europe (Frankfurt)   |
| eu-north-1  | 	Europe (Stockholm)   |

Each Region has multiple, isolated locations known as **Availability Zones**. The code for Availability Zone is its Region code followed by a letter identifier. For example, `us-east-1a`.

## SLA

AWS Service Level Agreements (**SLA**) are commitments made by AWS to its customers regarding the availability and performance of its cloud services.
SLAs specify the percentage of uptime that customers can expect from AWS services and the compensation they can receive if AWS fails to meet these commitments.
AWS offers different SLAs for different services, and the SLAs can vary based on the region and the type of service used. AWS SLAs provide customers with a level of assurance and confidence in the reliability and availability of the cloud services they use.

For more information, [here](https://aws.amazon.com/legal/service-level-agreements/?aws-sla-cards.sort-by=item.additionalFields.serviceNameLower&aws-sla-cards.sort-order=asc&awsf.tech-category-filter=*all).

# Self-check questions

[Enter the interactive self-check page](https://alonitac.github.io/DevOpsBootcampUPES/multichoice-questions/aws_intro.html)

# Exercises

### :pencil2: Talk with AWS using CLI

In this exercise, you will learn how to interact with the AWS API from your local machine using the AWS CLI (Command Line Interface).
This will allow you to manage AWS resources and services programmatically, in addition to using the AWS Management Console.

1. Follow AWS's official docs to [install AWS cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) on your Ubuntu machine.

2. You will then need to create credentials in the **IAM service** and configure them on your local machine before running CLI commands to interact with AWS services.
    1. Use your AWS account ID or account alias, your IAM username, and your password to sign in to the [IAM console](https://console.aws.amazon.com/iam)\.
    2. In the navigation bar on the upper right, choose your username, and then choose **Security credentials**\.
    3. In the **Access keys** section, choose **Create access key**\. If you already have two access keys, this button is deactivated and you must delete an access key before you can create a new one\.
    4. On the **Access key best practices & alternatives** page, choose your use case to learn about additional options which can help you avoid creating a long\-term access key\. If you determine that your use case still requires an access key, choose **Other** and then choose **Next**\.
    5. Set a description tag value for the access key\. This adds a tag key\-value pair to your IAM user\. This can help you identify and rotate access keys later\. The tag key is set to the access key id\. The tag value is set to the access key description that you specify\. When you are finished, choose **Create access key**\.
    6. On the **Retrieve access keys** page, choose either **Show** to reveal the value of your user's secret access key, or **Download \.csv file**\. This is your only opportunity to save your secret access key\. After you've saved your secret access key in a secure location, choose **Done**\.

3. Open a new terminal session on your local machine, and type `aws configure`. Enter the access key id and the access secret key. You can also provide the default region you are working on, and the default output format (`json`).
4. Test your credentials by executing `aws sts get-caller-identity`. This command returns details about your AWS user, which indicats a successful communication with API cli. 