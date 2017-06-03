HOSTNAME = 'indinero-mysql-vagrant'
VMDK_FILENAME = 'ubuntu-xenial-16.04-cloudimg.vmdk'
VDI_FILENAME = 'ubuntu-xenial-16.04-cloudimg.vmdk'

### Get VM directory

virtualbox_vm_directory = `VBoxManage list systemproperties | grep 'Default machine folder' | cut -b 24-`.chomp.strip
virtualbox_vm_name = `VBoxManage list vms | grep #{HOSTNAME} | awk -F'"' '$0=$2'`.chomp
indinero_vm_directory = File.join virtualbox_vm_directory, virtualbox_vm_name

p indinero_vm_directory

### Convert .vmdk to .vdi

vmdk_path = File.join indinero_vm_directory + VMDK_FILENAME
vdi_path = File.join indinero_vm_directory + VDI_FILENAME

`VBoxManage clonehd #{vmdk_path} #{vdi_path} --format VDI`

### Attach .vdi to virtual machine