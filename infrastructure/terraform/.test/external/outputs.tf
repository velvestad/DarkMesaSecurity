output "external" {
  value = {
    classroom_sw_name = hyperv_network_switch.classroom_sw.name
    wan_sw_name       = hyperv_network_switch.wan_sw.name
  }
}