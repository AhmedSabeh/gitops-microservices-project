# 🚀 DevOps AWS Cloud Infrastructure - GitOps Microservices Project

## 🧩 Overview
This project provides a **complete CI/CD-ready cloud infrastructure** on AWS using Terraform, GitHub Actions, EKS, ArgoCD, CloudWatch, and DynamoDB.  
It follows **infrastructure-as-code**, **GitOps**, and **modular Terraform** best practices for **scalability**, **security**, and **maintainability**.

---

## 🏗️ Architecture Components
The following diagram shows the full cloud infrastructure and GitOps workflow for this project:

<img width="2749" height="2145" alt="a new one" src="https://github.com/user-attachments/assets/cb639169-c08c-424f-b17e-c4a4a029ec12" />

| Component                  | Description |
|----------------------------|-------------|
| **VPC**                    | Custom VPC with public and private subnets across **3 Availability Zones**. |
| **EC2 Instances**          | Optional EC2 instances (for testing or GitHub Actions runners). |
| **EKS Cluster**            | Managed Kubernetes cluster hosting microservices (frontend, backend). |
| **DynamoDB**               | Serverless NoSQL database used by backend microservice. |
| **VPC Endpoint (Gateway)** | Enables **private communication** between EKS Worker Nodes and DynamoDB **without internet access**. |
| **CloudWatch**             | Monitors EC2, EKS, and custom metrics. |
| **SNS → Gmail Alerts**     | CloudWatch alarms trigger SNS notifications to DevOps Engineer’s Gmail inbox. |
| **ArgoCD**                 | Continuous Delivery tool for GitOps deployments to EKS. |
| **GitHub Actions**         | CI/CD automation: builds Docker images, pushes to ECR, triggers ArgoCD deployments. |

---

## ⚙️ Tools & Technologies

- **AWS**: EC2, EKS, DynamoDB, CloudWatch, SNS, IAM, VPC  
- **Terraform**: Infrastructure-as-Code (modular structure)  
- **GitHub Actions**: CI/CD automation and GitOps integration  
- **Docker**: Containerization of frontend and backend services  
- **ArgoCD**: Continuous Delivery (GitOps)  
- **CloudWatch + SNS**: Monitoring and alerting  
- **GitHub**: Source control and workflow triggers  

---

## 🧱 Directory Structure
```
gitops-microservices-project/
├── README.md
|
├── terraform/
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ ├── backend.tf
│ ├── modules/
│ │ ├── vpc/
│ │ ├── ec2/
│ │ ├── eks/
│ │ ├── dynamodb/
│ │ ├── vpc_endpoint_dynamodb/
│ │ ├── cloudwatch/
│ │ └── sns/
| |
├── Kubernetes/
│ ├── deployment.yaml
│ ├── service.yaml
│ │ └── namespace.yaml
| |
├── github/
│ └── workflows/
│ | └── ci.yml
| |
├── argo/
│ └── README.md
| |
├── docker/
│ ├── frontend/
│ └── backend/
```

---

## 🧠 Key Design Decisions

| Feature | Best Practice |
|---------|---------------|
| **VPC Endpoint for DynamoDB** | Created as a **separate Terraform module** for modularity and future scalability. |
| **Private Communication** | EKS worker nodes access DynamoDB via **Gateway Endpoint**, no internet required. |
| **Security** | Database has **no public access**; uses **IAM-based authentication** for pods or node roles. |
| **Monitoring** | CloudWatch alarms trigger **SNS → Gmail** for incident alerts. |
| **GitOps Workflow** | GitHub Actions builds Docker images → pushes to **ECR** → triggers **ArgoCD deployment**. |

---

## 🚀 Deployment Steps

### 1️⃣ Initialize Terraform
```
cd terraform
terraform init
```
2️⃣ Validate and Plan
```
terraform validate
terraform plan
```
3️⃣ Apply Infrastructure
```
terraform apply -auto-approve
```
4️⃣ Verify VPC Endpoint
```
aws ec2 describe-vpc-endpoints --filters "Name=service-name,Values=com.amazonaws.${region}.dynamodb"
```
5️⃣ Check DynamoDB Access

From your EKS pod:
```
aws dynamodb list-tables --region <region>
```
Should succeed without internet access.

6️⃣ Test Monitoring Alerts

Trigger a CloudWatch alarm threshold and verify email via SNS → Gmail.

📬 CloudWatch → SNS → Gmail Alert Flow
CloudWatch Alarm monitors metrics (CPU, memory, etc.)
        |
        v
On threshold breach → SNS Topic triggers
        |
        v
SNS subscription sends email alert to DevOps Engineer’s Gmail
        |
        v
Engineer reviews issue and takes immediate action

🐳 GitHub Actions CI/CD Flow

CI Workflow

Build Docker images for frontend/backend.

Run unit tests.

Push images to Amazon ECR.

CD Workflow

Trigger ArgoCD to deploy the latest images to EKS.

Update Kubernetes manifests in Git repository.
