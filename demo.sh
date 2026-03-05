#!/bin/bash
# demo.sh - An automated walkthrough of the Kubernetes Backup & Restore Manager
# Run this script from the root of the project directory.

echo "============================================="
echo " Kubernetes Backup & Restore Manager Demo"
echo "============================================="
echo ""

echo "Step 1: Deploying the test application..."
echo "---------------------------------------------"
kubectl create namespace devops-test || echo "Namespace already exists"
kubectl apply -f infrastructure/kubernetes/deployment.yaml -n devops-test
kubectl apply -f infrastructure/kubernetes/service.yaml -n devops-test
kubectl apply -f infrastructure/kubernetes/configmap.yaml -n devops-test
echo "⏳ Waiting for pods to spin up..."
sleep 5
kubectl get all -n devops-test
echo ""
echo "Press Enter to proceed to Step 2..."
read -r

echo "Step 2: Running the automated backup..."
echo "---------------------------------------------"
chmod +x src/main/scripts/backup.sh
./src/main/scripts/backup.sh devops-test
echo ""
echo "✅ Backup complete. Listing generated backup files:"
LATEST_BACKUP=$(ls -td backups/devops-test_* 2>/dev/null | head -1)
ls -lh "$LATEST_BACKUP"
echo ""
echo "Press Enter to proceed to Step 3..."
read -r

echo "Step 3: Simulating a disaster (deleting the application)..."
echo "---------------------------------------------"
kubectl delete namespace devops-test
echo "⏳ Waiting for namespace termination..."
sleep 5
echo "Verifying resources are gone (should output nothing or not found error):"
kubectl get all -n devops-test
echo ""
echo "Press Enter to proceed to Step 4..."
read -r

echo "Step 4: Restoring the backup..."
echo "---------------------------------------------"
kubectl create namespace devops-test
chmod +x src/main/scripts/restore.sh
./src/main/scripts/restore.sh "$LATEST_BACKUP"
echo ""
echo "⏳ Waiting for pods to restart..."
sleep 5
echo "✅ Validating restored resources:"
kubectl get all -n devops-test
echo "============================================="
echo " Demo completed successfully!"
echo "============================================="
