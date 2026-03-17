Kubernetes Backup & Restore Manager – DevOps Project
Student Name: Khushi Singhal
Registration No: 23FE10CSE00682
Course: CSE3253 DevOps 
Semester: VI (2025–2026)
Project Type: Kubernetes Automation + CI/CD
Difficulty: Intermediate
1. Project Overview
This project demonstrates automated backup and restoration of Kubernetes resources using DevOps tools such as Bash scripts, Docker, and Jenkins pipelines. The system allows DevOps engineers to safely store Kubernetes resource configurations and restore them if they are accidentally deleted or if the cluster fails.
The project exports Kubernetes resources as YAML files and stores them in timestamped backup folders. These backups can later be used to restore deployments, services, and configurations.
2. Problem Statement
In Kubernetes environments, accidental deletion of resources or configuration failures can cause application downtime. Manual backups are time‑consuming and error‑prone. This project integrates automated Kubernetes backups into a DevOps workflow, ensuring that resources can be restored quickly and system reliability is maintained.
3. Key Features
•	Automated Kubernetes resource backup using kubectl
•	Restore Kubernetes resources from YAML backup files
•	Namespace-based backup management
•	Timestamped backup folders
•	Dockerized environment for consistent execution
•	CI/CD pipeline automation using Jenkins
•	Disaster recovery for Kubernetes resources
4. Technology Stack
Runtime / Environment: Kubernetes (Minikube)
Automation: Bash scripting
DevOps Tools: Git, GitHub, Docker, Jenkins, kubectl
Configuration: YAML
5. Getting Started (Local Setup)
Prerequisites: Minikube, kubectl, Docker Desktop, Git, Jenkins (optional).
6. Start Kubernetes Cluster
Command: minikube start
7. Deploy Test Application
kubectl create namespace devops-test
kubectl apply -f infrastructure/kubernetes/deployment.yaml -n devops-test
kubectl apply -f infrastructure/kubernetes/service.yaml -n devops-test
kubectl apply -f infrastructure/kubernetes/configmap.yaml -n devops-test
8. Backup Process
Run backup script: ./src/main/scripts/backup.sh devops-test
The script creates a timestamped folder inside the backups directory and stores YAML files representing Kubernetes resources.
9. Restore Process
Delete namespace and recreate it.
Run restore script: ./src/main/scripts/restore.sh backups/devops-test_timestamp
10. Docker Usage
Build Docker image: docker build -t k8s-backup-manager .
Run container: docker run k8s-backup-manager
11. CI/CD Pipeline Behavior
1.	Clone project repository
2.	Build Docker image
3.	Execute backup script
4.	Archive backup files as Jenkins artifacts
12. Project Structure
•	src/main/scripts/ (backup.sh, restore.sh)
•	infrastructure/docker/ (Dockerfile)
•	infrastructure/kubernetes/ (deployment.yaml, service.yaml, configmap.yaml)
•	pipelines/ (Jenkinsfile)
•	docs/ (project-plan.md, design-document.md, user-guide.md)
13. Advantages
•	Automated Kubernetes configuration backup
•	Quick disaster recovery
•	CI/CD integration using Jenkins
•	Consistent environment using Docker
•	Simple and easy restoration process
14. Future Improvements
•	Automated scheduled backups
•	Cloud storage integration (AWS S3 / GCP)
•	Monitoring integration (Prometheus / Nagios)
•	Backup encryption
•	Multi-cluster backup support
