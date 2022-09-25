#!/bin/bash
composer install
./vendor/bin/sail up -d
docker exec -it example-app-laravel.test-1 /var/www/html/artisan migrate:refresh --seed
docker exec -it example-app-laravel.test-1 /var/www/html/artisan passport:install
echo  'successfully'
exit
