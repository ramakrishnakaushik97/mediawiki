FROM php:7.4-apache

# PHP extensions installation
RUN set -e; \
    apt update; \
    apt install -y libicu-dev; \
    docker-php-ext-install intl mysqli; \
    rm -rf /var/lib/apt/lists/*

# mediawiki app setup
RUN set -e; \
    curl -fSL -o mediawiki-1.39.0.tar.gz https://releases.wikimedia.org/mediawiki/1.39/mediawiki-1.39.0.tar.gz; \
    tar -x --strip-components=1 -f ./mediawiki-1.39.0.tar.gz; \
    rm -rf mediawiki-1.39.0.tar.gz; \
    chown -R www-data:www-data extensions skins cache images; \
    rm -rf /var/lib/apt/lists/*

# mySql Directory setup
RUN set -e; \
    mkdir -p /var/www/data && chown www-data:www-data /var/www/data

CMD ["apache2-foreground"]