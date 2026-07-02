# Used to test the Hyper-V provider for Terraform.

terraform {
  required_providers {
    hyperv = {
      source = "taliesins/hyperv"
      version = ">= 0.1.0"
    }
  }
}

provider "hyperv" {
  host     = var.host_ip
  port     = 5986
  https    = true
  insecure = true

  user = var.host_username
  password = var.host_password
}

resource "hyperv_vhd" "Ubuntu-core-disk3" {
  path = "C:\\Hyper-V\\vHDs\\tf-ubuntu-01-disk1.vhdx"
  vhd_type = "Dynamic"
  size = 10737418240
}

resource "hyperv_machine_instance" "ubuntu_vm" {
  name                     = "tf-ubuntu-01"
  generation               = 2
  memory_startup_bytes     = 2147483648   # 2GB
  processor_count          = 2
  dynamic_memory           = true

  hard_disk_drives {
    path = hyperv_vhd.Ubuntu-core-disk3.path
    controller_type        = "Scsi"
    controller_number      = "0"
    controller_location    = "0"
  }
}