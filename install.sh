#!/bin/bash
composer install
cp .env.example .env
./vendor/bin/sail up -d
docker exec -it order-challenge-laravel.test-1 /var/www/html/artisan key:generate
docker exec -it order-challenge-laravel.test-1 /var/www/html/artisan migrate:refresh --seed
docker exec -it order-challenge-laravel.test-1 /var/www/html/artisan passport:install
echo  'successfully'
exit
