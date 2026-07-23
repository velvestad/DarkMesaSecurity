# Hyper-V Host
OS:         Windows Server 2025 Datacenter
Hostname:   Srv2025-Vegeir

## Network Configuration
IP:         10.16.0.2
GW:         10.0.0.1
DNS:        10.0.0.10

## Configuration
Hyper-V Role installed
Virtual external switch configured (CLASSROOM-SW)
SSH enabled (also on public network)
WinRM enabled
ICMP ping answer enabled

## To-Do and consideration
- SSH: automate configuration, and certificate authentication only. Consider setting LAN net as private network when enabling SSH.
- Hyper-V and vSwitch configuration: Consider installation script, preconfigured image