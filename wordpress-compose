version: '3.8'

services:
  wordpress:
    image: wordpress:latest
    container_name: wordpress-app
    restart: always
    ports:
      - "8080:80"
    environment:
      WORDPRESS_DB_HOST: <Server-B-IP>:3306
      WORDPRESS_DB_NAME: wp_db
      WORDPRESS_DB_USER: wp_user
      WORDPRESS_DB_PASSWORD: wp_pass
    volumes:
      - wordpress_data:/var/www/html

volumes:
  wordpress_data:
