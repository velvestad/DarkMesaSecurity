packer {
  required_plugins {
    hyperv = {
      source  = "github.com/hashicorp/hyperv"
      version = "1.1.5"
    }
  }
}

source "hyperv-iso" "windows_server_2025_desktop" {

  vm_name = "ws2025-desktop-build"
  generation = 2
  cpus   = 2
  memory = 4096 # Added more memory than project requirements. For OS installation.
  switch_name = "CLASSROOM-SW"
  iso_url  = "c:\\ISOs\\ws2025.iso"
  iso_checksum = "none"
  communicator = "winrm"
  winrm_username = "packer"
  winrm_password = "PackerPassword123!"
  winrm_timeout  = "4h"
  winrm_use_ssl  = false
  winrm_insecure = true
  enable_secure_boot = true
  shutdown_command = "shutdown /s /t 10 /f"
  shutdown_timeout = "30m"
  boot_wait = "10s"

cd_files = ["./unattend.xml"]
cd_label = "cidata"

  output_directory = "packer_output"

  disk_size = "40960"
}

build {
  sources = [
    "source.hyperv-iso.windows_server_2025_desktop"
  ]
  /*
  provisioner "powershell" {
    scripts = [
      "scripts/01-enable-winrm.ps1"
    ]
  }

  provisioner "powershell" {
    scripts = [
      "scripts/02-windows-update.ps1"
    ]
  }

  provisioner "powershell" {
    scripts = [
      "scripts/99-sysprep.ps1"
    ]
  }
  */
}