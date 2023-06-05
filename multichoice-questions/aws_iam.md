# AWS - IAM - multichoice questions

## Question 1 

Which of the below actions can be controlled with IAM policies?

- [ ] Creating an Amazon S3 bucket.
- [ ] Control who can SSH into an EC2 instance.
- [ ] Control the name of an EC2 instance.
- [ ] Control the time in which IAM user can login to the web console. 

## Question 2

Which of the following statements best describe how a request to AWS is authorized?

- [ ] The request is default denied, but this can be overridden by an allow policy. If a policy explicitly denies a request, it can be overridden by another policy.
- [ ] The request is default denied, but this can be overridden by an allow policy. In contrast, if a policy explicitly denies a request, that deny can't be overridden.
- [ ] The request can either be allowed or denied depending on the request and each can be overwritten by the other. 
- [ ] The request is default allowed, but this can be overridden by a deny policy.

## Question 3

Your AWS account has 350 IAM users.
Your product manager asks you to allow to 50 users full access on S3. 
How can you implement this **effectively**?

- [ ] Create an IAM group, add the 50 users, and apply the policy to group.
- [ ] Create a policy and apply it to multiple users using a Bash script.
- [ ] Create an S3 bucket policy with unlimited access which includes each user's AWS account ID.
- [ ] Create a new role and add each user to the IAM role.

## Question 4

What does the following policy for Amazon EC2 do?

```json
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Deny",
    "Action": "*",
    "Resource": "*",
    "Condition": {
      "NotIpAddress": {
        "aws:SourceIp": [
          "192.0.2.0/24",
          "203.0.113.0/24"
        ]
      },
      "Bool": {"aws:ViaAWSService": "false"}
    }
  }
}
```

- [ ] Allow users with the above source IP to access resources.
- [ ] Denies access to AWS based on the source IP, even for AWS resources who try to access other resources.
- [ ] Denies access to AWS based on the source IP.
- [ ] Denies access from EC2 instance to the above IP ranges.

## Question 5 

What does the below policy do?

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSecurityGroupReferences",
        "ec2:DescribeStaleSecurityGroups"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ec2:AuthorizeSecurityGroupEgress",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:RevokeSecurityGroupEgress",
        "ec2:RevokeSecurityGroupIngress",
        "ec2:StartInstances",
        "ec2:StopInstances"
      ],
      "Resource": [
        "arn:aws:ec2:*:*:instance/*",
        "arn:aws:ec2:*:*:security-group/*"
      ],
      "Effect": "Allow"
    }
  ]
}
```

- [ ] Allows starting or stopping an EC2 instance and creating a security group.
- [ ] Allows starting or stopping an EC2 instance and modifying a security group.
- [ ] Allows starting or stopping an EC2 instance and deleting a security group.
- [ ] Allows creating an EC2 instance and modifying a security group.

## Question 6

Your EC2 instance should read objects from `mybucket` S3 bucket.
Your instance assumes a role with the following policy: 

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::mybucket"
    }
  ]
}
```

However, when the app running in the EC2 tries to read object, you receive the error: 

```text
Action does not apply to any resource(s) in statement.
```

How can you fix the error?

- [ ] Change the IAM permissions by applying `PutBucketPolicy` permissions.
- [ ] Verify that the policy has the same name as the EC2 instance.
- [ ] Add ``arn:aws:s3:::mybucket/*`` to the `Resource` section.
- [ ] Add an action `s3:ListBucket`.

## Question 7

An IAM user is trying to perform an action on an object belonging to some other account's S3 bucket.

Which of the bellow permission(s) would result a successful action?

- [ ] Identity based policy which allow the users to perform operation on S3 buckets.
- [ ] Only the root user account can perform this kind of operation. 
- [ ] Allow the user to access the other account's bucket using permission boundaries. 
- [ ] Resource based policy on the bucket which grant permission on the user's account.
