# Taskify Application - ArgoCD Deployment

Step-by-step guide for implementing GitOps with ArgoCD to deploy and maintain the Taskify frontend and backend applications on a Kubernetes cluster.

---

## ✅ Overview

- **Purpose:** Show how to deploy and manage Taskify frontend + backend via ArgoCD  
- **Frontend:** Nginx serving Task Manager UI  
- **Backend:** Python Flask API → DynamoDB  
- **Cluster:** AWS EKS  
- **Namespace:** `taskify`  
- **Deployment method:** GitOps with ArgoCD  

---

## ⚙️ Steps to Use ArgoCD

### 1. Login

```
# Get admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```
### 2. Port-forward ArgoCD server
```
kubectl port-forward svc/argocd-server -n argocd 9090:443
Access GUI: http://localhost:9090
```
<img width="1297" height="586" alt="Screenshot (424)" src="https://github.com/user-attachments/assets/2fff05d7-85a9-4aa2-af2d-1a9144b49aa6" />

-  Username: admin

-  Password: from command above

### 3. Connect Repository

-  Repository URL: https://github.com/AhmedSabeh/gitops-microservices-project

-  Path: Kubernetes

-  Revision: main

-  Auth: None (public repo)

### 4. Create Application in GUI

-  Application Name: taskify-app

-  Project: default

-  Cluster: https://kubernetes.default.svc

-  Namespace: taskify

-  Sync Policy: Automatic

-  ArgoCD will deploy Deployments, Services, and Ingress.

<img width="1366" height="584" alt="Screenshot (428)" src="https://github.com/user-attachments/assets/99bd4dae-5547-41b5-83f6-c90634467302" />

### 5. Sync & Verify

-  Click Sync → all resources will be applied

-  Expand Resources tree to see pods, ReplicaSets, Services

-  Pods should show Running / Healthy

### 6. GitOps Workflow

-  Push changes to main → ArgoCD detects them → auto-syncs cluster

-  Use this workflow for future updates

<img width="1366" height="592" alt="Screenshot (426)" src="https://github.com/user-attachments/assets/fb3593df-0623-45e2-a5b7-be043b233cec" />

