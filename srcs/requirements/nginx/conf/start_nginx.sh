#! /bin/sh

mkdir -p /etc/nginx/certs/

if [ ! -f /etc/nginx/certs/fullchain.pem ]; then
	openssl req -x509 -newkey rsa:2048 -nodes \
	-keyout /etc/nginx/certs/privkey.pem -out /etc/nginx/certs/fullchain.pem -days 365 \
	-subj "/CN=localhost"
fi

nginx -g 'daemon off;'