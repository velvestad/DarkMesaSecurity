## Variables for Hyper-V host
variable "host_ip" {
  type        = string
  description = "Hyper-V host IP"
}

variable "host_username" {
  type        = string
  description = "Hyper-V host username"
}

variable "host_password" {
  type        = string
  description = "Hyper-V host password"
}
