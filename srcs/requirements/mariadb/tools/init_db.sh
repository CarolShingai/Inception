#!/bin/bash

service mariadb start 

mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
mariadb -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
mariadb -u root -e "FLUSH PRIVILEGES;"