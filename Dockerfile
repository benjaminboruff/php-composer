FROM php

ENV PATH="/code:/code/app:${PATH}" \ 
    PHP_OPCACHE_VALIDATE_TIMESTAMPS="0" \
    PHP_OPCACHE_MAX_ACCELERATED_FILES="10000" \
    PHP_OPCACHE_MEMORY_CONSUMPTION="192" \
    PHP_OPCACHE_MAX_WASTED_PERCENTAGE="10"

RUN apt-get update \
    && apt-get install -y wget git zip unzip libzip-dev libpq-dev\
    && wget https://raw.githubusercontent.com/composer/getcomposer.org/d3e09029468023aa4e9dcd165e9b6f43df0a9999/web/installer -O - -q | php -- --quiet \
    && mv /composer.phar /usr/local/bin/composer \
    && composer self-update \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip opcache pgsql bcmath \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# The defaults in this opcache.ini are for a generic prod setup
# and can be changed in a dev project's docker-compose file to
# better fit a dev enviroment
COPY opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# This is where the app's source code volume is mounted 
WORKDIR /code/app

EXPOSE 8000
