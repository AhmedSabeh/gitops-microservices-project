# 🚀 GitOps CI/CD Project on AWS with EKS, Terraform, GitHub Actions & ArgoCD

This project demonstrates a **complete DevOps pipeline** implementing Infrastructure as Code (IaC), Continuous Integration (CI), Continuous Deployment (CD), containerization, GitOps automation, and monitoring on **AWS**.

---

## 🏗️ **Architecture Overview**



### 🔹 Components

| Component | Description |
|------------|--------------|
| **Terraform** | Builds the AWS infrastructure including VPC, subnets, NAT gateways, Internet gateway, and EKS cluster. |
| **EKS (Elastic Kubernetes Service)** | Manages containerized application deployment and scaling. |
| **GitHub Actions** | Handles CI pipeline: code build, Docker image creation, security scanning with Trivy, and pushing to Docker Hub. |
| **Docker** | Containerizes the application for consistent environment delivery. |
| **Trivy** | Scans Docker images for vulnerabilities before pushing to the registry. |
| **Docker Hub** | Stores built Docker images that will later be deployed on EKS. |
| **ArgoCD** | Handles Continuous Deployment by automatically syncing Kubernetes manifests from GitHub to the EKS cluster. |
| **DynamoDB** | Provides a managed, serverless NoSQL database backend for the application. |
| **CloudWatch** | Monitors application and infrastructure metrics, logs, and triggers alerts via SNS. |
| **SNS + Gmail** | CloudWatch sends alerts to an SNS topic, which emails the DevOps engineer for notifications. |

---

## ⚙️ **Workflow Summary**

### 🧑‍💻 1. Developer Stage
1. Developer pushes code to **GitHub**.
2. GitHub Actions pipeline automatically starts.

### 🏗️ 2. CI Stage – GitHub Actions
1. **Build Docker image** from the source code.
2. **Scan** the image for vulnerabilities using **Trivy**.
3. **Push** the scanned and approved image to **Docker Hub**.
4. **Update Kubernetes manifests** with the new image tag and commit back to GitHub.

### 🚀 3. CD Stage – ArgoCD on EKS
1. **ArgoCD** detects manifest changes in GitHub.
2. Automatically **syncs** the updated manifests to the **EKS cluster**.
3. **Kubernetes** deploys the new version across the nodes.
4. **Load Balancer** routes traffic from users to the running pods.

### 📊 4. Monitoring & Alerts
1. **CloudWatch** monitors logs, metrics, and events for EC2, EKS, and application components.
2. When thresholds or errors are detected, **CloudWatch triggers an SNS topic**.
3. **SNS sends email notifications** (via Gmail) to the **DevOps Engineer** for immediate action.

---

## 🧩 **Infrastructure Layout**

- **VPC** – Isolated environment for all resources  
- **2 Availability Zones** for high availability  
- **Private Subnets** – Host EKS worker nodes  
- **Public Subnets** – Contain NAT Gateways and Load Balancer  
- **NAT Gateways** – Allow private nodes secure outbound internet access  
- **Internet Gateway** – Enables inbound/outbound traffic for public subnets  
- **DynamoDB** – Serverless NoSQL database (managed by AWS)

---

## 🧰 **Tools & Technologies**

| Category | Tools |
|-----------|--------|
| **IaC** | Terraform |
| **CI/CD** | GitHub Actions, ArgoCD |
| **Containers** | Docker, Kubernetes (EKS) |
| **Security** | Trivy |
| **Monitoring** | CloudWatch, SNS, Gmail |
| **Database** | DynamoDB |
| **Cloud Provider** | AWS |

---

## 📂 **Folder Structure Example**

```bash
project-root/
│
├── Terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── modules/
│
├── manifests/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
│
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── src/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
│
└── README.md
