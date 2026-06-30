resource "hyperv_network_switch" "PrivateNetwork" {
  name                                    = "Private Network"
  switch_type                             = "Private"
  net_adapter_names                       = []
  allow_management_os                     = false
}

resource "hyperv_network_switch" "ClassroomNetwork" {
  name                                    = "Classroom Network"
  switch_type                             = "External"
  net_adapter_names                       = ["Ethernet"]
  allow_management_os                     = true
}