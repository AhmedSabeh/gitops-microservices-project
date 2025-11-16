# Taskify Application - ArgoCD Deployment

This folder contains **documentation for deploying the Taskify app using ArgoCD**.

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

```bash
# Get admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

# Port-forward ArgoCD server
kubectl port-forward svc/argocd-server -n argocd 8080:443
Access GUI: http://localhost:8080

Username: admin

Password: from command above

2. Connect Repository

Repository URL: https://github.com/AhmedSabeh/gitops-microservices-project

Path: Kubernetes

Revision: main

Auth: None (public repo)

3. Create Application in GUI

Application Name: taskify-app

Project: default

Cluster: https://kubernetes.default.svc

Namespace: taskify

Sync Policy: Automatic (optional)

ArgoCD will deploy Deployments, Services, and Ingress.

4. Sync & Verify

Click Sync → all resources will be applied

Expand Resources tree to see pods, ReplicaSets, Services

Pods should show Running / Healthy

5. GitOps Workflow

Push changes to main → ArgoCD detects them → auto-syncs cluster

Use this workflow for future updates
