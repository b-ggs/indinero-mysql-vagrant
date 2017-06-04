# indinero-mysql-vagrant

A simple Vagrant box with MySQL.

A fork of [b-ggs/mysql-vagrant](https://github.com/b-ggs/mysql-vagrant) used for development on inDinero.

## Requirements

* MySQL 5.6 for Ubuntu (`mysql-server_5.6.36-1ubuntu14.04_amd64.deb-bundle.tar`) to be downloaded from https://dev.mysql.com/downloads/mysql/5.6.html

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

```sh
mysql -h 127.0.0.1 -P 33060 -u root -p
```

## Populating database with `presko`

```sh
presko -database indinero_production -user root -p password -port 33060 -tables all
```

## Usage with Rails

`config/database.yml`

```ruby
default: &default
  adapter: mysql2
  username: root
  password: password
  host: 127.0.0.1
  port: 33060
  pool: 5
  timeout: 5000

test:
  <<: *default
  database: indinero_test

development:
  <<: *default
  database: indinero_production
```
