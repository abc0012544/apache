#Setting inherit from the sshd image which we create early.
FROM abc0012544/sshd

#Creator info
MAINTAINER Cao(caoqiang0012@163.com)

#Setting ENV parameter, all operate will be noninteractive
ENV DEBIAN_FRONTEND noninteractive

#Install
RUN apt-get -yq install apache2 && rm -rf /var/lib/apt/lists/*

#Change the system's time zone to locale
RUN echo "Asia/Shanghai" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

#Add script and setting execute privilege
ADD run.sh /run.sh
RUN chmod 755 /*.sh

#Adding one example web site, we will delete the default files under the apache folder, and will link to /var/www/html.
RUN mkdir -p /var/lock/apache2 && mkdir -p /app && rm -fr /var/www && ln -s /app /var/www
COPY sample/ /app

# Setting the Apache parameter.
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_SERVERADMIN admin@localhost
ENV APACHE_SERVERNAME localhost
ENV APACHE_SERVERALIAS docker.localhost
ENV APACHE_DOCUMENTROOT /var/www

EXPOSE 80
WORKDIR /app
CMD ["/run.sh"]
