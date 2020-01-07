FROM composer:latest AS composer

FROM php:7.3-fpm-alpine

RUN docker-php-ext-install pcntl pdo_mysql \
    && apk --update add --no-cache git

COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
