#!/bin/sh
set -e

if [ ! -e /var/www/html/lib/config.php ]; then
    cd /var/www/html

    git clone https://github.com/aaronpk/Watchtower.git .

    composer install

    cp lib/config.template.php lib/config.php

    chown -R www-data:www-data .

    cd lib

    sed -i "s|base_url = 'https://watchtower.dev'|base_url = '${WATCHTOWER_URL:=https\://watchtower.example.org}'|g" config.php

    sed -i "s|dbHost = '127.0.0.1'|dbHost = '${MYSQL_HOST:=127.0.0.1}'|g" config.php
    sed -i "s|dbPassword = 'watchtower'|dbPassword = '${MYSQL_PASSWORD:=watchtower}'|g" config.php

    sed -i "s|beanstalkServer = '127.0.0.1'|beanstalkServer = '${BEANSTALK_SERVER:=127.0.0.1}'|g" config.php
fi

exec "$@"
