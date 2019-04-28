from ubuntu:18.10

LABEL maintainer="Adriano Antonucci <adrianoantonucci@gmail.com>"

RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.conf

RUN apt-get update

RUN apt-get update
RUN apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update

RUN apt-get -y --force-yes install nginx
RUN rm -v /etc/nginx/sites-available/default
RUN rm -v /etc/nginx/sites-enabled/default
ADD config/server-config.nginx /etc/nginx/sites-available/application
ADD config/server-config.nginx /etc/nginx/sites-enabled/application

RUN apt-get -y --force-yes install php7.2 php7.2-fpm php7.2-mysql php7.2-pgsql php7.2-pdo php7.2-cli php7.2-curl php7.2-mbstring php7.2-xml php7.2-dompdf php7.2-dom
ADD config/composer.phar /usr/local/bin/composer

WORKDIR /var/www/html

EXPOSE 80
CMD service php7.2-fpm start && nginx -g "daemon off;"