FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	nginx \
	openssl \
	curl

COPY conf/nginx.conf /etc/nginx/
COPY ./conf/start_nginx.sh .

RUN chmod +x start_nginx.sh

CMD ["./start_nginx.sh"]
