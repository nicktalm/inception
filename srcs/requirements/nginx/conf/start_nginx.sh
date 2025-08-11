#! /bin/sh

# Create the directory for SSL certificates if it doesn't exist
mkdir -p /etc/nginx/certs/

# Check if the SSL certificate file already exists
if [ ! -f /etc/nginx/certs/ssl_cert.crt ]; then
	# Generate a self-signed SSL certificate and private key
	openssl req -x509 -newkey rsa:2048 -nodes \
	-keyout /etc/nginx/certs/ssl_key.key -out /etc/nginx/certs/ssl_cert.crt -days 365 \
	-subj "/CN=localhost"
fi

# Start Nginx in the foreground
nginx -g 'daemon off;'