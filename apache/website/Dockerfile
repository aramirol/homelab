FROM centos:latest
RUN yum -y install httpd git
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf
RUN git clone https://github.com/aramirol/simple-website.git /var/www/html
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
