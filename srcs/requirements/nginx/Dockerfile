# Use the official Debian Bullseye image as the base
FROM debian:bullseye

# Update package lists and install necessary packages
RUN apt-get update && apt-get install -y \
	nginx \
	openssl \
	curl

# Copy the custom Nginx configuration file into the container
COPY conf/nginx.conf /etc/nginx/

# Copy the startup script into the container
COPY ./conf/start_nginx.sh .

# Make the startup script executable
RUN chmod +x start_nginx.sh

# Set the startup script as the default command to run
CMD ["./start_nginx.sh"]