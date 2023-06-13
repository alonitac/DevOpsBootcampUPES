[comment]: # (mdslides presentation.md --include media)

[comment]: # (THEME = white)
[comment]: # (CODE_THEME = base16/zenburn)
[comment]: # (The list of themes is at https://revealjs.com/themes/)
[comment]: # (The list of code themes is at https://highlightjs.org/)

[comment]: # (controls: true)
[comment]: # (keyboard: true)
[comment]: # (markdown: { smartypants: true })
[comment]: # (hash: false)
[comment]: # (respondToHashChanges: false)
[comment]: # (width: 1500)
[comment]: # (height: 1000)

---

<style type="text/css">
  .reveal { 
    font-size: 2.2em;
  }

  .reveal .code-wrapper code {
    white-space: pre;
    font-size: 2em;
    line-height: 1.2em;
  }
</style>
---

![](media/upes.png)   <img src="media/int.png" width="8%">


DevOps Bootcamp - INT College & UPES University

# Elastic Load Balancing and Autoscaling

![](media/s3logo.png)

[comment]: # (!!!)

### Today's agenda

- Introducing Simple Storage Service (S3)
- Block vs Object storage
- Storage classes, data management features
- Data protection - permissions, encryption, integrity
- Data processing

[comment]: # (!!!)

### Simple Storage Service (S3) overview


