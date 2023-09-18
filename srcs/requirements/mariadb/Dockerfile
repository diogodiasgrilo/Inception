FROM debian:buster-slim

# Update the package database and install necessary packages
# like MariaDB server and client, and Curl (a tool to transfer data from or to a server)
RUN apt-get update && \
    apt-get install -y \
    mariadb-server \
    curl && \
    # Remove the package list to reduce the size of the image
    rm -rf /var/lib/apt/lists/*

# Create a directory for the MariaDB UNIX socket file and set the proper permissions
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

# Copy MariaDB configuration scripts into the image
COPY ./tools/mariadb.sh /usr/local/bin/

# Set the copied scripts as executable
RUN chmod +x /usr/local/bin/mariadb.sh

# Define the script to be run when the container starts
ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

# Set the default command to run the MariaDB server with a specific bind address
CMD ["mysqld", "--bind-address=0.0.0.0"]
    