# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/xenial64'
  config.vm.box_check_update = false
  config.vm.hostname = 'indinero-mysql-vagrant'
  config.vm.network :forwarded_port, guest: 3306, host: 33060
  config.vm.provision :shell, path: 'install.sh'
  config.vm.synced_folder '.', '/vagrant', mount_options: ['dmode=777', 'fmode=666']
  config.vm.provider 'virtualbox' do |v|
    v.memory = 4096
    v.cpus = 2
  end
end
