# Test router
resource "hyperv_machine_instance" "pfsense_router" {
  name                                    = "pfsense-router"
  generation                              = 1
  memory_maximum_bytes                    = 2147483648
  memory_minimum_bytes                    = 1073741824
  memory_startup_bytes                    = 1073741824
  processor_count                         = 2
  dynamic_memory                          = true
  state                                   = "Running"

  vm_firmware {
    enable_secure_boot = "Off"

    boot_order {
      boot_type           = "HardDiskDrive"
      controller_number   = "0"
      controller_location = "0"
    }
  }

  # Connected to WAN/internet
  network_adaptors {
    name                                       = "NIC1"
    switch_name                                = "CLASSROOM-SW"
    dynamic_mac_address                        = true
  }

  # Connected to site2site WAN
  network_adaptors {
    name                                       = "NIC2"
    switch_name                                = hyperv_network_switch.wan_sw.name
    dynamic_mac_address                        = true
  }

  # Connected to LAN
  network_adaptors {
    name                                       = "NIC3"
    switch_name                                = hyperv_network_switch.switch_1.name
    dynamic_mac_address                        = true
  }

  hard_disk_drives {
    controller_type                 = "Scsi"
    controller_number               = "0"
    controller_location             = "0"
    path                            = hyperv_vhd.pfsense-router-disk1.path
  }
}

resource "hyperv_vhd" "pfsense-router-disk1" {
  path = "C:\\Hyper-V\\vHDs\\pfsense-router-disk1.vhdx"
  vhd_type = "Dynamic"
  size = 12884901888
}