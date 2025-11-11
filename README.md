# 🚀 DevOps AWS Cloud Infrastructure — GitOps Microservices Project

## 🧩 Overview

This project builds a **complete CI/CD-ready cloud infrastructure on AWS** using **Terraform**, **Ansible**, **Jenkins**, **EKS**, **ArgoCD**, **CloudWatch**, and **DynamoDB**.  
It follows **infrastructure-as-code**, **GitOps**, and **modular Terraform** best practices for scalability and maintainability.

---

## 🏗️ Architecture Components

<img width="2749" height="2145" alt="a new one" src="https://github.com/user-attachments/assets/be0a9bd3-8f05-4ac2-94c8-63386bbc6ffb" />

| Component | Description |
|------------|-------------|
| **VPC** | Custom VPC with public and private subnets across 3 Availability Zones. |
| **EC2 Instances** | Two EC2 instances (Jenkins Master & Jenkins Worker) used for CI/CD, Docker builds, and integrations with Nexus & SonarQube. |
| **EKS Cluster** | Managed Kubernetes cluster hosting microservices (frontend, backend). |
| **Ansible** | Used for provisioning EC2 instances and installing Java, Jenkins, Git, Trivy, SonarQube, and Nexus. |
| **DynamoDB** | Serverless NoSQL database used by the backend microservice for storing application data. |
| **VPC Endpoint (Gateway)** | Allows private, secure communication between EKS Worker Nodes and DynamoDB without internet access. |
| **CloudWatch** | Monitors EC2 instances, EKS cluster, and custom metrics. |
| **SNS → Gmail Alerts** | CloudWatch alarms trigger SNS notifications that send alerts directly to the DevOps Engineer’s Gmail inbox. |
| **ArgoCD** | Continuous Delivery tool that deploys the latest application version to EKS using GitOps. |

---

---

## ⚙️ Tools & Technologies

- **AWS**: EC2, EKS, DynamoDB, CloudWatch, SNS, IAM, VPC
- **Terraform**: Infrastructure as Code (modular structure)
- **Ansible**: Server configuration management
- **Docker**: Containerization
- **Jenkins**: CI/CD automation
- **ArgoCD**: Continuous Delivery (GitOps)
- **CloudWatch + SNS**: Monitoring and alerting
- **GitHub**: Source control and pipeline triggers

---

## 🧱 Directory Structure


---

## 🧠 Key Design Decisions

| Feature | Best Practice |
|----------|----------------|
| **VPC Endpoint for DynamoDB** | Created as a separate module for modularity and future scalability. |
| **Private Communication** | EKS worker nodes access DynamoDB privately via Gateway Endpoint. |
| **Security** | No public access to database; IAM-based authentication for pods or node roles. |
| **Monitoring** | CloudWatch alarms trigger SNS → Gmail for incident alerts. |
| **GitOps Workflow** | Jenkins triggers ArgoCD deployment after build and image push. |

---

## 🚀 Deployment Steps

1. **Initialize Terraform**
   ```
   terraform init
   ```

Validate and Plan
   ```
terraform validate
terraform plan
   ```
Apply Infrastructure
   ```
terraform apply -auto-approve
   ```

Verify VPC Endpoint
   ```
aws ec2 describe-vpc-endpoints --filters "Name=service-name,Values=com.amazonaws.${region}.dynamodb"
   ```

Check DynamoDB Access

From your EKS pod:
   ```
aws dynamodb list-tables --region <region>
   ```
Should work without internet access.

Test Monitoring Alerts

Trigger a CloudWatch alarm threshold and verify you receive an email via SNS → Gmail.

📬 CloudWatch → SNS → Gmail Alert Flow

-  CloudWatch Alarm monitors metrics (CPU, memory, etc.)

-On threshold breach → SNS topic triggers.

-  SNS Subscription sends an email alert to the DevOps Engineer’s Gmail.

-  Engineer reviews the issue and takes action immediately.
