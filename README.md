# EKS-GitOps project using Terraform and ArgoCD 

## Overview

This project automates provisioning an AWS EKS cluster using Terraform, and deploys applications via ArgoCD for GitOps-style continuous delivery.

---

## Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform installed (v1.+ recommended)
- kubectl installed and configured
- GitHub repository containing your Kubernetes manifests and ArgoCD Application yamls

---

## Project Structure
<pre>```
eks-gitops-project
├── terraform/ # Terraform code for EKS provisioning
│ ├── main.tf
│ └── outputs.tf
├── argocd/ # ArgoCD Application manifests (App of Apps or single app)
│ └── app.yaml
├── manifests/ # Kubernetes manifests for your apps (e.g., NGINX)
│ ├── deployment.yaml
│ └── service.yaml
└── README.md # This file
```</pre>

---

## Steps to Run

### 1. Provision EKS Cluster
    ```bash
    Switch to terraform directory
    cd terraform
    
    Initialize the terraform
    terraform init
    
    Applies the main.tf
    terraform apply         # Do not panic, this may take 10+ minutes to complete
    
    You shoud see an AWS EKS cluster with a node running. 
    
### 2. Update kubeconfig to access the cluster
    aws eks update-kubeconfig --region <your-eks-region> --name <your-cluster-name>
    or 
    simply copy the command displayed by terraform output and run
    Try 'kubectl get nodes' to test it (from your terminal)

### 3. Deploy ArgoCD
    
    Create a namespace called argocd
    kubectl create namespace argocd
    
    Install ArgoCD by applying the manifest from argocd repo
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

### 4. Deploy Applications via ArgoCD
    kubectl apply -f ../argocd/app.yaml -n argocd

### Accessing Services
**ArgoCD UI**
    kubectl port-forward svc/argocd-server -n argocd 8088:443
    access it via http://localhost:8088 or https://<your-ip-address>:8088 (if you are using vm/ec2)
    
**ArgoCD credentials** 
    username - admin
    run the below command to get the initial password
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

**nginx app**
    kubectl port-forward svc/my-app-service 8082:80 -n default
    access it via http://localhost:8082 or https://<your-ip-address>:8082 (if you are using vm/ec2)
    
        
    Thank you for checking out. Feel free to contribute or raise issues if you find any. 🙂
