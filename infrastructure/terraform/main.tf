terraform {
  required_providers {
    hyperv = {
      source = "taliesins/hyperv"
      version = ">= 0.1.0"
    }
  }
}

provider "hyperv" {
  # Connection details to Hyper-V host
  host                  = "10.16.0.2"
  https                 = false 
  port                  = 5985
  insecure              = true
  use_ntlm              = true

  user                  = var.srv_usr
  password              = var.srv_pwd
}