- Amazon Simple Storage Service (Amazon S3) is an object storage service
- Store and retrieve any amount of data from anywhere around the world
- Unlimited capacity
- Does not have a file system. Instead, data is stored as **Objects** within a **Bucket**.
- All objects are stored in a **flat namespace** (there is no idea of directories), only bucket and objects within it.
- It is a **regional service** - content is automatically replicated within a region for durability in at least 3 AZs.
- [You pay for the stored GBs and outbound traffic](https://aws.amazon.com/s3/pricing/).

[comment]: # (!!!)

### S3 vs EBS - object storage and block storage

- EBS is a [block storage](https://aws.amazon.com/what-is/block-storage/), while S3 is an [object storage](https://aws.amazon.com/what-is/object-storage/). Those are two different technologies.
- Object storage systems distribute this data across **multiple physical device**s but allow users to access the content efficiently from a single, virtual storage repository.
- EBS use cases and performance:
  - Basically must be paired to an EC2 instance.
  - Low-latency performance – up to 16,000 IOPS for General Purpose SSDs and up to 256,000 IOPS for the new Provisioned IOPS SSD.
  - Highly available – 99.8% to 99.9% for General Purpose SSDs and 99.999% for the Provisioned IOPS SSD


[comment]: # (!!! data-auto-animate)

### S3 vs EBS - object storage and block storage

- S3 use cases and performance:
  - Store media and large data lakes - photos, videos, email, web pages, sensor data, and audio files.
  - Incredibly durable - 99.99999999999%
  - Highly available – 99.99%
  - Accessible by RESTful API - seconds to minutes for read/write operations  
  - Data can be access from everywhere (via public URL)
  - Impressive [performance and scale](https://docs.aws.amazon.com/AmazonS3/latest/userguide/optimizing-performance.html)

[comment]: # (!!! data-auto-animate)

### Storage classes

Amazon S3 offers a range of storage classes designed for different use cases.

- **S3 Standard** — The default storage class
- **S3 Standard-IA** and **S3 One Zone-IA** - designed for long-lived and infrequently accessed data. (IA stands for infrequent access.)
- **S3 Glacier** - designed for low-cost data archiving.
- **S3 Intelligent-Tiering** - designed to optimize storage costs by automatically moving data to the most cost-effective access tier.

[comment]: # (!!!  data-auto-animate)

### Storage management

Amazon S3 has storage management features that you can use to manage costs, meet regulatory requirements, reduce latency, and save multiple distinct copies of your data for compliance requirements.

- [Lifecycle](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lifecycle-mgmt.html) – You can transition objects to other S3 storage classes or expire objects that reach the end of their lifetimes.
- [Object Lock](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock.html) – Prevent Amazon S3 objects from being deleted or overwritten for a fixed amount of time.
- [Replication](https://docs.aws.amazon.com/AmazonS3/latest/userguide/replication.html) – Replicate objects and their respective metadata and object tags to one or more destination buckets in the same or different AWS Regions for reduced latency, compliance, security, and backup.
- [Batch Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/batch-ops.html) – Manage billions of objects at scale with a single S3 API request or a few clicks in the Amazon S3 console.

[comment]: # (!!!)

### Strong consistency model

- Amazon S3 provides strong read-after-write consistency for PUT and DELETE requests of objects in your Amazon S3 bucket
- This is called [strongly consistency model](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html#ConsistencyModel).

<img src="media/aws_strong.gif" width="70%">

[comment]: # (!!!)

### Access management and security

Amazon S3 provides features for auditing and managing access to your buckets and objects.

- By default, S3 buckets and the objects in them are **private**. You have access only to the S3 resources that you create.
- [Access control lists (ACLs)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/acls.html) allow to grant read and write permissions for individual buckets and objects to authorized AWS users (not necessarily users within your account). As a general rule, AWS doesn’t  recommend using it, but to use S3 resource-based policies instead.
- Using AWS Identity and Access Management (IAM), you should be able to manage granular permissions and access to an S3 bucket.


[comment]: # (!!!)

### Protecting data using server-side encryption

S3 will [encrypt your data at rest](https://docs.aws.amazon.com/AmazonS3/latest/userguide/serv-side-encryption.html) and manage the encryption keys for you.

- **Each object** is encrypted using a per-object key. The per-object key is encrypted using a master key, and the master key is managed and rotated regularly by Amazon.
- With **SSE-S3**, the default option for server-side encryption, Amazon S3 managed the keys for you internally in the S3 service.
- With **SSE-KMS** the master key is stored in KMS, this way you benefit from separate permissions for the use of the master key and the S3 objects (FedRAMP industry requirements).
- With **SSE-C**, Amazon S3 will encrypt your data at rest using the custom encryption keys that you provide

[comment]: # (!!!)

### Object integrity

[S3 uses checksum values](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) to verify the integrity of data that you upload to or download from Amazon S3.

- S3 offers you the option to choose the checksum algorithm that is used to validate your data during upload or download. Supported algorithms are: CRC32, CRC32C, SHA-1, SHA-256.
- Another way to verify the integrity of your object after uploading is to provide an MD5 digest of the object when you upload it.
- The [entity tag (ETag)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html#checking-object-integrity-etag-and-md5) for an object represents a specific version of that object. Keep in mind that the ETag reflects changes only to the content of an object, not to its metadata.
- Note that when an object is uploaded as a multipart upload, the ETag for the object is **not** an MD5 digest of the entire object.


[comment]: # (!!!)

### Data processing

S3 has features to transform data and trigger workflows to automate a variety of other processing activities.

- [S3 Object Lambda](https://docs.aws.amazon.com/AmazonS3/latest/userguide/transforming-objects.html) – Add your own code to S3 GET, HEAD, and LIST requests to modify and process data as it is returned to an application. Filter rows, dynamically resize images, redact confidential data, and much more.
- [Event notifications](https://docs.aws.amazon.com/AmazonS3/latest/userguide/NotificationHowTo.html) – Trigger workflows that use Amazon Simple Notification Service (Amazon SNS), Amazon Simple Queue Service (Amazon SQS), and AWS Lambda when a change is made to your S3 resources.


[comment]: # (!!!)

### Hosting a static website

You can use Amazon S3 to host a static website and serve, individual webpages, static content, and client-side scripts.

- When you [configure a bucket as a static website](https://docs.aws.amazon.com/AmazonS3/latest/userguide/HostingWebsiteOnS3Setup.html), you must enable static website hosting, configure an index document, and set permissions.
- When you configure a bucket as a public static website, you need to [grant public read access](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteAccessPermissionsReqd.html). To make your bucket publicly readable, you must disable block public access settings for the bucket and write a bucket policy that grants public read access.
- You can also optionally configure an [error document](https://docs.aws.amazon.com/AmazonS3/latest/userguide/CustomErrorDocSupport.html), [web traffic logging](https://docs.aws.amazon.com/AmazonS3/latest/userguide/LoggingWebsiteTraffic.html), or a [redirect](https://docs.aws.amazon.com/AmazonS3/latest/userguide/how-to-page-redirect.html).


[comment]: # (!!!)

# Thanks

[comment]: # (!!! data-background-color="aquamarine")


