#!/bin/bash

# Configure WordPress if not already configured
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Configuring WordPress..."

    wp --allow-root config create \
        --dbname="$DB_NAME" \
        --dbuser="$ADMIN_NAME" \
        --dbpass="$ADMIN_PASSWORD" \
        --dbhost=mariadb \
        --dbprefix="wp_"

    wp core install --allow-root \
        --path=/var/www/html \
        --title="$TITLE" \
        --url=$DOMAIN \
        --admin_user=$ADMIN_NAME \
        --admin_password=$ADMIN_PASSWORD \
        --admin_email=$ADMIN_EMAIL

    wp user create --allow-root	\
        --path=/var/www/html \
        "$USER_NAME" "$USER_EMAIL" \
        --user_pass=$USER_PASSWORD \
        --role='author'

    wp --allow-root theme activate twentytwentyfour
else
    echo "WordPress already configured."
fi

exec php-fpm7.4 -F

