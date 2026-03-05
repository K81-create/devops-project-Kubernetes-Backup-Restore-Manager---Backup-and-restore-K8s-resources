# Powershell script to install required dependencies for the DevOps project
Write-Host "Starting Installation of DevOps Tools (Docker, Minikube, Kubectl)..."

# Check if running as Admin
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator to install Docker Desktop and Minikube."
    exit 1
}

# Install Docker Desktop
Write-Host "Installing Docker Desktop..."
winget install -e --id Docker.DockerDesktop --accept-package-agreements --accept-source-agreements

# Install Minikube
Write-Host "Installing Minikube..."
winget install -e --id Kubernetes.minikube --accept-package-agreements --accept-source-agreements

# Install Kubectl
Write-Host "Installing Kubectl..."
winget install -e --id Kubernetes.kubectl --accept-package-agreements --accept-source-agreements

Write-Host "------------------------------------------------------------------"
Write-Host "Installation completed."
Write-Host "IMPORTANT: You MUST RESTART your computer to complete the Docker Desktop installation."
Write-Host "After restarting, open Docker Desktop to ensure it finishes its initial setup."
Write-Host "Then, open a new terminal in this project folder and run: minikube start"
