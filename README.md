# AWS_SolutionArchitect_Professional
#PATH TO AWS SOLUTION ARCHITECT
#### 1. AWS Solution Architect Associate (Associate Level)
#### 2. AWS SysOps Administrator Associate (Associate Level)
#### 3. AWS Solution Architect Procfessional (Professional Level)
#### 4. AWS Machine Learning (Speciality Level) 

### IDENTITY ACCESS MANAGEMENT 101 (INTRODUCTORY)

* IAM is Universal/Global. New Users have no permissions when created. 
* Users with AWS Management Console access can sign-in at: https://amitgoswami1027.signin.aws.amazon.com/console

### BILLING ALARM

### S3 OBJECT STORE ( READ S3 FAQs Before the Exam )
* S3 is object store. Safe place to store objects in cloud
* S3 has two models - 1. Read after write consistency for PUTS of new objects, 2.Eventual consistency - Override PUTS and Deletes. 
* S3 has tiered storage. Need to know details of different tiers. 
  * S3 STANDARD 
  * S3 - IA(Infrequently Accessed)
  * S3 One Zone - IA
  * S3 - Intelligent Tiering
  * S3 Glacier
  * S3 Glacier Deep Archieve
* Life cycle management and versioning.
* MFA for deleting the object.
* S3 changes on storage,request, cross region replication, transfer acceleration etc.

### S3 OBJECT STORE LAB
* Encryption in transit is achieved by SSL/TLS
* Encryption at rest (server side) is achieved by - S3 Managed Key- SSE-S3; AWS Key Managment Service - Managed Key- SSE-KMS and Customer Managed keys: SSE -C
* Client Side Encryption.

### S3 CROSS REGION REPLICATION
* Versioning much be enabled in both the source and destination
* Regions must be unique
* Files in existing buckets are not replicated automatically, all subsequently uploaded files will be replicated.
* Delete markers are not replicated.

### CLOUDFRONT (CDN)
* Edge Location - This is the location where content will be cached. This is seperate to AWS Region /AZ.
* ORIGIN - This is basically the source of all the files that CDN will distribute. This can be S3,EC2, elastic load balancer of Route53.
* Distribution (Name given to CDN which consist of collection of edge locations) can be web distribution or RTMP - Media Streaming distribution.
* Objects are cached to TTL (Time to Live)

### STORAGE GATEWAY
* Its is a service that connects on-premise software appliance with cloud based storage to provide seamless and secure integration
between organization on-premise IT environment and AWS storage infrastructure. 
* File Gateways, Volume Gateways- Cached volumes, Volume Gateways- Tape Volumes(VTL)

















