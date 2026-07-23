
resource "hyperv_network_switch" "classroom_sw" {
  name                                    = "CLASSROOM-SW"
  notes                                   = "Virtual switch for external network connectivity (internet)"
  switch_type                             = "External"
  net_adapter_names                       = "Ethernet" # This name is not tested
  
  # Hyper-V default switch settings
  default_flow_minimum_bandwidth_absolute = 100000000
  default_queue_vmmq_enabled              = true
  default_queue_vrss_enabled              = true
  minimum_bandwidth_mode                  = "Absolute"
}

resource "hyperv_network_switch" "wan_sw" {
  name                                    = "WAN-SW"
  allow_management_os                     = false
  switch_type                             = "Private"
}