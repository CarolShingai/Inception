FROM alpine:3.20

ARG ADMIN_NAME
ARG ADMIN_PASSWORD
ARG DB_NAME

RUN apk update && apk upgrade && \
    apk add --no-cache \
    mariadb \
    mariadb-client \
    bash

RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld && \
    chmod 755 /run/mysqld

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Copiar script de inicialização
COPY mariadb-init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb-init.sh

EXPOSE 777

USER mysql

ENTRYPOINT [ "/usr/local/bin/mariadb-init.sh" ]
