resource "hyperv_network_switch" "default" {
  name                                    = ""
  notes                                   = ""
  allow_management_os                     = true # Must be false for private switches
  enable_embedded_teaming                 = false
  enable_iov                              = false
  enable_packet_direct                    = false
  minimum_bandwidth_mode                  = "None"
  switch_type                             = "Internal" # Edit as needed: "Private", "Internal", "External"
  net_adapter_names                       = [] # Add names of NICs to bind to this switch
                                               # Single NIC name inside the array does not work. Will test if using no [] works.
  default_flow_minimum_bandwidth_absolute = 0
  default_flow_minimum_bandwidth_weight   = 0
  default_queue_vmmq_enabled              = false
  default_queue_vmmq_queue_pairs          = 16
  default_queue_vrss_enabled              = false
}