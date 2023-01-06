#!/bin/bash
exec sudo mysqld_safe &
sleep 5
cd /var/www/html
sudo mysql -u root --password='' < sql/user.sql
sudo mysql -u patchdemo --password='patchdemo' < sql/patchdemo.sql
