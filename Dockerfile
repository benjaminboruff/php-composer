FROM php

ENV PATH="/code:/code/app:${PATH}"

# This allows composer to be installed outside of the app dir
WORKDIR /code

RUN apt-get update \
    && apt-get install -y wget git zip unzip libzip-dev \
    && wget https://raw.githubusercontent.com/composer/getcomposer.org/d3e09029468023aa4e9dcd165e9b6f43df0a9999/web/installer -O - -q | php -- --quiet \
    && mv composer.phar composer \
    && composer self-update \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# This is where the app's source code volume is mounted 
WORKDIR /code/app

EXPOSE 8000
