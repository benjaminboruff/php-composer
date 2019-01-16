## Generic `php:latest` and `composer` image

This image contains a generic opcache.ini file for a production environment. These values can be changed in a dev project's
`docker-compose.yml` file.

```
[opcache]

opcache.enable=1
opcache.revalidate_freq=0
opcache.validate_timestamps=${PHP_OPCACHE_VALIDATE_TIMESTAMPS}
opcache.max_accelerated_files=${PHP_OPCACHE_MAX_ACCELERATED_FILES}
opcache.memory_consumption=${PHP_OPCACHE_MEMORY_CONSUMPTION}
opcache.max_wasted_percentage=${PHP_OPCACHE_MAX_WASTED_PERCENTAGE}
opcache.interned_strings_buffer=16
opcache.fast_shutdown=1
```

### Sample `docker-compose.yml` for a [slim](http://www.slimframework.com/) framework app.

```
version: '3'

services:
    slimapp:
        image: bhboruff/php-composer
        environment:
            user: "${UID}:${GID}"
            # NB: the default for PHP_OPCACHE_VALIDATE_TIMESTAMPS is 0, which may be what you
            # want for production, but for dev you certainly want file changes to be detected, thus set to 1
            PHP_OPCACHE_VALIDATE_TIMESTAMPS: 1
        ports:
            - 8000:8000
        volumes:
            - .:/code
        command: php -S 0.0.0.0:8000 -t public
```

Then run 

```env UID=$(id -u) GID=$(id -g) docker-compose up```

This assumes your host is linux. If you are using OSX or Win, then the `id -u` and `id -g` commands will be different, or not apply at all.

You'll have to roll your own `docker-compose.yml` based on your OS.

Please see this [sample Slim app](https://github.com/benjaminboruff/slimsample) for using this image via a `docker-compose.yml` file.