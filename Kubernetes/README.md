# GitOps Microservices Project - Kubernetes Deployment

## 🚀 Project Overview
This project demonstrates a **microservices deployment using Kubernetes** with a **frontend-backend architecture**:

- **Frontend:** Nginx serving a task management UI  
- **Backend:** Python Flask API handling tasks and writing to **DynamoDB**  
- **Deployment:** Kubernetes manifests (Deployments, Services) and **Helm chart for Ingress**  
- **GitOps-ready:** Can be integrated with ArgoCD for automated deployment  

---

## 🏗 Architecture

Frontend Pod (Nginx)
|
v
Backend Pod (Flask) ---> DynamoDB
|
v
Ingress (Helm) exposes frontend externally


- Frontend fetches tasks from the backend via `http://backend-svc:5000/tasks`  
- Backend remains **internal**, accessible only by frontend (ClusterIP service)  
- Pods are scheduled on **separate node groups** for frontend and backend  

---

## 📦 Kubernetes Components

| Component          | Type           | Notes                                    |
|-------------------|----------------|-----------------------------------------|
| Frontend Deployment | Deployment    | Runs Nginx container                     |
| Frontend Service    | ClusterIP     | Internal service, accessed via Ingress  |
| Backend Deployment  | Deployment    | Runs Flask container                     |
| Backend Service     | ClusterIP     | Only accessible internally               |
| Ingress             | Helm Chart    | Exposes frontend externally              |
| Node Groups         | Node labels   | Frontend & backend pods separated        |

---

## 🏗 Project Structure
Kubernetes/
├── frontend/
│ └── deployment.yaml
├── backend/
│ └── deployment.yaml
└── README.md


---

## 🚀 Deployment Steps

### 1. Apply Backend
```bash
kubectl apply -f Kubernetes/backend/deployment.yaml

Deploys Flask backend pods on backend-labeled nodes

Exposes backend via ClusterIP service


2. Apply Frontend
kubectl apply -f Kubernetes/frontend/deployment.yaml
Deploys Nginx frontend pods on frontend-labeled nodes

Configured to fetch tasks from backend service

3. Deploy Ingress via Helm

# Add Helm repo for ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Install ingress controller
helm install taskify-ingress ingress-nginx/ingress-nginx

Helm installs the Ingress controller

Exposes frontend externally

Backend remains internal (ClusterIP service)


4. Verify Deployment
kubectl get pods
kubectl get svc
kubectl get ingress

