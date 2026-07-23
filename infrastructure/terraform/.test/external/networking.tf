
resource "hyperv_network_switch" "classroom_sw" {
  name                                    = "CLASSROOM-SW"
  switch_type                             = "External"
  allow_management_os                     = true
  net_adapter_names                       = ["Ethernet",]
  
  # Hyper-V default switch settings
  default_flow_minimum_bandwidth_absolute = 100000000
  default_queue_vmmq_enabled              = true
  default_queue_vrss_enabled              = true
  minimum_bandwidth_mode                  = "Absolute"

  # There seems to be a bug with the provider. Single nic names inside the net_adapter_names list makes "terraform apply" fail.
  # Using this to ignore changes to the net_adapter_names list.
  lifecycle {
    ignore_changes = [
      net_adapter_names
    ]
  }
}

resource "hyperv_network_switch" "wan_sw" {
  name                                    = "WAN-SW"
  allow_management_os                     = false
  switch_type                             = "Private"
}