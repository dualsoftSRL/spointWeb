-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-06-2020 a las 16:08:53
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.3.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `spoint_db`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ncfprocedure` (IN `idncfobtenido` INT, IN `business_id1` INT)  BEGIN
DECLARE registros1 INT;
    DECLARE registros2 INT;
        DECLARE registros3 INT;
DECLARE registro4 INT;
set registros3=(SELECT COUNT(*) FROM ncf_secuencia WHERE status=2 AND idncf=idncfobtenido AND business_id=business_id1 and fecha_venc<=curdate() ORDER BY status LIMIT 1);
	 
    set registros2=0;

                   SET registros1=(SELECT idncfsecuencia FROM ncf_secuencia WHERE status=1 AND idncf=idncfobtenido AND business_id=business_id1 ORDER BY status LIMIT 1);
 SET registro4=(SELECT idncfsecuencia FROM ncf_secuencia WHERE STATUS=2 AND idncf=idncfobtenido AND business_id=business_id1 ORDER BY status LIMIT 1);
 if registros3=1
        THEN
        	update ncf_secuencia set status=3 where STATUS=2 and idncfsecuencia=registro4 and business_id=business_id1;
        end if;
		set registros2=(SELECT COUNT(*) FROM ncf_secuencia WHERE status=2 AND idncf=idncfobtenido AND business_id=business_id1 ORDER BY status LIMIT 1);
	
		if registros2=0
		then
		update ncf_secuencia set status=2 where status=1 and idncfsecuencia=registros1 AND business_id=business_id1;
		end if;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accounts`
--

CREATE TABLE `accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_type_id` int(11) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `is_closed` tinyint(1) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `account_transactions`
--

CREATE TABLE `account_transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_id` int(11) NOT NULL,
  `type` enum('debit','credit') COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_type` enum('opening_balance','fund_transfer','deposit') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(22,4) NOT NULL,
  `reff_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operation_date` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `transaction_payment_id` int(11) DEFAULT NULL,
  `transfer_transaction_id` int(11) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `account_types`
--

CREATE TABLE `account_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_account_type_id` int(11) DEFAULT NULL,
  `business_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `activity_log`
--

