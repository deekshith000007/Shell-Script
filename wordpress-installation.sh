#!/bin/bash
apt update && apt upgrade -y

# Install Apache, PHP, and related modules
apt install -y apache2 php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip

# Start and enable Apache
systemctl start apache2
systemctl enable apache2

# Download and set up WordPress
cd /tmp
curl -O https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -R /tmp/wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

# Configure WordPress
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/database_name_here/wordpress/" /var/www/html/wp-config.php
sed -i "s/username_here/wpuser/" /var/www/html/wp-config.php
sed -i "s/password_here/WP_Str0ng_P@ssw0rd!/" /var/www/html/wp-config.php
sed -i "s/localhost/ipofprivatemysql/" /var/www/html/wp-config.php

# Set WP salts
SALT=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
STRING='put your unique phrase here'
printf '%s\n' "g/$STRING/d" a "$SALT" . w | ed -s /var/www/html/wp-config.php

# Remove default index.html so that WordPress loads instead
rm -f /var/www/html/index.html

# Restart Apache
systemctl restart apache2

