FROM debian:oldstable

RUN apt update && apt upgrade -y \
    && apt install -y nginx openssl

# OPenSSL self-signed certificate generation
RUN openssl req -x509 -nodes -days 365 \
    -subj "/C=BR/ST=SP/L=Sao Paulo/O=42sp/CN=www.cshingai.42.fr" \
    -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

