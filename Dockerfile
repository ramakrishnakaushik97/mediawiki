FROM php:7.4-apache

RUN apt update && apt install -y libicu-dev && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install intl

COPY src/ /var/www/html/mediawiki/

# Set www-data to have UID 1000
RUN usermod -u 1000 www-data;
USER www-data
