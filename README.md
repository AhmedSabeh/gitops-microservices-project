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
| **VPC**                    | Custom VPC with public and private subnets across **2 Availability Zones**. |
| **EKS Cluster**            | Managed Kubernetes cluster hosting microservices (frontend, backend). |
| **DynamoDB**               | Serverless NoSQL database used by backend microservice. |
| **VPC Endpoint (Gateway)** | Enables **private communication** between EKS Worker Nodes and DynamoDB **without internet access**. |
| **CloudWatch**             | Monitors EC2, EKS, and custom metrics. |
| **SNS → Gmail Alerts**     | CloudWatch alarms trigger SNS notifications to DevOps Engineer’s Gmail inbox. |
| **ArgoCD**                 | Continuous Delivery tool for GitOps deployments to EKS. |
| **GitHub Actions**         | CI/CD automation: builds Docker images, pushes to Dockerhub, triggers ArgoCD deployments. |

---

## ⚙️ Tools & Technologies

- **AWS**: Dockerhub, EKS, DynamoDB, CloudWatch, SNS, IAM, VPC  
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
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── backend.tf
│   └── modules/
│       ├── cloudwatch/
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       ├── dynamodb/
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       ├── eks/
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       ├── vpc/
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       └── vpc-endpoint/
│           ├── main.tf
│           ├── outputs.tf
│           └── variables.tf
├── Kubernetes/
│   ├── backend-deployment.yaml
│   ├── backend-service.yaml
│   ├── frontend-deployment.yaml
│   ├── frontend-service.yaml
│   ├── ingress.yaml
│   ├── namespace.yaml
|   └── README.md
|
├── github/
│   └── workflows/
│       └── ci.yml
├── ArgoCD/
│   └── README.md
└── app/
    ├── backend/
    │   ├── app.py
    │   ├── requirements.txt
    │   └── Dockerfile
    └── frontend/
        ├── index.html
        ├── nginx.conf
        └── Dockerfile
```

---

## 🧠 Key Design Decisions

| Feature | Best Practice |
|---------|---------------|
| **VPC Endpoint for DynamoDB** | Created as a **separate Terraform module** for modularity and future scalability. |
| **Private Communication** | EKS worker nodes access DynamoDB via **Gateway Endpoint**, no internet required. |
| **Security** | Database has **no public access**; uses **IAM-based authentication** for pods or node roles. |
| **Monitoring** | CloudWatch alarms trigger **SNS → Gmail** for incident alerts. |
| **GitOps Workflow** | GitHub Actions builds Docker images → pushes to **Dockerhub** → triggers **ArgoCD deployment**. |

---

## 🚀 Deployment Steps

### 1️⃣ Initialize Terraform
```
cd terraform
terraform init
```
### 2️⃣ Validate and Plan
```
terraform validate
terraform plan
```
### 3️⃣ Apply Infrastructure
```
terraform apply -auto-approve
```
<img width="1021" height="401" alt="Screenshot (415)" src="https://github.com/user-attachments/assets/770176f2-823c-42a4-9397-60d7cb688a9b" />

### 4️⃣ Verify VPC Endpoint
```
aws ec2 describe-vpc-endpoints --filters "Name=service-name,Values=com.amazonaws.${region}.dynamodb"
```
<img width="1220" height="436" alt="Screenshot (449)" src="https://github.com/user-attachments/assets/07384495-09fd-403a-84a7-fe6b9265d6f4" />
<img width="1224" height="440" alt="Screenshot (450)" src="https://github.com/user-attachments/assets/a7473e7f-5a95-4f38-b827-bd4723d7895b" />

### 5️⃣ Check DynamoDB Access

From your EKS pod:
```
aws dynamodb list-tables --region us-east-1
```
<img width="1204" height="120" alt="Screenshot (448)" src="https://github.com/user-attachments/assets/691afd41-0fc3-4ecf-8235-c3304f38110e" />


### 6️⃣ Test Monitoring Alerts

-    Trigger a CloudWatch alarm threshold and verify email via SNS → Gmail.
```
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
```

### 🐳 GitHub Actions CI/CD Flow

#### CI Workflow

-    Build Docker images for frontend/backend.

-    Run unit tests.

-    Push images to Dockerhub.

<img width="1366" height="397" alt="Screenshot (442)" src="https://github.com/user-attachments/assets/2efeb00b-b916-4744-b016-3d355eb6cf10" />

#### CD Workflow

-    Trigger ArgoCD to deploy the latest images to EKS.

-    Update Kubernetes manifests in Git repository.

---

## 🖥️ Live Application

The following screenshot shows the **Taskify application running on EKS**.  
Frontend is served via Nginx and displays tasks fetched from the backend Flask API connected to DynamoDB:
<img width="1366" height="563" alt="Screenshot (446)" src="https://github.com/user-attachments/assets/72ff2b2f-ca73-42d3-ba61-6b709a46dadc" />

