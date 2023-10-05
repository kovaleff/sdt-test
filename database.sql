-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Окт 05 2023 г., 22:00
-- Версия сервера: 8.0.34-0ubuntu0.22.04.1
-- Версия PHP: 8.1.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `sdt`
--

-- --------------------------------------------------------

--
-- Структура таблицы `clients`
--

CREATE TABLE `clients` (
  `id` bigint UNSIGNED NOT NULL,
  `name` char(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `clients`
--

INSERT INTO `clients` (`id`, `name`) VALUES
(1, 'client1'),
(6, 'Client1'),
(7, 'Client2'),
(8, 'Client3'),
(9, 'Client4'),
(5, 'Client5'),
(10, 'Client5');

-- --------------------------------------------------------

--
-- Структура таблицы `merchandise`
--

CREATE TABLE `merchandise` (
  `id` bigint UNSIGNED NOT NULL,
  `name` char(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `merchandise`
--

INSERT INTO `merchandise` (`id`, `name`) VALUES
(1, 'merchandise1'),
(2, 'Merchandise5'),
(3, 'Merchandise5'),
(4, 'Merchandise1'),
(5, 'Merchandise2'),
(6, 'Merchandise3'),
(7, 'Merchandise4'),
(8, 'Merchandise5');

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id` bigint UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `comment` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('new','complete') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`id`, `item_id`, `customer_id`, `comment`, `status`, `order_date`) VALUES
(1, 7, 5, 'comment:695', 'new', '2020-12-08'),
(2, 1, 7, 'comment:543', 'new', '2020-12-11'),
(4, 7, 6, 'comment:208', 'complete', '2020-12-08'),
(5, 5, 5, 'comment:812', 'new', '2020-12-10'),
(7, 1, 5, 'comment:770', 'complete', '2020-12-09'),
(8, 1, 1, 'comment:525', 'complete', '2020-12-10'),
(9, 7, 7, 'comment:978', 'complete', '2020-12-08'),
(12, 1, 1, 'comment', NULL, '2023-10-05'),
(13, 1, 1, 'comment,100', NULL, '2023-10-05'),
(14, 1, 1, 'comment', NULL, '2023-10-05');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `byname` (`name`);

--
-- Индексы таблицы `merchandise`
--
ALTER TABLE `merchandise`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_ibfk_1` (`customer_id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `bydate` (`order_date`),
  ADD KEY `bystatus` (`status`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `clients`
--
ALTER TABLE `clients`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `merchandise`
--
ALTER TABLE `merchandise`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `clients` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `merchandise` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
