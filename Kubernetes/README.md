# GitOps Microservices Project - Kubernetes Deployment

## 🚀 Project Overview
This project demonstrates a **microservices deployment using Kubernetes** with a **frontend-backend architecture**:

- **Frontend:** Nginx serving a task management UI  
- **Backend:** Python Flask API handling tasks and writing to **DynamoDB**  
- **Deployment:** Kubernetes manifests (Deployments, Services) and **Helm chart for Ingress**  
- **GitOps-ready:** Can be integrated with ArgoCD for automated deployment  

---

## 🏗 Architecture
```
Frontend Pod 
|
v
Backend Pod ---> DynamoDB
|
v
Ingress (Helm) exposes frontend externally
```

---- 

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
```
Kubernetes/
├── backend-deployment.yaml
├── backend-service.yaml
├── frontend-deployment.yaml
├── frontend-service.yaml
├── ingress.yaml
├── namespace.yaml
└── README.md
```

---

## 🚀 Deployment Steps

### 1. Apply namespace
```
kubectl apply -f namespace.yaml
```

### 2. Apply Backend
```
kubectl apply -f backend-deployment.yaml
kubectl apply -f backend-service.yaml

```
-  Deploys Flask backend pods on backend-labeled nodes

-  Exposes backend via ClusterIP service


### 3. Apply Frontend
```
kubectl apply -f frontend-deployment.yaml
kubectl apply -f frontend-service.yaml
```
-  Deploys Nginx frontend pods on frontend-labeled nodes

-  Configured to fetch tasks from backend service

### 4. Deploy Ingress via Helm

-  Add Helm repo for ingress-nginx
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```
-  Install ingress controller
```
helm install taskify-ingress ingress-nginx/ingress-nginx
```

-  Helm installs the Ingress controller

-  Exposes frontend externally

-  Backend remains internal (ClusterIP service)


### 5. Verify Deployment
```
kubectl get pods -n taskify
kubectl get svc -n taskify 
kubectl get ingress -n taskify
```
