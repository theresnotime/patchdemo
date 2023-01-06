FROM debian:bullseye AS base
RUN apt update
RUN apt install sudo nano lsb-release git unzip rdfind dirmngr ca-certificates software-properties-common gnupg gnupg2 apt-transport-https curl -y
RUN sudo curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
RUN sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
RUN sudo apt update
RUN sudo apt upgrade -y
RUN sudo apt install apache2 default-mysql-server -y


# ---


# PatchDemo PHP 7.4
FROM base AS patchdemo-php-7.4
RUN apt update
# dependencies of MediaWiki
RUN sudo apt install php7.4 libapache2-mod-php7.4 php7.4-mysql php7.4-intl php7.4-xml php7.4-mbstring php7.4-curl -y
RUN sudo apt install php-wikidiff2 imagemagick librsvg2-bin lame -y
# dependencies of our system
RUN sudo apt install composer npm -y
RUN sudo mkdir /run/mysqld
RUN sudo chown -R mysql:mysql /run/mysqld
WORKDIR /var/www/html
RUN rm -rf /var/www/html/*

# Node 14
RUN sudo curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
RUN sudo sh -c "echo deb https://deb.nodesource.com/node_14.x impish main > /etc/apt/sources.list.d/nodesource.list"
RUN sudo apt update
RUN sudo apt install nodejs -y
# Update NPM
RUN sudo npm install -g npm@latest
# Let www-data run NPM
RUN sudo mkdir /var/www/.npm /var/www/.config
RUN sudo chown www-data: /var/www/.npm /var/www/.config
# We used to run NPM as root
#RUN sudo chown -R www-data: node_modules

COPY . /var/www/html

# Fix permissions
RUN sudo chown -R www-data: /var/www/html
RUN sudo chmod +x /var/www/html/scripts/*.sh

# Composer wants a directory for itself (COMPOSER_HOME)
RUN sudo -u www-data mkdir composer
# Create folder for wikis
RUN sudo -u www-data mkdir wikis

# create master copies of repositories
RUN sudo -u www-data mkdir -p repositories
WORKDIR /var/www/html/repositories
RUN /var/www/html/scripts/repoloop.sh
WORKDIR /var/www/html

# dependencies for the website
RUN composer install --no-dev
RUN sudo -u www-data npm ci --production

RUN /var/www/html/scripts/finalsetup.sh

EXPOSE 80
CMD ["/var/www/html/scripts/entrypoint.sh"]


# ---


# PatchDemo PHP 8.0
FROM base AS patchdemo-php-8.0
RUN apt update
# dependencies of MediaWiki
RUN sudo apt install php8.0 libapache2-mod-php8.0 php8.0-mysql php8.0-intl php8.0-xml php8.0-mbstring php8.0-curl -y
RUN sudo apt install php-wikidiff2 imagemagick librsvg2-bin lame -y
# dependencies of our system
RUN sudo apt install composer npm -y
RUN sudo mkdir /run/mysqld
RUN sudo chown -R mysql:mysql /run/mysqld
WORKDIR /var/www/html
RUN rm -rf /var/www/html/*

# Node 14
RUN sudo curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
RUN sudo sh -c "echo deb https://deb.nodesource.com/node_14.x impish main > /etc/apt/sources.list.d/nodesource.list"
RUN sudo apt update
RUN sudo apt install nodejs -y
# Update NPM
RUN sudo npm install -g npm@latest
# Let www-data run NPM
RUN sudo mkdir /var/www/.npm /var/www/.config
RUN sudo chown www-data: /var/www/.npm /var/www/.config
# We used to run NPM as root
#RUN sudo chown -R www-data: node_modules

COPY . /var/www/html

# Fix permissions
RUN sudo chown -R www-data: /var/www/html
RUN sudo chmod +x /var/www/html/scripts/*.sh

# Composer wants a directory for itself (COMPOSER_HOME)
RUN sudo -u www-data mkdir composer
# Create folder for wikis
RUN sudo -u www-data mkdir wikis

# create master copies of repositories
RUN sudo -u www-data mkdir -p repositories
WORKDIR /var/www/html/repositories
RUN /var/www/html/scripts/repoloop.sh
WORKDIR /var/www/html

# dependencies for the website
RUN composer install --no-dev
RUN sudo -u www-data npm ci --production

RUN /var/www/html/scripts/finalsetup.sh

EXPOSE 80
CMD ["/var/www/html/scripts/entrypoint.sh"]


# ---


# PatchDemo PHP 8.1
FROM base AS patchdemo-php-8.1
RUN apt update
# dependencies of MediaWiki
RUN sudo apt install php8.1 libapache2-mod-php8.1 php8.1-mysql php8.1-intl php8.1-xml php8.1-mbstring php8.1-curl -y
RUN sudo apt install php-wikidiff2 imagemagick librsvg2-bin lame -y
# dependencies of our system
RUN sudo apt install composer npm -y
RUN sudo mkdir /run/mysqld
RUN sudo chown -R mysql:mysql /run/mysqld
WORKDIR /var/www/html
RUN rm -rf /var/www/html/*

# Node 14
RUN sudo curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
RUN sudo sh -c "echo deb https://deb.nodesource.com/node_14.x impish main > /etc/apt/sources.list.d/nodesource.list"
RUN sudo apt update
RUN sudo apt install nodejs -y
# Update NPM
RUN sudo npm install -g npm@latest
# Let www-data run NPM
RUN sudo mkdir /var/www/.npm /var/www/.config
RUN sudo chown www-data: /var/www/.npm /var/www/.config
# We used to run NPM as root
#RUN sudo chown -R www-data: node_modules

COPY . /var/www/html

# Fix permissions
RUN sudo chown -R www-data: /var/www/html
RUN sudo chmod +x /var/www/html/scripts/*.sh

# Composer wants a directory for itself (COMPOSER_HOME)
RUN sudo -u www-data mkdir composer
# Create folder for wikis
RUN sudo -u www-data mkdir wikis

# create master copies of repositories
RUN sudo -u www-data mkdir -p repositories
WORKDIR /var/www/html/repositories
RUN /var/www/html/scripts/repoloop.sh
WORKDIR /var/www/html

# dependencies for the website
RUN composer install --no-dev
RUN sudo -u www-data npm ci --production

RUN /var/www/html/scripts/finalsetup.sh

EXPOSE 80
CMD ["/var/www/html/scripts/entrypoint.sh"]