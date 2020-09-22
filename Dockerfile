FROM php:7.2-fpm

RUN apt-get update

RUN apt-get install -y \
    apt-utils \
    zlib1g-dev \
    libzip-dev \
    libpng-dev \
    libicu-dev \
    libxml2-dev
RUN docker-php-ext-install zip
RUN apt-get install --yes --no-install-recommends libpq-dev \
  && docker-php-ext-install pdo_pgsql pgsql pdo_mysql intl xmlrpc gd soap

RUN chown -R www-data:www-data /var/www