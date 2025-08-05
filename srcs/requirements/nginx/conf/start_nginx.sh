#! /bin/sh

mkdir -p /etc/nginx/certs/

if [ ! -f /etc/nginx/certs/ssl_cert.crt ]; then
	openssl req -x509 -newkey rsa:2048 -nodes \
	-keyout /etc/nginx/certs/ssl_key.key -out /etc/nginx/certs/ssl_cert.crt -days 365 \
	-subj "/CN=localhost"
fi

nginx -g 'daemon off;'