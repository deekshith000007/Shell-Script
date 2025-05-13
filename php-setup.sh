#!/bin/bash
# Update the system
dnf update -y

# Install Apache
dnf install -y httpd
systemctl start httpd
systemctl enable httpd

# Install MariaDB (MySQL)
dnf install -y mariadb105-server
systemctl start mariadb
systemctl enable mariadb

# Secure MySQL installation
mysql_secure_installation <<EOF

y
password123
password123
y
y
y
y
EOF

# Install PHP
dnf install -y php php-mysqlnd

# Create a sample database and user
mysql -u root -ppassword123 <<EOF
CREATE DATABASE lamptest;
CREATE USER 'lampuser'@'localhost' IDENTIFIED BY 'lamppass';
GRANT ALL PRIVILEGES ON lamptest.* TO 'lampuser'@'localhost';
FLUSH PRIVILEGES;

USE lamptest;
CREATE TABLE test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255) NOT NULL
);
INSERT INTO test_table (message) VALUES ('Hello from MySQL!');
EOF

# Create a PHP test file
cat > /var/www/html/index.php <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>LAMP Stack Test</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            line-height: 1.6;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            background-color: #f4f4f4;
            padding: 20px;
            border-radius: 5px;
        }
        h1 {
            color: #333;
        }
        .success {
            color: green;
        }
        .error {
            color: red;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>LAMP Stack Test</h1>
        
        <h2>PHP Test</h2>
        <?php echo "<p class='success'>PHP is working properly!</p>"; ?>
        
        <h2>MySQL Connection Test</h2>
        <?php
        \$servername = "localhost";
        \$username = "lampuser";
        \$password = "lamppass";
        \$dbname = "lamptest";

        // Create connection
        \$conn = new mysqli(\$servername, \$username, \$password, \$dbname);

        // Check connection
        if (\$conn->connect_error) {
            die("<p class='error'>Connection failed: " . \$conn->connect_error . "</p>");
        }
        echo "<p class='success'>Connected to MySQL successfully!</p>";

        // Query data
        \$sql = "SELECT id, message FROM test_table";
        \$result = \$conn->query(\$sql);

        if (\$result->num_rows > 0) {
            echo "<h3>Data from database:</h3>";
            echo "<ul>";
            // Output data of each row
            while(\$row = \$result->fetch_assoc()) {
                echo "<li>ID: " . \$row["id"]. " - Message: " . \$row["message"]. "</li>";
            }
            echo "</ul>";
        } else {
            echo "<p>No results found</p>";
        }
        \$conn->close();
        ?>
        
        <h2>System Information</h2>
        <p>Server Software: <?php echo \$_SERVER["SERVER_SOFTWARE"]; ?></p>
        <p>PHP Version: <?php echo phpversion(); ?></p>
        <p>Server Time: <?php echo date("Y-m-d H:i:s"); ?></p>
    </div>
</body>
</html>
EOF

# Set proper permissions
chown -R apache:apache /var/www/html/
