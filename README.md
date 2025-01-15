# React App Deployment with Terraform

## Description

This project demonstrates the deployment of a React.js application on an AWS EC2 instance using Terraform for infrastructure as code. The setup provisions a complete environment, including a Virtual Private Cloud (VPC), security configurations, and the necessary software to run the application.

## Features

#### Automated Deployment: 
Terraform script provisions the infrastructure and deploys the React app automatically.

#### Custom Networking: 
Creates a VPC with a public subnet and internet connectivity.

#### Security Configurations: 
Configures security groups to allow SSH and HTTP/HTTPS access.

#### React Application: 
Deploys a pre-built React.js application from a GitHub repository.

#### Software Configuration: 
Automatically installs required software (Node.js, npm, Git, Nginx) and runs the application.

## Technologies Used

#### Infrastructure

* Terraform: Infrastructure as Code tool for AWS resource provisioning.

#### AWS Services:

* EC2 (Elastic Compute Cloud)

* VPC (Virtual Private Cloud)

* Subnets

* Internet Gateway

* Elastic IP

* Security Groups

#### Software

* React.js: Front-end framework for the application.

* Node.js: JavaScript runtime environment.

* npm: Package manager for Node.js.

* Nginx: Web server for serving the application.

* Git: Version control to clone the project.

## Prerequisites

#### AWS Account

Ensure you have access to an AWS account with permissions to create EC2, VPC, and related resources.

#### Terraform Installed

Download and install Terraform from the official website.

#### AWS CLI Configured

Set up the AWS CLI with your access and secret keys:

#### SSH Key Pair

Generate an SSH key pair or use an existing one. Ensure the public key is uploaded to AWS.

## Installation and Configuration

1. #### Clone the repository:
```bash
git clone https://github.com/MiguelM91/Web_con_react.git
```
2. ##### Navigate to the project directory.

```bash
cd Web_con_react
```
3. #### Run the deployment using Terraform:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply

```

4. #### Confirm the prompt to create the resources.

5. #### Access the Application

* Obtain the public IP of the EC2 instance from the Terraform output or AWS Management Console.

* Open a browser and navigate to:
 ```bash
http://<Public-IP>:3000
```
6. #### Cleanup

When you have finished this lab and checked that everything is in order, don't forget to delete the created resources.:

 ```bash
terraform destroy
```

## Troubleshooting

#### Application Not Loading: 
Verify the security group rules and ensure the necessary ports (8081, 3000) are open.

#### Permission Issues: 
Ensure the correct SSH key pair is configured and accessible.

#### Dependency Errors: 
Check the logs in /var/log/user_data.log on the EC2 instance for any setup issues.

## Author

MiguelM91