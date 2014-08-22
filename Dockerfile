FROM centurylink/apache-php:latest
MAINTAINER CentruyLink

# Install packages
RUN apt-get update && \
 DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
 DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor pwgen unzip wget && \
 apt-get -y install mysql-client

# Download OpenVBX into /app
RUN rm -fr /app && mkdir /app && \
 wget https://api.github.com/repos/twilio/OpenVBX/zipball/1.2.14 && \
 unzip 1.2.14 -d /tmp  && \
 cp -a /tmp/twilio*/. ~/app

 rm -rf /tmp/twilio*

# Add script to create 'openvbx' DB
ADD run.sh run.sh
RUN chmod 755 /*.sh
RUN chmod -R 777 /var/www/html/config/ /var/www/html/files/ /var/www/html/packages/

EXPOSE 80
CMD ["/run.sh"]
