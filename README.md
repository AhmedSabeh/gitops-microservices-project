# 🚀 GitOps CI/CD Project on AWS with EKS, Terraform, GitHub Actions, ArgoCD & DynamoDB

This project demonstrates a **complete DevOps pipeline** that automates Infrastructure provisioning, Continuous Integration, Continuous Deployment, containerization, monitoring, and alerting using **AWS native services** and modern DevOps tools.

It follows the **GitOps** methodology — where Kubernetes manifests are managed declaratively through Git and automatically deployed by **ArgoCD**.

---

## 🏗️ **Architecture Overview**

<img width="2749" height="2144" alt="a new one" src="https://github.com/user-attachments/assets/3da1e810-b3bd-4f4b-bc8a-dafe3f2da942" />

---

## 🔹 **Key Components**

| Component | Description |
|------------|--------------|
| **Terraform** | Used for Infrastructure as Code (IaC) to build AWS resources such as VPC, subnets, Internet Gateway, NAT Gateways, EKS Cluster, and DynamoDB table. |
| **EKS (Elastic Kubernetes Service)** | Hosts containerized microservices and provides orchestration, auto-scaling, and self-healing. |
| **GitHub & GitHub Actions** | Stores application code and runs the CI pipeline to build, scan, and publish Docker images automatically. |
| **Docker** | Containerizes the application for consistent runtime environments. |
| **Trivy** | Performs security scanning on Docker images before pushing them to Docker Hub. |
| **Docker Hub** | Central container registry where built Docker images are stored. |
| **ArgoCD** | GitOps tool deployed inside EKS to continuously deploy new manifests from GitHub into the cluster. |
| **DynamoDB** | AWS managed NoSQL database used by the application backend to store and retrieve data. |
| **CloudWatch** | Monitors application and infrastructure metrics and sends alerts. |
| **SNS + Gmail** | CloudWatch triggers an SNS topic that sends email alerts to the DevOps Engineer when any issue occurs. |

---

## ⚙️ **Pipeline Workflow**

### 🧑‍💻 1. Developer Phase
- Developer commits and pushes code to the **GitHub repository**.
- This triggers a **GitHub Actions workflow**.

### 🏗️ 2. CI (Continuous Integration) with GitHub Actions
1. **Checkout Code** — The pipeline pulls the latest code from GitHub.
2. **Build Docker Image** — Using the `Dockerfile`, the app is containerized.
3. **Trivy Security Scan** — Docker image is scanned for vulnerabilities.
4. **Push Image to Docker Hub** — Secure, scanned image is pushed to a private/public registry.
5. **Update Kubernetes Manifests** — The new image tag is updated in `deployment.yaml` and committed back to GitHub.

### 🚀 3. CD (Continuous Deployment) with ArgoCD
1. **ArgoCD** (running inside EKS) continuously monitors the GitHub repo for manifest changes.
2. When a change is detected, ArgoCD automatically syncs and applies manifests to the **EKS cluster**.
3. **Kubernetes** schedules the pods on worker nodes inside private subnets.
4. **Load Balancer** in public subnet routes user traffic to the application.

### 🧩 4. Application & DynamoDB Connection
- The backend application (running on EKS pods) uses AWS SDK credentials (via IAM Role) to securely connect to **DynamoDB**.
- **DynamoDB** stores and retrieves application data (e.g., user sessions, transactions, logs, or key-value pairs).
- Access is secured through **IAM Roles for Service Accounts (IRSA)** configured via Terraform.

### 📊 5. Monitoring & Alerting
1. **CloudWatch** collects EKS, application, and DynamoDB metrics and logs.
2. If a threshold is breached (e.g., CPU > 80%, DynamoDB latency, or application error), CloudWatch triggers an **alarm**.
3. The alarm publishes a message to an **SNS topic**.
4. **SNS** sends an **email notification** to the **DevOps Engineer (via Gmail)** for immediate awareness.

---

## 🧰 **Tools & Technologies**

| Category | Tools |
|-----------|--------|
| **Infrastructure** | Terraform, AWS |
| **Containerization** | Docker |
| **Orchestration** | Kubernetes (EKS) |
| **CI/CD** | GitHub Actions, ArgoCD |
| **Security** | Trivy |
| **Database** | AWS DynamoDB |
| **Monitoring & Alerts** | CloudWatch, SNS, Gmail |
| **Networking** | VPC, Subnets, NAT, IGW, Load Balancer |

---

## 🌐 **Infrastructure Layout**

- **VPC**: Isolated network for the application.
- **Public Subnets**: Host Load Balancers and NAT Gateways.
- **Private Subnets**: Host EKS worker nodes.
- **2 Availability Zones**: Ensure fault tolerance and high availability.
- **NAT Gateways**: Allow worker nodes in private subnets to access the internet securely.
- **Internet Gateway**: Provides internet access for public resources.
- **DynamoDB**: Serverless, managed NoSQL database accessible from EKS pods.
- **CloudWatch + SNS**: Provide real-time alerting and notifications.

---

## 📂 **Repository Structure Example**

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
│   ├── ingress.yaml
│   └── configmap.yaml     # contains DynamoDB table name and env vars
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
