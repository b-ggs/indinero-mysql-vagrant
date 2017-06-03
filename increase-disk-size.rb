HOSTNAME = 'indinero-mysql-vagrant'
VMDK_FILENAME = 'ubuntu-xenial-16.04-cloudimg.vmdk'
VDI_FILENAME = 'ubuntu-xenial-16.04-cloudimg.vdi'
VBOX_STORAGE_CONTROLLER = 'SCSI'
VDI_SIZE = 81920

### Check vagrant machine status

puts 'Checking vagrant machine state...'

status = `vagrant status`.chomp

if status =~ /running/
  puts 'Vagrant machine is still running. Running `vagrant halt`...'
  `vagrant halt`
else
  puts 'All good! Proceeding...'
end

### Get VM directory

vbox_vm_directory = `VBoxManage list systemproperties | grep 'Default machine folder' | cut -b 24-`.chomp.strip
vbox_vm_name = `VBoxManage list vms | grep #{HOSTNAME} | awk -F'"' '$0=$2'`.chomp
indinero_vm_directory = File.join vbox_vm_directory, vbox_vm_name

### Convert .vmdk to .vdi

vmdk_path = File.join indinero_vm_directory, VMDK_FILENAME
vdi_path = File.join indinero_vm_directory, VDI_FILENAME

if !File.exists? vmdk_path
  puts 'VMDK does not exist. Exiting.'
  exit
elsif File.exists? vdi_path
  puts 'VDI already exists. Exiting.'
  exit
end

puts "Converting #{VMDK_FILENAME} to #{VDI_FILENAME}..."

`VBoxManage clonehd "#{vmdk_path}" "#{vdi_path}" --format VDI`

puts "Success!"

### Increase .vdi size

puts "Resizing #{VDI_FILENAME} to #{VDI_SIZE}..."

`VBoxManage modifymedium disk "#{vdi_path}" --resize #{VDI_SIZE}`

### Attach .vdi to virtual machine

puts "Attaching #{VDI_FILENAME} to #{vbox_vm_name}..."

`VBoxManage storageattach #{vbox_vm_name} --storagectl "#{VBOX_STORAGE_CONTROLLER}" --port 0 --device 0 --type hdd --medium "#{vdi_path}"`

### Remove old .vmdk

puts "Removing #{vmdk_path}..."

`rm #{vmdk_path}`

puts 'Done! You can now run `vagrant up`.'
