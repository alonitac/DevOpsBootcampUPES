# AWS - S3 - multichoice questions

## Question 1 

Your app is running in an EC2 instance, needs to read and write data to S3. 
Which of the below methods is the most recommended to use? 

- [ ] Store the credentials in KMS, read them when in instance launches.
- [ ] Use IAM role for the EC2 with an appropriate permissions in S3.
- [ ] Execute `aws configure` form within the instance and provide Access Key id and Access Secret Key.
- [ ] Define the credentials in the instance's user data. 

## Question 2 

Which of the below features of S3 can protect from accidental data deletion or overridden?  

- [ ] Deny object deletion using an IAM bucket policy.
- [ ] Check data integrity before every upload operation.
- [ ] Access objects using pre-signed URLs.
- [ ] Enable bucket versioning.
- [ ] Enable cross-region replication.

## Question 3

Review [S3 performance](https://docs.aws.amazon.com/AmazonS3/latest/userguide/optimizing-performance.html) summary.

You consider using S3 bucket to store thousands of millions of text objects for a new service in your company. 

Which of the below information should be taken into account before choosing S3 as your solution?

- [ ] The size of individual object being written to S3
- [ ] The total number of requests per second at peak usage
- [ ] The number of customers that will use the service
- [ ] The total amount of storage needs for each S3 bucket

## Question 4

How can you ensure that the data has been saved properly in S3?

- [ ] The bucket is strongly consistent so there is no need to check data integrity.
- [ ] Check in the bucket logs.
- [ ] If the request status code in 200, the object has stored successfully.
- [ ] Using Content-MD5, eTag or checksums.

## Question 5

S3 service is:

- [ ] SaaS
- [ ] PaaS
- [ ] IaaS
- [ ] IaaC

## Question 6

There can be 2 objects in AWS with the same Etag.

- [ ] True
- [ ] False
- [ ] Only objects in different accounts
- [ ] Only objects in different bucket
- [ ] None of the above

## Question 7

In which storage class would you prefer to store your data based on the given scenario?

Monthly data stored size: 100 GB     
Average monthly GET requests: 10,000     
Average monthly PUT requests: 1,000     


- [ ] Standard Storage Class
- [ ] Infrequent Access Storage Class
- [ ] Glacier Storage Class
- [ ] Deep Archive Storage Class