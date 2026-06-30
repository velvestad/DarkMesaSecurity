resource "hyperv_vhd" "web_server_vhd" {
  path = "c:\\Hyper-V\\VHDs\\driveName.vhdx"
  #source               = ""
  #source_vm            = ""
  #source_disk          = 0
  vhd_type = "Dynamic"
  #parent_path          = ""
  size = 10737418240 #10GB
  #block_size           = 0
  #logical_sector_size  = 0
  #physical_sector_size = 0
}