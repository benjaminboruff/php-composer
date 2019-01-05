FROM php

WORKDIR /code
ENV PATH="/code:${PATH}"

RUN apt-get update \
    && apt-get install -y wget git zip unzip libzip-dev \
    && wget https://raw.githubusercontent.com/composer/getcomposer.org/d3e09029468023aa4e9dcd165e9b6f43df0a9999/web/installer -O - -q | php -- --quiet \
    && mv composer.phar composer \
    && docker-php-ext-install zip

EXPOSE 8000
