resource "hyperv_vhd" "Ubuntu-core-disk3" {
  path = "C:\\Hyper-V\\vHDs\\tf-ubuntu-01-disk1.vhdx"
  vhd_type = "Dynamic"
  size = 10737418240
}

resource "hyperv_machine_instance" "tf-ubuntu-01" {
  name                     = "tf-ubuntu-01"
  generation               = 2
  memory_startup_bytes     = 2147483648   # 2GB
  processor_count          = 2
  dynamic_memory           = true
  state                   = "Off"

  hard_disk_drives {
    path = hyperv_vhd.Ubuntu-core-disk3.path
    controller_type        = "Scsi"
    controller_number      = "0"
    controller_location    = "0"
  }
}