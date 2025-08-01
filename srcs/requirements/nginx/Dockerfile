FROM alpine:3.22

# Installiere nginx und openssl
RUN apk update && apk add nginx openssl

# Erstelle Zertifikatsordner
RUN mkdir -p /etc/ssl/private /etc/ssl/certs

# Erstelle ein selbstsigniertes Zertifikat
RUN openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/ssl/private/nginx-selfsigned.key \
  -out /etc/ssl/certs/nginx-selfsigned.crt \
  -subj "/C=DE/ST=Baden-Wuerttemberg/L=Heilbronn/O=42Heilbronn/OU=Dev/CN=localhost"

# Kopiere statische Inhalte
# COPY index.html /usr/share/nginx/html/

# Kopiere die angepasste NGINX-Konfiguration
COPY conf/nginx.conf /etc/nginx/http.d/default.conf

# Exponiere Port 443
EXPOSE 443

# Starte nginx im Vordergrund
ENTRYPOINT ["nginx", "-g", "daemon off;"]
