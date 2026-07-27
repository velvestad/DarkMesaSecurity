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
  
  # Hyper-V defaults for CPU
  vm_processor {
    compatibility_for_migration_enabled               = false
    compatibility_for_older_operating_systems_enabled = false
    enable_host_resource_protection                   = false
    expose_virtualization_extensions                  = false
    hw_thread_count_per_core                          = 0
    maximum                                           = 100
    maximum_count_per_numa_node                       = 12
    maximum_count_per_numa_socket                     = 1
    relative_weight                                   = 100
    reserve                                           = 0
  }

  # Connected to WAN/internet
  network_adaptors {
    name                                       = "NIC1"
    switch_name                                = var.external.classroom_sw_name
    dynamic_mac_address                        = true
  }

  # Connected to site2site WAN
  network_adaptors {
    name                                       = "NIC2"
    switch_name                                = var.external.wan_sw_name
    dynamic_mac_address                        = true
  }

  # Connected to LAN
  network_adaptors {
    name                                       = "NIC3"
    switch_name                                = hyperv_network_switch.switch_1.name
    dynamic_mac_address                        = true
  }

  network_adaptors {
    name                                       = "NIC4"
    dynamic_mac_address                        = true
  }

  hard_disk_drives {
    controller_type                 = "Ide"
    controller_number               = "0"
    controller_location             = "0"
    path                            = hyperv_vhd.pfsense-router-disk1.path
  }

  hard_disk_drives {
    controller_type                 = "Ide"
    controller_number               = "0"
    controller_location             = "1"
    path                            = hyperv_vhd.pfsense-router-config-drive.path
  }
}

resource "hyperv_vhd" "pfsense-router-disk1" {
  path = "C:\\Hyper-V\\vHDs\\pfsense-router-disk1.vhdx"
  #vhd_type = "Dynamic"
  #size = 12884901888

  source = "C:\\Hyper-V\\vHDs\\golden\\pfsense-golden.vhdx"
}

resource "hyperv_vhd" "pfsense-router-config-drive" {
  path = "C:\\Hyper-V\\vHDs\\pfsense-router-config-drive.vhdx"
  source = "C:\\Hyper-V\\vHDs\\pfsense_config_drives\\pfsense-router-config-drive.vhdx"
  
  # My script generates a fixed size VHDX, but terraform sees a dynamic. 
  # Will look into this if loading the config drive fails.
  #vhd_type = "Fixed"

  /*
  size = 67108864
  block_size           = 0
  logical_sector_size  = 512
  physical_sector_size = 4096
  */
}