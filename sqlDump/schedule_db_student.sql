CREATE DATABASE  IF NOT EXISTS `schedule_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `schedule_db`;
-- MySQL dump 10.13  Distrib 8.0.21, for macos10.15 (x86_64)
--
-- Host: localhost    Database: schedule_db
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `year` int NOT NULL,
  `free_periods` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (2,'Beach, Jack','M',12,2),(3,'Caldwell, Libby','F',12,2),(4,'Castaneda, Gabby','F',12,1),(5,'Godinez, Alejandra','F',12,2),(6,'Heaney, Robert','M',12,1),(7,'Herrera, Aaron','M',12,1),(8,'Hohn, Andrew','M',12,2),(9,'Jackson, McKinley','F',12,2),(10,'Johnson, Khia','F',12,2),(11,'Mancinas, Samantha','F',12,2),(12,'McKell, Keyaira','F',12,2),(13,'Platt, Ruby','F',12,2),(14,'Radloff, Rachel','F',12,1),(15,'Ramirez, Annel','F',12,1),(16,'Smith, Josh','M',12,2),(17,'Valadez, Julian','M',12,1),(18,'Vollmer, Joey','M',12,2),(19,'Woodworth, Tristin','M',12,2),(20,'Aguilar, Estacy','F',11,2),(21,'Bates, Ayden','M',11,2),(22,'Burkum, Everly','F',11,2),(23,'Castaneda, Milie','F',11,2),(24,'Castaneda, Martha ','F',11,2),(25,'Conner, Ryan','M',11,2),(26,'Gallego, Ruben','M',11,2),(27,'Gama, Jannice','F',11,2),(28,'Guggenmos, Bailee','F',11,2),(29,'Hoskins, Levi','M',11,1),(30,'Lukery, Fiona','F',11,1),(31,'Martinez, Ezekiel','M',11,2),(32,'Montanez, Jose','M',11,2),(33,'Reyes, Leila','F',11,1),(34,'Rietz, Natalia','F',11,2),(35,'Robinson, Daniyah','F',11,1),(36,'Simmons, Josiah','M',11,2),(37,'Smith, Kaiden','M',11,1),(38,'Smith, Kejuan','M',11,2),(39,'Stratford, Faith','F',11,1),(40,'Swartz, Naomi','F',11,1),(41,'Agraz-Gonzalez, Alondra ','F',10,1),(42,'Alvarez-Brown, Gabi','F',10,1),(43,'Ayensu-Aboagye, Yaw','M',10,1),(44,'Braimah, Noah','M',10,2),(45,'Cooper, Marissa','F',10,2),(46,'Diederich, Grant','M',10,2),(47,'Flores, Nevaeh','F',10,2),(48,'Garcia, Anthony','M',10,2),(49,'Macias Aguilar, Isaias','M',10,1),(50,'Montoya, Ricky','M',10,2),(51,'Ornelas, Daissy','F',10,2),(52,'Ramirez, Gael','M',10,2),(53,'Valadez, Sebastian','M',10,2),(54,'Vlahos, Michael','M',10,2),(55,'Vollmer, Sean','M',10,1),(56,'William, Khya','F',10,2),(57,'Freshman 1','F',9,1),(58,'Freshman 2','F',9,1),(59,'Freshman 3','F',9,1),(60,'Freshman 4','F',9,1),(61,'Freshman 5','F',9,1),(62,'Freshman 6','F',9,1),(63,'Freshman 7','M',9,1),(64,'Freshman 8','M',9,1),(65,'Freshman 9','M',9,1),(66,'Freshman 10','M',9,1),(67,'Freshman 11','M',9,1),(68,'Freshman 12','M',9,1),(69,'Freshman 13','M',9,1),(70,'Freshman 14','M',9,1),(71,'Freshman 15','M',9,1),(72,'Freshman 16','M',9,2),(73,'Freshman 17','M',9,2),(74,'Freshman 18','M',9,2),(75,'Freshman 19','M',9,2);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-20 11:15:13
