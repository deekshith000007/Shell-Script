#!/bin/bash

# Set root password securely and authenticate using it
echo "Resetting MySQL root password..."
sudo mysql << EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'StrongR00tP@ssw0rd';
FLUSH PRIVILEGES;
EOF

# Use root password to run the next MySQL commands
echo "Setting up WordPress database and user..."
sudo mysql -u root -p'StrongR00tP@ssw0rd' << EOF
DROP DATABASE IF EXISTS wordpress;
CREATE DATABASE wordpress;

-- Only try to install the plugin if needed (optional step)
-- INSTALL PLUGIN validate_password SONAME 'validate_password.so';
-- SET GLOBAL validate_password.policy=LOW;

CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'WP_Str0ng_P@ssw0rd!';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';
FLUSH PRIVILEGES;
EOF

# Allow external connections to MySQL
echo "Updating bind-address in MySQL config..."
sudo sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Restart MySQL service
echo "Restarting MySQL..."
sudo systemctl restart mysql

echo "MySQL setup complete."
