-- MySQL dump 10.13  Distrib 8.2.0, for macos14.0 (arm64)
--
-- Host: 127.0.0.1    Database: snipeit
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accessories`
--

DROP TABLE IF EXISTS `accessories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accessories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `qty` int NOT NULL DEFAULT '0',
  `requestable` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_cost` decimal(20,2) DEFAULT NULL,
  `order_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_id` int unsigned DEFAULT NULL,
  `min_amt` int DEFAULT NULL,
  `manufacturer_id` int DEFAULT NULL,
  `model_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `accessories_company_id_index` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accessories`
--

LOCK TABLES `accessories` WRITE;
/*!40000 ALTER TABLE `accessories` DISABLE KEYS */;
/*!40000 ALTER TABLE `accessories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accessories_users`
--

DROP TABLE IF EXISTS `accessories_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accessories_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `accessory_id` int DEFAULT NULL,
  `assigned_to` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accessories_users`
--

LOCK TABLES `accessories_users` WRITE;
/*!40000 ALTER TABLE `accessories_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `accessories_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `action_logs`
--

DROP TABLE IF EXISTS `action_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `action_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `action_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_id` int DEFAULT NULL,
  `target_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `filename` text COLLATE utf8mb4_unicode_ci,
  `item_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` int NOT NULL,
  `expected_checkin` date DEFAULT NULL,
  `accepted_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `thread_id` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `accept_signature` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `log_meta` text COLLATE utf8mb4_unicode_ci,
  `action_date` datetime DEFAULT NULL,
  `stored_eula` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `action_logs_thread_id_index` (`thread_id`),
  KEY `action_logs_created_at_index` (`created_at`),
  KEY `action_logs_item_type_item_id_action_type_index` (`item_type`,`item_id`,`action_type`),
  KEY `action_logs_target_type_target_id_action_type_index` (`target_type`,`target_id`,`action_type`),
  KEY `action_logs_target_type_target_id_index` (`target_type`,`target_id`),
  KEY `action_logs_company_id_index` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_logs`
--

