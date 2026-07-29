# Hyper-V Host
OS:         Windows Server 2025 Datacenter
Hostname:   Srv2025-Vegeir

## Configuration
- Hyper-V Role installed
- Virtual external switch configured (CLASSROOM-SW)
- SSH enabled (also on public network)
- WinRM enabled
- ICMP ping answer enabled
- Packer 1.16.0 installed
- OSCDIMG istalled

## Directories created
- `C:\Hyper-V\VMs`
- `C:\Hyper-V\vHDs` 
- `C:\ISOs`
- `C:\tfstate`
- `C:\temp`
- `C:\packer`


## To-Do and consideration
- SSH: automate configuration, and certificate authentication only. Consider setting LAN net as private network when enabling SSH.
- Hyper-V and vSwitch configuration: Consider installation script, preconfigured image