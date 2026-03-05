#!/bin/bash

# Configuration
BACKUP_DIR="${1}"

if [ -z "${BACKUP_DIR}" ]; then
    echo "Error: Please provide the path to the backup directory."
    echo "Usage: ./restore.sh <path_to_backup_directory>"
    exit 1
fi

if [ ! -d "${BACKUP_DIR}" ]; then
    echo "Error: Directory ${BACKUP_DIR} does not exist."
    exit 1
fi

echo "Starting Kubernetes Restoration from directory: ${BACKUP_DIR}"

# First apply resources that don't depend on others typically: Secrets, ConfigMaps
PRE_RESOURCES=("secrets.yaml" "configmaps.yaml")

for FILE in "${PRE_RESOURCES[@]}"; do
    if [ -f "${BACKUP_DIR}/${FILE}" ]; then
        echo "Restoring ${FILE}..."
        kubectl apply -f "${BACKUP_DIR}/${FILE}"
    fi
done

# Then apply the rest of the YAMLs (skip the pre resources as they are already applied)
for YAML_FILE in "${BACKUP_DIR}"/*.yaml; do
    BASENAME=$(basename "$YAML_FILE")
    
    # Skip if it is already deployed
    if [[ " ${PRE_RESOURCES[*]} " =~ " ${BASENAME} " ]]; then
        continue
    fi

    echo "Restoring ${BASENAME}..."
    kubectl apply -f "${YAML_FILE}"
done

echo "Restoration from ${BACKUP_DIR} completed."
