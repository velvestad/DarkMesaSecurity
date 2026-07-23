# Runner - Control Node
OS:         Ubuntu 24.04.4 LTS
Hostname:   Runner

Currently Hosted on Hyper-V host

## Network Configuration
IP:         10.16.0.3
GW:         10.0.0.1
DNS:        10.0.0.10

## Configuration
- GitHub Actions agent
    - Configured as a deamon starting at boot.
- Terraform
- Python
    - pip
    - python-venv           
    - pywinrm (in venv") 
- Ansible
    - ansible.windows (included in ansible-core)
    - microsoft.hyperv
- PowerShell


## To-do and considerations
- Create runner configuration script. Consider how to manage the key (secret).
- Uninstall Terraform and Ansible, and move to Actions version control for these.
- Consider uninstalling Python and Powershell. These are likely not needed.