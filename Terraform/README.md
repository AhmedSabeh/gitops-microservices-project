# 🚀 Infrastructure as Code (Terraform)

## 🧩 Overview

This repo demonstrates a **full GitOps-ready microservices deployment** on AWS, leveraging:

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

- EKS Cluster
<img width="1366" height="520" alt="Screenshot (432)" src="https://github.com/user-attachments/assets/b0e8e049-4ab8-4af1-bd82-76b19d2e1b35" />
<img width="1366" height="522" alt="Screenshot (433)" src="https://github.com/user-attachments/assets/a9ba62e6-dcc9-454b-a46d-3b23e0707758" />

- EKS Nodes & Node Groups
<img width="1366" height="559" alt="Screenshot (435)" src="https://github.com/user-attachments/assets/8a70bf99-edbd-45f6-85f5-698d1a05967d" />

- NAT Gateways
<img width="1366" height="515" alt="Screenshot (436)" src="https://github.com/user-attachments/assets/43bc7fc3-b84a-4351-ae25-948417e9c7e0" />

- VPC Endpoints
<img width="1366" height="551" alt="Screenshot (437)" src="https://github.com/user-attachments/assets/7f956566-218d-4135-8973-1761099e8aa2" />

- DynamoDB Table
<img width="1366" height="551" alt="Screenshot (438)" src="https://github.com/user-attachments/assets/5bf749bd-4895-4e58-b83f-8d40a1f71eba" />
