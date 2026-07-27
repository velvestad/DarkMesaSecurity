# Runner - Control Node
OS:         Ubuntu 24.04.4 LTS
Hostname:   Runner

Currently Hosted on Hyper-V host

## Configuration
- GitHub Actions agent
    - Configured as a deamon starting at boot.
- Terraform
- Python
    - pip
    - python-venv           
    - pywinrm (in venv") 

## To-do and considerations
- Create runner configuration script. Consider how to manage the key (secret).
- Uninstall Terraform and move to Actions version control.
- Consider uninstalling Python.