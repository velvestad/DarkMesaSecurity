variable "external" {
  type = object({
    classroom_sw_name = string
    wan_sw_name       = string
  })
}