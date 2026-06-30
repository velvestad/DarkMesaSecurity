variable "srv_usr" {
  description = "Username for Hyper-V host"
  type        = string
  sensitive   = true
}

variable "srv_pwd" {
  description = "Password for Hyper-V host"
  type        = string
  sensitive   = true
}