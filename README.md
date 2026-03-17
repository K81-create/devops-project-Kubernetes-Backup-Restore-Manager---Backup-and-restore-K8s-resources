Kubernetes Backup & Restore Manager – DevOps Project

Student Name: Khushi Singhal
Registration No: [Your Registration Number]
Course: CSE3253 DevOps [PE6]
Semester: VI (2025–2026)
Project Type: Kubernetes Automation + CI/CD
Difficulty: Intermediate

Project Overview

This project demonstrates automated backup and restoration of Kubernetes resources using DevOps tools such as Bash scripting, Docker, and Jenkins pipelines.

The system allows administrators to safely store Kubernetes resource configurations and restore them in case of accidental deletion, cluster failure, or configuration errors.

The project automates backup operations by exporting Kubernetes resources as YAML configuration files and storing them in timestamped backup folders.

To make the project more practical and closer to real DevOps workflows, it includes:

A sample Kubernetes application deployment for testing backups

Backup and restore automation using Bash scripts

Docker containerization for consistent execution environments

Jenkins CI/CD pipeline for automated backup processes

Problem Statement

In Kubernetes environments, losing resource configurations due to misconfiguration, accidental deletion, or system failure can cause significant downtime.

Traditional backups are often manual and inconsistent.

This project solves the problem by implementing an automated Kubernetes backup and restore system, allowing DevOps teams to:

Regularly back up cluster resources

Restore applications quickly

Integrate backup processes into CI/CD pipelines

Key Features

Automated Kubernetes resource backup using kubectl

Restore Kubernetes resources from YAML backups

Namespace-based backup management

Timestamped backup directories

Dockerized execution environment

Jenkins pipeline automation for backup jobs

Disaster recovery for Kubernetes resources

Technology Stack
Core Technologies

Kubernetes (Minikube)

Bash scripting

YAML configuration files

DevOps Tools

Version Control: Git + GitHub

Containerization: Docker

CI/CD Pipeline: Jenkins

Kubernetes CLI: kubectl

Getting Started (Local Setup)
Prerequisites

Make sure the following tools are installed:

Docker Desktop

Minikube

kubectl

Git

Jenkins (optional for CI/CD automation)

Start Kubernetes Cluster
minikube start

Verify cluster:

kubectl get nodes
Deploy Test Application

Create a namespace:

kubectl create namespace devops-test

Deploy the Kubernetes resources:

kubectl apply -f infrastructure/kubernetes/deployment.yaml -n devops-test
kubectl apply -f infrastructure/kubernetes/service.yaml -n devops-test
kubectl apply -f infrastructure/kubernetes/configmap.yaml -n devops-test

Verify deployment:

kubectl get all -n devops-test
Run Backup Script

Make the script executable:

chmod +x src/main/scripts/backup.sh

Run the backup:

./src/main/scripts/backup.sh devops-test

The script will create a timestamped folder inside:

backups/

Example:

backups/devops-test_20260318_143200/

The folder contains YAML files representing Kubernetes resources.

Restore Resources from Backup

Delete the namespace (for testing recovery):

kubectl delete namespace devops-test
kubectl create namespace devops-test

Run the restore script:

chmod +x src/main/scripts/restore.sh
./src/main/scripts/restore.sh backups/devops-test_TIMESTAMP

The script recreates the Kubernetes resources from the stored YAML files.

Docker Usage

Build the Docker image:

docker build -t k8s-backup-manager .

Run the container:

docker run k8s-backup-manager

Docker ensures the backup environment runs consistently across systems.

CI/CD Pipeline Behavior

The Jenkins pipeline automates the backup process.

Pipeline stages:

Clone project repository

Build Docker image

Execute backup script

Archive backup files as Jenkins artifacts

This enables continuous backup operations in a DevOps environment.

Project Structure (Important Folders)
src/main/scripts/
backup.sh
restore.sh

infrastructure/docker/
Dockerfile

infrastructure/kubernetes/
deployment.yaml
service.yaml
configmap.yaml

pipelines/
Jenkinsfile

docs/
project-plan.md
design-document.md
user-guide.md
Advantages of the System

Automated Kubernetes configuration backup

Quick disaster recovery

Reduced manual DevOps work

CI/CD integration with Jenkins

Portable environment using Docker

Future Improvements

Scheduled automatic backups

Cloud backup storage (AWS S3 / Google Cloud Storage)

Monitoring integration (Prometheus / Nagios)

Backup encryption

Multi-cluster backup support

