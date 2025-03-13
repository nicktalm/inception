# Verwende Debian als Basis-Image
FROM debian:bullseye

# Installiere NGINX und OpenSSL
RUN apt-get update && apt-get install -y nginx openssl

# Erstelle Verzeichnis für SSL-Zertifikate
RUN mkdir -p /etc/nginx/certs

# Kopiere das Start-Skript und die Konfigurationsdateien
COPY conf/start_nginx.sh /start_nginx.sh
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/conf.d/default.conf

# Setze das Start-Skript als ENTRYPOINT
ENTRYPOINT ["sh", "/start_nginx.sh"]

# Öffne den Port für HTTPS
EXPOSE 443
