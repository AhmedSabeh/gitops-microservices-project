# 🚀 GitOps Microservices Project on AWS

## 🧩 Project Overview

This project demonstrates a **full GitOps-ready microservices deployment** on AWS, leveraging:

- **Infrastructure as Code (IaC)** using **Terraform** with modular structure  
- **Kubernetes (EKS)** for container orchestration  
- **CloudWatch** for monitoring and logging  
- **DynamoDB** for backend storage  
- **VPC and VPC Endpoints** for secure networking  

The goal is to deploy a production-ready microservices stack following **best practices** in DevOps, GitOps, and cloud architecture.

---

## 🏗️ Project Structure

```
terraform/
 ├── main.tf
 ├── variables.tf
 ├── outputs.tf
 ├── backend.tf
 └── modules/
     ├── cloudwatch/
     │   ├── main.tf
     │   ├── outputs.tf
     │   └── variables.tf
     ├── dynamodb/
     │   ├── main.tf
     │   ├── outputs.tf
     │   └── variables.tf
     ├── eks/
     │   ├── main.tf
     │   ├── outputs.tf
     │   └── variables.tf
     ├── vpc/
     │   ├── main.tf
     │   ├── outputs.tf
     │   └── variables.tf
     └── vpc-endpoint/
         ├── main.tf
         ├── outputs.tf
         └── variables.tf
```
## ⚙️ Terraform Modules
### 1. VPC Module

- Creates a custom VPC with public/private subnets.

- Supports multi-AZ deployments for high availability.

- Configures route tables, internet gateways, NAT gateways, and security groups.

### 2. VPC Endpoint Module

- Creates interface and gateway endpoints for AWS services.

- Ensures private connectivity for DynamoDB, S3, and other AWS services without traversing the internet.

### 3. EKS Module

- Deploys an EKS cluster with node groups for frontend and backend workloads.

- Supports labeling nodes for workload isolation.

- Integrates with IAM roles and policies for secure cluster access.

### 4. DynamoDB Module

- Creates a NoSQL table for microservices backend data storage.

- Configurable read/write capacity and TTL settings for cleanup policies.

### 5. CloudWatch Module

- Sets up CloudWatch log groups for microservices logs.

- Supports metrics collection and alerting for cluster monitoring.

## 🚀 Deployment Steps

- Configure AWS CLI and Terraform backend:
```
aws configure
terraform init
```

- Plan the infrastructure:
```
terraform plan
```

- Apply the Terraform configuration:
```
terraform apply -auto-approve
```
<img width="1221" height="420" alt="Screenshot (453)" src="https://github.com/user-attachments/assets/9124991f-eb8e-497d-b488-54faf55c2f17" />

- Verify resources:
```
terraform show
kubectl get nodes -o wide
kubectl get pods -A
```
<img width="1212" height="362" alt="Screenshot (454)" src="https://github.com/user-attachments/assets/b8dc7ca6-684e-492c-bd6b-84e339feb122" />

## 🔐 Security & Best Practices

- All AWS resources are tagged for cost tracking and organization.

- VPC endpoints ensure private service access.

- Node groups are segregated by workload type (frontend/backend).

- CloudWatch collects logs for observability.
