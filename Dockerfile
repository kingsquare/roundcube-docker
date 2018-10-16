FROM php:7-apache
MAINTAINER Kingsquare <docker@kingsquare.nl>
LABEL webmail roundcube
EXPOSE 80

ENV ROUNDCUBE_VERSION=1.3.7

ENV DEBIAN_FRONTEND noninteractive
RUN apt update -qy && \
    apt install -qy --no-install-recommends \
        gnupg \
        ca-certificates \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libicu57 libicu-dev \
        libldap2-dev \
        libzip4 libzip-dev && \
    pear install Mail_mime Net_SMTP Net_Socket channel://pear.php.net/Net_IDNA2-0.2.0 Auth_SASL Net_Sieve Crypt_GPG Endroid/QrCode && \
    pecl install apcu redis && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install -j$(nproc) pdo_mysql mysqli sockets ldap zip opcache fileinfo intl exif gd zip && \
    docker-php-ext-enable apcu redis && \
    curl -o roundcube.zip -Ls https://github.com/roundcube/roundcubemail/releases/download/${ROUNDCUBE_VERSION}/roundcubemail-${ROUNDCUBE_VERSION}-complete.tar.gz && \
    tar xzf roundcube.zip --directory=/var/www/html && \
    # clean up \
    apt-get -yq autoremove --purge && \
    apt-get -qq clean && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apt/* /var/lib/apt/lists/* roundcube.zip /usr/src/php* && \
    mv /var/www/html/roundcube*/* /var/www/html

ENV PHP_ENV=production

COPY app /app

CMD ["/app/docker-entry.sh"]
