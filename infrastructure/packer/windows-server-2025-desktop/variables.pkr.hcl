variable "vm_description" {
  type    = string
  default = "Windows Server 2025 Standard Desktop Experience"
}


variable "winrm_username" {
  type    = string
  default = "Administrator"
}

variable "winrm_password" {
  type      = string
  default   = "PackerTest123!"
  sensitive = true
}
