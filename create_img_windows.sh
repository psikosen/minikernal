# Create a disk image
$diskImage = "mini-neokernel.img"
$sizeBytes = 64MB

# Create a new VHD
New-VHD -Path $diskImage -SizeBytes $sizeBytes -Fixed

# Mount the VHD
$disk = Mount-VHD -Path $diskImage -PassThru

# Initialize the disk, create a partition, and format it
Initialize-Disk -Number $disk.Number -PartitionStyle MBR
$partition = New-Partition -DiskNumber $disk.Number -UseMaximumSize -IsActive
Format-Volume -Partition $partition -FileSystem FAT32 -NewFileSystemLabel "NEOKERNEL"

# Get the drive letter of the mounted VHD
$driveLetter = ($partition | Get-Volume).DriveLetter

# Copy the kernel to the image
Copy-Item -Path "mini-neokernel.bin" -Destination "${driveLetter}:\"

# Dismount the VHD
Dismount-VHD -Path $diskImage

Write-Host "Bootable disk image created: $diskImage"