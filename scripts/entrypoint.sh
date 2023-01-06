#!/bin/bash
sudo chown -R mysql:mysql /var/lib/mysql

exec sudo mysqld_safe &
sleep 3
sudo mysql -u root --password='' < /var/www/html/sql/user.sql
sudo mysql -u patchdemo --password='patchdemo' < /var/www/html/sql/patchdemo.sql

apache2ctl -D FOREGROUND