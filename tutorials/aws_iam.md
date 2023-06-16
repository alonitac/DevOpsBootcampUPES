# Identity and Access Management (IAM)

## Identity-based policies

Identity-based policies are attached to an IAM user, group, or role. These policies let you specify what that identity can do (its permissions).

Throughout this unit, we will create different policies and associate them with the role you've created in the previous unit. 

If you haven't created a role yet, here is a short recap.

### Create IAM role with permissions over S3 and attach it to an EC2 instance

1. Open the IAM console at [https://console\.aws\.amazon\.com/iam/](https://console.aws.amazon.com/iam/)\.

2. In the navigation pane, choose **Roles**, **Create role**\.

3. On the **Trusted entity type** page, choose **AWS service** and the **EC2** use case\. Choose **Next: Permissions**\.

4. On the **Attach permissions policy** page, search for **AmazonS3FullAccess** AWS managed policy\.

5. On the **Review** page, enter a name for the role and choose **Create role**\.
6. Attach the role to your EC2 instance. 
7. Test your policy.

## The least privilege principle 

The least privilege principle is a security best practice that involves giving users and systems only the minimum permissions necessary to perform their tasks or functions, and no more. This helps to reduce the risk of accidental or intentional damage or data loss, and limit the potential impact of security breaches or vulnerabilities.

### Create a policy to access a certain bucket and prefix only and attach it to your IAM role.

Let's narrow the above policy of your S3 bucket.

1. Open the [IAM console](https://console.aws.amazon.com/iam/).
2. From the console, open the IAM user or role that should have access to only a certain bucket.
3. In the **Permissions** tab, remove the **AmazonS3FullAccess** AWS managed policy.
4. Click **Add permissions** and **Create inline policy**
5. Choose **Import manages policy** and import **AmazonS3FullAccess**, switch to the JSON view of your new policy.
6. Inspired by [policies examples](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_examples.html) in AWS IAM docs, try to change the given policy JSON such that it allows the user to list, read, and write objects with a prefix `images/`
7. Save your policy, test it.
8. Validate your changes using the [IAM Policy Simulator](https://policysim.aws.amazon.com/).


### Extend your policy

1. Explore [S3 policy condition key elements](https://docs.aws.amazon.com/AmazonS3/latest/userguide/amazon-s3-policy-keys.html).
2. Try to add a condition to your above policy such that only objects in `STANDARD_IA` storage-class can be accessed. 
3. Validate your changes.

### Use resource tags in the policy

Using resource tags in an AWS policy can help you implement more granular access controls based on the tags assigned to the resources. By using tags in the policy, you can specify permissions for specific tags or tag values, which can make it easier to manage access and automate resource management based on tags.

Let's see an example:

1. In IAM roles console, choose your role.
2. In **Tags** tab, add a tag with the key `BucketPrefix` and some value according to your choice.
3. Instead of allow operation on prefix `images/`, try to allow access on a dynamic prefix according to the principal tag:

```text
"Resource": ["arn:aws:s3:::<your-bucket-name>/${aws:PrincipalTag/BucketPrefix}/*"]
```

4. Test it.

### Controlling access to EC2 using resource tags

In this section we are going to create a role which can start/stop EC2 instances belonging to the Development environment only.

1. In IAM console, **Roles** page, create a new role with **AWS account** trusted entity type.
2. According to the policy described in [Controlling access to AWS resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html#access_tags_control-resources), create an inline policy for your role, that allows the principal assumed this role to start/stop EC2 instances that was tagged
   with key `Env` and value `Dev`.
3. Save the role.
4. Tag some of your EC2 instance with `Env=Dev`.
5. Now we would like to switch our AWS IAM user to assume the created role. 
   1. In the IAM console, choose your username on the navigation bar in the upper right\. It typically looks like this: ***username*@*account\_ID\_number\_or\_alias***\.
   2. Choose **Switch Role**
   3. On the **Switch Role** page, type the account ID number and the role.
6. Test your policy by trying to start/stop EC2 instances with/without appropriate `Env` tag.
7. Switch back to your IAM user. 

### Enforce tagging policy for resources

Enforcing tagging policies for resources in AWS is considered a good practice. 
By enforcing a tagging policy, you can ensure that all resources are consistently labeled and organized, which makes it easier to identify, search, and manage resources and costs.

For example, you can use tags to label resources based on their project and environment. This can help you to quickly find and manage resources, monitor costs, and set up automation and policies based on tags.

1. We now want to force a tagging policy in our AWS account. We want all EC2 instances to be tagged with a key `Project` with allowed values of `CloudMate`, `PipelineX`, or `SecureStack` (three imagined project names).
2. According to the policy described in [Controlling access during AWS requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html#access_tags_control-requests), add a statement to the above inline policy that enforces the tagging policy for EC2 instances belonging to different projects. 
3. Switch to your role and test your policy. 

# Self-check questions

[Enter the interactive self-check page](https://alonitac.github.io/DevOpsBootcampUPES/multichoice-questions/aws_iam.html)


# Exercises

### :pencil2: practice policies

Create the below policies following the Principle of the [least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege).

1. IAM policy with permissions to start and stop EC2 instances.
2. IAM policy with permissions read object from S3 buckets except objects starting with `internal/`.
3. IAM policy with permissions to upload objects from `STANDARD` and `STANDARD_IA` storage classes only.
4. IAM policy with permissions to attach EBS to EC2.
5. IAM policy with permissions to attach EBS to EC2 from the `us-east-1` region only.
6. IAM policy with permissions to attach EBS to EC2 from all US and EU regions.
7. IAM policy which denies users to assign policies to an identity, which means, users under this policy cannot assign IAM policies to other users, groups, roles.

### :pencil2: S3 encrypt data at transit

As you may know, Amazon S3 offers encryption in **transit** and encryption **at rest**. Encryption in transit refers to HTTPS and encryption at rest refers to client-side or server-side encryption.

Since Amazon S3 allows both HTTP and HTTPS requests, encryption in transit may be violated.
We would like to create a resource-based policy that will be associated with an S3 bucket and will enforce HTTPS communication only.

Use [this resource as a reference](https://repost.aws/knowledge-center/s3-bucket-policy-for-config-rule) to define the policy and attach it to your bucket.

## Optional practice

### ABAC

Attribute-based access control (ABAC) is an authorization strategy that defines permissions based on attributes.
In AWS, these attributes are called **tags**.
You can attach tags to almost any AWS resource (EC2 instance, S3 bucket), including IAM entities (users or roles).

ABAC policies can be designed to allow operations when the principal's tag matches the resource tag.
ABAC is helpful in environments that are growing rapidly and helps with situations where policy management becomes cumbersome.

Follow:   
https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_attribute-based-access-control.html

