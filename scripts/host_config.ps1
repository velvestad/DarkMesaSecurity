# Placeholder file for host configuration script.
# This script is intended to be run on the hyper-visor host to configure the environment.

# Setup required directories
$requiredDirs = @(
    "C:\temp",
    "C:\packer\work"
)

foreach ($dir in $requiredDirs) {
    New-Item -Path $dir -ItemType Directory -Force
}


# Download packer
Invoke-WebRequest `
    -Uri "https://releases.hashicorp.com/packer/1.16.0/packer_1.16.0_windows_amd64.zip" `
    -OutFile "C:\temp\packer_1.16.0_windows_amd64.zip"

Expand-Archive `
    -Path "C:\temp\packer_1.16.0_windows_amd64.zip" `
    -DestinationPath "C:\packer" `
    -Force

Remove-Item `
    -Path "C:\temp\packer_1.16.0_windows_amd64.zip" `
    -Force

# Install OSCDIMG
winget install Microsoft.OSCDIMG --accept-source-agreements