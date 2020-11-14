FROM php:7.3-fpm
# COPY php.ini /usr/local/etc/php/

COPY instantclient-basic-linux.x64-19.8.0.0.0dbru.zip /tmp
COPY instantclient-sdk-linux.x64-19.8.0.0.0dbru.zip /tmp

RUN apt-get update && \
    apt-get install -y zlib1g-dev libzip-dev libicu-dev libpq-dev unzip git zip wget libaio1 && \
    docker-php-ext-install intl && \
    unzip /tmp/instantclient-basic-linux.x64-19.8.0.0.0dbru.zip -d /usr/local/ && \
    unzip /tmp/instantclient-sdk-linux.x64-19.8.0.0.0dbru.zip -d /usr/local/ && \
    ln -s /usr/local/instantclient_19_8 /usr/local/instantclient && \
    # ln -s /usr/local/instantclient/libclntsh.so.19.1 /usr/local/instantclient/libclntsh.so && \
    export LD_LIBRARY_PATH=/usr/local/instantclient && \
    docker-php-ext-configure oci8 --with-oci8=instantclient,/usr/local/instantclient && \
    docker-php-ext-install oci8 && \
    docker-php-ext-configure pdo_oci --with-pdo-oci=shared,instantclient,/usr/local/instantclient,19.3 && \
    docker-php-ext-install pdo_oci && \
    rm -rf /usr/local/*.zip && \
    echo /usr/local/instantclient/ > /etc/ld.so.conf.d/oracle-insantclient.conf \
    && ldconfig

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

#Composer install
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer

WORKDIR /var/www/html/
