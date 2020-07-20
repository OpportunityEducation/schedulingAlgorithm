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
-- Table structure for table `unformatted_mentor_qualifications`
--

DROP TABLE IF EXISTS `unformatted_mentor_qualifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unformatted_mentor_qualifications` (
  `id` int DEFAULT NULL,
  `name` varchar(80) DEFAULT NULL,
  `planning_periods` int DEFAULT NULL,
  `course_1` varchar(40) DEFAULT NULL,
  `course_2` varchar(40) DEFAULT NULL,
  `course_3` varchar(40) DEFAULT NULL,
  `course_4` varchar(40) DEFAULT NULL,
  `course_5` varchar(40) DEFAULT NULL,
  `course_6` varchar(40) DEFAULT NULL,
  `course_7` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unformatted_mentor_qualifications`
--

LOCK TABLES `unformatted_mentor_qualifications` WRITE;
/*!40000 ALTER TABLE `unformatted_mentor_qualifications` DISABLE KEYS */;
INSERT INTO `unformatted_mentor_qualifications` VALUES (1,'Jen Dalbey',2,'TP: English','TP: Economics','TP: American Government','EP2: Social Sciences','EP2: Social Sciences','FP: Social Science (Upper Grades)',''),(2,'Ed Vogel',4,'TP: College Level English','EP2: English','EP2: English','','','',''),(3,'Ryan Luther',2,'EP2: Precalculus','FP: Mathematics','FP: Mathematics','FP: Mathematics','CSP (Computer Science Principles)','',''),(4,'Kourtney Shoemaker',2,'EP1: Social Sciences','EP1: Social Sciences','FP: Social Sciences','FP: Social Sciences','FP: Social Sciences','',''),(5,'Megan Heese',2,'EP1: English','EP1: English','FP: English','FP: English','FP: English','',''),(6,'Chris Heiman',2,'EP2: Integrated Science','EP1: Science','EP1: Science','FP: Science','','',''),(7,'Elyssia Finch',2,'Spanish 1','Spanish 2','Spanish 3','Theater','','',''),(8,'Georgia Hart',2,'TP: Biochemistry II','EP2: Biochemistry I','FP: Science','FP: Science','Anatomy 2','',''),(9,'Math Mentor 2',2,'EP1: Mathematics','EP1: Mathematics','EP2: Integrated Math','EP2: Precalculus Con.','','',''),(10,'Sheri Vollmer',0,'Physical Education','Physical Education','','','','','');
/*!40000 ALTER TABLE `unformatted_mentor_qualifications` ENABLE KEYS */;
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
