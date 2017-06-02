#!/usr/bin/env bash
sudo apt-get update

sudo apt-get -y install libaio1

tar -xvf /vagrant/external/mysql-server_5.6.36-1ubuntu14.04_amd64.deb-bundle.tar -C /vagrant/external

sudo dpkg -i /vagrant/external/mysql-common_5.6.36-1ubuntu14.04_amd64.deb
sudo dpkg -i /vagrant/external/mysql-community-client_5.6.36-1ubuntu14.04_amd64.deb
sudo dpkg -i /vagrant/external/mysql-client_5.6.36-1ubuntu14.04_amd64.deb
sudo dpkg -i /vagrant/external/libmysqlclient18_5.6.36-1ubuntu14.04_amd64.deb

sudo debconf-set-selections <<< 'mysql-community-server mysql-community-server/root-pass password password'
sudo debconf-set-selections <<< 'mysql-community-server mysql-community-server/re-root-pass password password'
sudo dpkg-preconfigure /vagrant/external/mysql-community-server_5.6.36-1ubuntu14.04_amd64.deb
sudo dpkg -i /vagrant/external/mysql-community-server_5.6.36-1ubuntu14.04_amd64.deb

# TODO: link this instead?
sudo cp /vagrant/configs/my.cnf /etc/mysql 

mysql -u root -ppassword -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;"
sudo service mysql restart
