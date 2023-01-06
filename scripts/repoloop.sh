#!/bin/bash
cd /var/www/html/repositories
while IFS=' ' read -r repo dir; do
	sudo -u www-data git clone --depth 1 --no-checkout https://gerrit.wikimedia.org/r/$repo.git $repo
done < /var/www/html/repository-lists/all.txt
cd /var/www/html
