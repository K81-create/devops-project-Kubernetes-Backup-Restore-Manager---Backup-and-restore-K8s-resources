# User Guide: Kubernetes Backup & Restore Manager

## 1. Prerequisites
Ensure you have the following installed on your machine/server before beginning:
- [Minikube](https://minikube.sigs.k8s.io/docs/start/) or any local/cloud Kubernetes cluster.
- `kubectl` CLI tool, configured to talk to your cluster.
- Docker Engine for containerization.
- Jenkins (Local installation or Dockerized pipeline orchestrator).

## 2. Deploying the Test Application
To verify backups, first deploy our sample application:
```bash
kubectl create namespace devops-test
kubectl apply -f infrastructure/kubernetes/deployment.yaml -n devops-test
kubectl apply -f infrastructure/kubernetes/service.yaml -n devops-test
kubectl apply -f infrastructure/kubernetes/configmap.yaml -n devops-test
```
You can verify it’s running with: `kubectl get all -n devops-test`.

## 3. Performing a Manual Backup
1. Navigate to the project root directory.
2. Make the script executable: 
   ```bash
   chmod +x src/main/scripts/backup.sh
   ```
3. Run the script with the target namespace you wish to backup:
   ```bash
   ./src/main/scripts/backup.sh devops-test
   ```
4. A new directory will be created under `backups/` containing your exported YAML files (e.g., `backups/devops-test_20260305_120000`).

## 4. Performing a Manual Restore
1. If simulating a disaster, delete the existing namespace to clear all resources:
   ```bash
   kubectl delete namespace devops-test
   kubectl create namespace devops-test
   ```
2. Make the restore script executable:
   ```bash
   chmod +x src/main/scripts/restore.sh
   ```
3. Run the script passing the previously created backup directory:
   ```bash
   ./src/main/scripts/restore.sh backups/devops-test_YYYYMMDD_HHMMSS
   ```
   *(Make sure to replace `YYYYMMDD_HHMMSS` with your specific backup folder's timestamp)*

## 5. Automated Backups via Jenkins
To fully automate backup operations on a schedule:
1. Create a **Pipeline** project in your Jenkins dashboard.
2. In the Pipeline section, choose **Pipeline script from SCM** and link your Git repository.
3. Ensure the Jenkins node has correct permissions to execute Docker commands and map your `~/.kube/config` appropriately.
4. Trigger a build manually or wait for the scheduled cron job. 
5. Once successful, navigate to the build's **Artifacts** to download your packaged backup YAML configurations securely safely stored in Jenkins.
