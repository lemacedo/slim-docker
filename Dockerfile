
FROM php:7.0-fpm-alpine

COPY . /var/www/html
COPY default.conf /etc/nginx/conf.d/default.conf

RUN apk update && apk upgrade

# Add bash
RUN apk add bash

# Add composer 
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"



RUN rm -rf /var/www/html/logs/* && chown -R www-data:www-data /var/www/html