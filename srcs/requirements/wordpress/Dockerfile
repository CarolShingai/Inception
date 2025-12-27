FROM debian:oldstable

WORKDIR /var/www/html

ARG DB_NAME
ARG TITLE
ARG ADMIN_NAME
ARG ADMIN_PASSWORD
ARG ADMIN_EMAIL
ARG USER_NAME
ARG USER_PASSWORD
ARG USER_EMAIL

RUN apt update && apt upgrade -y && apt install -y php php-fpm php-mysql \
    mariadb-client wget && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php

RUN chown -R www-data:www-data /var/www/html \
    && chmod 755 /var/www/html

RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x /usr/local/bin/wp \
	&& wp core download --allow-root --path=/var/www/html --debug

COPY /conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY /tools/init_wp.sh /usr/local/bin/init_wp.sh

RUN chmod +x /usr/local/bin/init_wp.sh

# Exemplo de uso das variáveis de build
RUN echo "Database: $DB_NAME, Admin: $ADMIN_NAME"

# ENTRYPOINT ["/usr/local/bin/init_wp.sh"]

CMD ["/usr/local/bin/init_wp.sh"]