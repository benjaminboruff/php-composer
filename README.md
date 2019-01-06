## Generic `php:latest` and `composer` image

### Sample `docker-compose.yml` for a [slim](http://www.slimframework.com/) framework app.

```
version: '3'

services:
    slimapp:
        image: bhboruff/php-composer
        environment:
            user: "${UID}:${GID}"
        ports:
            - 8000:8000
        volumes:
            - .:/code/app
        command: php -S 0.0.0.0:8000 -t public
```

Then run 

```env UID=${UID} GID=${GID} docker-compose up```

This assumes your host is linux. If you are using OSX or Win, then the `UID` and `GID` env vars may be different, or not apply at all.

You'll have to roll your own `docker-compose.yml` based on your OS.

Please see this [sample Slim app](https://github.com/benjaminboruff/slimsample) for using this image via a `docker-compose.yml` file.