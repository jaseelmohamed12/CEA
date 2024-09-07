FROM php:8.2-fpm

WORKDIR /var/www

RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    nginx \
    cron

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -

RUN apt-get install -y nodejs
RUN npm install -g npm@latest


COPY . /var/www

COPY --chown=www-data:www-data . /var/www

RUN composer clear-cache
RUN composer install

RUN npm install --legacy-peer-deps
RUN npm run build

COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./docker/entrypoint.sh /entrypoint.sh
COPY ./docker/build.sh /build.sh
COPY docker/cron/cea-cron-job.sh /etc/cron.d/cea-cron-job.sh

RUN chmod +x /build.sh
RUN chmod +x /entrypoint.sh

RUN chmod 0644 /etc/cron.d/cea-cron-job.sh
RUN crontab /etc/cron.d/cea-cron-job.sh
RUN touch /var/log/cron.log

RUN mkdir -p /var/www/storage/logs
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
