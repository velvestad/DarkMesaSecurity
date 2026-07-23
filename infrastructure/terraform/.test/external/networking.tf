
resource "hyperv_network_switch" "classroom_sw" {
  name                                    = "CLASSROOM-SW"
  notes                                   = "Virtual switch for external network connectivity (internet)"
  switch_type                             = "External"
  net_adapter_names                       = ["Ethernet"] # This name is not tested
}

resource "hyperv_network_switch" "wan_sw" {
  name                                    = "WAN-SW"
  allow_management_os                     = false
  switch_type                             = "Private"
}