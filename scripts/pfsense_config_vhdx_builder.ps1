# Create a Virtual Hard Drive with pfSense configuration files
param(
    # Path to the pfSense configuration files
    [Parameter(Mandatory=$true)]
    [string]$ConfigPath,
    
    # Name of output VHDX file (without extension)
    [Parameter(Mandatory=$true)]
    [string]$DriveName
)


# Create the VHD
Set-Location C:\Temp
New-VHD -Path ".\${DriveName}.vhdx" -SizeBytes 64MB -Fixed

# Mount the VHD
Mount-VHD -Path ".\${DriveName}.vhdx"

# Get the disk number of the mounted VHD
$vhd = Get-Disk | Where-Object -Property PartitionStyle -eq "RAW"

# Initialize the disk
Initialize-Disk -Number $vhd.Number -PartitionStyle MBR

# Create a new partition and format it
$drive = New-Partition -DiskNumber $vhd.Number -MbrType FAT32 -UseMaximumSize -AssignDriveLetter `
    | Format-Volume -FileSystem FAT32 -NewFileSystemLabel "CONFIG" -Confirm:$false

# Copy the configuration files to the VHD
$drive = $drive.DriveLetter
New-Item -Path "${drive}:\config" -ItemType Directory -Force
Copy-Item -Path $ConfigPath -Destination "${drive}:\config\" -Force

# Dismount the VHD
Dismount-VHD -DiskNumber $vhd.Number

# Copy the VHD to the output directory
Copy-Item -Path ".\${DriveName}.vhdx" -Destination C:\Hyper-V\vHDs\pfsense_config_drives -Force

# Clean up temporary files
Remove-Item -Path ".\${DriveName}.vhdx" -Force