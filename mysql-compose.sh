version: '3.8'

services:
  db:
    image: mysql:5.7
    container_name: mysql-db
    restart: always
    environment:
      MYSQL_DATABASE: wp_db
      MYSQL_USER: wp_user
      MYSQL_PASSWORD: wp_pass
      MYSQL_ROOT_PASSWORD: root_pass
    volumes:
      - db_data:/var/lib/mysql
      - ./mysql-conf/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf
    ports:
      - "3306:3306"

volumes:
  db_data:
