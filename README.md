# Kubernetes Backup & Restore Manager – DevOps Project

**Student Name:** Khushi Singhal  
**Registration No:** 23FE10CSE00682 
**Course:** CSE3253 DevOps [PE6]  
**Semester:** VI (2025–2026)  
**Project Type:** Kubernetes Automation + CI/CD  
**Difficulty:** Intermediate  

---

**Project Overview**

This project demonstrates **automated backup and restoration of Kubernetes resources** using DevOps tools such as **Bash scripts, Docker, and Jenkins pipelines**.

The system allows DevOps engineers to safely store Kubernetes resource configurations and restore them if they are accidentally deleted or if the cluster fails.

The project exports Kubernetes resources as **YAML files** and stores them in timestamped backup folders. These backups can later be used to restore deployments, services, and configurations.

To make the project more practical, it includes:

- A sample Kubernetes application deployment for testing backups  
- Backup automation using Bash scripts (`backup.sh`)  
- Restore automation using Bash scripts (`restore.sh`)  
- Docker containerization for consistent execution environment  
- Jenkins pipeline for automated backup operations  

---

**Problem Statement**

In Kubernetes environments, accidental deletion of resources or configuration failures can cause application downtime.

Manual backups are time-consuming and error-prone.

This project integrates **automated Kubernetes backups into a DevOps workflow**, ensuring that resources can be restored quickly and system reliability is maintained.

---

**Key Features**

- Automated Kubernetes resource backup using `kubectl`  
- Restore Kubernetes resources from YAML backup files  
- Namespace-based backup management  
- Timestamped backup folders  
- Dockerized environment for consistent execution  
- CI/CD pipeline automation using Jenkins  
- Disaster recovery for Kubernetes resources  

---

**Tech Stack**

**Runtime / Environment**
- Kubernetes (Minikube)  

**Automation**
- Bash scripting  

**DevOps Tools**
- Git + GitHub  
- Docker  
- Jenkins  
- kubectl  

**Configuration**
- YAML  

---

**Getting Started (Local Setup)**

**Prerequisites**

- Minikube  
- kubectl  
- Docker Desktop  
- Git  
- Jenkins (optional for automation)  

---

**Start Kubernetes Cluster**

```bash
minikube start
```

**Then Verify**
```bash
kubectl get nodes
```

**Go to Your Project Folder**
```bash
cd "C:\Users\khushi\OneDrive\Desktop\DevOps project"
```

**Deploy the Test Application**
```bash
kubectl create namespace devops-test
kubectl apply -f test-app/nginx.yaml -n devops-test
```
**Then verify**
```bash
kubectl get all -n devops-test
```

**Run Backup**
```bash
kubectl get all -n devops-test -o yaml > backup.yaml
```

**Simulate Failure**
```bash
kubectl delete namespace devops-test
```
**Restore From Backup**
```bash
kubectl create namespace devops-test
```

**Restore resources**
```bash
kubectl apply -f backup.yaml -n devops-test
```
**Verify Restore**
```bash
kubectl get all -n devops-test
```



  

