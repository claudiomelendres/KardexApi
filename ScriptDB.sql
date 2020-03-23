CREATE DATABASE  IF NOT EXISTS `db_kardex` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_kardex`;


DROP TABLE IF EXISTS `user`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `ci` int DEFAULT NULL,
  `first_name` varchar(250) DEFAULT NULL,
  `last_name` varchar(250) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `phone_number` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ;

DROP TABLE IF EXISTS `productunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productunity` (
  `product_unity_id` int NOT NULL AUTO_INCREMENT,
  `unity_name` varchar(250) DEFAULT NULL,
  `unity_description` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`product_unity_id`)
) ;


DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `inventory_id` int NOT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `avarage_cost_numertor` int DEFAULT NULL,
  `avarage_cost_denominator` int DEFAULT NULL,
  `kardex_id` int DEFAULT NULL,
  PRIMARY KEY (`inventory_id`),
  KEY `kardex_id_idx` (`kardex_id`),
  CONSTRAINT `kardex_id` FOREIGN KEY (`kardex_id`) REFERENCES `kardex` (`kardex_id`)
) ;



DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) DEFAULT NULL,
  `product_description` varchar(255) DEFAULT NULL,
  `product_price` int DEFAULT NULL,
  `product_unity_id` int DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `product_unity_id_idx` (`product_unity_id`),
  CONSTRAINT `product_unity_id` FOREIGN KEY (`product_unity_id`) REFERENCES `productunity` (`product_unity_id`)
) ;

DROP TABLE IF EXISTS `kardex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kardex` (
  `kardex_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `kardex_description` varchar(250) DEFAULT NULL,
  `product_price` int DEFAULT NULL,
  PRIMARY KEY (`kardex_id`),
  KEY `product_id_idx` (`product_id`),
  CONSTRAINT `product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ;



DROP TABLE IF EXISTS `kardexentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kardexentry` (
  `kardex_entry_id` int NOT NULL AUTO_INCREMENT,
  `kardex_id` int DEFAULT NULL,
  `entry_date` datetime DEFAULT NULL,
  `entry_quantity` int DEFAULT NULL,
  `entry_price` int DEFAULT NULL,
  `is_a_sale` bit(1) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`kardex_entry_id`),
  KEY `kardex_id_idx` (`kardex_id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `kardex_id_entry` FOREIGN KEY (`kardex_id`) REFERENCES `kardex` (`kardex_id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ;


