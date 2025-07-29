FROM alpine:3.22

RUN apk update && apk add nginx

# Kopiere HTML-Datei in das Verzeichnis, das NGINX standardmäßig nutzt
COPY index.html /usr/share/nginx/html/

# Kopiere die benutzerdefinierte NGINX-Konfiguration
COPY conf/nginx.conf /etc/nginx/http.d/nginx.conf

# Starte nginx im Vordergrund
ENTRYPOINT ["nginx", "-g", "daemon off;"]