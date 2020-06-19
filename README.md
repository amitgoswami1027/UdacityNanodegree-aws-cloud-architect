## AWS CLOUD ARCHITECT - NanoDegree (MyNotes)

# Design For Availability,Reliability and Resiliency
* Availability: A measure of time that a system is operating as expected. Typically measured as a percentage.
* Reliability: A measure of how likely something is to be operating as expected at any given point in time. Said differently, 
  how often something fails.
* Resiliency: A measure of a system's recoverability. How quickly and easily a system can be brought back online.

#### BUSINESS STAKEHOLDERS: Most software platforms have Service Level Agreements (SLAs) that are critical to business stakeholders. All 
business functions tend to be concerned with a companies SLAs as they have wide-spread impact. The business both expects its vendors to 
meet their SLAs, and it is vital for a company to achieve its published SLAs in order to meet contractual obligations and support its 
customers.
### OUTLINE
![image](https://user-images.githubusercontent.com/13011167/84280300-be81c680-ab54-11ea-9fec-8f87cca533aa.png)
### 1. AZs AND REGIONS - HA Design
* AWS has around 22 Regions and 2-3 AZs in each Region.
* Highly available design is critical. Building for failover must be considered at every level of a system. Allowing for any 
individual component to fail and having a standby system able to take over is no small task, but HA design allows for platform 
systems to remain available regardless of any given server failing. 
* Most software platforms have Service Level Agreements (SLAs) that are critical to business stakeholders. All business functions tend to be concerned with a companies SLAs as they have wide-spread impact. The business both expects its vendors to meet their SLAs, and it is vital for a company to achieve its published SLAs in order to meet contractual obligations and support its customers.
* A Virtual Private Cloud (VPC) is a private network that you control within the larger AWS network. These private networks allow you to configure your network architecture the way you desire. A VPC is region specific. You decide if your VPCs connect to each other or if you keep them independent. If you connect your VPCs, it's up to you to configure them according to regular networking guidelines.
* IGW (Internet Gateway) is by default multi AZ, but NAT Gateway is AZ specific. DIFFERENCES: We can use advanced networking options in order to create a subnet so that resources in this subnet will be able to access the Internet, but will not be directly accessible from the Internet. This configuration allows you to put resources an additional layer deeper within your network. Security has a concept referred to as "defense in depth," which promotes multiple layers of defense such that a compromise of any one layer does not expose important assets. 

#### AWS networking does have some limitations that your own data center network would not.
* You cannot use multicast in a VPC
* You cannot put network cards into "promiscuous" mode to sniff ethernet packets.
* There are some restrictions on opening up ports for SMTP
* You cannot have network scans run against your account without discussing with AWS

#### You can connect VPCs together to enable:  
* Cross VPC connections
* Cross region connections
* Cross account connections

### 2. BUILDING RESILENCY
* INTUTION : You can build a system that is singular with no failover options, and you can build systems that are Multi-AZ, 
Multi-Region with automated lightning fast failover. It is up to you to first determine what level of redundancy is 
appropriate and then figure out how to build that system.When approaching a new product or service, you should consider how 
important the system will be. Will the existence of the company depend on it staying up, or is it just helping a team vote on 
lunch choices? Will it bring in 10 million dollars a month, or is it providing a service for free? Ultimately, there are 
tradeoffs that need to be considered, and understanding them is key to understanding how resilient to make a system.
#### A. SERVER-BASED SERVICES (Services that are existing applications that AWS provides as "managed services" and run on individual server instances.): Server bases services are those that are "instance" based. Services like RDS and ElastiCache are 
instanced based in that you can run one instance, but you will not have any fault tolerance.  In order to gain high 
availability, you need to tell the service to provision a second instance for the primary instance to failover to, should 
there be an issue with it. This model is similar to traditional data center environments. A good way to tell if a service is a 
server/instance based service is if the service is a pre-existing product that AWS has create a service with (MongoDB, Redis, 
MySQL, Postgres). To get Multi-AZ availability, you need to configure a Subnet Group within the service. A subnet is attached 
to an AZ, and creating a grouping of subnets within the service tells the service where it can place the primary and standby 
instances of a service.
* AZ REDUNDANCY: Subnet Groups are key to creating Multi-AZ redundancy in server-based services. Subnet Groups define the 
different availability zones that your service will run in, and having multiple instances allow for fast failover if a single 
AZ were to go down. Multi-Region redundancy is more tricky. Depending on the service, it is harder, or not possible to run a service with failover between regions.
* Most of the server based services have similar concepts for handling a hardware failover automatically. This functionality 
is the same that handles a single availability zone failure. By creating active/standby pairs of servers that replicate and by 
having each member of the pair in a different availability zone, you create the infrastructure that handles both of these 
failure mode.
* ElastiCache: ElastiCache is one of these services. You will create an ElastiCache cluster that does not have a single point 
of failure, and that can handle an AZ outage. First, create an ElastiCache subnet group in the default VPC using each available subnet and then create a multi-AZ redis cluster.
#### B. DynamoDB is a native AWS service for non-relational databases. It is Multi-AZ by default and can be made Multi-Region 
with DynamoDB Streams and by creating a Global DynamoDB table. DynamoDB scales to extremely high loads with very fast response 
times. It also supports configuring a caching layer in front of the database.DynamoDB Streams allow every change made to a 
DynamoDB table to be "streamed" into other services. These other services can then choose what actions to take on the 
different items or operations within the stream.
* DynamoDB Streams And Global Tables : DynamoDB Streams capture all changes made to a DynamoDB Table. This includes only 
actions that modify the table, not actions that only read from the table.
* DynamoDB Global Tables take advantage of DynamoDB Streams the create Multi-Region active/active DynamoDB Tables. This allows 
you to modify a table in multiple regions and have those changes reflected in all regions. 
* Multi-Region, active/active data stores are a big deal and extremely useful for use cases that require it.
#### C. S3 is one of the very first AWS services and is an object store. You create buckets and you can store an unlimited number of objects in a bucket.
* With S3 Events allow you to execute Lambda functions on the creation, updating or deleting of objects.
S3 Versioned Buckets keep all versions of an S3 object as you make changes to the object. You can even use this functionality 
to recover deleted objects.

### 3. BUSINESS OBJECTIVES: Business objectives are where the other business functions of your company meet with the Engineering 
function. These other areas of the company focus on signing customers, managing finances, supporting customers, advertising 
your products, etc. Where all of these teams meet is in the realm of contracts, commitments and uptime. This is where other 
parts of a business have to collaborate with Engineering in order to come up with common goals and common language.
#### A. UPTIME: Percentage of time system is up and running normally.
* Allowed downtime = (30 days 24 hours 60 minutes) - (30 days 24 hours 60 minutes * SLA percentage)
* 99% = 7.3 hours of allowed downtime per month
* 99.9% = 43.8 minutes of allowed downtime per month
* 99.99% = 4.38 Minutes of allowed downtime per month
* 99.999% = 26.3 sec of allowed downtime per month
#### B. DOWNTIME: Total time - UPTIME = DOWNTIME
#### C. Calculating Service Level Agreements -Calculating Availability
When drafting a Service Level Agreement (SLA) for your platform, there are many things to consider. You will need to ponder 
what you will need to implement in order to meet the SLA, and also understand what types of guarantees that you are providing 
to your customers that you will meet the SLA. Monetary compensation is common for SLA violations either in the form of service 
credits or outright refunds.
Often when considering what type of SLA a platform can provide, there is a tendency to forget to consider some of the components of the system. If the SLA isn't carefully considered, it can quickly become very difficult and expensive to meet.
Your company would like to offer a 99.9% SLA on your entire platform. Consider the following services that are required for your service to operate normally:
```
    Email service provider: 99.9%
    DNS provider: 99.99%
    Authentication service provider: 99.9%
    AWS services: 99.9%
    Twitter feed: 99%
```
Write an SLA for your platform that breaks down acceptable amounts of downtime for your application and for third-party services separately. Also, define periods of excused downtime and caveats for reduced functionality of non-critical components.
* ABC Company Hosted Applications
ABC Company shall provide general platform uptime of 99.9%. This shall exclude a regular maintenance window from 1am - 5am CST every Sunday, as well as windows from 1am - 5am on other days provided that ABC provides 24 hours of notice.
* ABC Company Critical Third-Party Components
Some components of our system are beyond our control, and thus, we can only pass through the provided SLA of these vendors. We only work with vendors who provide an SLA of 99.9% or better for all critical services.
* ABC Company Non-Critical Components
Those components deemed non-critical (listed below) are subject to a 95% uptime SLA. These components are not core to our offering, but provide certain "nice to have" functionality. In cases where these services are not available, our platform shall continue to operate and provide core functionality as normal.
#### RTO (Recovery Time Objective):Recover Time Objective (RTO) is the maximum time your platform or service can be 
unavailable. If your platform is offline from noon until 5:00pm and you have a 4 hour RTO, then you have failed to maintain 
your RTO.
When setting an RTO, be sure to consider the many items that go into meeting an RTO. What are the things that you will need to have in place to achieve your RTO? If your RTO is less than 72 hours, you will need to have folks available on the weekend to fix your system. If it is less than 8 hours, you will need people available in the middle of the night. Not only will you need people available at these off-hour times, but they will need to have a wide range of knowledge on your systems, access to the systems, and the trust of the company to make critical changes on their own.
* How to actually calculate the RTO
```
Recovery Time Objective (RTO)
    00:00 - Problem happens (0 minutes)
    00:05 - An amount of time passes before an alert triggers (5 minutes)
    00:06 - Alert triggers on-all staff (1 minute)
    00:16 - On-call staff may need to get out of bed, get to computer, log in, log onto VPN (10 minutes)
    00:26 - On-call staff starts diagnosing issue (10 minutes)
    00:41 - Root cause is discovered (15 minutes)
    00:46 - Remediation started (5 minutes)
    00:56 - Remediation completed (10 minutes)

Total time: 56 minutes
An RTO of one hour for this incident would be reasonable.
```
#### RPO (Recovery Point Objective): Recovery Point Objective (RPO) is the maximum amount of time that your system can lose 
data for. RPO is not tied to whether your system is available, it is a measure of the window of time that you may lose data 
in. If you take a database snapshot at midnight every day and you have a data corruption issue at 7:00am requiring you to 
restore from backup, you have a 7 hour RPO. It may take you until 8:00am to restore service, but as long as your data loss 
stops at 7:00am, that is when your RPO window closes.
* If your database goes down at 7:00pm and your application continues to run until 7:20pm but is failing to store the data it receives, and then the database is brought back online at 8:00pm, what was the RPO of the outage? Ans : 20 Minutes ???
* If your database goes down at 7:00pm and your application continues to run until 7:20pm but is failing to store the data it receives, and then the database is brought back online at 8:00pm, what was the RTO of the outage?Ans : 1hour ??

#### DISASTER RECOVERY : RTO and RPO numbers apply to localized outages, but when setting your RTO and RPO, you must take into 
account worst case scenarios. The term Disaster Recover is used to describe a more widespread failure. In AWS, if you normally 
run your services in one region, a large enough failure to make you move your system to another region would be a Disaster 
Recovery (DR) event.
Disaster Recovery usually involves the wholesale moving of your platform from one place to another. Outside of AWS, you might 
have to move to a backup data center. Inside AWS, you can move to a different region. Disaster recovery is not something you 
can do after an incident occurs to take down your primary region. If you have not prepared in advance, you will have no choice 
but to wait for that region to recover. To be prepared ahead of time, consider all of the things you will need to restart your 
platform in a new home. What saved state do you need, what application software, what configuration information. Even your 
documentation cannot live solely in your primary region. All of these things must be considered ahead of time and replicated 
to your DR region.
* AWS CloudFront is a content distribution network. It allows for edge location spread around the world to cache content so 
that the original source only needs to be consulted after a certain amount of time has expired. CloudFront is a global AWS 
service and has the ability to serve files from an S3 bucket. It also can be configured to have a primary bucket and a backup 
bucket in case the primary is not available.
* Create two S3 buckets in two different regions and then create a CloudFront distribution and create an Origin Group with both buckets and use that as the origin for the CloudFront distribution.

#### 4. MONITORING 
* AWS Services That Publish CloudWatch Metrics : https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-
cloudwatch-metrics.html

# DESIGN FOR PEROFRMANCE AND SCALIBILITY
#### Key Points
* Moving to the cloud doesn’t guarantee that your application will be faster and cost less to operate. In fact, without the 
  proper baseline metrics, you won’t know where to start when planning your move.
* Most performance issues can be traced to the application itself and some applications will need to be redesigned to be cloud 
  native in order to achieve truly optimized performance. Common causes of performance issues:
  * Poorly designed applications
  * Database design constraints
  * Inefficient network routes
* Moving to the cloud should improve network response times. Global edge cache locations can bring the server closer to the end user.

## OUTLINE
![image](https://user-images.githubusercontent.com/13011167/84561275-b0a48f00-ad68-11ea-8f80-35f421f74482.png)

#### Examples Of Cloud Migration Goals:
* We are migrating to the cloud to reduce our infrastructure costs by 25%
* We believe that by hosting our application in AWS, we will be able to deliver download speeds that are 60% faster than our 
baseline.
* We are going to duplicate our infrastructure in the cloud and maintain our AWS account as a warm backup site for disaster 
recovery
* We are consolidating our data centers and moving to the cloud because our AWS account will provide one centralized view into 
our environment with more visibility into how our compute spend is being utilized.

## A. COST AND MONITORING
### How the AWS Cost Structure Works : Three Ways to Calculate AWS Costs
* Simple Monthly Calculator - allows you to explore AWS services, model solutions, and create estimates for the cost of your use cases on AWS 
* TCO Calculator - used to compare the cost of running your applications in an on-premises or colocation environment to AWS 
* AWS Pricing Calculator (NEW- replaces the Simple Monthly Calculator) 
* AWS PRICING CAL: https://docs.aws.amazon.com/pricing-calculator/latest/userguide/what-is-pricing-calculator.html
* https://calculator.aws/#/
* VPC PEERING : https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html

An accurate cost estimation that meets and exceeds your organization’s budgetary goals requires you to ask important questions, interpret data, and implement AWS best practices

#### Paid AWS Cloud Services include:
* Running Compute Resources
* Storage
* Provisioned Databases
* Data Transfer

Remember, you only pay for services you use, and once you stop using them, AWS stops charging you immediately and doesn’t levy any termination fees. 

### AWS does not charge for:
* AWS Elastic Beanstalk - Rapid application deployment
* AWS Cloud Formation - AWS Branded Infrastructure as Code service
* Auto-Scaling - Scaling EC2 instances up/down or in/out based on your application requirements
* AWS IAM - User and access management

There is no cost for uploading data into the AWS cloud, although you will pay for storage and data transfer back out. Because of the massive scale of the AWS technology platform, there is no limit to how much data you can upload. 

![image](https://user-images.githubusercontent.com/13011167/84426533-03832700-ac41-11ea-8c66-016f21a91c33.png)

### Tips for Reducing Costs
* Use AWS CloudFront to cache data close to end users
* Avoid inter-region data transfer costs
* Peering via AWS Transit Gateway for VPCs reduces costs

![image](https://user-images.githubusercontent.com/13011167/84577111-0b74cf80-add7-11ea-9804-da6022ee1b7a.png)

### INSTANCE PRICING (EC2)
AWS EC2 instance pricing is straightforward, but it can quickly become complex when you take up the task of optimizing your environment to achieve the ideal cost/performance balance.
* Explore OS licensing pricing and options
* Limit the users and roles that can launch production instances
* Choose the best instance for your workload
* Save by moving to new generation instances when available
* When optimizing your computing usage to reduce your monthly spend, one of the first places you want to count your costs is 
in your EC2 instances, and one of the best resources here is using reserved instances. 
![image](https://user-images.githubusercontent.com/13011167/84577161-7b835580-add7-11ea-90b1-04c85982e089.png)
#### Reserved and Spot Instances
* Reserved instances offer a savings of almost 70% in some cases. In exchange for an upfront commitment of 1 or 3 years, AWS 
offers significant savings, which increases a bit depending on how you choose to pay. Paying in advance will save you even 
more.
* Spot instances can potentially save customers 90% of AWS on-demand EC2 instance pricing, but there are some significant 
drawbacks. AWS can terminate a spot instance that is running below the current spot call price at any time after providing you 
with a 2-minute warning.

### STORAGE OPTIONs
Selecting the right storage is the key to both satisfied customers and high-performing databases. In general you should select storage based on the following criteria:
#### SSD Solid State Drives
* Use flash memory to deliver superior performance and durability without moving parts
* More durable, run cooler and use less energy
* Best for i/o intensive applications and database services and boot volumes
#### HDD Hard Disk Drives
* Proven technology
* Typically less expensive than solid state drives for the same amount of storage
* Available with more storage space than SSDs
* Best for throughput intensive workloads like big data analysis and log processing

#### The best storage type for a throughput intensive big-data workload: Throughput optimized HDD.
#### Create a Lifecycle Policy
Your company provides media storage for people who are almost famous on the internet. They upload photos and videos daily which receive hundreds of initial views, but not many users view them after a few days. The service you provide is free, and your not-quite famous customers understand you will delete their files in 180 days.

Design and implement a cost effective lifecycle policy for this scenario.
My Solution: Your solution might be different, but here is what I came up with:
* Store the media files in S3 standard for 30 days, then move files to S3 IA
* Store the media files in S3 IA for 60 days, then move to S3 Glacier and pay AWS for provisioned expedited retrieval if 
necessary
* Store the media in S3 Glacier for the remainder of the 180 days, then delete per the lifecycle policy

## B. PERFORMANCE IN CLOUD
* Moving your applications to the cloud doesn’t guarantee that your performance issues will automatically be resolved, 
  especially if you lift and shift.
  
#### Infrastructure Performance in the Cloud

![image](https://user-images.githubusercontent.com/13011167/84309264-7aef8280-ab7d-11ea-917f-18ac3fbec396.png)

* Burstable Performance Instance: T3, T3a, and T2 instances, are designed to provide a baseline level of CPU performance with the ability to burst to a higher level when required by your workload.AWS burstable instances are T2 and T3 instance types
* Optimized Instances: Instance types optimized to fit different use cases. Instance types comprise varying combinations of CPU, memory, storage, GPU, and networking capacity and give you the flexibility to choose the appropriate mix of resources for your applications.

![image](https://user-images.githubusercontent.com/13011167/84309456-c4d86880-ab7d-11ea-80e7-e69228b78711.png)

#### Scaling and performance 
![image](https://user-images.githubusercontent.com/13011167/84432156-0e8e8500-ac4a-11ea-9b05-2d5e770d52ce.png)

* Accelerated Computing Instance Families: Use hardware accelerators, or co-processors, to perform some functions, such as floating point number calculations, graphics processing, or data pattern matching, more efficiently than is possible in software running on CPUs.
* F1, P2, P3 , G3 and G4 instances provide extremely accelerated computing instances for supercoming resources like scientific image moduling. G4 instances well-suited for machine learning inference, video transcoding, and graphics applications like remote graphics workstations and game streaming in the cloud
* C4 and C5 are compute optimized instances like high preformance computing and scentific modeling.
* t2 and T3 are bustable instances that are unique in there ability on there baseline CPU resources. Tracking CPU credits when the instances running below capacity.
* R4 qand R5 are memory optimized instances, like high perofrmance Databases.
* D2 instances are memory optimized instances.
* Inf1, optimized for the machine learning models.
* AWS optimized instances can provide higher throughput for intensive workloads.

### Sotrage and servicves
![image](https://user-images.githubusercontent.com/13011167/84433742-6af2a400-ac4c-11ea-88a0-4ef9e3234a22.png)

#### EBS & EFS
Amazon EBS or Elastic Block Storage is provisioned capacity and performance
* Pay for the EBS storage even if it is unattached or has very low read/write activity.One of the - Need to audit your 
environment to detect and delete obsolete EBS volumes and adjust the size of your provisioned storage to match your actual 
use.
* EBS volumes attached to EBS optimized instances can be accessed using dedicated networks for better throughput
* Non-EBS optimized instances share the network with all the rest of the local traffic

Amazon EFS or Elastic File Storage has optimization built into the service
* Distributed to make it highly available, durable, and scalable.
* Can be mounted on up to thousands of Amazon EC2 instances concurrently
* Supports encryption in transit and encryption at rest with a minimal effect on I/O latency and throughput
* Amazon Elastic File System is a scalable NFS file system that grows and shrinks elastically as you add and remove files. 
There is no need to provision EFS storage, and you only pay for what you use.
* AWS EFS files can be automatically moved to a lower infrequently accessed tier (EFS-IA) after they haven’t been accessed for 
a certain period of time.
* EFS supports any number of concurrent EC2 instance connections. Thousands of connections is not uncommon.

#### EBS - ELASTIC BLOCK STORAGE
* EBS volumes are highly durable block storage hard drives that can either be created independently on the EBS management page or created with a new EC2 instance
* EBS volumes can be attached to and detached from instances and can be used just like any other hard drive- you can run databases, create file systems, and move them between instances
* EBS volumes are provisioned storage, so costs are incurred whether it is attached to an EC2 instance or not. Be mindful of idle EBS volumes and make sure they are necessary before you maintain unused volumes for long periods of time.
* EBS snapshots are point-in-time backups of EBS volumes saved to S3 and serve as a lower cost alternative to maintaining idle EBS volumes
* AWS EBS provides SSD or HDD volumes. SSD are for low latency/high performance applications like databases and HDD are for high throughput applications like big data workloads and infrequently accessed files in cold storage.
* Costs with EBS HDD are considerably lower than EBS SSD

![image](https://user-images.githubusercontent.com/13011167/84434646-118b7480-ac4e-11ea-99d8-1ddb505b1673.png)

## C. INFRASTRUCTURE AS A CODE (IAC)
Infrastructure as code is auditable and repeatable, which is perfect for large cloud implementations under the management of Cloud 
Governance where starting over for every new project or lifecycle is a tedious manual job with the potential for errors and compliance 
deviations.
#### Key Points
* Infrastructure as code is also sometimes referred to as software defined infrastructure.
* AWS CloudFormation makes it easy to use programming languages or even a text file to securely model and provision the resources you 
  need to run your application.
* One potential drawback of opting for AWS CloudFormation is that it effectively locks you into AWS as a cloud provider, unless you want 
  to start over.
#### What is Terraform?
* Terraform is an Open source Infrastructure as code software tool.
* Terraform code is written in Hashicorp configuration language or HCL, a structured configuration language that is human and machine   
  readable for use at the command line.
* Terraform is cloud neutral, meaning the APIs it provides do not lock the user to any one particular cloud provider.
* Learning about Infrastructure as Code and Terraform is a great step toward advancing your career in cloud architecture.
#### Getting Started With Terraform
* Download Terraform : https://www.terraform.io/downloads.html
* In order to authenticate Terraform to your AWS account, you need to set the AWS credentials for the IAM user you are using for the   
  course.

## D. SERVERLESS COMPUTING
### CLOUD MIGRATION 
#### Lift and Shift	The process of moving your application from an on-premises environment to the cloud without making any major changes to the code.
#### Cloud Native	An app that has been engineered specifically to use cloud services and infrastructure
#### Key Points
* Lift and Shift is the simple process of moving your application from an on-premises environment to the cloud without making any 
  significant changes to the code. AWS Server migration can assist with this process.
* Lift and Shift migrations don’t have many options for performance improvements other than to allocate additional resources where 
  bottlenecks are observed. This exposes the company to the potential for excessive compute costs.
* Not all applications aren’t good candidates for cloud-native redesign, but a redesign can advantage of cloud services like optimized 
  instances and AWS RDS to produce improved performance
* The best candidates for cloud native redesign are lightweight applications whose functions can be driven by events like API calls, 
  file uploads, database updates, and messages being added to a queue.
  ![image](https://user-images.githubusercontent.com/13011167/84561814-30ccf380-ad6d-11ea-95bd-12b822dda558.png)

### SERVERLESS COST
* Lambda requests are billed based on : number of requests/function invocations and duration of compute time and allocated memory
* Duration is billed per 100ms. Lambda works better for small scale apps
* EC2 works better for long-running functions
* Lambda functions are stateless and run in short-lived containers. There is a "cold-start" delay after a period of inactivity but that 
  can be avoided by using a keep warm service
* Serverless can also bring cost savings because fewer people are needed for operations support
* When to Use Lambda: AWS Lambda is optimal for applications with irregular usage patterns and lulls between spikes in activity
* AWS Lambda is not a good choice for applications with regular, consistent, or steady workloads and long running functions. It might 
  end up being more costly than EC2 instances.Consider the considerable cost of re-architecting an application when deciding if AWS 
  Lambda is a good choice. It might be!
* Cold Start	The delayed response that occurs when a new labda instance receives its first request.
* Keep Warm	A periodic ping or function call to lambdas to keep them on in order to avoid the delay of cold starts
* https://dashbird.io/lambda-cost-calculator/

#### AWS Lambda Calculator: https://s3.amazonaws.com/lambda-tools/pricing-calculator.html
#### AWS EC2 PRICING: https://aws.amazon.com/ec2/pricing/on-demand/
#### EC2 RESERVED INSTANCE: https://aws.amazon.com/ec2/pricing/reserved-instances/pricing/
![image](https://user-images.githubusercontent.com/13011167/84564983-975d0c00-ad83-11ea-9ea7-6b96e3a694c2.png)


# DESIGN FOR SECURITY
![image](https://user-images.githubusercontent.com/13011167/84625561-1d529180-af01-11ea-8e26-a1efd02fef42.png)

## 1. SECURING ACCESS TO CLOUD RESOURCES
#### Securing Access
* Identity and Access Management in the cloud is the cornerstone of a secure environment.
* Securing access to the control plane will determine security on a network, data, and resource consumption level.

#### A COMMON USE CASE
Imagine a situation where keys in a config file or code were accidently pushed to a repository which is viewable by unauthorized parties, such as a public GitbHub repo. Or, imagine a situation where a user's laptop or server were compromised and keys were stolen. This could be disastrous depending on how users are given access to information and services.

A much better alternative to managing sensitive keys all together is to provide access using Identity Access Management (IAM) roles. The key benefit to IAM roles is that all credentials are temporary once assumed and there is no need to store API keys permanently.
#### ASSUMING ROLE :
* Applications running on containers and servers can simply assume roles which are assigned to the server infrastructure 
  without the need to handle API keys within code or config files.
* Additionally, IAM roles can be used to provide access to a multi AWS account structure without the need for managing users 
  across many accounts - which is a common challenge.
* Another benefit is that IAM roles pave the way for devising an elevated privilege model or complete identity federation. 
  This removes the risk associated with managing users and identities in AWS.
* Identity federation involves trusting a centralized identity provider that your organization is using to effectively shift   
  user management and authorization from your AWS account to the identity provider.
![image](https://user-images.githubusercontent.com/13011167/84625672-64408700-af01-11ea-8b8c-71f47feab4a1.png)

#### IAM Roles for Applications
* Applications running on instances or containers should use instance profile roles and not user api keys.
* Instance profile role is a special role that is assigned to EC2 instances which allow applications running on those 
instances to obtain temporary credentials aligned with that role.

#### IAM Roles for Users
* All users should be using multi-factor authentication (MFA) protected role escalation or identity federation.

![image](https://user-images.githubusercontent.com/13011167/84627645-e41c2080-af04-11ea-9c72-7b115eba1568.png)

![image](https://user-images.githubusercontent.com/13011167/84628050-98b64200-af05-11ea-882e-465cc29d9c44.png)

### Identity Federation for Controlling User Access
* Using IAM roles is more secure than provisioning IAM users and managing API keys.
* Identity federation allows an organization to manage identities using an external identity provider instead of attempting to 
  provision and manage user identities from within the AWS environment.
* If a mobile or web application requires access to the AWS API, the user of that application can authenticate with a web 
  identity provider such as facebook, google, or amazon to obtain temporary API credentials.
* Identity Federation - Identity Federation enables you to manage access to your AWS resources centrally. With federation, you 
  can use single sign-on (SSO) to access your AWS accounts using credentials from your corporate directory. Federation uses 
  open standards, such as Security Assertion Markup Language 2.0 (SAML), to exchange identity and security information between 
  an identity provider (IdP) and an application.
* External Identity Providers-An identity provider external to your AWS accounts. Examples include corporate ADFS, cloud-based 
 identity-as-a-service provider, or web identity provider, such as Google or Facebook.
* Identity providers such as ADFS and cloud identity providers use open standards such as SAML 2.0. Web identity providers 
  such as Google or Facebook comply with OpenID Connect. Both SAML 2.0 and OpenID Connect allow the exchange of identity 
  information between the Identity Provider (IdP) and AWS.

#### Examples of External Identity Providers
 * SAML 2.0 Identity Providers
   * Corporate active directory
   * Cloud-based identity providers such as Okta, OneLogin, Ping, Centrify, AWS SSO, etc.
 * Web Identity Providers
   * Facebook, Google, Amazon, etc.

Identity providers can provide role based access control mapped to IAM roles and AWS accounts.

#### Two Primary Security Benefits of Incorporating Identity Federation
* Organizations can centrally manage users, their identities and authentication, and their various roles with respect to 
access to various applications and platforms. This will allow onboarding and offboarding of an employee's access to entities 
such as AWS seamless and compliant with an organizations approval and off boarding processes. An example of this would be an 
employee that has access to multiple AWS accounts, Azure, windows servers, corporate VPN etc, If the employee leaves the 
organization, this access can be revoke centrally.
* Identity federation removes the need to use AWS IAM users and user api keys. Access to the API is then always dependent on 
IAM roles via federation.

![image](https://user-images.githubusercontent.com/13011167/84633811-94425700-af0e-11ea-8e9a-d571d77fe8d8.png)

* SAML 2.0 IDENTITY Federation: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_saml.html
* Web Identify Fedration: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_oidc.html

#### Least Privilege Access - Granting a user or application only the permissions they need to do the required task.
* When creating IAM policies that provide permissions to users and roles, we want to follow the common security practice of 
  granting least privilege. Least Privilege means we grant only the permissions required to perform the necessary tasks.
* For that reason it is critical to fine-tune IAM policies to restrict and limit, at minimum:
  * What Can be Done (Actions)
  * To What (Resources)
  * By Who (Principals, Trust Policies)
In the below example, we have an IAM policy that allows specific actions and limits those actions to a specific resource - in this case, the recipes table.
```
      {
            "Sid": "DDBTableAccessLeastPrivilege",
            "Effect": "Allow",
            "Action": [
                "dynamodb:BatchGet*",
                "dynamodb:DescribeStream",
                "dynamodb:DescribeTable",
                "dynamodb:Get*",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:BatchWrite*",
                "dynamodb:Delete*",
                "dynamodb:Update*",
                "dynamodb:PutItem"
            ],
            "Resource": "arn:aws:dynamodb:*:*:table/recipes"
        }

```

## 2. Securing Access to Cloud Infrastructure
![image](https://user-images.githubusercontent.com/13011167/84639169-a4116980-af15-11ea-8082-0b9df629684e.png)
### When designing and deploying cloud networks and infrastructure there are a few key questions to be asking related to security controls:
* Which trusted networks will traffic to your cloud environment originate from?
* Which components in your environment will need network connectivity to other components?
* Are security groups and network ACLs as specific as possible?
* Which components will be taking traffic from the internet?
* How is access to servers managed?
* Have outbound traffic needs been identified?

### Techniques to Provide Secure Access to Servers
#### Deploy Immutable Instances
* Prevent unauthorized access through deploying servers as immutable components.
* Immutable instances are launched from virtual machine images that are created in a private environment. The images have 
  ideally gone through security patching and hardening, custom configuration, application code deployment, and vulnerability 
  scanning.
* When it’s time to update the application, a new image is created and deployed and the old instance is then deprovisioned.
* During this cycle no individual ever needs to login to the instance.
* This is a huge step in the right direction in protecting instances from security breaches and unauthorized access.
![image](https://user-images.githubusercontent.com/13011167/84762969-1f901b00-afe9-11ea-9d02-c699df4c71fd.png)

#### Configuration Management Tools
Use a configuration management tool to enforce hardening and configuration policies. Even in the event that someone deployed 
an instance with insecure configuration, the configuration management tool would override this by applying the correct 
configuration. Some popular tools with this regard are ansible, chef and puppet.
![image](https://user-images.githubusercontent.com/13011167/84763156-641bb680-afe9-11ea-9181-9035e39d0bc9.png)

#### Privileged Access Management Tools
The use of a Privileged Access Management (PAM) tool can provide additional benefits such as:
* time based or temporary access to elevated privileges
* granular privilege management
* session recording and audit trails
* password and secrets management
* multi factor authentication

#### CONTROL TRAFFIC - INGRESS AND EGRESS
* Ingress can be required to access services and resources that are running in our cloud environment. In-bound network traffic 
  that is entering your cloud environment from the outside.
* We also need to be able to access the internet or other external networks for our applications to be able to function. Out-
  bound network traffic that is leaving your cloud environment.
* Ingress traffic can be controlled and restricted using network ACLs, security groups, which are both effective firewalls, 
  routing rules, and host based endpoint security tools which oftentimes contain firewall capabilities.
* In addition to the configuration of ACLs and security groups, private access to VPC networks is also required, either from 
  user work locations or from corporate-owned network spaces.
* Egress traffic in AWS is generally handled using internet gateways and nat gateways. As with ingress traffic, egress traffic 
  should also be controlled and restricted for a number of reasons.

#### Egress Control - Using NACLs and security groups to restrict internet bound traffic to specific entities is not the best 
approach.
* AWS provides a few different conduits for connecting to internet sites from our VPC subnets:
  * Resources deployed in a subnet can be assigned to public IP addresses and will have internet bound traffic routed through 
    an "internet gateway".
  * A NAT instance or NAT gateway can be deployed in public subnets so that instances in other subnets can use this device to 
    gain access to the internet.
* From a security perspective, it is not practical to deploy all application resources that require internet connectivity into 
  a public subnet. This widens the attack surface and leaves the environment open to exploitation.
* To solve this, a device such as the NAT gateway is the most common solution.
* The shortfall with the NAT gateway solution from a security perspective is that it is difficult to monitor and restrict 
  traffic at the application layer to specific domains and sites. 

#### Securing Egress Traffic
* Set Up a Web Proxy Layer: This is the simplest way to log application internet traffic. Proxies can also be used to restrict 
  traffic to allowed sites. There are a few drawbacks:
  * Additional Configuration: applications and instances that require internet access will need to be configured to make use 
    of an http proxy.
  * The proxy farm itself will need to be configured, managed and maintained.
* In-Line Gateway Appliance: These appliances generally come from commercial vendors and provide a range of capabilities for 
  controlling and inspecting outbound traffic out of the box. Cost is the biggest barrier to this approach.
* Host-Based IDS: A host-based IDS is an agent based solution that runs on each instance. Providing many of the capabilities 
  that the in-line gateway appliance provides including egress control and data loss prevention, intrusion detection and 
  prevention. The biggest disadvantage is enforcing that all hosts in your environment have the agent running.
* EGRESS CONTROL : https://aws.amazon.com/answers/networking/controlling-vpc-egress-traffic/

 #### Access to Cloud Networks - Methods for Establishing Network Access to Resources Running in your Cloud Environments:
 * Bastion Hosts: Bastion hosts, or jump hosts, are set up in a public subnet to allow a user to login from either their home 
   or office network, and subsequently access or jump to resources in private networks.
   * Pros: It is a simple and low cost method for getting onto your cloud VPC.
   * Cons: It needs additional effort to harden the bastion host. It is not scalable for many users, and may not work if 
     client applications need to be on the user's laptop or desktop. It is a common target for attackers who hope to gain 
     access to the network by exploiting a vulnerability on the bastion host.
     ![image](https://user-images.githubusercontent.com/13011167/84803584-d0b1a800-b01f-11ea-986b-c304823136f1.png)
* Virtual Desktop Solution: Similar to a bastion host, except that each user will get their own virtual bastion.
  * Pros: It allows users to install their desktop application clients in the cloud environment without having connectivity to 
    the VPC from their local laptop
  * Cons: It costs more than a bastion host. Users will not have direct connectivity to any backend services in the VPC.
    ![image](https://user-images.githubusercontent.com/13011167/84804374-4ddd1d00-b020-11ea-9e0f-7a8b4f8d07ac.png)
* Client VPN: A client VPN solution allows a user to connect to the cloud VPC using a secure VPN client to establish an 
  encrypted tunnel.
  * Pros: Easy to set up. It has the ability to manage many users and roles. It places the user into the VPC so that they may 
    use client applications on their local host to hit the resources deployed in the VPC.
  * Cons: It has additional cost as compared to a bastion host. Users may need to install proprietary VPN clients on their 
    local machines.
    ![image](https://user-images.githubusercontent.com/13011167/84804504-7fee7f00-b020-11ea-82c7-77e3adb592b6.png)
* Site-to Site-VPN: We can connect a local trusted network's firewall with the AWS VPN service to establish VPN tunnel 
  connectivity from the entire local network to the AWS VPC network.
  * Pros: No need to install any VPN client software on each user's local machine.
  * Cons: Additional routing and configuration needs to be performed on the local network. It often leads to delays in setup. 
    No role based routing.
    ![image](https://user-images.githubusercontent.com/13011167/84804645-b2987780-b020-11ea-926f-648e457c45ae.png)
* Direct Connect Link: A dedicated link from a corporate office network or co-location datacenter.
  * Pros: Dedicated bandwidth. It is ideal for hybrid cloud environments.
  * Cons: Higher costs and require more time to set up. Once set up, if users are not on the corporate LAN, a solution such as 
    VPN or VDI will still need to be implemented. Generally, it is not an option for small or virtual teams that do not have a      
    LAN to work out of.
    ![image](https://user-images.githubusercontent.com/13011167/84804787-e6739d00-b020-11ea-90a7-79ba9689c0e9.png)

## 3. Protecting Data Stored in the Cloud
Our goal was to minimize the risk of a malicious actor being able to access our networks and servers, invoke the AWS API, and, ultimately, perform destructive or unauthorized actions in our environments.

It is crucial that the data that we are storing in the cloud is encrypted and that the encryption keys are correctly managed! In the event that there were to be a vulnerability to our network or AWS account settings, we want to reduce the risk of data being readable by an unauthorized party.
![image](https://user-images.githubusercontent.com/13011167/84806088-cba22800-b022-11ea-97b4-2138b2daca94.png)

### DATA ENCRYPTION
#### S3 Bucket Encryption
![image](https://user-images.githubusercontent.com/13011167/85027898-11ccc800-b198-11ea-81a9-ef6c044ae64b.png)

#### S3 Bucket Server-Side Encryption: S3 buckets provisioned in AWS support a few different methods of ensuring your data is encrypted when physically being stored on disk. 
* S3-Managed Keys : With this simple option, we can specify that any object written to S3 will be encrypted by S3 and the S3 
service will manage the encryption keys behind the scenes. It is important to keep in mind that with this option anyone with 
read access permissions to the bucket and file. Anyone with read permission will be able to make calls to the service to 
retrieve the file unencrypted.
* AWS-Managed Master Keys: In this option, the caller will need to specify that KMS will manage encryption keys for the S3 
service. This provides additional auditability of S3's use of the encryption keys.
* Customer-Managed Master Keys: Again, the caller will need to specify that KMS will manage encryption keys for the S3 
service. The caller will also need to specify the key that will be used for encryption. Additionally, the caller needs to have 
permissions to use the key. This provides additional ability to control and restrict which principals can access or decrypt 
sensitive dat
* Customer-Provided Keys:In this case, the customer can provide encryption keys to S3. S3 will perform the encryption on the 
server without keeping the key itself. The key would then be provided with the request to decrypt the object. With this option 
the burden of managing the key falls on the customer.

Server-side encryption for AWS services is a very powerful and transparent way to ensure that security best practices are 
implemented. We have highlighted this with S3, however, other AWS services, for example DynamoDB, also provide this 
functionality.

#### AWS KEY MANAGEMENT SERVICE (KMS)
#### 1. AWS-Managed Customer Master Keys: (This approach is acceptable if the sole requirement is to ensure that data is encrypted at rest in AWS' data centers). The key is provisioned automatically by KMS when a service such as S3 or EC2 needs   
  to use KMS to encrypt underlying data. A separate master key would be created for each service that starts using 
  KMS.Permissions to AWS managed keys are also handled behind the scenes. Any principal or user who has access to a particular 
  service would inherently have access to any encrypted data that the service had encrypted using the AWS managed keys. This 
  approach is acceptable if the sole requirement is to ensure that data is encrypted at rest in AWS' data centers.
* Using an example of a DynamoDB table that has encryption using AWS managed keys, all users or roles in the account that have 
  read access to the dynamodb table would be able to read data from the table.
* Limitations With AWS Managed CMKs: The main drawback here is that it does not allow granular and least privileged access to 
  the keys. It would not be possible to segment and isolate permissions to certain keys and encrypted data. In addition to 
  this limitation, AWS managed keys are not available for applications to use for client-side encryption since they are only 
  available for use by AWS services.
* This approach is also not recommended for accounts where sensitive data is present since in the event of the AWS account or 
  role compromised for some reason, encrypted data may not be protected.
  ![image](https://user-images.githubusercontent.com/13011167/85032029-f912e100-b19c-11ea-892d-b30d7ccb1880.png)

#### 2. Customer-Managed Customer Master Keys: (The main benefit to this approach is that permissions to manage and use the keys can be explicitly defined and controlled. This allows separation of duties, segmentation of key usage etc.)  The second option is to explicitly provision the keys using KMS. In this case 
   the user creates and manages permissions to the keys. The main benefit to this approach is that permissions to manage and  
   use the keys can be explicitly defined and controlled. This allows separation of duties, segmentation of key usage etc. 
* Again using DynamoDB as an example, we can have much more flexibility to restrict access to data by restricting access to 
  encryption keys. For example we can have 2 separate master keys, for two different sets of tables or data classifications, 
  for example non-sensitive and sensitive tables. We can also assign certain IAM roles to be able to use the keys, and other 
  IAM roles to be able to manage the keys.
* This second approach is a good balance between manageability and security, and it will generally provide the capabilities 
  mandated by most compliance standards.
* KMS also provides the ability for the user to create master key material outside of AWS and import it into KMS.

#### 3. Bring Your Own Key: When new customer master keys are provisioned in KMS, by default, KMS creates and maintains the 
key material for you. However, KMS also provides the customer the option of importing their own key material which may be 
maintained in a key store external to KMS. With this option the customer has full control of the key's lifecycle including 
expiration, deletion, and rotation.

A potential use case for importing key material may be to maintain backup copies of the key material external to AWS to 
fulfill disaster recovery requirements. Customers may also find this option useful if they have a desire to use one key 
management system for cloud and on-premise infrastructure.

### Best Practices for Securing S3: The importance of ensuring that S3 buckets are configured securely can not be understated! The vast majority of cloud data breaches in the last few years were of private data being leaked from S3 buckets.
Some best practices for Securing S3 include:
* Use Object Versioning: This makes it difficult for infiltrators to corrupt or delete data.
* Block Public Access: This lessens the attack surface.
* Use VPC Endpoints: This allows you to block requests that do not originate from your VPC network.
* Create S3 Bucket Policies: Use policies to restrict and control access.
![image](https://user-images.githubusercontent.com/13011167/85141751-e663df00-b264-11ea-806c-34d5fe5959d5.png)

## 4. Defensive Security in the Cloud
![image](https://user-images.githubusercontent.com/13011167/85145571-60e32d80-b26a-11ea-945b-592c0001ca35.png)

By the end of the lesson you will have a better understanding of:
* How to identify misconfigurations that can lead to vulnerabilities.
* How to identify and guard against malicious activity.
* How to design a deployment pipeline that ensures that security practices are implemented early on.

#### Common Threat Vectors : Let's get a better feel for the common threat vectors that affect cloud environments. I have categorized these into external threats and internal threats.
#### External Threats: Let us look at the attack surface of a cloud environment from the perspective of an actor who is on the 
internet and does not have access to the private network space of our cloud environment.
* Public Facing Web Applications: Attackers will attempt to exploit application related vulnerabilities such as those found in 
the OWASP top 10. Cloud architects and engineers designing cloud environments need to ensure that any external web 
applications are defended appropriately. Teams should also perform security and penetration testing on applications to reduce 
risks prior to deployment.

![image](https://user-images.githubusercontent.com/13011167/85148424-c08f0800-b26d-11ea-9432-d3fdb4aa0283.png)
* Public Facing Server Infrastructure: Aside from web applications, any other server infrastructure such as bastion hosts, 
databases, etc are prime targets for attackers. Any resources, such as these, need to have additional hardening and isolation 
from other internal resources that host sensitive data. At a high level, the use of these types of resources and exposing them 
to the internet should be avoided, limited, and restricted.
* The AWS API and Console: Due to the inherent nature of the public cloud being public, access to the AWS API for managing 
cloud services is public facing. If this access is compromised, an attacker could gain control of your environment and start 
managing your resources from anywhere!
![image](https://user-images.githubusercontent.com/13011167/85149155-968a1580-b26e-11ea-841f-39824de6ec13.png)

#### Internal Threats: Although it is important to defend our external public facing perimeter, it is equally important to 
assume those same threats can potentially exist within the private network. Internal attackers may also have gained access to 
instances and hosts running in the cloud and will attempt to install and run malware or access data on cloud instances.

The threat is compounded if an attacker or a piece of malicious software has gained network access to other private networks 
that are connected to your cloud environment. To prevent this, it is critical that cloud hosts are hardened and set up to 
restrict access even if they are not public facing. The AWS API can also become a target if attackers gain access to internal 
code repositories that mistakenly hold API keys and other secrets.
* Identifying Threats and Vulnerabilities: The goal of this entire course is to design cloud architectures so that the 
likelihood of any of these types of attacks, both external and internal, are reduced or eliminated.
* OWASP Top 10: A widely accepted set of vulnerabilities which can lead to exploitation of web applications.

![image](https://user-images.githubusercontent.com/13011167/85149994-9b02fe00-b26f-11ea-980f-8c24984b7052.png)

#### Checking Infrastructure as Code for Vulnerabilities
![image](https://user-images.githubusercontent.com/13011167/85154750-7873e380-b275-11ea-9e30-f79daf0ae61b.png)
![image](https://user-images.githubusercontent.com/13011167/85154616-4cf0f900-b275-11ea-88df-b6243c28eb1f.png)

### Identifying Vulnerabilities: Monitoring for Vulnerabilities and Misconfigurations in AWS
* AWS Config: AWS Config collects configuration snapshots of many of the core infrastructure services that AWS provides. When 
Config is enabled, you will have insight into how a particular resource is configured, when it changed, and what was changed.
The configuration snapshot serves as an input to rules which evaluate whether the configuration is in compliance or out of 
compliance with the conditions specified in the rule. It is strongly recommended to setup AWS Config rules for any security or 
compliance requirements that your organization has.
* Security HUB is a service within AWS which aggregates findings from other security tools into a single pane of glass. 
Security monitoring services such as AWS Config, Inspector, GuardDuty, and many open source and commercial tools integrate 
findings with Security Hub.
![image](https://user-images.githubusercontent.com/13011167/85160911-ac9ed280-b27c-11ea-96c0-49cf40e20e1f.png)
* AWS Inspector: AWS inspector is intended to specifically analyze and report on vulnerabilities on EC2 instances. AWS 
Inspector is designed to identify vulnerabilities at the OS level.Inspector can also provide a report on network reachability 
the public internet to instances and load balancers along with specific ports that are reachable.Once the inspector agent is installed on an instance, it can scan against:
   * CIS benchmarks for linux and windows
   * AWS security best practices
   * Common vulnerabilities and exposures or CVE findings

#### Security Information and Event Monitoring Sources in AWS
* CloudTrail: AWS CloudTrail is the source of activity logging within an AWS account. Any API activity, console usage, cross 
account access etc will be recorded in CloudTrail. CloudTrail will log all activity and allow you to search these logs for 90 
days.
   * However it is highly recommended to configure CloudTrail logs in all accounts and all regions to be written to S3 
     buckets, preferably a central S3 bucket in a dedicated security account. These logs can then be examined later or 
     ingested by a log analysis or SIEM tool.
   * CloudTrail is by far the most valuable tool to monitor and audit activity in your AWS account. 
* VPC Flow Logs: When VPC flow logs provide insight into network activity including:
    * Connection attempts or rejects, allows or denies
    * Source and destination IPs, ports
    * Packets and byte counts
  * It is important to note that VPC flow logs do not provide visibility into actual traffic content or payload.
  * If you need visibility into network traffic content in order to perform more sophisticated detection of activity you can 
    enable VPC traffic mirroring. Once VPC traffic mirroring is enabled, you can ship this data to third party network 
    monitoring tools
* S3 Bucket Logs: Any changes to an S3 bucket's configuration will be logged as API calls in CloudTrail.
  From a security standpoint it is important to be aware of attempts to read or write objects to S3 buckets - especially those 
  that contain sensitive or critical data. Object level logging is optional and can be enabled either through CloudTrail or 
  the S3 bucket's settings. All calls to read or write data will appear in CloudTrail.
* AWS Config logs: Config logs record all state changes for any resources that are being monitored by AWS Config. These logs 
  should be sent to a log analysis tool to gain deeper visibility into configuration state changes.
* DNS logs: DNS query logging is also available in AWS Route53. Regardless of your choice to enable DNS query logging, AWS 
  does maintain these logs behind the scenes and will use them for identifying suspicious activity.
* EC2 Instance Server Logs: System logs from your Linux and Windows instances are also critical to identifying suspicious 
  activity or auditing. These logs can be sent to cloudwatch logs or other log analysis tools or products that provide 
  intrusion detection and dynamic host based security event monitoring.


### IMPORTANT LINKS FOR READING
* Global Infrastructure : https://aws.amazon.com/about-aws/global-infrastructure/
* Case Studies: https://aws.amazon.com/solutions/case-studies/?customer-references-cards.sort-by=item.additionalFields.publishedDate&customer-references-cards.sort-order=desc
* AWS Realiability Pillar : https://d1.awsstatic.com/whitepapers/architecture/AWS-Reliability-Pillar.pdf
* CIDR : https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing
* NAT: https://en.wikipedia.org/wiki/Network_address_translation
* WannaCry ransomware attack: https://en.wikipedia.org/wiki/WannaCry_ransomware_attack
* S3 Pricing: https://aws.amazon.com/s3/pricing/
* HIGH AVAILABILITY - NO OF NINES : https://en.wikipedia.org/wiki/High_availability
* Atlassian Incident Handbook : https://www.atlassian.com/incident-management/handbook/postmortems#postmortem-issue-fields
* GitHub Post-incident analysis: https://github.blog/2018-10-30-oct21-post-incident-analysis/
* AWS Services That Publish CloudWatch Metrics : https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html
* CLOUD MIGRATION : https://www.cloudindustryforum.org/content/getting-cloud-faster-5-ws-cloud-migration
* CLOUD MIGRATION WITH AWS : https://aws.amazon.com/cloud-migration/
* AWS BLOGS: https://aws.amazon.com/blogs/aws/
* AWS RELEASE NOTES: https://aws.amazon.com/new/?whats-new-content-all.sort-by=item.additionalFields.postDateTime&whats-new-content-all.sort-order=desc&wn-featured-announcements.sort-by=item.additionalFields.numericSort&wn-featured-announcements.sort-order=asc
* AWS INSIDER: https://awsinsider.net/Home.aspx
* AWS REDDITT: https://www.reddit.com/r/aws/
* AWS OUTPOST: https://aws.amazon.com/outposts/
* AWS SNOWBALL: https://aws.amazon.com/snowball/
* AWS OUTPOST: https://www.zdnet.com/article/aws-outpost-brings-its-cloud-hardware-on-premises/
* CLOUD MIGRATION: https://www.cloudindustryforum.org/content/getting-cloud-faster-5-ws-cloud-migration
* CLOUD MIGRATION2: https://aws.amazon.com/cloud-migration/
* CLOUD PRICING: https://cloud.withgoogle.com/build/infrastructure/public-cloud-pricing-explained/
* VPC PREEING : https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html
* REDUCE COST ON AWS: https://cloudonaut.io/6-new-ways-to-reduce-your-AWS-bill-with-little-effort/
* SAVE MONEY WITH VPC ENDPOINT: https://medium.com/nubego/how-to-save-money-with-aws-vpc-endpoints-9bac8ae1319c
* HOW TO HAVE AWS BUDGET UNDER CONTROL:  https://jatheon.com/blog/aws-reduce-costs/
* TYPE OF INSTANCES: https://aws.amazon.com/ec2/instance-types/

