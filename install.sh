#!/usr/bin/env bash
sudo apt-get update

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
sudo apt-get -y install mysql-server

# TODO: link this instead?
sudo cp /vagrant/configs/my.cnf /etc/mysql 

mysql -u root -ppassword -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;"
sudo service mysql restart
