FROM debian:oldstable

ARG ADMIN_NAME
ARG ADMIN_PASSWORD
ARG DB_NAME

RUN apt update && apt upgrade -y \
    && apt install -y mariadb-server mariadb-client

RUN apt-get update && apt-get install -y gettext

RUN mkdir -p /var/run/mysql \
    && chown -R mysql:mysql /var/run/mysql \
    && chmod 777 /var/run/mysql

COPY tools/init_db.sh /usr/local/bin/init_db.sh
COPY tools/init.sql /usr/local/bin/init.sql

COPY conf/my.cnf /etc/mysql/my.cnf

RUN chmod +x /usr/local/bin/init_db.sh && /usr/local/bin/init_db.sh

# Exemplo de uso das variáveis de build
RUN echo "Database: $DB_NAME, Admin: $ADMIN_NAME"

CMD ["mysqld_safe"]