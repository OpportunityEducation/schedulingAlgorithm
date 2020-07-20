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
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL,
  `capacity` int NOT NULL,
  `classroom_type_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_availability`
--

DROP TABLE IF EXISTS `classroom_availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom_availability` (
  `day_id` int NOT NULL,
  `classroom_id` int NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_availability`
--

LOCK TABLES `classroom_availability` WRITE;
/*!40000 ALTER TABLE `classroom_availability` DISABLE KEYS */;
/*!40000 ALTER TABLE `classroom_availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_type`
--

DROP TABLE IF EXISTS `classroom_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_type` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_type`
--

LOCK TABLES `classroom_type` WRITE;
/*!40000 ALTER TABLE `classroom_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `classroom_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commitment_type`
--

DROP TABLE IF EXISTS `commitment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commitment_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reason` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commitment_type`
--

LOCK TABLES `commitment_type` WRITE;
/*!40000 ALTER TABLE `commitment_type` DISABLE KEYS */;
INSERT INTO `commitment_type` VALUES (1,'Internship'),(2,'Extracurricular');
/*!40000 ALTER TABLE `commitment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `allowed_grades` varchar(10) DEFAULT NULL,
  `is_elective` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'FP: English','9',0),(2,'EP1: English','10',0),(3,'EP2: English','11',0),(4,'TP: English','12',0),(5,'TP: College Level English','12',0),(6,'FP: Social Sciences','9',0),(7,'FP: Social Science (Upper Grades)','9',0),(8,'EP1: Social Sciences','10',0),(9,'EP2: Social Sciences','11',0),(10,'TP: American Government','12',0),(11,'TP: Economics','12',0),(12,'FP: Science','9',0),(13,'EP1: Science','10',0),(14,'EP2: Integrated Science','11',0),(15,'EP2: Biochemistry I','11',0),(16,'TP: Biochemistry II','12',0),(17,'FP: Mathematics','9',0),(18,'EP1: Mathematics','10',0),(19,'EP2: Integrated Math','11',0),(20,'EP2: Precalculus','11',0),(21,'EP2: Precalculus Con.','11',0),(22,'Anatomy 2','10',1),(23,'CSP (Computer Science Principles)','9,10,11,12',1),(24,'Spanish 1','10,11,12',1),(25,'Spanish 2','10',1),(26,'Spanish 3','10',1),(27,'Music','9,10,11,12',1),(28,'Theater','9,10,11,12',1),(29,'Physical Education','9,10,11,12',1);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_enrollment`
--

DROP TABLE IF EXISTS `course_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_enrollment` (
  `user_id` int NOT NULL,
  `course_section_id` int NOT NULL,
  `is_mentor` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_enrollment`
--

LOCK TABLES `course_enrollment` WRITE;
/*!40000 ALTER TABLE `course_enrollment` DISABLE KEYS */;
INSERT INTO `course_enrollment` VALUES (10,1,0),(5,2,0),(7,2,0),(18,1,0),(8,1,0),(16,1,0),(19,1,0),(9,2,0),(3,2,0),(17,2,0),(2,1,0),(12,2,0),(4,1,0),(14,2,0),(11,1,0),(13,1,0),(6,2,0),(15,2,0),(20,3,0),(21,30,0),(25,30,0),(28,30,0),(29,30,0),(30,3,0),(31,3,0),(32,3,0),(34,3,0),(35,3,0),(36,3,0),(38,30,0),(39,3,0),(40,30,0),(23,30,0),(26,3,0),(33,3,0),(37,30,0),(24,30,0),(27,30,0),(22,30,0),(41,4,0),(42,4,0),(43,4,0),(44,4,0),(45,4,0),(46,4,0),(47,4,0),(48,4,0),(49,4,0),(50,4,0),(51,4,0),(52,4,0),(53,4,0),(54,4,0),(55,4,0),(56,4,0),(73,5,0),(59,5,0),(68,32,0),(58,5,0),(69,32,0),(65,5,0),(57,5,0),(63,32,0),(64,5,0),(72,32,0),(70,5,0),(61,32,0),(62,32,0),(75,5,0),(66,32,0),(74,5,0),(67,32,0),(71,32,0),(60,32,0),(10,34,0),(5,6,0),(7,7,0),(18,8,0),(8,6,0),(16,8,0),(19,9,0),(9,10,0),(3,11,0),(17,11,0),(2,12,0),(12,7,0),(4,11,0),(14,10,0),(11,13,0),(13,12,0),(6,12,0),(15,7,0),(20,14,0),(21,12,0),(25,34,0),(28,14,0),(29,12,0),(30,12,0),(31,6,0),(32,12,0),(34,12,0),(35,12,0),(36,12,0),(38,34,0),(39,12,0),(40,12,0),(23,14,0),(26,6,0),(33,14,0),(37,14,0),(24,14,0),(27,12,0),(22,14,0),(41,34,0),(42,6,0),(43,6,0),(44,34,0),(45,6,0),(46,34,0),(47,34,0),(48,6,0),(49,34,0),(50,34,0),(51,34,0),(52,34,0),(53,6,0),(54,34,0),(55,6,0),(56,34,0),(73,15,0),(59,15,0),(68,38,0),(58,38,0),(69,15,0),(65,15,0),(57,6,0),(63,38,0),(64,38,0),(72,15,0),(70,38,0),(61,38,0),(62,38,0),(75,38,0),(66,38,0),(74,15,0),(67,6,0),(71,15,0),(60,15,0),(10,16,0),(5,9,0),(7,16,0),(18,7,0),(8,9,0),(16,9,0),(19,34,0),(9,40,0),(3,10,0),(17,10,0),(2,9,0),(12,10,0),(4,9,0),(14,17,0),(11,7,0),(13,18,0),(6,16,0),(15,10,0),(20,8,0),(21,18,0),(25,8,0),(28,8,0),(29,18,0),(30,18,0),(31,8,0),(32,18,0),(34,18,0),(35,18,0),(36,8,0),(38,8,0),(39,18,0),(40,18,0),(23,8,0),(26,8,0),(33,18,0),(37,8,0),(24,8,0),(27,18,0),(22,8,0),(41,19,0),(42,19,0),(43,19,0),(44,19,0),(45,19,0),(46,19,0),(47,19,0),(48,19,0),(49,19,0),(50,19,0),(51,19,0),(52,19,0),(53,19,0),(54,19,0),(55,19,0),(56,19,0),(73,42,0),(59,20,0),(68,20,0),(58,20,0),(69,42,0),(65,20,0),(57,42,0),(63,42,0),(64,20,0),(72,20,0),(70,20,0),(61,42,0),(62,42,0),(75,42,0),(66,42,0),(74,20,0),(67,42,0),(71,42,0),(60,20,0),(10,9,0),(5,17,0),(7,11,0),(18,9,0),(8,40,0),(16,6,0),(19,21,0),(3,22,0),(17,7,0),(2,11,0),(4,7,0),(11,23,0),(13,9,0),(15,24,0),(20,25,0),(21,25,0),(25,25,0),(28,25,0),(29,9,0),(30,25,0),(31,25,0),(32,25,0),(34,25,0),(35,25,0),(36,25,0),(38,25,0),(39,25,0),(40,25,0),(23,16,0),(26,16,0),(33,16,0),(37,16,0),(24,16,0),(27,16,0),(22,16,0),(41,26,0),(42,26,0),(43,26,0),(44,26,0),(45,26,0),(46,26,0),(47,26,0),(48,26,0),(49,26,0),(50,26,0),(51,26,0),(52,26,0),(53,26,0),(54,26,0),(55,26,0),(56,26,0),(73,13,0),(59,36,0),(68,36,0),(58,36,0),(69,13,0),(65,13,0),(57,36,0),(63,36,0),(64,36,0),(72,13,0),(70,13,0),(61,13,0),(62,36,0),(75,36,0),(66,36,0),(74,36,0),(67,36,0),(71,13,0),(60,13,0),(10,40,0),(7,40,0),(18,17,0),(16,40,0),(17,27,0),(2,17,0),(4,22,0),(11,40,0),(13,28,0),(20,28,0),(21,40,0),(25,21,0),(28,23,0),(29,21,0),(30,22,0),(31,21,0),(32,23,0),(34,27,0),(35,23,0),(36,27,0),(38,21,0),(39,23,0),(40,22,0),(23,21,0),(26,21,0),(33,23,0),(37,28,0),(27,40,0),(22,23,0),(41,21,0),(42,23,0),(43,24,0),(44,21,0),(46,21,0),(47,28,0),(48,21,0),(49,23,0),(50,28,0),(51,23,0),(52,17,0),(53,21,0),(54,27,0),(55,27,0),(56,21,0),(73,17,0),(59,17,0),(68,40,0),(58,17,0),(69,17,0),(65,40,0),(57,40,0),(63,40,0),(64,17,0),(72,17,0),(70,40,0),(61,17,0),(62,40,0),(75,17,0),(66,17,0),(74,40,0),(67,40,0),(71,17,0),(60,17,0),(7,44,0),(20,23,0),(29,17,0),(30,40,0),(35,40,0),(36,21,0),(39,17,0),(40,21,0),(41,28,0),(42,28,0),(43,27,0),(49,27,0),(55,40,0),(73,44,0),(59,29,0),(68,44,0),(58,29,0),(69,29,0),(65,44,0),(57,44,0),(63,29,0),(64,29,0),(72,23,0),(70,29,0),(61,29,0),(62,44,0),(66,44,0),(74,44,0),(67,29,0),(71,29,0),(60,44,0),(1,4,1),(2,5,1),(2,3,1),(5,2,1),(5,1,1),(9,18,1),(9,21,1),(6,14,1),(1,10,1),(1,11,1),(8,16,1),(3,20,1),(4,6,1),(9,19,1),(3,17,1),(1,7,1),(10,29,1),(8,15,1),(6,13,1),(6,12,1),(7,24,1),(8,22,1),(7,25,1),(7,26,1),(1,9,1),(4,8,1),(3,23,1),(7,28,1),(11,27,1),(2,3,1),(5,1,1),(9,18,1),(4,6,1),(3,17,1),(10,29,1),(8,12,1),(11,27,1);
/*!40000 ALTER TABLE `course_enrollment` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `day`
--

DROP TABLE IF EXISTS `day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `day` (
  `id` int NOT NULL AUTO_INCREMENT,
  `weekday` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `day`
--

LOCK TABLES `day` WRITE;
/*!40000 ALTER TABLE `day` DISABLE KEYS */;
INSERT INTO `day` VALUES (1,'Sunday'),(2,'Monday'),(3,'Tuesday'),(4,'Wednesday'),(5,'Thursday'),(6,'Friday'),(7,'Saturday');
/*!40000 ALTER TABLE `day` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formatted_output`
--

DROP TABLE IF EXISTS `formatted_output`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formatted_output` (
  `name` varchar(80) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `class_name` varchar(40) DEFAULT NULL,
  `mentor` varchar(80) DEFAULT NULL,
  `section_number` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formatted_output`
--

LOCK TABLES `formatted_output` WRITE;
/*!40000 ALTER TABLE `formatted_output` DISABLE KEYS */;
INSERT INTO `formatted_output` VALUES ('Johnson, Khia',12,'F','TP: English','Jen Dalbey',1),('Vollmer, Joey',12,'M','TP: English','Jen Dalbey',1),('Hohn, Andrew',12,'M','TP: English','Jen Dalbey',1),('Smith, Josh',12,'M','TP: English','Jen Dalbey',1),('Woodworth, Tristin',12,'M','TP: English','Jen Dalbey',1),('Beach, Jack',12,'M','TP: English','Jen Dalbey',1),('Castaneda, Gabby',12,'F','TP: English','Jen Dalbey',1),('Mancinas, Samantha',12,'F','TP: English','Jen Dalbey',1),('Platt, Ruby',12,'F','TP: English','Jen Dalbey',1),('Godinez, Alejandra',12,'F','TP: College Level English','Ed Vogel',1),('Herrera, Aaron',12,'M','TP: College Level English','Ed Vogel',1),('Jackson, McKinley',12,'F','TP: College Level English','Ed Vogel',1),('Caldwell, Libby',12,'F','TP: College Level English','Ed Vogel',1),('Valadez, Julian',12,'M','TP: College Level English','Ed Vogel',1),('McKell, Keyaira',12,'F','TP: College Level English','Ed Vogel',1),('Radloff, Rachel',12,'F','TP: College Level English','Ed Vogel',1),('Heaney, Robert',12,'M','TP: College Level English','Ed Vogel',1),('Ramirez, Annel',12,'F','TP: College Level English','Ed Vogel',1),('Aguilar, Estacy',11,'F','EP2: English','Ed Vogel',1),('Rietz, Natalia',11,'F','EP2: English','Ed Vogel',1),('Lukery, Fiona',11,'F','EP2: English','Ed Vogel',1),('Reyes, Leila',11,'F','EP2: English','Ed Vogel',1),('Stratford, Faith',11,'F','EP2: English','Ed Vogel',1),('Robinson, Daniyah',11,'F','EP2: English','Ed Vogel',1),('Simmons, Josiah',11,'M','EP2: English','Ed Vogel',1),('Gallego, Ruben',11,'M','EP2: English','Ed Vogel',1),('Montanez, Jose',11,'M','EP2: English','Ed Vogel',1),('Martinez, Ezekiel',11,'M','EP2: English','Ed Vogel',1),('Castaneda, Martha ',11,'F','EP2: English','Ed Vogel',2),('Swartz, Naomi',11,'F','EP2: English','Ed Vogel',2),('Gama, Jannice',11,'F','EP2: English','Ed Vogel',2),('Guggenmos, Bailee',11,'F','EP2: English','Ed Vogel',2),('Burkum, Everly',11,'F','EP2: English','Ed Vogel',2),('Castaneda, Milie',11,'F','EP2: English','Ed Vogel',2),('Smith, Kejuan',11,'M','EP2: English','Ed Vogel',2),('Hoskins, Levi',11,'M','EP2: English','Ed Vogel',2),('Smith, Kaiden',11,'M','EP2: English','Ed Vogel',2),('Bates, Ayden',11,'M','EP2: English','Ed Vogel',2),('Conner, Ryan',11,'M','EP2: English','Ed Vogel',2),('Agraz-Gonzalez, Alondra ',10,'F','EP1: English','Megan Heese',1),('Alvarez-Brown, Gabi',10,'F','EP1: English','Megan Heese',1),('Ayensu-Aboagye, Yaw',10,'M','EP1: English','Megan Heese',1),('Braimah, Noah',10,'M','EP1: English','Megan Heese',1),('Cooper, Marissa',10,'F','EP1: English','Megan Heese',1),('Diederich, Grant',10,'M','EP1: English','Megan Heese',1),('Flores, Nevaeh',10,'F','EP1: English','Megan Heese',1),('Garcia, Anthony',10,'M','EP1: English','Megan Heese',1),('Macias Aguilar, Isaias',10,'M','EP1: English','Megan Heese',1),('Montoya, Ricky',10,'M','EP1: English','Megan Heese',1),('Ornelas, Daissy',10,'F','EP1: English','Megan Heese',1),('Ramirez, Gael',10,'M','EP1: English','Megan Heese',1),('Valadez, Sebastian',10,'M','EP1: English','Megan Heese',1),('Vlahos, Michael',10,'M','EP1: English','Megan Heese',1),('Vollmer, Sean',10,'M','EP1: English','Megan Heese',1),('William, Khya',10,'F','EP1: English','Megan Heese',1),('Freshman 1',9,'F','FP: English','Megan Heese',1),('Freshman 3',9,'F','FP: English','Megan Heese',1),('Freshman 2',9,'F','FP: English','Megan Heese',1),('Freshman 17',9,'M','FP: English','Megan Heese',1),('Freshman 14',9,'M','FP: English','Megan Heese',1),('Freshman 9',9,'M','FP: English','Megan Heese',1),('Freshman 8',9,'M','FP: English','Megan Heese',1),('Freshman 19',9,'M','FP: English','Megan Heese',1),('Freshman 18',9,'M','FP: English','Megan Heese',1),('Freshman 4',9,'F','FP: English','Megan Heese',2),('Freshman 6',9,'F','FP: English','Megan Heese',2),('Freshman 5',9,'F','FP: English','Megan Heese',2),('Freshman 16',9,'M','FP: English','Megan Heese',2),('Freshman 12',9,'M','FP: English','Megan Heese',2),('Freshman 10',9,'M','FP: English','Megan Heese',2),('Freshman 11',9,'M','FP: English','Megan Heese',2),('Freshman 15',9,'M','FP: English','Megan Heese',2),('Freshman 7',9,'M','FP: English','Megan Heese',2),('Freshman 13',9,'M','FP: English','Megan Heese',2),('Freshman 1',9,'F','EP1: Mathematics','Math Mentor 2',1),('Alvarez-Brown, Gabi',10,'F','EP1: Mathematics','Math Mentor 2',1),('Cooper, Marissa',10,'F','EP1: Mathematics','Math Mentor 2',1),('Godinez, Alejandra',12,'F','EP1: Mathematics','Math Mentor 2',1),('Vollmer, Sean',10,'M','EP1: Mathematics','Math Mentor 2',1),('Smith, Josh',12,'M','EP1: Mathematics','Math Mentor 2',1),('Freshman 11',9,'M','EP1: Mathematics','Math Mentor 2',1),('Gallego, Ruben',11,'M','EP1: Mathematics','Math Mentor 2',1),('Martinez, Ezekiel',11,'M','EP1: Mathematics','Math Mentor 2',1),('Hohn, Andrew',12,'M','EP1: Mathematics','Math Mentor 2',1),('Ayensu-Aboagye, Yaw',10,'M','EP1: Mathematics','Math Mentor 2',1),('Valadez, Sebastian',10,'M','EP1: Mathematics','Math Mentor 2',1),('Garcia, Anthony',10,'M','EP1: Mathematics','Math Mentor 2',1),('William, Khya',10,'F','EP1: Mathematics','Math Mentor 2',2),('Flores, Nevaeh',10,'F','EP1: Mathematics','Math Mentor 2',2),('Ornelas, Daissy',10,'F','EP1: Mathematics','Math Mentor 2',2),('Agraz-Gonzalez, Alondra ',10,'F','EP1: Mathematics','Math Mentor 2',2),('Johnson, Khia',12,'F','EP1: Mathematics','Math Mentor 2',2),('Vlahos, Michael',10,'M','EP1: Mathematics','Math Mentor 2',2),('Ramirez, Gael',10,'M','EP1: Mathematics','Math Mentor 2',2),('Conner, Ryan',11,'M','EP1: Mathematics','Math Mentor 2',2),('Macias Aguilar, Isaias',10,'M','EP1: Mathematics','Math Mentor 2',2),('Smith, Kejuan',11,'M','EP1: Mathematics','Math Mentor 2',2),('Braimah, Noah',10,'M','EP1: Mathematics','Math Mentor 2',2),('Woodworth, Tristin',12,'M','EP1: Mathematics','Math Mentor 2',2),('Montoya, Ricky',10,'M','EP1: Mathematics','Math Mentor 2',2),('Diederich, Grant',10,'M','EP1: Mathematics','Math Mentor 2',2),('Herrera, Aaron',12,'M','EP2: Precalculus Con.','Math Mentor 2',1),('McKell, Keyaira',12,'F','EP2: Precalculus Con.','Math Mentor 2',1),('Ramirez, Annel',12,'F','EP2: Precalculus Con.','Math Mentor 2',1),('Vollmer, Joey',12,'M','EP2: Precalculus Con.','Math Mentor 2',1),('Mancinas, Samantha',12,'F','EP2: Precalculus Con.','Math Mentor 2',1),('Valadez, Julian',12,'M','EP2: Precalculus Con.','Math Mentor 2',1),('Castaneda, Gabby',12,'F','EP2: Precalculus Con.','Math Mentor 2',1),('Vollmer, Joey',12,'M','EP2: Integrated Science','Chris Heiman',1),('Smith, Josh',12,'M','EP2: Integrated Science','Chris Heiman',1),('Aguilar, Estacy',11,'F','EP2: Integrated Science','Chris Heiman',1),('Conner, Ryan',11,'M','EP2: Integrated Science','Chris Heiman',1),('Guggenmos, Bailee',11,'F','EP2: Integrated Science','Chris Heiman',1),('Martinez, Ezekiel',11,'M','EP2: Integrated Science','Chris Heiman',1),('Simmons, Josiah',11,'M','EP2: Integrated Science','Chris Heiman',1),('Smith, Kejuan',11,'M','EP2: Integrated Science','Chris Heiman',1),('Castaneda, Milie',11,'F','EP2: Integrated Science','Chris Heiman',1),('Gallego, Ruben',11,'M','EP2: Integrated Science','Chris Heiman',1),('Smith, Kaiden',11,'M','EP2: Integrated Science','Chris Heiman',1),('Castaneda, Martha ',11,'F','EP2: Integrated Science','Chris Heiman',1),('Burkum, Everly',11,'F','EP2: Integrated Science','Chris Heiman',1),('Woodworth, Tristin',12,'M','TP: American Government','Jen Dalbey',1),('Godinez, Alejandra',12,'F','TP: American Government','Jen Dalbey',1),('Hohn, Andrew',12,'M','TP: American Government','Jen Dalbey',1),('Smith, Josh',12,'M','TP: American Government','Jen Dalbey',1),('Beach, Jack',12,'M','TP: American Government','Jen Dalbey',1),('Castaneda, Gabby',12,'F','TP: American Government','Jen Dalbey',1),('Johnson, Khia',12,'F','TP: American Government','Jen Dalbey',1),('Vollmer, Joey',12,'M','TP: American Government','Jen Dalbey',1),('Platt, Ruby',12,'F','TP: American Government','Jen Dalbey',1),('Hoskins, Levi',11,'M','TP: American Government','Jen Dalbey',1),('Jackson, McKinley',12,'F','TP: Economics','Jen Dalbey',1),('Radloff, Rachel',12,'F','TP: Economics','Jen Dalbey',1),('Caldwell, Libby',12,'F','TP: Economics','Jen Dalbey',1),('Valadez, Julian',12,'M','TP: Economics','Jen Dalbey',1),('McKell, Keyaira',12,'F','TP: Economics','Jen Dalbey',1),('Ramirez, Annel',12,'F','TP: Economics','Jen Dalbey',1),('Caldwell, Libby',12,'F','TP: Biochemistry II','Georgia Hart',1),('Valadez, Julian',12,'M','TP: Biochemistry II','Georgia Hart',1),('Castaneda, Gabby',12,'F','TP: Biochemistry II','Georgia Hart',1),('Herrera, Aaron',12,'M','TP: Biochemistry II','Georgia Hart',1),('Beach, Jack',12,'M','TP: Biochemistry II','Georgia Hart',1),('Beach, Jack',12,'M','EP2: Precalculus','Ryan Luther',1),('Platt, Ruby',12,'F','EP2: Precalculus','Ryan Luther',1),('Heaney, Robert',12,'M','EP2: Precalculus','Ryan Luther',1),('Bates, Ayden',11,'M','EP2: Precalculus','Ryan Luther',1),('Hoskins, Levi',11,'M','EP2: Precalculus','Ryan Luther',1),('Lukery, Fiona',11,'F','EP2: Precalculus','Ryan Luther',1),('Montanez, Jose',11,'M','EP2: Precalculus','Ryan Luther',1),('Rietz, Natalia',11,'F','EP2: Precalculus','Ryan Luther',1),('Robinson, Daniyah',11,'F','EP2: Precalculus','Ryan Luther',1),('Simmons, Josiah',11,'M','EP2: Precalculus','Ryan Luther',1),('Stratford, Faith',11,'F','EP2: Precalculus','Ryan Luther',1),('Swartz, Naomi',11,'F','EP2: Precalculus','Ryan Luther',1),('Gama, Jannice',11,'F','EP2: Precalculus','Ryan Luther',1),('Mancinas, Samantha',12,'F','FP: Social Sciences','Kourtney Shoemaker',1),('Freshman 4',9,'F','FP: Social Sciences','Kourtney Shoemaker',1),('Freshman 5',9,'F','FP: Social Sciences','Kourtney Shoemaker',1),('Freshman 17',9,'M','FP: Social Sciences','Kourtney Shoemaker',1),('Freshman 15',9,'M','FP: Social Sciences','Kourtney Shoemaker',1),('Freshman 14',9,'M','FP: Social Sciences','Kourtney Shoemaker',1),('Freshman 16',9,'M','FP: Social Sciences','Kourtney Shoemaker',1),('Freshman 13',9,'M','FP: Social Sciences','Kourtney Shoemaker',1),('Freshman 9',9,'M','FP: Social Sciences','Kourtney Shoemaker',1),('Freshman 2',9,'F','FP: Social Sciences','Kourtney Shoemaker',2),('Freshman 6',9,'F','FP: Social Sciences','Kourtney Shoemaker',2),('Freshman 3',9,'F','FP: Social Sciences','Kourtney Shoemaker',2),('Freshman 1',9,'F','FP: Social Sciences','Kourtney Shoemaker',2),('Freshman 8',9,'M','FP: Social Sciences','Kourtney Shoemaker',2),('Freshman 7',9,'M','FP: Social Sciences','Kourtney Shoemaker',2),('Freshman 18',9,'M','FP: Social Sciences','Kourtney Shoemaker',2),('Freshman 12',9,'M','FP: Social Sciences','Kourtney Shoemaker',2),('Freshman 10',9,'M','FP: Social Sciences','Kourtney Shoemaker',2),('Freshman 19',9,'M','FP: Social Sciences','Kourtney Shoemaker',2),('Freshman 11',9,'M','FP: Social Sciences','Kourtney Shoemaker',2),('Aguilar, Estacy',11,'F','EP2: Integrated Math','Math Mentor 2',1),('Guggenmos, Bailee',11,'F','EP2: Integrated Math','Math Mentor 2',1),('Castaneda, Milie',11,'F','EP2: Integrated Math','Math Mentor 2',1),('Reyes, Leila',11,'F','EP2: Integrated Math','Math Mentor 2',1),('Smith, Kaiden',11,'M','EP2: Integrated Math','Math Mentor 2',1),('Castaneda, Martha ',11,'F','EP2: Integrated Math','Math Mentor 2',1),('Burkum, Everly',11,'F','EP2: Integrated Math','Math Mentor 2',1),('Freshman 3',9,'F','FP: Mathematics','Ryan Luther',1),('Freshman 4',9,'F','FP: Mathematics','Ryan Luther',1),('Freshman 15',9,'M','FP: Mathematics','Ryan Luther',1),('Freshman 17',9,'M','FP: Mathematics','Ryan Luther',1),('Freshman 16',9,'M','FP: Mathematics','Ryan Luther',1),('Freshman 13',9,'M','FP: Mathematics','Ryan Luther',1),('Freshman 18',9,'M','FP: Mathematics','Ryan Luther',1),('Freshman 9',9,'M','FP: Mathematics','Ryan Luther',1),('Freshman 2',9,'F','FP: Mathematics','Ryan Luther',2),('Freshman 5',9,'F','FP: Mathematics','Ryan Luther',2),('Freshman 6',9,'F','FP: Mathematics','Ryan Luther',2),('Freshman 14',9,'M','FP: Mathematics','Ryan Luther',2),('Freshman 8',9,'M','FP: Mathematics','Ryan Luther',2),('Freshman 19',9,'M','FP: Mathematics','Ryan Luther',2),('Freshman 12',9,'M','FP: Mathematics','Ryan Luther',2),('Freshman 7',9,'M','FP: Mathematics','Ryan Luther',2),('Freshman 10',9,'M','FP: Mathematics','Ryan Luther',2),('Johnson, Khia',12,'F','FP: Social Science (Upper Grades)','Jen Dalbey',1),('Herrera, Aaron',12,'M','FP: Social Science (Upper Grades)','Jen Dalbey',1),('Heaney, Robert',12,'M','FP: Social Science (Upper Grades)','Jen Dalbey',1),('Castaneda, Milie',11,'F','FP: Social Science (Upper Grades)','Jen Dalbey',1),('Gallego, Ruben',11,'M','FP: Social Science (Upper Grades)','Jen Dalbey',1),('Reyes, Leila',11,'F','FP: Social Science (Upper Grades)','Jen Dalbey',1),('Smith, Kaiden',11,'M','FP: Social Science (Upper Grades)','Jen Dalbey',1),('Castaneda, Martha ',11,'F','FP: Social Science (Upper Grades)','Jen Dalbey',1),('Gama, Jannice',11,'F','FP: Social Science (Upper Grades)','Jen Dalbey',1),('Burkum, Everly',11,'F','FP: Social Science (Upper Grades)','Jen Dalbey',1),('Stratford, Faith',11,'F','Physical Education','Sheri Vollmer',1),('Freshman 4',9,'F','Physical Education','Sheri Vollmer',1),('Radloff, Rachel',12,'F','Physical Education','Sheri Vollmer',1),('Godinez, Alejandra',12,'F','Physical Education','Sheri Vollmer',1),('Freshman 2',9,'F','Physical Education','Sheri Vollmer',1),('Freshman 5',9,'F','Physical Education','Sheri Vollmer',1),('Freshman 3',9,'F','Physical Education','Sheri Vollmer',1),('Freshman 10',9,'M','Physical Education','Sheri Vollmer',1),('Vollmer, Joey',12,'M','Physical Education','Sheri Vollmer',1),('Hoskins, Levi',11,'M','Physical Education','Sheri Vollmer',1),('Freshman 19',9,'M','Physical Education','Sheri Vollmer',1),('Freshman 13',9,'M','Physical Education','Sheri Vollmer',1),('Freshman 17',9,'M','Physical Education','Sheri Vollmer',1),('Beach, Jack',12,'M','Physical Education','Sheri Vollmer',1),('Freshman 8',9,'M','Physical Education','Sheri Vollmer',1),('Freshman 16',9,'M','Physical Education','Sheri Vollmer',1),('Freshman 15',9,'M','Physical Education','Sheri Vollmer',1),('Ramirez, Gael',10,'M','Physical Education','Sheri Vollmer',1),('Mancinas, Samantha',12,'F','Physical Education','Sheri Vollmer',2),('Freshman 6',9,'F','Physical Education','Sheri Vollmer',2),('Lukery, Fiona',11,'F','Physical Education','Sheri Vollmer',2),('Gama, Jannice',11,'F','Physical Education','Sheri Vollmer',2),('Jackson, McKinley',12,'F','Physical Education','Sheri Vollmer',2),('Johnson, Khia',12,'F','Physical Education','Sheri Vollmer',2),('Robinson, Daniyah',11,'F','Physical Education','Sheri Vollmer',2),('Freshman 1',9,'F','Physical Education','Sheri Vollmer',2),('Hohn, Andrew',12,'M','Physical Education','Sheri Vollmer',2),('Freshman 18',9,'M','Physical Education','Sheri Vollmer',2),('Freshman 12',9,'M','Physical Education','Sheri Vollmer',2),('Freshman 7',9,'M','Physical Education','Sheri Vollmer',2),('Freshman 14',9,'M','Physical Education','Sheri Vollmer',2),('Herrera, Aaron',12,'M','Physical Education','Sheri Vollmer',2),('Freshman 11',9,'M','Physical Education','Sheri Vollmer',2),('Vollmer, Sean',10,'M','Physical Education','Sheri Vollmer',2),('Smith, Josh',12,'M','Physical Education','Sheri Vollmer',2),('Freshman 9',9,'M','Physical Education','Sheri Vollmer',2),('Bates, Ayden',11,'M','Physical Education','Sheri Vollmer',2),('Platt, Ruby',12,'F','EP2: Biochemistry I','Georgia Hart',1),('Bates, Ayden',11,'M','EP2: Biochemistry I','Georgia Hart',1),('Hoskins, Levi',11,'M','EP2: Biochemistry I','Georgia Hart',1),('Lukery, Fiona',11,'F','EP2: Biochemistry I','Georgia Hart',1),('Montanez, Jose',11,'M','EP2: Biochemistry I','Georgia Hart',1),('Rietz, Natalia',11,'F','EP2: Biochemistry I','Georgia Hart',1),('Robinson, Daniyah',11,'F','EP2: Biochemistry I','Georgia Hart',1),('Stratford, Faith',11,'F','EP2: Biochemistry I','Georgia Hart',1),('Swartz, Naomi',11,'F','EP2: Biochemistry I','Georgia Hart',1),('Reyes, Leila',11,'F','EP2: Biochemistry I','Georgia Hart',1),('Gama, Jannice',11,'F','EP2: Biochemistry I','Georgia Hart',1),('Agraz-Gonzalez, Alondra ',10,'F','EP1: Science','Chris Heiman',1),('Alvarez-Brown, Gabi',10,'F','EP1: Science','Chris Heiman',1),('Ayensu-Aboagye, Yaw',10,'M','EP1: Science','Chris Heiman',1),('Braimah, Noah',10,'M','EP1: Science','Chris Heiman',1),('Cooper, Marissa',10,'F','EP1: Science','Chris Heiman',1),('Diederich, Grant',10,'M','EP1: Science','Chris Heiman',1),('Flores, Nevaeh',10,'F','EP1: Science','Chris Heiman',1),('Garcia, Anthony',10,'M','EP1: Science','Chris Heiman',1),('Macias Aguilar, Isaias',10,'M','EP1: Science','Chris Heiman',1),('Montoya, Ricky',10,'M','EP1: Science','Chris Heiman',1),('Ornelas, Daissy',10,'F','EP1: Science','Chris Heiman',1),('Ramirez, Gael',10,'M','EP1: Science','Chris Heiman',1),('Valadez, Sebastian',10,'M','EP1: Science','Chris Heiman',1),('Vlahos, Michael',10,'M','EP1: Science','Chris Heiman',1),('Vollmer, Sean',10,'M','EP1: Science','Chris Heiman',1),('William, Khya',10,'F','EP1: Science','Chris Heiman',1),('Freshman 3',9,'F','FP: Science','Chris Heiman',1),('Freshman 2',9,'F','FP: Science','Chris Heiman',1),('Freshman 4',9,'F','FP: Science','Chris Heiman',1),('Freshman 16',9,'M','FP: Science','Chris Heiman',1),('Freshman 8',9,'M','FP: Science','Chris Heiman',1),('Freshman 18',9,'M','FP: Science','Chris Heiman',1),('Freshman 14',9,'M','FP: Science','Chris Heiman',1),('Freshman 9',9,'M','FP: Science','Chris Heiman',1),('Freshman 12',9,'M','FP: Science','Chris Heiman',1),('Freshman 6',9,'F','FP: Science','Georgia Hart',2),('Freshman 1',9,'F','FP: Science','Georgia Hart',2),('Freshman 5',9,'F','FP: Science','Georgia Hart',2),('Freshman 19',9,'M','FP: Science','Georgia Hart',2),('Freshman 13',9,'M','FP: Science','Georgia Hart',2),('Freshman 7',9,'M','FP: Science','Georgia Hart',2),('Freshman 15',9,'M','FP: Science','Georgia Hart',2),('Freshman 10',9,'M','FP: Science','Georgia Hart',2),('Freshman 17',9,'M','FP: Science','Georgia Hart',2),('Freshman 11',9,'M','FP: Science','Georgia Hart',2),('Woodworth, Tristin',12,'M','Spanish 1','Elyssia Finch',1),('Conner, Ryan',11,'M','Spanish 1','Elyssia Finch',1),('Hoskins, Levi',11,'M','Spanish 1','Elyssia Finch',1),('Martinez, Ezekiel',11,'M','Spanish 1','Elyssia Finch',1),('Smith, Kejuan',11,'M','Spanish 1','Elyssia Finch',1),('Castaneda, Milie',11,'F','Spanish 1','Elyssia Finch',1),('Gallego, Ruben',11,'M','Spanish 1','Elyssia Finch',1),('Agraz-Gonzalez, Alondra ',10,'F','Spanish 1','Elyssia Finch',1),('Braimah, Noah',10,'M','Spanish 1','Elyssia Finch',1),('Diederich, Grant',10,'M','Spanish 1','Elyssia Finch',1),('Garcia, Anthony',10,'M','Spanish 1','Elyssia Finch',1),('Valadez, Sebastian',10,'M','Spanish 1','Elyssia Finch',1),('William, Khya',10,'F','Spanish 1','Elyssia Finch',1),('Simmons, Josiah',11,'M','Spanish 1','Elyssia Finch',1),('Swartz, Naomi',11,'F','Spanish 1','Elyssia Finch',1),('Caldwell, Libby',12,'F','Anatomy 2','Georgia Hart',1),('Castaneda, Gabby',12,'F','Anatomy 2','Georgia Hart',1),('Lukery, Fiona',11,'F','Anatomy 2','Georgia Hart',1),('Swartz, Naomi',11,'F','Anatomy 2','Georgia Hart',1),('Mancinas, Samantha',12,'F','Spanish 2','Elyssia Finch',1),('Guggenmos, Bailee',11,'F','Spanish 2','Elyssia Finch',1),('Montanez, Jose',11,'M','Spanish 2','Elyssia Finch',1),('Robinson, Daniyah',11,'F','Spanish 2','Elyssia Finch',1),('Stratford, Faith',11,'F','Spanish 2','Elyssia Finch',1),('Reyes, Leila',11,'F','Spanish 2','Elyssia Finch',1),('Burkum, Everly',11,'F','Spanish 2','Elyssia Finch',1),('Alvarez-Brown, Gabi',10,'F','Spanish 2','Elyssia Finch',1),('Macias Aguilar, Isaias',10,'M','Spanish 2','Elyssia Finch',1),('Ornelas, Daissy',10,'F','Spanish 2','Elyssia Finch',1),('Aguilar, Estacy',11,'F','Spanish 2','Elyssia Finch',1),('Freshman 16',9,'M','Spanish 2','Elyssia Finch',1),('Ramirez, Annel',12,'F','Spanish 3','Elyssia Finch',1),('Ayensu-Aboagye, Yaw',10,'M','Spanish 3','Elyssia Finch',1),('Aguilar, Estacy',11,'F','EP2: Social Sciences','Jen Dalbey',1),('Bates, Ayden',11,'M','EP2: Social Sciences','Jen Dalbey',1),('Conner, Ryan',11,'M','EP2: Social Sciences','Jen Dalbey',1),('Guggenmos, Bailee',11,'F','EP2: Social Sciences','Jen Dalbey',1),('Lukery, Fiona',11,'F','EP2: Social Sciences','Jen Dalbey',1),('Martinez, Ezekiel',11,'M','EP2: Social Sciences','Jen Dalbey',1),('Montanez, Jose',11,'M','EP2: Social Sciences','Jen Dalbey',1),('Rietz, Natalia',11,'F','EP2: Social Sciences','Jen Dalbey',1),('Robinson, Daniyah',11,'F','EP2: Social Sciences','Jen Dalbey',1),('Simmons, Josiah',11,'M','EP2: Social Sciences','Jen Dalbey',1),('Smith, Kejuan',11,'M','EP2: Social Sciences','Jen Dalbey',1),('Stratford, Faith',11,'F','EP2: Social Sciences','Jen Dalbey',1),('Swartz, Naomi',11,'F','EP2: Social Sciences','Jen Dalbey',1),('Agraz-Gonzalez, Alondra ',10,'F','EP1: Social Sciences','Kourtney Shoemaker',1),('Alvarez-Brown, Gabi',10,'F','EP1: Social Sciences','Kourtney Shoemaker',1),('Ayensu-Aboagye, Yaw',10,'M','EP1: Social Sciences','Kourtney Shoemaker',1),('Braimah, Noah',10,'M','EP1: Social Sciences','Kourtney Shoemaker',1),('Cooper, Marissa',10,'F','EP1: Social Sciences','Kourtney Shoemaker',1),('Diederich, Grant',10,'M','EP1: Social Sciences','Kourtney Shoemaker',1),('Flores, Nevaeh',10,'F','EP1: Social Sciences','Kourtney Shoemaker',1),('Garcia, Anthony',10,'M','EP1: Social Sciences','Kourtney Shoemaker',1),('Macias Aguilar, Isaias',10,'M','EP1: Social Sciences','Kourtney Shoemaker',1),('Montoya, Ricky',10,'M','EP1: Social Sciences','Kourtney Shoemaker',1),('Ornelas, Daissy',10,'F','EP1: Social Sciences','Kourtney Shoemaker',1),('Ramirez, Gael',10,'M','EP1: Social Sciences','Kourtney Shoemaker',1),('Valadez, Sebastian',10,'M','EP1: Social Sciences','Kourtney Shoemaker',1),('Vlahos, Michael',10,'M','EP1: Social Sciences','Kourtney Shoemaker',1),('Vollmer, Sean',10,'M','EP1: Social Sciences','Kourtney Shoemaker',1),('William, Khya',10,'F','EP1: Social Sciences','Kourtney Shoemaker',1),('Valadez, Julian',12,'M','CSP (Computer Science Principles)','Ryan Luther',1),('Rietz, Natalia',11,'F','CSP (Computer Science Principles)','Ryan Luther',1),('Simmons, Josiah',11,'M','CSP (Computer Science Principles)','Ryan Luther',1),('Vlahos, Michael',10,'M','CSP (Computer Science Principles)','Ryan Luther',1),('Vollmer, Sean',10,'M','CSP (Computer Science Principles)','Ryan Luther',1),('Ayensu-Aboagye, Yaw',10,'M','CSP (Computer Science Principles)','Ryan Luther',1),('Macias Aguilar, Isaias',10,'M','CSP (Computer Science Principles)','Ryan Luther',1),('Platt, Ruby',12,'F','Theater','Elyssia Finch',1),('Aguilar, Estacy',11,'F','Theater','Elyssia Finch',1),('Smith, Kaiden',11,'M','Theater','Elyssia Finch',1),('Flores, Nevaeh',10,'F','Theater','Elyssia Finch',1),('Montoya, Ricky',10,'M','Theater','Elyssia Finch',1),('Agraz-Gonzalez, Alondra ',10,'F','Theater','Elyssia Finch',1),('Alvarez-Brown, Gabi',10,'F','Theater','Elyssia Finch',1),('Freshman 3',9,'F','Music','TBA',1),('Freshman 2',9,'F','Music','TBA',1),('Freshman 5',9,'F','Music','TBA',1),('Freshman 8',9,'M','Music','TBA',1),('Freshman 14',9,'M','Music','TBA',1),('Freshman 7',9,'M','Music','TBA',1),('Freshman 11',9,'M','Music','TBA',1),('Freshman 15',9,'M','Music','TBA',1),('Freshman 13',9,'M','Music','TBA',1),('Freshman 4',9,'F','Music','TBA',2),('Freshman 1',9,'F','Music','TBA',2),('Freshman 6',9,'F','Music','TBA',2),('Freshman 9',9,'M','Music','TBA',2),('Herrera, Aaron',12,'M','Music','TBA',2),('Freshman 18',9,'M','Music','TBA',2),('Freshman 17',9,'M','Music','TBA',2),('Freshman 12',9,'M','Music','TBA',2),('Freshman 10',9,'M','Music','TBA',2);
/*!40000 ALTER TABLE `formatted_output` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentor`
--

DROP TABLE IF EXISTS `mentor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mentor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL,
  `planning_periods` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentor`
--

LOCK TABLES `mentor` WRITE;
/*!40000 ALTER TABLE `mentor` DISABLE KEYS */;
INSERT INTO `mentor` VALUES (1,'Jen Dalbey',2),(2,'Ed Vogel',4),(3,'Ryan Luther',2),(4,'Kourtney Shoemaker',2),(5,'Megan Heese',2),(6,'Chris Heiman',2),(7,'Elyssia Finch',2),(8,'Georgia Hart',2),(9,'Math Mentor 2',2),(10,'Sheri Vollmer',0),(11,'TBA',0);
/*!40000 ALTER TABLE `mentor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentor_availability`
--

DROP TABLE IF EXISTS `mentor_availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mentor_availability` (
  `day_id` int NOT NULL,
  `mentor_id` int NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentor_availability`
--

LOCK TABLES `mentor_availability` WRITE;
/*!40000 ALTER TABLE `mentor_availability` DISABLE KEYS */;
/*!40000 ALTER TABLE `mentor_availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentor_classroom_preferences`
--

DROP TABLE IF EXISTS `mentor_classroom_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mentor_classroom_preferences` (
  `mentor_id` int NOT NULL,
  `classroom_id` int NOT NULL,
  `ranking` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentor_classroom_preferences`
--

LOCK TABLES `mentor_classroom_preferences` WRITE;
/*!40000 ALTER TABLE `mentor_classroom_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `mentor_classroom_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentor_qualified_courses`
--

DROP TABLE IF EXISTS `mentor_qualified_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mentor_qualified_courses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mentor_id` int NOT NULL,
  `course_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentor_qualified_courses`
--

LOCK TABLES `mentor_qualified_courses` WRITE;
/*!40000 ALTER TABLE `mentor_qualified_courses` DISABLE KEYS */;
INSERT INTO `mentor_qualified_courses` VALUES (2,1,4),(3,1,11),(4,1,10),(5,1,9),(6,1,9),(7,1,7),(8,2,5),(9,2,3),(10,2,3),(11,3,20),(12,3,17),(13,3,17),(14,3,17),(15,3,23),(16,4,8),(17,4,8),(18,4,6),(19,4,6),(20,4,6),(21,5,2),(22,5,2),(23,5,1),(24,5,1),(25,5,1),(26,6,14),(27,6,13),(28,6,13),(29,6,12),(30,7,24),(31,7,25),(32,7,26),(33,7,28),(34,8,16),(35,8,15),(36,8,12),(37,8,12),(38,8,22),(39,9,18),(40,9,18),(41,9,19),(42,9,21),(43,10,29),(44,10,29);
/*!40000 ALTER TABLE `mentor_qualified_courses` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `student_commitments`
--

DROP TABLE IF EXISTS `student_commitments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_commitments` (
  `commitment_type_id` int NOT NULL,
  `student_id` int NOT NULL,
  `day_id` int NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_commitments`
--

LOCK TABLES `student_commitments` WRITE;
/*!40000 ALTER TABLE `student_commitments` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_commitments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_course_preferences`
--

DROP TABLE IF EXISTS `student_course_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_course_preferences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,
  `ranking` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=387 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_course_preferences`
--

LOCK TABLES `student_course_preferences` WRITE;
/*!40000 ALTER TABLE `student_course_preferences` DISABLE KEYS */;
INSERT INTO `student_course_preferences` VALUES (1,2,4,1),(2,2,20,2),(3,2,10,3),(4,2,16,4),(5,2,29,5),(6,3,5,1),(7,3,16,2),(8,3,11,3),(9,3,22,4),(10,4,4,1),(11,4,16,2),(12,4,10,3),(13,4,21,4),(14,4,22,5),(15,5,5,1),(16,5,18,2),(17,5,10,3),(18,5,29,4),(19,6,5,1),(20,6,20,2),(21,6,7,3),(22,7,5,1),(23,7,21,2),(24,7,7,3),(25,7,16,4),(26,7,29,5),(27,7,27,6),(28,8,4,1),(29,8,18,2),(30,8,10,3),(31,8,29,4),(32,9,5,1),(33,9,11,2),(34,9,29,3),(35,10,4,1),(36,10,18,2),(37,10,7,3),(38,10,10,4),(39,10,29,5),(40,11,4,1),(41,11,6,2),(42,11,21,3),(43,11,25,4),(44,11,29,5),(45,12,5,1),(46,12,21,2),(47,12,11,3),(48,13,4,1),(49,13,20,2),(50,13,15,3),(51,13,10,4),(52,13,28,5),(53,14,5,1),(54,14,11,2),(55,14,29,3),(56,15,5,1),(57,15,21,2),(58,15,11,3),(59,15,26,4),(60,16,4,1),(61,16,14,2),(62,16,10,3),(63,16,18,4),(64,16,29,5),(65,17,5,1),(66,17,16,2),(67,17,11,3),(68,17,21,4),(69,17,23,5),(70,18,4,1),(71,18,14,2),(72,18,21,3),(73,18,10,4),(74,18,29,5),(75,19,4,1),(76,19,10,2),(77,19,18,3),(78,19,24,4),(79,20,3,1),(80,20,19,2),(81,20,14,3),(82,20,9,4),(83,20,28,5),(84,20,25,6),(85,21,3,1),(86,21,20,2),(87,21,15,3),(88,21,9,4),(89,21,29,5),(90,22,3,1),(91,22,19,2),(92,22,14,3),(93,22,7,4),(94,22,25,5),(95,23,3,1),(96,23,19,2),(97,23,14,3),(98,23,7,4),(99,23,24,5),(100,24,3,1),(101,24,19,2),(102,24,14,3),(103,24,7,4),(104,25,3,1),(105,25,18,2),(106,25,14,3),(107,25,9,4),(108,25,24,5),(109,26,3,1),(110,26,18,2),(111,26,14,3),(112,26,7,4),(113,26,24,5),(114,27,3,1),(115,27,20,2),(116,27,15,3),(117,27,7,4),(118,27,29,5),(119,28,3,1),(120,28,19,2),(121,28,14,3),(122,28,9,4),(123,28,25,5),(124,29,3,1),(125,29,20,2),(126,29,15,3),(127,29,10,4),(128,29,24,5),(129,29,29,6),(130,30,3,1),(131,30,20,2),(132,30,15,3),(133,30,9,4),(134,30,22,5),(135,30,29,6),(136,31,3,1),(137,31,18,2),(138,31,14,3),(139,31,9,4),(140,31,24,5),(141,32,3,1),(142,32,20,2),(143,32,15,3),(144,32,9,4),(145,32,25,5),(146,33,3,1),(147,33,19,2),(148,33,15,3),(149,33,7,4),(150,33,25,5),(151,34,3,1),(152,34,20,2),(153,34,15,3),(154,34,9,4),(155,34,23,5),(156,35,3,1),(157,35,20,2),(158,35,15,3),(159,35,9,4),(160,35,25,5),(161,35,29,6),(162,36,3,1),(163,36,20,2),(164,36,14,3),(165,36,9,4),(166,36,23,5),(167,36,24,6),(168,37,3,1),(169,37,19,2),(170,37,14,3),(171,37,7,4),(172,37,28,5),(173,38,3,1),(174,38,18,2),(175,38,14,3),(176,38,9,4),(177,38,24,5),(178,39,3,1),(179,39,20,2),(180,39,15,3),(181,39,9,4),(182,39,25,5),(183,39,29,6),(184,40,3,1),(185,40,20,2),(186,40,15,3),(187,40,9,4),(188,40,22,5),(189,40,24,6),(190,41,2,1),(191,41,18,2),(192,41,13,3),(193,41,8,4),(194,41,24,5),(195,41,28,6),(196,42,2,1),(197,42,18,2),(198,42,13,3),(199,42,8,4),(200,42,25,5),(201,42,28,6),(202,43,2,1),(203,43,18,2),(204,43,13,3),(205,43,8,4),(206,43,26,5),(207,43,23,6),(208,44,2,1),(209,44,18,2),(210,44,13,3),(211,44,8,4),(212,44,24,5),(213,45,2,1),(214,45,18,2),(215,45,13,3),(216,45,8,4),(217,46,2,1),(218,46,18,2),(219,46,13,3),(220,46,8,4),(221,46,24,5),(222,47,2,1),(223,47,18,2),(224,47,13,3),(225,47,8,4),(226,47,28,5),(227,48,2,1),(228,48,18,2),(229,48,13,3),(230,48,8,4),(231,48,24,5),(232,49,2,1),(233,49,18,2),(234,49,13,3),(235,49,8,4),(236,49,25,5),(237,49,23,6),(238,50,2,1),(239,50,18,2),(240,50,13,3),(241,50,8,4),(242,50,28,5),(243,51,2,1),(244,51,18,2),(245,51,13,3),(246,51,8,4),(247,51,25,5),(248,52,2,1),(249,52,18,2),(250,52,13,3),(251,52,8,4),(252,52,29,5),(253,53,2,1),(254,53,18,2),(255,53,13,3),(256,53,8,4),(257,53,24,5),(258,54,2,1),(259,54,18,2),(260,54,13,3),(261,54,8,4),(262,54,23,5),(263,55,2,1),(264,55,18,2),(265,55,13,3),(266,55,8,4),(267,55,23,5),(268,55,29,6),(269,56,2,1),(270,56,18,2),(271,56,13,3),(272,56,8,4),(273,56,24,5),(274,57,1,1),(275,57,18,2),(276,57,12,3),(277,57,6,4),(278,57,29,5),(279,57,27,6),(280,58,1,1),(281,58,17,2),(282,58,12,3),(283,58,6,4),(284,58,29,5),(285,58,27,6),(286,59,1,1),(287,59,17,2),(288,59,12,3),(289,59,6,4),(290,59,29,5),(291,59,27,6),(292,60,1,1),(293,60,17,2),(294,60,12,3),(295,60,6,4),(296,60,29,5),(297,60,27,6),(298,61,1,1),(299,61,17,2),(300,61,12,3),(301,61,6,4),(302,61,29,5),(303,61,27,6),(304,62,1,1),(305,62,17,2),(306,62,12,3),(307,62,6,4),(308,62,29,5),(309,62,27,6),(310,63,1,1),(311,63,17,2),(312,63,12,3),(313,63,6,4),(314,63,29,5),(315,63,27,6),(316,64,1,1),(317,64,17,2),(318,64,12,3),(319,64,6,4),(320,64,29,5),(321,64,27,6),(322,65,1,1),(323,65,17,2),(324,65,12,3),(325,65,6,4),(326,65,29,5),(327,65,27,6),(328,66,1,1),(329,66,17,2),(330,66,12,3),(331,66,6,4),(332,66,29,5),(333,66,27,6),(334,67,1,1),(335,67,18,2),(336,67,12,3),(337,67,6,4),(338,67,29,5),(339,67,27,6),(340,68,1,1),(341,68,17,2),(342,68,12,3),(343,68,6,4),(344,68,29,5),(345,68,27,6),(346,69,1,1),(347,69,17,2),(348,69,12,3),(349,69,6,4),(350,69,29,5),(351,69,27,6),(352,70,1,1),(353,70,17,2),(354,70,12,3),(355,70,6,4),(356,70,29,5),(357,70,27,6),(358,71,1,1),(359,71,17,2),(360,71,12,3),(361,71,6,4),(362,71,29,5),(363,71,27,6),(364,72,1,1),(365,72,17,2),(366,72,12,3),(367,72,6,4),(368,72,29,5),(369,72,25,6),(370,73,1,1),(371,73,17,2),(372,73,12,3),(373,73,6,4),(374,73,29,5),(375,73,27,6),(376,74,1,1),(377,74,17,2),(378,74,12,3),(379,74,6,4),(380,74,29,5),(381,74,27,6),(382,75,1,1),(383,75,17,2),(384,75,12,3),(385,75,6,4),(386,75,29,5);
/*!40000 ALTER TABLE `student_course_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_course_preferences_unenrolled`
--

DROP TABLE IF EXISTS `student_course_preferences_unenrolled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_course_preferences_unenrolled` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,
  `ranking` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=387 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_course_preferences_unenrolled`
--

LOCK TABLES `student_course_preferences_unenrolled` WRITE;
/*!40000 ALTER TABLE `student_course_preferences_unenrolled` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_course_preferences_unenrolled` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `unformatted_preferences`
--

DROP TABLE IF EXISTS `unformatted_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unformatted_preferences` (
  `student_id` int DEFAULT NULL,
  `student_name` varchar(80) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `grade` varchar(10) DEFAULT NULL,
  `free_periods` int DEFAULT NULL,
  `req_1` varchar(40) DEFAULT NULL,
  `req_2` varchar(40) DEFAULT NULL,
  `req_3` varchar(40) DEFAULT NULL,
  `req_4` varchar(40) DEFAULT NULL,
  `req_5` varchar(40) DEFAULT NULL,
  `req_6` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unformatted_preferences`
--

LOCK TABLES `unformatted_preferences` WRITE;
/*!40000 ALTER TABLE `unformatted_preferences` DISABLE KEYS */;
INSERT INTO `unformatted_preferences` VALUES (2,'Beach, Jack','Male','Senior',2,'TP: English','EP2: Precalculus','TP: American Government','TP: Biochemistry II','Physical Education',''),(3,'Caldwell, Libby','Female','Senior',2,'TP: College Level English','TP: Biochemistry II','TP: Economics','','Anatomy 2',''),(4,'Castaneda, Gabby','Female','Senior',1,'TP: English','TP: Biochemistry II','TP: American Government','EP2: Precalculus Con.','Anatomy 2',''),(5,'Godinez, Alejandra','Female','Senior',2,'TP: College Level English','EP1: Mathematics','TP: American Government','','Physical Education',''),(6,'Heaney, Robert','Male','Senior',1,'TP: College Level English','EP2: Precalculus','FP: Social Science (Upper Grades)','','',''),(7,'Herrera, Aaron','Male','Senior',1,'TP: College Level English','EP2: Precalculus Con.','FP: Social Science (Upper Grades)','TP: Biochemistry II','Physical Education','Music'),(8,'Hohn, Andrew','Male','Senior',2,'TP: English','EP1: Mathematics','TP: American Government','','Physical Education',''),(9,'Jackson, McKinley','Female','Senior',2,'TP: College Level English','TP: Economics','','','Physical Education',''),(10,'Johnson, Khia','Female','Senior',2,'TP: English','EP1: Mathematics','FP: Social Science (Upper Grades)','TP: American Government','Physical Education',''),(11,'Mancinas, Samantha','Female','Senior',2,'TP: English','FP: Social Sciences','EP2: Precalculus Con.','','Spanish 2','Physical Education'),(12,'McKell, Keyaira','Female','Senior',2,'TP: College Level English','EP2: Precalculus Con.','TP: Economics','','',''),(13,'Platt, Ruby','Female','Senior',2,'TP: English','EP2: Precalculus','EP2: Biochemistry I','TP: American Government','Theater',''),(14,'Radloff, Rachel','Female','Senior',1,'TP: College Level English','TP: Economics','','','Physical Education',''),(15,'Ramirez, Annel','Female','Senior',1,'TP: College Level English','EP2: Precalculus Con.','TP: Economics','','Spanish 3',''),(16,'Smith, Josh','Male','Senior',2,'TP: English','EP2: Integrated Science','TP: American Government','EP1: Mathematics','Physical Education',''),(17,'Valadez, Julian','Male','Senior',1,'TP: College Level English','TP: Biochemistry II','TP: Economics','EP2: Precalculus Con.','CSP',''),(18,'Vollmer, Joey','Male','Senior',2,'TP: English','EP2: Integrated Science','EP2: Precalculus Con.','TP: American Government','Physical Education',''),(19,'Woodworth, Tristin','Male','Senior',2,'TP: English','TP: American Government','EP1: Mathematics','','Spanish 1',''),(20,'Aguilar, Estacy','Female','Junior',2,'EP2: English','EP2: Integrated Math','EP2: Integrated Science','EP2: Social Sciences','Theater','Spanish 2'),(21,'Bates, Ayden','Male','Junior',2,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','EP2: Social Sciences','Physical Education',''),(22,'Burkum, Everly','Female','Junior',2,'EP2: English','EP2: Integrated Math','EP2: Integrated Science','FP: Social Science (Upper Grades)','Spanish 2',''),(23,'Castaneda, Milie','Female','Junior',2,'EP2: English','EP2: Integrated Math','EP2: Integrated Science','FP: Social Science (Upper Grades)','Spanish 1',''),(24,'Castaneda, Martha ','Female','Junior',2,'EP2: English','EP2: Integrated Math','EP2: Integrated Science','FP: Social Science (Upper Grades)','',''),(25,'Conner, Ryan','Male','Junior',2,'EP2: English','EP1: Mathematics','EP2: Integrated Science','EP2: Social Sciences','Spanish 1',''),(26,'Gallego, Ruben','Male','Junior',2,'EP2: English','EP1: Mathematics','EP2: Integrated Science','FP: Social Science (Upper Grades)','Spanish 1',''),(27,'Gama, Jannice','Female','Junior',2,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','FP: Social Science (Upper Grades)','Physical Education',''),(28,'Guggenmos, Bailee','Female','Junior',2,'EP2: English','EP2: Integrated Math','EP2: Integrated Science','EP2: Social Sciences','Spanish 2',''),(29,'Hoskins, Levi','Male','Junior',1,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','TP: American Government','Spanish 1','Physical Education'),(30,'Lukery, Fiona','Female','Junior',1,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','EP2: Social Sciences','Anatomy 2','Physical Education'),(31,'Martinez, Ezekiel','Male','Junior',2,'EP2: English','EP1: Mathematics','EP2: Integrated Science','EP2: Social Sciences','Spanish 1',''),(32,'Montanez, Jose','Male','Junior',2,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','EP2: Social Sciences','Spanish 2',''),(33,'Reyes, Leila','Female','Junior',1,'EP2: English','EP2: Integrated Math','EP2: Biochemistry I','FP: Social Science (Upper Grades)','Spanish 2',''),(34,'Rietz, Natalia','Female','Junior',2,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','EP2: Social Sciences','CSP',''),(35,'Robinson, Daniyah','Female','Junior',1,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','EP2: Social Sciences','Spanish 2','Physical Education'),(36,'Simmons, Josiah','Male','Junior',2,'EP2: English','EP2: Precalculus','EP2: Integrated Science','EP2: Social Sciences','CSP','Spanish 1'),(37,'Smith, Kaiden','Male','Junior',1,'EP2: English','EP2: Integrated Math','EP2: Integrated Science','FP: Social Science (Upper Grades)','Theater',''),(38,'Smith, Kejuan','Male','Junior',2,'EP2: English','EP1: Mathematics','EP2: Integrated Science','EP2: Social Sciences','Spanish 1',''),(39,'Stratford, Faith','Female','Junior',1,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','EP2: Social Sciences','Spanish 2','Physical Education'),(40,'Swartz, Naomi','Female','Junior',1,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','EP2: Social Sciences','Anatomy 2','Spanish 1'),(41,'Agraz-Gonzalez, Alondra ','Female','Sophomore',1,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 1','Theater'),(42,'Alvarez-Brown, Gabi','Female','Sophomore',1,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 2','Theater'),(43,'Ayensu-Aboagye, Yaw','Male','Sophomore',1,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 3','CSP'),(44,'Braimah, Noah','Male','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 1',''),(45,'Cooper, Marissa','Female','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','',''),(46,'Diederich, Grant','Male','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 1',''),(47,'Flores, Nevaeh','Female','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Theater ',''),(48,'Garcia, Anthony','Male','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 1',''),(49,'Macias Aguilar, Isaias','Male','Sophomore',1,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 2','CSP'),(50,'Montoya, Ricky','Male','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Theater ',''),(51,'Ornelas, Daissy','Female','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 2',''),(52,'Ramirez, Gael','Male','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Physical Education',''),(53,'Valadez, Sebastian','Male','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 1',''),(54,'Vlahos, Michael','Male','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','CSP',''),(55,'Vollmer, Sean','Male','Sophomore',1,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','CSP','Physical Education'),(56,'William, Khya','Female','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 1',''),(57,'Freshman 1','Female','Freshman',1,'FP: English','EP1: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(58,'Freshman 2','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music'),(59,'Freshman 3','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music'),(60,'Freshman 4','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music'),(61,'Freshman 5','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music'),(62,'Freshman 6','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music'),(63,'Freshman 7','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music'),(64,'Freshman 8','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music'),(65,'Freshman 9','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music'),(66,'Freshman 10','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music'),(67,'Freshman 11','Male','Freshman',1,'FP: English','EP1: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music'),(68,'Freshman 12','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music'),(69,'Freshman 13','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music'),(70,'Freshman 14','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music'),(71,'Freshman 15','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music'),(72,'Freshman 16','Male','Freshman',2,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Spanish 2'),(73,'Freshman 17','Male','Freshman',2,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music '),(74,'Freshman 18','Male','Freshman',2,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education','Music'),(75,'Freshman 19','Male','Freshman',2,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physcial Education',' ');
/*!40000 ALTER TABLE `unformatted_preferences` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-20 12:27:26
