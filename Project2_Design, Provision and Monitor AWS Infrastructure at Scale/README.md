## AWS ARCHITECT NANODEGREE - PROJECT-02

# Design, Provision and Monitor AWS Infrastructure at Scale
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

### Steps to Install Terraform on Windows
* STEP-01 A Terraform module best practice is to have separate git repositories for reusable modules and live infrastructure and specify   a versioned module git URL in the source parameter instead of your local filesystem.Terraform modules can be created and shared among 
  Terraform users on Terraform Registry or in private registries. Using premade modules is a good way to get started.
* Terraform is a declarative Language. An example of how declarative code differs from procedural code would be changing the number of 
  servers in a .tf file to increase the number of running servers from 2 to 4. Terraform would recognize that two servers have already   
  been created based on the .tfstate, and add two more because the end goal is 4 servers. In procedural language such as an AWS CLI 
  command, increasing the server count to 4 would result in 4 additional servers.
* STEP-02: First, ensure that you are using an administrative shell - you can also install as a non-admin, check out Non-Administrative 
  Installation. Install Chocolatey. Chocolatey is a free and open-source package management system for Windows. Install the Terraform 
  package from the command-line.
* STEP-03: Install Chocolatey. 
  ```
  Command: @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command   "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET  "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
  ```
* STEP-04: choco install terraform ; Set the Path Environment variable to the location of terraform binary.
* STEP-05: terraform -verion
* Terraform Commands
  * terraform init
  * terraform apply
  * terraform destroy
* STEP-06: In order to maintain your tfstate file properly, you MUST have versioning enabled on your S3 bucket. When the state file is 
  stored remotely in S3, it can be versioned and shared collaboratively

## Task 1: Create AWS Architecture Schematics
### Part 1 : You have been asked to plan and provision a cost-effective AWS infrastructure for a new social media application 
development project for 50,000 single-region users. The project requires the following AWS infrastructure and services. Please include 
your name and label all elements of the infrastructure on the diagram.
* Infrastructure in the following regions: us-east-1
* Users and Client machines
* One VPC
* Two Availability Zones
* Four Subnets (2 Public, 2 Private)
* A NAT Gateway
* A CloudFront distribution with an S3 bucket
* Web servers in the Public Subnets sized according to your usage estimates
* Application Servers in the Private Subnets sized according to your usage estimates
* DB Servers in the Private Subnets
* Web Servers Load Balanced and Autoscaled
* Application Servers Load Balanced and Autoscaled
* A Master DB in AZ1 with a read replica in AZ2
Use LucidChart or a similar diagramming application to create your schematic. Export your schematic as a PDF and save as Udacity_Diagram_1.pdf.

### Part-02: You have been asked to plan a SERVERLESS architecture schematic for a new application development project. The project 
requires the following AWS infrastructure and services.
* A user and client machine
* AWS Route 53
* A CloudFront Distribution
* AWS Cognito
* AWS Lambda
* API Gateway
* DynamoDB
* S3 Storage
Export your schematic as a PDF and save as Udacity_Diagram_2.pdf

## Task 2: Calculate Infrastructure Costs
* PART-01: Use the AWS Pricing Calculator to estimate how much it will cost to run the services in your Part 1 diagram for one month.
  * Target a monthly estimate between $8,000-$10,000.
  * Be mindful of AWS regions when you are estimating costs.
  * Export the estimate as a CSV file named Initial_Cost_Estimate.csv.
* PART-02: Return to the AWS Pricing Calculator and reconfigure your estimates for the following scenarios:
  * Your budget has been reduced from $8,000-$10,000 to a maximum of $6,500. What services will you modify to meet this new budget? 
    Export the updated costs in a CSV file named Reduced_Cost_Estimate.csv and write up a brief narrative of the changes you made in the 
    CSV file below the cost estimate.
  * Your budget has been increased to $20,000. What resources will you add and why?
    Think about where to add redundancy and how to improve performance. Re-configure your estimate to a monthly invoice of $18K-20K. 
    Export the updated costs to a CSV file named Increased_Cost Estimate.csv and write up a brief narrative of the changes you made in 
    the CSV file below the cost estimate.

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

## OUTLINE
![image](https://user-images.githubusercontent.com/13011167/84308697-90b07800-ab7c-11ea-96fd-02f5f0308723.png)

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

## PERFORMANCE IN CLOUD
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

### INFRASTRUCTURE AS A CODE (IAC)
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



### IMPORTANT LINKS FOR READING
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
