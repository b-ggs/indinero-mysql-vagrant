# mysql-vagrant

A simple vagrant box with MySQL.

## Requirements

* MySQL 5.6 for Ubuntu Linux (`mysql-server_5.6.36-1ubuntu14.04_amd64.deb-bundle.tar`) to be downloaded from https://dev.mysql.com/downloads/mysql/5.6.html

## Getting started

1. Clone this repository

2. Place `mysql-server_5.6.36-1ubuntu14.04_amd64.deb-bundle.tar` into the `external` directory

3. Run `vagrant up` to let Vagrant initialize the VM and install MySQL and its dependencies

4. Run `ruby increase-disk-size.rb` to convert the generated VMDK to VDI, and resize the disk from 10 GB to 80 GB

5. Run `vagrant up` when prompted to start using the machine

## Connecting to MySQL

Host: `127.0.0.1`

User: `root`

Password: `password`

Port: `33060`

---
_Note: Only be used for development purposes._