CREATE TABLE `activity_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `log_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `subject_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_id` int(11) DEFAULT NULL,
  `causer_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `properties` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `activity_log`
--

INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_id`, `subject_type`, `causer_id`, `causer_type`, `properties`, `created_at`, `updated_at`) VALUES
(1, 'default', 'edited', 12, 'App\\Transaction', 4, 'App\\User', '[]', '2020-03-06 14:00:22', '2020-03-06 14:00:22'),
(2, 'default', 'edited', 58, 'App\\Transaction', 1, 'App\\User', '[]', '2020-05-09 14:31:58', '2020-05-09 14:31:58'),
(3, 'default', 'edited', 58, 'App\\Transaction', 1, 'App\\User', '[]', '2020-05-09 14:32:12', '2020-05-09 14:32:12'),
(4, 'default', 'edited', 55, 'App\\Transaction', 5, 'App\\User', '[]', '2020-05-09 15:00:45', '2020-05-09 15:00:45'),
(5, 'default', 'edited', 63, 'App\\Transaction', 5, 'App\\User', '[]', '2020-05-14 13:37:23', '2020-05-14 13:37:23'),
(6, 'default', 'edited', 81, 'App\\Transaction', 1, 'App\\User', '[]', '2020-06-03 19:20:40', '2020-06-03 19:20:40'),
(7, 'default', 'edited', 82, 'App\\Transaction', 1, 'App\\User', '[]', '2020-06-08 13:29:20', '2020-06-08 13:29:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barcodes`
--

CREATE TABLE `barcodes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `width` double(22,4) DEFAULT NULL,
  `height` double(22,4) DEFAULT NULL,
  `paper_width` double(22,4) DEFAULT NULL,
  `paper_height` double(22,4) DEFAULT NULL,
  `top_margin` double(22,4) DEFAULT NULL,
  `left_margin` double(22,4) DEFAULT NULL,
  `row_distance` double(22,4) DEFAULT NULL,
  `col_distance` double(22,4) DEFAULT NULL,
  `stickers_in_one_row` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_continuous` tinyint(1) NOT NULL DEFAULT 0,
  `stickers_in_one_sheet` int(11) DEFAULT NULL,
  `business_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `barcodes`
--

INSERT INTO `barcodes` (`id`, `name`, `description`, `width`, `height`, `paper_width`, `paper_height`, `top_margin`, `left_margin`, `row_distance`, `col_distance`, `stickers_in_one_row`, `is_default`, `is_continuous`, `stickers_in_one_sheet`, `business_id`, `created_at`, `updated_at`) VALUES
(1, '20 Labels per Sheet - (8.5\" x 11\")', 'Sheet Size: 8.5\" x 11\"\\r\\nLabel Size: 4\" x 1\"\\r\\nLabels per sheet: 20', 3.7500, 1.0000, 8.5000, 11.0000, 0.5000, 0.5000, 0.0000, 0.1562, 2, 0, 0, 20, NULL, '2017-12-18 10:13:44', '2017-12-18 10:13:44'),
(2, '30 Labels per sheet - (8.5\" x 11\")', 'Sheet Size: 8.5\" x 11\"\\r\\nLabel Size: 2.625\" x 1\"\\r\\nLabels per sheet: 30', 2.6250, 1.0000, 8.5000, 11.0000, 0.5000, 0.2198, 0.0000, 0.1400, 3, 0, 0, 30, NULL, '2017-12-18 10:04:39', '2017-12-18 10:10:40'),
(3, '32 Labels per sheet - (8.5\" x 11\")', 'Sheet Size: 8.5\" x 11\"\\r\\nLabel Size: 2\" x 1.25\"\\r\\nLabels per sheet: 32', 2.0000, 1.2500, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 32, NULL, '2017-12-18 09:55:40', '2017-12-18 09:55:40'),
(4, '40 Labels per sheet - (8.5\" x 11\")', 'Sheet Size: 8.5\" x 11\"\\r\\nLabel Size: 2\" x 1\"\\r\\nLabels per sheet: 40', 2.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 40, NULL, '2017-12-18 09:58:40', '2017-12-18 09:58:40'),
(5, '50 Labels per Sheet - (8.5\" x 11\")', 'Sheet Size: 8.5\" x 11\"\\r\\nLabel Size: 1.5\" x 1\"\\r\\nLabels per sheet: 50', 1.5000, 1.0000, 8.5000, 11.0000, 0.5000, 0.5000, 0.0000, 0.0000, 5, 0, 0, 50, NULL, '2017-12-18 09:51:10', '2017-12-18 09:51:10'),
(6, 'Continuous Rolls - 31.75mm x 25.4mm', 'Label Size: 31.75mm x 25.4mm\\r\\nGap: 3.18mm', 1.2500, 1.0000, 1.2500, 0.0000, 0.1250, 0.0000, 0.1250, 0.0000, 1, 0, 1, NULL, NULL, '2017-12-18 09:51:10', '2017-12-18 09:51:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bookings`
--

CREATE TABLE `bookings` (
  `id` int(10) UNSIGNED NOT NULL,
  `contact_id` int(10) UNSIGNED NOT NULL,
  `waiter_id` int(10) UNSIGNED DEFAULT NULL,
  `table_id` int(10) UNSIGNED DEFAULT NULL,
  `correspondent_id` int(11) DEFAULT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `booking_start` datetime NOT NULL,
  `booking_end` datetime NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `booking_status` enum('booked','completed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `brands`
--

INSERT INTO `brands` (`id`, `business_id`, `name`, `description`, `created_by`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'Intel', 'ninguna', 1, '2020-06-08 13:44:45', '2020-03-04 19:36:53', '2020-06-08 13:44:45'),
(2, 2, 'Intel', 'Ninguna', 3, NULL, '2020-03-05 13:24:11', '2020-03-05 13:24:11'),
(3, 1, 'Zte', 'ninguna', 1, NULL, '2020-03-05 17:57:15', '2020-03-05 17:57:15'),
(4, 4, 'DSC', NULL, 15, NULL, '2020-05-12 11:11:32', '2020-05-12 11:11:32'),
(5, 1, 'Marca ejemplo', 'esta es un ejemplo de marca', 1, NULL, '2020-06-03 19:04:12', '2020-06-03 19:04:30'),
(6, 1, 'marca de', 'editada', 1, NULL, '2020-06-08 13:44:12', '2020-06-08 13:44:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `business`
--

CREATE TABLE `business` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_id` int(10) UNSIGNED NOT NULL,
  `start_date` date DEFAULT NULL,
  `tax_number_1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_label_1` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_number_2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_label_2` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_sales_tax` int(10) UNSIGNED DEFAULT NULL,
  `default_profit_percent` double(5,2) NOT NULL DEFAULT 0.00,
  `owner_id` int(10) UNSIGNED NOT NULL,
  `time_zone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Asia/Kolkata',
  `fy_start_month` tinyint(4) NOT NULL DEFAULT 1,
  `accounting_method` enum('fifo','lifo','avco') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fifo',
  `default_sales_discount` decimal(5,2) DEFAULT NULL,
  `sell_price_tax` enum('includes','excludes') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'includes',
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku_prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_product_expiry` tinyint(1) NOT NULL DEFAULT 0,
  `expiry_type` enum('add_expiry','add_manufacturing') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'add_expiry',
  `on_product_expiry` enum('keep_selling','stop_selling','auto_delete') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'keep_selling',
  `stop_selling_before` int(11) NOT NULL COMMENT 'Stop selling expied item n days before expiry',
  `enable_tooltip` tinyint(1) NOT NULL DEFAULT 1,
  `purchase_in_diff_currency` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Allow purchase to be in different currency then the business currency',
  `purchase_currency_id` int(10) UNSIGNED DEFAULT NULL,
  `p_exchange_rate` decimal(20,3) NOT NULL DEFAULT 1.000,
  `transaction_edit_days` int(10) UNSIGNED NOT NULL DEFAULT 30,
  `stock_expiry_alert_days` int(10) UNSIGNED NOT NULL DEFAULT 30,
  `keyboard_shortcuts` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pos_settings` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_brand` tinyint(1) NOT NULL DEFAULT 1,
  `enable_category` tinyint(1) NOT NULL DEFAULT 1,
  `enable_sub_category` tinyint(1) NOT NULL DEFAULT 1,
  `enable_price_tax` tinyint(1) NOT NULL DEFAULT 1,
  `enable_purchase_status` tinyint(1) DEFAULT 1,
  `enable_lot_number` tinyint(1) NOT NULL DEFAULT 0,
  `default_unit` int(11) DEFAULT NULL,
  `enable_sub_units` tinyint(1) NOT NULL DEFAULT 0,
  `enable_racks` tinyint(1) NOT NULL DEFAULT 0,
  `enable_row` tinyint(1) NOT NULL DEFAULT 0,
  `enable_position` tinyint(1) NOT NULL DEFAULT 0,
  `enable_editing_product_from_purchase` tinyint(1) NOT NULL DEFAULT 1,
  `sales_cmsn_agnt` enum('logged_in_user','user','cmsn_agnt') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_addition_method` tinyint(1) NOT NULL DEFAULT 1,
  `enable_inline_tax` tinyint(1) NOT NULL DEFAULT 1,
  `currency_symbol_placement` enum('before','after') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'before',
  `enabled_modules` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_format` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'm/d/Y',
  `time_format` enum('12','24') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '24',
  `ref_no_prefixes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme_color` char(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `enable_rp` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `rp_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `amount_for_unit_rp` decimal(22,4) NOT NULL DEFAULT 1.0000 COMMENT 'rp is the short form of reward points',
  `min_order_total_for_rp` decimal(22,4) NOT NULL DEFAULT 1.0000 COMMENT 'rp is the short form of reward points',
  `max_rp_per_order` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `redeem_amount_per_unit_rp` decimal(22,4) NOT NULL DEFAULT 1.0000 COMMENT 'rp is the short form of reward points',
  `min_order_total_for_redeem` decimal(22,4) NOT NULL DEFAULT 1.0000 COMMENT 'rp is the short form of reward points',
  `min_redeem_point` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `max_redeem_point` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `rp_expiry_period` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `rp_expiry_type` enum('month','year') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'year' COMMENT 'rp is the short form of reward points',
  `email_settings` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sms_settings` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_labels` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `common_settings` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `rnc` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `business`
--

INSERT INTO `business` (`id`, `name`, `currency_id`, `start_date`, `tax_number_1`, `tax_label_1`, `tax_number_2`, `tax_label_2`, `default_sales_tax`, `default_profit_percent`, `owner_id`, `time_zone`, `fy_start_month`, `accounting_method`, `default_sales_discount`, `sell_price_tax`, `logo`, `sku_prefix`, `enable_product_expiry`, `expiry_type`, `on_product_expiry`, `stop_selling_before`, `enable_tooltip`, `purchase_in_diff_currency`, `purchase_currency_id`, `p_exchange_rate`, `transaction_edit_days`, `stock_expiry_alert_days`, `keyboard_shortcuts`, `pos_settings`, `enable_brand`, `enable_category`, `enable_sub_category`, `enable_price_tax`, `enable_purchase_status`, `enable_lot_number`, `default_unit`, `enable_sub_units`, `enable_racks`, `enable_row`, `enable_position`, `enable_editing_product_from_purchase`, `sales_cmsn_agnt`, `item_addition_method`, `enable_inline_tax`, `currency_symbol_placement`, `enabled_modules`, `date_format`, `time_format`, `ref_no_prefixes`, `theme_color`, `created_by`, `enable_rp`, `rp_name`, `amount_for_unit_rp`, `min_order_total_for_rp`, `max_rp_per_order`, `redeem_amount_per_unit_rp`, `min_order_total_for_redeem`, `min_redeem_point`, `max_redeem_point`, `rp_expiry_period`, `rp_expiry_type`, `email_settings`, `sms_settings`, `custom_labels`, `common_settings`, `is_active`, `created_at`, `updated_at`, `rnc`) VALUES
(1, 'Dualsoft', 33, '2020-03-04', NULL, NULL, NULL, NULL, NULL, 25.00, 1, 'America/Santo_Domingo', 1, 'fifo', '0.00', 'includes', '1583507749_logo-01.jpg', NULL, 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, '1.000', 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"recent_product_quantity\":\"f2\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"add_new_product\":\"f4\"}}', '{\"show_credit_sale_button\":\"1\",\"disable_pay_checkout\":0,\"disable_draft\":0,\"disable_express_checkout\":0,\"hide_product_suggestion\":0,\"hide_recent_trans\":0,\"disable_discount\":0,\"disable_order_tax\":0,\"is_pos_subtotal_editable\":0}', 1, 1, 1, 1, 1, 0, NULL, 0, 0, 0, 0, 1, 'logged_in_user', 1, 0, 'before', NULL, 'm/d/Y', '24', '{\"purchase\":\"PO\",\"purchase_return\":null,\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"expense_payment\":null,\"business_location\":\"BL\",\"username\":null,\"subscription\":null}', NULL, NULL, 0, NULL, '1.0000', '1.0000', NULL, '1.0000', '1.0000', NULL, NULL, NULL, 'year', '{\"mail_driver\":\"smtp\",\"mail_host\":null,\"mail_port\":null,\"mail_username\":null,\"mail_password\":\"Ubunto084\",\"mail_encryption\":null,\"mail_from_address\":null,\"mail_from_name\":null}', '{\"url\":null,\"send_to_param_name\":\"to\",\"msg_param_name\":\"text\",\"request_method\":\"post\",\"param_1\":null,\"param_val_1\":null,\"param_2\":null,\"param_val_2\":null,\"param_3\":null,\"param_val_3\":null,\"param_4\":null,\"param_val_4\":null,\"param_5\":null,\"param_val_5\":null,\"param_6\":null,\"param_val_6\":null,\"param_7\":null,\"param_val_7\":null,\"param_8\":null,\"param_val_8\":null,\"param_9\":null,\"param_val_9\":null,\"param_10\":null,\"param_val_10\":null}', '{\"payments\":{\"custom_pay_1\":null,\"custom_pay_2\":null,\"custom_pay_3\":null}}', '{\"default_datatable_page_entries\":\"25\"}', 1, '2020-03-05 05:06:01', '2020-06-12 17:05:34', '4010201'),
(2, 'Botana', 33, '2020-03-05', NULL, NULL, NULL, NULL, NULL, 25.00, 3, 'America/Santo_Domingo', 1, 'fifo', '0.00', 'includes', '1584706871_logo_botana.png', NULL, 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, '1.000', 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"recent_product_quantity\":\"f2\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"add_new_product\":\"f4\"}}', '{\"allow_overselling\":\"1\",\"disable_order_tax\":\"1\",\"is_pos_subtotal_editable\":\"1\",\"show_credit_sale_button\":\"1\",\"disable_pay_checkout\":0,\"disable_draft\":0,\"disable_express_checkout\":0,\"hide_product_suggestion\":0,\"hide_recent_trans\":0,\"disable_discount\":0}', 0, 1, 1, 1, 0, 0, 2, 0, 0, 0, 0, 1, NULL, 1, 0, 'before', NULL, 'd-m-Y', '24', '{\"purchase\":\"OC\",\"purchase_return\":\"DC\",\"stock_transfer\":\"TA\",\"stock_adjustment\":\"AI\",\"sell_return\":\"CN\",\"expense\":\"GA\",\"contacts\":\"CO\",\"purchase_payment\":\"PC\",\"sell_payment\":\"PV\",\"expense_payment\":\"PG\",\"business_location\":\"UB\",\"username\":null,\"subscription\":null}', 'red', NULL, 0, NULL, '1.0000', '1.0000', NULL, '1.0000', '1.0000', NULL, NULL, NULL, 'year', '{\"mail_driver\":\"smtp\",\"mail_host\":null,\"mail_port\":null,\"mail_username\":null,\"mail_password\":null,\"mail_encryption\":null,\"mail_from_address\":null,\"mail_from_name\":null}', '{\"url\":null,\"send_to_param_name\":\"to\",\"msg_param_name\":\"text\",\"request_method\":\"post\",\"param_1\":null,\"param_val_1\":null,\"param_2\":null,\"param_val_2\":null,\"param_3\":null,\"param_val_3\":null,\"param_4\":null,\"param_val_4\":null,\"param_5\":null,\"param_val_5\":null,\"param_6\":null,\"param_val_6\":null,\"param_7\":null,\"param_val_7\":null,\"param_8\":null,\"param_val_8\":null,\"param_9\":null,\"param_val_9\":null,\"param_10\":null,\"param_val_10\":null}', '{\"payments\":{\"custom_pay_1\":null,\"custom_pay_2\":null,\"custom_pay_3\":null}}', '{\"default_datatable_page_entries\":\"50\"}', 1, '2020-03-05 22:38:31', '2020-03-20 12:21:11', NULL),
(3, 'FJServices', 2, '2020-03-09', NULL, NULL, NULL, NULL, NULL, 25.00, 14, 'America/Santo_Domingo', 1, 'fifo', '0.00', 'includes', '1586880637_software_logo-01-01-300x98.png', NULL, 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, '1.000', 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"recent_product_quantity\":\"f2\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"add_new_product\":\"f4\"}}', '{\"hide_product_suggestion\":\"1\",\"hide_recent_trans\":\"1\",\"disable_order_tax\":\"1\",\"show_credit_sale_button\":\"1\",\"disable_pay_checkout\":0,\"disable_draft\":0,\"disable_express_checkout\":0,\"disable_discount\":0,\"is_pos_subtotal_editable\":0}', 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 1, NULL, 1, 0, 'before', NULL, 'd-m-Y', '12', '{\"purchase\":\"PO\",\"purchase_return\":null,\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"expense_payment\":null,\"business_location\":\"BL\",\"username\":null,\"subscription\":null}', 'green', NULL, 0, NULL, '1.0000', '1.0000', NULL, '1.0000', '1.0000', NULL, NULL, NULL, 'year', '{\"mail_driver\":\"smtp\",\"mail_host\":null,\"mail_port\":null,\"mail_username\":null,\"mail_password\":null,\"mail_encryption\":null,\"mail_from_address\":null,\"mail_from_name\":null}', '{\"url\":null,\"send_to_param_name\":\"to\",\"msg_param_name\":\"text\",\"request_method\":\"post\",\"param_1\":null,\"param_val_1\":null,\"param_2\":null,\"param_val_2\":null,\"param_3\":null,\"param_val_3\":null,\"param_4\":null,\"param_val_4\":null,\"param_5\":null,\"param_val_5\":null,\"param_6\":null,\"param_val_6\":null,\"param_7\":null,\"param_val_7\":null,\"param_8\":null,\"param_val_8\":null,\"param_9\":null,\"param_val_9\":null,\"param_10\":null,\"param_val_10\":null}', '{\"payments\":{\"custom_pay_1\":null,\"custom_pay_2\":null,\"custom_pay_3\":null}}', '{\"default_datatable_page_entries\":\"100\"}', 1, '2020-03-09 23:54:04', '2020-04-14 16:10:37', NULL),
(4, 'ASP Security', 33, '2020-05-11', NULL, NULL, NULL, NULL, NULL, 25.00, 15, 'America/Santo_Domingo', 1, 'fifo', NULL, 'includes', '1589200326_4d4708d8-3289-4971-bded-9e0a82029975.jpg', NULL, 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, '1.000', 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"recent_product_quantity\":\"f2\",\"add_new_product\":\"f4\"}}', NULL, 1, 1, 1, 1, 1, 0, NULL, 0, 0, 0, 0, 1, NULL, 1, 0, 'before', NULL, 'm/d/Y', '24', '{\"purchase\":\"PO\",\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"business_location\":\"BL\"}', NULL, NULL, 0, NULL, '1.0000', '1.0000', NULL, '1.0000', '1.0000', NULL, NULL, NULL, 'year', NULL, NULL, NULL, NULL, 1, '2020-05-11 22:02:06', '2020-05-11 22:02:06', NULL),
(5, 'ASW EXPRESS', 33, '2020-05-11', NULL, NULL, NULL, NULL, NULL, 25.00, 16, 'America/Santo_Domingo', 1, 'fifo', '0.00', 'includes', '1589205951_ASW.jpeg', NULL, 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, '1.000', 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"recent_product_quantity\":\"f2\",\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"add_new_product\":\"f4\"}}', '{\"allow_overselling\":\"1\",\"hide_product_suggestion\":\"1\",\"hide_recent_trans\":\"1\",\"is_pos_subtotal_editable\":\"1\",\"show_credit_sale_button\":\"1\",\"disable_pay_checkout\":0,\"disable_draft\":0,\"disable_express_checkout\":0,\"disable_discount\":0,\"disable_order_tax\":0}', 0, 1, 0, 1, 0, 0, NULL, 0, 0, 0, 0, 1, NULL, 1, 0, 'before', '[\"types_of_service\"]', 'd/m/Y', '12', '{\"purchase\":\"OC\",\"purchase_return\":\"DC\",\"stock_transfer\":\"TR\",\"stock_adjustment\":\"AS\",\"sell_return\":\"DE\",\"expense\":\"GA\",\"contacts\":\"CO\",\"purchase_payment\":\"PC\",\"sell_payment\":\"SP\",\"expense_payment\":null,\"business_location\":\"BL\",\"username\":null,\"subscription\":null}', NULL, NULL, 0, NULL, '1.0000', '1.0000', NULL, '1.0000', '1.0000', NULL, NULL, NULL, 'year', '{\"mail_driver\":\"smtp\",\"mail_host\":null,\"mail_port\":null,\"mail_username\":null,\"mail_password\":null,\"mail_encryption\":null,\"mail_from_address\":null,\"mail_from_name\":null}', '{\"url\":null,\"send_to_param_name\":\"to\",\"msg_param_name\":\"text\",\"request_method\":\"post\",\"param_1\":null,\"param_val_1\":null,\"param_2\":null,\"param_val_2\":null,\"param_3\":null,\"param_val_3\":null,\"param_4\":null,\"param_val_4\":null,\"param_5\":null,\"param_val_5\":null,\"param_6\":null,\"param_val_6\":null,\"param_7\":null,\"param_val_7\":null,\"param_8\":null,\"param_val_8\":null,\"param_9\":null,\"param_val_9\":null,\"param_10\":null,\"param_val_10\":null}', '{\"payments\":{\"custom_pay_1\":null,\"custom_pay_2\":null,\"custom_pay_3\":null}}', '{\"default_datatable_page_entries\":\"100\"}', 1, '2020-05-11 23:35:51', '2020-05-12 11:27:25', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `business_locations`
--

CREATE TABLE `business_locations` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `landmark` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zip_code` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_scheme_id` int(10) UNSIGNED NOT NULL,
  `invoice_layout_id` int(10) UNSIGNED NOT NULL,
  `selling_price_group_id` int(11) DEFAULT NULL,
  `print_receipt_on_invoice` tinyint(1) DEFAULT 1,
  `receipt_printer_type` enum('browser','printer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'browser',
  `printer_id` int(11) DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternate_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `default_payment_accounts` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `custom_field2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `printer_on` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `business_locations`
--

INSERT INTO `business_locations` (`id`, `business_id`, `location_id`, `name`, `landmark`, `country`, `state`, `city`, `zip_code`, `invoice_scheme_id`, `invoice_layout_id`, `selling_price_group_id`, `print_receipt_on_invoice`, `receipt_printer_type`, `printer_id`, `mobile`, `alternate_number`, `email`, `website`, `is_active`, `default_payment_accounts`, `custom_field1`, `custom_field2`, `custom_field3`, `custom_field4`, `deleted_at`, `created_at`, `updated_at`, `printer_on`) VALUES
(1, 1, 'BL0001', 'Dualsoft', 'Moca', 'República Dominicana', 'Espaillat', 'Moca', '56000', 1, 2, NULL, 1, 'browser', NULL, NULL, NULL, NULL, NULL, 1, '{\"cash\":{\"is_enabled\":\"1\"},\"card\":{\"is_enabled\":\"1\"},\"cheque\":{\"is_enabled\":\"1\"},\"bank_transfer\":{\"is_enabled\":\"1\"},\"other\":{\"is_enabled\":\"1\"},\"custom_pay_1\":{\"is_enabled\":\"1\"},\"custom_pay_2\":{\"is_enabled\":\"1\"},\"custom_pay_3\":{\"is_enabled\":\"1\"}}', '1', NULL, NULL, NULL, NULL, '2020-03-05 05:06:01', '2020-03-26 15:11:29', '1'),
(2, 2, 'BL0001', 'Botana - Empanadas artesanales', 'Moca', 'República Dominicana', 'Espaillat', 'Moca', '56000', 3, 4, 0, 1, 'browser', NULL, '809-578-0517', NULL, NULL, NULL, 1, '{\"cash\":{\"is_enabled\":\"1\"},\"custom_pay_1\":{\"is_enabled\":\"1\"}}', 'A Crédito', NULL, NULL, NULL, NULL, '2020-03-05 22:38:31', '2020-05-07 14:36:49', '1'),
(3, 3, 'BL0001', 'FJServices', 'moca', 'República Dominicana', 'spaillat', 'moca', '56000', 4, 5, NULL, 1, 'browser', NULL, '', '', '', '', 1, '{\"cash\":{\"is_enabled\":1,\"account\":null},\"card\":{\"is_enabled\":1,\"account\":null},\"cheque\":{\"is_enabled\":1,\"account\":null},\"bank_transfer\":{\"is_enabled\":1,\"account\":null},\"other\":{\"is_enabled\":1,\"account\":null},\"custom_pay_1\":{\"is_enabled\":1,\"account\":null},\"custom_pay_2\":{\"is_enabled\":1,\"account\":null},\"custom_pay_3\":{\"is_enabled\":1,\"account\":null}}', NULL, NULL, NULL, NULL, NULL, '2020-03-09 23:54:04', '2020-03-09 23:54:04', NULL),
(4, 4, 'BL0001', 'ASP Security', 'Moca', 'República Dominicana', 'Espaillat', 'Moca', '56000', 5, 6, NULL, 1, 'browser', NULL, '', '', '', '', 1, '{\"cash\":{\"is_enabled\":1,\"account\":null},\"card\":{\"is_enabled\":1,\"account\":null},\"cheque\":{\"is_enabled\":1,\"account\":null},\"bank_transfer\":{\"is_enabled\":1,\"account\":null},\"other\":{\"is_enabled\":1,\"account\":null},\"custom_pay_1\":{\"is_enabled\":1,\"account\":null},\"custom_pay_2\":{\"is_enabled\":1,\"account\":null},\"custom_pay_3\":{\"is_enabled\":1,\"account\":null}}', '1', NULL, NULL, NULL, NULL, '2020-05-11 22:02:07', '2020-05-11 22:02:07', '1'),
(5, 5, 'BL0001', 'ASW EXPRESS', 'Calle 16 de Agosto no. 51, Moca, Provincia Espaillat', 'Rep. Dom.', 'Espaillat', 'mOCA', '56000', 6, 7, NULL, 1, 'browser', NULL, '809-278-4015', '809-290-9104', '', 'WWW.ASW.DO', 1, '{\"cash\":{\"is_enabled\":1,\"account\":null},\"card\":{\"is_enabled\":1,\"account\":null},\"cheque\":{\"is_enabled\":1,\"account\":null},\"bank_transfer\":{\"is_enabled\":1,\"account\":null},\"other\":{\"is_enabled\":1,\"account\":null},\"custom_pay_1\":{\"is_enabled\":1,\"account\":null},\"custom_pay_2\":{\"is_enabled\":1,\"account\":null},\"custom_pay_3\":{\"is_enabled\":1,\"account\":null}}', '1', NULL, NULL, NULL, NULL, '2020-05-11 23:35:51', '2020-05-11 23:35:51', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cash_registers`
--

CREATE TABLE `cash_registers` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('close','open') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `closed_at` datetime DEFAULT NULL,
  `closing_amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `total_card_slips` int(11) NOT NULL DEFAULT 0,
  `total_cheques` int(11) NOT NULL DEFAULT 0,
  `closing_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cash_registers`
--

INSERT INTO `cash_registers` (`id`, `business_id`, `location_id`, `user_id`, `status`, `closed_at`, `closing_amount`, `total_card_slips`, `total_cheques`, `closing_note`, `created_at`, `updated_at`) VALUES
(1, 2, 2, 4, 'open', NULL, '0.0000', 0, 0, NULL, '2020-03-05 16:49:40', '2020-03-05 16:49:40'),
(2, 2, 2, 5, 'open', NULL, '0.0000', 0, 0, NULL, '2020-03-05 19:03:23', '2020-03-05 19:03:23'),
(3, 1, 1, 8, 'close', '2020-03-06 09:22:47', '500.0000', 0, 0, NULL, '2020-03-06 13:21:05', '2020-03-06 13:22:47'),
(4, 1, 1, 8, 'open', NULL, '0.0000', 0, 0, NULL, '2020-03-06 13:26:01', '2020-03-06 13:26:01'),
(5, 1, 1, 1, 'close', '2020-05-29 09:14:39', '500.0000', 0, 0, NULL, '2020-03-06 14:48:35', '2020-05-29 13:14:39'),
(6, 2, 2, 3, 'close', '2020-03-06 11:40:52', '555.0000', 0, 0, NULL, '2020-03-06 15:31:46', '2020-03-06 15:40:52'),
(7, 3, 3, 14, 'open', NULL, '0.0000', 0, 0, NULL, '2020-03-09 14:42:42', '2020-03-09 14:42:42'),
(8, 2, 2, 3, 'open', NULL, '0.0000', 0, 0, NULL, '2020-03-18 20:15:05', '2020-03-18 20:15:05'),
(9, 5, 5, 16, 'open', NULL, '0.0000', 0, 0, NULL, '2020-05-12 11:29:00', '2020-05-12 11:29:00'),
(10, 5, 5, 17, 'open', NULL, '0.0000', 0, 0, NULL, '2020-05-14 13:29:45', '2020-05-14 13:29:45'),
(11, 1, 1, 1, 'close', '2020-05-29 09:47:26', '5000.0000', 0, 0, NULL, '2020-05-29 13:20:01', '2020-05-29 13:47:26'),
(12, 1, 1, 1, 'close', '2020-05-29 09:51:22', '5000.0000', 0, 0, NULL, '2020-05-29 13:50:14', '2020-05-29 13:51:22'),
(13, 1, 1, 1, 'close', '2020-05-29 09:52:53', '5500.0000', 0, 0, NULL, '2020-05-29 13:52:46', '2020-05-29 13:52:53'),
(14, 1, 1, 1, 'close', '2020-05-29 09:53:51', '2000.0000', 0, 0, NULL, '2020-05-29 13:53:43', '2020-05-29 13:53:51'),
(15, 1, 1, 1, 'close', '2020-05-29 10:08:48', '2212.5000', 0, 0, NULL, '2020-05-29 14:07:51', '2020-05-29 14:08:48'),
(16, 1, 1, 1, 'close', '2020-05-29 10:16:25', '200.0000', 0, 0, NULL, '2020-05-29 14:16:19', '2020-05-29 14:16:25'),
(17, 1, 1, 1, 'close', '2020-05-29 10:58:48', '4700.0000', 0, 0, NULL, '2020-05-29 14:58:19', '2020-05-29 14:58:48'),
(18, 1, 1, 1, 'close', '2020-06-03 15:21:54', '1950.0000', 0, 0, NULL, '2020-05-29 19:17:58', '2020-06-03 19:21:54'),
(19, 1, 1, 1, 'close', '2020-06-08 09:31:22', '350.0000', 0, 0, NULL, '2020-06-08 13:25:35', '2020-06-08 13:31:22'),
(20, 1, 1, 1, 'close', '2020-06-12 14:27:26', '4700.0000', 0, 0, NULL, '2020-06-12 17:07:39', '2020-06-12 18:27:26'),
(21, 1, 1, 1, 'close', '2020-06-12 16:19:50', '200.0000', 0, 0, NULL, '2020-06-12 18:27:43', '2020-06-12 20:19:50'),
(22, 1, 1, 1, 'close', '2020-06-12 20:49:28', '50.0000', 0, 0, NULL, '2020-06-12 20:20:10', '2020-06-13 00:49:28'),
(23, 1, 1, 1, 'close', '2020-06-15 15:55:27', '1062.5000', 0, 0, NULL, '2020-06-15 13:16:41', '2020-06-15 19:55:27'),
(24, 1, 1, 1, 'open', NULL, '0.0000', 0, 0, NULL, '2020-06-15 19:55:53', '2020-06-15 19:55:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cash_register_transactions`
--

CREATE TABLE `cash_register_transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `cash_register_id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `pay_method` enum('cash','card','cheque','bank_transfer','custom_pay_1','custom_pay_2','custom_pay_3','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('debit','credit') COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_type` enum('initial','sell','transfer','refund') COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cash_register_transactions`
--

INSERT INTO `cash_register_transactions` (`id`, `cash_register_id`, `amount`, `pay_method`, `type`, `transaction_type`, `transaction_id`, `created_at`, `updated_at`) VALUES
(1, 1, '0.0000', 'cash', 'credit', 'initial', NULL, '2020-03-05 16:49:40', '2020-03-05 16:49:40'),
(2, 2, '0.0000', 'cash', 'credit', 'initial', NULL, '2020-03-05 19:03:23', '2020-03-05 19:03:23'),
(3, 3, '500.0000', 'cash', 'credit', 'initial', NULL, '2020-03-06 13:21:05', '2020-03-06 13:21:05'),
(4, 3, '0.0000', 'cash', 'credit', 'sell', 10, '2020-03-06 13:22:02', '2020-03-06 13:22:02'),
(5, 3, '0.0000', 'cash', 'credit', 'sell', 10, '2020-03-06 13:22:02', '2020-03-06 13:22:02'),
(6, 4, '500.0000', 'cash', 'credit', 'initial', NULL, '2020-03-06 13:26:01', '2020-03-06 13:26:01'),
(9, 4, '62.5000', 'cash', 'credit', 'sell', 14, '2020-03-06 14:04:39', '2020-03-06 14:04:39'),
(10, 4, '0.0000', 'cash', 'credit', 'sell', 14, '2020-03-06 14:04:39', '2020-03-06 14:04:39'),
(11, 5, '500.0000', 'cash', 'credit', 'initial', NULL, '2020-03-06 14:48:35', '2020-03-06 14:48:35'),
(12, 6, '500.0000', 'cash', 'credit', 'initial', NULL, '2020-03-06 15:31:46', '2020-03-06 15:31:46'),
(19, 7, '0.0000', 'cash', 'credit', 'initial', NULL, '2020-03-09 14:42:42', '2020-03-09 14:42:42'),
(20, 8, '50000.0000', 'cash', 'credit', 'initial', NULL, '2020-03-18 20:15:05', '2020-03-18 20:15:05'),
(21, 8, '175.0000', 'cash', 'credit', 'sell', 31, '2020-03-18 20:19:08', '2020-03-18 20:19:08'),
(22, 8, '0.0000', 'cash', 'credit', 'sell', 31, '2020-03-18 20:19:08', '2020-03-18 20:19:08'),
(23, 8, '175.0000', 'cash', 'credit', 'sell', 32, '2020-03-18 20:22:52', '2020-03-18 20:22:52'),
(24, 8, '0.0000', 'cash', 'credit', 'sell', 32, '2020-03-18 20:22:52', '2020-03-18 20:22:52'),
(25, 8, '175.0000', 'cash', 'credit', 'sell', 33, '2020-03-18 20:23:30', '2020-03-18 20:23:30'),
(26, 8, '0.0000', 'cash', 'credit', 'sell', 33, '2020-03-18 20:23:30', '2020-03-18 20:23:30'),
(27, 8, '175.0000', 'cash', 'credit', 'sell', 34, '2020-03-18 20:24:15', '2020-03-18 20:24:15'),
(28, 8, '0.0000', 'cash', 'credit', 'sell', 34, '2020-03-18 20:24:15', '2020-03-18 20:24:15'),
(29, 8, '175.0000', 'cash', 'credit', 'sell', 35, '2020-03-18 20:24:36', '2020-03-18 20:24:36'),
(30, 8, '0.0000', 'cash', 'credit', 'sell', 35, '2020-03-18 20:24:36', '2020-03-18 20:24:36'),
(31, 8, '175.0000', 'cash', 'credit', 'sell', 36, '2020-03-18 20:24:48', '2020-03-18 20:24:48'),
(32, 8, '0.0000', 'cash', 'credit', 'sell', 36, '2020-03-18 20:24:48', '2020-03-18 20:24:48'),
(35, 7, '3200.0000', 'cash', 'credit', 'sell', 41, '2020-03-31 20:20:35', '2020-03-31 20:20:35'),
(36, 7, '0.0000', 'cash', 'credit', 'sell', 41, '2020-03-31 20:20:35', '2020-03-31 20:20:35'),
(37, 9, '0.0000', 'cash', 'credit', 'initial', NULL, '2020-05-12 11:29:00', '2020-05-12 11:29:00'),
(38, 10, '10.0000', 'cash', 'credit', 'initial', NULL, '2020-05-14 13:29:45', '2020-05-14 13:29:45'),
(39, 11, '5000.0000', 'cash', 'credit', 'initial', NULL, '2020-05-29 13:20:01', '2020-05-29 13:20:01'),
(40, 12, '5000.0000', 'cash', 'credit', 'initial', NULL, '2020-05-29 13:50:14', '2020-05-29 13:50:14'),
(41, 13, '5500.0000', 'cash', 'credit', 'initial', NULL, '2020-05-29 13:52:46', '2020-05-29 13:52:46'),
(42, 14, '2000.0000', 'cash', 'credit', 'initial', NULL, '2020-05-29 13:53:43', '2020-05-29 13:53:43'),
(43, 15, '2150.0000', 'cash', 'credit', 'initial', NULL, '2020-05-29 14:07:51', '2020-05-29 14:07:51'),
(44, 15, '62.5000', 'cash', 'credit', 'sell', 73, '2020-05-29 14:08:00', '2020-05-29 14:08:00'),
(45, 15, '0.0000', 'cash', 'credit', 'sell', 73, '2020-05-29 14:08:00', '2020-05-29 14:08:00'),
(46, 16, '200.0000', 'cash', 'credit', 'initial', NULL, '2020-05-29 14:16:19', '2020-05-29 14:16:19'),
(47, 17, '2700.0000', 'cash', 'credit', 'initial', NULL, '2020-05-29 14:58:19', '2020-05-29 14:58:19'),
(48, 17, '2000.0000', 'cash', 'credit', 'sell', 74, '2020-05-29 14:58:33', '2020-05-29 14:58:33'),
(49, 17, '0.0000', 'cash', 'credit', 'sell', 74, '2020-05-29 14:58:33', '2020-05-29 14:58:33'),
(50, 18, '200.0000', 'cash', 'credit', 'initial', NULL, '2020-05-29 19:17:58', '2020-05-29 19:17:58'),
(51, 8, '35.0000', 'cash', 'credit', 'sell', 75, '2020-06-02 15:16:48', '2020-06-02 15:16:48'),
(52, 8, '0.0000', 'cash', 'credit', 'sell', 75, '2020-06-02 15:16:48', '2020-06-02 15:16:48'),
(53, 18, '125.0000', 'cash', 'credit', 'sell', 76, '2020-06-02 20:56:39', '2020-06-02 20:56:39'),
(54, 18, '0.0000', 'cash', 'credit', 'sell', 76, '2020-06-02 20:56:39', '2020-06-02 20:56:39'),
(55, 18, '125.0000', 'cash', 'credit', 'sell', 77, '2020-06-02 20:57:05', '2020-06-02 20:57:05'),
(56, 18, '0.0000', 'cash', 'credit', 'sell', 77, '2020-06-02 20:57:05', '2020-06-02 20:57:05'),
(57, 18, '1500.0000', 'cash', 'credit', 'sell', 81, '2020-06-03 19:20:40', '2020-06-03 19:20:40'),
(58, 19, '200.0000', 'cash', 'credit', 'initial', NULL, '2020-06-08 13:25:35', '2020-06-08 13:25:35'),
(59, 19, '150.0000', 'cash', 'credit', 'sell', 82, '2020-06-08 13:29:20', '2020-06-08 13:29:20'),
(60, 19, '0.0000', 'cash', 'credit', 'sell', 83, '2020-06-08 13:30:28', '2020-06-08 13:30:28'),
(61, 19, '0.0000', 'cash', 'credit', 'sell', 83, '2020-06-08 13:30:28', '2020-06-08 13:30:28'),
(62, 20, '200.0000', 'cash', 'credit', 'sell', NULL, '2020-06-12 17:07:39', '2020-06-12 17:07:39'),
(63, 20, '2500.0000', 'cash', 'credit', 'sell', 93, '2020-06-12 17:14:05', '2020-06-12 17:14:05'),
(64, 20, '0.0000', 'cash', 'credit', 'sell', 93, '2020-06-12 17:14:05', '2020-06-12 17:14:05'),
(65, 20, '2000.0000', 'cash', 'credit', 'sell', 97, '2020-06-12 18:24:21', '2020-06-12 18:24:21'),
(66, 20, '0.0000', 'cash', 'credit', 'sell', 97, '2020-06-12 18:24:21', '2020-06-12 18:24:21'),
(67, 21, '100.0000', 'cash', 'credit', 'initial', NULL, '2020-06-12 18:27:43', '2020-06-12 18:27:43'),
(68, 21, '100.0000', 'cash', 'credit', 'sell', 102, '2020-06-12 19:08:20', '2020-06-12 19:08:20'),
(69, 21, '0.0000', 'cash', 'credit', 'sell', 102, '2020-06-12 19:08:20', '2020-06-12 19:08:20'),
(70, 22, '50.0000', 'cash', 'credit', 'initial', NULL, '2020-06-12 20:20:10', '2020-06-12 20:20:10'),
(71, 23, '100.0000', 'cash', 'credit', 'initial', NULL, '2020-06-15 13:16:41', '2020-06-15 13:16:41'),
(72, 23, '400.0000', 'cash', 'credit', 'sell', 108, '2020-06-15 18:43:42', '2020-06-15 18:43:42'),
(73, 23, '0.0000', 'cash', 'credit', 'sell', 108, '2020-06-15 18:43:42', '2020-06-15 18:43:42'),
(74, 23, '281.2500', 'cash', 'credit', 'sell', 111, '2020-06-15 19:24:20', '2020-06-15 19:24:20'),
(75, 23, '0.0000', 'cash', 'credit', 'sell', 111, '2020-06-15 19:24:20', '2020-06-15 19:24:20'),
(76, 23, '281.2500', 'cash', 'credit', 'sell', 112, '2020-06-15 19:30:56', '2020-06-15 19:30:56'),
(77, 23, '0.0000', 'cash', 'credit', 'sell', 112, '2020-06-15 19:30:56', '2020-06-15 19:30:56'),
(78, 24, '200.0000', 'cash', 'credit', 'initial', NULL, '2020-06-15 19:55:54', '2020-06-15 19:55:54'),
(79, 24, '100.0000', 'cash', 'credit', 'sell', 114, '2020-06-15 19:56:06', '2020-06-15 19:56:06'),
(80, 24, '0.0000', 'cash', 'credit', 'sell', 114, '2020-06-15 19:56:06', '2020-06-15 19:56:06'),
(81, 24, '100.0000', 'cash', 'credit', 'sell', 115, '2020-06-15 19:56:16', '2020-06-15 19:56:16'),
(82, 24, '0.0000', 'cash', 'credit', 'sell', 115, '2020-06-15 19:56:16', '2020-06-15 19:56:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `short_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `name`, `business_id`, `short_code`, `parent_id`, `created_by`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Electrodoméstico', 1, '001', 0, 1, NULL, '2020-03-04 19:37:18', '2020-03-04 19:37:18'),
(2, 'Empanadas', 2, '001', 0, 3, NULL, '2020-03-05 13:23:40', '2020-03-05 16:34:41'),
(3, 'Pollo/Crema', 2, NULL, 2, 5, NULL, '2020-03-05 16:35:16', '2020-03-05 16:35:16'),
(4, 'Pollo/Puerro', 2, NULL, 2, 5, NULL, '2020-03-05 16:35:31', '2020-03-05 16:35:31'),
(5, 'Pollo/Maíz', 2, NULL, 2, 5, NULL, '2020-03-05 16:35:45', '2020-03-05 16:35:45'),
(6, 'Pizza', 2, NULL, 2, 5, NULL, '2020-03-05 16:35:54', '2020-03-05 16:35:54'),
(7, 'Queso', 2, NULL, 2, 5, NULL, '2020-03-05 16:36:05', '2020-03-05 16:36:05'),
(8, 'Sin/Relleno', 2, NULL, 2, 5, NULL, '2020-03-05 16:36:29', '2020-03-05 16:36:29'),
(9, 'Productos', 3, 'Prod', 0, 14, NULL, '2020-04-09 13:11:39', '2020-04-09 13:11:39'),
(10, 'Servicios', 3, 'Serv', 0, 14, NULL, '2020-04-09 13:11:51', '2020-04-09 13:11:51'),
(11, 'Lácteo', 1, '0001', 0, 1, NULL, '2020-06-03 19:03:10', '2020-06-03 19:03:31'),
(12, 'categori', 1, '002', 0, 1, '2020-06-08 13:45:51', '2020-06-08 13:45:23', '2020-06-08 13:45:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contacts`
--

CREATE TABLE `contacts` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `type` enum('supplier','customer','both') COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_business_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `landmark` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `landline` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternate_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pay_term_number` int(11) DEFAULT NULL,
  `pay_term_type` enum('days','months') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit_limit` decimal(22,4) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `total_rp` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `total_rp_used` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `total_rp_expired` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `customer_group_id` int(11) DEFAULT NULL,
  `custom_field1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `idncf` int(11) DEFAULT 0,
  `status` int(11) DEFAULT 1,
  `tiene_credito` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contacts`
--

INSERT INTO `contacts` (`id`, `business_id`, `type`, `supplier_business_name`, `name`, `email`, `contact_id`, `tax_number`, `city`, `state`, `country`, `landmark`, `mobile`, `landline`, `alternate_number`, `pay_term_number`, `pay_term_type`, `credit_limit`, `created_by`, `total_rp`, `total_rp_used`, `total_rp_expired`, `is_default`, `customer_group_id`, `custom_field1`, `custom_field2`, `custom_field3`, `custom_field4`, `deleted_at`, `created_at`, `updated_at`, `idncf`, `status`, `tiene_credito`) VALUES
(1, 1, 'customer', NULL, 'Walk-In Customer', NULL, 'CO0001', NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-05 05:06:01', '2020-03-05 05:06:01', 1, 1, 0),
(2, 1, 'customer', NULL, 'ejemplo asa', NULL, '001', '001', NULL, NULL, NULL, NULL, '432432432', NULL, NULL, 2, 'months', NULL, 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-04 20:44:24', '2020-04-30 19:17:02', 0, 1, 0),
(3, 2, 'customer', NULL, 'Al Contado', NULL, 'CO0001', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, 3, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-05 22:38:31', '2020-03-05 16:51:04', 1, 1, 0),
(4, 2, 'supplier', 'Fabrica', 'Fabrica', NULL, 'CO0002', NULL, NULL, NULL, NULL, NULL, '000', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-05 16:48:13', '2020-03-05 16:48:13', 0, 1, 0),
(5, 1, 'supplier', 'intel', 'intel', NULL, 'CO0003', NULL, NULL, NULL, NULL, NULL, '4324234234', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-06 13:24:28', '2020-03-06 13:24:28', 0, 1, 0),
(6, 2, 'customer', NULL, 'Jaine Villar', NULL, 'CO0003', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, 4, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, '2020-03-06 13:59:17', '2020-04-26 23:15:58', 0, 1, 0),
(7, 2, 'customer', NULL, 'prueba', NULL, 'CO0004', NULL, NULL, NULL, NULL, NULL, '432432432', NULL, NULL, NULL, NULL, NULL, 3, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-06 15:38:40', '2020-05-09 12:09:55', 0, 0, 0),
(8, 3, 'customer', NULL, 'Contado', NULL, 'CO0001', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, 14, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-09 23:54:04', '2020-03-09 15:04:34', 0, 1, 0),
(9, 3, 'customer', NULL, 'José Comprés Conemco', NULL, 'CO0002', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, 15, 'days', '50000.0000', 14, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-09 14:34:26', '2020-04-01 21:44:38', 1, 1, 0),
(10, 1, 'customer', NULL, 'ejemplo1', NULL, 'CO0004', NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-11 21:45:11', '2020-03-27 18:44:06', 1, 1, 0),
(11, 2, 'customer', NULL, 'Joan De los santos', NULL, 'CO0005', NULL, 'Moca', NULL, NULL, NULL, '0000000', NULL, NULL, 15, 'days', NULL, 5, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, '2020-04-26 23:21:04', '2020-04-26 23:21:04', 0, 1, 0),
(12, 2, 'customer', NULL, 'Centro Especialidades médicas', NULL, 'CO0006', NULL, NULL, NULL, NULL, NULL, '000000', NULL, NULL, 30, 'days', NULL, 5, 0, 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, '2020-04-27 01:33:28', '2020-04-27 01:33:28', 0, 1, 0),
(13, 2, 'customer', NULL, 'Cafetería Centro Medico Guadalupe', NULL, 'CO0007', NULL, NULL, NULL, NULL, NULL, '(000', NULL, NULL, 1, 'months', NULL, 5, 0, 0, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, '2020-05-07 11:17:52', '2020-05-07 14:53:15', 0, 1, 1),
(14, 2, 'customer', NULL, 'usa credito', NULL, 'CO0008', NULL, NULL, NULL, NULL, NULL, ' ', NULL, NULL, 1, 'months', '5000.0000', 3, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, '2020-05-09 12:10:06', '2020-05-07 14:35:21', '2020-05-09 12:10:06', 0, 1, 1),
(15, 4, 'customer', NULL, 'Walk-In Customer', NULL, 'CO0001', NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 15, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-11 22:02:06', '2020-05-11 22:02:06', 0, 1, 0),
(16, 5, 'customer', NULL, 'Cliente de Contado', NULL, 'CO0001', NULL, NULL, NULL, NULL, NULL, '(809) 000-0000', NULL, NULL, NULL, NULL, NULL, 16, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-11 23:35:51', '2020-05-12 10:00:59', 0, 1, 0),
(17, 4, 'customer', NULL, 'Francisco Jorge', NULL, '1', NULL, 'Moca', 'Espaillat', 'República Dominicana', NULL, '(809) 710-0963', NULL, NULL, NULL, NULL, NULL, 15, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-12 11:06:07', '2020-05-12 11:06:39', 0, 1, 0),
(18, 1, 'supplier', 'ninguna', 'ejemplo', NULL, 'CO0005', NULL, NULL, NULL, NULL, NULL, ' ', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-25 19:17:38', '2020-05-25 19:17:38', 0, 1, 0),
(19, 1, 'customer', NULL, 'sad', NULL, 'CO0006', NULL, NULL, NULL, NULL, NULL, ' ', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-29 19:22:37', '2020-05-29 19:22:37', 0, 1, 0),
(20, 1, 'supplier', 'ipple', 'proveedor mac book', 'ipple@gmail.com', 'CO0007', NULL, 'Moca', 'Espaillat', 'República Dominicana', 'Moca', '(089) 309-2093', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, '2020-06-03 18:59:27', '2020-06-03 18:58:21', '2020-06-03 18:59:27', 0, 1, 0),
(21, 1, 'supplier', 'asd', 'sd', NULL, 'CO0009', NULL, NULL, NULL, NULL, NULL, ' ', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-03 19:31:49', '2020-06-03 19:31:49', 0, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `currencies`
--

CREATE TABLE `currencies` (
  `id` int(10) UNSIGNED NOT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `thousand_separator` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `decimal_separator` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `currencies`
--

INSERT INTO `currencies` (`id`, `country`, `currency`, `code`, `symbol`, `thousand_separator`, `decimal_separator`, `created_at`, `updated_at`) VALUES
(1, 'Albania', 'Leke', 'ALL', 'Lek', ',', '.', NULL, NULL),
(2, 'America', 'Dollars', 'USD', '$', ',', '.', NULL, NULL),
(3, 'Afghanistan', 'Afghanis', 'AF', '؋', ',', '.', NULL, NULL),
(4, 'Argentina', 'Pesos', 'ARS', '$', ',', '.', NULL, NULL),
(5, 'Aruba', 'Guilders', 'AWG', 'ƒ', ',', '.', NULL, NULL),
(6, 'Australia', 'Dollars', 'AUD', '$', ',', '.', NULL, NULL),
(7, 'Azerbaijan', 'New Manats', 'AZ', 'ман', ',', '.', NULL, NULL),
(8, 'Bahamas', 'Dollars', 'BSD', '$', ',', '.', NULL, NULL),
(9, 'Barbados', 'Dollars', 'BBD', '$', ',', '.', NULL, NULL),
(10, 'Belarus', 'Rubles', 'BYR', 'p.', ',', '.', NULL, NULL),
(11, 'Belgium', 'Euro', 'EUR', '€', ',', '.', NULL, NULL),
(12, 'Beliz', 'Dollars', 'BZD', 'BZ$', ',', '.', NULL, NULL),
(13, 'Bermuda', 'Dollars', 'BMD', '$', ',', '.', NULL, NULL),
(14, 'Bolivia', 'Bolivianos', 'BOB', '$b', ',', '.', NULL, NULL),
(15, 'Bosnia and Herzegovina', 'Convertible Marka', 'BAM', 'KM', ',', '.', NULL, NULL),
(16, 'Botswana', 'Pula\'s', 'BWP', 'P', ',', '.', NULL, NULL),
(17, 'Bulgaria', 'Leva', 'BG', 'лв', ',', '.', NULL, NULL),
(18, 'Brazil', 'Reais', 'BRL', 'R$', ',', '.', NULL, NULL),
(19, 'Britain [United Kingdom]', 'Pounds', 'GBP', '£', ',', '.', NULL, NULL),
(20, 'Brunei Darussalam', 'Dollars', 'BND', '$', ',', '.', NULL, NULL),
(21, 'Cambodia', 'Riels', 'KHR', '៛', ',', '.', NULL, NULL),
(22, 'Canada', 'Dollars', 'CAD', '$', ',', '.', NULL, NULL),
(23, 'Cayman Islands', 'Dollars', 'KYD', '$', ',', '.', NULL, NULL),
(24, 'Chile', 'Pesos', 'CLP', '$', ',', '.', NULL, NULL),
(25, 'China', 'Yuan Renminbi', 'CNY', '¥', ',', '.', NULL, NULL),
(26, 'Colombia', 'Pesos', 'COP', '$', ',', '.', NULL, NULL),
(27, 'Costa Rica', 'Colón', 'CRC', '₡', ',', '.', NULL, NULL),
(28, 'Croatia', 'Kuna', 'HRK', 'kn', ',', '.', NULL, NULL),
(29, 'Cuba', 'Pesos', 'CUP', '₱', ',', '.', NULL, NULL),
(30, 'Cyprus', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(31, 'Czech Republic', 'Koruny', 'CZK', 'Kč', ',', '.', NULL, NULL),
(32, 'Denmark', 'Kroner', 'DKK', 'kr', ',', '.', NULL, NULL),
(33, 'Dominican Republic', 'Pesos', 'DOP ', 'RD$', ',', '.', NULL, NULL),
(34, 'East Caribbean', 'Dollars', 'XCD', '$', ',', '.', NULL, NULL),
(35, 'Egypt', 'Pounds', 'EGP', '£', ',', '.', NULL, NULL),
(36, 'El Salvador', 'Colones', 'SVC', '$', ',', '.', NULL, NULL),
(37, 'England [United Kingdom]', 'Pounds', 'GBP', '£', ',', '.', NULL, NULL),
(38, 'Euro', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(39, 'Falkland Islands', 'Pounds', 'FKP', '£', ',', '.', NULL, NULL),
(40, 'Fiji', 'Dollars', 'FJD', '$', ',', '.', NULL, NULL),
(41, 'France', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(42, 'Ghana', 'Cedis', 'GHC', '¢', ',', '.', NULL, NULL),
(43, 'Gibraltar', 'Pounds', 'GIP', '£', ',', '.', NULL, NULL),
(44, 'Greece', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(45, 'Guatemala', 'Quetzales', 'GTQ', 'Q', ',', '.', NULL, NULL),
(46, 'Guernsey', 'Pounds', 'GGP', '£', ',', '.', NULL, NULL),
(47, 'Guyana', 'Dollars', 'GYD', '$', ',', '.', NULL, NULL),
(48, 'Holland [Netherlands]', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(49, 'Honduras', 'Lempiras', 'HNL', 'L', ',', '.', NULL, NULL),
(50, 'Hong Kong', 'Dollars', 'HKD', '$', ',', '.', NULL, NULL),
(51, 'Hungary', 'Forint', 'HUF', 'Ft', ',', '.', NULL, NULL),
(52, 'Iceland', 'Kronur', 'ISK', 'kr', ',', '.', NULL, NULL),
(53, 'India', 'Rupees', 'INR', '₹', ',', '.', NULL, NULL),
(54, 'Indonesia', 'Rupiahs', 'IDR', 'Rp', ',', '.', NULL, NULL),
(55, 'Iran', 'Rials', 'IRR', '﷼', ',', '.', NULL, NULL),
(56, 'Ireland', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(57, 'Isle of Man', 'Pounds', 'IMP', '£', ',', '.', NULL, NULL),
(58, 'Israel', 'New Shekels', 'ILS', '₪', ',', '.', NULL, NULL),
(59, 'Italy', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(60, 'Jamaica', 'Dollars', 'JMD', 'J$', ',', '.', NULL, NULL),
(61, 'Japan', 'Yen', 'JPY', '¥', ',', '.', NULL, NULL),
(62, 'Jersey', 'Pounds', 'JEP', '£', ',', '.', NULL, NULL),
(63, 'Kazakhstan', 'Tenge', 'KZT', 'лв', ',', '.', NULL, NULL),
(64, 'Korea [North]', 'Won', 'KPW', '₩', ',', '.', NULL, NULL),
(65, 'Korea [South]', 'Won', 'KRW', '₩', ',', '.', NULL, NULL),
(66, 'Kyrgyzstan', 'Soms', 'KGS', 'лв', ',', '.', NULL, NULL),
(67, 'Laos', 'Kips', 'LAK', '₭', ',', '.', NULL, NULL),
(68, 'Latvia', 'Lati', 'LVL', 'Ls', ',', '.', NULL, NULL),
(69, 'Lebanon', 'Pounds', 'LBP', '£', ',', '.', NULL, NULL),
(70, 'Liberia', 'Dollars', 'LRD', '$', ',', '.', NULL, NULL),
(71, 'Liechtenstein', 'Switzerland Francs', 'CHF', 'CHF', ',', '.', NULL, NULL),
(72, 'Lithuania', 'Litai', 'LTL', 'Lt', ',', '.', NULL, NULL),
(73, 'Luxembourg', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(74, 'Macedonia', 'Denars', 'MKD', 'ден', ',', '.', NULL, NULL),
(75, 'Malaysia', 'Ringgits', 'MYR', 'RM', ',', '.', NULL, NULL),
(76, 'Malta', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(77, 'Mauritius', 'Rupees', 'MUR', '₨', ',', '.', NULL, NULL),
(78, 'Mexico', 'Pesos', 'MXN', '$', ',', '.', NULL, NULL),
(79, 'Mongolia', 'Tugriks', 'MNT', '₮', ',', '.', NULL, NULL),
(80, 'Mozambique', 'Meticais', 'MZ', 'MT', ',', '.', NULL, NULL),
(81, 'Namibia', 'Dollars', 'NAD', '$', ',', '.', NULL, NULL),
(82, 'Nepal', 'Rupees', 'NPR', '₨', ',', '.', NULL, NULL),
(83, 'Netherlands Antilles', 'Guilders', 'ANG', 'ƒ', ',', '.', NULL, NULL),
(84, 'Netherlands', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(85, 'New Zealand', 'Dollars', 'NZD', '$', ',', '.', NULL, NULL),
(86, 'Nicaragua', 'Cordobas', 'NIO', 'C$', ',', '.', NULL, NULL),
(87, 'Nigeria', 'Nairas', 'NG', '₦', ',', '.', NULL, NULL),
(88, 'North Korea', 'Won', 'KPW', '₩', ',', '.', NULL, NULL),
(89, 'Norway', 'Krone', 'NOK', 'kr', ',', '.', NULL, NULL),
(90, 'Oman', 'Rials', 'OMR', '﷼', ',', '.', NULL, NULL),
(91, 'Pakistan', 'Rupees', 'PKR', '₨', ',', '.', NULL, NULL),
(92, 'Panama', 'Balboa', 'PAB', 'B/.', ',', '.', NULL, NULL),
(93, 'Paraguay', 'Guarani', 'PYG', 'Gs', ',', '.', NULL, NULL),
(94, 'Peru', 'Nuevos Soles', 'PE', 'S/.', ',', '.', NULL, NULL),
(95, 'Philippines', 'Pesos', 'PHP', 'Php', ',', '.', NULL, NULL),
(96, 'Poland', 'Zlotych', 'PL', 'zł', ',', '.', NULL, NULL),
(97, 'Qatar', 'Rials', 'QAR', '﷼', ',', '.', NULL, NULL),
(98, 'Romania', 'New Lei', 'RO', 'lei', ',', '.', NULL, NULL),
(99, 'Russia', 'Rubles', 'RUB', 'руб', ',', '.', NULL, NULL),
(100, 'Saint Helena', 'Pounds', 'SHP', '£', ',', '.', NULL, NULL),
(101, 'Saudi Arabia', 'Riyals', 'SAR', '﷼', ',', '.', NULL, NULL),
(102, 'Serbia', 'Dinars', 'RSD', 'Дин.', ',', '.', NULL, NULL),
(103, 'Seychelles', 'Rupees', 'SCR', '₨', ',', '.', NULL, NULL),
(104, 'Singapore', 'Dollars', 'SGD', '$', ',', '.', NULL, NULL),
(105, 'Slovenia', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(106, 'Solomon Islands', 'Dollars', 'SBD', '$', ',', '.', NULL, NULL),
(107, 'Somalia', 'Shillings', 'SOS', 'S', ',', '.', NULL, NULL),
(108, 'South Africa', 'Rand', 'ZAR', 'R', ',', '.', NULL, NULL),
(109, 'South Korea', 'Won', 'KRW', '₩', ',', '.', NULL, NULL),
(110, 'Spain', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(111, 'Sri Lanka', 'Rupees', 'LKR', '₨', ',', '.', NULL, NULL),
(112, 'Sweden', 'Kronor', 'SEK', 'kr', ',', '.', NULL, NULL),
(113, 'Switzerland', 'Francs', 'CHF', 'CHF', ',', '.', NULL, NULL),
(114, 'Suriname', 'Dollars', 'SRD', '$', ',', '.', NULL, NULL),
(115, 'Syria', 'Pounds', 'SYP', '£', ',', '.', NULL, NULL),
(116, 'Taiwan', 'New Dollars', 'TWD', 'NT$', ',', '.', NULL, NULL),
(117, 'Thailand', 'Baht', 'THB', '฿', ',', '.', NULL, NULL),
(118, 'Trinidad and Tobago', 'Dollars', 'TTD', 'TT$', ',', '.', NULL, NULL),
(119, 'Turkey', 'Lira', 'TRY', 'TL', ',', '.', NULL, NULL),
(120, 'Turkey', 'Liras', 'TRL', '£', ',', '.', NULL, NULL),
(121, 'Tuvalu', 'Dollars', 'TVD', '$', ',', '.', NULL, NULL),
(122, 'Ukraine', 'Hryvnia', 'UAH', '₴', ',', '.', NULL, NULL),
(123, 'United Kingdom', 'Pounds', 'GBP', '£', ',', '.', NULL, NULL),
(124, 'United States of America', 'Dollars', 'USD', '$', ',', '.', NULL, NULL),
(125, 'Uruguay', 'Pesos', 'UYU', '$U', ',', '.', NULL, NULL),
(126, 'Uzbekistan', 'Sums', 'UZS', 'лв', ',', '.', NULL, NULL),
(127, 'Vatican City', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(128, 'Venezuela', 'Bolivares Fuertes', 'VEF', 'Bs', ',', '.', NULL, NULL),
(129, 'Vietnam', 'Dong', 'VND', '₫', ',', '.', NULL, NULL),
(130, 'Yemen', 'Rials', 'YER', '﷼', ',', '.', NULL, NULL),
(131, 'Zimbabwe', 'Zimbabwe Dollars', 'ZWD', 'Z$', ',', '.', NULL, NULL),
(132, 'Iraq', 'Iraqi dinar', 'IQD', 'د.ع', ',', '.', NULL, NULL),
(133, 'Kenya', 'Kenyan shilling', 'KES', 'KSh', ',', '.', NULL, NULL),
(134, 'Bangladesh', 'Taka', 'BDT', '৳', ',', '.', NULL, NULL),
(135, 'Algerie', 'Algerian dinar', 'DZD', 'د.ج', ' ', '.', NULL, NULL),
(136, 'United Arab Emirates', 'United Arab Emirates dirham', 'AED', 'د.إ', ',', '.', NULL, NULL),
(137, 'Uganda', 'Uganda shillings', 'UGX', 'USh', ',', '.', NULL, NULL),
(138, 'Tanzania', 'Tanzanian shilling', 'TZS', 'TSh', ',', '.', NULL, NULL),
(139, 'Angola', 'Kwanza', 'AOA', 'Kz', ',', '.', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customer_groups`
--

CREATE TABLE `customer_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double(5,2) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `customer_groups`
--

INSERT INTO `customer_groups` (`id`, `business_id`, `name`, `amount`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 2, 'Carritos', 20.00, 5, '2020-04-26 23:15:25', '2020-04-26 23:15:25'),
(2, 2, 'Clinicas', 30.00, 5, '2020-04-27 01:32:14', '2020-04-27 01:32:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallencf`
--

CREATE TABLE `detallencf` (
  `iddetalle` int(11) NOT NULL,
  `secuencia` decimal(18,0) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `tipo` int(11) NOT NULL DEFAULT 1,
  `iddocumento` int(11) DEFAULT NULL,
  `IDsecuenciaNCF` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `detallencf`
--

INSERT INTO `detallencf` (`iddetalle`, `secuencia`, `status`, `tipo`, `iddocumento`, `IDsecuenciaNCF`) VALUES
(1, '1', 1, 1, 42, 5),
(2, '0', 1, 1, 43, 0),
(3, '1', 1, 1, 44, 1),
(4, '0', 1, 1, 45, 0),
(5, '0', 1, 1, 46, 0),
(6, '0', 1, 1, 47, 0),
(7, '0', 1, 1, 48, 0),
(8, '0', 1, 1, 49, 0),
(9, '0', 1, 1, 50, 0),
(10, '1', 1, 1, 51, 7),
(11, '0', 1, 1, 52, 0),
(12, '2', 1, 1, 53, 7),
(13, '0', 1, 1, 54, 0),
(14, '0', 1, 1, 55, 0),
(15, '0', 1, 1, 56, 0),
(16, '0', 1, 1, 57, 0),
(17, '0', 1, 1, 58, 0),
(18, '0', 1, 1, 59, 0),
(19, '0', 1, 1, 60, 0),
(20, '0', 1, 1, 61, 0),
(21, '3', 1, 1, 62, 7),
(22, '0', 1, 1, 63, 0),
(23, '0', 1, 1, 64, 0),
(24, '0', 1, 1, 65, 0),
(25, '0', 1, 1, 66, 0),
(26, '0', 1, 1, 67, 0),
(27, '2', 1, 1, 68, 1),
(28, '3', 1, 1, 69, 1),
(29, '4', 1, 1, 70, 1),
(30, '0', 1, 1, 71, 0),
(31, '0', 1, 1, 72, 0),
(32, '0', 1, 1, 73, 0),
(33, '0', 1, 1, 74, 0),
(34, '0', 1, 1, 75, 0),
(35, '0', 1, 1, 76, 0),
(36, '5', 1, 1, 77, 1),
(37, '0', 1, 1, 78, 0),
(38, '0', 1, 1, 79, 0),
(39, '6', 1, 1, 80, 1),
(40, '0', 1, 1, 81, 0),
(41, '0', 1, 1, 82, 0),
(42, '0', 1, 1, 83, 0),
(43, '0', 1, 1, 84, 0),
(44, '0', 1, 1, 85, 0),
(45, '0', 1, 1, 86, 0),
(46, '7', 1, 1, 87, 1),
(47, '8', 1, 1, 88, 1),
(48, '0', 1, 1, 89, 0),
(49, '0', 1, 1, 90, 0),
(50, '0', 1, 1, 91, 0),
(51, '0', 1, 1, 92, 0),
(52, '0', 1, 1, 93, 0),
(53, '0', 1, 1, 94, 0),
(54, '0', 1, 1, 95, 0),
(55, '9', 1, 1, 96, 1),
(56, '0', 1, 1, 97, 0),
(57, '0', 1, 1, 98, 0),
(58, '10', 1, 1, 99, 1),
(59, '0', 1, 1, 100, 0),
(60, '0', 1, 1, 101, 0),
(61, '0', 1, 1, 102, 0),
(62, '0', 1, 1, 103, 0),
(63, '0', 1, 1, 104, 0),
(64, '0', 1, 1, 105, 0),
(65, '0', 1, 1, 106, 0),
(66, '0', 1, 1, 107, 0),
(67, '0', 1, 1, 108, 0),
(68, '0', 1, 1, 109, 0),
(69, '0', 1, 1, 110, 0),
(70, '0', 1, 1, 111, 0),
(71, '0', 1, 1, 112, 0),
(72, '0', 1, 1, 113, 0),
(73, '0', 1, 1, 114, 0),
(74, '0', 1, 1, 115, 0),
(75, '0', 1, 1, 116, 0),
(76, '0', 1, 1, 117, 0),
(77, '0', 1, 1, 118, 0),
(78, '0', 1, 1, 119, 0),
(89, '0', 1, 1, 130, 0),
(91, '0', 1, 1, 132, 0),
(92, '0', 1, 1, 133, 0),
(93, '0', 1, 1, 134, 0),
(94, '0', 1, 1, 135, 0),
(95, '0', 1, 1, 136, 0),
(97, '0', 1, 1, 138, 0),
(98, '0', 1, 1, 139, 0),
(99, '0', 1, 1, 140, 0),
(100, '0', 1, 1, 141, 0),
(101, '0', 1, 1, 142, 0),
(102, '0', 1, 1, 143, 0),
(110, '0', 1, 1, 151, 0),
(111, '0', 1, 1, 152, 0),
(112, '0', 1, 1, 153, 0),
(113, '0', 1, 1, 154, 0),
(114, '0', 1, 1, 155, 0),
(115, '0', 1, 1, 156, 0),
(116, '0', 1, 1, 157, 0),
(117, '0', 1, 1, 158, 0),
(118, '0', 1, 1, 159, 0),
(119, '0', 1, 1, 160, 0),
(120, '0', 1, 1, 161, 0),
(121, '0', 1, 1, 162, 0),
(122, '0', 1, 1, 163, 0),
(123, '0', 1, 1, 164, 0),
(124, '0', 1, 1, 165, 0),
(125, '0', 1, 1, 166, 0),
(126, '0', 1, 1, 167, 0),
(129, '0', 1, 1, 170, 0),
(130, '0', 1, 1, 171, 0),
(131, '0', 1, 1, 172, 0),
(132, '0', 1, 1, 173, 0),
(133, '0', 1, 1, 174, 0),
(134, '0', 1, 1, 175, 0),
(135, '0', 1, 1, 176, 0),
(136, '0', 1, 1, 177, 0),
(137, '0', 1, 1, 178, 0),
(141, '0', 1, 1, 182, 0),
(142, '0', 1, 1, 183, 0),
(143, '0', 1, 1, 184, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `discounts`
--

CREATE TABLE `discounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(11) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `discount_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `applicable_in_spg` tinyint(1) DEFAULT 0,
  `applicable_in_cg` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `group_sub_taxes`
--

CREATE TABLE `group_sub_taxes` (
  `group_tax_id` int(10) UNSIGNED NOT NULL,
  `tax_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invoice_layouts`
--

CREATE TABLE `invoice_layouts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `header_text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_no_prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quotation_no_prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_heading` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_heading_line1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_heading_line2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_heading_line3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_heading_line4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_heading_line5` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_heading_not_paid` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_heading_paid` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quotation_heading` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_total_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_due_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_client_id` tinyint(1) NOT NULL DEFAULT 0,
  `client_id_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_tax_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_time_format` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_time` tinyint(1) NOT NULL DEFAULT 1,
  `show_brand` tinyint(1) NOT NULL DEFAULT 0,
  `show_sku` tinyint(1) NOT NULL DEFAULT 1,
  `show_cat_code` tinyint(1) NOT NULL DEFAULT 1,
  `show_expiry` tinyint(1) NOT NULL DEFAULT 0,
  `show_lot` tinyint(1) NOT NULL DEFAULT 0,
  `show_image` tinyint(1) NOT NULL DEFAULT 0,
  `show_sale_description` tinyint(1) NOT NULL DEFAULT 0,
  `sales_person_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_sales_person` tinyint(1) NOT NULL DEFAULT 0,
  `table_product_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `table_qty_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `table_unit_price_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `table_subtotal_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cat_code_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_logo` tinyint(1) NOT NULL DEFAULT 0,
  `show_business_name` tinyint(1) NOT NULL DEFAULT 0,
  `show_location_name` tinyint(1) NOT NULL DEFAULT 1,
  `show_landmark` tinyint(1) NOT NULL DEFAULT 1,
  `show_city` tinyint(1) NOT NULL DEFAULT 1,
  `show_state` tinyint(1) NOT NULL DEFAULT 1,
  `show_zip_code` tinyint(1) NOT NULL DEFAULT 1,
  `show_country` tinyint(1) NOT NULL DEFAULT 1,
  `show_mobile_number` tinyint(1) NOT NULL DEFAULT 1,
  `show_alternate_number` tinyint(1) NOT NULL DEFAULT 0,
  `show_email` tinyint(1) NOT NULL DEFAULT 0,
  `show_tax_1` tinyint(1) NOT NULL DEFAULT 1,
  `show_tax_2` tinyint(1) NOT NULL DEFAULT 0,
  `show_barcode` tinyint(1) NOT NULL DEFAULT 0,
  `show_payments` tinyint(1) NOT NULL DEFAULT 0,
  `show_customer` tinyint(1) NOT NULL DEFAULT 0,
  `customer_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_reward_point` tinyint(1) NOT NULL DEFAULT 0,
  `highlight_color` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer_text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module_info` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `common_settings` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `business_id` int(10) UNSIGNED NOT NULL,
  `design` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT 'classic',
  `cn_heading` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'cn = credit note',
  `cn_no_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cn_amount_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `table_tax_headings` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_previous_bal` tinyint(1) NOT NULL DEFAULT 0,
  `prev_bal_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `change_return_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_custom_fields` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_custom_fields` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_custom_fields` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `invoice_layouts`
--

INSERT INTO `invoice_layouts` (`id`, `name`, `header_text`, `invoice_no_prefix`, `quotation_no_prefix`, `invoice_heading`, `sub_heading_line1`, `sub_heading_line2`, `sub_heading_line3`, `sub_heading_line4`, `sub_heading_line5`, `invoice_heading_not_paid`, `invoice_heading_paid`, `quotation_heading`, `sub_total_label`, `discount_label`, `tax_label`, `total_label`, `total_due_label`, `paid_label`, `show_client_id`, `client_id_label`, `client_tax_label`, `date_label`, `date_time_format`, `show_time`, `show_brand`, `show_sku`, `show_cat_code`, `show_expiry`, `show_lot`, `show_image`, `show_sale_description`, `sales_person_label`, `show_sales_person`, `table_product_label`, `table_qty_label`, `table_unit_price_label`, `table_subtotal_label`, `cat_code_label`, `logo`, `show_logo`, `show_business_name`, `show_location_name`, `show_landmark`, `show_city`, `show_state`, `show_zip_code`, `show_country`, `show_mobile_number`, `show_alternate_number`, `show_email`, `show_tax_1`, `show_tax_2`, `show_barcode`, `show_payments`, `show_customer`, `customer_label`, `show_reward_point`, `highlight_color`, `footer_text`, `module_info`, `common_settings`, `is_default`, `business_id`, `design`, `cn_heading`, `cn_no_label`, `cn_amount_label`, `table_tax_headings`, `show_previous_bal`, `prev_bal_label`, `change_return_label`, `product_custom_fields`, `contact_custom_fields`, `location_custom_fields`, `created_at`, `updated_at`) VALUES
(1, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', NULL, 1, 0, 1, 1, 0, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', 0, '#000000', '', NULL, NULL, 1, 1, 'classic', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '2020-03-05 05:06:01', '2020-03-05 05:06:01'),
(2, 'Factura_termica', '<p>Dualsoft</p>', 'Invoice No.', 'Quotation No.', 'Dualsoft', NULL, NULL, NULL, NULL, NULL, 'Pendiente', 'Pagado', 'Quotation', 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', NULL, 1, 0, 1, 0, 0, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', 'HSN', NULL, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', 0, '#000000', NULL, NULL, '{\"due_date_label\":\"Due Date\"}', 0, 1, 'slim', 'Credit Note', 'Ref. No.', 'Credit Amount', NULL, 0, 'All Balance Due', 'Change Return', NULL, NULL, NULL, '2020-03-04 20:43:34', '2020-03-04 20:43:34'),
(3, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', NULL, 1, 0, 1, 1, 0, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', 0, '#000000', '', NULL, NULL, 0, 2, 'classic', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '2020-03-05 22:38:31', '2020-03-06 12:22:25'),
(4, 'Fact_Pequena', NULL, 'Fact No.', 'Cotización No.', 'Factura', NULL, NULL, NULL, NULL, NULL, 'a Crédito', 'de Contado', 'Cotización', 'Subtotal', 'Descuento', 'Itbis', 'Total', 'Total Pendiente', 'Total Pagado', 0, NULL, NULL, 'Fecha', 'd-m-y', 1, 0, 0, 0, 0, 0, 0, 1, 'Vendedor:', 1, 'Producto', 'Cant', 'P/UD', 'Monto', 'HSN', '1584705050_logo_botana.png', 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 'Cliente', 0, '#000000', '<p>&nbsp;</p>\r\n\r\n<p><strong>Recibido por:___________________________</strong></p>\r\n\r\n<p style=\"text-align:center\">&nbsp;</p>\r\n\r\n<p style=\"text-align:center\"><strong>Gracias por Preferirnos!</strong></p>\r\n\r\n<p style=\"text-align:center\">&nbsp;</p>', NULL, '{\"due_date_label\":null,\"show_due_date\":\"1\"}', 1, 2, 'slim', 'Nota de Crédito', 'Ref. No.', 'Monto', NULL, 0, 'Balance', 'Cambio', NULL, NULL, NULL, '2020-03-05 13:21:01', '2020-05-08 11:25:50'),
(5, 'Default', NULL, 'Factura No.', NULL, 'Factura', NULL, NULL, NULL, NULL, NULL, 'a Credito', 'a Contado', NULL, 'Subtotal', 'Descuento', 'Itbis', 'Total', 'Total Pendiente', 'Total Pagado', 0, NULL, NULL, 'Fecha', NULL, 1, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 'Artículo', 'Cantidad', 'Precio UD', 'Subtotal', NULL, NULL, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 'Cliente', 0, '#000000', '<p>Agradecido por su confianza!</p>', NULL, '{\"due_date_label\":\"F. Pago\"}', 1, 3, 'detailed', NULL, NULL, NULL, NULL, 0, 'Balance', NULL, NULL, NULL, NULL, '2020-03-09 23:54:04', '2020-03-11 15:19:41'),
(6, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', NULL, 1, 0, 1, 1, 0, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', 0, '#000000', '', NULL, NULL, 1, 4, 'classic', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '2020-05-11 22:02:06', '2020-05-11 22:02:06'),
(7, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', NULL, 1, 0, 1, 1, 0, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', 0, '#000000', '', NULL, NULL, 1, 5, 'classic', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '2020-05-11 23:35:51', '2020-05-11 23:35:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invoice_schemes`
--

CREATE TABLE `invoice_schemes` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scheme_type` enum('blank','year') COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_number` int(11) DEFAULT NULL,
  `invoice_count` int(11) NOT NULL DEFAULT 0,
  `total_digits` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `invoice_schemes`
--

INSERT INTO `invoice_schemes` (`id`, `business_id`, `name`, `scheme_type`, `prefix`, `start_number`, `invoice_count`, `total_digits`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 1, 'Default', 'blank', '', 1, 55, 4, 1, '2020-03-05 05:06:01', '2020-06-19 20:33:59'),
(3, 2, 'Default', 'blank', NULL, 95, 29, 5, 1, '2020-03-05 22:38:31', '2020-06-02 15:16:48'),
(4, 3, 'Default', 'blank', '', 1, 8, 4, 1, '2020-03-09 23:54:04', '2020-04-20 20:34:18'),
(5, 4, 'Default', 'blank', '', 1, 0, 4, 1, '2020-05-11 22:02:06', '2020-05-11 22:02:06'),
(6, 5, 'Default', 'blank', '', 1, 0, 4, 1, '2020-05-11 23:35:51', '2020-05-11 23:35:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `media`
--

CREATE TABLE `media` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `file_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `media`
--

INSERT INTO `media` (`id`, `business_id`, `file_name`, `description`, `uploaded_by`, `model_type`, `model_id`, `created_at`, `updated_at`) VALUES
(1, 5, '1589279633_1942548787_miami.jpg', NULL, 16, 'App\\Variation', 14, '2020-05-12 10:33:53', '2020-05-12 10:33:53'),
(2, 5, '1589279696_1701264888_china.jpg', NULL, 16, 'App\\Variation', 15, '2020-05-12 10:34:56', '2020-05-12 10:34:56'),
(3, 5, '1589279947_778169606_seguro.jpg', NULL, 16, 'App\\Variation', 16, '2020-05-12 10:39:07', '2020-05-12 10:39:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2017_07_05_071953_create_currencies_table', 1),
(4, '2017_07_05_073658_create_business_table', 1),
(5, '2017_07_22_075923_add_business_id_users_table', 1),
(6, '2017_07_23_113209_create_brands_table', 1),
(7, '2017_07_26_083429_create_permission_tables', 1),
(8, '2017_07_26_110000_create_tax_rates_table', 1),
(9, '2017_07_26_122313_create_units_table', 1),
(10, '2017_07_27_075706_create_contacts_table', 1),
(11, '2017_08_04_071038_create_categories_table', 1),
(12, '2017_08_08_115903_create_products_table', 1),
(13, '2017_08_09_061616_create_variation_templates_table', 1),
(14, '2017_08_09_061638_create_variation_value_templates_table', 1),
(15, '2017_08_10_061146_create_product_variations_table', 1),
(16, '2017_08_10_061216_create_variations_table', 1),
(17, '2017_08_19_054827_create_transactions_table', 1),
(18, '2017_08_31_073533_create_purchase_lines_table', 1),
(19, '2017_10_15_064638_create_transaction_payments_table', 1),
(20, '2017_10_31_065621_add_default_sales_tax_to_business_table', 1),
(21, '2017_11_20_051930_create_table_group_sub_taxes', 1),
(22, '2017_11_20_063603_create_transaction_sell_lines', 1),
(23, '2017_11_21_064540_create_barcodes_table', 1),
(24, '2017_11_23_181237_create_invoice_schemes_table', 1),
(25, '2017_12_25_122822_create_business_locations_table', 1),
(26, '2017_12_25_160253_add_location_id_to_transactions_table', 1),
(27, '2017_12_25_163227_create_variation_location_details_table', 1),
(28, '2018_01_04_115627_create_sessions_table', 1),
(29, '2018_01_05_112817_create_invoice_layouts_table', 1),
(30, '2018_01_06_112303_add_invoice_scheme_id_and_invoice_layout_id_to_business_locations', 1),
(31, '2018_01_08_104124_create_expense_categories_table', 1),
(32, '2018_01_08_123327_modify_transactions_table_for_expenses', 1),
(33, '2018_01_09_111005_modify_payment_status_in_transactions_table', 1),
(34, '2018_01_09_111109_add_paid_on_column_to_transaction_payments_table', 1),
(35, '2018_01_25_172439_add_printer_related_fields_to_business_locations_table', 1),
(36, '2018_01_27_184322_create_printers_table', 1),
(37, '2018_01_30_181442_create_cash_registers_table', 1),
(38, '2018_01_31_125836_create_cash_register_transactions_table', 1),
(39, '2018_02_07_173326_modify_business_table', 1),
(40, '2018_02_08_105425_add_enable_product_expiry_column_to_business_table', 1),
(41, '2018_02_08_111027_add_expiry_period_and_expiry_period_type_columns_to_products_table', 1),
(42, '2018_02_08_131118_add_mfg_date_and_exp_date_purchase_lines_table', 1),
(43, '2018_02_08_155348_add_exchange_rate_to_transactions_table', 1),
(44, '2018_02_09_124945_modify_transaction_payments_table_for_contact_payments', 1),
(45, '2018_02_12_113640_create_transaction_sell_lines_purchase_lines_table', 1),
(46, '2018_02_12_114605_add_quantity_sold_in_purchase_lines_table', 1),
(47, '2018_02_13_183323_alter_decimal_fields_size', 1),
(48, '2018_02_14_161928_add_transaction_edit_days_to_business_table', 1),
(49, '2018_02_15_161032_add_document_column_to_transactions_table', 1),
(50, '2018_02_17_124709_add_more_options_to_invoice_layouts', 1),
(51, '2018_02_19_111517_add_keyboard_shortcut_column_to_business_table', 1),
(52, '2018_02_19_121537_stock_adjustment_move_to_transaction_table', 1),
(53, '2018_02_20_165505_add_is_direct_sale_column_to_transactions_table', 1),
(54, '2018_02_21_105329_create_system_table', 1),
(55, '2018_02_23_100549_version_1_2', 1),
(56, '2018_02_23_125648_add_enable_editing_sp_from_purchase_column_to_business_table', 1),
(57, '2018_02_26_103612_add_sales_commission_agent_column_to_business_table', 1),
(58, '2018_02_26_130519_modify_users_table_for_sales_cmmsn_agnt', 1),
(59, '2018_02_26_134500_add_commission_agent_to_transactions_table', 1),
(60, '2018_02_27_121422_add_item_addition_method_to_business_table', 1),
(61, '2018_02_27_170232_modify_transactions_table_for_stock_transfer', 1),
(62, '2018_03_05_153510_add_enable_inline_tax_column_to_business_table', 1),
(63, '2018_03_06_210206_modify_product_barcode_types', 1),
(64, '2018_03_13_181541_add_expiry_type_to_business_table', 1),
(65, '2018_03_16_113446_product_expiry_setting_for_business', 1),
(66, '2018_03_19_113601_add_business_settings_options', 1),
(67, '2018_03_26_125334_add_pos_settings_to_business_table', 1),
(68, '2018_03_26_165350_create_customer_groups_table', 1),
(69, '2018_03_27_122720_customer_group_related_changes_in_tables', 1),
(70, '2018_03_29_110138_change_tax_field_to_nullable_in_business_table', 1),
(71, '2018_03_29_115502_add_changes_for_sr_number_in_products_and_sale_lines_table', 1),
(72, '2018_03_29_134340_add_inline_discount_fields_in_purchase_lines', 1),
(73, '2018_03_31_140921_update_transactions_table_exchange_rate', 1),
(74, '2018_04_03_103037_add_contact_id_to_contacts_table', 1),
(75, '2018_04_03_122709_add_changes_to_invoice_layouts_table', 1),
(76, '2018_04_09_135320_change_exchage_rate_size_in_business_table', 1),
(77, '2018_04_17_123122_add_lot_number_to_business', 1),
(78, '2018_04_17_160845_add_product_racks_table', 1),
(79, '2018_04_20_182015_create_res_tables_table', 1),
(80, '2018_04_24_105246_restaurant_fields_in_transaction_table', 1),
(81, '2018_04_24_114149_add_enabled_modules_business_table', 1),
(82, '2018_04_24_133704_add_modules_fields_in_invoice_layout_table', 1),
(83, '2018_04_27_132653_quotation_related_change', 1),
(84, '2018_05_02_104439_add_date_format_and_time_format_to_business', 1),
(85, '2018_05_02_111939_add_sell_return_to_transaction_payments', 1),
(86, '2018_05_14_114027_add_rows_positions_for_products', 1),
(87, '2018_05_14_125223_add_weight_to_products_table', 1),
(88, '2018_05_14_164754_add_opening_stock_permission', 1),
(89, '2018_05_15_134729_add_design_to_invoice_layouts', 1),
(90, '2018_05_16_183307_add_tax_fields_invoice_layout', 1),
(91, '2018_05_18_191956_add_sell_return_to_transaction_table', 1),
(92, '2018_05_21_131349_add_custom_fileds_to_contacts_table', 1),
(93, '2018_05_21_131607_invoice_layout_fields_for_sell_return', 1),
(94, '2018_05_21_131949_add_custom_fileds_and_website_to_business_locations_table', 1),
(95, '2018_05_22_123527_create_reference_counts_table', 1),
(96, '2018_05_22_154540_add_ref_no_prefixes_column_to_business_table', 1),
(97, '2018_05_24_132620_add_ref_no_column_to_transaction_payments_table', 1),
(98, '2018_05_24_161026_add_location_id_column_to_business_location_table', 1),
(99, '2018_05_25_180603_create_modifiers_related_table', 1),
(100, '2018_05_29_121714_add_purchase_line_id_to_stock_adjustment_line_table', 1),
(101, '2018_05_31_114645_add_res_order_status_column_to_transactions_table', 1),
(102, '2018_06_05_103530_rename_purchase_line_id_in_stock_adjustment_lines_table', 1),
(103, '2018_06_05_111905_modify_products_table_for_modifiers', 1),
(104, '2018_06_06_110524_add_parent_sell_line_id_column_to_transaction_sell_lines_table', 1),
(105, '2018_06_07_152443_add_is_service_staff_to_roles_table', 1),
(106, '2018_06_07_182258_add_image_field_to_products_table', 1),
(107, '2018_06_13_133705_create_bookings_table', 1),
(108, '2018_06_15_173636_add_email_column_to_contacts_table', 1),
(109, '2018_06_27_182835_add_superadmin_related_fields_business', 1),
(110, '2018_07_10_101913_add_custom_fields_to_products_table', 1),
(111, '2018_07_17_103434_add_sales_person_name_label_to_invoice_layouts_table', 1),
(112, '2018_07_17_163920_add_theme_skin_color_column_to_business_table', 1),
(113, '2018_07_24_160319_add_lot_no_line_id_to_transaction_sell_lines_table', 1),
(114, '2018_07_25_110004_add_show_expiry_and_show_lot_colums_to_invoice_layouts_table', 1),
(115, '2018_07_25_172004_add_discount_columns_to_transaction_sell_lines_table', 1),
(116, '2018_07_26_124720_change_design_column_type_in_invoice_layouts_table', 1),
(117, '2018_07_26_170424_add_unit_price_before_discount_column_to_transaction_sell_line_table', 1),
(118, '2018_07_28_103614_add_credit_limit_column_to_contacts_table', 1),
(119, '2018_08_08_110755_add_new_payment_methods_to_transaction_payments_table', 1),
(120, '2018_08_08_122225_modify_cash_register_transactions_table_for_new_payment_methods', 1),
(121, '2018_08_14_104036_add_opening_balance_type_to_transactions_table', 1),
(122, '2018_09_04_155900_create_accounts_table', 1),
(123, '2018_09_06_114438_create_selling_price_groups_table', 1),
(124, '2018_09_06_154057_create_variation_group_prices_table', 1),
(125, '2018_09_07_102413_add_permission_to_access_default_selling_price', 1),
(126, '2018_09_07_134858_add_selling_price_group_id_to_transactions_table', 1),
(127, '2018_09_10_112448_update_product_type_to_single_if_null_in_products_table', 1),
(128, '2018_09_10_152703_create_account_transactions_table', 1),
(129, '2018_09_10_173656_add_account_id_column_to_transaction_payments_table', 1),
(130, '2018_09_19_123914_create_notification_templates_table', 1),
(131, '2018_09_22_110504_add_sms_and_email_settings_columns_to_business_table', 1),
(132, '2018_09_24_134942_add_lot_no_line_id_to_stock_adjustment_lines_table', 1),
(133, '2018_09_26_105557_add_transaction_payments_for_existing_expenses', 1),
(134, '2018_09_27_111609_modify_transactions_table_for_purchase_return', 1),
(135, '2018_09_27_131154_add_quantity_returned_column_to_purchase_lines_table', 1),
(136, '2018_10_02_131401_add_return_quantity_column_to_transaction_sell_lines_table', 1),
(137, '2018_10_03_104918_add_qty_returned_column_to_transaction_sell_lines_purchase_lines_table', 1),
(138, '2018_10_03_185947_add_default_notification_templates_to_database', 1),
(139, '2018_10_09_153105_add_business_id_to_transaction_payments_table', 1),
(140, '2018_10_16_135229_create_permission_for_sells_and_purchase', 1),
(141, '2018_10_22_114441_add_columns_for_variable_product_modifications', 1),
(142, '2018_10_22_134428_modify_variable_product_data', 1),
(143, '2018_10_30_181558_add_table_tax_headings_to_invoice_layout', 1),
(144, '2018_10_31_122619_add_pay_terms_field_transactions_table', 1),
(145, '2018_10_31_161328_add_new_permissions_for_pos_screen', 1),
(146, '2018_10_31_174752_add_access_selected_contacts_only_to_users_table', 1),
(147, '2018_10_31_175627_add_user_contact_access', 1),
(148, '2018_10_31_180559_add_auto_send_sms_column_to_notification_templates_table', 1),
(149, '2018_11_02_171949_change_card_type_column_to_varchar_in_transaction_payments_table', 1),
(150, '2018_11_08_105621_add_role_permissions', 1),
(151, '2018_11_26_114135_add_is_suspend_column_to_transactions_table', 1),
(152, '2018_11_28_104410_modify_units_table_for_multi_unit', 1),
(153, '2018_11_28_170952_add_sub_unit_id_to_purchase_lines_and_sell_lines', 1),
(154, '2018_11_29_115918_add_primary_key_in_system_table', 1),
(155, '2018_12_03_185546_add_product_description_column_to_products_table', 1),
(156, '2018_12_06_114937_modify_system_table_and_users_table', 1),
(157, '2018_12_13_160007_add_custom_fields_display_options_to_invoice_layouts_table', 1),
(158, '2018_12_14_103307_modify_system_table', 1),
(159, '2018_12_18_133837_add_prev_balance_due_columns_to_invoice_layouts_table', 1),
(160, '2018_12_18_170656_add_invoice_token_column_to_transaction_table', 1),
(161, '2018_12_20_133639_add_date_time_format_column_to_invoice_layouts_table', 1),
(162, '2018_12_21_120659_add_recurring_invoice_fields_to_transactions_table', 1),
(163, '2018_12_24_154933_create_notifications_table', 1),
(164, '2019_01_08_112015_add_document_column_to_transaction_payments_table', 1),
(165, '2019_01_10_124645_add_account_permission', 1),
(166, '2019_01_16_125825_add_subscription_no_column_to_transactions_table', 1),
(167, '2019_01_28_111647_add_order_addresses_column_to_transactions_table', 1),
(168, '2019_02_13_173821_add_is_inactive_column_to_products_table', 1),
(169, '2019_02_19_103118_create_discounts_table', 1),
(170, '2019_02_21_120324_add_discount_id_column_to_transaction_sell_lines_table', 1),
(171, '2019_02_21_134324_add_permission_for_discount', 1),
(172, '2019_03_04_170832_add_service_staff_columns_to_transaction_sell_lines_table', 1),
(173, '2019_03_09_102425_add_sub_type_column_to_transactions_table', 1),
(174, '2019_03_09_124457_add_indexing_transaction_sell_lines_purchase_lines_table', 1),
(175, '2019_03_12_120336_create_activity_log_table', 1),
(176, '2019_03_15_132925_create_media_table', 1),
(177, '2019_05_08_130339_add_indexing_to_parent_id_in_transaction_payments_table', 1),
(178, '2019_05_10_132311_add_missing_column_indexing', 1),
(179, '2019_05_14_091812_add_show_image_column_to_invoice_layouts_table', 1),
(180, '2019_05_25_104922_add_view_purchase_price_permission', 1),
(181, '2019_06_17_103515_add_profile_informations_columns_to_users_table', 1),
(182, '2019_06_18_135524_add_permission_to_view_own_sales_only', 1),
(183, '2019_06_19_112058_add_database_changes_for_reward_points', 1),
(184, '2019_06_28_133732_change_type_column_to_string_in_transactions_table', 1),
(185, '2019_07_13_111420_add_is_created_from_api_column_to_transactions_table', 1),
(186, '2019_07_15_165136_add_fields_for_combo_product', 1),
(187, '2019_07_19_103446_add_mfg_quantity_used_column_to_purchase_lines_table', 1),
(188, '2019_07_22_152649_add_not_for_selling_in_product_table', 1),
(189, '2019_07_29_185351_add_show_reward_point_column_to_invoice_layouts_table', 1),
(190, '2019_08_08_162302_add_sub_units_related_fields', 1),
(191, '2019_08_26_133419_update_price_fields_decimal_point', 1),
(192, '2019_09_02_160054_remove_location_permissions_from_roles', 1),
(193, '2019_09_03_185259_add_permission_for_pos_screen', 1),
(194, '2019_09_04_163141_add_location_id_to_cash_registers_table', 1),
(195, '2019_09_04_184008_create_types_of_services_table', 1),
(196, '2019_09_06_131445_add_types_of_service_fields_to_transactions_table', 1),
(197, '2019_09_09_134810_add_default_selling_price_group_id_column_to_business_locations_table', 1),
(198, '2019_09_12_105616_create_product_locations_table', 1),
(199, '2019_09_17_122522_add_custom_labels_column_to_business_table', 1),
(200, '2019_09_18_164319_add_shipping_fields_to_transactions_table', 1),
(201, '2019_09_19_170927_close_all_active_registers', 1),
(202, '2019_09_23_161906_add_media_description_cloumn_to_media_table', 1),
(203, '2019_10_18_155633_create_account_types_table', 1),
(204, '2019_10_22_163335_add_common_settings_column_to_business_table', 1),
(205, '2019_10_29_132521_add_update_purchase_status_permission', 1),
(206, '2019_11_09_110522_add_indexing_to_lot_number', 1),
(207, '2019_11_19_170824_add_is_active_column_to_business_locations_table', 1),
(208, '2019_11_21_162913_change_quantity_field_types_to_decimal', 1),
(209, '2019_12_02_105025_create_warranties_table', 1),
(210, '2019_12_03_180342_add_common_settings_field_to_invoice_layouts_table', 1),
(211, '2019_12_06_174904_add_change_return_label_column_to_invoice_layouts_table', 1),
(212, '2019_12_11_121307_add_draft_and_quotation_list_permissions', 1),
(213, '2019_12_12_180126_copy_expense_total_to_total_before_tax', 1),
(214, '2019_12_19_181412_make_alert_quantity_field_nullable_on_products_table', 1),
(215, '2018_06_27_185405_create_packages_table', 2),
(216, '2018_06_28_182803_create_subscriptions_table', 2),
(217, '2018_07_17_182021_add_rows_to_system_table', 2),
(218, '2018_07_19_131721_add_options_to_packages_table', 2),
(219, '2018_08_17_155534_add_min_termination_alert_days', 2),
(220, '2018_08_28_105945_add_business_based_username_settings_to_system_table', 2),
(221, '2018_08_30_105906_add_superadmin_communicator_logs_table', 2),
(222, '2018_11_02_130636_add_custom_permissions_to_packages_table', 2),
(223, '2018_11_05_161848_add_more_fields_to_packages_table', 2),
(224, '2018_12_10_124621_modify_system_table_values_null_default', 2),
(225, '2019_05_10_135434_add_missing_database_column_indexes', 2),
(226, '2019_08_16_115300_create_superadmin_frontend_pages_table', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `model_has_permissions`
--

INSERT INTO `model_has_permissions` (`permission_id`, `model_type`, `model_id`) VALUES
(77, 'App\\User', 2),
(77, 'App\\User', 4),
(77, 'App\\User', 5),
(77, 'App\\User', 8),
(77, 'App\\User', 9),
(77, 'App\\User', 10),
(77, 'App\\User', 12),
(77, 'App\\User', 18),
(79, 'App\\User', 7),
(85, 'App\\User', 17);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\User', 1),
(1, 'App\\User', 2),
(1, 'App\\User', 9),
(1, 'App\\User', 10),
(1, 'App\\User', 12),
(2, 'App\\User', 8),
(2, 'App\\User', 18),
(3, 'App\\User', 3),
(3, 'App\\User', 5),
(5, 'App\\User', 4),
(6, 'App\\User', 7),
(7, 'App\\User', 14),
(9, 'App\\User', 15),
(11, 'App\\User', 16),
(13, 'App\\User', 17);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ncf`
--

CREATE TABLE `ncf` (
  `idncf` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ncf`
--

INSERT INTO `ncf` (`idncf`, `nombre`, `status`) VALUES
(1, 'Consumidor Final', 1),
(3, 'Crédito Fiscal', 1),
(5, 'Nota de débito', 1),
(6, 'Notas de crédito', 1),
(7, 'Comprobante de compras', 1),
(8, 'Registro único de ingreso', 1),
(9, 'Gastos menores', 1),
(10, 'Regímenes especiales', 1),
(11, 'Comprobante Gubernamental', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ncf_secuencia`
--

CREATE TABLE `ncf_secuencia` (
  `idncfsecuencia` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_venc` datetime NOT NULL DEFAULT current_timestamp(),
  `prefijo` varchar(50) NOT NULL,
  `idncf` int(11) NOT NULL,
  `desde` int(11) NOT NULL,
  `hasta` int(11) NOT NULL,
  `usados` int(11) NOT NULL DEFAULT 0,
  `autorizacionNo` varchar(50) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `business_id` int(11) NOT NULL,
  `updated_at` datetime DEFAULT current_timestamp(),
  `created_at` datetime DEFAULT current_timestamp(),
  `secuencia` int(11) DEFAULT 0,
  `deleted_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ncf_secuencia`
--

INSERT INTO `ncf_secuencia` (`idncfsecuencia`, `fecha`, `fecha_venc`, `prefijo`, `idncf`, `desde`, `hasta`, `usados`, `autorizacionNo`, `status`, `business_id`, `updated_at`, `created_at`, `secuencia`, `deleted_at`) VALUES
(1, '2020-04-01 13:29:48', '2021-02-02 00:00:00', 'B01', 1, 1, 10, 10, '010101', 0, 1, '2020-04-01 16:29:48', '2020-04-01 16:29:48', 10, 0),
(2, '2020-04-01 13:45:06', '2020-02-03 00:00:00', 'B01', 1, 1, 10, 0, '010101', 3, 2, '2020-04-01 16:45:06', '2020-04-01 16:45:06', 1, 0),
(3, '2020-04-01 13:49:25', '2020-04-03 00:00:00', 'B01', 1, 11, 20, 0, '010101', 3, 2, '2020-04-01 16:49:25', '2020-04-01 16:49:25', 11, 0),
(4, '2020-04-01 13:49:50', '2020-02-02 00:00:00', 'B01', 1, 11, 20, 0, '010101', 3, 1, '2020-04-01 16:49:50', '2020-04-01 16:49:50', 11, 0),
(5, '2020-04-01 14:38:41', '2020-12-31 00:00:00', 'B01', 1, 1, 100, 1, '09123', 2, 3, '2020-04-01 17:38:41', '2020-04-01 17:38:41', 2, 0),
(6, '2020-04-01 14:39:06', '2020-12-31 00:00:00', 'B01', 1, 20, 100, 0, '12', 1, 3, '2020-04-01 17:39:06', '2020-04-01 17:39:06', 20, 0),
(7, '2020-04-26 16:39:31', '2020-12-31 00:00:00', 'B0100000', 1, 1, 100, 3, 'edawsdas', 2, 2, '2020-04-26 19:39:31', '2020-04-26 19:39:31', 4, 0),
(8, '2020-06-03 15:26:11', '2021-02-02 00:00:00', 'B01', 1, 89, 230, 0, '0101001', 3, 1, '2020-06-03 15:26:25', '2020-06-03 15:26:11', 89, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notification_templates`
--

CREATE TABLE `notification_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `template_for` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sms_body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auto_send` tinyint(1) NOT NULL DEFAULT 0,
  `auto_send_sms` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notification_templates`
--

INSERT INTO `notification_templates` (`id`, `business_id`, `template_for`, `email_body`, `sms_body`, `subject`, `auto_send`, `auto_send_sms`, `created_at`, `updated_at`) VALUES
(1, 1, 'new_sale', '<p>Dear {contact_name},</p>\n\n                    <p>Your invoice number is {invoice_number}<br />\n                    Total amount: {total_amount}<br />\n                    Paid amount: {paid_amount}</p>\n\n                    <p>Thank you for shopping with us.</p>\n\n                    <p>{business_logo}</p>\n\n                    <p>&nbsp;</p>', 'Dear {contact_name}, Thank you for shopping with us. {business_name}', 'Thank you from {business_name}', 0, 0, '2020-03-05 05:06:01', '2020-03-05 05:06:01'),
(2, 1, 'payment_received', '<p>Dear {contact_name},</p>\n\n                <p>We have received a payment of {paid_amount}</p>\n\n                <p>{business_logo}</p>', 'Dear {contact_name}, We have received a payment of {paid_amount}. {business_name}', 'Payment Received, from {business_name}', 0, 0, '2020-03-05 05:06:01', '2020-03-05 05:06:01'),
(3, 1, 'payment_reminder', '<p>Dear {contact_name},</p>\n\n                    <p>This is to remind you that you have pending payment of {due_amount}. Kindly pay it as soon as possible.</p>\n\n                    <p>{business_logo}</p>', 'Dear {contact_name}, You have pending payment of {due_amount}. Kindly pay it as soon as possible. {business_name}', 'Payment Reminder, from {business_name}', 0, 0, '2020-03-05 05:06:01', '2020-03-05 05:06:01'),
(4, 1, 'new_booking', '<p>Dear {contact_name},</p>\n\n                    <p>Your booking is confirmed</p>\n\n                    <p>Date: {start_time} to {end_time}</p>\n\n                    <p>Table: {table}</p>\n\n                    <p>Location: {location}</p>\n\n                    <p>{business_logo}</p>', 'Dear {contact_name}, Your booking is confirmed. Date: {start_time} to {end_time}, Table: {table}, Location: {location}', 'Booking Confirmed - {business_name}', 0, 0, '2020-03-05 05:06:01', '2020-03-05 05:06:01'),
(5, 1, 'new_order', '<p>Dear {contact_name},</p>\n\n                    <p>We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'Dear {contact_name}, We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible. {business_name}', 'New Order, from {business_name}', 0, 0, '2020-03-05 05:06:01', '2020-03-05 05:06:01'),
(6, 1, 'payment_paid', '<p>Dear {contact_name},</p>\n\n                    <p>We have paid amount {paid_amount} again invoice number {invoice_number}.<br />\n                    Kindly note it down.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'We have paid amount {paid_amount} again invoice number {invoice_number}.\n                    Kindly note it down. {business_name}', 'Payment Paid, from {business_name}', 0, 0, '2020-03-05 05:06:01', '2020-03-05 05:06:01'),
(7, 1, 'items_received', '<p>Dear {contact_name},</p>\n\n                    <p>We have received all items from invoice reference number {invoice_number}. Thank you for processing it.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'We have received all items from invoice reference number {invoice_number}. Thank you for processing it. {business_name}', 'Items received, from {business_name}', 0, 0, '2020-03-05 05:06:01', '2020-03-05 05:06:01'),
(8, 1, 'items_pending', '<p>Dear {contact_name},<br />\n                    This is to remind you that we have not yet received some items from invoice reference number {invoice_number}. Please process it as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'This is to remind you that we have not yet received some items from invoice reference number {invoice_number} . Please process it as soon as possible.{business_name}', 'Items Pending, from {business_name}', 0, 0, '2020-03-05 05:06:01', '2020-03-05 05:06:01'),
(9, 2, 'new_sale', '<p>Dear {contact_name},</p>\n\n                    <p>Your invoice number is {invoice_number}<br />\n                    Total amount: {total_amount}<br />\n                    Paid amount: {paid_amount}</p>\n\n                    <p>Thank you for shopping with us.</p>\n\n                    <p>{business_logo}</p>\n\n                    <p>&nbsp;</p>', 'Dear {contact_name}, Thank you for shopping with us. {business_name}', 'Thank you from {business_name}', 0, 0, '2020-03-05 22:38:31', '2020-03-05 22:38:31'),
(10, 2, 'payment_received', '<p>Dear {contact_name},</p>\n\n                <p>We have received a payment of {paid_amount}</p>\n\n                <p>{business_logo}</p>', 'Dear {contact_name}, We have received a payment of {paid_amount}. {business_name}', 'Payment Received, from {business_name}', 0, 0, '2020-03-05 22:38:31', '2020-03-05 22:38:31'),
(11, 2, 'payment_reminder', '<p>Dear {contact_name},</p>\n\n                    <p>This is to remind you that you have pending payment of {due_amount}. Kindly pay it as soon as possible.</p>\n\n                    <p>{business_logo}</p>', 'Dear {contact_name}, You have pending payment of {due_amount}. Kindly pay it as soon as possible. {business_name}', 'Payment Reminder, from {business_name}', 0, 0, '2020-03-05 22:38:31', '2020-03-05 22:38:31'),
(12, 2, 'new_booking', '<p>Dear {contact_name},</p>\n\n                    <p>Your booking is confirmed</p>\n\n                    <p>Date: {start_time} to {end_time}</p>\n\n                    <p>Table: {table}</p>\n\n                    <p>Location: {location}</p>\n\n                    <p>{business_logo}</p>', 'Dear {contact_name}, Your booking is confirmed. Date: {start_time} to {end_time}, Table: {table}, Location: {location}', 'Booking Confirmed - {business_name}', 0, 0, '2020-03-05 22:38:31', '2020-03-05 22:38:31'),
(13, 2, 'new_order', '<p>Dear {contact_name},</p>\n\n                    <p>We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'Dear {contact_name}, We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible. {business_name}', 'New Order, from {business_name}', 0, 0, '2020-03-05 22:38:31', '2020-03-05 22:38:31'),
(14, 2, 'payment_paid', '<p>Dear {contact_name},</p>\n\n                    <p>We have paid amount {paid_amount} again invoice number {invoice_number}.<br />\n                    Kindly note it down.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'We have paid amount {paid_amount} again invoice number {invoice_number}.\n                    Kindly note it down. {business_name}', 'Payment Paid, from {business_name}', 0, 0, '2020-03-05 22:38:31', '2020-03-05 22:38:31'),
(15, 2, 'items_received', '<p>Dear {contact_name},</p>\n\n                    <p>We have received all items from invoice reference number {invoice_number}. Thank you for processing it.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'We have received all items from invoice reference number {invoice_number}. Thank you for processing it. {business_name}', 'Items received, from {business_name}', 0, 0, '2020-03-05 22:38:31', '2020-03-05 22:38:31'),
(16, 2, 'items_pending', '<p>Dear {contact_name},<br />\n                    This is to remind you that we have not yet received some items from invoice reference number {invoice_number}. Please process it as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'This is to remind you that we have not yet received some items from invoice reference number {invoice_number} . Please process it as soon as possible.{business_name}', 'Items Pending, from {business_name}', 0, 0, '2020-03-05 22:38:31', '2020-03-05 22:38:31'),
(17, 3, 'new_sale', '<p>Dear {contact_name},</p>\n\n                    <p>Your invoice number is {invoice_number}<br />\n                    Total amount: {total_amount}<br />\n                    Paid amount: {paid_amount}</p>\n\n                    <p>Thank you for shopping with us.</p>\n\n                    <p>{business_logo}</p>\n\n                    <p>&nbsp;</p>', 'Dear {contact_name}, Thank you for shopping with us. {business_name}', 'Thank you from {business_name}', 0, 0, '2020-03-09 23:54:04', '2020-03-09 23:54:04'),
(18, 3, 'payment_received', '<p>Dear {contact_name},</p>\n\n                <p>We have received a payment of {paid_amount}</p>\n\n                <p>{business_logo}</p>', 'Dear {contact_name}, We have received a payment of {paid_amount}. {business_name}', 'Payment Received, from {business_name}', 0, 0, '2020-03-09 23:54:04', '2020-03-09 23:54:04'),
(19, 3, 'payment_reminder', '<p>Dear {contact_name},</p>\n\n                    <p>This is to remind you that you have pending payment of {due_amount}. Kindly pay it as soon as possible.</p>\n\n                    <p>{business_logo}</p>', 'Dear {contact_name}, You have pending payment of {due_amount}. Kindly pay it as soon as possible. {business_name}', 'Payment Reminder, from {business_name}', 0, 0, '2020-03-09 23:54:04', '2020-03-09 23:54:04'),
(20, 3, 'new_booking', '<p>Dear {contact_name},</p>\n\n                    <p>Your booking is confirmed</p>\n\n                    <p>Date: {start_time} to {end_time}</p>\n\n                    <p>Table: {table}</p>\n\n                    <p>Location: {location}</p>\n\n                    <p>{business_logo}</p>', 'Dear {contact_name}, Your booking is confirmed. Date: {start_time} to {end_time}, Table: {table}, Location: {location}', 'Booking Confirmed - {business_name}', 0, 0, '2020-03-09 23:54:04', '2020-03-09 23:54:04'),
(21, 3, 'new_order', '<p>Dear {contact_name},</p>\n\n                    <p>We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'Dear {contact_name}, We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible. {business_name}', 'New Order, from {business_name}', 0, 0, '2020-03-09 23:54:04', '2020-03-09 23:54:04'),
(22, 3, 'payment_paid', '<p>Dear {contact_name},</p>\n\n                    <p>We have paid amount {paid_amount} again invoice number {invoice_number}.<br />\n                    Kindly note it down.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'We have paid amount {paid_amount} again invoice number {invoice_number}.\n                    Kindly note it down. {business_name}', 'Payment Paid, from {business_name}', 0, 0, '2020-03-09 23:54:04', '2020-03-09 23:54:04'),
(23, 3, 'items_received', '<p>Dear {contact_name},</p>\n\n                    <p>We have received all items from invoice reference number {invoice_number}. Thank you for processing it.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'We have received all items from invoice reference number {invoice_number}. Thank you for processing it. {business_name}', 'Items received, from {business_name}', 0, 0, '2020-03-09 23:54:04', '2020-03-09 23:54:04'),
(24, 3, 'items_pending', '<p>Dear {contact_name},<br />\n                    This is to remind you that we have not yet received some items from invoice reference number {invoice_number}. Please process it as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'This is to remind you that we have not yet received some items from invoice reference number {invoice_number} . Please process it as soon as possible.{business_name}', 'Items Pending, from {business_name}', 0, 0, '2020-03-09 23:54:04', '2020-03-09 23:54:04'),
(25, 4, 'new_sale', '<p>Dear {contact_name},</p>\n\n                    <p>Your invoice number is {invoice_number}<br />\n                    Total amount: {total_amount}<br />\n                    Paid amount: {paid_amount}</p>\n\n                    <p>Thank you for shopping with us.</p>\n\n                    <p>{business_logo}</p>\n\n                    <p>&nbsp;</p>', 'Dear {contact_name}, Thank you for shopping with us. {business_name}', 'Thank you from {business_name}', 0, 0, '2020-05-11 22:02:07', '2020-05-11 22:02:07'),
(26, 4, 'payment_received', '<p>Dear {contact_name},</p>\n\n                <p>We have received a payment of {paid_amount}</p>\n\n                <p>{business_logo}</p>', 'Dear {contact_name}, We have received a payment of {paid_amount}. {business_name}', 'Payment Received, from {business_name}', 0, 0, '2020-05-11 22:02:07', '2020-05-11 22:02:07'),
(27, 4, 'payment_reminder', '<p>Dear {contact_name},</p>\n\n                    <p>This is to remind you that you have pending payment of {due_amount}. Kindly pay it as soon as possible.</p>\n\n                    <p>{business_logo}</p>', 'Dear {contact_name}, You have pending payment of {due_amount}. Kindly pay it as soon as possible. {business_name}', 'Payment Reminder, from {business_name}', 0, 0, '2020-05-11 22:02:07', '2020-05-11 22:02:07'),
(28, 4, 'new_booking', '<p>Dear {contact_name},</p>\n\n                    <p>Your booking is confirmed</p>\n\n                    <p>Date: {start_time} to {end_time}</p>\n\n                    <p>Table: {table}</p>\n\n                    <p>Location: {location}</p>\n\n                    <p>{business_logo}</p>', 'Dear {contact_name}, Your booking is confirmed. Date: {start_time} to {end_time}, Table: {table}, Location: {location}', 'Booking Confirmed - {business_name}', 0, 0, '2020-05-11 22:02:07', '2020-05-11 22:02:07'),
(29, 4, 'new_order', '<p>Dear {contact_name},</p>\n\n                    <p>We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'Dear {contact_name}, We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible. {business_name}', 'New Order, from {business_name}', 0, 0, '2020-05-11 22:02:07', '2020-05-11 22:02:07'),
(30, 4, 'payment_paid', '<p>Dear {contact_name},</p>\n\n                    <p>We have paid amount {paid_amount} again invoice number {invoice_number}.<br />\n                    Kindly note it down.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'We have paid amount {paid_amount} again invoice number {invoice_number}.\n                    Kindly note it down. {business_name}', 'Payment Paid, from {business_name}', 0, 0, '2020-05-11 22:02:07', '2020-05-11 22:02:07'),
(31, 4, 'items_received', '<p>Dear {contact_name},</p>\n\n                    <p>We have received all items from invoice reference number {invoice_number}. Thank you for processing it.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'We have received all items from invoice reference number {invoice_number}. Thank you for processing it. {business_name}', 'Items received, from {business_name}', 0, 0, '2020-05-11 22:02:07', '2020-05-11 22:02:07'),
(32, 4, 'items_pending', '<p>Dear {contact_name},<br />\n                    This is to remind you that we have not yet received some items from invoice reference number {invoice_number}. Please process it as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'This is to remind you that we have not yet received some items from invoice reference number {invoice_number} . Please process it as soon as possible.{business_name}', 'Items Pending, from {business_name}', 0, 0, '2020-05-11 22:02:07', '2020-05-11 22:02:07'),
(33, 5, 'new_sale', '<p>Dear {contact_name},</p>\n\n                    <p>Your invoice number is {invoice_number}<br />\n                    Total amount: {total_amount}<br />\n                    Paid amount: {paid_amount}</p>\n\n                    <p>Thank you for shopping with us.</p>\n\n                    <p>{business_logo}</p>\n\n                    <p>&nbsp;</p>', 'Dear {contact_name}, Thank you for shopping with us. {business_name}', 'Thank you from {business_name}', 0, 0, '2020-05-11 23:35:51', '2020-05-11 23:35:51'),
(34, 5, 'payment_received', '<p>Dear {contact_name},</p>\n\n                <p>We have received a payment of {paid_amount}</p>\n\n                <p>{business_logo}</p>', 'Dear {contact_name}, We have received a payment of {paid_amount}. {business_name}', 'Payment Received, from {business_name}', 0, 0, '2020-05-11 23:35:51', '2020-05-11 23:35:51'),
(35, 5, 'payment_reminder', '<p>Dear {contact_name},</p>\n\n                    <p>This is to remind you that you have pending payment of {due_amount}. Kindly pay it as soon as possible.</p>\n\n                    <p>{business_logo}</p>', 'Dear {contact_name}, You have pending payment of {due_amount}. Kindly pay it as soon as possible. {business_name}', 'Payment Reminder, from {business_name}', 0, 0, '2020-05-11 23:35:51', '2020-05-11 23:35:51'),
(36, 5, 'new_booking', '<p>Dear {contact_name},</p>\n\n                    <p>Your booking is confirmed</p>\n\n                    <p>Date: {start_time} to {end_time}</p>\n\n                    <p>Table: {table}</p>\n\n                    <p>Location: {location}</p>\n\n                    <p>{business_logo}</p>', 'Dear {contact_name}, Your booking is confirmed. Date: {start_time} to {end_time}, Table: {table}, Location: {location}', 'Booking Confirmed - {business_name}', 0, 0, '2020-05-11 23:35:51', '2020-05-11 23:35:51'),
(37, 5, 'new_order', '<p>Dear {contact_name},</p>\n\n                    <p>We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'Dear {contact_name}, We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible. {business_name}', 'New Order, from {business_name}', 0, 0, '2020-05-11 23:35:51', '2020-05-11 23:35:51'),
(38, 5, 'payment_paid', '<p>Dear {contact_name},</p>\n\n                    <p>We have paid amount {paid_amount} again invoice number {invoice_number}.<br />\n                    Kindly note it down.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'We have paid amount {paid_amount} again invoice number {invoice_number}.\n                    Kindly note it down. {business_name}', 'Payment Paid, from {business_name}', 0, 0, '2020-05-11 23:35:51', '2020-05-11 23:35:51'),
(39, 5, 'items_received', '<p>Dear {contact_name},</p>\n\n                    <p>We have received all items from invoice reference number {invoice_number}. Thank you for processing it.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'We have received all items from invoice reference number {invoice_number}. Thank you for processing it. {business_name}', 'Items received, from {business_name}', 0, 0, '2020-05-11 23:35:51', '2020-05-11 23:35:51'),
(40, 5, 'items_pending', '<p>Dear {contact_name},<br />\n                    This is to remind you that we have not yet received some items from invoice reference number {invoice_number}. Please process it as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'This is to remind you that we have not yet received some items from invoice reference number {invoice_number} . Please process it as soon as possible.{business_name}', 'Items Pending, from {business_name}', 0, 0, '2020-05-11 23:35:51', '2020-05-11 23:35:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `packages`
--

CREATE TABLE `packages` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `location_count` int(11) NOT NULL COMMENT 'No. of Business Locations, 0 = infinite option.',
  `user_count` int(11) NOT NULL,
  `product_count` int(11) NOT NULL,
  `bookings` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Enable/Disable bookings',
  `kitchen` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Enable/Disable kitchen',
  `order_screen` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Enable/Disable order_screen',
  `tables` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Enable/Disable tables',
  `invoice_count` int(11) NOT NULL,
  `interval` enum('days','months','years') COLLATE utf8mb4_unicode_ci NOT NULL,
  `interval_count` int(11) NOT NULL,
  `trial_days` int(11) NOT NULL,
  `price` decimal(20,4) NOT NULL,
  `custom_permissions` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT 0,
  `is_one_time` tinyint(1) NOT NULL DEFAULT 0,
  `enable_custom_link` tinyint(1) NOT NULL DEFAULT 0,
  `custom_link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_link_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `packages`
--

INSERT INTO `packages` (`id`, `name`, `description`, `location_count`, `user_count`, `product_count`, `bookings`, `kitchen`, `order_screen`, `tables`, `invoice_count`, `interval`, `interval_count`, `trial_days`, `price`, `custom_permissions`, `created_by`, `sort_order`, `is_active`, `is_private`, `is_one_time`, `enable_custom_link`, `custom_link`, `custom_link_text`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Básico', 'contiene algunas funciones', 1, 5, 0, 0, 0, 0, 0, 0, 'months', 4, 30, '2500.0000', '', 1, 1, 1, 0, 0, 0, '', '', NULL, '2020-06-10 05:35:43', '2020-06-10 05:35:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'profit_loss_report.view', 'web', '2020-03-05 05:03:21', NULL),
(2, 'direct_sell.access', 'web', '2020-03-05 05:03:21', NULL),
(3, 'product.opening_stock', 'web', '2020-03-05 05:03:22', '2020-03-05 05:03:22'),
(4, 'crud_all_bookings', 'web', '2020-03-05 05:03:22', '2020-03-05 05:03:22'),
(5, 'crud_own_bookings', 'web', '2020-03-05 05:03:22', '2020-03-05 05:03:22'),
(6, 'access_default_selling_price', 'web', '2020-03-05 05:03:23', '2020-03-05 05:03:23'),
(7, 'purchase.payments', 'web', '2020-03-05 05:03:23', '2020-03-05 05:03:23'),
(8, 'sell.payments', 'web', '2020-03-05 05:03:23', '2020-03-05 05:03:23'),
(9, 'edit_product_price_from_sale_screen', 'web', '2020-03-05 05:03:23', '2020-03-05 05:03:23'),
(10, 'edit_product_discount_from_sale_screen', 'web', '2020-03-05 05:03:23', '2020-03-05 05:03:23'),
(11, 'roles.view', 'web', '2020-03-05 05:03:23', '2020-03-05 05:03:23'),
(12, 'roles.create', 'web', '2020-03-05 05:03:23', '2020-03-05 05:03:23'),
(13, 'roles.update', 'web', '2020-03-05 05:03:23', '2020-03-05 05:03:23'),
(14, 'roles.delete', 'web', '2020-03-05 05:03:23', '2020-03-05 05:03:23'),
(15, 'account.access', 'web', '2020-03-05 05:03:23', '2020-03-05 05:03:23'),
(16, 'discount.access', 'web', '2020-03-05 05:03:23', '2020-03-05 05:03:23'),
(17, 'view_purchase_price', 'web', '2020-03-05 05:03:24', '2020-03-05 05:03:24'),
(18, 'view_own_sell_only', 'web', '2020-03-05 05:03:24', '2020-03-05 05:03:24'),
(19, 'edit_product_discount_from_pos_screen', 'web', '2020-03-05 05:03:24', '2020-03-05 05:03:24'),
(20, 'edit_product_price_from_pos_screen', 'web', '2020-03-05 05:03:24', '2020-03-05 05:03:24'),
(21, 'access_shipping', 'web', '2020-03-05 05:03:24', '2020-03-05 05:03:24'),
(22, 'purchase.update_status', 'web', '2020-03-05 05:03:24', '2020-03-05 05:03:24'),
(23, 'list_drafts', 'web', '2020-03-05 05:03:25', '2020-03-05 05:03:25'),
(24, 'list_quotations', 'web', '2020-03-05 05:03:25', '2020-03-05 05:03:25'),
(25, 'user.view', 'web', '2020-03-05 05:03:25', NULL),
(26, 'user.create', 'web', '2020-03-05 05:03:25', NULL),
(27, 'user.update', 'web', '2020-03-05 05:03:25', NULL),
(28, 'user.delete', 'web', '2020-03-05 05:03:25', NULL),
(29, 'supplier.view', 'web', '2020-03-05 05:03:25', NULL),
(30, 'supplier.create', 'web', '2020-03-05 05:03:25', NULL),
(31, 'supplier.update', 'web', '2020-03-05 05:03:25', NULL),
(32, 'supplier.delete', 'web', '2020-03-05 05:03:25', NULL),
(33, 'customer.view', 'web', '2020-03-05 05:03:25', NULL),
(34, 'customer.create', 'web', '2020-03-05 05:03:25', NULL),
(35, 'customer.update', 'web', '2020-03-05 05:03:25', NULL),
(36, 'customer.delete', 'web', '2020-03-05 05:03:25', NULL),
(37, 'product.view', 'web', '2020-03-05 05:03:25', NULL),
(38, 'product.create', 'web', '2020-03-05 05:03:25', NULL),
(39, 'product.update', 'web', '2020-03-05 05:03:25', NULL),
(40, 'product.delete', 'web', '2020-03-05 05:03:25', NULL),
(41, 'purchase.view', 'web', '2020-03-05 05:03:25', NULL),
(42, 'purchase.create', 'web', '2020-03-05 05:03:25', NULL),
(43, 'purchase.update', 'web', '2020-03-05 05:03:25', NULL),
(44, 'purchase.delete', 'web', '2020-03-05 05:03:25', NULL),
(45, 'sell.view', 'web', '2020-03-05 05:03:25', NULL),
(46, 'sell.create', 'web', '2020-03-05 05:03:25', NULL),
(47, 'sell.update', 'web', '2020-03-05 05:03:25', NULL),
(48, 'sell.delete', 'web', '2020-03-05 05:03:25', NULL),
(49, 'purchase_n_sell_report.view', 'web', '2020-03-05 05:03:25', NULL),
(50, 'contacts_report.view', 'web', '2020-03-05 05:03:25', NULL),
(51, 'stock_report.view', 'web', '2020-03-05 05:03:25', NULL),
(52, 'tax_report.view', 'web', '2020-03-05 05:03:25', NULL),
(53, 'trending_product_report.view', 'web', '2020-03-05 05:03:25', NULL),
(54, 'register_report.view', 'web', '2020-03-05 05:03:25', NULL),
(55, 'sales_representative.view', 'web', '2020-03-05 05:03:25', NULL),
(56, 'expense_report.view', 'web', '2020-03-05 05:03:25', NULL),
(57, 'business_settings.access', 'web', '2020-03-05 05:03:25', NULL),
(58, 'barcode_settings.access', 'web', '2020-03-05 05:03:25', NULL),
(59, 'invoice_settings.access', 'web', '2020-03-05 05:03:25', NULL),
(60, 'brand.view', 'web', '2020-03-05 05:03:25', NULL),
(61, 'brand.create', 'web', '2020-03-05 05:03:25', NULL),
(62, 'brand.update', 'web', '2020-03-05 05:03:25', NULL),
(63, 'brand.delete', 'web', '2020-03-05 05:03:25', NULL),
(64, 'tax_rate.view', 'web', '2020-03-05 05:03:25', NULL),
(65, 'tax_rate.create', 'web', '2020-03-05 05:03:25', NULL),
(66, 'tax_rate.update', 'web', '2020-03-05 05:03:25', NULL),
(67, 'tax_rate.delete', 'web', '2020-03-05 05:03:25', NULL),
(68, 'unit.view', 'web', '2020-03-05 05:03:25', NULL),
(69, 'unit.create', 'web', '2020-03-05 05:03:25', NULL),
(70, 'unit.update', 'web', '2020-03-05 05:03:25', NULL),
(71, 'unit.delete', 'web', '2020-03-05 05:03:25', NULL),
(72, 'category.view', 'web', '2020-03-05 05:03:25', NULL),
(73, 'category.create', 'web', '2020-03-05 05:03:25', NULL),
(74, 'category.update', 'web', '2020-03-05 05:03:25', NULL),
(75, 'category.delete', 'web', '2020-03-05 05:03:25', NULL),
(76, 'expense.access', 'web', '2020-03-05 05:03:25', NULL),
(77, 'access_all_locations', 'web', '2020-03-05 05:03:25', NULL),
(78, 'dashboard.data', 'web', '2020-03-05 05:03:25', NULL),
(79, 'location.1', 'web', '2020-03-05 05:06:01', '2020-03-05 05:06:01'),
(80, 'location.2', 'web', '2020-03-05 22:38:31', '2020-03-05 22:38:31'),
(81, 'location.3', 'web', '2020-03-09 23:54:04', '2020-03-09 23:54:04'),
(82, 'selling_price_group.1', 'web', '2020-04-09 13:12:32', '2020-04-09 13:12:32'),
(83, 'selling_price_group.2', 'web', '2020-04-09 13:12:41', '2020-04-09 13:12:41'),
(84, 'location.4', 'web', '2020-05-11 22:02:07', '2020-05-11 22:02:07'),
(85, 'location.5', 'web', '2020-05-11 23:35:51', '2020-05-11 23:35:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presupuesto`
--

CREATE TABLE `presupuesto` (
  `id` int(11) NOT NULL,
  `p_id` int(11) DEFAULT NULL,
  `partidas` varchar(155) DEFAULT NULL,
  `cantidad` varchar(155) DEFAULT NULL,
  `unidad` varchar(155) DEFAULT NULL,
  `precio_unitario` varchar(155) DEFAULT NULL,
  `Valor` varchar(255) DEFAULT NULL,
  `business_id` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `printers`
--

CREATE TABLE `printers` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection_type` enum('network','windows','linux') COLLATE utf8mb4_unicode_ci NOT NULL,
  `capability_profile` enum('default','simple','SP2000','TEP-200M','P822D') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `char_per_line` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `port` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `type` enum('single','variable','modifier','combo') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_id` int(11) UNSIGNED DEFAULT NULL,
  `sub_unit_ids` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand_id` int(10) UNSIGNED DEFAULT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `sub_category_id` int(10) UNSIGNED DEFAULT NULL,
  `tax` int(10) UNSIGNED DEFAULT NULL,
  `tax_type` enum('inclusive','exclusive') COLLATE utf8mb4_unicode_ci NOT NULL,
  `enable_stock` tinyint(1) NOT NULL DEFAULT 0,
  `alert_quantity` decimal(22,4) DEFAULT NULL,
  `sku` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `barcode_type` enum('C39','C128','EAN13','EAN8','UPCA','UPCE') COLLATE utf8mb4_unicode_ci DEFAULT 'C128',
  `expiry_period` decimal(4,2) DEFAULT NULL,
  `expiry_period_type` enum('days','months') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_sr_no` tinyint(1) NOT NULL DEFAULT 0,
  `weight` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_custom_field1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_custom_field2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_custom_field3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_custom_field4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `warranty_id` int(11) DEFAULT NULL,
  `is_inactive` tinyint(1) NOT NULL DEFAULT 0,
  `not_for_selling` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`id`, `name`, `business_id`, `type`, `unit_id`, `sub_unit_ids`, `brand_id`, `category_id`, `sub_category_id`, `tax`, `tax_type`, `enable_stock`, `alert_quantity`, `sku`, `barcode_type`, `expiry_period`, `expiry_period_type`, `enable_sr_no`, `weight`, `product_custom_field1`, `product_custom_field2`, `product_custom_field3`, `product_custom_field4`, `image`, `product_description`, `created_by`, `warranty_id`, `is_inactive`, `not_for_selling`, `created_at`, `updated_at`) VALUES
(1, 'ejemplo', 1, 'single', 1, NULL, 1, 1, NULL, NULL, 'exclusive', 1, '5.0000', '0001', 'C128', NULL, NULL, 0, '200', NULL, NULL, NULL, NULL, NULL, '<p>ninguna</p>', 1, NULL, 0, 0, '2020-03-04 19:38:54', '2020-03-04 19:38:54'),
(2, 'ejemplo1', 1, 'single', 1, NULL, 1, 1, NULL, NULL, 'exclusive', 1, '4.0000', '0002', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, 0, '2020-03-04 20:45:31', '2020-03-04 20:45:31'),
(3, 'Empanadas Pollo y Crema', 2, 'single', 2, NULL, NULL, 2, 3, NULL, 'exclusive', 1, '10.0000', '0003', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, NULL, 0, 0, '2020-03-05 16:39:40', '2020-03-05 16:39:40'),
(4, 'Empanadas Pollo y Maiz', 2, 'single', 2, NULL, NULL, 2, 5, NULL, 'exclusive', 1, '10.0000', '0004', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, NULL, 0, 0, '2020-03-05 16:40:22', '2020-03-05 16:40:22'),
(5, 'Empanadas Puerro', 2, 'single', 2, NULL, NULL, 2, 4, NULL, 'exclusive', 1, '10.0000', '0005', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, NULL, 0, 0, '2020-03-05 16:40:51', '2020-03-05 16:40:51'),
(6, 'Empanadas Pizza', 2, 'single', 2, NULL, NULL, 2, 6, NULL, 'exclusive', 1, '10.0000', '0006', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, NULL, 0, 0, '2020-03-05 16:41:30', '2020-03-05 16:41:30'),
(7, 'Empanadas Quesos', 2, 'single', 2, NULL, NULL, 2, 7, NULL, 'exclusive', 1, '10.0000', '0007', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, NULL, 0, 0, '2020-03-05 16:42:09', '2020-03-05 16:42:09'),
(8, 'Empanadas Sin Relleno', 2, 'single', 2, NULL, NULL, 2, 8, NULL, 'exclusive', 1, '9.0000', '0008', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, NULL, 0, 0, '2020-03-05 16:42:45', '2020-03-05 16:42:45'),
(9, 'Servicios Profesionales', 3, 'single', 3, NULL, NULL, NULL, NULL, NULL, 'exclusive', 0, '0.0000', '0009', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14, NULL, 0, 0, '2020-03-09 14:45:20', '2020-03-09 14:45:20'),
(10, 'Router Microtik', 3, 'single', 3, NULL, NULL, NULL, NULL, NULL, 'exclusive', 0, '0.0000', '0010', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14, NULL, 0, 0, '2020-03-11 15:16:48', '2020-03-11 15:16:48'),
(12, 'Mubee(revendedores)', 3, 'single', 3, NULL, NULL, 10, NULL, NULL, 'exclusive', 0, '0.0000', '0012', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14, NULL, 0, 0, '2020-04-09 13:21:16', '2020-04-09 13:21:16'),
(13, 'Axe(Revendedores)', 3, 'single', 3, NULL, NULL, 10, NULL, NULL, 'exclusive', 0, '0.0000', '0013', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14, NULL, 0, 0, '2020-04-09 13:22:50', '2020-04-09 13:22:50'),
(17, 'Currier China', 1, 'single', 1, NULL, 3, NULL, NULL, NULL, 'exclusive', 1, '0.0000', '0017', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, 0, '2020-05-12 13:59:26', '2020-06-12 17:11:09'),
(18, 'Currier desde miami', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, '0.0000', '0018', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, 0, '2020-05-12 14:02:49', '2020-06-19 17:33:14'),
(19, 'Producto prueba 1', 5, 'single', 5, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, '0.0000', '0019', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '1589307108_apple.jpg', NULL, 16, NULL, 0, 0, '2020-05-12 18:11:48', '2020-05-12 18:11:48'),
(20, 'Producto prueba 2', 5, 'single', 5, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, '0.0000', '0020', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16, NULL, 0, 0, '2020-05-12 18:12:18', '2020-05-12 18:12:18'),
(22, 'ejemplo stock', 1, 'single', 1, NULL, 1, 1, NULL, NULL, 'exclusive', 0, '0.0000', '0022', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, 0, '2020-05-28 15:33:46', '2020-05-28 15:33:46'),
(23, 'probando stock', 1, 'single', 1, NULL, 1, 1, NULL, NULL, 'exclusive', 1, NULL, '0023', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, 0, '2020-05-28 15:34:54', '2020-05-28 15:34:54'),
(24, 'producto probando', 1, 'single', 7, NULL, 5, 11, NULL, NULL, 'exclusive', 1, '5.0000', '0024', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, 0, '2020-06-03 19:08:17', '2020-06-03 19:08:17'),
(25, 'producto probando 2', 1, 'single', 7, NULL, 5, 11, NULL, NULL, 'exclusive', 1, '5.0000', '0025', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, 0, '2020-06-03 19:09:32', '2020-06-03 19:09:32'),
(26, 'producto', 1, 'single', 1, NULL, 1, 1, NULL, NULL, 'exclusive', 0, '0.0000', '0026', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, 0, '2020-06-08 13:26:44', '2020-06-08 13:26:44'),
(27, 'cama', 1, 'single', 8, NULL, 6, 1, NULL, NULL, 'exclusive', 1, '5.0000', '0027', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p>esta es una cama cuadrada</p>', 1, NULL, 0, 0, '2020-06-08 13:49:52', '2020-06-08 13:49:52'),
(28, 'para verificar', 1, 'single', 1, NULL, 5, 1, NULL, NULL, 'exclusive', 1, NULL, '0028', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, 0, '2020-06-19 17:41:01', '2020-06-19 17:41:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product_locations`
--

CREATE TABLE `product_locations` (
  `product_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `product_locations`
--

INSERT INTO `product_locations` (`product_id`, `location_id`) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 3),
(10, 3),
(11, 3),
(12, 3),
(13, 3),
(14, 5),
(15, 5),
(16, 5),
(17, 1),
(18, 1),
(19, 5),
(20, 5),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product_racks`
--

CREATE TABLE `product_racks` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `rack` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `row` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product_variations`
--

CREATE TABLE `product_variations` (
  `id` int(10) UNSIGNED NOT NULL,
  `variation_template_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `is_dummy` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `product_variations`
--

INSERT INTO `product_variations` (`id`, `variation_template_id`, `name`, `product_id`, `is_dummy`, `created_at`, `updated_at`) VALUES
(1, NULL, 'DUMMY', 1, 1, '2020-03-04 19:38:54', '2020-03-04 19:38:54'),
(2, NULL, 'DUMMY', 2, 1, '2020-03-04 20:45:31', '2020-03-04 20:45:31'),
(3, NULL, 'DUMMY', 3, 1, '2020-03-05 16:39:40', '2020-03-05 16:39:40'),
(4, NULL, 'DUMMY', 4, 1, '2020-03-05 16:40:22', '2020-03-05 16:40:22'),
(5, NULL, 'DUMMY', 5, 1, '2020-03-05 16:40:51', '2020-03-05 16:40:51'),
(6, NULL, 'DUMMY', 6, 1, '2020-03-05 16:41:30', '2020-03-05 16:41:30'),
(7, NULL, 'DUMMY', 7, 1, '2020-03-05 16:42:09', '2020-03-05 16:42:09'),
(8, NULL, 'DUMMY', 8, 1, '2020-03-05 16:42:45', '2020-03-05 16:42:45'),
(9, NULL, 'DUMMY', 9, 1, '2020-03-09 14:45:20', '2020-03-09 14:45:20'),
(10, NULL, 'DUMMY', 10, 1, '2020-03-11 15:16:48', '2020-03-11 15:16:48'),
(12, NULL, 'DUMMY', 12, 1, '2020-04-09 13:21:16', '2020-04-09 13:21:16'),
(13, NULL, 'DUMMY', 13, 1, '2020-04-09 13:22:50', '2020-04-09 13:22:50'),
(17, NULL, 'DUMMY', 17, 1, '2020-05-12 13:59:26', '2020-05-12 13:59:26'),
(18, NULL, 'DUMMY', 18, 1, '2020-05-12 14:02:49', '2020-05-12 14:02:49'),
(19, NULL, 'DUMMY', 19, 1, '2020-05-12 18:11:48', '2020-05-12 18:11:48'),
(20, NULL, 'DUMMY', 20, 1, '2020-05-12 18:12:18', '2020-05-12 18:12:18'),
(22, NULL, 'DUMMY', 22, 1, '2020-05-28 15:33:46', '2020-05-28 15:33:46'),
(23, NULL, 'DUMMY', 23, 1, '2020-05-28 15:34:54', '2020-05-28 15:34:54'),
(24, NULL, 'DUMMY', 24, 1, '2020-06-03 19:08:17', '2020-06-03 19:08:17'),
(25, NULL, 'DUMMY', 25, 1, '2020-06-03 19:09:32', '2020-06-03 19:09:32'),
(26, NULL, 'DUMMY', 26, 1, '2020-06-08 13:26:44', '2020-06-08 13:26:44'),
(27, NULL, 'DUMMY', 27, 1, '2020-06-08 13:49:52', '2020-06-08 13:49:52'),
(28, NULL, 'DUMMY', 28, 1, '2020-06-19 17:41:01', '2020-06-19 17:41:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `project`
--

CREATE TABLE `project` (
  `p_id` int(11) NOT NULL,
  `name` varchar(155) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `customer_id` varchar(200) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `encargado` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `members` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `business_id` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `project`
--

INSERT INTO `project` (`p_id`, `name`, `Description`, `customer_id`, `status`, `encargado`, `start_date`, `end_date`, `members`, `category`, `business_id`, `updated_at`, `created_at`) VALUES
(3, 'proyecto 3', 'as', '1', 'En progreso', '1', '2020-12-31', '2020-12-31', '1,18', 'ninguna', 1, '2020-06-09 13:25:37', '2020-06-02 16:11:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `purchase_lines`
--

CREATE TABLE `purchase_lines` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `pp_without_discount` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'Purchase price before inline discounts',
  `discount_percent` decimal(5,2) NOT NULL DEFAULT 0.00 COMMENT 'Inline discount percentage',
  `purchase_price` decimal(22,4) NOT NULL,
  `purchase_price_inc_tax` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `item_tax` decimal(22,4) NOT NULL COMMENT 'Tax for one quantity',
  `tax_id` int(10) UNSIGNED DEFAULT NULL,
  `quantity_sold` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'Quanity sold from this purchase line',
  `quantity_adjusted` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'Quanity adjusted in stock adjustment from this purchase line',
  `quantity_returned` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `mfg_quantity_used` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `mfg_date` date DEFAULT NULL,
  `exp_date` date DEFAULT NULL,
  `lot_number` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_unit_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `purchase_lines`
--

INSERT INTO `purchase_lines` (`id`, `transaction_id`, `product_id`, `variation_id`, `quantity`, `pp_without_discount`, `discount_percent`, `purchase_price`, `purchase_price_inc_tax`, `item_tax`, `tax_id`, `quantity_sold`, `quantity_adjusted`, `quantity_returned`, `mfg_quantity_used`, `mfg_date`, `exp_date`, `lot_number`, `sub_unit_id`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 2, '5.0000', '0.0000', '0.00', '0.0000', '0.0000', '0.0000', NULL, '5.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-03-04 20:45:31', '2020-06-03 19:17:28'),
(4, 11, 1, 1, '10.0000', '200.0000', '0.00', '200.0000', '200.0000', '0.0000', NULL, '12.0000', '1.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-03-06 13:25:43', '2020-06-19 20:32:10'),
(5, 11, 2, 2, '10.0000', '300.0000', '0.00', '300.0000', '300.0000', '0.0000', NULL, '6.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-03-06 13:25:43', '2020-06-12 18:28:43'),
(6, 29, 6, 6, '20.0000', '28.0000', '0.00', '28.0000', '28.0000', '0.0000', NULL, '20.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-03-18 20:13:27', '2020-06-18 18:41:25'),
(7, 29, 3, 3, '20.0000', '25.0000', '0.00', '25.0000', '25.0000', '0.0000', NULL, '20.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-03-18 20:13:27', '2020-05-08 12:11:28'),
(8, 29, 4, 4, '20.0000', '25.0000', '0.00', '25.0000', '25.0000', '0.0000', NULL, '10.0000', '5.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-03-18 20:13:27', '2020-06-17 20:14:22'),
(9, 29, 5, 5, '20.0000', '25.0000', '0.00', '25.0000', '25.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-03-18 20:13:27', '2020-05-07 12:57:58'),
(10, 29, 7, 7, '20.0000', '28.0000', '0.00', '28.0000', '28.0000', '0.0000', NULL, '20.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-03-18 20:13:27', '2020-05-07 14:57:03'),
(11, 29, 8, 8, '20.0000', '15.0000', '0.00', '15.0000', '15.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-03-18 20:13:27', '2020-05-11 13:39:21'),
(12, 37, 3, 3, '10.0000', '25.0000', '0.00', '25.0000', '25.0000', '0.0000', NULL, '10.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-03-18 20:26:08', '2020-05-14 12:05:33'),
(13, 37, 4, 4, '10.0000', '25.0000', '0.00', '25.0000', '25.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-03-18 20:26:08', '2020-03-18 20:26:08'),
(14, 37, 6, 6, '10.0000', '28.0000', '0.00', '28.0000', '28.0000', '0.0000', NULL, '10.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-03-18 20:26:08', '2020-06-18 18:39:45'),
(15, 72, 23, 25, '10.0000', '100.0000', '0.00', '100.0000', '100.0000', '0.0000', NULL, '2.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-05-28 15:35:09', '2020-06-02 20:57:05'),
(16, 78, 24, 26, '10.0000', '225.0000', '0.00', '225.0000', '225.0000', '0.0000', NULL, '3.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-06-03 19:10:14', '2020-06-15 19:30:56'),
(17, 78, 24, 26, '25.0000', '225.0000', '0.00', '225.0000', '225.0000', '0.0000', NULL, '9.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-06-03 19:10:14', '2020-06-15 19:58:23'),
(18, 79, 17, 17, '5.0000', '236.0000', '0.00', '236.0000', '236.0000', '0.0000', NULL, '4.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-06-03 19:13:35', '2020-06-15 18:50:08'),
(19, 84, 17, 17, '5.0000', '236.0000', '0.00', '236.0000', '236.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-06-08 13:35:14', '2020-06-08 13:35:14'),
(20, 86, 27, 29, '10.0000', '2000.0000', '0.00', '2000.0000', '2000.0000', '0.0000', NULL, '9.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-06-08 13:50:30', '2020-06-15 19:07:44'),
(21, 130, 6, 6, '24.0000', '28.0000', '0.00', '28.0000', '28.0000', '0.0000', NULL, '21.0000', '2.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-06-18 15:12:17', '2020-06-18 19:24:14'),
(22, 182, 18, 18, '1.0000', '236.0000', '0.00', '236.0000', '236.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, NULL, '2020-06-19 17:43:22', '2020-06-19 17:43:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reference_counts`
--

CREATE TABLE `reference_counts` (
  `id` int(10) UNSIGNED NOT NULL,
  `ref_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ref_count` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `reference_counts`
--

INSERT INTO `reference_counts` (`id`, `ref_type`, `ref_count`, `business_id`, `created_at`, `updated_at`) VALUES
(1, 'contacts', 9, 1, '2020-03-05 05:06:01', '2020-06-03 19:31:49'),
(2, 'business_location', 1, 1, '2020-03-05 05:06:01', '2020-03-05 05:06:01'),
(3, 'username', 10, 1, '2020-03-04 20:29:55', '2020-05-20 17:51:13'),
(4, 'contacts', 8, 2, '2020-03-05 22:38:31', '2020-05-07 14:35:21'),
(5, 'business_location', 1, 2, '2020-03-05 22:38:31', '2020-03-05 22:38:31'),
(6, 'username', 2, 2, '2020-03-05 13:35:43', '2020-03-05 13:36:39'),
(7, 'purchase', 3, 2, '2020-03-05 16:49:10', '2020-03-18 20:26:08'),
(8, 'sell_payment', 20, 2, '2020-03-06 12:35:04', '2020-06-02 15:16:48'),
(9, 'sell_payment', 46, 1, '2020-03-06 13:18:29', '2020-06-19 20:33:59'),
(10, 'purchase', 3, 1, '2020-03-06 13:25:43', '2020-06-08 13:35:14'),
(11, 'contacts', 2, 3, '2020-03-09 23:54:04', '2020-03-09 14:34:26'),
(12, 'business_location', 1, 3, '2020-03-09 23:54:04', '2020-03-09 23:54:04'),
(13, 'sell_payment', 5, 3, '2020-03-09 14:49:45', '2020-04-20 20:32:26'),
(14, 'opening_balance', 1, 1, '2020-03-11 21:45:11', '2020-03-11 21:45:11'),
(15, 'purchase_return', 1, 2, '2020-03-18 20:16:47', '2020-03-18 20:16:47'),
(16, 'purchase_payment', 3, 2, '2020-03-18 20:26:15', '2020-05-09 12:11:30'),
(17, 'sell_return', 2, 3, '2020-04-20 20:44:26', '2020-04-20 20:44:37'),
(18, 'opening_balance', 1, 2, '2020-04-27 01:33:28', '2020-04-27 01:33:28'),
(19, 'sell_return', 1, 2, '2020-05-04 13:15:29', '2020-05-04 13:15:29'),
(20, 'contacts', 2, 4, '2020-05-11 22:02:06', '2020-05-12 11:06:07'),
(21, 'business_location', 1, 4, '2020-05-11 22:02:07', '2020-05-11 22:02:07'),
(22, 'contacts', 1, 5, '2020-05-11 23:35:51', '2020-05-11 23:35:51'),
(23, 'business_location', 1, 5, '2020-05-11 23:35:51', '2020-05-11 23:35:51'),
(24, 'username', 1, 5, '2020-05-14 12:39:29', '2020-05-14 12:39:29'),
(25, 'purchase_payment', 3, 1, '2020-06-03 19:13:35', '2020-06-08 13:36:10'),
(26, 'expense', 8, 1, '2020-06-08 13:42:18', '2020-06-15 20:04:28'),
(27, 'stock_adjustment', 39, 2, '2020-06-17 20:11:50', '2020-06-18 19:23:31'),
(28, 'stock_adjustment', 1, 1, '2020-06-19 15:07:42', '2020-06-19 15:07:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `res_product_modifier_sets`
--

CREATE TABLE `res_product_modifier_sets` (
  `modifier_set_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL COMMENT 'Table use to store the modifier sets applicable for a product'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `res_tables`
--

CREATE TABLE `res_tables` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_service_staff` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `business_id`, `is_default`, `is_service_staff`, `created_at`, `updated_at`) VALUES
(1, 'SuperAdmin#1', 'web', 1, 1, 0, '2020-03-05 05:06:01', '2020-03-05 05:06:01'),
(2, 'Cashier#1', 'web', 1, 0, 0, '2020-03-05 05:06:01', '2020-03-05 05:06:01'),
(3, 'SuperAdmin#2', 'web', 2, 1, 0, '2020-03-05 22:38:31', '2020-03-05 22:38:31'),
(4, 'Cashier#2', 'web', 2, 0, 0, '2020-03-05 22:38:31', '2020-03-05 22:38:31'),
(5, 'Encargado Administrativo#2', 'web', 2, 0, 0, '2020-03-05 13:33:32', '2020-03-05 13:33:32'),
(6, 'prueba#1', 'web', 1, 0, 0, '2020-03-05 17:55:17', '2020-03-05 17:55:17'),
(7, 'SuperAdmin#3', 'web', 3, 1, 0, '2020-03-09 23:54:04', '2020-03-09 23:54:04'),
(8, 'Cashier#3', 'web', 3, 0, 0, '2020-03-09 23:54:04', '2020-03-09 23:54:04'),
(9, 'SuperAdmin#4', 'web', 4, 1, 0, '2020-05-11 22:02:06', '2020-05-11 22:02:06'),
(10, 'Cashier#4', 'web', 4, 0, 0, '2020-05-11 22:02:06', '2020-05-11 22:02:06'),
(11, 'SuperAdmin#5', 'web', 5, 1, 0, '2020-05-11 23:35:51', '2020-05-11 23:35:51'),
(12, 'Administrador#5', 'web', 5, 0, 0, '2020-05-11 23:35:51', '2020-05-12 10:44:24'),
(13, 'Cajera#5', 'web', 5, 0, 0, '2020-05-14 12:37:57', '2020-05-14 12:37:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 5),
(1, 6),
(2, 5),
(2, 6),
(3, 5),
(6, 5),
(6, 6),
(7, 5),
(7, 6),
(8, 5),
(8, 6),
(8, 12),
(8, 13),
(9, 5),
(9, 6),
(9, 13),
(10, 5),
(10, 6),
(10, 13),
(16, 5),
(16, 6),
(17, 5),
(18, 5),
(18, 6),
(18, 12),
(18, 13),
(19, 5),
(19, 6),
(19, 13),
(20, 5),
(20, 6),
(20, 13),
(21, 5),
(21, 6),
(21, 12),
(21, 13),
(22, 5),
(22, 6),
(23, 5),
(23, 6),
(23, 12),
(23, 13),
(24, 5),
(24, 6),
(29, 5),
(29, 6),
(30, 5),
(30, 6),
(31, 5),
(31, 6),
(32, 5),
(32, 6),
(33, 5),
(33, 12),
(34, 5),
(35, 5),
(36, 5),
(37, 5),
(38, 5),
(39, 5),
(40, 5),
(41, 5),
(41, 6),
(42, 5),
(42, 6),
(43, 5),
(43, 6),
(44, 5),
(44, 6),
(45, 2),
(45, 4),
(45, 5),
(45, 6),
(45, 8),
(45, 10),
(45, 12),
(45, 13),
(46, 2),
(46, 4),
(46, 5),
(46, 6),
(46, 8),
(46, 10),
(46, 12),
(46, 13),
(47, 2),
(47, 4),
(47, 5),
(47, 6),
(47, 8),
(47, 10),
(47, 12),
(48, 2),
(48, 4),
(48, 5),
(48, 6),
(48, 8),
(48, 10),
(48, 12),
(49, 5),
(49, 6),
(50, 5),
(50, 6),
(51, 5),
(51, 6),
(52, 6),
(53, 5),
(53, 6),
(54, 5),
(54, 6),
(55, 5),
(55, 6),
(56, 5),
(56, 6),
(56, 12),
(60, 5),
(60, 6),
(61, 5),
(61, 6),
(62, 5),
(62, 6),
(63, 5),
(63, 6),
(64, 6),
(64, 12),
(65, 6),
(66, 6),
(67, 6),
(68, 5),
(68, 6),
(69, 5),
(69, 6),
(70, 5),
(70, 6),
(71, 5),
(71, 6),
(72, 5),
(72, 6),
(73, 5),
(73, 6),
(74, 5),
(74, 6),
(75, 5),
(75, 6),
(77, 2),
(77, 4),
(77, 8),
(77, 10),
(78, 5),
(78, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `selling_price_groups`
--

CREATE TABLE `selling_price_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `selling_price_groups`
--

INSERT INTO `selling_price_groups` (`id`, `name`, `description`, `business_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Precio1', NULL, 3, NULL, '2020-04-09 13:12:32', '2020-04-09 13:12:32'),
(2, 'Precio2', NULL, 3, NULL, '2020-04-09 13:12:41', '2020-04-09 13:12:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sell_line_warranties`
--

CREATE TABLE `sell_line_warranties` (
  `sell_line_id` int(11) NOT NULL,
  `warranty_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock_adjustments_temp`
--

CREATE TABLE `stock_adjustments_temp` (
  `id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock_adjustment_lines`
--

CREATE TABLE `stock_adjustment_lines` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(22,4) NOT NULL,
  `unit_price` decimal(22,4) DEFAULT NULL COMMENT 'Last purchase unit price',
  `removed_purchase_line` int(11) DEFAULT NULL,
  `lot_no_line_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `stock_adjustment_lines`
--

INSERT INTO `stock_adjustment_lines` (`id`, `transaction_id`, `product_id`, `variation_id`, `quantity`, `unit_price`, `removed_purchase_line`, `lot_no_line_id`, `created_at`, `updated_at`) VALUES
(2, 119, 4, 4, '5.0000', '25.0000', NULL, NULL, '2020-06-17 20:14:22', '2020-06-17 20:14:22'),
(60, 178, 1, 1, '1.0000', '200.0000', NULL, NULL, '2020-06-19 15:07:42', '2020-06-19 15:07:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `package_id` int(10) UNSIGNED NOT NULL,
  `start_date` date DEFAULT NULL,
  `trial_end_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `package_price` decimal(20,2) NOT NULL,
  `package_details` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_id` int(10) UNSIGNED NOT NULL,
  `paid_via` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_transaction_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('approved','waiting','declined') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'waiting',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `business_id`, `package_id`, `start_date`, `trial_end_date`, `end_date`, `package_price`, `package_details`, `created_id`, `paid_via`, `payment_transaction_id`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 2, 1, '2020-06-10', '2020-11-09', '2020-10-10', '2500.00', '{\"location_count\":1,\"user_count\":5,\"product_count\":0,\"invoice_count\":0,\"name\":\"B\\u00e1sico\"}', 1, 'offline', NULL, 'approved', NULL, '2020-06-10 05:36:14', '2020-06-10 05:49:34'),
(2, 5, 1, '2020-06-10', '2020-11-09', '2020-10-10', '2500.00', '{\"location_count\":1,\"user_count\":5,\"product_count\":0,\"invoice_count\":0,\"name\":\"B\\u00e1sico\"}', 1, 'offline', NULL, 'approved', NULL, '2020-06-10 05:49:15', '2020-06-10 05:49:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `superadmin_communicator_logs`
--

CREATE TABLE `superadmin_communicator_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_ids` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `superadmin_frontend_pages`
--

CREATE TABLE `superadmin_frontend_pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_shown` tinyint(1) NOT NULL,
  `menu_order` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `system`
--

CREATE TABLE `system` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `system`
--

INSERT INTO `system` (`id`, `key`, `value`) VALUES
(1, 'db_version', '2.19'),
(2, 'default_business_active_status', '1'),
(3, 'superadmin_version', '1.6'),
(4, 'app_currency_id', '33'),
(5, 'invoice_business_name', 'Spoint'),
(6, 'invoice_business_landmark', 'Calle Eduardo García no. 27'),
(7, 'invoice_business_zip', '56000'),
(8, 'invoice_business_state', 'Espaillat'),
(9, 'invoice_business_city', 'Moca'),
(10, 'invoice_business_country', 'República Dominicana'),
(11, 'email', 'info@dualsoft.com.do'),
(12, 'package_expiry_alert_days', '5'),
(13, 'enable_business_based_username', '0'),
(14, 'superadmin_register_tc', NULL),
(15, 'welcome_email_subject', NULL),
(16, 'welcome_email_body', NULL),
(17, 'superadmin_enable_register_tc', '0'),
(18, 'allow_email_settings_to_businesses', '0'),
(19, 'enable_new_business_registration_notification', '1'),
(20, 'enable_new_subscription_notification', '0'),
(21, 'enable_welcome_email', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `task`
--

CREATE TABLE `task` (
  `idtask` int(11) NOT NULL,
  `task_title` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `start_from` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `task_description` varchar(255) DEFAULT NULL,
  `p_id` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `business_id` int(11) DEFAULT NULL,
  `updated_at` date NOT NULL,
  `created_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `task`
--

INSERT INTO `task` (`idtask`, `task_title`, `category`, `start_from`, `end_date`, `task_description`, `p_id`, `status`, `business_id`, `updated_at`, `created_at`) VALUES
(12, 'asd', 'dasd', '2020-02-02', '2021-02-02', 'dasd', 3, 'En progreso', 1, '2020-06-09', '2020-06-09'),
(13, 'asda', 'dasds', '2020-02-02', '2021-01-02', 'dasd', 3, 'En espera', 1, '2020-06-09', '2020-06-09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tax_rates`
--

CREATE TABLE `tax_rates` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double(22,4) NOT NULL,
  `is_tax_group` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tax_rates`
--

INSERT INTO `tax_rates` (`id`, `business_id`, `name`, `amount`, `is_tax_group`, `created_by`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 5, 'Itbis', 18.0000, 0, 16, NULL, '2020-05-12 10:10:26', '2020-05-12 10:10:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transactions`
--

CREATE TABLE `transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED DEFAULT NULL,
  `res_table_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'fields to restaurant module',
  `res_waiter_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'fields to restaurant module',
  `res_order_status` enum('received','cooked','served') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('received','pending','ordered','draft','final') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_quotation` tinyint(1) NOT NULL DEFAULT 0,
  `payment_status` enum('paid','due','partial') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adjustment_type` enum('normal','abnormal') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` int(11) UNSIGNED DEFAULT NULL,
  `customer_group_id` int(11) DEFAULT NULL COMMENT 'used to add customer group while selling',
  `invoice_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ref_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` datetime NOT NULL,
  `total_before_tax` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'Total before the purchase/invoice tax, this includeds the indivisual product tax',
  `tax_id` int(10) UNSIGNED DEFAULT NULL,
  `tax_amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `discount_type` enum('fixed','percentage') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` decimal(22,4) DEFAULT 0.0000,
  `rp_redeemed` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `rp_redeemed_amount` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'rp is the short form of reward points',
  `shipping_details` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivered_to` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_charges` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `additional_notes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `staff_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `final_total` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `expense_category_id` int(10) UNSIGNED DEFAULT NULL,
  `expense_for` int(10) UNSIGNED DEFAULT NULL,
  `commission_agent` int(11) DEFAULT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_direct_sale` tinyint(1) NOT NULL DEFAULT 0,
  `is_suspend` tinyint(1) NOT NULL DEFAULT 0,
  `exchange_rate` decimal(20,3) NOT NULL DEFAULT 1.000,
  `total_amount_recovered` decimal(22,4) DEFAULT NULL COMMENT 'Used for stock adjustment.',
  `transfer_parent_id` int(11) DEFAULT NULL,
  `return_parent_id` int(11) DEFAULT NULL,
  `opening_stock_product_id` int(11) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `types_of_service_id` int(11) DEFAULT NULL,
  `packing_charge` decimal(22,4) DEFAULT NULL,
  `packing_charge_type` enum('fixed','percent') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_custom_field_1` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_custom_field_2` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_custom_field_3` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_custom_field_4` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_created_from_api` tinyint(1) NOT NULL DEFAULT 0,
  `rp_earned` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `order_addresses` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_recurring` tinyint(1) NOT NULL DEFAULT 0,
  `recur_interval` double(22,4) DEFAULT NULL,
  `recur_interval_type` enum('days','months','years') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recur_repetitions` int(11) DEFAULT NULL,
  `recur_stopped_on` datetime DEFAULT NULL,
  `recur_parent_id` int(11) DEFAULT NULL,
  `invoice_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pay_term_number` int(11) DEFAULT NULL,
  `pay_term_type` enum('days','months') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selling_price_group_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `idncf` int(11) DEFAULT 0,
  `ncf` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `secuencia` int(11) DEFAULT 0,
  `idsecuencia` int(11) DEFAULT 0,
  `vencencf` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `transactions`
--

INSERT INTO `transactions` (`id`, `business_id`, `location_id`, `res_table_id`, `res_waiter_id`, `res_order_status`, `type`, `sub_type`, `status`, `is_quotation`, `payment_status`, `adjustment_type`, `contact_id`, `customer_group_id`, `invoice_no`, `ref_no`, `subscription_no`, `transaction_date`, `total_before_tax`, `tax_id`, `tax_amount`, `discount_type`, `discount_amount`, `rp_redeemed`, `rp_redeemed_amount`, `shipping_details`, `shipping_address`, `shipping_status`, `delivered_to`, `shipping_charges`, `additional_notes`, `staff_note`, `final_total`, `expense_category_id`, `expense_for`, `commission_agent`, `document`, `is_direct_sale`, `is_suspend`, `exchange_rate`, `total_amount_recovered`, `transfer_parent_id`, `return_parent_id`, `opening_stock_product_id`, `created_by`, `types_of_service_id`, `packing_charge`, `packing_charge_type`, `service_custom_field_1`, `service_custom_field_2`, `service_custom_field_3`, `service_custom_field_4`, `is_created_from_api`, `rp_earned`, `order_addresses`, `is_recurring`, `recur_interval`, `recur_interval_type`, `recur_repetitions`, `recur_stopped_on`, `recur_parent_id`, `invoice_token`, `pay_term_number`, `pay_term_type`, `selling_price_group_id`, `created_at`, `updated_at`, `idncf`, `ncf`, `secuencia`, `idsecuencia`, `vencencf`) VALUES
(1, 1, 1, NULL, NULL, NULL, 'opening_stock', NULL, 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, '2020-01-01 16:45:31', '0.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-04 20:45:31', '2020-03-04 20:45:31', 0, '0', 0, 0, NULL),
(3, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'draft', 0, NULL, NULL, 2, NULL, 'ePxJX', '', NULL, '2020-03-04 16:49:00', '0.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, 2, 'months', NULL, '2020-03-04 20:51:09', '2020-03-04 20:51:09', 0, '0', 0, 0, NULL),
(4, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'draft', 0, NULL, NULL, 2, NULL, 'dZawk', '', NULL, '2020-03-04 16:52:00', '0.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, 2, NULL, NULL, '2020-03-04 20:53:15', '2020-03-04 20:53:15', 0, '0', 0, 0, NULL),
(6, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'draft', 1, NULL, NULL, 3, NULL, 'DeZKy', '', NULL, '2020-03-05 12:52:33', '230.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '230.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 4, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2020-03-05 16:52:33', '2020-03-05 16:52:33', 0, '0', 0, 0, NULL),
(9, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 2, NULL, '0001', '', NULL, '2020-03-06 09:17:00', '300.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '300.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, 2, NULL, NULL, '2020-03-06 13:18:29', '2020-03-11 20:43:33', 0, '0', 0, 0, NULL),
(10, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0002', '', NULL, '2020-03-06 09:22:02', '0.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 8, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-06 13:22:02', '2020-03-06 13:22:02', 0, '0', 0, 0, NULL),
(11, 1, 1, NULL, NULL, NULL, 'purchase', NULL, 'received', 0, 'paid', NULL, 5, NULL, NULL, '0001', NULL, '2020-03-06 09:24:00', '5000.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '5000.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-06 13:25:43', '2020-06-08 13:36:10', 0, '0', 0, 0, NULL),
(14, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0004', '', NULL, '2020-03-06 10:04:39', '62.5000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '62.5000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 8, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-06 14:04:39', '2020-03-06 14:04:39', 0, '0', 0, 0, NULL),
(16, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0005', '', NULL, '2020-03-06 10:48:42', '62.5000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '62.5000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2020-03-06 14:48:42', '2020-03-06 14:49:29', 0, '0', 0, 0, NULL),
(17, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 2, NULL, '0006', '', NULL, '2020-03-06 10:50:38', '187.5000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '187.5000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 8, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, 2, 'months', NULL, '2020-03-06 14:50:38', '2020-03-12 00:15:57', 0, '0', 0, 0, NULL),
(19, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0007', '', NULL, '2020-03-06 11:33:06', '62.5000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '62.5000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2020-03-06 15:33:06', '2020-06-03 19:14:56', 0, '0', 0, 0, NULL),
(25, 3, 3, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'partial', NULL, 9, NULL, '0003', '', NULL, '2020-03-11 11:14:00', '6764.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '6764.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 14, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, 15, NULL, NULL, '2020-03-11 15:17:08', '2020-04-15 11:40:14', 0, '0', 0, 0, NULL),
(27, 1, 1, NULL, NULL, NULL, 'opening_balance', NULL, 'final', 0, 'due', NULL, 10, NULL, NULL, '2020/0001', NULL, '2020-03-11 17:45:11', '5000.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '5000.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-11 21:45:11', '2020-03-27 18:44:06', 0, '0', 0, 0, NULL),
(29, 2, 2, NULL, NULL, NULL, 'purchase', NULL, 'received', 0, 'paid', NULL, 4, NULL, NULL, 'OC2020/0002', NULL, '2020-03-18 16:11:00', '2920.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '2920.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-18 20:13:27', '2020-03-18 20:26:23', 0, '0', 0, 0, NULL),
(31, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 3, NULL, '00102', '', NULL, '2020-03-18 16:19:08', '175.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '175.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 3, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2020-03-18 20:19:08', '2020-03-18 20:21:05', 0, '0', 0, 0, NULL),
(32, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 6, NULL, '00103', '', NULL, '2020-03-18 16:22:52', '175.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '175.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 3, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2020-03-18 20:22:52', '2020-03-18 20:22:52', 0, '0', 0, 0, NULL),
(33, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 7, NULL, '00104', '', NULL, '2020-03-18 16:23:30', '175.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '175.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 3, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2020-03-18 20:23:30', '2020-03-18 20:23:30', 0, '0', 0, 0, NULL),
(34, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 3, NULL, '00105', '', NULL, '2020-03-18 16:24:15', '175.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '175.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 3, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2020-03-18 20:24:15', '2020-03-18 20:24:15', 0, '0', 0, 0, NULL),
(35, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 6, NULL, '00106', '', NULL, '2020-03-18 16:24:36', '175.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '175.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 3, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2020-03-18 20:24:36', '2020-03-18 20:24:36', 0, '0', 0, 0, NULL),
(36, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 7, NULL, '00107', '', NULL, '2020-03-18 16:24:48', '175.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '175.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 3, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2020-03-18 20:24:48', '2020-03-18 20:24:48', 0, '0', 0, 0, NULL),
(37, 2, 2, NULL, NULL, NULL, 'purchase', NULL, 'received', 0, 'paid', NULL, 4, NULL, NULL, 'OC2020/0003', NULL, '2020-03-18 16:25:00', '780.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '780.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-18 20:26:08', '2020-03-18 20:26:15', 0, '0', 0, 0, NULL),
(38, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 7, NULL, '00108', '', NULL, '2020-03-20 08:54:00', '35.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '35.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 5, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-20 12:55:05', '2020-03-20 12:56:29', 0, '0', 0, 0, NULL),
(41, 3, 3, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 8, NULL, '0004', '', NULL, '2020-03-31 16:20:35', '3200.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '3200.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 14, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'N6c2CAeoMk9PGKcpPDdcGULOaAKrI5V26TGibYod', NULL, NULL, 0, '2020-03-31 20:20:35', '2020-03-31 20:20:35', 1, 'B010001000000100', 100, 2, NULL),
(42, 3, 3, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 8, NULL, '0005', '', NULL, '2020-04-01 17:42:00', '0.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 14, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'uUYgc7pxF05znkiBeXdA6NO5SgTkDV9XYG8FHVYi', NULL, NULL, NULL, '2020-04-01 21:43:18', '2020-04-01 21:43:18', 1, 'B0100000001', 1, 5, NULL),
(43, 3, 3, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 8, NULL, '0006', '', NULL, '2020-04-15 08:19:00', '3200.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '3200.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 14, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, '1jWgbH1bId0oGHKoXFw1ZTriR0OV3IExZ4T0E7jr', NULL, NULL, NULL, '2020-04-15 12:20:04', '2020-04-15 12:20:04', NULL, '0', 0, 0, NULL),
(45, 3, 3, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 8, NULL, '0007', '', NULL, '2020-04-20 16:31:00', '3200.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '3200.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 14, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'xozSvvaYlOVjtuhLXRXXgOEzdlYx4HRaTeUwMWD5', 30, 'days', NULL, '2020-04-20 20:32:26', '2020-04-20 20:32:26', NULL, '0', 0, 0, NULL),
(46, 3, 3, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'due', NULL, 8, NULL, '0008', '', NULL, '2020-04-20 16:33:00', '3200.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '3200.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 14, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'xozSvvaYlOVjtuhLXRXXgOEzdlYx4HRaTeUwMWD5', 30, 'days', NULL, '2020-04-20 20:34:18', '2020-04-20 20:34:18', NULL, '0', 0, 0, NULL),
(47, 3, 3, NULL, NULL, NULL, 'sell_return', NULL, 'final', 0, 'due', NULL, 8, NULL, 'CN2020/0002', NULL, NULL, '2020-04-20 00:00:00', '3200.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '3200.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, 43, NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-04-20 20:44:26', '2020-04-20 20:44:37', 0, '0', 0, 0, NULL),
(48, 2, 2, NULL, NULL, NULL, 'opening_balance', NULL, 'final', 0, 'partial', NULL, 12, NULL, NULL, '2020/0001', NULL, '2020-04-26 21:33:28', '31520.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '31520.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-04-27 01:33:28', '2020-05-09 12:11:30', 0, '0', 0, 0, NULL),
(49, 2, 2, NULL, NULL, NULL, 'sell_return', NULL, 'final', 0, 'due', NULL, 7, NULL, 'CN2020/0001', NULL, NULL, '2020-05-04 00:00:00', '35.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '35.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, 38, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-04 13:15:29', '2020-05-04 13:15:29', 0, '0', 0, 0, NULL),
(54, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'due', NULL, 13, 2, '00113', '', NULL, '2020-05-06 10:55:00', '722.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '722.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 5, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'EvBJldLVf3Tjrg9MoXOkz5Gg0S0lf5u1zd5DGhKb', 1, 'months', NULL, '2020-05-07 14:57:03', '2020-05-07 14:57:03', NULL, '0', 0, 0, NULL),
(55, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'due', NULL, 13, 2, '00114', '', NULL, '2020-05-07 06:02:00', '760.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '760.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 5, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, 0, NULL, NULL, 'sWU3rLFDuXOdG8tgtehGle7cjOouEtszIfPRMgbf', 1, 'months', NULL, '2020-05-08 10:04:18', '2020-05-09 15:00:45', NULL, NULL, NULL, NULL, NULL),
(56, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'due', NULL, 13, 2, '00115', '', NULL, '2020-05-08 08:10:00', '760.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '760.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 5, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'sWU3rLFDuXOdG8tgtehGle7cjOouEtszIfPRMgbf', 1, 'months', NULL, '2020-05-08 12:11:28', '2020-05-08 12:11:28', NULL, '0', 0, 0, NULL),
(59, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'due', NULL, 13, 2, '00116', '', NULL, '2020-05-11 07:43:00', '684.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '684.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 5, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'lBGs7CEhHaQ96OE4Rt4E7yoEImlPmcZO6hnTs0BO', 1, 'months', NULL, '2020-05-11 11:44:12', '2020-05-11 11:44:12', NULL, '0', 0, 0, NULL),
(63, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'due', NULL, 13, 2, '00118', '', NULL, '2020-05-13 08:01:00', '760.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '760.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 5, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, 0, NULL, NULL, '87hUKD3uwqOIGbIldQNyEZEXUj2iQBMMAKMjSjaN', 1, 'months', NULL, '2020-05-14 12:02:10', '2020-05-14 13:37:23', NULL, NULL, NULL, NULL, NULL),
(64, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'due', NULL, 13, 2, '00119', '', NULL, '2020-05-14 08:03:00', '760.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '760.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 5, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, '87hUKD3uwqOIGbIldQNyEZEXUj2iQBMMAKMjSjaN', 1, 'months', NULL, '2020-05-14 12:05:33', '2020-05-14 12:05:33', NULL, '0', 0, 0, NULL),
(65, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'due', NULL, 13, 2, '00120', '', NULL, '2020-05-18 19:44:00', '608.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '608.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 5, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'HMOEBM4DI2jh4Rsv71FjWWwNfYn7n8n0fnJF66tO', 1, 'months', NULL, '2020-05-18 23:44:55', '2020-05-18 23:44:55', NULL, '0', 0, 0, NULL),
(66, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'due', NULL, 13, 2, '00121', '', NULL, '2020-05-19 09:01:00', '760.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '760.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 5, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'uGxQXG2mx28593oV0xlvtz3wZaiw98yICzDByZD6', 1, 'months', NULL, '2020-05-19 13:01:53', '2020-05-19 13:01:53', NULL, '0', 0, 0, NULL),
(67, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'due', NULL, 13, 2, '00122', '', NULL, '2020-05-20 07:46:00', '760.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '760.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 5, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'jtMUd1eqojoE26vjVXR0huCO43jF5otc1wvmghil', 1, 'months', NULL, '2020-05-20 11:47:41', '2020-05-20 11:47:41', NULL, '0', 0, 0, NULL),
(71, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0021', '', NULL, '2020-05-25 12:25:00', '0.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'F1mohBpmHdwJnU98LCSZs5bD6HT4DLJLIgOPKBRd', NULL, NULL, NULL, '2020-05-25 16:25:27', '2020-05-25 16:25:27', NULL, '0', 0, 0, '0000-00-00'),
(72, 1, 1, NULL, NULL, NULL, 'opening_stock', NULL, 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, '2020-01-01 11:35:09', '1000.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '1000.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, 23, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-28 15:35:09', '2020-05-28 15:35:09', 0, '0', 0, 0, NULL),
(73, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0022', '', NULL, '2020-05-29 10:08:00', '62.5000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '62.5000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'Aj4Xjz8R8IEJm2dGweSLPtjNmQksCys6GOc0q046', NULL, NULL, 0, '2020-05-29 14:08:00', '2020-05-29 14:08:00', NULL, '0', 0, 0, NULL),
(74, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0023', '', NULL, '2020-05-29 10:58:33', '2000.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '2000.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'Aj4Xjz8R8IEJm2dGweSLPtjNmQksCys6GOc0q046', NULL, NULL, 0, '2020-05-29 14:58:33', '2020-05-29 14:58:33', NULL, '0', 0, 0, NULL),
(75, 2, 2, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 3, NULL, '00123', '', NULL, '2020-06-02 11:16:48', '35.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '35.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 3, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'Z4D83jXbUTCYXtNQ7g3shJM1WyiMcHjZJ0PkitIS', NULL, NULL, 0, '2020-06-02 15:16:48', '2020-06-02 15:16:48', NULL, '0', 0, 0, NULL),
(76, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0024', '', NULL, '2020-06-02 16:56:39', '125.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '125.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'vc96biDcULcoryaB73dHfYtMGoh0pWHyKJImBgGw', NULL, NULL, 0, '2020-06-02 20:56:39', '2020-06-08 13:40:02', NULL, '0', 0, 0, NULL),
(77, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0025', '', NULL, '2020-06-02 16:57:05', '125.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '125.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'vc96biDcULcoryaB73dHfYtMGoh0pWHyKJImBgGw', NULL, NULL, 0, '2020-06-02 20:57:05', '2020-06-08 13:40:02', 1, 'B0100000005', 5, 1, '2021-02-02'),
(78, 1, 1, NULL, NULL, NULL, 'opening_stock', NULL, 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, '2020-01-01 15:10:14', '7875.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '7875.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, 24, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-03 19:10:14', '2020-06-03 19:10:14', 0, '0', 0, 0, NULL),
(79, 1, 1, NULL, NULL, NULL, 'purchase', NULL, 'received', 0, 'paid', NULL, 18, NULL, NULL, '0001', NULL, '2020-06-03 15:11:00', '0.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-03 19:13:35', '2020-06-03 19:13:35', 0, '0', 0, 0, NULL),
(80, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0026', '', NULL, '2020-06-03 15:15:00', '600.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '600.0000', NULL, NULL, 1, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, '0vFzEwidhDcLgiJIzhGDUR0uA4BdOdtj5X1EqShl', NULL, NULL, NULL, '2020-06-03 19:17:28', '2020-06-08 13:39:24', 1, 'B0100000006', 6, 1, '2021-02-02'),
(81, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0027', '', NULL, '2020-06-03 15:19:32', '1500.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', 'venta suspendida', NULL, '1500.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, '0vFzEwidhDcLgiJIzhGDUR0uA4BdOdtj5X1EqShl', NULL, NULL, NULL, '2020-06-03 19:19:32', '2020-06-03 19:20:40', NULL, NULL, NULL, NULL, NULL),
(82, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0028', '', NULL, '2020-06-08 09:27:52', '150.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', 'para facturar luego', NULL, '150.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'RsqJntScWJmSGnMphHWClP42PXpZoOMXx1KhVOtP', NULL, NULL, NULL, '2020-06-08 13:27:52', '2020-06-08 13:29:20', NULL, NULL, NULL, NULL, NULL),
(83, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0029', '', NULL, '2020-06-08 09:30:28', '0.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'RsqJntScWJmSGnMphHWClP42PXpZoOMXx1KhVOtP', NULL, NULL, 0, '2020-06-08 13:30:28', '2020-06-08 13:30:28', NULL, '0', 0, 0, NULL),
(84, 1, 1, NULL, NULL, NULL, 'purchase', NULL, 'pending', 0, 'paid', NULL, 18, NULL, NULL, 'PO2020/0003', NULL, '2020-06-08 09:33:00', '0.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-08 13:35:14', '2020-06-08 13:35:14', 0, '0', 0, 0, NULL),
(85, 1, 1, NULL, NULL, NULL, 'expense', NULL, 'final', 0, 'due', NULL, NULL, NULL, NULL, 'EP2020/0001', NULL, '2020-06-08 09:41:00', '5000.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', 'ejemplo de gastos', NULL, '5000.0000', NULL, 1, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-08 13:42:18', '2020-06-08 13:42:18', 0, '0', 0, 0, NULL),
(86, 1, 1, NULL, NULL, NULL, 'opening_stock', NULL, 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, '2020-01-01 09:50:30', '20000.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '20000.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, 27, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-08 13:50:30', '2020-06-08 13:50:30', 0, '0', 0, 0, NULL),
(87, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0030', '', NULL, '2020-06-12 13:06:00', '200.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '200.0000', NULL, NULL, 1, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'UJQ0Y5OfuerIjhrIkDxt3Q07dNxFbBwRqOQLmuLs', NULL, NULL, NULL, '2020-06-12 17:06:53', '2020-06-12 17:06:53', 1, 'B0100000007', 7, 1, '2021-02-02'),
(88, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0031', '', NULL, '2020-06-12 13:08:00', '62.5000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '62.5000', NULL, NULL, 1, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'UJQ0Y5OfuerIjhrIkDxt3Q07dNxFbBwRqOQLmuLs', NULL, NULL, NULL, '2020-06-12 17:08:18', '2020-06-12 17:08:18', 1, 'B0100000008', 8, 1, '2021-02-02'),
(89, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0032', '', NULL, '2020-06-12 13:08:00', '100.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '100.0000', NULL, NULL, 1, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'UJQ0Y5OfuerIjhrIkDxt3Q07dNxFbBwRqOQLmuLs', NULL, NULL, NULL, '2020-06-12 17:09:07', '2020-06-12 17:09:07', NULL, '0', 0, 0, '0000-00-00'),
(90, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0033', '', NULL, '2020-06-12 13:09:00', '400.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '400.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'UJQ0Y5OfuerIjhrIkDxt3Q07dNxFbBwRqOQLmuLs', NULL, NULL, NULL, '2020-06-12 17:10:10', '2020-06-12 17:10:10', NULL, '0', 0, 0, '0000-00-00'),
(91, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0034', '', NULL, '2020-06-12 13:11:00', '400.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '400.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'UJQ0Y5OfuerIjhrIkDxt3Q07dNxFbBwRqOQLmuLs', NULL, NULL, NULL, '2020-06-12 17:11:36', '2020-06-12 17:11:36', NULL, '0', 0, 0, '0000-00-00'),
(92, 1, 1, NULL, NULL, NULL, 'expense', NULL, 'final', 0, 'due', NULL, NULL, NULL, NULL, '009', NULL, '2020-06-12 13:12:00', '250.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', 'ninguno', NULL, '250.0000', NULL, 1, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 17:12:34', '2020-06-12 17:12:34', 0, '0', 0, 0, NULL),
(93, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0035', '', NULL, '2020-06-12 13:14:05', '2500.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '2500.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'UJQ0Y5OfuerIjhrIkDxt3Q07dNxFbBwRqOQLmuLs', NULL, NULL, 0, '2020-06-12 17:14:05', '2020-06-12 17:14:05', NULL, '0', 0, 0, NULL),
(94, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0036', '', NULL, '2020-06-12 13:21:00', '2500.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '2500.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'UJQ0Y5OfuerIjhrIkDxt3Q07dNxFbBwRqOQLmuLs', NULL, NULL, NULL, '2020-06-12 17:23:07', '2020-06-12 17:23:07', NULL, '0', 0, 0, '0000-00-00'),
(95, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'due', NULL, 1, NULL, '0037', '', NULL, '2020-06-12 13:26:29', '281.2500', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '281.2500', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'UJQ0Y5OfuerIjhrIkDxt3Q07dNxFbBwRqOQLmuLs', NULL, NULL, 0, '2020-06-12 17:26:29', '2020-06-12 17:26:29', NULL, '0', 0, 0, NULL),
(96, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0038', '', NULL, '2020-06-12 13:54:00', '2500.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '2500.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'UJQ0Y5OfuerIjhrIkDxt3Q07dNxFbBwRqOQLmuLs', NULL, NULL, NULL, '2020-06-12 17:54:57', '2020-06-12 17:54:57', 1, 'B0100000009', 9, 1, '2021-02-02'),
(97, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0039', '', NULL, '2020-06-12 14:24:21', '2000.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '2000.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'UJQ0Y5OfuerIjhrIkDxt3Q07dNxFbBwRqOQLmuLs', NULL, NULL, 0, '2020-06-12 18:24:21', '2020-06-12 18:24:21', NULL, '0', 0, 0, NULL),
(98, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'due', NULL, 1, NULL, '0040', '', NULL, '2020-06-12 14:25:38', '2500.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '2500.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'UJQ0Y5OfuerIjhrIkDxt3Q07dNxFbBwRqOQLmuLs', NULL, NULL, 0, '2020-06-12 18:25:38', '2020-06-12 18:25:38', NULL, '0', 0, 0, NULL),
(99, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'due', NULL, 1, NULL, '0041', '', NULL, '2020-06-12 14:26:18', '2500.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '2500.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'UJQ0Y5OfuerIjhrIkDxt3Q07dNxFbBwRqOQLmuLs', NULL, NULL, 0, '2020-06-12 18:26:18', '2020-06-12 18:26:18', 1, 'B0100000010', 10, 1, '2021-02-02'),
(100, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'due', NULL, 1, NULL, '0042', '', NULL, '2020-06-12 14:27:53', '2500.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '2500.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'UJQ0Y5OfuerIjhrIkDxt3Q07dNxFbBwRqOQLmuLs', NULL, NULL, 0, '2020-06-12 18:27:53', '2020-06-12 18:27:53', NULL, '0', 0, 0, NULL),
(101, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0043', '', NULL, '2020-06-12 14:28:00', '100.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '100.0000', NULL, NULL, 1, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'UJQ0Y5OfuerIjhrIkDxt3Q07dNxFbBwRqOQLmuLs', NULL, NULL, NULL, '2020-06-12 18:28:43', '2020-06-12 18:28:43', NULL, '0', 0, 0, '0000-00-00'),
(102, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0044', '', NULL, '2020-06-12 15:08:20', '100.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '100.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'UJQ0Y5OfuerIjhrIkDxt3Q07dNxFbBwRqOQLmuLs', NULL, NULL, 0, '2020-06-12 19:08:20', '2020-06-12 19:08:20', NULL, '0', 0, 0, NULL),
(103, 1, 1, NULL, NULL, NULL, 'expense', NULL, 'final', 0, 'due', NULL, NULL, NULL, NULL, 'nin', NULL, '2020-06-12 15:32:00', '500.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', 'no', NULL, '500.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 19:33:09', '2020-06-12 19:33:09', 0, '0', 0, 0, NULL),
(104, 1, 1, NULL, NULL, NULL, 'expense', NULL, 'final', 0, 'due', NULL, NULL, NULL, NULL, '0002', NULL, '2020-06-12 15:44:00', '500.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', 'asd', NULL, '500.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 19:44:57', '2020-06-12 19:44:57', 0, '0', 0, 0, NULL),
(105, 1, 1, NULL, NULL, NULL, 'expense', NULL, 'final', 0, 'due', NULL, NULL, NULL, NULL, '768', NULL, '2020-06-12 16:20:10', '2000.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', 'nin', NULL, '2000.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 20:20:32', '2020-06-12 20:20:32', 0, '0', 0, 0, NULL),
(106, 1, 1, NULL, NULL, NULL, 'expense', NULL, 'final', 0, 'due', NULL, NULL, NULL, NULL, '020', NULL, '2020-06-12 16:47:00', '100.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', 'fd', NULL, '100.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 20:47:33', '2020-06-12 20:47:33', 0, '0', 0, 0, NULL),
(107, 1, 1, NULL, NULL, NULL, 'expense', NULL, 'final', 0, 'due', NULL, NULL, NULL, NULL, 'EP2020/0007', NULL, '2020-06-15 09:20:00', '200.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', 'nin', NULL, '200.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-15 13:20:53', '2020-06-15 13:20:53', 0, '0', 0, 0, NULL),
(108, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0045', '', NULL, '2020-06-15 14:43:42', '400.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '400.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'YlEstzvPGJ71hs9jJqSk1VSzN3tE1QPvOJTEdbFE', NULL, NULL, 0, '2020-06-15 18:43:42', '2020-06-15 18:43:42', NULL, '0', 0, 0, NULL),
(109, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0046', '', NULL, '2020-06-15 14:50:08', '400.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '400.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'YlEstzvPGJ71hs9jJqSk1VSzN3tE1QPvOJTEdbFE', NULL, NULL, 0, '2020-06-15 18:50:08', '2020-06-15 18:52:18', NULL, '0', 0, 0, NULL),
(110, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'partial', NULL, 1, NULL, '0047', '', NULL, '2020-06-15 15:07:43', '2500.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '2500.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'YlEstzvPGJ71hs9jJqSk1VSzN3tE1QPvOJTEdbFE', NULL, NULL, 0, '2020-06-15 19:07:43', '2020-06-15 19:08:20', NULL, '0', 0, 0, NULL),
(111, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0048', '', NULL, '2020-06-15 15:24:20', '281.2500', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '281.2500', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'YlEstzvPGJ71hs9jJqSk1VSzN3tE1QPvOJTEdbFE', NULL, NULL, 0, '2020-06-15 19:24:20', '2020-06-15 19:24:20', NULL, '0', 0, 0, NULL),
(112, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0049', '', NULL, '2020-06-15 15:30:56', '281.2500', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '281.2500', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'YlEstzvPGJ71hs9jJqSk1VSzN3tE1QPvOJTEdbFE', NULL, NULL, 0, '2020-06-15 19:30:56', '2020-06-15 19:30:56', NULL, '0', 0, 0, NULL),
(113, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0050', '', NULL, '2020-06-15 15:31:26', '281.2500', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '281.2500', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'YlEstzvPGJ71hs9jJqSk1VSzN3tE1QPvOJTEdbFE', NULL, NULL, 0, '2020-06-15 19:31:26', '2020-06-15 19:49:39', NULL, '0', 0, 0, NULL),
(114, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0051', '', NULL, '2020-06-15 15:56:06', '100.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '100.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'YlEstzvPGJ71hs9jJqSk1VSzN3tE1QPvOJTEdbFE', NULL, NULL, 0, '2020-06-15 19:56:06', '2020-06-15 19:56:06', NULL, '0', 0, 0, NULL),
(115, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0052', '', NULL, '2020-06-15 15:56:16', '100.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '100.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'YlEstzvPGJ71hs9jJqSk1VSzN3tE1QPvOJTEdbFE', NULL, NULL, 0, '2020-06-15 19:56:16', '2020-06-15 19:56:16', NULL, '0', 0, 0, NULL),
(116, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'partial', NULL, 1, NULL, '0053', '', NULL, '2020-06-15 15:58:23', '50.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '50.0000', NULL, NULL, 1, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'YlEstzvPGJ71hs9jJqSk1VSzN3tE1QPvOJTEdbFE', NULL, NULL, 0, '2020-06-15 19:58:23', '2020-06-15 20:01:24', NULL, '0', 0, 0, NULL),
(117, 1, 1, NULL, NULL, NULL, 'expense', NULL, 'final', 0, 'due', NULL, NULL, NULL, NULL, '232', NULL, '2020-06-15 16:04:00', '100.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '100.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-15 20:04:28', '2020-06-15 20:04:28', 0, '0', 0, 0, NULL),
(119, 2, 2, NULL, NULL, NULL, 'stock_adjustment', NULL, 'received', 0, NULL, 'normal', NULL, NULL, NULL, '001', NULL, '2020-06-17 16:13:00', '0.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '125.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', '0.0000', NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-17 20:14:22', '2020-06-17 20:14:22', 0, '0', 0, 0, NULL),
(130, 2, 2, NULL, NULL, NULL, 'opening_stock', NULL, 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, '2020-01-01 11:12:17', '672.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '672.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, 6, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-18 15:12:17', '2020-06-18 16:22:12', 0, '0', 0, 0, NULL),
(178, 1, 1, NULL, NULL, NULL, 'stock_adjustment', NULL, 'received', 0, NULL, 'normal', NULL, NULL, NULL, 'SA2020/0001', NULL, '2020-06-19 11:07:00', '0.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '200.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', '0.0000', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-19 15:07:42', '2020-06-19 15:07:42', 0, '0', 0, 0, NULL),
(182, 1, 1, NULL, NULL, NULL, 'opening_stock', NULL, 'received', 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, '2020-01-01 13:43:22', '236.0000', NULL, '0.0000', NULL, '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '236.0000', NULL, NULL, NULL, NULL, 0, 0, '1.000', NULL, NULL, NULL, 18, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-19 17:43:22', '2020-06-19 17:43:22', 0, '0', 0, 0, NULL),
(183, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0054', '', NULL, '2020-06-19 16:31:00', '187.5000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '187.5000', NULL, NULL, 1, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'fhSJyNfp3RNKtnEXujSpuM8Vb8JA1WVAbsnEgH3K', NULL, NULL, NULL, '2020-06-19 20:32:10', '2020-06-19 20:32:10', NULL, '0', 0, 0, '0000-00-00'),
(184, 1, 1, NULL, NULL, NULL, 'sell', NULL, 'final', 0, 'paid', NULL, 1, NULL, '0055', '', NULL, '2020-06-19 16:33:00', '125.0000', NULL, '0.0000', 'percentage', '0.0000', 0, '0.0000', NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, '125.0000', NULL, NULL, 1, NULL, 1, 0, '1.000', NULL, NULL, NULL, NULL, 1, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'days', 0, NULL, NULL, 'fhSJyNfp3RNKtnEXujSpuM8Vb8JA1WVAbsnEgH3K', NULL, NULL, NULL, '2020-06-19 20:33:59', '2020-06-19 20:33:59', NULL, '0', 0, 0, NULL);

--
-- Disparadores `transactions`
--
DELIMITER $$
CREATE TRIGGER `generancf` AFTER INSERT ON `transactions` FOR EACH ROW BEGIN
  DECLARE registros1 INT;

    DECLARE contador1 INT default 0;
        DECLARE hasta1 INT DEFAULT 0;

    DECLARE a INT;
       DECLARE secuencias INT DEFAULT 0;
 DECLARE secuenciasuma INT DEFAULT 0;
    DECLARE usado int default 0;
    declare usadosuma int default 0;
    SET a=1;
    
insert into detallencf(secuencia,iddocumento,IDsecuenciaNCF) values(new.secuencia,new.id,new.idsecuencia);

  SELECT max(secuencia) 
    INTO secuencias
    FROM ncf_secuencia WHERE idncf=new.idncf and business_id=new.business_id;
    SET contador1=(SELECT secuencia FROM ncf_secuencia WHERE status=2 and idncf=new.idncf and idncfsecuencia=new.idsecuencia and business_id=new.business_id);
        SET hasta1=(SELECT hasta FROM ncf_secuencia WHERE status=2 and idncfsecuencia=new.idsecuencia and idncf=new.idncf and business_id=new.business_id);

    SET secuenciasuma=secuencias+1;
     SELECT max(Usados) 
    INTO usado
    FROM ncf_secuencia WHERE idncf=new.idncf and status=2 and idncfsecuencia=new.idsecuencia and business_id=new.business_id;
    SET usadosuma=usado+1;
        update ncf_secuencia set usados=usadosuma where  idncf=new.idncf and idncfsecuencia=new.idsecuencia and business_id=new.business_id;
        
      

  
        
	if contador1>=hasta1
	then
	        UPDATE ncf_secuencia SET status=0 WHERE status=2 AND idncfsecuencia = new.idsecuencia and business_id=new.business_id;
     ELSE       
          UPDATE ncf_secuencia SET secuencia=contador1+1 where status=2 and idncf=new.idncf and idncfsecuencia=new.idsecuencia and business_id=new.business_id;
end if;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transaction_payments`
--

CREATE TABLE `transaction_payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(11) UNSIGNED DEFAULT NULL,
  `business_id` int(11) DEFAULT NULL,
  `is_return` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Used during sales to return the change',
  `amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `method` enum('cash','card','cheque','bank_transfer','custom_pay_1','custom_pay_2','custom_pay_3','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_transaction_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_holder_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_security` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cheque_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_on` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `payment_for` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_ref_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type_cont` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `transaction_payments`
--

INSERT INTO `transaction_payments` (`id`, `transaction_id`, `business_id`, `is_return`, `amount`, `method`, `transaction_no`, `card_transaction_number`, `card_number`, `card_type`, `card_holder_name`, `card_month`, `card_year`, `card_security`, `cheque_number`, `bank_account_number`, `paid_on`, `created_by`, `payment_for`, `parent_id`, `note`, `document`, `payment_ref_no`, `account_id`, `created_at`, `updated_at`, `type_cont`) VALUES
(3, 14, 1, 0, '62.5000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-06 10:04:39', 8, 1, NULL, NULL, NULL, 'SP2020/0002', NULL, '2020-03-06 14:04:39', '2020-03-06 14:04:39', NULL),
(5, NULL, 2, 0, '585.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-06 10:20:00', 5, 3, NULL, NULL, NULL, 'PV2020/0003', NULL, '2020-03-06 14:20:51', '2020-03-06 14:20:51', NULL),
(9, 16, 1, 0, '62.5000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-06 10:49:00', 1, 1, NULL, NULL, NULL, 'SP2020/0003', NULL, '2020-03-06 14:49:29', '2020-03-06 14:49:29', NULL),
(16, 9, 1, 0, '300.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-11 16:43:33', 1, 2, NULL, NULL, NULL, 'SP2020/0007', NULL, '2020-03-11 20:43:33', '2020-03-11 20:43:33', NULL),
(17, 17, 1, 0, '187.5000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-11 20:15:57', 1, 2, NULL, NULL, NULL, 'SP2020/0008', NULL, '2020-03-12 00:15:57', '2020-03-12 00:15:57', NULL),
(19, 31, 2, 0, '175.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-18 16:21:00', 3, 3, NULL, NULL, NULL, 'PV2020/0010', NULL, '2020-03-18 20:21:05', '2020-03-18 20:21:05', NULL),
(20, 32, 2, 0, '175.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-18 16:22:52', 3, 6, NULL, NULL, NULL, 'PV2020/0011', NULL, '2020-03-18 20:22:52', '2020-03-18 20:22:52', NULL),
(21, 33, 2, 0, '175.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-18 16:23:30', 3, 7, NULL, NULL, NULL, 'PV2020/0012', NULL, '2020-03-18 20:23:30', '2020-03-18 20:23:30', NULL),
(22, 34, 2, 0, '175.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-18 16:24:15', 3, 3, NULL, NULL, NULL, 'PV2020/0013', NULL, '2020-03-18 20:24:15', '2020-03-18 20:24:15', NULL),
(23, 35, 2, 0, '175.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-18 16:24:36', 3, 6, NULL, NULL, NULL, 'PV2020/0014', NULL, '2020-03-18 20:24:36', '2020-03-18 20:24:36', NULL),
(24, 36, 2, 0, '175.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-18 16:24:48', 3, 7, NULL, NULL, NULL, 'PV2020/0015', NULL, '2020-03-18 20:24:48', '2020-03-18 20:24:48', NULL),
(25, 37, 2, 0, '780.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-18 16:26:00', 3, 4, NULL, NULL, NULL, 'PC2020/0001', NULL, '2020-03-18 20:26:15', '2020-03-18 20:26:15', NULL),
(26, 29, 2, 0, '2920.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-18 16:26:00', 3, 4, NULL, NULL, NULL, 'PC2020/0002', NULL, '2020-03-18 20:26:23', '2020-03-18 20:26:23', NULL),
(27, 38, 2, 0, '35.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-20 08:56:29', 5, 7, NULL, NULL, NULL, 'PV2020/0016', NULL, '2020-03-20 12:56:29', '2020-03-20 12:56:29', NULL),
(29, 41, 3, 0, '3200.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-31 16:20:35', 14, 8, NULL, NULL, NULL, 'SP2020/0002', NULL, '2020-03-31 20:20:35', '2020-03-31 20:20:35', NULL),
(30, 25, 3, 0, '3764.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-04-15 07:39:00', 14, 9, NULL, NULL, NULL, 'SP2020/0003', NULL, '2020-04-15 11:40:14', '2020-04-15 11:40:14', NULL),
(31, 43, 3, 0, '3200.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-04-15 08:20:04', 14, 8, NULL, NULL, NULL, 'SP2020/0004', NULL, '2020-04-15 12:20:04', '2020-04-15 12:20:04', NULL),
(32, 45, 3, 0, '3200.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-04-20 16:32:26', 14, 8, NULL, NULL, NULL, 'SP2020/0005', NULL, '2020-04-20 20:32:26', '2020-04-20 20:32:26', NULL),
(35, NULL, 2, 0, '10000.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-09 08:11:00', 5, 12, NULL, NULL, NULL, 'PV2020/0019', NULL, '2020-05-09 12:11:29', '2020-05-09 12:11:29', NULL),
(36, 48, 2, 0, '10000.0000', 'cash', 'cash', NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-09 08:11:00', 5, 12, 35, NULL, NULL, 'PC2020/0003', NULL, '2020-05-09 12:11:30', '2020-05-09 12:11:30', NULL),
(37, 73, 1, 0, '62.5000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-29 10:08:00', 1, 1, NULL, NULL, NULL, 'SP2020/0010', NULL, '2020-05-29 14:08:00', '2020-05-29 14:08:00', NULL),
(38, 74, 1, 0, '2000.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-29 10:58:33', 1, 1, NULL, NULL, NULL, 'SP2020/0011', NULL, '2020-05-29 14:58:33', '2020-05-29 14:58:33', NULL),
(39, 75, 2, 0, '35.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-02 11:16:48', 3, 3, NULL, NULL, NULL, 'PV2020/0020', NULL, '2020-06-02 15:16:48', '2020-06-02 15:16:48', NULL),
(42, 79, 1, 0, '5000.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-03 15:13:35', 1, 18, NULL, NULL, NULL, 'PP2020/0001', NULL, '2020-06-03 19:13:35', '2020-06-03 19:13:35', NULL),
(43, 19, 1, 0, '62.5000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-03 15:14:00', 1, 1, NULL, NULL, NULL, 'SP2020/0014', NULL, '2020-06-03 19:14:56', '2020-06-03 19:14:56', NULL),
(45, 81, 1, 0, '200.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-03 15:20:40', 1, 1, NULL, NULL, NULL, 'SP2020/0016', NULL, '2020-06-03 19:20:40', '2020-06-03 19:20:40', NULL),
(46, 81, 1, 0, '1300.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-03 15:20:40', 1, 1, NULL, NULL, NULL, 'SP2020/0017', NULL, '2020-06-03 19:20:40', '2020-06-03 19:20:40', NULL),
(47, 82, 1, 0, '200.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-08 09:29:20', 1, 1, NULL, NULL, NULL, 'SP2020/0018', NULL, '2020-06-08 13:29:20', '2020-06-08 13:29:20', NULL),
(48, 82, 1, 0, '-50.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-08 09:29:20', 1, 1, NULL, NULL, NULL, 'SP2020/0019', NULL, '2020-06-08 13:29:20', '2020-06-08 13:29:20', NULL),
(49, 84, 1, 0, '500.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-08 09:35:14', 1, 18, NULL, NULL, NULL, 'PP2020/0002', NULL, '2020-06-08 13:35:14', '2020-06-08 13:35:14', NULL),
(50, 11, 1, 0, '5000.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-08 09:36:00', 1, 5, NULL, NULL, NULL, 'PP2020/0003', NULL, '2020-06-08 13:36:10', '2020-06-08 13:36:10', NULL),
(51, 80, 1, 0, '600.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-08 09:39:00', 1, 1, NULL, NULL, NULL, 'SP2020/0020', NULL, '2020-06-08 13:39:24', '2020-06-08 13:39:24', NULL),
(52, 76, 1, 0, '125.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-08 09:40:02', 1, 1, NULL, NULL, NULL, 'SP2020/0021', NULL, '2020-06-08 13:40:02', '2020-06-08 13:40:02', NULL),
(53, 77, 1, 0, '125.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-08 09:40:02', 1, 1, NULL, NULL, NULL, 'SP2020/0022', NULL, '2020-06-08 13:40:02', '2020-06-08 13:40:02', NULL),
(54, 87, 1, 0, '200.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 13:06:53', 1, 1, NULL, NULL, NULL, 'SP2020/0023', NULL, '2020-06-12 17:06:53', '2020-06-12 17:06:53', NULL),
(55, 88, 1, 0, '62.5000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 13:08:18', 1, 1, NULL, NULL, NULL, 'SP2020/0024', NULL, '2020-06-12 17:08:18', '2020-06-12 17:08:18', NULL),
(56, 89, 1, 0, '100.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 13:09:07', 1, 1, NULL, NULL, NULL, 'SP2020/0025', NULL, '2020-06-12 17:09:07', '2020-06-12 17:09:07', NULL),
(57, 90, 1, 0, '400.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 13:10:10', 1, 1, NULL, NULL, NULL, 'SP2020/0026', NULL, '2020-06-12 17:10:10', '2020-06-12 17:10:10', NULL),
(58, 91, 1, 0, '400.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 13:11:36', 1, 1, NULL, NULL, NULL, 'SP2020/0027', NULL, '2020-06-12 17:11:36', '2020-06-12 17:11:36', NULL),
(59, 93, 1, 0, '2500.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 13:14:05', 1, 1, NULL, NULL, NULL, 'SP2020/0028', NULL, '2020-06-12 17:14:05', '2020-06-12 17:14:05', NULL),
(60, 94, 1, 0, '2500.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 13:23:07', 1, 1, NULL, NULL, NULL, 'SP2020/0029', NULL, '2020-06-12 17:23:07', '2020-06-12 17:23:07', NULL),
(61, 96, 1, 0, '2500.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 13:54:57', 1, 1, NULL, NULL, NULL, 'SP2020/0030', NULL, '2020-06-12 17:54:57', '2020-06-12 17:54:57', NULL),
(62, 97, 1, 0, '2000.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 14:24:21', 1, 1, NULL, NULL, NULL, 'SP2020/0031', NULL, '2020-06-12 18:24:21', '2020-06-12 18:24:21', NULL),
(63, 101, 1, 0, '100.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 14:28:43', 1, 1, NULL, NULL, NULL, 'SP2020/0032', NULL, '2020-06-12 18:28:43', '2020-06-12 18:28:43', NULL),
(64, 102, 1, 0, '100.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-12 15:08:20', 1, 1, NULL, NULL, NULL, 'SP2020/0033', NULL, '2020-06-12 19:08:20', '2020-06-12 19:08:20', NULL),
(65, 108, 1, 0, '400.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-15 14:43:42', 1, 1, NULL, NULL, NULL, 'SP2020/0034', NULL, '2020-06-15 18:43:42', '2020-06-15 18:43:42', NULL),
(66, 109, 1, 0, '100.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-15 14:50:00', 1, 1, NULL, NULL, NULL, 'SP2020/0035', NULL, '2020-06-15 18:50:58', '2020-06-15 18:50:58', NULL),
(67, 109, 1, 0, '300.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-15 14:52:00', 1, 1, NULL, NULL, NULL, 'SP2020/0036', NULL, '2020-06-15 18:52:18', '2020-06-15 18:52:18', NULL),
(68, 110, 1, 0, '100.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-15 15:08:00', 1, 1, NULL, NULL, NULL, 'SP2020/0037', NULL, '2020-06-15 19:08:20', '2020-06-15 19:08:20', NULL),
(69, 111, 1, 0, '281.2500', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-15 15:24:20', 1, 1, NULL, NULL, NULL, 'SP2020/0038', NULL, '2020-06-15 19:24:20', '2020-06-15 19:24:20', NULL),
(70, 112, 1, 0, '281.2500', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-15 15:30:56', 1, 1, NULL, NULL, NULL, 'SP2020/0039', NULL, '2020-06-15 19:30:56', '2020-06-15 19:30:56', NULL),
(71, 113, 1, 0, '150.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-15 15:31:00', 1, 1, NULL, NULL, NULL, 'SP2020/0040', NULL, '2020-06-15 19:32:04', '2020-06-15 19:32:04', 'pago'),
(72, 113, 1, 0, '131.2500', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-15 15:49:00', 1, 1, NULL, NULL, NULL, 'SP2020/0041', NULL, '2020-06-15 19:49:39', '2020-06-15 19:49:39', 'pago'),
(73, 114, 1, 0, '100.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-15 15:56:06', 1, 1, NULL, NULL, NULL, 'SP2020/0042', NULL, '2020-06-15 19:56:06', '2020-06-15 19:56:06', NULL),
(74, 115, 1, 0, '100.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-15 15:56:16', 1, 1, NULL, NULL, NULL, 'SP2020/0043', NULL, '2020-06-15 19:56:16', '2020-06-15 19:56:16', NULL),
(75, 116, 1, 0, '25.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-15 16:01:00', 1, 1, NULL, NULL, NULL, 'SP2020/0044', NULL, '2020-06-15 20:01:24', '2020-06-15 20:01:24', 'pago'),
(76, 183, 1, 0, '187.5000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-19 16:32:10', 1, 1, NULL, NULL, NULL, 'SP2020/0045', NULL, '2020-06-19 20:32:10', '2020-06-19 20:32:10', NULL),
(77, 184, 1, 0, '125.0000', 'cash', NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2020-06-19 16:33:59', 1, 1, NULL, NULL, NULL, 'SP2020/0046', NULL, '2020-06-19 20:33:59', '2020-06-19 20:33:59', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transaction_sell_lines`
--

CREATE TABLE `transaction_sell_lines` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `quantity_returned` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `unit_price_before_discount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `unit_price` decimal(22,4) DEFAULT NULL COMMENT 'Sell price excluding tax',
  `line_discount_type` enum('fixed','percentage') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_discount_amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `unit_price_inc_tax` decimal(22,4) DEFAULT NULL COMMENT 'Sell price including tax',
  `item_tax` decimal(22,4) NOT NULL COMMENT 'Tax for one quantity',
  `tax_id` int(10) UNSIGNED DEFAULT NULL,
  `discount_id` int(11) DEFAULT NULL,
  `lot_no_line_id` int(11) DEFAULT NULL,
  `sell_line_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `res_service_staff_id` int(11) DEFAULT NULL,
  `res_line_order_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_sell_line_id` int(11) DEFAULT NULL,
  `children_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Type of children for the parent, like modifier or combo',
  `sub_unit_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `transaction_sell_lines`
--

INSERT INTO `transaction_sell_lines` (`id`, `transaction_id`, `product_id`, `variation_id`, `quantity`, `quantity_returned`, `unit_price_before_discount`, `unit_price`, `line_discount_type`, `line_discount_amount`, `unit_price_inc_tax`, `item_tax`, `tax_id`, `discount_id`, `lot_no_line_id`, `sell_line_note`, `res_service_staff_id`, `res_line_order_status`, `parent_sell_line_id`, `children_type`, `sub_unit_id`, `created_at`, `updated_at`) VALUES
(2, 3, 2, 2, '1.0000', '0.0000', '0.0000', '0.0000', 'fixed', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-04 20:51:09', '2020-03-04 20:51:09'),
(3, 4, 2, 2, '1.0000', '0.0000', '0.0000', '0.0000', 'fixed', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-04 20:53:15', '2020-03-04 20:53:15'),
(4, 6, 3, 3, '2.0000', '0.0000', '35.0000', '35.0000', 'fixed', '0.0000', '35.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-05 16:52:33', '2020-03-05 16:52:33'),
(5, 6, 6, 6, '1.0000', '0.0000', '35.0000', '35.0000', 'fixed', '0.0000', '35.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-05 16:52:33', '2020-03-05 16:52:33'),
(6, 6, 4, 4, '1.0000', '0.0000', '35.0000', '35.0000', 'fixed', '0.0000', '35.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-05 16:52:33', '2020-03-05 16:52:33'),
(7, 6, 5, 5, '1.0000', '0.0000', '35.0000', '35.0000', 'fixed', '0.0000', '35.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-05 16:52:33', '2020-03-05 16:52:33'),
(8, 6, 8, 8, '1.0000', '0.0000', '20.0000', '20.0000', 'fixed', '0.0000', '20.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-05 16:52:33', '2020-03-05 16:52:33'),
(9, 6, 7, 7, '1.0000', '0.0000', '35.0000', '35.0000', 'fixed', '0.0000', '35.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-05 16:52:33', '2020-03-05 16:52:33'),
(15, 9, 2, 2, '1.0000', '0.0000', '300.0000', '300.0000', 'fixed', '0.0000', '300.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-06 13:18:29', '2020-03-06 13:18:29'),
(16, 10, 2, 2, '2.0000', '0.0000', '0.0000', '0.0000', 'fixed', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-06 13:22:02', '2020-03-06 13:22:02'),
(19, 14, 1, 1, '1.0000', '0.0000', '62.5000', '62.5000', 'fixed', '0.0000', '62.5000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-06 14:04:39', '2020-03-06 14:04:39'),
(24, 16, 1, 1, '1.0000', '0.0000', '62.5000', '62.5000', 'fixed', '0.0000', '62.5000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-06 14:48:42', '2020-03-06 14:48:42'),
(25, 17, 1, 1, '3.0000', '0.0000', '62.5000', '62.5000', 'fixed', '0.0000', '62.5000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-06 14:50:38', '2020-03-06 14:50:38'),
(27, 19, 1, 1, '1.0000', '0.0000', '62.5000', '62.5000', 'fixed', '0.0000', '62.5000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-06 15:33:06', '2020-03-06 15:33:06'),
(33, 25, 9, 9, '1.0000', '0.0000', '3564.0000', '3564.0000', 'fixed', '0.0000', '3564.0000', '0.0000', NULL, NULL, NULL, '3 Meses de aplicación para transferir data del servidor', NULL, NULL, NULL, '', NULL, '2020-03-11 15:17:08', '2020-03-11 15:17:08'),
(34, 25, 10, 10, '1.0000', '0.0000', '3200.0000', '3200.0000', 'fixed', '0.0000', '3200.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-11 15:17:08', '2020-03-11 15:17:08'),
(37, 31, 6, 6, '5.0000', '0.0000', '35.0000', '35.0000', 'fixed', '0.0000', '35.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-18 20:19:08', '2020-03-18 20:19:08'),
(38, 32, 3, 3, '5.0000', '0.0000', '35.0000', '35.0000', 'fixed', '0.0000', '35.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-18 20:22:52', '2020-03-18 20:22:52'),
(39, 33, 4, 4, '5.0000', '0.0000', '35.0000', '35.0000', 'fixed', '0.0000', '35.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-18 20:23:30', '2020-03-18 20:23:30'),
(40, 34, 6, 6, '5.0000', '0.0000', '35.0000', '35.0000', 'fixed', '0.0000', '35.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-18 20:24:15', '2020-03-18 20:24:15'),
(41, 35, 3, 3, '5.0000', '0.0000', '35.0000', '35.0000', 'fixed', '0.0000', '35.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-18 20:24:36', '2020-03-18 20:24:36'),
(42, 36, 4, 4, '5.0000', '0.0000', '35.0000', '35.0000', 'fixed', '0.0000', '35.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-18 20:24:48', '2020-03-18 20:24:48'),
(43, 38, 7, 7, '1.0000', '1.0000', '35.0000', '35.0000', 'fixed', '0.0000', '35.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-20 12:55:05', '2020-05-04 13:15:29'),
(46, 41, 10, 10, '1.0000', '0.0000', '3200.0000', '3200.0000', 'fixed', '0.0000', '3200.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-03-31 20:20:35', '2020-03-31 20:20:35'),
(47, 42, 9, 9, '1.0000', '0.0000', '0.0000', '0.0000', 'fixed', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-04-01 21:43:18', '2020-04-01 21:43:18'),
(48, 43, 10, 10, '1.0000', '1.0000', '3200.0000', '3200.0000', 'fixed', '0.0000', '3200.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-04-15 12:20:04', '2020-04-20 20:44:37'),
(50, 45, 10, 10, '1.0000', '0.0000', '3200.0000', '3200.0000', 'fixed', '0.0000', '3200.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-04-20 20:32:26', '2020-04-20 20:32:26'),
(51, 46, 10, 10, '1.0000', '0.0000', '3200.0000', '3200.0000', 'fixed', '0.0000', '3200.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-04-20 20:34:18', '2020-04-20 20:34:18'),
(56, 54, 7, 7, '19.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-07 14:57:03', '2020-05-07 14:57:03'),
(57, 55, 6, 6, '10.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-08 10:04:18', '2020-05-09 15:00:45'),
(58, 55, 7, 7, '2.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-08 10:04:18', '2020-05-09 15:00:45'),
(59, 55, 3, 3, '8.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-08 10:04:18', '2020-05-09 15:00:45'),
(60, 56, 3, 3, '8.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-08 12:11:28', '2020-05-08 12:11:28'),
(61, 56, 6, 6, '12.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-08 12:11:28', '2020-05-08 12:11:28'),
(64, 59, 7, 7, '12.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-11 11:44:12', '2020-05-11 11:44:12'),
(65, 59, 6, 6, '6.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-11 11:44:12', '2020-05-11 11:44:12'),
(69, 63, 7, 7, '20.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-14 12:02:10', '2020-05-14 13:37:23'),
(70, 64, 3, 3, '8.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-14 12:05:33', '2020-05-14 12:05:33'),
(71, 64, 7, 7, '12.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-14 12:05:33', '2020-05-14 12:05:33'),
(72, 65, 7, 7, '16.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-18 23:44:55', '2020-05-18 23:44:55'),
(73, 66, 3, 3, '8.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-19 13:01:53', '2020-05-19 13:01:53'),
(74, 66, 7, 7, '12.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-19 13:01:53', '2020-05-19 13:01:53'),
(75, 67, 6, 6, '12.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-20 11:47:41', '2020-05-20 11:47:41'),
(76, 67, 3, 3, '8.0000', '0.0000', '38.0000', '38.0000', 'fixed', '0.0000', '38.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-20 11:47:41', '2020-05-20 11:47:41'),
(80, 71, 2, 2, '1.0000', '0.0000', '0.0000', '0.0000', 'fixed', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-25 16:25:27', '2020-05-25 16:25:27'),
(81, 73, 1, 1, '1.0000', '0.0000', '62.5000', '62.5000', 'fixed', '0.0000', '62.5000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-29 14:08:00', '2020-05-29 14:08:00'),
(82, 74, 1, 1, '1.0000', '0.0000', '2000.0000', '2000.0000', 'fixed', '0.0000', '2000.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-05-29 14:58:33', '2020-05-29 14:58:33'),
(83, 75, 6, 6, '1.0000', '0.0000', '35.0000', '35.0000', 'fixed', '0.0000', '35.0000', '0.0000', NULL, NULL, NULL, 'asd', NULL, NULL, NULL, '', NULL, '2020-06-02 15:16:48', '2020-06-02 15:16:48'),
(84, 76, 23, 25, '1.0000', '0.0000', '125.0000', '125.0000', 'fixed', '0.0000', '125.0000', '0.0000', NULL, NULL, NULL, 'mlk', NULL, NULL, NULL, '', NULL, '2020-06-02 20:56:39', '2020-06-02 20:56:39'),
(85, 77, 23, 25, '1.0000', '0.0000', '125.0000', '125.0000', 'fixed', '0.0000', '125.0000', '0.0000', NULL, NULL, NULL, 'mnb', NULL, NULL, NULL, '', NULL, '2020-06-02 20:57:05', '2020-06-02 20:57:05'),
(86, 80, 2, 2, '3.0000', '0.0000', '200.0000', '200.0000', 'fixed', '0.0000', '200.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-03 19:17:28', '2020-06-03 19:17:28'),
(87, 81, 24, 26, '5.0000', '0.0000', '300.0000', '300.0000', 'fixed', '0.0000', '300.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-03 19:19:32', '2020-06-03 19:20:40'),
(88, 82, 26, 28, '1.0000', '0.0000', '250.0000', '150.0000', 'fixed', '100.0000', '150.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-08 13:27:52', '2020-06-08 13:29:20'),
(89, 83, 2, 2, '1.0000', '0.0000', '0.0000', '0.0000', 'fixed', '0.0000', '0.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-08 13:30:28', '2020-06-08 13:30:28'),
(90, 87, 2, 2, '1.0000', '0.0000', '200.0000', '200.0000', 'fixed', '0.0000', '200.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-12 17:06:53', '2020-06-12 17:06:53'),
(91, 88, 1, 1, '1.0000', '0.0000', '62.5000', '62.5000', 'fixed', '0.0000', '62.5000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-12 17:08:18', '2020-06-12 17:08:18'),
(92, 89, 2, 2, '1.0000', '0.0000', '100.0000', '100.0000', 'fixed', '0.0000', '100.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-12 17:09:07', '2020-06-12 17:09:07'),
(93, 90, 17, 17, '1.0000', '0.0000', '400.0000', '400.0000', 'fixed', '0.0000', '400.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-12 17:10:10', '2020-06-12 17:10:10'),
(94, 91, 17, 17, '1.0000', '0.0000', '400.0000', '400.0000', 'fixed', '0.0000', '400.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-12 17:11:36', '2020-06-12 17:11:36'),
(95, 93, 27, 29, '1.0000', '0.0000', '2500.0000', '2500.0000', 'fixed', '0.0000', '2500.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-12 17:14:05', '2020-06-12 17:14:05'),
(96, 94, 27, 29, '1.0000', '0.0000', '2500.0000', '2500.0000', 'fixed', '0.0000', '2500.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-12 17:23:07', '2020-06-12 17:23:07'),
(97, 95, 24, 26, '1.0000', '0.0000', '281.2500', '281.2500', 'fixed', '0.0000', '281.2500', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-12 17:26:29', '2020-06-12 17:26:29'),
(98, 96, 27, 29, '1.0000', '0.0000', '2500.0000', '2500.0000', 'fixed', '0.0000', '2500.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-12 17:54:57', '2020-06-12 17:54:57'),
(99, 97, 27, 29, '1.0000', '0.0000', '2000.0000', '2000.0000', 'fixed', '0.0000', '2000.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-12 18:24:21', '2020-06-12 18:24:21'),
(100, 98, 27, 29, '1.0000', '0.0000', '2500.0000', '2500.0000', 'fixed', '0.0000', '2500.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-12 18:25:38', '2020-06-12 18:25:38'),
(101, 99, 27, 29, '1.0000', '0.0000', '2500.0000', '2500.0000', 'fixed', '0.0000', '2500.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-12 18:26:18', '2020-06-12 18:26:18'),
(102, 100, 27, 29, '1.0000', '0.0000', '2500.0000', '2500.0000', 'fixed', '0.0000', '2500.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-12 18:27:53', '2020-06-12 18:27:53'),
(103, 101, 2, 2, '1.0000', '0.0000', '100.0000', '100.0000', 'fixed', '0.0000', '100.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-12 18:28:43', '2020-06-12 18:28:43'),
(104, 102, 27, 29, '1.0000', '0.0000', '100.0000', '100.0000', 'fixed', '0.0000', '100.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-12 19:08:20', '2020-06-12 19:08:20'),
(105, 108, 17, 17, '1.0000', '0.0000', '400.0000', '400.0000', 'fixed', '0.0000', '400.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-15 18:43:42', '2020-06-15 18:43:42'),
(106, 109, 17, 17, '1.0000', '0.0000', '400.0000', '400.0000', 'fixed', '0.0000', '400.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-15 18:50:08', '2020-06-15 18:50:08'),
(107, 110, 27, 29, '1.0000', '0.0000', '2500.0000', '2500.0000', 'fixed', '0.0000', '2500.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-15 19:07:43', '2020-06-15 19:07:43'),
(108, 111, 24, 26, '1.0000', '0.0000', '281.2500', '281.2500', 'fixed', '0.0000', '281.2500', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-15 19:24:20', '2020-06-15 19:24:20'),
(109, 112, 24, 26, '1.0000', '0.0000', '281.2500', '281.2500', 'fixed', '0.0000', '281.2500', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-15 19:30:56', '2020-06-15 19:30:56'),
(110, 113, 24, 26, '1.0000', '0.0000', '281.2500', '281.2500', 'fixed', '0.0000', '281.2500', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-15 19:31:26', '2020-06-15 19:31:26'),
(111, 114, 24, 26, '1.0000', '0.0000', '100.0000', '100.0000', 'fixed', '0.0000', '100.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-15 19:56:06', '2020-06-15 19:56:06'),
(112, 115, 24, 26, '1.0000', '0.0000', '100.0000', '100.0000', 'fixed', '0.0000', '100.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-15 19:56:16', '2020-06-15 19:56:16'),
(113, 116, 24, 26, '1.0000', '0.0000', '50.0000', '50.0000', 'fixed', '0.0000', '50.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-15 19:58:23', '2020-06-15 19:58:23'),
(114, 183, 1, 1, '3.0000', '0.0000', '62.5000', '62.5000', 'fixed', '0.0000', '62.5000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-19 20:32:10', '2020-06-19 20:32:10'),
(115, 184, 22, 24, '1.0000', '0.0000', '125.0000', '125.0000', 'fixed', '0.0000', '125.0000', '0.0000', NULL, NULL, NULL, '', NULL, NULL, NULL, '', NULL, '2020-06-19 20:33:59', '2020-06-19 20:33:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transaction_sell_lines_purchase_lines`
--

CREATE TABLE `transaction_sell_lines_purchase_lines` (
  `id` int(10) UNSIGNED NOT NULL,
  `sell_line_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'id from transaction_sell_lines',
  `stock_adjustment_line_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'id from stock_adjustment_lines',
  `purchase_line_id` int(10) UNSIGNED NOT NULL COMMENT 'id from purchase_lines',
  `quantity` decimal(22,4) NOT NULL,
  `qty_returned` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `transaction_sell_lines_purchase_lines`
--

INSERT INTO `transaction_sell_lines_purchase_lines` (`id`, `sell_line_id`, `stock_adjustment_line_id`, `purchase_line_id`, `quantity`, `qty_returned`, `created_at`, `updated_at`) VALUES
(7, 15, NULL, 1, '1.0000', '0.0000', '2020-03-06 13:18:29', '2020-03-06 13:18:29'),
(8, 16, NULL, 1, '2.0000', '0.0000', '2020-03-06 13:22:02', '2020-03-06 13:22:02'),
(11, 19, NULL, 4, '1.0000', '0.0000', '2020-03-06 14:04:39', '2020-03-06 14:04:39'),
(16, 24, NULL, 4, '1.0000', '0.0000', '2020-03-06 14:48:42', '2020-03-06 14:48:42'),
(17, 25, NULL, 4, '3.0000', '0.0000', '2020-03-06 14:50:38', '2020-03-06 14:50:38'),
(19, 27, NULL, 4, '1.0000', '0.0000', '2020-03-06 15:33:06', '2020-03-06 15:33:06'),
(30, 37, NULL, 6, '5.0000', '0.0000', '2020-03-18 20:19:08', '2020-03-18 20:19:08'),
(31, 38, NULL, 7, '5.0000', '0.0000', '2020-03-18 20:22:52', '2020-03-18 20:22:52'),
(32, 39, NULL, 8, '5.0000', '0.0000', '2020-03-18 20:23:30', '2020-03-18 20:23:30'),
(33, 40, NULL, 6, '5.0000', '0.0000', '2020-03-18 20:24:15', '2020-03-18 20:24:15'),
(34, 41, NULL, 7, '5.0000', '0.0000', '2020-03-18 20:24:36', '2020-03-18 20:24:36'),
(35, 42, NULL, 8, '5.0000', '0.0000', '2020-03-18 20:24:48', '2020-03-18 20:24:48'),
(36, 43, NULL, 10, '1.0000', '1.0000', '2020-03-20 12:55:05', '2020-05-04 13:15:29'),
(40, 52, NULL, 10, '19.0000', '0.0000', '2020-05-07 11:19:21', '2020-05-07 11:19:21'),
(44, 56, NULL, 10, '1.0000', '0.0000', '2020-05-07 14:57:03', '2020-05-07 14:57:03'),
(45, 56, NULL, 0, '18.0000', '0.0000', '2020-05-07 14:57:03', '2020-05-07 14:57:03'),
(46, 57, NULL, 6, '10.0000', '0.0000', '2020-05-08 10:04:18', '2020-05-08 10:04:18'),
(47, 58, NULL, 0, '2.0000', '0.0000', '2020-05-08 10:04:18', '2020-05-08 10:04:18'),
(48, 59, NULL, 7, '8.0000', '0.0000', '2020-05-08 10:04:18', '2020-05-08 10:04:18'),
(49, 60, NULL, 7, '2.0000', '0.0000', '2020-05-08 12:11:28', '2020-05-08 12:11:28'),
(50, 60, NULL, 12, '6.0000', '0.0000', '2020-05-08 12:11:28', '2020-05-08 12:11:28'),
(51, 61, NULL, 14, '10.0000', '0.0000', '2020-05-08 12:11:28', '2020-05-08 12:11:28'),
(52, 61, NULL, 21, '2.0000', '0.0000', '2020-05-08 12:11:28', '2020-06-18 15:12:17'),
(55, 58, NULL, 0, '2.0000', '0.0000', '2020-05-09 15:00:45', '2020-05-09 15:00:45'),
(56, 64, NULL, 0, '12.0000', '0.0000', '2020-05-11 11:44:12', '2020-05-11 11:44:12'),
(57, 65, NULL, 21, '3.0000', '0.0000', '2020-05-11 11:44:12', '2020-06-18 15:12:17'),
(61, 69, NULL, 0, '21.0000', '0.0000', '2020-05-14 12:02:10', '2020-05-14 12:02:10'),
(62, 70, NULL, 12, '4.0000', '0.0000', '2020-05-14 12:05:33', '2020-05-14 12:05:33'),
(63, 70, NULL, 0, '4.0000', '0.0000', '2020-05-14 12:05:33', '2020-05-14 12:05:33'),
(64, 71, NULL, 0, '12.0000', '0.0000', '2020-05-14 12:05:33', '2020-05-14 12:05:33'),
(65, 69, NULL, 0, '20.0000', '0.0000', '2020-05-14 13:37:23', '2020-05-14 13:37:23'),
(66, 72, NULL, 0, '16.0000', '0.0000', '2020-05-18 23:44:55', '2020-05-18 23:44:55'),
(67, 73, NULL, 0, '8.0000', '0.0000', '2020-05-19 13:01:53', '2020-05-19 13:01:53'),
(68, 74, NULL, 0, '12.0000', '0.0000', '2020-05-19 13:01:53', '2020-05-19 13:01:53'),
(69, 75, NULL, 21, '7.0000', '0.0000', '2020-05-20 11:47:41', '2020-06-18 15:12:47'),
(70, 76, NULL, 0, '8.0000', '0.0000', '2020-05-20 11:47:41', '2020-05-20 11:47:41'),
(74, 80, NULL, 1, '1.0000', '0.0000', '2020-05-25 16:25:27', '2020-05-25 16:25:27'),
(75, 81, NULL, 4, '1.0000', '0.0000', '2020-05-29 14:08:00', '2020-05-29 14:08:00'),
(76, 82, NULL, 4, '1.0000', '0.0000', '2020-05-29 14:58:33', '2020-05-29 14:58:33'),
(77, 83, NULL, 21, '1.0000', '0.0000', '2020-06-02 15:16:48', '2020-06-18 15:13:23'),
(78, 84, NULL, 15, '1.0000', '0.0000', '2020-06-02 20:56:39', '2020-06-02 20:56:39'),
(79, 85, NULL, 15, '1.0000', '0.0000', '2020-06-02 20:57:05', '2020-06-02 20:57:05'),
(80, 86, NULL, 1, '1.0000', '0.0000', '2020-06-03 19:17:28', '2020-06-03 19:17:28'),
(81, 86, NULL, 5, '2.0000', '0.0000', '2020-06-03 19:17:28', '2020-06-03 19:17:28'),
(82, 87, NULL, 17, '5.0000', '0.0000', '2020-06-03 19:19:32', '2020-06-03 19:19:32'),
(83, 89, NULL, 5, '1.0000', '0.0000', '2020-06-08 13:30:28', '2020-06-08 13:30:28'),
(84, 90, NULL, 5, '1.0000', '0.0000', '2020-06-12 17:06:53', '2020-06-12 17:06:53'),
(85, 91, NULL, 4, '1.0000', '0.0000', '2020-06-12 17:08:18', '2020-06-12 17:08:18'),
(86, 92, NULL, 5, '1.0000', '0.0000', '2020-06-12 17:09:07', '2020-06-12 17:09:07'),
(87, 93, NULL, 18, '1.0000', '0.0000', '2020-06-12 17:10:10', '2020-06-12 17:10:10'),
(88, 94, NULL, 18, '1.0000', '0.0000', '2020-06-12 17:11:36', '2020-06-12 17:11:36'),
(89, 95, NULL, 20, '1.0000', '0.0000', '2020-06-12 17:14:05', '2020-06-12 17:14:05'),
(90, 96, NULL, 20, '1.0000', '0.0000', '2020-06-12 17:23:07', '2020-06-12 17:23:07'),
(91, 97, NULL, 16, '1.0000', '0.0000', '2020-06-12 17:26:29', '2020-06-12 17:26:29'),
(92, 98, NULL, 20, '1.0000', '0.0000', '2020-06-12 17:54:57', '2020-06-12 17:54:57'),
(93, 99, NULL, 20, '1.0000', '0.0000', '2020-06-12 18:24:21', '2020-06-12 18:24:21'),
(94, 100, NULL, 20, '1.0000', '0.0000', '2020-06-12 18:25:38', '2020-06-12 18:25:38'),
(95, 101, NULL, 20, '1.0000', '0.0000', '2020-06-12 18:26:18', '2020-06-12 18:26:18'),
(96, 102, NULL, 20, '1.0000', '0.0000', '2020-06-12 18:27:53', '2020-06-12 18:27:53'),
(97, 103, NULL, 5, '1.0000', '0.0000', '2020-06-12 18:28:43', '2020-06-12 18:28:43'),
(98, 104, NULL, 20, '1.0000', '0.0000', '2020-06-12 19:08:20', '2020-06-12 19:08:20'),
(99, 105, NULL, 18, '1.0000', '0.0000', '2020-06-15 18:43:42', '2020-06-15 18:43:42'),
(100, 106, NULL, 18, '1.0000', '0.0000', '2020-06-15 18:50:08', '2020-06-15 18:50:08'),
(101, 107, NULL, 20, '1.0000', '0.0000', '2020-06-15 19:07:44', '2020-06-15 19:07:44'),
(102, 108, NULL, 16, '1.0000', '0.0000', '2020-06-15 19:24:20', '2020-06-15 19:24:20'),
(103, 109, NULL, 16, '1.0000', '0.0000', '2020-06-15 19:30:56', '2020-06-15 19:30:56'),
(104, 110, NULL, 17, '1.0000', '0.0000', '2020-06-15 19:31:27', '2020-06-15 19:31:27'),
(105, 111, NULL, 17, '1.0000', '0.0000', '2020-06-15 19:56:06', '2020-06-15 19:56:06'),
(106, 112, NULL, 17, '1.0000', '0.0000', '2020-06-15 19:56:16', '2020-06-15 19:56:16'),
(107, 113, NULL, 17, '1.0000', '0.0000', '2020-06-15 19:58:23', '2020-06-15 19:58:23'),
(109, NULL, 2, 8, '5.0000', '0.0000', '2020-06-17 20:14:22', '2020-06-17 20:14:22'),
(110, 65, NULL, 21, '3.0000', '0.0000', '2020-06-18 15:12:17', '2020-06-18 15:12:47'),
(111, 75, NULL, 21, '5.0000', '0.0000', '2020-06-18 15:12:47', '2020-06-18 15:13:23'),
(148, NULL, 60, 4, '1.0000', '0.0000', '2020-06-19 15:07:42', '2020-06-19 15:07:42'),
(149, 114, NULL, 4, '3.0000', '0.0000', '2020-06-19 20:32:10', '2020-06-19 20:32:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `types_of_services`
--

CREATE TABLE `types_of_services` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_id` int(11) NOT NULL,
  `location_price_group` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `packing_charge` decimal(22,4) DEFAULT NULL,
  `packing_charge_type` enum('fixed','percent') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_custom_fields` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `units`
--

CREATE TABLE `units` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `actual_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `allow_decimal` tinyint(1) NOT NULL,
  `base_unit_id` int(11) DEFAULT NULL,
  `base_unit_multiplier` decimal(20,4) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `units`
--

INSERT INTO `units` (`id`, `business_id`, `actual_name`, `short_name`, `allow_decimal`, `base_unit_id`, `base_unit_multiplier`, `created_by`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'Pieces', 'Pc(s)', 0, NULL, NULL, 1, NULL, '2020-03-05 05:06:01', '2020-03-05 05:06:01'),
(2, 2, 'Unidad', 'UD(s)', 0, NULL, NULL, 3, NULL, '2020-03-05 22:38:31', '2020-03-05 16:34:00'),
(3, 3, 'UD', 'UD', 0, NULL, NULL, 14, NULL, '2020-03-09 23:54:04', '2020-04-09 13:11:06'),
(4, 4, 'Pieces', 'Pc(s)', 0, NULL, NULL, 15, NULL, '2020-05-11 22:02:07', '2020-05-11 22:02:07'),
(5, 5, 'Libras', 'Lbs', 1, NULL, NULL, 16, NULL, '2020-05-11 23:35:51', '2020-05-12 10:15:26'),
(6, 4, 'Sensor movimiento', 'SM', 1, NULL, NULL, 15, NULL, '2020-05-12 11:10:24', '2020-05-12 11:10:24'),
(7, 1, 'docenas', 'doc', 1, NULL, NULL, 1, NULL, '2020-06-03 19:02:33', '2020-06-03 19:02:33'),
(8, 1, 'unidad de productos', 'unit', 1, NULL, NULL, 1, NULL, '2020-06-08 13:46:26', '2020-06-08 13:46:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `surname` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` char(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `contact_no` char(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_id` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('active','inactive','terminated') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `is_cmmsn_agnt` tinyint(1) NOT NULL DEFAULT 0,
  `cmmsn_percent` decimal(4,2) NOT NULL DEFAULT 0.00,
  `selected_contacts` tinyint(1) NOT NULL DEFAULT 0,
  `dob` date DEFAULT NULL,
  `marital_status` enum('married','unmarried','divorced') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blood_group` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` char(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fb_link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter_link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `social_media_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `social_media_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permanent_address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_details` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_proof_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_proof_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `access_cost_product` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `surname`, `first_name`, `last_name`, `username`, `email`, `password`, `language`, `contact_no`, `address`, `remember_token`, `business_id`, `status`, `is_cmmsn_agnt`, `cmmsn_percent`, `selected_contacts`, `dob`, `marital_status`, `blood_group`, `contact_number`, `fb_link`, `twitter_link`, `social_media_1`, `social_media_2`, `permanent_address`, `current_address`, `guardian_name`, `custom_field_1`, `custom_field_2`, `custom_field_3`, `custom_field_4`, `bank_details`, `id_proof_name`, `id_proof_number`, `deleted_at`, `created_at`, `updated_at`, `access_cost_product`) VALUES
(1, NULL, 'Dualsoft', NULL, 'dualsoft', NULL, '$2y$10$G9XL3hiqbtFThv64ldjMbOOChHuJfb6PCvX5Fh50Rx3H4581UVSsa', 'es', NULL, NULL, 'JGxypvWHLAgWm86UE5Juiphtn4bUucWdwWiDoDdHDlULB9F5k8p0zW6sxwUY', 1, 'active', 0, '0.00', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-05 05:06:01', '2020-05-20 13:42:35', ''),
(2, NULL, 'admin1', 'admin1', 'admin1', 'admin@admin.com', '$2y$10$HKy22jrme2AJVY53ZVeST.5fxwOtrXuhOagH1hf/s5vxx4saO34/i', 'en', NULL, NULL, 'uMthbCdElkWcFvzxMsKMTL0SH6tOCg5ZlpkOBWmd5AkYmW9FyGZke8AZlNdf', 1, 'active', 0, '0.00', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"account_holder_name\":null,\"account_number\":null,\"bank_name\":null,\"bank_code\":null,\"branch\":null,\"tax_payer_id\":null}', NULL, NULL, '2020-03-04 20:31:00', '2020-03-04 20:29:55', '2020-03-04 20:31:00', ''),
(3, NULL, '-', '-', 'empanadas_artesanales', NULL, '$2y$10$p3MHsS69SEH7YNtqXahLOefQuhiRH6mURYy4ZGpX2EQiQe2RVcT/W', 'es', NULL, NULL, 'nA8YlC3814Hz9iYQhy1xaFpupF16GoSicAJODFsNJPYoi0WZdS92BAcYU1X1', 2, 'active', 0, '0.00', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-05 22:38:31', '2020-03-05 22:38:31', ''),
(4, 'Sra', 'Yuri Clarissa', 'Henriquez Vásquez', 'yurih', 'henriquez.yuri@gmail.com', '$2y$10$ka.TsSh4kXMcJFYsE2gWDuhn/fKIe9mMDOtuVRBFNZ.mh44VsJ/n6', 'es', NULL, NULL, 'n6Fam4h5XMmaK8qNr8AHwyGhmawfUhOVLsqQQb16VgwU5MgNI78g7O0qXJLs', 2, 'active', 0, '0.00', 0, '1983-02-01', 'married', NULL, '8097717273', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"account_holder_name\":null,\"account_number\":null,\"bank_name\":null,\"bank_code\":null,\"branch\":null,\"tax_payer_id\":null}', NULL, NULL, NULL, '2020-03-05 13:35:43', '2020-03-05 13:38:07', ''),
(5, 'Sr', 'Francisco Ernesto', 'Jorge Guzmán', 'frankjorgeg', 'frank.jorge@gmail.com', '$2y$10$WRj2fNxi83sJE7jYb4ZQdOZwsVKvss0kk11glCNXJVyPHesVsgR22', 'es', NULL, NULL, 'OdJoDHPMPOMY118UPA6Yx4bMuoT6iD4pmQDEMRF7ROVuSXOsUUXU8qXEIX1j', 2, 'active', 0, '0.00', 0, '1983-03-17', 'married', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"account_holder_name\":null,\"account_number\":null,\"bank_name\":null,\"bank_code\":null,\"branch\":null,\"tax_payer_id\":null}', NULL, NULL, NULL, '2020-03-05 13:36:39', '2020-03-05 16:23:58', ''),
(7, 'sr', 'administrador', 'admin', 'admin12', 'admin@admin.com', '$2y$10$OT5zKgKsdcuy/mkvQZmPQufIqWju5lxUVQNsDhadSf3y4C.tWVN5K', 'es', NULL, NULL, 'iShlJVzJ7qCIBWtbRjPUTh2YFdYkehnZAhzGHVfwk4HNieBy5rL8cNQs6lUN', 1, 'active', 0, '0.00', 0, '2020-03-05', 'unmarried', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"account_holder_name\":null,\"account_number\":null,\"bank_name\":null,\"bank_code\":null,\"branch\":null,\"tax_payer_id\":null}', NULL, NULL, '2020-03-09 14:00:15', '2020-03-05 18:00:40', '2020-03-09 14:00:15', ''),
(8, 'sr', 'cajero', 'cajero', 'cajero', 'correo@gmail.com', '$2y$10$9vuFj.bJH617XFbj4XhiQu5MLAgCcFnQVQho02PP4tXKSsFyKo8Cu', 'es', NULL, NULL, 'vSdTNgCoUdxuVkZWurqDnfEVxyOVBDZqxyMySGn5JFXANTu7xvFGB117m3Pt', 1, 'active', 0, '0.00', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"account_holder_name\":null,\"account_number\":null,\"bank_name\":null,\"bank_code\":null,\"branch\":null,\"tax_payer_id\":null}', NULL, NULL, '2020-03-09 14:00:18', '2020-03-06 13:20:13', '2020-03-09 14:00:18', ''),
(9, 'sr', 'Francisco', 'Jorge', 'frankjf', 'admin@admin.com', '$2y$10$bD7UBl2BKqupyYpgVZm.M.CSG2/V38JTbByrJd2MDN.LVj8IDzT0u', 'en', NULL, NULL, NULL, 1, 'active', 0, '0.00', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"account_holder_name\":null,\"account_number\":null,\"bank_name\":null,\"bank_code\":null,\"branch\":null,\"tax_payer_id\":null}', NULL, NULL, '2020-03-09 14:02:49', '2020-03-09 14:01:15', '2020-03-09 14:02:49', ''),
(12, 'sr', 'as', 'asd', 'administrador', 'ad@ad.com', '$2y$10$S8pcWsm62ldCRewwl/AHFezSqpaDzdPGcgvb2PgYcXeUvTwol6wSG', 'en', NULL, NULL, NULL, 1, 'active', 0, '0.00', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"account_holder_name\":null,\"account_number\":null,\"bank_name\":null,\"bank_code\":null,\"branch\":null,\"tax_payer_id\":null}', NULL, NULL, '2020-03-09 14:18:50', '2020-03-09 14:18:44', '2020-03-09 14:18:50', ''),
(14, 'Sr', 'Francisco', 'Jorge', 'frankjorge', NULL, '$2y$10$vJrH7.g7i90pmMoV.mEVZegiKkTt86OmBkHN2mAtXxSjpQmyp.RFi', 'es', NULL, NULL, '4v1lW0kR0zIzFySUGQpfJlqnLLfwf2svmhIFZjzGNbNWU9vF7qSrgKqo1HxF', 3, 'active', 0, '0.00', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-09 23:54:04', '2020-03-09 23:54:04', ''),
(15, 'ASP', 'Patricioml', 'Patricioml', 'Patricioml', NULL, '$2y$10$PeiBoFzD0G6edAZrr9CytOdGa8nT/HGMsyv.BcfzSyraGe9X9xILi', 'en', NULL, NULL, NULL, 4, 'active', 0, '0.00', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-05-11 22:02:06', '2020-05-11 22:02:06', ''),
(16, 'Señor', 'Agliberto', 'Hernández', 'aglibertoh', NULL, '$2y$10$O4g6jjUwmHuPwrKytfccx.dpJExvDgLFe1kcvjwtSJyZt/zwAsN1u', 'es', NULL, NULL, 'VTvATlm13yw2SnEfklhWZxyMFOcZITWj8dUACMfQP4PA5sJPXZpcwoXXGAs4', 5, 'active', 0, '0.00', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"account_holder_name\":null,\"account_number\":null,\"bank_name\":null,\"bank_code\":null,\"branch\":null,\"tax_payer_id\":null}', NULL, NULL, NULL, '2020-05-11 23:35:51', '2020-05-11 23:52:33', ''),
(17, 'sra', 'ASW', 'Moca', 'aswmoca', 'aswmoca@gami.com', '$2y$10$MXxKxKfhvzLp0INxO2Jp6OXg0EArtkVu4a76ugtvwrhqByAvXS2xq', 'es', NULL, NULL, 'CYkZOKtleFGo8HbkraoBJv0LxVIkeqIFHfPFGG9X4urqDXLmMnUPgXYvgtMY', 5, 'active', 0, '0.00', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"account_holder_name\":null,\"account_number\":null,\"bank_name\":null,\"bank_code\":null,\"branch\":null,\"tax_payer_id\":null}', NULL, NULL, NULL, '2020-05-14 12:39:29', '2020-05-14 13:30:53', ''),
(18, NULL, 'Usuario 2', 'ninguno', 'prueba', 'ninguno@ninguno.com', '$2y$10$.ffvZztnXkPUQNGjVNBr5e/BHTYPFPUnCQd0RumYPwx8qW.m5wBza', 'en', NULL, NULL, NULL, 1, 'active', 0, '0.00', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"account_holder_name\":null,\"account_number\":null,\"bank_name\":null,\"bank_code\":null,\"branch\":null,\"tax_payer_id\":null}', NULL, NULL, NULL, '2020-05-20 17:51:13', '2020-06-02 18:04:04', 'No');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_contact_access`
--

CREATE TABLE `user_contact_access` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `variations`
--

CREATE TABLE `variations` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `sub_sku` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_variation_id` int(10) UNSIGNED NOT NULL,
  `variation_value_id` int(11) DEFAULT NULL,
  `default_purchase_price` decimal(22,4) DEFAULT NULL,
  `dpp_inc_tax` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `profit_percent` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `default_sell_price` decimal(22,4) DEFAULT NULL,
  `sell_price_inc_tax` decimal(22,4) DEFAULT NULL COMMENT 'Sell price including tax',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `combo_variations` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Contains the combo variation details'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `variations`
--

INSERT INTO `variations` (`id`, `name`, `product_id`, `sub_sku`, `product_variation_id`, `variation_value_id`, `default_purchase_price`, `dpp_inc_tax`, `profit_percent`, `default_sell_price`, `sell_price_inc_tax`, `created_at`, `updated_at`, `deleted_at`, `combo_variations`) VALUES
(1, 'DUMMY', 1, '0001', 1, NULL, '200.0000', '200.0000', '-68.7500', '62.5000', '62.5000', '2020-03-04 19:38:54', '2020-03-06 13:25:43', NULL, '[]'),
(2, 'DUMMY', 2, '0002', 2, NULL, '300.0000', '300.0000', '-100.0000', '0.0000', '0.0000', '2020-03-04 20:45:31', '2020-03-06 13:25:43', NULL, '[]'),
(3, 'DUMMY', 3, '0003', 3, NULL, '25.0000', '25.0000', '40.0000', '35.0000', '35.0000', '2020-03-05 16:39:40', '2020-03-05 16:39:40', NULL, '[]'),
(4, 'DUMMY', 4, '0004', 4, NULL, '25.0000', '25.0000', '40.0000', '35.0000', '35.0000', '2020-03-05 16:40:22', '2020-03-05 16:40:22', NULL, '[]'),
(5, 'DUMMY', 5, '0005', 5, NULL, '25.0000', '25.0000', '40.0000', '35.0000', '35.0000', '2020-03-05 16:40:51', '2020-03-05 16:40:51', NULL, '[]'),
(6, 'DUMMY', 6, '0006', 6, NULL, '28.0000', '28.0000', '25.0000', '35.0000', '35.0000', '2020-03-05 16:41:30', '2020-03-05 16:41:30', NULL, '[]'),
(7, 'DUMMY', 7, '0007', 7, NULL, '28.0000', '28.0000', '25.0000', '35.0000', '35.0000', '2020-03-05 16:42:09', '2020-03-05 16:42:09', NULL, '[]'),
(8, 'DUMMY', 8, '0008', 8, NULL, '15.0000', '15.0000', '33.3300', '20.0000', '20.0000', '2020-03-05 16:42:45', '2020-03-05 16:42:45', NULL, '[]'),
(9, 'DUMMY', 9, '0009', 9, NULL, '0.0000', '0.0000', '25.0000', '0.0000', '0.0000', '2020-03-09 14:45:20', '2020-03-09 14:45:20', NULL, '[]'),
(10, 'DUMMY', 10, '0010', 10, NULL, '3200.0000', '3200.0000', '0.0000', '3200.0000', '3200.0000', '2020-03-11 15:16:48', '2020-03-11 15:16:48', NULL, '[]'),
(12, 'DUMMY', 12, '0012', 12, NULL, '28.0000', '28.0000', '78.5700', '50.0000', '50.0000', '2020-04-09 13:21:16', '2020-04-09 13:21:16', NULL, '[]'),
(13, 'DUMMY', 13, '0013', 13, NULL, '28.0000', '28.0000', '78.5700', '50.0000', '50.0000', '2020-04-09 13:22:50', '2020-04-09 13:22:50', NULL, '[]'),
(17, 'DUMMY', 17, '0017', 17, NULL, '236.0000', '236.0000', '69.4900', '400.0000', '400.0000', '2020-05-12 13:59:26', '2020-06-12 17:11:09', NULL, '[]'),
(18, 'DUMMY', 18, '0018', 18, NULL, '236.0000', '236.0000', '69.4900', '400.0000', '400.0000', '2020-05-12 14:02:49', '2020-06-19 17:43:15', NULL, '[]'),
(19, 'DUMMY', 19, '0019', 19, NULL, '0.0000', '0.0000', '25.0000', '0.0000', '0.0000', '2020-05-12 18:11:48', '2020-05-12 18:11:48', NULL, '[]'),
(20, 'DUMMY', 20, '0020', 20, NULL, '0.0000', '0.0000', '25.0000', '0.0000', '0.0000', '2020-05-12 18:12:18', '2020-05-12 18:12:18', NULL, '[]'),
(24, 'DUMMY', 22, '0022', 22, NULL, '100.0000', '100.0000', '25.0000', '125.0000', '125.0000', '2020-05-28 15:33:46', '2020-05-28 15:33:46', NULL, '[]'),
(25, 'DUMMY', 23, '0023', 23, NULL, '100.0000', '100.0000', '25.0000', '125.0000', '125.0000', '2020-05-28 15:34:54', '2020-05-28 15:34:54', NULL, '[]'),
(26, 'DUMMY', 24, '0024', 24, NULL, '225.0000', '225.0000', '25.0000', '281.2500', '281.2500', '2020-06-03 19:08:17', '2020-06-03 19:08:57', NULL, '[]'),
(27, 'DUMMY', 25, '0025', 25, NULL, '225.0000', '225.0000', '25.0000', '281.2500', '281.2500', '2020-06-03 19:09:32', '2020-06-03 19:09:32', NULL, '[]'),
(28, 'DUMMY', 26, '0026', 26, NULL, '200.0000', '200.0000', '25.0000', '250.0000', '250.0000', '2020-06-08 13:26:44', '2020-06-08 13:26:44', NULL, '[]'),
(29, 'DUMMY', 27, '0027', 27, NULL, '2000.0000', '2000.0000', '25.0000', '2500.0000', '2500.0000', '2020-06-08 13:49:52', '2020-06-08 13:49:52', NULL, '[]'),
(30, 'DUMMY', 28, '0028', 28, NULL, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2020-06-19 17:41:01', '2020-06-19 17:41:01', NULL, '[]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `variation_group_prices`
--

CREATE TABLE `variation_group_prices` (
  `id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `price_group_id` int(10) UNSIGNED NOT NULL,
  `price_inc_tax` decimal(22,4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `variation_location_details`
--

CREATE TABLE `variation_location_details` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_variation_id` int(10) UNSIGNED NOT NULL COMMENT 'id from product_variations table',
  `variation_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `qty_available` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `incr` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `variation_location_details`
--

INSERT INTO `variation_location_details` (`id`, `product_id`, `product_variation_id`, `variation_id`, `location_id`, `qty_available`, `created_at`, `updated_at`, `incr`) VALUES
(1, 2, 2, 2, 1, '4.0000', '2020-03-04 20:45:31', '2020-06-12 18:28:43', 0),
(2, 5, 5, 5, 2, '20.0000', '2020-03-05 16:49:10', '2020-05-07 12:57:58', 0),
(3, 3, 3, 3, 2, '-20.0000', '2020-03-05 16:49:10', '2020-05-20 11:47:41', 0),
(4, 6, 6, 6, 2, '15.0000', '2020-03-06 12:16:24', '2020-06-18 19:24:14', 1),
(5, 8, 8, 8, 2, '20.0000', '2020-03-06 12:16:24', '2020-05-11 13:39:21', 0),
(6, 1, 1, 1, 1, '6.0000', '2020-03-06 13:25:43', '2020-06-19 20:32:10', 1),
(7, 4, 4, 4, 2, '15.0000', '2020-03-06 14:16:36', '2020-06-17 20:14:22', 0),
(8, 7, 7, 7, 2, '-92.0000', '2020-03-18 20:13:27', '2020-05-19 13:01:53', 0),
(9, 23, 23, 25, 1, '8.0000', '2020-05-28 15:35:09', '2020-06-02 20:57:05', 0),
(10, 24, 24, 26, 1, '23.0000', '2020-06-03 19:10:14', '2020-06-15 19:58:23', 0),
(11, 17, 17, 17, 1, '1.0000', '2020-06-03 19:13:35', '2020-06-15 18:50:08', 0),
(12, 27, 27, 29, 1, '1.0000', '2020-06-08 13:50:30', '2020-06-15 19:07:43', 0),
(16, 18, 18, 18, 1, '1.0000', '2020-06-19 17:43:22', '2020-06-19 17:43:22', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `variation_templates`
--

CREATE TABLE `variation_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `variation_templates`
--

INSERT INTO `variation_templates` (`id`, `name`, `business_id`, `created_at`, `updated_at`) VALUES
(1, 'Colores', 1, '2020-05-28 14:04:43', '2020-05-28 14:04:43'),
(2, 'Tamaño', 1, '2020-06-03 19:01:53', '2020-06-03 19:01:53'),
(3, 'Forma', 1, '2020-06-08 13:47:04', '2020-06-08 13:47:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `variation_value_templates`
--

CREATE TABLE `variation_value_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `variation_template_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `variation_value_templates`
--

INSERT INTO `variation_value_templates` (`id`, `name`, `variation_template_id`, `created_at`, `updated_at`) VALUES
(1, 'Negro', 1, '2020-05-28 14:04:43', '2020-05-28 14:04:43'),
(2, 'Rojo', 1, '2020-05-28 14:04:43', '2020-05-28 14:04:43'),
(3, 'Azul', 1, '2020-05-28 14:04:43', '2020-05-28 14:04:43'),
(4, 'pequeño', 2, '2020-06-03 19:01:53', '2020-06-03 19:01:53'),
(5, 'grande', 2, '2020-06-03 19:01:53', '2020-06-03 19:01:53'),
(6, 'mediano', 2, '2020-06-03 19:01:53', '2020-06-03 19:01:53'),
(7, 'redonda', 3, '2020-06-08 13:47:04', '2020-06-08 13:47:04'),
(8, 'cuadrada', 3, '2020-06-08 13:47:04', '2020-06-08 13:47:04'),
(9, 'rectangular', 3, '2020-06-08 13:47:04', '2020-06-08 13:47:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `warranties`
--

CREATE TABLE `warranties` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(11) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `duration_type` enum('days','months','years') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `account_transactions`
--
ALTER TABLE `account_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_transactions_account_id_index` (`account_id`),
  ADD KEY `account_transactions_transaction_id_index` (`transaction_id`),
  ADD KEY `account_transactions_transaction_payment_id_index` (`transaction_payment_id`),
  ADD KEY `account_transactions_transfer_transaction_id_index` (`transfer_transaction_id`),
  ADD KEY `account_transactions_created_by_index` (`created_by`);

--
-- Indices de la tabla `account_types`
--
ALTER TABLE `account_types`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_log_log_name_index` (`log_name`);

--
-- Indices de la tabla `barcodes`
--
ALTER TABLE `barcodes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barcodes_business_id_foreign` (`business_id`);

--
-- Indices de la tabla `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_contact_id_foreign` (`contact_id`),
  ADD KEY `bookings_business_id_foreign` (`business_id`),
  ADD KEY `bookings_created_by_foreign` (`created_by`),
  ADD KEY `bookings_table_id_index` (`table_id`),
  ADD KEY `bookings_waiter_id_index` (`waiter_id`),
  ADD KEY `bookings_location_id_index` (`location_id`);

--
-- Indices de la tabla `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brands_business_id_foreign` (`business_id`),
  ADD KEY `brands_created_by_foreign` (`created_by`);

--
-- Indices de la tabla `business`
--
ALTER TABLE `business`
  ADD PRIMARY KEY (`id`),
  ADD KEY `business_owner_id_foreign` (`owner_id`),
  ADD KEY `business_currency_id_foreign` (`currency_id`),
  ADD KEY `business_default_sales_tax_foreign` (`default_sales_tax`);

--
-- Indices de la tabla `business_locations`
--
ALTER TABLE `business_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `business_locations_business_id_index` (`business_id`),
  ADD KEY `business_locations_invoice_scheme_id_foreign` (`invoice_scheme_id`),
  ADD KEY `business_locations_invoice_layout_id_foreign` (`invoice_layout_id`);

--
-- Indices de la tabla `cash_registers`
--
ALTER TABLE `cash_registers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cash_registers_business_id_foreign` (`business_id`),
  ADD KEY `cash_registers_user_id_foreign` (`user_id`),
  ADD KEY `cash_registers_location_id_index` (`location_id`);

--
-- Indices de la tabla `cash_register_transactions`
--
ALTER TABLE `cash_register_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cash_register_transactions_cash_register_id_foreign` (`cash_register_id`),
  ADD KEY `cash_register_transactions_transaction_id_index` (`transaction_id`);

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_business_id_foreign` (`business_id`),
  ADD KEY `categories_created_by_foreign` (`created_by`);

--
-- Indices de la tabla `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contacts_business_id_foreign` (`business_id`),
  ADD KEY `contacts_created_by_foreign` (`created_by`);

--
-- Indices de la tabla `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `customer_groups`
--
ALTER TABLE `customer_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_groups_business_id_foreign` (`business_id`);

--
-- Indices de la tabla `detallencf`
--
ALTER TABLE `detallencf`
  ADD PRIMARY KEY (`iddetalle`);

--
-- Indices de la tabla `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discounts_business_id_index` (`business_id`),
  ADD KEY `discounts_brand_id_index` (`brand_id`),
  ADD KEY `discounts_category_id_index` (`category_id`),
  ADD KEY `discounts_location_id_index` (`location_id`),
  ADD KEY `discounts_priority_index` (`priority`);

--
-- Indices de la tabla `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expense_categories_business_id_foreign` (`business_id`);

--
-- Indices de la tabla `group_sub_taxes`
--
ALTER TABLE `group_sub_taxes`
  ADD KEY `group_sub_taxes_group_tax_id_foreign` (`group_tax_id`),
  ADD KEY `group_sub_taxes_tax_id_foreign` (`tax_id`);

--
-- Indices de la tabla `invoice_layouts`
--
ALTER TABLE `invoice_layouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_layouts_business_id_foreign` (`business_id`);

--
-- Indices de la tabla `invoice_schemes`
--
ALTER TABLE `invoice_schemes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_schemes_business_id_foreign` (`business_id`);

--
-- Indices de la tabla `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indices de la tabla `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indices de la tabla `ncf`
--
ALTER TABLE `ncf`
  ADD PRIMARY KEY (`idncf`);

--
-- Indices de la tabla `ncf_secuencia`
--
ALTER TABLE `ncf_secuencia`
  ADD PRIMARY KEY (`idncfsecuencia`);

--
-- Indices de la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indices de la tabla `notification_templates`
--
ALTER TABLE `notification_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `presupuesto`
--
ALTER TABLE `presupuesto`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `printers`
--
ALTER TABLE `printers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `printers_business_id_foreign` (`business_id`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_brand_id_foreign` (`brand_id`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_sub_category_id_foreign` (`sub_category_id`),
  ADD KEY `products_tax_foreign` (`tax`),
  ADD KEY `products_name_index` (`name`),
  ADD KEY `products_business_id_index` (`business_id`),
  ADD KEY `products_unit_id_index` (`unit_id`),
  ADD KEY `products_created_by_index` (`created_by`),
  ADD KEY `products_warranty_id_index` (`warranty_id`);

--
-- Indices de la tabla `product_locations`
--
ALTER TABLE `product_locations`
  ADD KEY `product_locations_product_id_index` (`product_id`),
  ADD KEY `product_locations_location_id_index` (`location_id`);

--
-- Indices de la tabla `product_racks`
--
ALTER TABLE `product_racks`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `product_variations`
--
ALTER TABLE `product_variations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_variations_name_index` (`name`),
  ADD KEY `product_variations_product_id_index` (`product_id`);

--
-- Indices de la tabla `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`p_id`);

--
-- Indices de la tabla `purchase_lines`
--
ALTER TABLE `purchase_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_lines_transaction_id_foreign` (`transaction_id`),
  ADD KEY `purchase_lines_product_id_foreign` (`product_id`),
  ADD KEY `purchase_lines_variation_id_foreign` (`variation_id`),
  ADD KEY `purchase_lines_tax_id_foreign` (`tax_id`),
  ADD KEY `purchase_lines_sub_unit_id_index` (`sub_unit_id`),
  ADD KEY `purchase_lines_lot_number_index` (`lot_number`(191));

--
-- Indices de la tabla `reference_counts`
--
ALTER TABLE `reference_counts`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `res_product_modifier_sets`
--
ALTER TABLE `res_product_modifier_sets`
  ADD KEY `res_product_modifier_sets_modifier_set_id_foreign` (`modifier_set_id`);

--
-- Indices de la tabla `res_tables`
--
ALTER TABLE `res_tables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `res_tables_business_id_foreign` (`business_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roles_business_id_foreign` (`business_id`);

--
-- Indices de la tabla `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indices de la tabla `selling_price_groups`
--
ALTER TABLE `selling_price_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `selling_price_groups_business_id_foreign` (`business_id`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD UNIQUE KEY `sessions_id_unique` (`id`);

--
-- Indices de la tabla `stock_adjustment_lines`
--
ALTER TABLE `stock_adjustment_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_adjustment_lines_product_id_foreign` (`product_id`),
  ADD KEY `stock_adjustment_lines_variation_id_foreign` (`variation_id`),
  ADD KEY `stock_adjustment_lines_transaction_id_index` (`transaction_id`);

--
-- Indices de la tabla `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscriptions_business_id_foreign` (`business_id`),
  ADD KEY `subscriptions_package_id_index` (`package_id`),
  ADD KEY `subscriptions_created_id_index` (`created_id`);

--
-- Indices de la tabla `superadmin_communicator_logs`
--
ALTER TABLE `superadmin_communicator_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `superadmin_frontend_pages`
--
ALTER TABLE `superadmin_frontend_pages`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `system`
--
ALTER TABLE `system`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`idtask`);

--
-- Indices de la tabla `tax_rates`
--
ALTER TABLE `tax_rates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tax_rates_business_id_foreign` (`business_id`),
  ADD KEY `tax_rates_created_by_foreign` (`created_by`);

--
-- Indices de la tabla `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_tax_id_foreign` (`tax_id`),
  ADD KEY `transactions_business_id_index` (`business_id`),
  ADD KEY `transactions_type_index` (`type`(191)),
  ADD KEY `transactions_contact_id_index` (`contact_id`),
  ADD KEY `transactions_transaction_date_index` (`transaction_date`),
  ADD KEY `transactions_created_by_index` (`created_by`),
  ADD KEY `transactions_location_id_index` (`location_id`),
  ADD KEY `transactions_expense_for_foreign` (`expense_for`),
  ADD KEY `transactions_expense_category_id_index` (`expense_category_id`),
  ADD KEY `transactions_sub_type_index` (`sub_type`),
  ADD KEY `transactions_return_parent_id_index` (`return_parent_id`),
  ADD KEY `type` (`type`(191));

--
-- Indices de la tabla `transaction_payments`
--
ALTER TABLE `transaction_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_payments_transaction_id_foreign` (`transaction_id`),
  ADD KEY `transaction_payments_created_by_index` (`created_by`),
  ADD KEY `transaction_payments_parent_id_index` (`parent_id`);

--
-- Indices de la tabla `transaction_sell_lines`
--
ALTER TABLE `transaction_sell_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_sell_lines_transaction_id_foreign` (`transaction_id`),
  ADD KEY `transaction_sell_lines_product_id_foreign` (`product_id`),
  ADD KEY `transaction_sell_lines_variation_id_foreign` (`variation_id`),
  ADD KEY `transaction_sell_lines_tax_id_foreign` (`tax_id`),
  ADD KEY `transaction_sell_lines_children_type_index` (`children_type`),
  ADD KEY `transaction_sell_lines_parent_sell_line_id_index` (`parent_sell_line_id`);

--
-- Indices de la tabla `transaction_sell_lines_purchase_lines`
--
ALTER TABLE `transaction_sell_lines_purchase_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sell_line_id` (`sell_line_id`),
  ADD KEY `stock_adjustment_line_id` (`stock_adjustment_line_id`),
  ADD KEY `purchase_line_id` (`purchase_line_id`);

--
-- Indices de la tabla `types_of_services`
--
ALTER TABLE `types_of_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `types_of_services_business_id_index` (`business_id`);

--
-- Indices de la tabla `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD KEY `units_business_id_foreign` (`business_id`),
  ADD KEY `units_created_by_foreign` (`created_by`),
  ADD KEY `units_base_unit_id_index` (`base_unit_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD KEY `users_business_id_foreign` (`business_id`);

--
-- Indices de la tabla `user_contact_access`
--
ALTER TABLE `user_contact_access`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `variations`
--
ALTER TABLE `variations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variations_product_id_foreign` (`product_id`),
  ADD KEY `variations_product_variation_id_foreign` (`product_variation_id`),
  ADD KEY `variations_name_index` (`name`),
  ADD KEY `variations_sub_sku_index` (`sub_sku`),
  ADD KEY `variations_variation_value_id_index` (`variation_value_id`);

--
-- Indices de la tabla `variation_group_prices`
--
ALTER TABLE `variation_group_prices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variation_group_prices_variation_id_foreign` (`variation_id`),
  ADD KEY `variation_group_prices_price_group_id_foreign` (`price_group_id`);

--
-- Indices de la tabla `variation_location_details`
--
ALTER TABLE `variation_location_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variation_location_details_location_id_foreign` (`location_id`),
  ADD KEY `variation_location_details_product_id_index` (`product_id`),
  ADD KEY `variation_location_details_product_variation_id_index` (`product_variation_id`),
  ADD KEY `variation_location_details_variation_id_index` (`variation_id`);

--
-- Indices de la tabla `variation_templates`
--
ALTER TABLE `variation_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variation_templates_business_id_foreign` (`business_id`);

--
-- Indices de la tabla `variation_value_templates`
--
ALTER TABLE `variation_value_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variation_value_templates_name_index` (`name`),
  ADD KEY `variation_value_templates_variation_template_id_index` (`variation_template_id`);

--
-- Indices de la tabla `warranties`
--
ALTER TABLE `warranties`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `account_transactions`
--
ALTER TABLE `account_transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `account_types`
--
ALTER TABLE `account_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `barcodes`
--
ALTER TABLE `barcodes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `business`
--
ALTER TABLE `business`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `business_locations`
--
ALTER TABLE `business_locations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cash_registers`
--
ALTER TABLE `cash_registers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `cash_register_transactions`
--
ALTER TABLE `cash_register_transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- AUTO_INCREMENT de la tabla `customer_groups`
--
ALTER TABLE `customer_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `detallencf`
--
ALTER TABLE `detallencf`
  MODIFY `iddetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT de la tabla `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `invoice_layouts`
--
ALTER TABLE `invoice_layouts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `invoice_schemes`
--
ALTER TABLE `invoice_schemes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `media`
--
ALTER TABLE `media`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=227;

--
-- AUTO_INCREMENT de la tabla `ncf`
--
ALTER TABLE `ncf`
  MODIFY `idncf` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `ncf_secuencia`
--
ALTER TABLE `ncf_secuencia`
  MODIFY `idncfsecuencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `notification_templates`
--
ALTER TABLE `notification_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `packages`
--
ALTER TABLE `packages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT de la tabla `presupuesto`
--
ALTER TABLE `presupuesto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `printers`
--
ALTER TABLE `printers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `product_racks`
--
ALTER TABLE `product_racks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `product_variations`
--
ALTER TABLE `product_variations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `project`
--
ALTER TABLE `project`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `purchase_lines`
--
ALTER TABLE `purchase_lines`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `reference_counts`
--
ALTER TABLE `reference_counts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `res_tables`
--
ALTER TABLE `res_tables`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `selling_price_groups`
--
ALTER TABLE `selling_price_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `stock_adjustment_lines`
--
ALTER TABLE `stock_adjustment_lines`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT de la tabla `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `superadmin_communicator_logs`
--
ALTER TABLE `superadmin_communicator_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `superadmin_frontend_pages`
--
ALTER TABLE `superadmin_frontend_pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `system`
--
ALTER TABLE `system`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `task`
--
ALTER TABLE `task`
  MODIFY `idtask` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `tax_rates`
--
ALTER TABLE `tax_rates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=185;

--
-- AUTO_INCREMENT de la tabla `transaction_payments`
--
ALTER TABLE `transaction_payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT de la tabla `transaction_sell_lines`
--
ALTER TABLE `transaction_sell_lines`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT de la tabla `transaction_sell_lines_purchase_lines`
--
ALTER TABLE `transaction_sell_lines_purchase_lines`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=150;

--
-- AUTO_INCREMENT de la tabla `types_of_services`
--
ALTER TABLE `types_of_services`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `units`
--
ALTER TABLE `units`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `user_contact_access`
--
ALTER TABLE `user_contact_access`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `variations`
--
ALTER TABLE `variations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `variation_group_prices`
--
ALTER TABLE `variation_group_prices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `variation_location_details`
--
ALTER TABLE `variation_location_details`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `variation_templates`
--
ALTER TABLE `variation_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `variation_value_templates`
--
ALTER TABLE `variation_value_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `warranties`
--
ALTER TABLE `warranties`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `barcodes`
--
ALTER TABLE `barcodes`
  ADD CONSTRAINT `barcodes_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `brands`
--
ALTER TABLE `brands`
  ADD CONSTRAINT `brands_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `brands_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `business`
--
ALTER TABLE `business`
  ADD CONSTRAINT `business_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  ADD CONSTRAINT `business_default_sales_tax_foreign` FOREIGN KEY (`default_sales_tax`) REFERENCES `tax_rates` (`id`),
  ADD CONSTRAINT `business_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `business_locations`
--
ALTER TABLE `business_locations`
  ADD CONSTRAINT `business_locations_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `business_locations_invoice_layout_id_foreign` FOREIGN KEY (`invoice_layout_id`) REFERENCES `invoice_layouts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `business_locations_invoice_scheme_id_foreign` FOREIGN KEY (`invoice_scheme_id`) REFERENCES `invoice_schemes` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cash_registers`
--
ALTER TABLE `cash_registers`
  ADD CONSTRAINT `cash_registers_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cash_registers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cash_register_transactions`
--
ALTER TABLE `cash_register_transactions`
  ADD CONSTRAINT `cash_register_transactions_cash_register_id_foreign` FOREIGN KEY (`cash_register_id`) REFERENCES `cash_registers` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `categories_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `contacts_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contacts_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `customer_groups`
--
ALTER TABLE `customer_groups`
  ADD CONSTRAINT `customer_groups_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD CONSTRAINT `expense_categories_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `group_sub_taxes`
--
ALTER TABLE `group_sub_taxes`
  ADD CONSTRAINT `group_sub_taxes_group_tax_id_foreign` FOREIGN KEY (`group_tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `group_sub_taxes_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `invoice_layouts`
--
ALTER TABLE `invoice_layouts`
  ADD CONSTRAINT `invoice_layouts_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `invoice_schemes`
--
ALTER TABLE `invoice_schemes`
  ADD CONSTRAINT `invoice_schemes_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `printers`
--
ALTER TABLE `printers`
  ADD CONSTRAINT `printers_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_tax_foreign` FOREIGN KEY (`tax`) REFERENCES `tax_rates` (`id`),
  ADD CONSTRAINT `products_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `product_variations`
--
ALTER TABLE `product_variations`
  ADD CONSTRAINT `product_variations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `purchase_lines`
--
ALTER TABLE `purchase_lines`
  ADD CONSTRAINT `purchase_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_lines_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `res_product_modifier_sets`
--
ALTER TABLE `res_product_modifier_sets`
  ADD CONSTRAINT `res_product_modifier_sets_modifier_set_id_foreign` FOREIGN KEY (`modifier_set_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `res_tables`
--
ALTER TABLE `res_tables`
  ADD CONSTRAINT `res_tables_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `roles`
--
ALTER TABLE `roles`
  ADD CONSTRAINT `roles_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `selling_price_groups`
--
ALTER TABLE `selling_price_groups`
  ADD CONSTRAINT `selling_price_groups_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `stock_adjustment_lines`
--
ALTER TABLE `stock_adjustment_lines`
  ADD CONSTRAINT `stock_adjustment_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_adjustment_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_adjustment_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `tax_rates`
--
ALTER TABLE `tax_rates`
  ADD CONSTRAINT `tax_rates_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tax_rates_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_expense_category_id_foreign` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_expense_for_foreign` FOREIGN KEY (`expense_for`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `business_locations` (`id`),
  ADD CONSTRAINT `transactions_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `transaction_payments`
--
ALTER TABLE `transaction_payments`
  ADD CONSTRAINT `transaction_payments_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `transaction_sell_lines`
--
ALTER TABLE `transaction_sell_lines`
  ADD CONSTRAINT `transaction_sell_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaction_sell_lines_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaction_sell_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaction_sell_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `units`
--
ALTER TABLE `units`
  ADD CONSTRAINT `units_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `units_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `variations`
--
ALTER TABLE `variations`
  ADD CONSTRAINT `variations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `variations_product_variation_id_foreign` FOREIGN KEY (`product_variation_id`) REFERENCES `product_variations` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `variation_group_prices`
--
ALTER TABLE `variation_group_prices`
  ADD CONSTRAINT `variation_group_prices_price_group_id_foreign` FOREIGN KEY (`price_group_id`) REFERENCES `selling_price_groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `variation_group_prices_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `variation_location_details`
--
ALTER TABLE `variation_location_details`
  ADD CONSTRAINT `variation_location_details_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `business_locations` (`id`),
  ADD CONSTRAINT `variation_location_details_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`);

--
-- Filtros para la tabla `variation_templates`
--
ALTER TABLE `variation_templates`
  ADD CONSTRAINT `variation_templates_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `variation_value_templates`
--
ALTER TABLE `variation_value_templates`
  ADD CONSTRAINT `variation_value_templates_variation_template_id_foreign` FOREIGN KEY (`variation_template_id`) REFERENCES `variation_templates` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
