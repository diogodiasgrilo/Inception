# Use the slimmer version of Debian Buster as the base image
FROM debian:buster-slim

# Update the Debian package repository and install necessary packages including 
# the PHP extensions needed for WordPress and Redis
RUN apt-get update && apt-get -y install \
	wget \
	curl \
	bash \
	php \
	php-cgi \
	php-mysql \
	php-fpm \
	php-pdo \
	php-gd \
	php-cli \
	php-mbstring \
	redis \
	php-redis \
	&& rm -rf /var/lib/apt/lists/*

# Download the wp-cli tool, make it executable, and move it to a directory in the system PATH
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp

# Copy the PHP-FPM pool configuration file from the local file system to the appropriate directory 
# in the container to configure PHP-FPM
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

# Create a directory for PHP runtime files to enable PHP to start correctly
RUN mkdir /run/php

# Copy the WordPress setup script from your local file system to the container, 
# and make it executable so it can be run when the container starts
COPY ./tools/wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress.sh
ENTRYPOINT ["/usr/local/bin/wordpress.sh"]

# Set the working directory inside the container to the directory where Apache serves files from by default
WORKDIR /var/www/html/

# CMD directive defines the default command to run PHP-FPM in foreground mode, 
# this ensures that the PHP-FPM process keeps running and doesn't terminate 
CMD ["/usr/sbin/php-fpm7.3", "-F"]
