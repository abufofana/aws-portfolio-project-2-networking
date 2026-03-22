\# AWS Terraform Networking Project



## Overview

In this project I used Terraform to provision a complete AWS networking environment from scratch.

The goal was to understand how public and private subnets work in AWS, how internet access is controlled through route tables, and how private resources can safely access the internet using a NAT Gateway.

All infrastructure was created, tested, and destroyed using Terraform.


## Architecture

The infrastructure created in this project includes:

- A custom VPC

- One public subnet

- One private subnet

- An Internet Gateway

- Public and private route tables

- Route table associations

- A security group allowing SSH access

- An EC2 instance deployed in the public subnet

- An Elastic IP

- A NAT Gateway for private subnet outbound internet access



The final architecture looks like this:



Internet  

↓  

Internet Gateway  

↓  

Public Subnet  

↓  

NAT Gateway  

↓  

Private Subnet  


--



## Key Concepts Demonstrated


This project demonstrates several core AWS networking concepts:



Public vs private subnets



How route tables control network traffic



Why `0.0.0.0/0` represents all internet traffic



How Internet Gateways provide public internet access



How NAT Gateways allow private subnet instances to reach the internet securely



How security groups control inbound access to EC2 instances


--

## Terraform Resources Used



Some of the main Terraform resources used in this project include:



aws\_vpc



aws\_subnet



aws\_internet\_gateway



aws\_route\_table



aws\_route\_table\_association



aws\_security\_group



aws\_instance



aws\_eip



aws\_nat\_gateway


---


## Terraform Workflow



The infrastructure lifecycle followed the standard Terraform workflow:



terraform fmt  

terraform validate  

terraform plan  

terraform apply  

terraform destroy



This ensured the configuration was formatted correctly, validated, previewed before deployment, and fully removed after testing.


---

## Why I Built This



As someone transitioning from IT support into cloud engineering, I wanted to move beyond theory and actually build infrastructure using Infrastructure as Code.



This project helped me understand how AWS networking components interact and how Terraform can be used to provision and manage that infrastructure in a repeatable way.


---


## Future Improvements



Potential future improvements include:



Adding a load balancer



Deploying application servers in the private subnet



Introducing Terraform modules



Using remote state with S3 and DynamoDB

