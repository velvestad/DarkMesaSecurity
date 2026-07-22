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