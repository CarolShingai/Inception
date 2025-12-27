FROM debian:oldstable

WORKDIR /var/www/html

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

ENTRYPOINT ["/usr/local/bin/init_wp.sh"]

CMD ["php-fpm7.4", "-F"]