## AWS CLOUD ARCHITECT - NanoDegree (MyNotes)

## Design For Availability,Reliability and Resiliency
* Availability: A measure of time that a system is operating as expected. Typically measured as a percentage.
* Reliability: A measure of how likely something is to be operating as expected at any given point in time. Said differently, 
  how often something fails.
* Resiliency: A measure of a system's recoverability. How quickly and easily a system can be brought back online.

### AZs AND REGIONS - HA Design
* AWS has around 20 Regions and 2-3 AZs in each Region.
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

### BUILDING RESILENCY
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

### BUSINESS OBJECTIVES: Business objectives are where the other business functions of your company meet with the Engineering 
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

#### MONITORING 
* AWS Services That Publish CloudWatch Metrics : https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-
cloudwatch-metrics.html

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

================================================================================================

## DESIGN FOR PEROFRMANCE AND SCALIBILITY
#### Key Points
* Moving to the cloud doesn’t guarantee that your application will be faster and cost less to operate. In fact, without the 
proper baseline metrics, you won’t know where to start when planning your move.
* Most performance issues can be traced to the application itself and some applications will need to be redesigned to be cloud 
native in order to achieve truly optimized performance. Common causes of performance issues:
  * Poorly designed applications
  * Database design constraints
  * Inefficient network routes
* Moving to the cloud should improve network response times. Global edge cache locations can bring the server closer to the end user.

#### Examples Of Cloud Migration Goals:
* We are migrating to the cloud to reduce our infrastructure costs by 25%
* We believe that by hosting our application in AWS, we will be able to deliver download speeds that are 60% faster than our 
baseline
* We are going to duplicate our infrastructure in the cloud and maintain our AWS account as a warm backup site for disaster 
recovery
* We are consolidating our data centers and moving to the cloud because our AWS account will provide one centralized view into 
our environment with more visibility into how our compute spend is being utilized.

### PREREQUISITIES FOR COURSE
* VSCode 	https://code.visualstudio.com
* Create an AWS Account 	https://portal.aws.amazon.com/billing/signup
* AWS CLI 	https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
* Terraform 	https://learn.hashicorp.com/terraform/getting-started/install.html
* LucidChart 	https://www.lucidchart.com

### INSTALLATIONS
* AWS CLI INSTALLATIONS: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
* TERRAFORM INSTALLATIONS: https://learn.hashicorp.com/terraform/getting-started/install.html
* DIAGRAM APPLICATION: https://www.lucidchart.com/

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

### INSTANCE PRICING
AWS EC2 instance pricing is straightforward, but it can quickly become complex when you take up the task of optimizing your environment to achieve the ideal cost/performance balance.
* Explore OS licensing pricing and options
* Limit the users and roles that can launch production instances
* Choose the best instance for your workload
* Save by moving to new generation instances when available
* When optimizing your computing usage to reduce your monthly spend, one of the first places you want to count your costs is 
in your EC2 instances, and one of the best resources here is using reserved instances. 

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



### IMPORTANT LINKS FOR READING
* CLOUD MIGRATION : https://www.cloudindustryforum.org/content/getting-cloud-faster-5-ws-cloud-migration
* CLOUD MIGRATION WITH AWS : https://aws.amazon.com/cloud-migration/
* AWS BLOGS: https://aws.amazon.com/blogs/aws/
* AWS RELEASE NOTES: https://aws.amazon.com/new/?whats-new-content-all.sort-by=item.additionalFields.postDateTime&whats-new-content-all.sort-order=desc&wn-featured-announcements.sort-by=item.additionalFields.numericSort&wn-featured-announcements.sort-order=asc
* AWS INSIDER: https://awsinsider.net/Home.aspx
* AWS REDDITT: https://www.reddit.com/r/aws/
* AWS OUTPOST: https://aws.amazon.com/outposts/
* AWS SNOWBALL: https://aws.amazon.com/snowball/
