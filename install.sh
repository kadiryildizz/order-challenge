#!/bin/bash
cp .env.example .env
composer install
./vendor/bin/sail up -d
sleep 20
docker exec -it order-challenge-laravel.test-1 /var/www/html/artisan key:generate
docker exec -it order-challenge-laravel.test-1 /var/www/html/artisan migrate:refresh --seed
docker exec -it order-challenge-laravel.test-1 /var/www/html/artisan passport:install
echo  'successfully'
exit
