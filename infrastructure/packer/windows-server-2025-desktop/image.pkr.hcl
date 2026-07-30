# Source: https://github.com/mfgjwaterman/Packer/tree/main

# ---------------------------------------------------------------------------
# Packer configuration / Required_plugins block
# https://developer.hashicorp.com/packer/integrations/hashicorp/hyperv/latest/components/builder/iso
# https://github.com/rgl/packer-plugin-windows-update
# Created: Michael Waterman
# Blog: https://michaelwaterman.nl
# Date: 29-04-2026
# Version: 1.1
# ---------------------------------------------------------------------------
packer {
  required_plugins {
    hyperv = {
      source  = "github.com/hashicorp/hyperv"
      version = ">= 1.1.5"
    }
    windows-update = {
      source  = "github.com/rgl/windows-update"
      version = ">= 0.18.1"
    }
  }
}

locals {
  build_date = formatdate("YYYY-MM-DD", timestamp())
}

# ---------------------------------------------------------------------------
# SOURCE: Windows Server 2025 Desktop on Hyper-V
# ---------------------------------------------------------------------------

source "hyperv-iso" "windows_server_2025_desktop" {
  vm_name = join(
    "-",
    [
      "build",
      "windows",
      "Standard",
      "2025",
      "Desktop Experience",
      "0.1.0"
    ]
  )

  # -------------------------------------------------------------------------
  # Base Guest OS information
  # -------------------------------------------------------------------------
  generation           = 2
  switch_name          = "CLASSROOM-SW"
  enable_secure_boot   = true
  secure_boot_template = "MicrosoftWindows"
  cpus                 = 2
  memory               = 4096
  disk_size            = 40960
  headless             = true

  # -------------------------------------------------------------------------
  # Bootable ISO
  # -------------------------------------------------------------------------
  iso_url      = "C:\\ISOs\\ws2025.iso"
  iso_checksum = "7B052573BA7894C9924E3E87BA732CCD354D18CB75A883EFA9B900EA125BFD51"
  boot_wait    = "-1s"
  boot_command = ["<spacebar>"]

  # -------------------------------------------------------------------------
  # Autounattend.xml
  # -------------------------------------------------------------------------
  cd_files = [
    "C:/packer/work/provisioning/pre-build/*"
  ]
  cd_label = "cidata"

  # -------------------------------------------------------------------------
  # WINRM / Communicator
  # -------------------------------------------------------------------------
  communicator   = "winrm"
  winrm_username = var.winrm_username
  winrm_password = var.winrm_password
  winrm_timeout  = "12h"
  winrm_use_ssl  = true
  winrm_insecure = true

  # -------------------------------------------------------------------------
  # Shutdown command
  # -------------------------------------------------------------------------
  shutdown_command = <<EOF
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$Action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-NoProfile -ExecutionPolicy Bypass -File C:\Windows\Temp\Invoke-ImageFinalization.ps1 -TargetRole Server'; $Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddSeconds(15); $Principal = New-ScheduledTaskPrincipal -UserId '${var.winrm_username}' -LogonType Password -RunLevel Highest; $Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Principal $Principal; Register-ScheduledTask -TaskName 'PackerImageFinalization' -InputObject $Task -User '${var.winrm_username}' -Password '${var.winrm_password}' -Force; Start-Sleep -Seconds 5; Start-ScheduledTask -TaskName 'PackerImageFinalization'; exit 0"
EOF

  shutdown_timeout = "30m"
  disable_shutdown = false

  # -------------------------------------------------------------------------
  # Output variables
  # -------------------------------------------------------------------------
  temp_path = "C:\\temp"
  output_directory = "C:\\Hyper-V\\vHDs\\golden"
}


# ---------------------------------------------------------------------------
# BUILD
# ---------------------------------------------------------------------------

build {
  name    = "windows_server_2025_desktop"
  sources = ["source.hyperv-iso.windows_server_2025_desktop"]

  # -------------------------------------------------------------------------
  # Windows Updates
  # -------------------------------------------------------------------------
    provisioner "windows-update" {
      search_criteria = "IsInstalled=0"
      filters = [
        "exclude:$_.Title -like '*Driver*'",
        "exclude:$_.Title -like '*Preview*'",
        "include:$true",
      ]
      update_limit = 50
    }

  # -------------------------------------------------------------------------
  # Create the scripts directory
  # -------------------------------------------------------------------------
  provisioner "powershell" {
    inline = [
      "if (-not (Test-Path 'C:\\Windows\\Setup\\Scripts')) { New-Item -Path 'C:\\Windows\\Setup\\Scripts' -ItemType Directory -Force | Out-Null }"
    ]
  }

  # -------------------------------------------------------------------------
  # Upload the unattended file
  # -------------------------------------------------------------------------
  # provisioner "file" {
  #  source      = "provisioning/post-build/unattend/unattend.xml"
  #  destination = "C:\\Windows\\System32\\Sysprep\\unattend.xml"
  #}

  # -------------------------------------------------------------------------
  # Upload the Invoke-ImageFinalization.ps1 file
  # -------------------------------------------------------------------------
  provisioner "file" {
    source      = "C:/packer/work/provisioning/build/Invoke-ImageFinalization.ps1"
    destination = "C:\\Windows\\temp\\Invoke-ImageFinalization.ps1"
  }

  # -------------------------------------------------------------------------
  # Upload the SetupComplete.cmd file
  # -------------------------------------------------------------------------
  # provisioner "file" {
  #  source      = "provisioning/post-build/setupcomplete/SetupComplete.cmd"
  #  destination = "C:\\Windows\\Setup\\Scripts\\SetupComplete.cmd"
  #}

  # -------------------------------------------------------------------------
  # Cleanup image
  # -------------------------------------------------------------------------
  provisioner "powershell" {
    script = "C:/packer/work/provisioning/build/Cleanup-For-Image.ps1"
  }
}