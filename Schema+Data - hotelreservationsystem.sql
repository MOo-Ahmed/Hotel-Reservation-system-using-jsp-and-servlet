-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: hotelreservationsystem
-- ------------------------------------------------------
-- Server version	5.7.32-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `countryID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `city_fk_1` (`countryID`),
  CONSTRAINT `city_fk_1` FOREIGN KEY (`countryID`) REFERENCES `country` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Cairo',1),(2,'Sharm Al-Sheikh',1),(3,'Dubai',5),(4,'Paris',2),(5,'Munich',10),(6,'Mumbai',7),(7,'Moscow',9),(8,'Jeddah',6),(9,'Mecca',6),(10,'Switzerland',4);
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (5,'Arabian United Emirates'),(1,'Egypt'),(2,'France'),(10,'Germany'),(7,'India'),(9,'Russia'),(6,'Saudi Arabia'),(4,'Switzerland'),(8,'Thailand'),(3,'USA');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel`
--

DROP TABLE IF EXISTS `hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `stars` tinyint(1) NOT NULL DEFAULT '3',
  `distanceFromCC` double NOT NULL DEFAULT '10',
  `includingMeals` varchar(100) NOT NULL DEFAULT 'Yes',
  `cityID` int(11) NOT NULL,
  `locationUrl` varchar(600) NOT NULL,
  `contacts` varchar(50) DEFAULT NULL,
  `imgCount` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `hotel_fk_1` (`cityID`),
  CONSTRAINT `hotel_fk_1` FOREIGN KEY (`cityID`) REFERENCES `city` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel`
--

