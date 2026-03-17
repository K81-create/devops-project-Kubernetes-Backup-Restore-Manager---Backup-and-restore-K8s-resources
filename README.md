<<<<<<< HEAD
# Kubernetes Backup & Restore Manager

This project provides an automated system to backup and restore Kubernetes resources (Deployments, Services, ConfigMaps, Secrets, etc.) using Bash scripts, Docker, and Jenkins.

## Architecture 

1. **Backup/Restore Scripts**: Bash scripts `src/main/scripts/backup.sh` and `src/main/scripts/restore.sh` utilize `kubectl` to export and import resources as YAML files.
2. **Docker**: A `infrastructure/docker/Dockerfile` containerizes the environment, providing AWS CLI and `kubectl`.
3. **Jenkins**: A declarative pipeline `pipelines/Jenkinsfile` automates the backup process using the Docker image.

## Prerequisites

- Local Kubernetes cluster (e.g., [Minikube](https://minikube.sigs.k8s.io/docs/start/))
- `kubectl` installed on the host
- [Docker](https://docs.docker.com/get-docker/) installed
- [Jenkins](https://www.jenkins.io/download/) installed (Locally or via Docker)

## Setup Instructions

### 1. Test Application Deployment
Deploy a sample app to verify the backup and restore functionality:
```bash
kubectl create namespace devops-test
kubectl apply -f infrastructure/kubernetes/deployment.yaml -n devops-test
kubectl apply -f infrastructure/kubernetes/service.yaml -n devops-test
kubectl apply -f infrastructure/kubernetes/configmap.yaml -n devops-test
```

### 2. Manual Backup
Run the backup script and provide the target namespace:
```bash
chmod +x src/main/scripts/backup.sh
./src/main/scripts/backup.sh devops-test
```
This will create a timestamped folder inside the `backups/` directory containing YAML files for deployments, services, pods, etc.

### 3. Manual Restore
To test restoration, delete the resources:
```bash
kubectl delete namespace devops-test
kubectl create namespace devops-test
```
Then, restore from the backup directory:
```bash
chmod +x src/main/scripts/restore.sh
./src/main/scripts/restore.sh backups/devops-test_YYYYMMDD_HHMMSS
```
*Note: Replace `YYYYMMDD_HHMMSS` with the actual timestamped directory.*

## Jenkins Automation

1. Create a "Pipeline" project in Jenkins.
2. Under "Pipeline", select "Pipeline script from SCM" (Assuming you push this code to GitHub).
3. If testing locally, you can copy the contents of `Jenkinsfile` into the "Pipeline script" block directly.
4. Ensure Jenkins has permissions to run Docker and access the `~/.kube/config` for authentication.
5. Click **Build Now** to trigger an automated backup. Artifacts (YAML files) will be securely archived in Jenkins.
=======

