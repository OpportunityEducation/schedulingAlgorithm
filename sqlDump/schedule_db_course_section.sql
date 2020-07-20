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
-- Table structure for table `course_section`
--

DROP TABLE IF EXISTS `course_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_section` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `section_number` int DEFAULT NULL,
  `classroom_id` int DEFAULT NULL,
  `class_period` int DEFAULT NULL,
  `students_enrolled` int DEFAULT NULL,
  `males_enrolled` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_section`
--

LOCK TABLES `course_section` WRITE;
/*!40000 ALTER TABLE `course_section` DISABLE KEYS */;
INSERT INTO `course_section` VALUES (1,4,1,0,0,9,5),(2,5,1,0,0,9,3),(3,3,1,0,0,10,4),(4,2,1,0,0,16,10),(5,1,1,0,0,9,6),(6,18,1,0,0,13,9),(7,21,1,0,0,7,3),(8,14,1,0,0,13,8),(9,10,1,0,0,10,6),(10,11,1,0,0,6,1),(11,16,1,0,0,5,3),(12,20,1,0,0,13,6),(13,6,1,0,0,9,6),(14,19,1,0,0,7,1),(15,17,1,0,0,8,6),(16,7,1,0,0,10,4),(17,29,1,0,0,18,11),(18,15,1,0,0,11,3),(19,13,1,0,0,16,10),(20,12,1,0,0,9,6),(21,24,1,0,0,15,11),(22,22,1,0,0,4,0),(23,25,1,0,0,12,3),(24,26,1,0,0,2,1),(25,9,1,0,0,13,6),(26,8,1,0,0,16,10),(27,23,1,0,0,7,6),(28,28,1,0,0,7,2),(29,27,1,0,0,9,6),(30,3,2,0,0,11,5),(32,1,2,0,0,10,7),(34,18,2,0,0,14,9),(36,6,2,0,0,11,7),(38,17,2,0,0,9,6),(40,29,2,0,0,19,11),(42,12,2,0,0,10,7),(44,27,2,0,0,9,6);
/*!40000 ALTER TABLE `course_section` ENABLE KEYS */;
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
