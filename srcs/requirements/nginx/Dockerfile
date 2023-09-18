# Use a specific version of the Debian Buster image to ensure consistent builds
FROM debian:buster-slim

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    nginx \
    curl && \
    rm -rf /var/lib/apt/lists/*

# Download, install, and clean up the mkcert tool
RUN curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64" && \
    chmod +x mkcert-v*-linux-amd64 && \
    mv mkcert-v*-linux-amd64 /usr/local/bin/mkcert

# Create SSL certificates
RUN mkdir -p /etc/nginx/ssl && \
    mkcert -cert-file /etc/nginx/ssl/diogpere.crt -key-file /etc/nginx/ssl/diogpere.key diogpere.42.fr

# Clean up mkcert tool after usage
RUN rm /usr/local/bin/mkcert

# Copy Nginx configuration
COPY ./conf/nginx.conf /etc/nginx/conf.d

# Create runtime directory for Nginx
RUN mkdir -p /run/nginx

# Start Nginx in foreground so Docker can manage it
CMD ["nginx", "-g", "daemon off;"]