LOCK TABLES `action_logs` WRITE;
/*!40000 ALTER TABLE `action_logs` DISABLE KEYS */;
INSERT INTO `action_logs` VALUES (1,NULL,'create',NULL,NULL,NULL,NULL,NULL,'App\\Models\\User',1,NULL,NULL,'2023-12-13 06:29:21','2023-12-13 06:29:21',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `action_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_logs`
--

DROP TABLE IF EXISTS `asset_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asset_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `action_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `asset_id` int NOT NULL,
  `checkedout_to` int DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `asset_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `filename` text COLLATE utf8mb4_unicode_ci,
  `requested_at` datetime DEFAULT NULL,
  `accepted_at` datetime DEFAULT NULL,
  `accessory_id` int DEFAULT NULL,
  `accepted_id` int DEFAULT NULL,
  `consumable_id` int DEFAULT NULL,
  `expected_checkin` date DEFAULT NULL,
  `component_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_logs`
--

LOCK TABLES `asset_logs` WRITE;
/*!40000 ALTER TABLE `asset_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_maintenances`
--

DROP TABLE IF EXISTS `asset_maintenances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asset_maintenances` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int unsigned NOT NULL,
  `supplier_id` int unsigned NOT NULL,
  `asset_maintenance_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_warranty` tinyint(1) NOT NULL,
  `start_date` date NOT NULL,
  `completion_date` date DEFAULT NULL,
  `asset_maintenance_time` int DEFAULT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_ci,
  `cost` decimal(20,2) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_maintenances`
--

LOCK TABLES `asset_maintenances` WRITE;
/*!40000 ALTER TABLE `asset_maintenances` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_maintenances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_uploads`
--

DROP TABLE IF EXISTS `asset_uploads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asset_uploads` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `filename` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `asset_id` int NOT NULL,
  `filenotes` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_uploads`
--

LOCK TABLES `asset_uploads` WRITE;
/*!40000 ALTER TABLE `asset_uploads` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_uploads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `asset_tag` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_id` int DEFAULT NULL,
  `serial` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `asset_eol_date` date DEFAULT NULL,
  `eol_explicit` tinyint(1) NOT NULL DEFAULT '0',
  `purchase_cost` decimal(20,2) DEFAULT NULL,
  `order_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_to` int DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `image` text COLLATE utf8mb4_unicode_ci,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `physical` tinyint(1) NOT NULL DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `archived` tinyint(1) DEFAULT '0',
  `warranty_months` int DEFAULT NULL,
  `depreciate` tinyint(1) DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `requestable` tinyint NOT NULL DEFAULT '0',
  `rtd_location_id` int DEFAULT NULL,
  `_snipeit_mac_address_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accepted` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_checkout` datetime DEFAULT NULL,
  `last_checkin` datetime DEFAULT NULL,
  `expected_checkin` date DEFAULT NULL,
  `company_id` int unsigned DEFAULT NULL,
  `assigned_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_audit_date` datetime DEFAULT NULL,
  `next_audit_date` date DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `checkin_counter` int NOT NULL DEFAULT '0',
  `checkout_counter` int NOT NULL DEFAULT '0',
  `requests_counter` int NOT NULL DEFAULT '0',
  `byod` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_rtd_location_id_index` (`rtd_location_id`),
  KEY `assets_assigned_type_assigned_to_index` (`assigned_type`,`assigned_to`),
  KEY `assets_created_at_index` (`created_at`),
  KEY `assets_deleted_at_status_id_index` (`deleted_at`,`status_id`),
  KEY `assets_deleted_at_model_id_index` (`deleted_at`,`model_id`),
  KEY `assets_deleted_at_assigned_type_assigned_to_index` (`deleted_at`,`assigned_type`,`assigned_to`),
  KEY `assets_deleted_at_supplier_id_index` (`deleted_at`,`supplier_id`),
  KEY `assets_deleted_at_location_id_index` (`deleted_at`,`location_id`),
  KEY `assets_deleted_at_rtd_location_id_index` (`deleted_at`,`rtd_location_id`),
  KEY `assets_deleted_at_asset_tag_index` (`deleted_at`,`asset_tag`),
  KEY `assets_deleted_at_name_index` (`deleted_at`,`name`),
  KEY `assets_serial_index` (`serial`),
  KEY `assets_company_id_index` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `eula_text` longtext COLLATE utf8mb4_unicode_ci,
  `use_default_eula` tinyint(1) NOT NULL DEFAULT '0',
  `require_acceptance` tinyint(1) NOT NULL DEFAULT '0',
  `category_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'asset',
  `checkin_email` tinyint(1) NOT NULL DEFAULT '0',
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Misc Software','2023-12-13 06:22:38','2023-12-13 06:22:38',NULL,NULL,NULL,0,0,'license',0,NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checkout_acceptances`
--

DROP TABLE IF EXISTS `checkout_acceptances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checkout_acceptances` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `checkoutable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checkoutable_id` bigint unsigned NOT NULL,
  `assigned_to_id` int DEFAULT NULL,
  `signature_filename` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accepted_at` timestamp NULL DEFAULT NULL,
  `declined_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `stored_eula` text COLLATE utf8mb4_unicode_ci,
  `stored_eula_file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `checkout_acceptances_checkoutable_type_checkoutable_id_index` (`checkoutable_type`,`checkoutable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checkout_acceptances`
--

LOCK TABLES `checkout_acceptances` WRITE;
/*!40000 ALTER TABLE `checkout_acceptances` DISABLE KEYS */;
/*!40000 ALTER TABLE `checkout_acceptances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checkout_requests`
--

DROP TABLE IF EXISTS `checkout_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checkout_requests` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `requestable_id` int NOT NULL,
  `requestable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `canceled_at` datetime DEFAULT NULL,
  `fulfilled_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `checkout_requests_user_id_requestable_id_requestable_type` (`user_id`,`requestable_id`,`requestable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checkout_requests`
--

LOCK TABLES `checkout_requests` WRITE;
/*!40000 ALTER TABLE `checkout_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `checkout_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `companies` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fax` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `companies_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies`
--

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `components`
--

DROP TABLE IF EXISTS `components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `components` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `qty` int NOT NULL DEFAULT '1',
  `order_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_cost` decimal(20,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `min_amt` int DEFAULT NULL,
  `serial` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `components_company_id_index` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `components`
--

LOCK TABLES `components` WRITE;
/*!40000 ALTER TABLE `components` DISABLE KEYS */;
/*!40000 ALTER TABLE `components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `components_assets`
--

DROP TABLE IF EXISTS `components_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `components_assets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `assigned_qty` int DEFAULT '1',
  `component_id` int DEFAULT NULL,
  `asset_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `components_assets`
--

LOCK TABLES `components_assets` WRITE;
/*!40000 ALTER TABLE `components_assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `components_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumables`
--

DROP TABLE IF EXISTS `consumables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consumables` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `qty` int NOT NULL DEFAULT '0',
  `requestable` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_cost` decimal(20,2) DEFAULT NULL,
  `order_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_id` int unsigned DEFAULT NULL,
  `min_amt` int DEFAULT NULL,
  `model_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manufacturer_id` int DEFAULT NULL,
  `item_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `consumables_company_id_index` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumables`
--

LOCK TABLES `consumables` WRITE;
/*!40000 ALTER TABLE `consumables` DISABLE KEYS */;
/*!40000 ALTER TABLE `consumables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumables_users`
--

DROP TABLE IF EXISTS `consumables_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consumables_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `consumable_id` int DEFAULT NULL,
  `assigned_to` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumables_users`
--

LOCK TABLES `consumables_users` WRITE;
/*!40000 ALTER TABLE `consumables_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `consumables_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_field_custom_fieldset`
--

DROP TABLE IF EXISTS `custom_field_custom_fieldset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_field_custom_fieldset` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `custom_field_id` int NOT NULL,
  `custom_fieldset_id` int NOT NULL,
  `order` int NOT NULL,
  `required` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_field_custom_fieldset`
--

LOCK TABLES `custom_field_custom_fieldset` WRITE;
/*!40000 ALTER TABLE `custom_field_custom_fieldset` DISABLE KEYS */;
INSERT INTO `custom_field_custom_fieldset` VALUES (1,1,1,1,0);
/*!40000 ALTER TABLE `custom_field_custom_fieldset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_fields`
--

DROP TABLE IF EXISTS `custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_fields` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `format` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `element` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `field_values` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `field_encrypted` tinyint(1) NOT NULL DEFAULT '0',
  `db_column` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `help_text` text COLLATE utf8mb4_unicode_ci,
  `show_in_email` tinyint(1) NOT NULL DEFAULT '0',
  `show_in_requestable_list` tinyint(1) DEFAULT '0',
  `is_unique` tinyint(1) DEFAULT '0',
  `display_in_user_view` tinyint(1) DEFAULT '0',
  `auto_add_to_fieldsets` tinyint(1) DEFAULT '0',
  `show_in_listview` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_fields`
--

LOCK TABLES `custom_fields` WRITE;
/*!40000 ALTER TABLE `custom_fields` DISABLE KEYS */;
INSERT INTO `custom_fields` VALUES (1,'MAC Address','regex:/^[a-fA-F0-9]{2}:[a-fA-F0-9]{2}:[a-fA-F0-9]{2}:[a-fA-F0-9]{2}:[a-fA-F0-9]{2}:[a-fA-F0-9]{2}$/','text',NULL,'2023-12-13 06:22:37',NULL,NULL,0,'_snipeit_mac_address_1',NULL,0,0,0,0,0,0);
/*!40000 ALTER TABLE `custom_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_fieldsets`
--

DROP TABLE IF EXISTS `custom_fieldsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_fieldsets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_fieldsets`
--

LOCK TABLES `custom_fieldsets` WRITE;
/*!40000 ALTER TABLE `custom_fieldsets` DISABLE KEYS */;
INSERT INTO `custom_fieldsets` VALUES (1,'Asset with MAC Address',NULL,NULL,NULL);
/*!40000 ALTER TABLE `custom_fieldsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fax` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int NOT NULL,
  `company_id` int DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `manager_id` int DEFAULT NULL,
  `notes` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `departments_company_id_index` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `depreciations`
--

DROP TABLE IF EXISTS `depreciations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `depreciations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `months` int NOT NULL,
  `depreciation_min` decimal(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `depreciations`
--

LOCK TABLES `depreciations` WRITE;
/*!40000 ALTER TABLE `depreciations` DISABLE KEYS */;
/*!40000 ALTER TABLE `depreciations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imports`
--

DROP TABLE IF EXISTS `imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `imports` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filesize` int NOT NULL,
  `import_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `header_row` text COLLATE utf8mb4_unicode_ci,
  `first_row` text COLLATE utf8mb4_unicode_ci,
  `field_map` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imports`
--

LOCK TABLES `imports` WRITE;
/*!40000 ALTER TABLE `imports` DISABLE KEYS */;
/*!40000 ALTER TABLE `imports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kits`
--

DROP TABLE IF EXISTS `kits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kits` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kits`
--

LOCK TABLES `kits` WRITE;
/*!40000 ALTER TABLE `kits` DISABLE KEYS */;
/*!40000 ALTER TABLE `kits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kits_accessories`
--

DROP TABLE IF EXISTS `kits_accessories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kits_accessories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `kit_id` int DEFAULT NULL,
  `accessory_id` int DEFAULT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kits_accessories`
--

LOCK TABLES `kits_accessories` WRITE;
/*!40000 ALTER TABLE `kits_accessories` DISABLE KEYS */;
/*!40000 ALTER TABLE `kits_accessories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kits_consumables`
--

DROP TABLE IF EXISTS `kits_consumables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kits_consumables` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `kit_id` int DEFAULT NULL,
  `consumable_id` int DEFAULT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kits_consumables`
--

LOCK TABLES `kits_consumables` WRITE;
/*!40000 ALTER TABLE `kits_consumables` DISABLE KEYS */;
/*!40000 ALTER TABLE `kits_consumables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kits_licenses`
--

DROP TABLE IF EXISTS `kits_licenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kits_licenses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `kit_id` int DEFAULT NULL,
  `license_id` int DEFAULT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kits_licenses`
--

LOCK TABLES `kits_licenses` WRITE;
/*!40000 ALTER TABLE `kits_licenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `kits_licenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kits_models`
--

DROP TABLE IF EXISTS `kits_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kits_models` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `kit_id` int DEFAULT NULL,
  `model_id` int DEFAULT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kits_models`
--

LOCK TABLES `kits_models` WRITE;
/*!40000 ALTER TABLE `kits_models` DISABLE KEYS */;
/*!40000 ALTER TABLE `kits_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `license_seats`
--

DROP TABLE IF EXISTS `license_seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `license_seats` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `license_id` int DEFAULT NULL,
  `assigned_to` int DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `asset_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `license_seats_license_id_index` (`license_id`),
  KEY `license_seats_assigned_to_license_id_index` (`assigned_to`,`license_id`),
  KEY `license_seats_asset_id_license_id_index` (`asset_id`,`license_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `license_seats`
--

LOCK TABLES `license_seats` WRITE;
/*!40000 ALTER TABLE `license_seats` DISABLE KEYS */;
/*!40000 ALTER TABLE `license_seats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `licenses`
--

DROP TABLE IF EXISTS `licenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `licenses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `purchase_date` date DEFAULT NULL,
  `purchase_cost` decimal(20,2) DEFAULT NULL,
  `order_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seats` int NOT NULL DEFAULT '1',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `user_id` int DEFAULT NULL,
  `depreciation_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `license_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `license_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `depreciate` tinyint(1) DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `purchase_order` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `termination_date` date DEFAULT NULL,
  `maintained` tinyint(1) DEFAULT NULL,
  `reassignable` tinyint(1) NOT NULL DEFAULT '1',
  `company_id` int unsigned DEFAULT NULL,
  `manufacturer_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `licenses_company_id_index` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `licenses`
--

LOCK TABLES `licenses` WRITE;
/*!40000 ALTER TABLE `licenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `licenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fax` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `currency` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ldap_ou` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manager_id` int DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_attempts`
--

DROP TABLE IF EXISTS `login_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_attempts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remote_ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `successful` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_attempts`
--

LOCK TABLES `login_attempts` WRITE;
/*!40000 ALTER TABLE `login_attempts` DISABLE KEYS */;
INSERT INTO `login_attempts` VALUES (1,'testuser','172.21.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',1,'2023-12-13 06:29:21',NULL);
/*!40000 ALTER TABLE `login_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturers`
--

DROP TABLE IF EXISTS `manufacturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manufacturers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `support_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `warranty_lookup_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `support_phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `support_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturers`
--

LOCK TABLES `manufacturers` WRITE;
/*!40000 ALTER TABLE `manufacturers` DISABLE KEYS */;
/*!40000 ALTER TABLE `manufacturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=365 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2012_12_06_225921_migration_cartalyst_sentry_install_users',1),(2,'2012_12_06_225929_migration_cartalyst_sentry_install_groups',1),(3,'2012_12_06_225945_migration_cartalyst_sentry_install_users_groups_pivot',1),(4,'2012_12_06_225988_migration_cartalyst_sentry_install_throttle',1),(5,'2013_03_23_193214_update_users_table',1),(6,'2013_11_13_075318_create_models_table',1),(7,'2013_11_13_075335_create_categories_table',1),(8,'2013_11_13_075347_create_manufacturers_table',1),(9,'2013_11_15_015858_add_user_id_to_categories',1),(10,'2013_11_15_112701_add_user_id_to_manufacturers',1),(11,'2013_11_15_190327_create_assets_table',1),(12,'2013_11_15_190357_create_temp_licenses_table',1),(13,'2013_11_15_201848_add_license_name_to_licenses',1),(14,'2013_11_16_040323_create_depreciations_table',1),(15,'2013_11_16_042851_add_depreciation_id_to_models',1),(16,'2013_11_16_084923_add_user_id_to_models',1),(17,'2013_11_16_103258_create_locations_table',1),(18,'2013_11_16_103336_add_location_id_to_assets',1),(19,'2013_11_16_103407_add_checkedout_to_to_assets',1),(20,'2013_11_16_103425_create_history_table',1),(21,'2013_11_17_054359_drop_licenses_table',1),(22,'2013_11_17_054526_add_physical_to_assets',1),(23,'2013_11_17_055126_create_settings_table',1),(24,'2013_11_17_062634_add_license_to_assets',1),(25,'2013_11_18_134332_add_contacts_to_users',1),(26,'2013_11_18_142847_add_info_to_locations',1),(27,'2013_11_18_152942_remove_location_id_from_asset',1),(28,'2013_11_18_164423_set_nullvalues_for_user',1),(29,'2013_11_19_013337_create_asset_logs_table',1),(30,'2013_11_19_061409_edit_added_on_asset_logs_table',1),(31,'2013_11_19_062250_edit_location_id_asset_logs_table',1),(32,'2013_11_20_055822_add_soft_delete_on_assets',1),(33,'2013_11_20_121404_add_soft_delete_on_locations',1),(34,'2013_11_20_123137_add_soft_delete_on_manufacturers',1),(35,'2013_11_20_123725_add_soft_delete_on_categories',1),(36,'2013_11_20_130248_create_status_labels',1),(37,'2013_11_20_130830_add_status_id_on_assets_table',1),(38,'2013_11_20_131544_add_status_type_on_status_labels',1),(39,'2013_11_20_134103_add_archived_to_assets',1),(40,'2013_11_21_002321_add_uploads_table',1),(41,'2013_11_21_024531_remove_deployable_boolean_from_status_labels',1),(42,'2013_11_22_075308_add_option_label_to_settings_table',1),(43,'2013_11_22_213400_edits_to_settings_table',1),(44,'2013_11_25_013244_recreate_licenses_table',1),(45,'2013_11_25_031458_create_license_seats_table',1),(46,'2013_11_25_032022_add_type_to_actionlog_table',1),(47,'2013_11_25_033008_delete_bad_licenses_table',1),(48,'2013_11_25_033131_create_new_licenses_table',1),(49,'2013_11_25_033534_add_licensed_to_licenses_table',1),(50,'2013_11_25_101308_add_warrantee_to_assets_table',1),(51,'2013_11_25_104343_alter_warranty_column_on_assets',1),(52,'2013_11_25_150450_drop_parent_from_categories',1),(53,'2013_11_25_151920_add_depreciate_to_assets',1),(54,'2013_11_25_152903_add_depreciate_to_licenses_table',1),(55,'2013_11_26_211820_drop_license_from_assets_table',1),(56,'2013_11_27_062510_add_note_to_asset_logs_table',1),(57,'2013_12_01_113426_add_filename_to_asset_log',1),(58,'2013_12_06_094618_add_nullable_to_licenses_table',1),(59,'2013_12_10_084038_add_eol_on_models_table',1),(60,'2013_12_12_055218_add_manager_to_users_table',1),(61,'2014_01_28_031200_add_qr_code_to_settings_table',1),(62,'2014_02_13_183016_add_qr_text_to_settings_table',1),(63,'2014_05_24_093839_alter_default_license_depreciation_id',1),(64,'2014_05_27_231658_alter_default_values_licenses',1),(65,'2014_06_19_191508_add_asset_name_to_settings',1),(66,'2014_06_20_004847_make_asset_log_checkedout_to_nullable',1),(67,'2014_06_20_005050_make_asset_log_purchasedate_to_nullable',1),(68,'2014_06_24_003011_add_suppliers',1),(69,'2014_06_24_010742_add_supplier_id_to_asset',1),(70,'2014_06_24_012839_add_zip_to_supplier',1),(71,'2014_06_24_033908_add_url_to_supplier',1),(72,'2014_07_08_054116_add_employee_id_to_users',1),(73,'2014_07_09_134316_add_requestable_to_assets',1),(74,'2014_07_17_085822_add_asset_to_software',1),(75,'2014_07_17_161625_make_asset_id_in_logs_nullable',1),(76,'2014_08_12_053504_alpha_0_4_2_release',1),(77,'2014_08_17_083523_make_location_id_nullable',1),(78,'2014_10_16_200626_add_rtd_location_to_assets',1),(79,'2014_10_24_000417_alter_supplier_state_to_32',1),(80,'2014_10_24_015641_add_display_checkout_date',1),(81,'2014_10_28_222654_add_avatar_field_to_users_table',1),(82,'2014_10_29_045924_add_image_field_to_models_table',1),(83,'2014_11_01_214955_add_eol_display_to_settings',1),(84,'2014_11_04_231416_update_group_field_for_reporting',1),(85,'2014_11_05_212408_add_fields_to_licenses',1),(86,'2014_11_07_021042_add_image_to_supplier',1),(87,'2014_11_20_203007_add_username_to_user',1),(88,'2014_11_20_223947_add_auto_to_settings',1),(89,'2014_11_20_224421_add_prefix_to_settings',1),(90,'2014_11_21_104401_change_licence_type',1),(91,'2014_12_09_082500_add_fields_maintained_term_to_licenses',1),(92,'2015_02_04_155757_increase_user_field_lengths',1),(93,'2015_02_07_013537_add_soft_deleted_to_log',1),(94,'2015_02_10_040958_fix_bad_assigned_to_ids',1),(95,'2015_02_10_053310_migrate_data_to_new_statuses',1),(96,'2015_02_11_044104_migrate_make_license_assigned_null',1),(97,'2015_02_11_104406_migrate_create_requests_table',1),(98,'2015_02_12_001312_add_mac_address_to_asset',1),(99,'2015_02_12_024100_change_license_notes_type',1),(100,'2015_02_17_231020_add_localonly_to_settings',1),(101,'2015_02_19_222322_add_logo_and_colors_to_settings',1),(102,'2015_02_24_072043_add_alerts_to_settings',1),(103,'2015_02_25_022931_add_eula_fields',1),(104,'2015_02_25_204513_add_accessories_table',1),(105,'2015_02_26_091228_add_accessories_user_table',1),(106,'2015_02_26_115128_add_deleted_at_models',1),(107,'2015_02_26_233005_add_category_type',1),(108,'2015_03_01_231912_update_accepted_at_to_acceptance_id',1),(109,'2015_03_05_011929_add_qr_type_to_settings',1),(110,'2015_03_18_055327_add_note_to_user',1),(111,'2015_04_29_234704_add_slack_to_settings',1),(112,'2015_05_04_085151_add_parent_id_to_locations_table',1),(113,'2015_05_22_124421_add_reassignable_to_licenses',1),(114,'2015_06_10_003314_fix_default_for_user_notes',1),(115,'2015_06_10_003554_create_consumables',1),(116,'2015_06_15_183253_move_email_to_username',1),(117,'2015_06_23_070346_make_email_nullable',1),(118,'2015_06_26_213716_create_asset_maintenances_table',1),(119,'2015_07_04_212443_create_custom_fields_table',1),(120,'2015_07_09_014359_add_currency_to_settings_and_locations',1),(121,'2015_07_21_122022_add_expected_checkin_date_to_asset_logs',1),(122,'2015_07_24_093845_add_checkin_email_to_category_table',1),(123,'2015_07_25_055415_remove_email_unique_constraint',1),(124,'2015_07_29_230054_add_thread_id_to_asset_logs_table',1),(125,'2015_07_31_015430_add_accepted_to_assets',1),(126,'2015_09_09_195301_add_custom_css_to_settings',1),(127,'2015_09_21_235926_create_custom_field_custom_fieldset',1),(128,'2015_09_22_000104_create_custom_fieldsets',1),(129,'2015_09_22_003321_add_fieldset_id_to_assets',1),(130,'2015_09_22_003413_migrate_mac_address',1),(131,'2015_09_28_003314_fix_default_purchase_order',1),(132,'2015_10_01_024551_add_accessory_consumable_price_info',1),(133,'2015_10_12_192706_add_brand_to_settings',1),(134,'2015_10_22_003314_fix_defaults_accessories',1),(135,'2015_10_23_182625_add_checkout_time_and_expected_checkout_date_to_assets',1),(136,'2015_11_05_061015_create_companies_table',1),(137,'2015_11_05_061115_add_company_id_to_consumables_table',1),(138,'2015_11_05_183749_image',1),(139,'2015_11_06_092038_add_company_id_to_accessories_table',1),(140,'2015_11_06_100045_add_company_id_to_users_table',1),(141,'2015_11_06_134742_add_company_id_to_licenses_table',1),(142,'2015_11_08_035832_add_company_id_to_assets_table',1),(143,'2015_11_08_222305_add_ldap_fields_to_settings',1),(144,'2015_11_15_151803_add_full_multiple_companies_support_to_settings_table',1),(145,'2015_11_26_195528_import_ldap_settings',1),(146,'2015_11_30_191504_remove_fk_company_id',1),(147,'2015_12_21_193006_add_ldap_server_cert_ignore_to_settings_table',1),(148,'2015_12_30_233509_add_timestamp_and_userId_to_custom_fields',1),(149,'2015_12_30_233658_add_timestamp_and_userId_to_custom_fieldsets',1),(150,'2016_01_28_041048_add_notes_to_models',1),(151,'2016_02_19_070119_add_remember_token_to_users_table',1),(152,'2016_02_19_073625_create_password_resets_table',1),(153,'2016_03_02_193043_add_ldap_flag_to_users',1),(154,'2016_03_02_220517_update_ldap_filter_to_longer_field',1),(155,'2016_03_08_225351_create_components_table',1),(156,'2016_03_09_024038_add_min_stock_to_tables',1),(157,'2016_03_10_133849_add_locale_to_users',1),(158,'2016_03_10_135519_add_locale_to_settings',1),(159,'2016_03_11_185621_add_label_settings_to_settings',1),(160,'2016_03_22_125911_fix_custom_fields_regexes',1),(161,'2016_04_28_141554_add_show_to_users',1),(162,'2016_05_16_164733_add_model_mfg_to_consumable',1),(163,'2016_05_19_180351_add_alt_barcode_settings',1),(164,'2016_05_19_191146_add_alter_interval',1),(165,'2016_05_19_192226_add_inventory_threshold',1),(166,'2016_05_20_024859_remove_option_keys_from_settings_table',1),(167,'2016_05_20_143758_remove_option_value_from_settings_table',1),(168,'2016_06_01_000001_create_oauth_auth_codes_table',1),(169,'2016_06_01_000002_create_oauth_access_tokens_table',1),(170,'2016_06_01_000003_create_oauth_refresh_tokens_table',1),(171,'2016_06_01_000004_create_oauth_clients_table',1),(172,'2016_06_01_000005_create_oauth_personal_access_clients_table',1),(173,'2016_06_01_140218_add_email_domain_and_format_to_settings',1),(174,'2016_06_22_160725_add_user_id_to_maintenances',1),(175,'2016_07_13_150015_add_is_ad_to_settings',1),(176,'2016_07_14_153609_add_ad_domain_to_settings',1),(177,'2016_07_22_003348_fix_custom_fields_regex_stuff',1),(178,'2016_07_22_054850_one_more_mac_addr_fix',1),(179,'2016_07_22_143045_add_port_to_ldap_settings',1),(180,'2016_07_22_153432_add_tls_to_ldap_settings',1),(181,'2016_07_27_211034_add_zerofill_to_settings',1),(182,'2016_08_02_124944_add_color_to_statuslabel',1),(183,'2016_08_04_134500_add_disallow_ldap_pw_sync_to_settings',1),(184,'2016_08_09_002225_add_manufacturer_to_licenses',1),(185,'2016_08_12_121613_add_manufacturer_to_accessories_table',1),(186,'2016_08_23_143353_add_new_fields_to_custom_fields',1),(187,'2016_08_23_145619_add_show_in_nav_to_status_labels',1),(188,'2016_08_30_084634_make_purchase_cost_nullable',1),(189,'2016_09_01_141051_add_requestable_to_asset_model',1),(190,'2016_09_02_001448_create_checkout_requests_table',1),(191,'2016_09_04_180400_create_actionlog_table',1),(192,'2016_09_04_182149_migrate_asset_log_to_action_log',1),(193,'2016_09_19_235935_fix_fieldtype_for_target_type',1),(194,'2016_09_23_140722_fix_modelno_in_consumables_to_string',1),(195,'2016_09_28_231359_add_company_to_logs',1),(196,'2016_10_14_130709_fix_order_number_to_varchar',1),(197,'2016_10_16_015024_rename_modelno_to_model_number',1),(198,'2016_10_16_015211_rename_consumable_modelno_to_model_number',1),(199,'2016_10_16_143235_rename_model_note_to_notes',1),(200,'2016_10_16_165052_rename_component_total_qty_to_qty',1),(201,'2016_10_19_145520_fix_order_number_in_components_to_string',1),(202,'2016_10_27_151715_add_serial_to_components',1),(203,'2016_10_27_213251_increase_serial_field_capacity',1),(204,'2016_10_29_002724_enable_2fa_fields',1),(205,'2016_10_29_082408_add_signature_to_acceptance',1),(206,'2016_11_01_030818_fix_forgotten_filename_in_action_logs',1),(207,'2016_11_13_020954_rename_component_serial_number_to_serial',1),(208,'2016_11_16_172119_increase_purchase_cost_size',1),(209,'2016_11_17_161317_longer_state_field_in_location',1),(210,'2016_11_17_193706_add_model_number_to_accessories',1),(211,'2016_11_24_160405_add_missing_target_type_to_logs_table',1),(212,'2016_12_07_173720_increase_size_of_state_in_suppliers',1),(213,'2016_12_19_004212_adjust_locale_length_to_10',1),(214,'2016_12_19_133936_extend_phone_lengths_in_supplier_and_elsewhere',1),(215,'2016_12_27_212631_make_asset_assigned_to_polymorphic',1),(216,'2017_01_09_040429_create_locations_ldap_query_field',1),(217,'2017_01_14_002418_create_imports_table',1),(218,'2017_01_25_063357_fix_utf8_custom_field_column_names',1),(219,'2017_03_03_154632_add_time_date_display_to_settings',1),(220,'2017_03_10_210807_add_fields_to_manufacturer',1),(221,'2017_05_08_195520_increase_size_of_field_values_in_custom_fields',1),(222,'2017_05_22_204422_create_departments',1),(223,'2017_05_22_233509_add_manager_to_locations_table',1),(224,'2017_06_14_122059_add_next_autoincrement_to_settings',1),(225,'2017_06_18_151753_add_header_and_first_row_to_importer_table',1),(226,'2017_07_07_191533_add_login_text',1),(227,'2017_07_25_130710_add_thumbsize_to_settings',1),(228,'2017_08_03_160105_set_asset_archived_to_zero_default',1),(229,'2017_08_22_180636_add_secure_password_options',1),(230,'2017_08_25_074822_add_auditing_tables',1),(231,'2017_08_25_101435_add_auditing_to_settings',1),(232,'2017_09_18_225619_fix_assigned_type_not_being_nulled',1),(233,'2017_10_03_015503_drop_foreign_keys',1),(234,'2017_10_10_123504_allow_nullable_depreciation_id_in_models',1),(235,'2017_10_17_133709_add_display_url_to_settings',1),(236,'2017_10_19_120002_add_custom_forgot_password_url',1),(237,'2017_10_19_130406_add_image_and_supplier_to_accessories',1),(238,'2017_10_20_234129_add_location_indices_to_assets',1),(239,'2017_10_25_202930_add_images_uploads_to_locations_manufacturers_etc',1),(240,'2017_10_27_180947_denorm_asset_locations',1),(241,'2017_10_27_192423_migrate_denormed_asset_locations',1),(242,'2017_10_30_182938_add_address_to_user',1),(243,'2017_11_08_025918_add_alert_menu_setting',1),(244,'2017_11_08_123942_labels_display_company_name',1),(245,'2017_12_12_010457_normalize_asset_last_audit_date',1),(246,'2017_12_12_033618_add_actionlog_meta',1),(247,'2017_12_26_170856_re_normalize_last_audit',1),(248,'2018_01_17_184354_add_archived_in_list_setting',1),(249,'2018_01_19_203121_add_dashboard_message_to_settings',1),(250,'2018_01_24_062633_add_footer_settings_to_settings',1),(251,'2018_01_24_093426_add_modellist_preferenc',1),(252,'2018_02_22_160436_add_remote_user_settings',1),(253,'2018_03_03_011032_add_theme_to_settings',1),(254,'2018_03_06_054937_add_default_flag_on_statuslabels',1),(255,'2018_03_23_212048_add_display_in_email_to_custom_fields',1),(256,'2018_03_24_030738_add_show_images_in_email_setting',1),(257,'2018_03_24_050108_add_cc_alerts',1),(258,'2018_03_29_053618_add_canceled_at_and_fulfilled_at_in_requests',1),(259,'2018_03_29_070121_add_drop_unique_requests',1),(260,'2018_03_29_070511_add_new_index_requestable',1),(261,'2018_04_02_150700_labels_display_model_name',1),(262,'2018_04_16_133902_create_custom_field_default_values_table',1),(263,'2018_05_04_073223_add_category_to_licenses',1),(264,'2018_05_04_075235_add_update_license_category',1),(265,'2018_05_08_031515_add_gdpr_privacy_footer',1),(266,'2018_05_14_215229_add_indexes',1),(267,'2018_05_14_223646_add_indexes_to_assets',1),(268,'2018_05_14_233638_denorm_counters_on_assets',1),(269,'2018_05_16_153409_add_first_counter_totals_to_assets',1),(270,'2018_06_21_134622_add_version_footer',1),(271,'2018_07_05_215440_add_unique_serial_option_to_settings',1),(272,'2018_07_17_005911_create_login_attempts_table',1),(273,'2018_07_24_154348_add_logo_to_print_assets',1),(274,'2018_07_28_023826_create_checkout_acceptances_table',1),(275,'2018_08_20_204842_add_depreciation_option_to_settings',1),(276,'2018_09_10_082212_create_checkout_acceptances_for_unaccepted_assets',1),(277,'2018_10_18_191228_add_kits_licenses_table',1),(278,'2018_10_19_153910_add_kits_table',1),(279,'2018_10_19_154013_add_kits_models_table',1),(280,'2018_12_05_211936_add_favicon_to_settings',1),(281,'2018_12_05_212119_add_email_logo_to_settings',1),(282,'2019_02_07_185953_add_kits_consumables_table',1),(283,'2019_02_07_190030_add_kits_accessories_table',1),(284,'2019_02_12_182750_add_actiondate_to_actionlog',1),(285,'2019_02_14_154310_change_auto_increment_prefix_to_nullable',1),(286,'2019_02_16_143518_auto_increment_back_to_string',1),(287,'2019_02_17_205048_add_label_logo_to_settings',1),(288,'2019_02_20_234421_make_serial_nullable',1),(289,'2019_02_21_224703_make_fields_nullable_for_integrity',1),(290,'2019_04_06_060145_add_user_skin_setting',1),(291,'2019_04_06_205355_add_setting_allow_user_skin',1),(292,'2019_06_12_184327_rename_groups_table',1),(293,'2019_07_23_140906_add_show_assigned_assets_to_settings',1),(294,'2019_08_20_084049_add_custom_remote_user_header',1),(295,'2019_12_04_223111_passport_upgrade',1),(296,'2020_02_04_172100_add_ad_append_domain_settings',1),(297,'2020_04_29_222305_add_saml_fields_to_settings',1),(298,'2020_08_11_200712_add_saml_key_rollover',1),(299,'2020_10_22_233743_move_accessory_checkout_note_to_join_table',1),(300,'2020_10_23_161736_fix_zero_values_for_locations',1),(301,'2020_11_18_214827_widen_license_serial_field',1),(302,'2020_12_14_233815_add_digit_separator_to_settings',1),(303,'2020_12_18_090026_swap_target_type_index_order',1),(304,'2020_12_21_153235_update_min_password',1),(305,'2020_12_21_210105_fix_bad_ldap_server_url_for_v5',1),(306,'2021_02_05_172502_add_provider_to_oauth_table',1),(307,'2021_03_18_184102_adds_several_ldap_fields',1),(308,'2021_04_07_001811_add_ldap_dept',1),(309,'2021_04_14_180125_add_ids_to_tables',1),(310,'2021_06_07_155421_add_serial_number_indexes',1),(311,'2021_06_07_155436_add_company_id_indexes',1),(312,'2021_07_28_031345_add_client_side_l_d_a_p_cert_to_settings',1),(313,'2021_07_28_040554_add_client_side_l_d_a_p_key_to_settings',1),(314,'2021_08_11_005206_add_depreciation_minimum_value',1),(315,'2021_08_24_124354_make_ldap_client_certs_nullable',1),(316,'2021_09_20_183216_change_default_label_to_nullable',1),(317,'2021_12_27_151849_change_supplier_address_length',1),(318,'2022_01_10_182548_add_license_id_index_to_license_seats',1),(319,'2022_02_03_214958_blank_out_ldap_active_flag',1),(320,'2022_02_16_152431_add_unique_constraint_to_custom_field',1),(321,'2022_03_03_225655_add_notes_to_accessories',1),(322,'2022_03_03_225754_add_notes_to_components',1),(323,'2022_03_03_225824_add_notes_to_consumables',1),(324,'2022_03_04_080836_add_remote_to_user',1),(325,'2022_03_09_001334_add_eula_to_checkout_acceptance',1),(326,'2022_03_10_175740_add_eula_to_action_logs',1),(327,'2022_03_21_162724_adds_ldap_manager',1),(328,'2022_04_05_135340_add_primary_key_to_custom_fields_pivot',1),(329,'2022_05_16_235350_remove_stored_eula_field',1),(330,'2022_06_23_164407_add_user_id_to_users',1),(331,'2022_06_28_234539_add_username_index_to_users',1),(332,'2022_07_07_010406_add_indexes_to_license_seats',1),(333,'2022_08_10_141328_add_notes_denorm_to_consumables_users',1),(334,'2022_08_25_213308_adds_ldap_default_group_to_settings_table',1),(335,'2022_09_29_040231_add_chart_type_to_settings',1),(336,'2022_10_05_163044_add_start_termination_date_to_users',1),(337,'2022_10_25_193823_add_externalid_to_users',1),(338,'2022_10_25_215520_add_label2_settings',1),(339,'2022_11_07_134348_add_display_to_user_in_custom_fields',1),(340,'2022_11_15_232525_adds_should_autoassign_bool_to_users_table',1),(341,'2022_12_20_171851_fix_nullable_migration_for_settings',1),(342,'2023_01_18_122534_add_byod_to_assets',1),(343,'2023_01_21_225350_add_eol_date_on_assets_table',1),(344,'2023_01_23_232933_add_vip_to_users',1),(345,'2023_02_12_224353_fix_unescaped_customfields_format',1),(346,'2023_02_28_173527_adds_webhook_option_to_settings_table',1),(347,'2023_03_21_215218_update_slack_setting',1),(348,'2023_04_12_135822_add_supplier_to_components',1),(349,'2023_04_25_085912_add_autoadd_to_customfields',1),(350,'2023_04_25_181817_adds_ldap_location_to_settings_table',1),(351,'2023_04_26_160235_add_warranty_url_to_manufacturers',1),(352,'2023_05_08_132921_increase_state_to_more_than_3',1),(353,'2023_05_10_001836_add_google_auth_to_settings',1),(354,'2023_07_05_092237_change_settings_table_increase_saml_idp_metadata_size',1),(355,'2023_07_06_092507_add_phone_fax_to_locations',1),(356,'2023_07_13_052204_denormalized_eol_and_add_column_for_explicit_date_to_assets',1),(357,'2023_07_14_004221_add_show_in_list_view_to_custom_fields',1),(358,'2023_08_01_174150_change_webhook_settings_variable_type',1),(359,'2023_08_13_172600_add_email_to_companies',1),(360,'2023_08_17_202638_add_last_checkin_to_assets',1),(361,'2023_08_21_064609_add_name_ordering_to_settings',1),(362,'2023_08_21_181742_add_min_amt_to_models_table',1),(363,'2023_09_13_200913_fix_asset_model_min_qty_nullability',1),(364,'2023_10_25_064324_add_show_in_requestable_to_custom_fields',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `models`
--

DROP TABLE IF EXISTS `models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `models` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_amt` int DEFAULT NULL,
  `manufacturer_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `depreciation_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `eol` int DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deprecated_mac_address` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `fieldset_id` int DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `requestable` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `models`
--

LOCK TABLES `models` WRITE;
/*!40000 ALTER TABLE `models` DISABLE KEYS */;
/*!40000 ALTER TABLE `models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `models_custom_fields`
--

DROP TABLE IF EXISTS `models_custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `models_custom_fields` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `asset_model_id` int NOT NULL,
  `custom_field_id` int NOT NULL,
  `default_value` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `models_custom_fields`
--

LOCK TABLES `models_custom_fields` WRITE;
/*!40000 ALTER TABLE `models_custom_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `models_custom_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `client_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` VALUES ('15bb791ae7bb07625443cde585c7ac801aea61f8b1eee5bd3ebdd047bd5cb12eb06f8cf5a44b5426',1,3,'test','[]',0,'2023-12-13 06:30:48','2023-12-13 06:30:48','2043-12-13 06:30:48'),('d129ea544efc9205f2899db5054d533cafd3db18d5c0c637b71e9504997849b04126f911585d71a6',1,3,'test2','[]',1,'2023-12-13 20:49:39','2023-12-13 20:49:39','2043-12-13 20:49:39');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_auth_codes`
--

LOCK TABLES `oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_clients`
--

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` VALUES (1,NULL,'Snipe-IT Personal Access Client','L802C8CeKCZ0daTxQB0YKRGEi06e8csNKKqXnAvi',NULL,'http://localhost',1,0,0,'2023-12-13 06:27:57','2023-12-13 06:27:57'),(2,NULL,'Snipe-IT Password Grant Client','IRam6Js8ntatxSz7HE4dkOnlB5FSvFi8qhRZRdyU','users','http://localhost',0,1,0,'2023-12-13 06:27:57','2023-12-13 06:27:57'),(3,NULL,'Snipe-IT Personal Access Client','TRf8V4chbbjE1mk88VkCHfw1qa5BJ9qEd1TkAgeC',NULL,'http://localhost',1,0,0,'2023-12-13 06:28:06','2023-12-13 06:28:06'),(4,NULL,'Snipe-IT Password Grant Client','ktYLycopoq5PiF1Y76BEkNJ0yhKxlB1hGKx6tc8W','users','http://localhost',0,1,0,'2023-12-13 06:28:06','2023-12-13 06:28:06');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_personal_access_clients`
--

LOCK TABLES `oauth_personal_access_clients` WRITE;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` VALUES (1,1,'2023-12-13 06:27:57','2023-12-13 06:27:57'),(2,3,'2023-12-13 06:28:06','2023-12-13 06:28:06');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_tokens`
--

LOCK TABLES `oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL,
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_groups`
--

DROP TABLE IF EXISTS `permission_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_groups`
--

LOCK TABLES `permission_groups` WRITE;
/*!40000 ALTER TABLE `permission_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `permission_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requested_assets`
--

DROP TABLE IF EXISTS `requested_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requested_assets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int NOT NULL,
  `user_id` int NOT NULL,
  `accepted_at` datetime DEFAULT NULL,
  `denied_at` datetime DEFAULT NULL,
  `notes` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requested_assets`
--

LOCK TABLES `requested_assets` WRITE;
/*!40000 ALTER TABLE `requested_assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `requested_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requests` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `request_code` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requests`
--

LOCK TABLES `requests` WRITE;
/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `per_page` int NOT NULL DEFAULT '20',
  `site_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Snipe IT Asset Management',
  `qr_code` int DEFAULT NULL,
  `qr_text` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_asset_name` int DEFAULT NULL,
  `display_checkout_date` int DEFAULT NULL,
  `display_eol` int DEFAULT NULL,
  `auto_increment_assets` int NOT NULL DEFAULT '0',
  `auto_increment_prefix` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `load_remote` tinyint(1) NOT NULL DEFAULT '1',
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `header_color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alert_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alerts_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `default_eula_text` longtext COLLATE utf8mb4_unicode_ci,
  `barcode_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'QRCODE',
  `webhook_endpoint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `webhook_channel` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `webhook_botname` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `webhook_selected` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'slack',
  `default_currency` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_css` text COLLATE utf8mb4_unicode_ci,
  `brand` tinyint NOT NULL DEFAULT '1',
  `ldap_enabled` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ldap_server` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ldap_uname` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ldap_pword` longtext COLLATE utf8mb4_unicode_ci,
  `ldap_basedn` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ldap_default_group` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ldap_filter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ldap_username_field` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'samaccountname',
  `ldap_lname_field` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'sn',
  `ldap_fname_field` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'givenname',
  `ldap_auth_filter_query` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'uid=',
  `ldap_version` int DEFAULT '3',
  `ldap_active_flag` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ldap_dept` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ldap_emp_num` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ldap_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ldap_phone_field` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ldap_jobtitle` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ldap_manager` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ldap_country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ldap_location` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_multiple_companies_support` tinyint(1) NOT NULL DEFAULT '0',
  `ldap_server_cert_ignore` tinyint(1) NOT NULL DEFAULT '0',
  `locale` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT 'en',
  `labels_per_page` tinyint NOT NULL DEFAULT '30',
  `labels_width` decimal(6,5) NOT NULL DEFAULT '2.62500',
  `labels_height` decimal(6,5) NOT NULL DEFAULT '1.00000',
  `labels_pmargin_left` decimal(6,5) NOT NULL DEFAULT '0.21975',
  `labels_pmargin_right` decimal(6,5) NOT NULL DEFAULT '0.21975',
  `labels_pmargin_top` decimal(6,5) NOT NULL DEFAULT '0.50000',
  `labels_pmargin_bottom` decimal(6,5) NOT NULL DEFAULT '0.50000',
  `labels_display_bgutter` decimal(6,5) NOT NULL DEFAULT '0.07000',
  `labels_display_sgutter` decimal(6,5) NOT NULL DEFAULT '0.05000',
  `labels_fontsize` tinyint NOT NULL DEFAULT '9',
  `labels_pagewidth` decimal(7,5) NOT NULL DEFAULT '8.50000',
  `labels_pageheight` decimal(7,5) NOT NULL DEFAULT '11.00000',
  `labels_display_name` tinyint NOT NULL DEFAULT '0',
  `labels_display_serial` tinyint NOT NULL DEFAULT '1',
  `labels_display_tag` tinyint NOT NULL DEFAULT '1',
  `alt_barcode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'C128',
  `alt_barcode_enabled` tinyint(1) DEFAULT '1',
  `alert_interval` int DEFAULT '30',
  `alert_threshold` int DEFAULT '5',
  `name_display_format` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT 'first_last',
  `email_domain` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_format` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'filastname',
  `username_format` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'filastname',
  `is_ad` tinyint(1) NOT NULL DEFAULT '0',
  `ad_domain` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ldap_port` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '389',
  `ldap_tls` tinyint(1) NOT NULL DEFAULT '0',
  `zerofill_count` int NOT NULL DEFAULT '5',
  `ldap_pw_sync` tinyint(1) NOT NULL DEFAULT '1',
  `two_factor_enabled` tinyint DEFAULT NULL,
  `require_accept_signature` tinyint(1) NOT NULL DEFAULT '0',
  `date_display_format` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Y-m-d',
  `time_display_format` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'h:i A',
  `next_auto_tag_base` bigint NOT NULL DEFAULT '1',
  `login_note` text COLLATE utf8mb4_unicode_ci,
  `thumbnail_max_h` int DEFAULT '50',
  `pwd_secure_uncommon` tinyint(1) NOT NULL DEFAULT '0',
  `pwd_secure_complexity` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pwd_secure_min` int NOT NULL DEFAULT '8',
  `audit_interval` int DEFAULT NULL,
  `audit_warning_days` int DEFAULT NULL,
  `show_url_in_emails` tinyint(1) NOT NULL DEFAULT '0',
  `custom_forgot_pass_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_alerts_in_menu` tinyint(1) NOT NULL DEFAULT '1',
  `labels_display_company_name` tinyint(1) NOT NULL DEFAULT '0',
  `show_archived_in_list` tinyint(1) NOT NULL DEFAULT '0',
  `dashboard_message` text COLLATE utf8mb4_unicode_ci,
  `support_footer` char(5) COLLATE utf8mb4_unicode_ci DEFAULT 'on',
  `footer_text` text COLLATE utf8mb4_unicode_ci,
  `modellist_displays` char(191) COLLATE utf8mb4_unicode_ci DEFAULT 'image,category,manufacturer,model_number',
  `login_remote_user_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `login_common_disabled` tinyint(1) NOT NULL DEFAULT '0',
  `login_remote_user_custom_logout_url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `skin` char(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_images_in_email` tinyint(1) NOT NULL DEFAULT '1',
  `admin_cc_email` char(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `labels_display_model` tinyint(1) NOT NULL DEFAULT '0',
  `privacy_policy_link` char(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version_footer` char(5) COLLATE utf8mb4_unicode_ci DEFAULT 'on',
  `unique_serial` tinyint(1) NOT NULL DEFAULT '0',
  `logo_print_assets` tinyint(1) NOT NULL DEFAULT '0',
  `depreciation_method` char(10) COLLATE utf8mb4_unicode_ci DEFAULT 'default',
  `favicon` char(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_logo` char(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label_logo` char(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allow_user_skin` tinyint(1) NOT NULL DEFAULT '0',
  `show_assigned_assets` tinyint(1) NOT NULL DEFAULT '0',
  `login_remote_user_header_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ad_append_domain` tinyint(1) NOT NULL DEFAULT '0',
  `saml_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `saml_idp_metadata` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `saml_attr_mapping_username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `saml_forcelogin` tinyint(1) NOT NULL DEFAULT '0',
  `saml_slo` tinyint(1) NOT NULL DEFAULT '0',
  `saml_sp_x509cert` text COLLATE utf8mb4_unicode_ci,
  `saml_sp_privatekey` text COLLATE utf8mb4_unicode_ci,
  `saml_custom_settings` text COLLATE utf8mb4_unicode_ci,
  `saml_sp_x509certNew` text COLLATE utf8mb4_unicode_ci,
  `digit_separator` char(191) COLLATE utf8mb4_unicode_ci DEFAULT '1,234.56',
  `ldap_client_tls_cert` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ldap_client_tls_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `dash_chart_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'name',
  `label2_enable` tinyint(1) NOT NULL DEFAULT '0',
  `label2_template` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'DefaultLabel',
  `label2_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label2_asset_logo` tinyint(1) NOT NULL DEFAULT '0',
  `label2_1d_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `label2_2d_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `label2_2d_target` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'hardware_id',
  `label2_fields` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'name=name;serial=serial;model=model.name;',
  `google_login` tinyint(1) DEFAULT '0',
  `google_client_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_client_secret` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'2023-12-13 06:29:21','2023-12-13 06:29:21',1,20,'Test Site',NULL,NULL,NULL,NULL,NULL,0,NULL,1,NULL,NULL,'test@example.com',1,NULL,'QRCODE',NULL,NULL,NULL,'slack','USD',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'samaccountname','sn','givenname','uid=',3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'en',30,2.62500,1.00000,0.21975,0.21975,0.50000,0.50000,0.07000,0.05000,9,8.50000,11.00000,0,1,1,'C128',1,30,5,'first_last','example.com','filastname','filastname',0,NULL,'389',0,5,1,NULL,0,'Y-m-d','h:i A',1,NULL,50,0,NULL,10,NULL,NULL,0,NULL,1,0,0,NULL,'on',NULL,'image,category,manufacturer,model_number',0,0,'',NULL,1,NULL,0,NULL,'on',0,0,'default',NULL,NULL,NULL,0,0,'',0,0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,'1,234.56',NULL,NULL,'name',0,'DefaultLabel',NULL,0,'default','default','hardware_id','name=name;serial=serial;model=model.name;',0,NULL,NULL);
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_labels`
--

DROP TABLE IF EXISTS `status_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status_labels` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deployable` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `color` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_in_nav` tinyint(1) DEFAULT '0',
  `default_label` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_labels`
--

LOCK TABLES `status_labels` WRITE;
/*!40000 ALTER TABLE `status_labels` DISABLE KEYS */;
INSERT INTO `status_labels` VALUES (1,'Pending',1,NULL,NULL,NULL,0,1,0,'These assets are not yet ready to be deployed, usually because of configuration or waiting on parts.',NULL,0,0),(2,'Ready to Deploy',1,NULL,NULL,NULL,1,0,0,'These assets are ready to deploy.',NULL,0,0),(3,'Archived',1,NULL,NULL,NULL,0,0,1,'These assets are no longer in circulation or viable.',NULL,0,0);
/*!40000 ALTER TABLE `status_labels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fax` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `zip` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `throttle`
--

DROP TABLE IF EXISTS `throttle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `throttle` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `ip_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attempts` int NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `banned` tinyint(1) NOT NULL DEFAULT '0',
  `last_attempt_at` timestamp NULL DEFAULT NULL,
  `suspended_at` timestamp NULL DEFAULT NULL,
  `banned_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `throttle_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `throttle`
--

LOCK TABLES `throttle` WRITE;
/*!40000 ALTER TABLE `throttle` DISABLE KEYS */;
/*!40000 ALTER TABLE `throttle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8mb4_unicode_ci,
  `activated` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int DEFAULT NULL,
  `activation_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activated_at` timestamp NULL DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `persist_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reset_password_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `website` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gravatar` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jobtitle` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manager_id` int DEFAULT NULL,
  `employee_num` text COLLATE utf8mb4_unicode_ci,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `company_id` int unsigned DEFAULT NULL,
  `remember_token` text COLLATE utf8mb4_unicode_ci,
  `ldap_import` tinyint(1) NOT NULL DEFAULT '0',
  `locale` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'en',
  `show_in_list` tinyint(1) NOT NULL DEFAULT '1',
  `two_factor_secret` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_enrolled` tinyint(1) NOT NULL DEFAULT '0',
  `two_factor_optin` tinyint(1) NOT NULL DEFAULT '0',
  `department_id` int DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `skin` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remote` tinyint(1) DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `scim_externalid` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `autoassign_licenses` tinyint(1) NOT NULL DEFAULT '1',
  `vip` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_activation_code_index` (`activation_code`),
  KEY `users_reset_password_code_index` (`reset_password_code`),
  KEY `users_company_id_index` (`company_id`),
  KEY `users_username_deleted_at_index` (`username`,`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'test@example.com','$2y$10$3IKVDlFz8eHCAWAZhP7ZJe68.jS8YIOWNnV7yuMXFYb66DrNeTSpa','{\"superuser\":1}',1,NULL,NULL,NULL,NULL,NULL,NULL,'Test','User','2023-12-13 06:29:21','2023-12-13 06:29:21',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'testuser',NULL,NULL,'5pF0D7eb7x0aUIX9liXKRwL3gH80KzYqvyIO9Jw4oZfrXUvugy8ZJOlC1lJ8',0,'en',1,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,1,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_groups` (
  `user_id` int unsigned NOT NULL,
  `group_id` int unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-13 13:03:43
