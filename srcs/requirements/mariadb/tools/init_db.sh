#!/bin/bash

set -e

if [ ! -d /var/lib/mysql/mysql ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    envsubst < /usr/local/bin/init.sql | mysqld --user=mysql --bootstrap
fi