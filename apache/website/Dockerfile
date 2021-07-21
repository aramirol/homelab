# Use Centos OS
FROM centos:latest

# Install httpd and git. Use aramirol/simple-wegsit git repository
RUN yum -y install httpd git && \
    echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf && \
    git clone https://github.com/aramirol/simple-website.git /var/www/html

# Start httpd service
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# Expose http port 80
EXPOSE 80
