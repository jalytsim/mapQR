-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: AGRI
-- ------------------------------------------------------
-- Server version	8.0.36-0ubuntu0.22.04.1

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
-- Table structure for table `crop`
--

DROP TABLE IF EXISTS `crop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `crop_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `produceCategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crop`
--

LOCK TABLES `crop` WRITE;
/*!40000 ALTER TABLE `crop` DISABLE KEYS */;
INSERT INTO `crop` VALUES (1,'Maize',50,1),(2,'Beans',10,2),(3,'Coffee',25,3),(4,'Cassava',30,4),(5,'Rice',20,5),(6,'Bananas',15,6);
/*!40000 ALTER TABLE `crop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `district`
--

DROP TABLE IF EXISTS `district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `district` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district`
--

LOCK TABLES `district` WRITE;
/*!40000 ALTER TABLE `district` DISABLE KEYS */;
INSERT INTO `district` VALUES (1,'Kabarole','Western'),(2,'Lira','Northern'),(3,'Jinja','Eastern'),(4,'Arua','Northern'),(5,'Iganga','Eastern'),(6,'Kasese','Western'),(7,'Masindi','Western'),(8,'Mukono','Central'),(9,'Arua','Northern'),(10,'Kisoro','Western'),(11,'Moroto','Northern'),(12,'Ntungamo','Western'),(13,'Pallisa','Eastern'),(14,'Rukungiri','Western'),(15,'Soroti','Eastern'),(16,'Tororo','Eastern'),(17,'Adjumani','Northern'),(18,'Kotido','Northern'),(19,'Kumi','Eastern'),(20,'Kyenjojo','Western');
/*!40000 ALTER TABLE `district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `farm`
--

DROP TABLE IF EXISTS `farm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `farm` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `subcounty` varchar(255) DEFAULT NULL,
  `farmergroup_id` int DEFAULT NULL,
  `district_id` int DEFAULT NULL,
  `geolocation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `district_id` (`district_id`),
  KEY `farmergroup_id` (`farmergroup_id`),
  CONSTRAINT `farm_ibfk_1` FOREIGN KEY (`district_id`) REFERENCES `district` (`id`),
  CONSTRAINT `farm_ibfk_2` FOREIGN KEY (`farmergroup_id`) REFERENCES `farmergroup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farm`
--

LOCK TABLES `farm` WRITE;
/*!40000 ALTER TABLE `farm` DISABLE KEYS */;
INSERT INTO `farm` VALUES (1,'John Doe Farm','Kawempe',1,1,'0.3163,32.5822'),(2,'Jane Smith Farm','Gulu',2,2,'2.7809,32.2995'),(3,'Peter Kato Farm','Mbale',3,3,'1.0647,34.1797'),(4,'Sarah Nalubega Farm','Makindye',1,1,'0.2986,32.6235'),(5,'David Omondi Farm','Nwoya',2,2,'2.6249,31.3952'),(6,'Grace Nakato Farm','Bubulo',3,3,'1.0722,34.1691'),(7,'Joseph Ssempala Farm','Rubaga',1,1,'0.2947,32.5521'),(8,'Mercy Auma Farm','Pader',2,2,'2.7687,33.2428'),(9,'Andrew Wabwire Farm','Manafwa',3,3,'1.1714,34.3447'),(10,'Harriet Namutebi Farm','Nakawa',1,1,'0.3153,32.6153'),(11,'Emmanuel Ojok Farm','Lira',2,2,'2.2481,32.8997'),(12,'Joyce Nakazibwe Farm','Sironko',3,3,'1.2236,34.3874'),(13,'Richard Kizza Farm','Nansana',1,1,'0.3652,32.5274'),(14,'Sarah Nambooze Farm','Kitgum',2,2,'3.3017,32.8737'),(15,'Godfrey Sserwadda Farm','Kapchorwa',3,3,'1.3962,34.4507'),(16,'Mary Nalule Farm','Wakiso',1,1,'0.4054,32.4594'),(17,'Isaac Ongom Farm','Amuru',2,2,'2.8231,31.4344'),(18,'Agnes Atim Farm','Bududa',3,3,'1.0614,34.3294'),(19,'Charles Odoi Farm','Kira',1,1,'0.3673,32.6159'),(20,'Florence Nakimera Farm','Adjumani',2,2,'3.3812,31.7989');
/*!40000 ALTER TABLE `farm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `farmData`
--

DROP TABLE IF EXISTS `farmData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `farmData` (
  `id` int NOT NULL AUTO_INCREMENT,
  `farm_id` int DEFAULT NULL,
  `crop_id` int DEFAULT NULL,
  `tilled_land_size` float DEFAULT NULL,
  `planting_date` date DEFAULT NULL,
  `season` int DEFAULT NULL,
  `quality` varchar(255) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `harvest_date` date DEFAULT NULL,
  `expected_yield` float DEFAULT NULL,
  `actual_yield` float DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  `channel_partner` varchar(255) DEFAULT NULL,
  `destination_country` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `farm_id` (`farm_id`),
  KEY `crop_id` (`crop_id`),
  CONSTRAINT `farmData_ibfk_1` FOREIGN KEY (`farm_id`) REFERENCES `farm` (`id`),
  CONSTRAINT `farmData_ibfk_2` FOREIGN KEY (`crop_id`) REFERENCES `crop` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farmData`
--

LOCK TABLES `farmData` WRITE;
/*!40000 ALTER TABLE `farmData` DISABLE KEYS */;
INSERT INTO `farmData` VALUES (1,1,1,2.5,'2023-03-15',1,'Good',100,'2023-07-15',2500,2300,'2023-07-15 09:00:00','Agro Supplies Ltd','Uganda','Jinja Farms Ltd'),(2,1,2,1,'2023-03-20',1,'Fair',50,'2023-07-20',500,480,'2023-07-20 09:00:00','Uganda AgriTech Solutions','Uganda','Kampala Agro Farms'),(3,2,3,0.5,'2023-04-01',1,'Good',20,'2023-09-01',500,480,'2023-09-01 09:00:00','Kampala Agri Solutions','Uganda','Mbale Farms Co.'),(4,2,4,1,'2023-04-05',1,'Good',30,'2023-09-05',900,880,'2023-09-05 09:00:00','Uganda Organic Harvest','Uganda','Masaka Agro Enterprises'),(5,3,5,0.8,'2023-04-10',1,'Fair',40,'2023-09-10',800,780,'2023-09-10 09:00:00','Jinja Farms Ltd','Uganda','Mbarara Agro Coop'),(6,3,6,0.3,'2023-04-15',1,'Excellent',15,'2023-09-15',225,220,'2023-09-15 09:00:00','Uganda Green Fields','Uganda','Lira Organic Farmers'),(7,4,1,2,'2023-03-15',1,'Good',80,'2023-07-15',2000,1900,'2023-07-15 09:00:00','Kasese AgriPro','Uganda','Entebbe Produce Group'),(8,4,2,0.8,'2023-03-20',1,'Fair',40,'2023-07-20',400,380,'2023-07-20 09:00:00','Uganda Harvesters','Uganda','Soroti Agri Enterprise'),(9,5,3,0.4,'2023-04-01',1,'Good',15,'2023-09-01',375,370,'2023-09-01 09:00:00','Kabale Farm Solutions','Uganda','Gulu Farmers Coop'),(10,5,4,0.7,'2023-04-05',1,'Good',25,'2023-09-05',750,740,'2023-09-05 09:00:00','Mbale Agri Ltd','Uganda','Hoima Organic'),(11,6,5,0.6,'2023-04-10',1,'Fair',30,'2023-09-10',600,580,'2023-09-10 09:00:00','Uganda Agro Services','Uganda','Mityana Produce Group'),(12,6,6,0.2,'2023-04-15',1,'Excellent',10,'2023-09-15',150,140,'2023-09-15 09:00:00','Jinja Fields','Uganda','Kasese Agri Coop'),(13,7,1,1.5,'2023-03-15',1,'Good',60,'2023-07-15',1500,1400,'2023-07-15 09:00:00','Uganda Harvest Group','Uganda','Kabale Farms'),(14,7,2,0.5,'2023-03-20',1,'Fair',25,'2023-07-20',250,240,'2023-07-20 09:00:00','Gulu Agri Solutions','Uganda','Mbale Organic'),(15,8,3,0.3,'2023-04-01',1,'Good',10,'2023-09-01',250,240,'2023-09-01 09:00:00','Lira Farms','Uganda','Masaka Agri Coop'),(16,8,4,0.6,'2023-04-05',1,'Good',20,'2023-09-05',600,590,'2023-09-05 09:00:00','Kabale AgriPro','Uganda','Jinja Organic'),(17,9,5,0.5,'2023-04-10',1,'Fair',25,'2023-09-10',500,490,'2023-09-10 09:00:00','Uganda Green Harvest','Uganda','Mbarara Agri Enterprise'),(18,9,6,0.2,'2023-04-15',1,'Excellent',10,'2023-09-15',100,90,'2023-09-15 09:00:00','Hoima Agro Solutions','Uganda','Kasese Farmers Coop'),(19,10,1,1,'2023-03-15',1,'Good',40,'2023-07-15',1000,950,'2023-07-15 09:00:00','Entebbe Agri Ltd','Uganda','Masindi Harvesters'),(20,10,2,0.4,'2023-03-20',1,'Fair',20,'2023-07-20',200,190,'2023-07-20 09:00:00','Gulu Fields','Uganda','Mbale Agro Coop'),(21,11,3,0.2,'2023-04-01',1,'Good',5,'2023-09-01',125,120,'2023-09-01 09:00:00','Mityana Farms','Uganda','Kabale Agri Group'),(22,11,4,0.4,'2023-04-05',1,'Good',10,'2023-09-05',300,290,'2023-09-05 09:00:00','Kasese AgroPro','Uganda','Gulu Organic Farmers'),(23,12,5,0.3,'2023-04-10',1,'Fair',15,'2023-09-10',300,290,'2023-09-10 09:00:00','Mbale Harvest Group','Uganda','Mityana Agri Enterprise'),(24,12,6,0.1,'2023-04-15',1,'Excellent',5,'2023-09-15',50,40,'2023-09-15 09:00:00','Masaka Agri Solutions','Uganda','Masindi Agri Coop'),(25,13,1,0.5,'2023-03-15',1,'Good',20,'2023-07-15',500,480,'2023-07-15 09:00:00','Kabale Green Fields','Uganda','Lira Harvest Group'),(26,13,2,0.2,'2023-03-20',1,'Fair',10,'2023-07-20',100,90,'2023-07-20 09:00:00','Mbarara AgriPro','Uganda','Entebbe Agri Coop'),(27,14,3,0.1,'2023-04-01',1,'Good',5,'2023-09-01',125,120,'2023-09-01 09:00:00','Gulu Harvesters','Uganda','Mbarara Harvesters'),(28,14,4,0.2,'2023-04-05',1,'Good',5,'2023-09-05',150,140,'2023-09-05 09:00:00','Masaka Fields','Uganda','Hoima Agri Enterprise'),(29,15,5,0.2,'2023-04-10',1,'Fair',10,'2023-09-10',100,90,'2023-09-10 09:00:00','Mbale AgroPro','Uganda','Masindi Agri Solutions'),(30,15,6,0.1,'2023-04-15',1,'Excellent',5,'2023-09-15',50,40,'2023-09-15 09:00:00','Mityana Harvesters','Uganda','Entebbe Harvest Group'),(31,16,1,0.3,'2023-03-15',1,'Good',12,'2023-07-15',300,290,'2023-07-15 09:00:00','Masindi AgroPro','Uganda','Mityana Agri Coop'),(32,16,2,0.1,'2023-03-20',1,'Fair',6,'2023-07-20',60,50,'2023-07-20 09:00:00','Kabale Fields','Uganda','Jinja Agri Solutions'),(33,17,3,0.05,'2023-04-01',1,'Good',2,'2023-09-01',50,40,'2023-09-01 09:00:00','Mbarara Agri Group','Uganda','Masaka Harvesters'),(34,17,4,0.1,'2023-04-05',1,'Good',3,'2023-09-05',30,25,'2023-09-05 09:00:00','Mbale Agro Solutions','Uganda','Kabale Agri Solutions'),(35,18,5,0.1,'2023-04-10',1,'Fair',5,'2023-09-10',50,40,'2023-09-10 09:00:00','Masindi Harvest Group','Uganda','Kasese Agri Coop'),(36,18,6,0.05,'2023-04-15',1,'Excellent',2,'2023-09-15',20,15,'2023-09-15 09:00:00','Mityana AgroPro','Uganda','Lira Harvesters'),(37,19,1,0.2,'2023-03-15',1,'Good',8,'2023-07-15',200,190,'2023-07-15 09:00:00','Mbarara Agro Group','Uganda','Mbale Agri Coop'),(38,19,2,0.1,'2023-03-20',1,'Fair',4,'2023-07-20',40,30,'2023-07-20 09:00:00','Jinja Agri Solutions','Uganda','Mbarara Agri Coop'),(39,20,3,0.05,'2023-04-01',1,'Good',2,'2023-09-01',50,40,'2023-09-01 09:00:00','Masaka AgroPro','Uganda','Masindi Harvesters'),(40,20,4,0.1,'2023-04-05',1,'Good',3,'2023-09-05',30,25,'2023-09-05 09:00:00','Kabale Agro Solutions','Uganda','Kasese Agri Group'),(41,1,1,2.5,'2023-03-15',1,'Good',100,'2023-07-15',2500,2300,'2023-07-15 09:00:00','Mityana Agri Group','Uganda','Gulu Agri Solutions'),(42,1,2,1,'2023-03-20',1,'Fair',50,'2023-07-20',500,480,'2023-07-20 09:00:00','Masindi Agro Solutions','Uganda','Mbale Harvesters'),(43,2,3,0.5,'2023-04-01',1,'Good',20,'2023-09-01',500,480,'2023-09-01 09:00:00','Kasese Agro Group','Uganda','Entebbe Harvest Group'),(44,2,4,1,'2023-04-05',1,'Good',30,'2023-09-05',900,880,'2023-09-05 09:00:00','Mbarara Agro Solutions','Uganda','Jinja Agri Coop'),(45,3,5,0.8,'2023-04-10',1,'Fair',40,'2023-09-10',800,780,'2023-09-10 09:00:00','Mbale Agro Group','Uganda','Mbarara Harvesters'),(46,3,6,0.3,'2023-04-15',1,'Excellent',15,'2023-09-15',225,220,'2023-09-15 09:00:00','Mityana Agro Solutions','Uganda','Masaka Harvesters'),(47,4,1,2,'2023-03-15',1,'Good',80,'2023-07-15',2000,1900,'2023-07-15 09:00:00','Masaka Agro Group','Uganda','Kabale Agri Coop'),(48,4,2,0.8,'2023-03-20',1,'Fair',40,'2023-07-20',400,380,'2023-07-20 09:00:00','Kabale Agro Group','Uganda','Mbarara Harvesters'),(49,5,3,0.4,'2023-04-01',1,'Good',15,'2023-09-01',375,370,'2023-09-01 09:00:00','Mbarara AgroPro','Uganda','Masaka Agri Solutions'),(50,5,4,0.7,'2023-04-05',1,'Good',25,'2023-09-05',750,740,'2023-09-05 09:00:00','Mbale Agro Solutions','Uganda','Masindi Agri Coop'),(51,6,5,0.6,'2023-04-10',1,'Fair',30,'2023-09-10',600,580,'2023-09-10 09:00:00','Masaka Agro Solutions','Uganda','Mbarara Harvesters'),(52,6,6,0.2,'2023-04-15',1,'Excellent',10,'2023-09-15',150,140,'2023-09-15 09:00:00','Mityana AgroPro','Uganda','Kasese Agri Solutions'),(53,7,1,1.5,'2023-03-15',1,'Good',60,'2023-07-15',1500,1400,'2023-07-15 09:00:00','Masindi Agro Solutions','Uganda','Entebbe Agri Coop'),(54,7,2,0.5,'2023-03-20',1,'Fair',25,'2023-07-20',250,240,'2023-07-20 09:00:00','Kasese Agro Solutions','Uganda','Mityana Agri Coop'),(55,8,3,0.3,'2023-04-01',1,'Good',10,'2023-09-01',250,240,'2023-09-01 09:00:00','Mbarara Agro Solutions','Uganda','Masaka Agri Group'),(56,8,4,0.6,'2023-04-05',1,'Good',20,'2023-09-05',600,590,'2023-09-05 09:00:00','Mbale AgroPro','Uganda','Jinja Agri Coop'),(57,9,5,0.5,'2023-04-10',1,'Fair',25,'2023-09-10',500,490,'2023-09-10 09:00:00','Masindi AgroPro','Uganda','Mbarara Agri Solutions'),(58,9,6,0.2,'2023-04-15',1,'Excellent',10,'2023-09-15',100,90,'2023-09-15 09:00:00','Kasese Agro Group','Uganda','Masaka Agri Solutions'),(59,10,1,1,'2023-03-15',1,'Good',40,'2023-07-15',1000,950,'2023-07-15 09:00:00','Mityana AgroPro','Uganda','Kabale Agri Coop'),(60,10,2,0.4,'2023-03-20',1,'Fair',20,'2023-07-20',200,190,'2023-07-20 09:00:00','Masaka AgroPro','Uganda','Mbarara Agri Solutions'),(61,11,3,0.2,'2023-04-01',1,'Good',5,'2023-09-01',125,120,'2023-09-01 09:00:00','Mbarara Agro Solutions','Uganda','Kasese Agri Group'),(62,11,4,0.4,'2023-04-05',1,'Good',10,'2023-09-05',300,290,'2023-09-05 09:00:00','Mbale Agro Solutions','Uganda','Masindi Agri Coop'),(63,12,5,0.3,'2023-04-10',1,'Fair',15,'2023-09-10',300,290,'2023-09-10 09:00:00','Masaka Agro Solutions','Uganda','Mbarara Agri Group'),(64,12,6,0.1,'2023-04-15',1,'Excellent',5,'2023-09-15',50,40,'2023-09-15 09:00:00','Mityana AgroPro','Uganda','Masaka Agri Coop'),(65,13,1,0.5,'2023-03-15',1,'Good',20,'2023-07-15',500,480,'2023-07-15 09:00:00','Masindi AgroPro','Uganda','Jinja Agri Coop'),(66,13,2,0.2,'2023-03-20',1,'Fair',10,'2023-07-20',100,90,'2023-07-20 09:00:00','Kasese Agro Group','Uganda','Mbarara Agri Solutions'),(67,14,3,0.1,'2023-04-01',1,'Good',5,'2023-09-01',125,120,'2023-09-01 09:00:00','Mbarara Agro Solutions','Uganda','Kasese Agri Coop'),(68,14,4,0.2,'2023-04-05',1,'Good',5,'2023-09-05',150,140,'2023-09-05 09:00:00','Mbale Agro Solutions','Uganda','Masaka Agri Solutions'),(69,15,5,0.2,'2023-04-10',1,'Fair',10,'2023-09-10',100,90,'2023-09-10 09:00:00','Masaka Agro Solutions','Uganda','Mbarara Agri Solutions'),(70,15,6,0.1,'2023-04-15',1,'Excellent',5,'2023-09-15',50,40,'2023-09-15 09:00:00','Mityana AgroPro','Uganda','Kabale Agri Coop'),(71,16,1,0.3,'2023-03-15',1,'Good',12,'2023-07-15',300,290,'2023-07-15 09:00:00','Masaka AgroPro','Uganda','Mbarara Agri Solutions'),(72,16,2,0.1,'2023-03-20',1,'Fair',6,'2023-07-20',60,50,'2023-07-20 09:00:00','Mbarara Agro Solutions','Uganda','Kasese Agri Group'),(73,17,3,0.05,'2023-04-01',1,'Good',2,'2023-09-01',50,40,'2023-09-01 09:00:00','Mbale Agro Solutions','Uganda','Masindi Agri Coop'),(74,17,4,0.1,'2023-04-05',1,'Good',3,'2023-09-05',30,25,'2023-09-05 09:00:00','Masaka Agro Solutions','Uganda','Mbarara Agri Group'),(75,18,5,0.1,'2023-04-10',1,'Fair',5,'2023-09-10',50,40,'2023-09-10 09:00:00','Mityana AgroPro','Uganda','Masaka Agri Coop'),(76,18,6,0.05,'2023-04-15',1,'Excellent',2,'2023-09-15',20,15,'2023-09-15 09:00:00','Masindi AgroPro','Uganda','Jinja Agri Coop'),(77,19,1,0.2,'2023-03-15',1,'Good',8,'2023-07-15',200,190,'2023-07-15 09:00:00','Kasese Agro Group','Uganda','Mbarara Agri Solutions'),(78,19,2,0.1,'2023-03-20',1,'Fair',4,'2023-07-20',40,30,'2023-07-20 09:00:00','Mbarara Agro Solutions','Uganda','Kasese Agri Coop'),(79,20,3,0.05,'2023-04-01',1,'Good',2,'2023-09-01',50,40,'2023-09-01 09:00:00','Mbale Agro Solutions','Uganda','Masaka Agri Solutions'),(80,20,4,0.1,'2023-04-05',1,'Good',3,'2023-09-05',30,25,'2023-09-05 09:00:00','Masaka Agro Solutions','Uganda','Mbarara Agri Solutions');
/*!40000 ALTER TABLE `farmData` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `farmergroup`
--

DROP TABLE IF EXISTS `farmergroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `farmergroup` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farmergroup`
--

LOCK TABLES `farmergroup` WRITE;
/*!40000 ALTER TABLE `farmergroup` DISABLE KEYS */;
INSERT INTO `farmergroup` VALUES (1,'Farmers Cooperative Society','A cooperative society of farmers'),(2,'Women Farmers Association','An association of women farmers'),(3,'Young Farmers Group','A group of young farmers');
/*!40000 ALTER TABLE `farmergroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produceCategory`
--

DROP TABLE IF EXISTS `produceCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produceCategory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `grade` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produceCategory`
--

LOCK TABLES `produceCategory` WRITE;
/*!40000 ALTER TABLE `produceCategory` DISABLE KEYS */;
INSERT INTO `produceCategory` VALUES (1,'Maize',1),(2,'Beans',2),(3,'Coffee',3),(4,'Cassava',1),(5,'Rice',2),(6,'Bananas',3);
/*!40000 ALTER TABLE `produceCategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `soilData`
--

DROP TABLE IF EXISTS `soilData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `soilData` (
  `id` int NOT NULL AUTO_INCREMENT,
  `district_id` int DEFAULT NULL,
  `internal_id` int DEFAULT NULL,
  `device` varchar(255) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `nitrogen` float DEFAULT NULL,
  `phosphorus` float DEFAULT NULL,
  `potassium` float DEFAULT NULL,
  `ph` float DEFAULT NULL,
  `temperature` float DEFAULT NULL,
  `humidity` float DEFAULT NULL,
  `conductivity` float DEFAULT NULL,
  `signal_level` float DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `district_id` (`district_id`),
  CONSTRAINT `soilData_ibfk_1` FOREIGN KEY (`district_id`) REFERENCES `district` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `soilData`
--

LOCK TABLES `soilData` WRITE;
/*!40000 ALTER TABLE `soilData` DISABLE KEYS */;
/*!40000 ALTER TABLE `soilData` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-04 19:23:29
