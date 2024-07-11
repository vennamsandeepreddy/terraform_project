This project provides a Terraform-based approach to deploy a scalable and secure infrastructure on AWS, featuring a VPC, Application Load Balancer (ALB), Elastic Container Service (ECS), Aurora MySQL RDS. The infrastructure is divided into multiple modules for better organization and maintainability. 

Overview
The project is structured into the following modules:

VPC: Creates a Virtual Private Cloud with public and private subnets.
ALB: Sets up an Application Load Balancer with HTTPS support.
ECS: Deploys an ECS cluster with a task definition and service.
RDS: Creates an Aurora MySQL RDS instance.

Features
------------

Security
--------

Network Segmentation: The VPC module defines separate public and private subnets, ensuring that sensitive resources (like the RDS instance) are only accessible from within the VPC.
HTTPS Support: The ALB is configured to use HTTPS, securing data in transit using an ACM-provisioned certificate.
Security Groups: The security module defines security groups to control traffic between different components:
ALB Security Group: Allows inbound HTTPS traffic from the internet.
ECS Security Group: Allows traffic from the ALB to ECS tasks.
RDS Security Group: Restricts access to the RDS instance to only ECS tasks.
Secrets Management: Secrets Manager is used to securely store and manage the RDS database credentials.


Scalability
--------------

Elastic Load Balancing: The ALB distributes incoming traffic across multiple ECS tasks, ensuring high availability and scalability.
ECS with Fargate: ECS is configured with Fargate, allowing for automatic scaling of containerized applications without the need to manage underlying EC2 instances.
Auto-scaling: ECS services are set to scale based on demand(CPU and Memory Utilization), adding more tasks as needed to handle increased traffic.
