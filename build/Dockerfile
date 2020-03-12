FROM composer:latest AS composer

FROM php:7.4-fpm-alpine

RUN docker-php-ext-install opcache pcntl pdo_mysql \
    && apk --update add --no-cache git

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