LOCK TABLES `hotel` WRITE;
/*!40000 ALTER TABLE `hotel` DISABLE KEYS */;
INSERT INTO `hotel` VALUES (1,'Ramses Hilton Hotel & Casino',4,3,'Yes',1,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3453.5316800824876!2d31.234300484930408!3d30.050290781880186!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x145840c381a29537%3A0xf1d5b3a64a0e4de1!2z2LHZhdiz2YrYsyDZh9mK2YTYqtmI2YY!5e0!3m2!1sar!2seg!4v1610639877073!5m2!1sar!2seg','247294327',3),(2,'Grand Nile Tower',5,4,'No',1,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7110.622545272864!2d31.229040891837037!3d30.034032271711865!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x14584090695d6421%3A0x201285387107863a!2z2YHZhtiv2YIg2KzYsdin2YbYryDZhtin2YrZhCDYqtin2YjYsQ!5e0!3m2!1sar!2seg!4v1610640059613!5m2!1sar!2seg',NULL,3),(3,'Four Seasons Resort Sharm El Sheikh',5,10,'Yes',2,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3524.2288102528964!2d34.393636513007!3d27.956277994139285!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x145349bc1be43c57%3A0xa090387be33c0e8f!2sFour%20Seasons%20Resort%20Sharm%20El%20Sheikh!5e0!3m2!1sar!2seg!4v1610640259206!5m2!1sar!2seg',NULL,3),(4,'Marriott Sharm El Sheikh',4,10,'Yes',2,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3525.5524986468263!2d34.33488708497998!3d27.915702882706082!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x1453378873c26bd7%3A0x444415f6b9610f2f!2sSharm%20El%20Sheikh%20Marriott%20Resort!5e0!3m2!1sar!2seg!4v1610640312014!5m2!1sar!2seg',NULL,3),(5,'Mandarin Oriental Jumeira',5,10,'Yes',3,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3609.6027518559627!2d55.25373068503787!3d25.216615783887146!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3e5f4246e0648775%3A0xc37cde75328351b4!2z2YXYp9mG2K_Yp9ix2YrZhiDYo9mI2LHZitmG2KrYp9mEINis2YXZitix2Kc!5e0!3m2!1sar!2seg!4v1610640342557!5m2!1sar!2seg',NULL,3),(6,'Gevora Hotel',3,10,'Yes',3,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3609.725797514717!2d55.278643014694346!3d25.212467990557744!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3e5f428ea0569559%3A0x7e780c58cf5a199c!2z2YHZhtiv2YIg2KzZitmB2YjYsdin!5e0!3m2!1sar!2seg!4v1610640396838!5m2!1sar!2seg',NULL,3),(7,'Hyatt Regency Paris Etoile',4,10,'Yes',4,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2623.832930492241!2d2.2866863843595353!3d48.88046137928956!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x47e66f8b8149404f%3A0x451d76ae1e117f24!2z2YHZhtiv2YIg2K3Zitin2Kkg2LHZitis2YbYs9mKINio2KfYsdmK2LMg2KXZitiq2YjYp9mE!5e0!3m2!1sar!2seg!4v1610640429822!5m2!1sar!2seg',NULL,3),(8,'Hôtel Gramont',5,10,'Yes',4,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2624.3520740572803!2d2.339221584359881!3d48.87056447928872!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x47e66e3a33a342b9%3A0xe6a64962dc5dedcd!2sH%C3%B4tel%20Gramont!5e0!3m2!1sar!2seg!4v1610640462933!5m2!1sar!2seg',NULL,3),(9,'Raffles Makkah Palace',4,10,'Yes',9,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3714.243804619872!2d39.82733468510973!3d21.419659985787938!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x15c21b4ced818a17%3A0xabbb8ea73849812c!2z2LHYp9mB2YTYsiDZgti12LEg2YXZg9ip!5e0!3m2!1sar!2seg!4v1610640512740!5m2!1sar!2seg',NULL,3),(10,'Hilton Suites Makkah',3,10,'Yes',9,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3714.204947869834!2d39.82387188510985!3d21.421187885787102!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x15c204b679347f05%3A0x50f5f4304df897e6!2z2YXZg9ipINmH2YrZhNiq2YjZhiDZhNmE2KfYrNmG2K3YqQ!5e0!3m2!1sar!2seg!4v1610640546235!5m2!1sar!2seg',NULL,3);
/*!40000 ALTER TABLE `hotel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hoteladmin`
--

DROP TABLE IF EXISTS `hoteladmin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hoteladmin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adminID` int(11) NOT NULL,
  `hotelID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Ad_fk1` (`adminID`),
  KEY `Ad_fk2` (`hotelID`),
  CONSTRAINT `Ad_fk1` FOREIGN KEY (`adminID`) REFERENCES `user` (`id`),
  CONSTRAINT `Ad_fk2` FOREIGN KEY (`hotelID`) REFERENCES `hotel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hoteladmin`
--

LOCK TABLES `hoteladmin` WRITE;
/*!40000 ALTER TABLE `hoteladmin` DISABLE KEYS */;
INSERT INTO `hoteladmin` VALUES (1,4,1),(2,4,3);
/*!40000 ALTER TABLE `hoteladmin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  `hotelID` int(11) NOT NULL,
  `isRead` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `notifi_FK1` (`hotelID`),
  CONSTRAINT `notifi_FK1` FOREIGN KEY (`hotelID`) REFERENCES `hotel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (3,'Welcome to Residencia, our dear hotel admin',1,1,'2021-01-07 21:15:56'),(11,'Reservation with id = 8 at hotel \'Ramses Hilton Hotel & Casino\' , and start date = 2021-03-09 and end date = 2021-04-12 , has been cancelled by client whose name is Mohamed Ahmed Abdelnabey',1,1,'2021-01-11 16:56:52'),(12,'Reservation with id = 14 at hotel \'Ramses Hilton Hotel & Casino\' , and start date = 2021-02-17 and end date = 2021-02-20 , has been cancelled by client whose name is Mohamed Ashraf',1,1,'2021-01-15 17:44:29'),(13,'Reservation with id = 15 at hotel \'Ramses Hilton Hotel & Casino\' , and start date = 2021-04-15 and end date = 2021-04-22 , has been cancelled by client whose name is Mohamed Ahmed Abdelnabey',1,1,'2021-01-15 18:08:51');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `hotelID` int(11) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `ts_createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isPaid` varchar(3) NOT NULL DEFAULT 'No',
  `checkInDate` date DEFAULT NULL,
  `checkOutDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reservation_FK1` (`userID`),
  KEY `RESERVATION_FK2` (`hotelID`),
  CONSTRAINT `RESERVATION_FK2` FOREIGN KEY (`hotelID`) REFERENCES `hotel` (`id`),
  CONSTRAINT `reservation_FK1` FOREIGN KEY (`userID`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (13,5,3,'2021-01-17','2021-01-22','2021-01-15 14:54:35','Yes','2021-01-15',NULL),(14,2,2,'2021-01-18','2021-01-20','2021-01-15 18:09:46','No',NULL,NULL),(15,3,7,'2021-01-20','2021-01-22','2021-01-15 18:10:44','No',NULL,NULL),(16,1,4,'2021-01-19','2021-01-23','2021-01-15 18:12:29','No',NULL,NULL);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `hotelID` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `rate` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `review_FK1` (`userID`),
  KEY `review_FK2` (`hotelID`),
  CONSTRAINT `review_FK1` FOREIGN KEY (`userID`) REFERENCES `user` (`id`),
  CONSTRAINT `review_FK2` FOREIGN KEY (`hotelID`) REFERENCES `hotel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,1,1,'Nice hotel. I really enjoyed my accommodation there. They have great services and comfortable rooms',4),(2,2,1,'I hope I stay here once again in my next visit to Egypt',3),(3,3,2,'Nice hotel. It has a pretty view on the Nile. They have great services and comfortable rooms',5),(4,2,2,'My favourite hotel in Cairo',3),(5,5,3,'It was the best hotel in Africa',4),(6,2,3,'First time I heard of this hotel I didn\'t imagine such awesome vibes.',5),(7,2,6,'one of the best hotels I\'ve seen in my life, everything is glowing in gold like a royal castle.',5),(8,2,8,'for anyone who wanna taste the simplicity and beauty combined together I recommend this hotel.',4),(9,2,9,'spending 2 days in this hotel was the best experience in my life.',5),(10,3,4,'the pools sight everywhere was so cool and encouraging you to spend more night in this hotel',4),(11,3,5,'the hotel is so big and has almost whatever you dream of.',5),(12,3,6,'watching the city while you are in a pool in that high is what you need in your life.',4),(13,3,7,'remember when they told you Paris is the city of beauty?, they meant this hotel :).',5),(14,3,8,'not very good style but the service was good.',3),(15,3,10,'good hotel to spend a couple of days but not the best experience',4),(16,5,4,'the hotel was amazing',4),(17,5,5,'one of the best hotels in UAE',4),(18,5,9,'very luxurious hotel',4),(19,5,10,'I liked the hotel but the workers were so greedy. ',2);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `hotelID` int(11) NOT NULL,
  `roomTypeID` int(11) NOT NULL,
  `price` decimal(10,0) NOT NULL DEFAULT '200',
  `facilities` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `room_fk1` (`hotelID`),
  KEY `room_fk2` (`roomTypeID`),
  CONSTRAINT `room_fk1` FOREIGN KEY (`hotelID`) REFERENCES `hotel` (`id`),
  CONSTRAINT `room_fk2` FOREIGN KEY (`roomTypeID`) REFERENCES `roomtype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,'A1',1,1,200,'beds, closet, television, refrigerator, air conditioner'),(2,'A2',1,1,220,'beds, closet'),(3,'A3',1,1,200,'beds, closet, television, refrigerator, air conditioner'),(4,'B1',1,2,200,'beds, closet, television, refrigerator, air conditioner'),(5,'B2',1,2,200,'beds, closet, television, refrigerator, air conditioner'),(6,'A1',2,1,100,'beds, closet, television, refrigerator, air conditioner'),(7,'A2',2,1,200,'beds, closet, television, refrigerator, air conditioner'),(8,'A3',2,1,300,'beds, closet, television, refrigerator, air conditioner, jacuzzi'),(9,'B1',2,2,200,'beds, closet, television, refrigerator, air conditioner'),(10,'B2',2,2,200,'beds, closet, television, refrigerator, air conditioner'),(11,'A1',3,1,200,'beds, closet, television, refrigerator, air conditioner'),(12,'A2',3,1,200,'beds, closet, television, refrigerator, air conditioner'),(13,'A3',3,1,200,'beds, closet, television, refrigerator, air conditioner'),(14,'A4',3,1,200,'beds, closet, television, refrigerator, air conditioner'),(15,'A5',3,1,200,'beds, closet, television, refrigerator, air conditioner'),(16,'A1',4,1,200,'beds, closet, television, refrigerator, air conditioner'),(17,'A2',4,1,200,'beds, closet, television, refrigerator, air conditioner'),(18,'A3',4,1,200,'beds, closet, television, refrigerator, air conditioner'),(19,'B1',4,2,200,'beds, closet, television, refrigerator, air conditioner'),(20,'B2',4,2,200,'beds, closet, television, refrigerator, air conditioner'),(21,'A1',5,1,200,'beds, closet, television, refrigerator, air conditioner'),(22,'A2',5,1,200,'beds, closet, television, refrigerator, air conditioner'),(23,'B1',5,2,200,'beds, closet, television, refrigerator, air conditioner'),(24,'B2',5,2,200,'beds, closet, television, refrigerator, air conditioner'),(25,'B3',5,2,200,'beds, closet, television, refrigerator, air conditioner'),(26,'A1',6,1,390,'beds, closet, television, refrigerator, air conditioner'),(27,'A2',6,1,400,'beds, closet, television, refrigerator, air conditioner'),(28,'A3',6,1,420,'beds, closet, television, refrigerator, air conditioner, jacuzzi'),(29,'A4',6,1,360,'beds, closet, television, refrigerator, air conditioner'),(30,'B1',6,2,340,'beds, closet, television, refrigerator, air conditioner'),(31,'A1',7,1,300,'beds, closet, television, refrigerator, air conditioner'),(32,'A2',7,1,310,'beds, closet, television, refrigerator, air conditioner'),(33,'A3',7,1,320,'beds, closet, television, refrigerator, air conditioner'),(34,'B1',7,2,250,'beds, closet, television, refrigerator, air conditioner'),(35,'B2',7,2,260,'beds, closet, television, refrigerator, air conditioner'),(36,'A1',8,1,290,'beds, closet, television, refrigerator, air conditioner'),(37,'A2',8,1,290,'beds, closet, television, refrigerator, air conditioner'),(38,'A3',8,1,340,'beds, closet, television, refrigerator, air conditioner'),(39,'B1',8,2,230,'beds, closet, television, refrigerator, air conditioner'),(40,'B2',8,2,245,'beds, closet, television, refrigerator, air conditioner'),(41,'A1',9,1,450,'beds, closet, television, refrigerator, air conditioner, jacuzzi'),(42,'A2',9,1,450,'beds, closet, television, refrigerator, air conditioner, jacuzzi'),(43,'A3',9,1,350,'beds, closet, television, refrigerator, air conditioner'),(44,'B1',9,2,300,'beds, closet, television, refrigerator, air conditioner'),(45,'B2',9,2,280,'beds, closet, television, refrigerator, air conditioner'),(46,'A1',10,1,350,'beds, closet, television, refrigerator, air conditioner, jacuzzi'),(47,'A2',10,1,325,'beds, closet, television, refrigerator, air conditioner'),(48,'A3',10,1,300,'beds, closet, television, refrigerator, air conditioner'),(49,'B1',10,2,250,'beds, closet, television, refrigerator, air conditioner'),(50,'B2',10,2,270,'beds, closet, television, refrigerator, air conditioner'),(51,'C1',1,1,150,'Beds, WC');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roomreservation`
--

DROP TABLE IF EXISTS `roomreservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roomreservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reservationID` int(11) NOT NULL,
  `roomID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `roomRes_FK1` (`roomID`),
  KEY `roomRes_FK2` (`reservationID`),
  CONSTRAINT `roomRes_FK1` FOREIGN KEY (`roomID`) REFERENCES `room` (`id`),
  CONSTRAINT `roomRes_FK2` FOREIGN KEY (`reservationID`) REFERENCES `reservation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roomreservation`
--

LOCK TABLES `roomreservation` WRITE;
/*!40000 ALTER TABLE `roomreservation` DISABLE KEYS */;
INSERT INTO `roomreservation` VALUES (16,13,14),(17,13,15),(18,14,7),(19,14,9),(20,15,31),(21,16,16),(22,16,17),(23,16,20);
/*!40000 ALTER TABLE `roomreservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roomtype`
--

DROP TABLE IF EXISTS `roomtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roomtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roomtype`
--

LOCK TABLES `roomtype` WRITE;
/*!40000 ALTER TABLE `roomtype` DISABLE KEYS */;
INSERT INTO `roomtype` VALUES (1,'Adults'),(2,'Children');
/*!40000 ALTER TABLE `roomtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `username` varchar(40) NOT NULL,
  `password` varchar(20) NOT NULL,
  `phoneNumber` varchar(15) NOT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Mohamed Ahmed Abdelnabey','engr2017@gmail.com','MOHAMED123','bP$7f@oZcY','+201001001234',0),(2,'Kareem Ahmed Eltemsah','temsah@gmail.com','K-Temsah11','100100','+201101001234',0),(3,'Yousef Osama Sayed','y.osama@gamil.com','Yousef Elkady','666666','+201201001234',0),(4,'Amr Mohamed Abdelnabey','m.a3bdelnabi@gmail.com','AmrMohamed','100100','01511223030',1),(5,'Mohamed Ashraf','mesoul279@gmail.com','Ashroof','dG#9rHZqb2','011430618917',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'hotelreservationsystem'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-15 20:14:30
