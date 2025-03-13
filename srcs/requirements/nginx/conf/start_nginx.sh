#!/bin/sh

# SSL-Zertifikat generieren, falls nicht vorhanden
if [ ! -f /etc/nginx/certs/server.crt ]; then
    echo "SSL-Zertifikat nicht gefunden, erstelle selbstsigniertes Zertifikat..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/certs/server.key \
        -out /etc/nginx/certs/server.crt \
        -subj "/C=DE/ST=Baden-Wuerttemberg/L=Heilbronn/O=42 School/OU=IT Department/CN=localhost"
fi

# NGINX starten
nginx -g "daemon off;"
