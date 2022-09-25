-- -------------------------------------------------------------
-- TablePlus 4.8.8(450)
--
-- https://tableplus.com/
--
-- Database: laravel
-- Generation Time: 2022-09-26 01:01:35.7950
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


CREATE TABLE `companies` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '0,1,2',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `companies_status_index` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `customer_addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `name` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '0,1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_addresses_status_index` (`status`),
  KEY `customer_addresses_customer_id_foreign` (`customer_id`),
  CONSTRAINT `customer_addresses_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `company_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '0,1,2',
  `role` tinyint NOT NULL DEFAULT '2' COMMENT '1,2',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customers_status_index` (`status`),
  KEY `customers_role_index` (`role`),
  KEY `customers_company_id_foreign` (`company_id`),
  CONSTRAINT `customers_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `client_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `client_id` bigint unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `oauth_clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `order_id` bigint unsigned NOT NULL,
  `company_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` double(8,2) NOT NULL,
  `total_price` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_products_product_id_foreign` (`product_id`),
  KEY `order_products_order_id_foreign` (`order_id`),
  KEY `order_products_company_id_foreign` (`company_id`),
  CONSTRAINT `order_products_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_products_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `company_id` bigint unsigned DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0,1,2',
  `shipping_status` enum('PENDING','DELIVERED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `shipping_date` datetime DEFAULT NULL,
  `customer_address_id` bigint unsigned DEFAULT NULL,
  `total` double(8,2) NOT NULL,
  `code` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_status_index` (`status`),
  KEY `orders_customer_id_foreign` (`customer_id`),
  KEY `orders_company_id_foreign` (`company_id`),
  KEY `orders_customer_address_id_foreign` (`customer_address_id`),
  CONSTRAINT `orders_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `orders_customer_address_id_foreign` FOREIGN KEY (`customer_address_id`) REFERENCES `customer_addresses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_id` bigint unsigned NOT NULL,
  `price` double(8,2) NOT NULL,
  `stock` int NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '0,1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_slug_unique` (`slug`),
  KEY `products_status_index` (`status`),
  KEY `products_company_id_foreign` (`company_id`),
  CONSTRAINT `products_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `companies` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Elissa Hickle', 1, '2022-09-25 21:42:44', '2022-09-25 21:42:44');

INSERT INTO `customer_addresses` (`id`, `customer_id`, `name`, `address_text`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 'Garrett Simonis', '38132 Hoppe Forge\nNorth Keeleyhaven, FL 29724', 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(2, 4, 'Milton Keeling', '3794 Greyson Springs\nWest Roberto, KY 17383-7168', 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(3, 5, 'Dr. Taylor Kemmer I', '3775 Prosacco Tunnel Apt. 489\nPort Lorenz, WY 26587-3268', 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(4, 6, 'Alanna Gutkowski', '559 Cremin Extensions Suite 752\nKaiabury, CA 64627', 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45');

INSERT INTO `customers` (`id`, `company_id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `status`, `role`, `created_at`, `updated_at`) VALUES
(1, 1, 'Kellen Ziemann', 'admin@example.org', '2022-09-25 21:42:45', '$2y$10$0WrDtn5dIkKK8alHjY5Io.x0jJR5jqvJJHC6wP/Wk0zpOW6VxFSkq', 'GWnX6J1JMv', 1, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(2, 1, 'Mr. Marquis Hettinger', 'test_user@example.org', '2022-09-25 21:42:45', '$2y$10$7hJGCQYya0D6rvEDKxAPbecrKEwZPFZZph6rSjeendsA1GKf9AsIu', 'pgexbzbHlC', 1, 2, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(3, 1, 'Carli Adams', 'banderson@example.org', '2022-09-25 21:42:45', '$2y$10$8jU4kaW2uREx8gD/lW0WEunnjjVJnXcDIbJPz78jwiInMQBsPuVq.', 'ADi3bOjbcq', 1, 2, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(4, 1, 'Arlie Prosacco', 'dameon19@example.net', '2022-09-25 21:42:45', '$2y$10$i05r9GgW.y49Rt6BbTpdPOuXTIsWW8AUA.GU6ARbKPnn7wzTxy.vm', 'ExP42wGdfH', 1, 2, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(5, 1, 'Ebony Kuphal PhD', 'amante@example.com', '2022-09-25 21:42:45', '$2y$10$posFQlSrhtdC2oL.aa4qVetnEoBboqLieuZzMtLn2cy0Z3J85S4q6', 'DqxWfqGqT3', 1, 2, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(6, 1, 'Mrs. Malvina Volkman', 'runte.antonia@example.com', '2022-09-25 21:42:45', '$2y$10$QPKy0.xn2MP2jywGRx6zEOW4AxY49Eflf3V3Y8baQQFmpEVXp.8jy', 'lqG0qUho2d', 1, 2, '2022-09-25 21:42:45', '2022-09-25 21:42:45');

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(2, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(3, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(4, '2016_06_01_000004_create_oauth_clients_table', 1),
(5, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(6, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(7, '2022_09_23_193601_make_table', 1);

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('0393115f8eb88d1deb8387c9abfc8a6c1821ce805e6a765286122195acdba1e10b1aef6388972d17', 2, 1, 'createToken', '[]', 0, '2022-09-25 21:46:49', '2022-09-25 21:46:49', '2023-09-25 21:46:49'),
('b6753810243445a69d6a405c9825d7fa0fa0da1dc4fd124c19d9c4b2002e60e063eedbb0b5c1670d', 3, 1, 'createToken', '[]', 0, '2022-09-25 21:56:39', '2022-09-25 21:56:39', '2023-09-25 21:56:39');

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', '6DjgB4o9YnAMg6F9g4Sy0keJZ0tnpBLo7vj3nZfm', NULL, 'http://localhost', 1, 0, 0, '2022-09-25 21:42:54', '2022-09-25 21:42:54'),
(2, NULL, 'Laravel Password Grant Client', 'ksOGRN8g5jw7ZY4T1LGYQzymIFsBX027UJ3ClnZY', 'users', 'http://localhost', 0, 1, 0, '2022-09-25 21:42:54', '2022-09-25 21:42:54');

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2022-09-25 21:42:54', '2022-09-25 21:42:54');

INSERT INTO `order_products` (`id`, `product_id`, `order_id`, `company_id`, `quantity`, `unit_price`, `total_price`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 11.46, 11.46, '2022-09-25 21:49:36', '2022-09-25 21:49:36'),
(2, 2, 1, 1, 1, 56.64, 56.64, '2022-09-25 21:49:36', '2022-09-25 21:49:36'),
(3, 3, 2, 1, 1, 62.65, 62.65, '2022-09-25 21:49:55', '2022-09-25 21:49:55'),
(4, 4, 2, 1, 1, 64.61, 64.61, '2022-09-25 21:49:55', '2022-09-25 21:49:55'),
(5, 1, 2, 1, 1, 11.46, 11.46, '2022-09-25 21:50:53', '2022-09-25 21:50:53'),
(6, 2, 2, 1, 2, 56.64, 113.28, '2022-09-25 21:50:53', '2022-09-25 21:50:53'),
(7, 3, 3, 1, 1, 62.65, 62.65, '2022-09-25 21:54:21', '2022-09-25 21:54:21'),
(8, 5, 3, 1, 1, 66.88, 66.88, '2022-09-25 21:54:21', '2022-09-25 21:54:21'),
(9, 3, 4, 1, 1, 62.65, 62.65, '2022-09-25 21:56:53', '2022-09-25 21:56:53'),
(10, 5, 4, 1, 1, 66.88, 66.88, '2022-09-25 21:56:53', '2022-09-25 21:56:53'),
(11, 1, 5, 1, 1, 11.46, 11.46, '2022-09-25 21:57:20', '2022-09-25 21:57:20'),
(12, 2, 5, 1, 1, 56.64, 56.64, '2022-09-25 21:57:20', '2022-09-25 21:57:20');

INSERT INTO `orders` (`id`, `customer_id`, `company_id`, `status`, `shipping_status`, `shipping_date`, `customer_address_id`, `total`, `code`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 1, 'PENDING', '2022-09-26 09:49:35', 1, 0.00, 'ABC7959', '2022-09-25 21:49:35', '2022-09-25 21:49:35'),
(2, 2, 1, 1, 'PENDING', '2022-09-27 09:49:55', 1, 0.00, 'ABC8862', '2022-09-25 21:49:55', '2022-09-25 21:49:55'),
(3, 2, 1, 1, 'PENDING', '2022-09-27 09:54:21', 1, 0.00, 'ABC8061', '2022-09-25 21:54:21', '2022-09-25 21:54:21'),
(4, 3, 1, 1, 'PENDING', '2022-09-26 09:56:53', 1, 0.00, 'ABC5205', '2022-09-25 21:56:53', '2022-09-25 21:56:53'),
(5, 3, 1, 1, 'PENDING', '2022-09-26 09:57:20', 1, 0.00, 'ABC9505', '2022-09-25 21:57:20', '2022-09-25 21:57:20');

INSERT INTO `products` (`id`, `name`, `slug`, `company_id`, `price`, `stock`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Lempi Torphy', 'lempi-torphy', 1, 11.46, 7, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(2, 'Adolph Pacocha', 'adolph-pacocha', 1, 56.64, 3, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(3, 'Catherine Lebsack', 'catherine-lebsack', 1, 62.65, 8, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(4, 'Ottilie Terry', 'ottilie-terry', 1, 64.61, 3, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(5, 'Bethany Lakin III', 'bethany-lakin-iii', 1, 66.88, 7, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(6, 'Christop Jakubowski', 'christop-jakubowski', 1, 80.60, 1, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(7, 'Ethel Mayer', 'ethel-mayer', 1, 78.19, 3, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(8, 'Jada King', 'jada-king', 1, 25.71, 2, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(9, 'Lenna Steuber', 'lenna-steuber', 1, 92.38, 7, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(10, 'Vito Brown', 'vito-brown', 1, 30.62, 3, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(11, 'Miss Maybell Balistreri', 'miss-maybell-balistreri', 1, 51.75, 8, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(12, 'Destiny Bins', 'destiny-bins', 1, 41.08, 5, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(13, 'Dr. Henderson Shanahan III', 'dr-henderson-shanahan-iii', 1, 97.02, 9, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(14, 'Mr. Geo Rowe', 'mr-geo-rowe', 1, 15.16, 7, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(15, 'Magali Runolfsdottir', 'magali-runolfsdottir', 1, 91.04, 6, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(16, 'Mr. Harmon Wuckert I', 'mr-harmon-wuckert-i', 1, 70.27, 4, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(17, 'Adriel Hodkiewicz', 'adriel-hodkiewicz', 1, 28.18, 1, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(18, 'Claud Kautzer III', 'claud-kautzer-iii', 1, 78.92, 9, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(19, 'Idell Lemke', 'idell-lemke', 1, 95.34, 8, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(20, 'Marta Durgan', 'marta-durgan', 1, 94.77, 9, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(21, 'Prof. Jon Fadel DVM', 'prof-jon-fadel-dvm', 1, 5.55, 4, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(22, 'Jude Brakus', 'jude-brakus', 1, 60.72, 4, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(23, 'Elinor Stiedemann', 'elinor-stiedemann', 1, 21.45, 1, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(24, 'Jordyn McCullough', 'jordyn-mccullough', 1, 23.13, 4, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(25, 'Annetta Larkin', 'annetta-larkin', 1, 38.24, 6, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(26, 'Alexander Feil', 'alexander-feil', 1, 17.31, 3, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(27, 'Gerson Reynolds II', 'gerson-reynolds-ii', 1, 40.35, 1, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(28, 'Jessica Yundt', 'jessica-yundt', 1, 31.82, 1, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(29, 'Mittie Streich', 'mittie-streich', 1, 45.61, 7, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(30, 'Ms. Amelie Hagenes', 'ms-amelie-hagenes', 1, 72.78, 8, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(31, 'Miss Emelia Hessel Jr.', 'miss-emelia-hessel-jr', 1, 90.61, 6, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(32, 'Billie Cronin', 'billie-cronin', 1, 43.45, 8, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(33, 'Hildegard Lockman', 'hildegard-lockman', 1, 77.17, 2, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(34, 'Katlynn Prohaska', 'katlynn-prohaska', 1, 5.30, 0, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(35, 'Prof. Celine Wunsch', 'prof-celine-wunsch', 1, 14.05, 1, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(36, 'Ms. Theresa Keebler', 'ms-theresa-keebler', 1, 14.70, 2, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(37, 'Dr. Alexane Konopelski DVM', 'dr-alexane-konopelski-dvm', 1, 43.85, 7, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(38, 'Prof. Coby Cassin', 'prof-coby-cassin', 1, 72.02, 6, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(39, 'Mr. Rahul Frami', 'mr-rahul-frami', 1, 32.96, 1, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(40, 'Jerrold O\'Connell DVM', 'jerrold-oconnell-dvm', 1, 82.79, 4, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(41, 'Antone Wunsch', 'antone-wunsch', 1, 37.02, 1, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(42, 'Mr. Robin Hand Sr.', 'mr-robin-hand-sr', 1, 47.82, 4, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(43, 'Prof. Carter Koepp', 'prof-carter-koepp', 1, 21.24, 7, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(44, 'Joesph Predovic', 'joesph-predovic', 1, 16.65, 1, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(45, 'Miss Vita Bailey III', 'miss-vita-bailey-iii', 1, 47.54, 2, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(46, 'Rubie Runolfsdottir', 'rubie-runolfsdottir', 1, 90.76, 7, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(47, 'Malcolm Simonis', 'malcolm-simonis', 1, 82.10, 6, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(48, 'Adolfo Schaden', 'adolfo-schaden', 1, 57.27, 7, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(49, 'Lilly Christiansen', 'lilly-christiansen', 1, 61.35, 6, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(50, 'Prof. Ethyl Volkman', 'prof-ethyl-volkman', 1, 82.96, 9, 0, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(51, 'Josie O\'Keefe', 'josie-okeefe', 1, 68.98, 2, 1, '2022-09-25 21:42:45', '2022-09-25 21:42:45'),
(52, 'Leone Wisozk III', 'leone-wisozk-iii', 1, 47.99, 5, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(53, 'Dr. Valentina Balistreri', 'dr-valentina-balistreri', 1, 17.98, 7, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(54, 'Alva Bailey', 'alva-bailey', 1, 92.07, 5, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(55, 'Freeda Kunde', 'freeda-kunde', 1, 24.95, 8, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(56, 'Darrin Thiel Sr.', 'darrin-thiel-sr', 1, 67.95, 0, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(57, 'Elinore Howe DVM', 'elinore-howe-dvm', 1, 47.46, 7, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(58, 'Mrs. Linda Kshlerin Jr.', 'mrs-linda-kshlerin-jr', 1, 43.14, 4, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(59, 'Linwood Schaefer Jr.', 'linwood-schaefer-jr', 1, 6.66, 3, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(60, 'Sarai Hartmann', 'sarai-hartmann', 1, 72.63, 1, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(61, 'Lourdes Ledner II', 'lourdes-ledner-ii', 1, 30.74, 2, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(62, 'Charlotte Rolfson', 'charlotte-rolfson', 1, 39.39, 3, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(63, 'Mr. Ralph Watsica', 'mr-ralph-watsica', 1, 20.03, 9, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(64, 'Kendall Wyman DVM', 'kendall-wyman-dvm', 1, 20.36, 8, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(65, 'Dariana Murphy', 'dariana-murphy', 1, 96.85, 6, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(66, 'Prof. Savanna Weber I', 'prof-savanna-weber-i', 1, 28.33, 0, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(67, 'Dayton Kovacek', 'dayton-kovacek', 1, 85.73, 0, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(68, 'Dell Gleason III', 'dell-gleason-iii', 1, 79.63, 6, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(69, 'Ellis Botsford', 'ellis-botsford', 1, 68.61, 4, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(70, 'Alycia Jacobs', 'alycia-jacobs', 1, 32.12, 5, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(71, 'Kelley Osinski I', 'kelley-osinski-i', 1, 16.86, 7, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(72, 'Clint Bartoletti', 'clint-bartoletti', 1, 23.35, 6, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(73, 'Dr. Angelina Labadie', 'dr-angelina-labadie', 1, 59.97, 0, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(74, 'Dr. Horace Nitzsche', 'dr-horace-nitzsche', 1, 42.78, 4, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(75, 'Catharine Nitzsche Jr.', 'catharine-nitzsche-jr', 1, 42.37, 0, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(76, 'Roel Medhurst', 'roel-medhurst', 1, 65.61, 4, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(77, 'Mr. Humberto Deckow', 'mr-humberto-deckow', 1, 27.38, 4, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(78, 'Alysha Wiegand', 'alysha-wiegand', 1, 72.71, 7, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(79, 'Karli Wisoky', 'karli-wisoky', 1, 45.33, 7, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(80, 'Victor Ondricka II', 'victor-ondricka-ii', 1, 33.78, 2, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(81, 'Connor Altenwerth', 'connor-altenwerth', 1, 27.51, 9, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(82, 'Kiera Grant', 'kiera-grant', 1, 50.27, 3, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(83, 'Flo Flatley', 'flo-flatley', 1, 69.06, 1, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(84, 'Casper Considine', 'casper-considine', 1, 83.41, 4, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(85, 'Tommie Schultz', 'tommie-schultz', 1, 36.20, 4, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(86, 'Bailey Crona', 'bailey-crona', 1, 40.06, 6, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(87, 'Alexandrea Skiles', 'alexandrea-skiles', 1, 92.85, 8, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(88, 'River Leuschke DDS', 'river-leuschke-dds', 1, 78.66, 5, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(89, 'Miss Margarett Kovacek III', 'miss-margarett-kovacek-iii', 1, 89.60, 0, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(90, 'Madalyn Hirthe', 'madalyn-hirthe', 1, 53.25, 7, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(91, 'Elva Halvorson', 'elva-halvorson', 1, 66.97, 4, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(92, 'Prof. Lennie Langosh PhD', 'prof-lennie-langosh-phd', 1, 24.97, 9, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(93, 'Miss Alycia Parisian Sr.', 'miss-alycia-parisian-sr', 1, 86.46, 8, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(94, 'Pasquale Walker', 'pasquale-walker', 1, 64.21, 6, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(95, 'Jerry Romaguera', 'jerry-romaguera', 1, 99.34, 0, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(96, 'Al West', 'al-west', 1, 70.89, 2, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(97, 'Natalia Muller', 'natalia-muller', 1, 14.05, 9, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(98, 'Cesar Nader PhD', 'cesar-nader-phd', 1, 56.51, 0, 1, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(99, 'Jewell Heidenreich', 'jewell-heidenreich', 1, 59.48, 1, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46'),
(100, 'Mr. Dagmar Osinski MD', 'mr-dagmar-osinski-md', 1, 90.58, 5, 0, '2022-09-25 21:42:46', '2022-09-25 21:42:46');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;