# Design Document: Kubernetes Backup & Restore Manager

## 1. Architecture Overview
The system is composed of three primary interconnected layers:
1. **Execution Scripts**: The foundation of the mechanism, directly interacting with the Kubernetes API via `kubectl` to manage resources.
2. **Containerized Environment**: A customized Docker image serving as an isolated, consistent runtime environment for the required tools (Kubernetes CLI).
3. **Orchestration Layer**: Jenkins automates the execution of the bash scripts inside a provisioned Docker container and handles storage of backup artifacts.

## 2. Component Design

### 2.1 Backup Script (`src/main/scripts/backup.sh`)
- Takes a target `namespace` as a command-line argument.
- Automates directory creation with timestamps: `backups/<namespace>_YYYYMMDD_HHMMSS`.
- Uses `kubectl get <resource> -n <namespace> -o yaml` for standard resources (Deployments, Services, ConfigMaps, Secrets, Ingress) and outputs them to independent files to provide modularity.
- Ensures cluster-specific or dynamically generated fields are not permanently baked in, facilitating cross-environment restoration if needed.

### 2.2 Restore Script (`src/main/scripts/restore.sh`)
- Accepts a `backup_directory` path as input from the executed backup run.
- Iterates sequentially through the stored YAML definitions.
- Applies the resources back to the designated Kubernetes cluster using `kubectl apply -f <file>`.

### 2.3 Jenkins Pipeline (`pipelines/Jenkinsfile`)
A declarative pipeline configured with the following stages:
- **Checkout**: Pulling the latest code repository from SCM.
- **Build Container**: Generating the Docker image defined in the `infrastructure/docker/Dockerfile`.
- **Execute Backup**: Running `src/main/scripts/backup.sh` inside the provisioned Docker container. It requires securely injecting the host's `~/.kube/config` (or using a service account) for cluster authentication.
- **Archive Artifacts**: Saving the resulting backup YAML files as Jenkins Build Artifacts for durability.

## 3. Security Considerations
- The Jenkins worker needs secure, restricted access to the cluster's `kubeconfig` or equivalent RBAC service accounts.
- Secrets are backed up in base-64 layout natively by `kubectl`; therefore, the backup folders and Jenkins artifacts must be protected using proper access permissions.
