#!/bin/sh

bash /build.sh
php artisan view:clear
php artisan config:clear
php artisan cache:clear
# Run migrations and seeders
php artisan migrate --force
php artisan db:seed --force
service cron start

php-fpm -D && nginx -g 'daemon off;'