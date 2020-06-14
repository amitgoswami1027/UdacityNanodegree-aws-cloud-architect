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

## Task 1: Create AWS Architecture Schematics - [Done]
### Part 1 : You have been asked to plan and provision a cost-effective AWS infrastructure for a new social media application 
development project for 50,000 single-region users. The project requires the following AWS infrastructure and services. Please include 
your name and label all elements of the infrastructure on the diagram.
* Infrastructure in the following regions: us-east-1(AmitG)
* Users and Client machines
* One VPC (10.1.0.0/16) - AmitG
* Two Availability Zones - us-east-1a and us-east-1b
* Four Subnets (2 Public, 2 Private) - 10.1.10.0/24; 10.1.11.0/24;10.1.20.0/24;10.1.21.0/24
* A NAT Gateway 
* A CloudFront distribution with an S3 bucket
* Web servers in the Public Subnets sized according to your usage estimates - T4 (Web Servers) 
* Application Servers in the Private Subnets sized according to your usage estimates T4 ( Application Server)
* DB Servers in the Private Subnets (RDS Master and RDS Replica)
* Web Servers Load Balanced and Autoscaled
* Application Servers Load Balanced and Autoscaled
* A Master DB in AZ1 with a read replica in AZ2
Use LucidChart or a similar diagramming application to create your schematic. Export your schematic as a PDF and save as Udacity_Diagram_1.pdf.
### SOLUTION : Taking the architecture forward from the Project-01:Data DUrability and Recovery, here goes the details of the initial. 
AWS Architecutre for the above problem statement.To be cost effective I will be using the Multi-AZ architecutre as Multi region will 
be costly and believe for 50k users it does not make sense to go from multi-region architecture option.
* In order to achieve the durability and availability in AWS you must go for multi AZ Architecutre, us-east-1a and us-east-1b. 
* Primary VPC (us-east-1) - 10.1.0.0/16 with Subnets : 10.1.10.0/24; 10.1.11.0/24;10.1.20.0/24;10.1.21.0/24
#### Added the find in repo - Udacity_Diagram_1.pdf. Following snapshot for your reference. (All resources are tagged with AmitG)
![image](https://user-images.githubusercontent.com/13011167/84575602-dd3dc280-adcb-11ea-95e9-45e06ef7fa0e.png)

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
#### SOLUTION : Added the find in repo - Udacity_Diagram_2.pdf. Following snapshot for your reference.(All resources are tagged with AmitG)
![image](https://user-images.githubusercontent.com/13011167/84576081-9f429d80-adcf-11ea-93b4-3ec1b2ffedab.png)

## Task 2: Calculate Infrastructure Costs-[Done]
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
### SOLUTION : (initial_cost_estimate.csv;reduced_cost_estimate.csv and increased_cost_estimate.csv enclosed for reference)
### Links for cost computaitons:
* Initial Cost: https://calculator.aws/#/estimate?id=b909c3b2e8839a9108abb974f40bec561af0ab66
* Reduced Cost: https://calculator.aws/#/estimate?id=72b87c780f7e9c11ecf9da3835d46415c9ef4ecf
* Enhanced Cost: https://calculator.aws/#/estimate?id=410248567d79f29af9c89e0b99c77a9182f35207
### Reduced costs changes- Modifications
* Use of smaller EC2 and RDS instances
* We can also make use of the reserved instances booked for 1-3 year duraiton to reduce cost.  * Using reserved instances will   
  significantly reduce costs but will lock the platform into using the selected infrastructure for the next year. 
* Using smaller EC2 instances allows for more granular autoscaling though could reduce performance.
### Increased costs changes- Modifications
* Larger RDS instances and increased EC2 instances for scaling and performance. 
* We can also make use of another AZ in Us-east-1, probably use-east-1c.
* We can also make use of the multi region configrations to enhance the durability abd availability for disastory management - Second 
  region allows for failover if the first region goes down. 

## Task 3: Configure Permissions. [Done]
In order to complete this task, please ensure your IAM users have been granted access to the billing dashboard (Activating Access to the Billing and Cost Management Console).
* 1. Update the AWS password policy.
     * Minimum password length = 8
     * Require at least one uppercase letter
     * Require at least one lowercase letter
     * Require at least one number
     * Require at least one non-alphanumeric character.
Submit a screenshot of the Password Policy from the IAM Account settings page. Name the screenshot udacity_password_policy.png or udacity_password_policy.jpg.
![image](https://user-images.githubusercontent.com/13011167/84579265-0ff6b380-adea-11ea-80be-2380ea1876fc.png)
* 2. Create a Group named CloudTrailAdmins and give it the two CloudTrail privileges.
* 3. Create a Group named Reviewers and give it the Billing privilege.
* 4. Configure a user named CloudTrail and a user named Accountant. Give the users AWS Console access and assign them a password that 
     conforms to your password policy. Require them to change their password when they login.
* 5. Assign CloudTrail to the CloudTrailAdmins group. Assign Accountant to the Reviewers group .
* 6. Test both user accounts by logging into the AWS console as the users CloudTrail and Accountant after changing their passwords on 
     login. Login using your numerical AccountID.

## Task 4: Set up Cost Monitoring-[Done]
* Configure CloudWatch billing alarm
* Set up a Billing alarm with a $5 threshold
* Set up notification so that you get an email alert when the alarm is triggered.
* Save a screenshot of the CloudWatch Alarms page showing the new alarm with a green OK status as CloudWatch_alarm.png or 
  CloudWatch_alarm.jpg
### SOLUTION: 
* Steps-01 : Setting Up an Amazon SNS Topic Using the AWS Management Console.
  * Create an SNS topic,
  * Subscribe to an SNS topic(Provide email for notifications, confirm the email.)
  * Publish a test message to an SNS topic.
* Step-02 : Create the Cloud watch alarm with the specification given in the above task.
* Step-03 : In case we recieve the INSUFFICIENT DATA, need to check if the instance or services are not running, some services publish 
  the data at some specific interval, so need to wait. INSUFFICIENT DATA is not the error scenario and its a normal state.
#### Added CloudWatch_alarm.png with AmitG tagged. Also please find the enclosed shapshot for your reference.
![image](https://user-images.githubusercontent.com/13011167/84587920-e5841500-ae40-11ea-9866-c7f6bec9ba61.png)

## Task 5 : Use Terraform to Provision AWS Infrastructure
### Part 1
* 1. Download the starter code.
* 2. In the main.tf file write the code to provision
     * AWS as the cloud provider
     * Use an existing VPC ID
     * Use an existing public subnet
     * AWS t2.micro EC2 instances named Udacity T2
     * 2 m4.large EC2 instances named Udacity M4
* 3. Run Terraform.
* 4. Take a screenshot of the 6 EC2 instances in the AWS console. Save it as Terraform_1_1.png or Terraform_1_1.jpg .
* 5. Use Terraform to delete the 2 m4.large instances.
* 6. Take an updated screenshot of the AWS console showing only the 4 t2.micro instances and save it as Terraform_1_2.png or Terraform_1_2.jpg
#### Terraform_1_1.png & Terraform_1_2.png added to the repo for review.
### Part 2
* 1. In the Exercise_2 folder, write the code to deploy an AWS Lambda Function using Terraform. Your code should include:
     * A lambda.py file
     * A main.tf file
     * An outputs.tf file
     * A variables.tf file
* 2. Take a screenshot of the EC2 instances page and save it as Terraform_2_1.png or Terraform_2_1.jpg.
* 3. Take a screenshot of the VPC page and save it as Terraform_2_2.png or Terraform_2_2.jpg.
* 4. Take a screenshot of the CloudWatch log entry for the lambda function execution and save it as Terraform_2_3.png or 
     Terraform_2_3.jpg.
#### Terraform_2_1.png & Terraform_2_2.png added to the repo for review.

## Task 6: Destroy the Infrastructure using Terraform and prepare for submission
* Destroy all running provisioned infrastructure using Terraform so as not to incur unwanted charges.
* Take a screenshot of the EC2 instances page and label it Terraform_destroyed.png or Terraform_destroyed.jpg .
* Upload Terraform files, screenshots, schematics and CSV files to your GitHub repo
### SOLUTION : Terraform_destroyed.png added to the repo for review

### IMPORTANT LINKS FOR READING
* CLOUD PRICING: https://cloud.withgoogle.com/build/infrastructure/public-cloud-pricing-explained/
* VPC PREEING : https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html
* REDUCE COST ON AWS: https://cloudonaut.io/6-new-ways-to-reduce-your-AWS-bill-with-little-effort/
* SAVE MONEY WITH VPC ENDPOINT: https://medium.com/nubego/how-to-save-money-with-aws-vpc-endpoints-9bac8ae1319c
* HOW TO HAVE AWS BUDGET UNDER CONTROL:  https://jatheon.com/blog/aws-reduce-costs/
* TYPE OF INSTANCES: https://aws.amazon.com/ec2/instance-types/
