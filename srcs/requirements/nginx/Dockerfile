FROM debian:12

RUN apt update && apt upgrade && apt install -y \
	nginx \
	openssl \
	curl

COPY conf/nginx.conf /etc/nginx/sites-available/.
COPY ./conf/start_nginx.sh .

RUN chmod +x start_nginx.sh

CMD ["./start_nginx.sh"]
