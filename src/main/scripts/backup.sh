#!/bin/bash

# Configuration
NAMESPACE="${1:-default}"
BACKUP_DIR="backups/${NAMESPACE}_$(date +%Y%m%d_%H%M%S)"
# Additional resources can be added to this array
RESOURCES=("deployments" "services" "pods" "configmaps" "secrets" "statefulsets" "daemonsets")

echo "Starting Kubernetes Backup for namespace: ${NAMESPACE}"
echo "Backup Directory: ${BACKUP_DIR}"

# Create backup directory
mkdir -p "${BACKUP_DIR}"

# Export resources
for RESOURCE in "${RESOURCES[@]}"; do
    echo "Exporting ${RESOURCE}..."
    kubectl get "${RESOURCE}" -n "${NAMESPACE}" -o yaml > "${BACKUP_DIR}/${RESOURCE}.yaml"
    
    # Check if the export was successful and if there are resources exported (not just the empty List)
    if [ $? -eq 0 ]; then
        # Check if the generated YAML is just an empty List object
        ITEMS_COUNT=$(grep -c "items: \[\]" "${BACKUP_DIR}/${RESOURCE}.yaml" || echo 0)
        if [ "$ITEMS_COUNT" -gt 0 ]; then
             echo "  No ${RESOURCE} found in namespace ${NAMESPACE}. Removing empty file."
             rm -f "${BACKUP_DIR}/${RESOURCE}.yaml"
        else
             echo "  Successfully exported ${RESOURCE}."
        fi
    else
        echo "  Failed to export ${RESOURCE}."
        rm -f "${BACKUP_DIR}/${RESOURCE}.yaml"
    fi
done

echo "Backup completed successfully!"
echo "Files are saved in: ${BACKUP_DIR}"
