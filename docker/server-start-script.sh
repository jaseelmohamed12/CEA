#!/bin/bash

touch /cron_log.log
chmod 777 /cron_log.log

echo "Running all"
: >> /app/storage/logs/laravel.log && chmod 777 /app/storage/logs/laravel.log
echo "Running queues"
supervisord -c /etc/supervisor/supervisord.conf
echo "Running scheduler"
cron
echo "Running server"
apachectl start && chmod 777 /app/storage/logs/laravel.log && tail -f /app/storage/logs/laravel.log

