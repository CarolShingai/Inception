FROM debian:oldstable

RUN apt update && apt upgrade -y \
    && apt install -y mariadb-server mariadb-client

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

COPY /conf/my.cnf /etc/mysql/my.cnf

COPY /tools/init_db.sh /usr/local/bin/init_db.sh

RUN chmod +x /usr/local/bin/init_db.sh

ENTRYPOINT ["/usr/local/bin/init_db.sh"]

CMD ["mysqld"]