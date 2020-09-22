#Uses geekidea image due to a cron job bug in alpine
FROM geekidea/alpine-cron:3.10

# Install packages and remove default server definition
RUN apk --no-cache add php7 php7-fpm php7-opcache php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype php7-session \
    php7-mbstring php7-gd php7-iconv php7-zip php7-pgsql php7-pdo_pgsql php7-simplexml php7-fileinfo php7-tokenizer \
    php7-xmlrpc php7-soap nginx supervisor curl && rm /etc/nginx/conf.d/default.conf
RUN apk add bash git sudo

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY config/php.ini /etc/php7/conf.d/custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisord.conf
ADD config/start.sh /
RUN chmod +x /start.sh

# Setup document root
RUN mkdir -p /var/www/html

# Set access to nobody
RUN chown -R nobody.nobody /var/www/html && \
  chown -R nobody.nobody /run && \
  chown -R nobody.nobody /var/lib/nginx && \
  chown -R nobody.nobody /var/log/nginx && \
  chown -R nobody:nobody /var/www && \
  chown -R nobody:nobody /var/log

# Switch to use a non-root user from here on
USER nobody

# Set cron
RUN mkdir /tmp/crontabs \
    && echo 'SHELL=/bin/sh' > /tmp/crontabs/nobody \
    && echo '*/1 * * * * /tmp/moodlecron.sh' >> /tmp/crontabs/nobody \
    && echo 'php /var/www/html/admin/cli/cron.php >> /tmp/moodlecron.log' > /tmp/moodlecron.sh \
    && chmod 0755 /tmp/moodlecron.sh

# Add application
WORKDIR /var/www/html
COPY --chown=nobody moodle/ /var/www/html/

# Expose the port nginx is reachable on
EXPOSE 8080

# Run start script
CMD ["/start.sh"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping
