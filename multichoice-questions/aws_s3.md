# AWS - S3 - multichoice questions

### Question 1 

Your app is running in an EC2 instance, needs to read and write data to S3. 
Which of the below methods is the most recommended to use? 

1. Store the credentials in KMS, read them when in instance launches.
2. Use IAM role for the EC2 with an appropriate permissions in S3.
3. Execute `aws configure` form within the instance and provide Access Key id and Access Secret Key.
4. Define the credentials in the instance's user data. 

### Question 2 

Which of the below features of S3 can protect from accidental data deletion or overridden?  

1. Deny object deletion using an IAM bucket policy.
2. Check data integrity before every upload operation.
3. Access objects using pre-signed URLs.
4. Enable bucket versioning.
5. Enable cross-region replication.

### Question 3

Review [S3 performance](https://docs.aws.amazon.com/AmazonS3/latest/userguide/optimizing-performance.html) summary.

You consider using S3 bucket to store thousands of millions of objects for a new service in your company. 

Which of the below information should be taken into account before choosing S3 as your solution?

1. The size of individual objects being written to S3, in order to properly design the key names.
2. The total number of requests per second at peak usage.
3. The number of customers that will use the service. 
4. The total amount of storage needs for each S3 bucket.

### Question 4

How can you ensure that the data has been saved properly in S3?

1. The bucket is strongly consistent so there is no need to check data integrity.
2. Check in the bucket logs.
3. If the request status code in 200, the object has stored successfully.
4. Using Content-MD5, eTag or checksums.

### Question 5

question about ACL 

How do you secure company critical data on S3 ? (choose 4 correct answers)

1. You can use the Server Side Encryption (SSE)
2. You can serve it through Cloudfront
3. You can use IAM Policies
4. You can use Bucket policies
5. You can use Access Control Lists (ACLs)

### Question 6 

Which feature(s) can be used to restrict access to data in S3?

1. Using an S3 bucket IAM policy.
2. Create an event notification for the bucket for every compromised object.
3. Using S3 ACL on the bucket or the object.
4. Block the bucket from being public, which is allowed by default.

### Question 7

You have an S3 bucket with thousands of objects. Which of the below approaches are possible solutions for searching a certain object in the bucket? 

1. Use the S3 query.
2. Tag the objects with the metadata to search on that.
3. Make your own DB system which stores the S3 metadata for the search functionality.
4. Search by object prefix. 

### Question 8

S3 service is:

1. SaaS
2. PaaS
3. IaaS
4. IaaC

### Question 9

Your healthcare company stores sensitive patience health history information on S3. 
The legal department requires to:

- Encrypt data in transit.
- Encrypt data at rest.
- Don't allow public access to the bucket. 
- In case of data leakage, the hacker cannot personalize the data (the data is not [PII](https://www.dol.gov/general/ppii).

How would you configure the bucket? 

- Enable AES-256 (SSE-S3) encryption on the S3 bucket.
- Enable default encryption with AWS KMS-managed keys (SSE-KMS) on the S3 bucket.
- Add a bucket policy that includes a deny if PutObject request does not include aws:SecureTransport.
- Add a bucket policy with aws:SourceIp to only allow uploads and downloads from the corporate address.
- Enable CloudTrail to monitor and act on changes to the data lake's S3 bucket.


### Question 10

When you ask your usage report from GitHub, they generate the report on a background process, upload the report to S3 and email you with a download link.  

How would you recommend them to store the data in S3? 

1. In a public S3 bucket. Generate a pre-signed URL to the report object, valid for 12 hours.
2. In a public S3 bucket. Use a hash of the user's email address and the date and time the report was requested to generate a unique object name. Email this link to the user and have a scheduled task run within your application to remove objects that are older than seven days.
3. In a private S3 bucket. The link in the email should take the user to your application, where you can verify the active user session or force the user to log in. After verifying the user has rights to access this file, have the application retrieve the object from S3 and return it in the HTTP response. Delete the file from the S3 bucket after the request is completed.
4. In a private S3 bucket. The link in the email should take the user to your application, where you can verify the active user session or force the user to log in. Set the report object in S3 to public. Show the user a "Download" button in the browser that links to the public object.

