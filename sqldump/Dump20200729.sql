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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
INSERT INTO `classroom` VALUES (1,'330',18,1),(2,'332',18,1),(3,'334',18,1),(4,'336',20,2),(5,'340',18,2),(6,'354B',18,3),(7,'354A',80,4),(8,'307 (conf. room)',9,5),(9,'316',7,5);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_type`
--

LOCK TABLES `classroom_type` WRITE;
/*!40000 ALTER TABLE `classroom_type` DISABLE KEYS */;
INSERT INTO `classroom_type` VALUES (1,'Humanities & Electives'),(2,'STEM & Electives'),(3,'Science & Science Electives'),(4,'Pathways, Open Quest, PE'),(5,'Humanities: Transition Phase Only');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commitment_type`
--

LOCK TABLES `commitment_type` WRITE;
/*!40000 ALTER TABLE `commitment_type` DISABLE KEYS */;
INSERT INTO `commitment_type` VALUES (1,'Internship'),(2,'Extracurricular'),(3,'College course'),(4,'Off campus class');
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
  `course_type` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'FP: English','9',0,'1'),(2,'EP1: English','10',0,'1'),(3,'EP2: English','11',0,'1'),(4,'TP: English','12',0,'5'),(5,'TP: College Level English','12',0,'5'),(6,'FP: Social Sciences','9',0,'1'),(7,'FP: Social Science (Upper Grades)','9',0,'1'),(8,'EP1: Social Sciences','10',0,'1'),(9,'EP2: Social Sciences','11',0,'1'),(10,'TP: American Government','12',0,'5'),(11,'TP: Economics','12',0,'5'),(12,'FP: Science','9',0,'3'),(13,'EP1: Science','10',0,'3'),(14,'EP2: Integrated Science','11',0,'3'),(15,'EP2: Biochemistry I','11',0,'3'),(16,'TP: Biochemistry II','12',0,'3'),(17,'FP: Mathematics','9',0,'2'),(18,'EP1: Mathematics','10',0,'2'),(19,'EP2: Integrated Math','11',0,'2'),(20,'EP2: Precalculus','11',0,'2'),(21,'EP2: Precalculus Con.','11',0,'2'),(22,'Anatomy 2','10',1,'3'),(23,'CSP (Computer Science Principles)','9,10,11,12',1,'2'),(24,'Spanish 1','10,11,12',1,'1,2'),(25,'Spanish 2','10',1,'1,2'),(26,'Spanish 3','10',1,'1,2'),(27,'Music','9,10,11,12',1,'1,2'),(28,'Theater','9,10,11,12',1,'1,2'),(29,'Physical Education','9,10,11,12',1,'4');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_conflicts`
--

DROP TABLE IF EXISTS `course_conflicts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_conflicts` (
  `id` int DEFAULT NULL,
  `duplicates` varchar(200) DEFAULT NULL,
  `duplicates_num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_conflicts`
--

LOCK TABLES `course_conflicts` WRITE;
/*!40000 ALTER TABLE `course_conflicts` DISABLE KEYS */;
INSERT INTO `course_conflicts` VALUES (1,'6,12,17,27,29',5),(2,'8,13,18',3),(3,'9,19',2),(4,'None',0),(5,'11',1),(6,'1,12,17,27,29',5),(7,'None',0),(8,'2,13,18',3),(9,'3',1),(10,'None',0),(11,'5',1),(12,'1,6,17,27,29',5),(13,'2,8,18',3),(14,'None',0),(15,'None',0),(16,'None',0),(17,'1,6,12,27,29',5),(18,'2,8,13',3),(19,'3',1),(20,'None',0),(21,'None',0),(22,'None',0),(23,'None',0),(24,'None',0),(25,'None',0),(26,'None',0),(27,'1,6,12,17,29',5),(28,'None',0),(29,'1,6,12,17,27',5);
/*!40000 ALTER TABLE `course_conflicts` ENABLE KEYS */;
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
INSERT INTO `course_enrollment` VALUES (10,1,0),(16,1,0),(6,2,0),(12,2,0),(3,2,0),(4,1,0),(13,1,0),(8,1,0),(7,2,0),(5,2,0),(19,1,0),(11,1,0),(9,2,0),(15,2,0),(18,1,0),(17,2,0),(2,1,0),(14,2,0),(20,3,0),(21,3,0),(28,3,0),(29,3,0),(30,3,0),(31,3,0),(32,3,0),(34,3,0),(35,3,0),(36,3,0),(39,3,0),(40,3,0),(27,3,0),(37,3,0),(38,3,0),(33,3,0),(24,3,0),(23,3,0),(25,3,0),(22,3,0),(26,3,0),(41,4,0),(42,4,0),(43,4,0),(44,4,0),(45,4,0),(46,4,0),(47,4,0),(48,4,0),(49,4,0),(50,4,0),(51,4,0),(52,4,0),(53,4,0),(54,4,0),(55,4,0),(56,4,0),(76,5,0),(81,5,0),(70,5,0),(65,5,0),(83,5,0),(78,5,0),(64,5,0),(79,5,0),(67,5,0),(57,5,0),(72,5,0),(82,5,0),(66,5,0),(69,5,0),(89,5,0),(75,5,0),(87,5,0),(59,5,0),(60,5,0),(58,5,0),(77,5,0),(71,5,0),(63,5,0),(68,5,0),(61,5,0),(74,5,0),(85,5,0),(86,5,0),(62,5,0),(73,5,0),(84,5,0),(80,5,0),(10,6,0),(16,7,0),(6,8,0),(12,9,0),(3,10,0),(4,10,0),(13,8,0),(8,6,0),(7,9,0),(5,6,0),(19,11,0),(11,12,0),(9,13,0),(15,9,0),(18,7,0),(17,10,0),(2,8,0),(14,13,0),(20,14,0),(21,8,0),(28,14,0),(29,8,0),(30,8,0),(31,6,0),(32,8,0),(34,8,0),(35,8,0),(36,8,0),(39,8,0),(40,8,0),(27,8,0),(37,14,0),(38,6,0),(33,14,0),(24,14,0),(23,14,0),(25,6,0),(22,14,0),(26,6,0),(41,6,0),(42,6,0),(43,8,0),(44,6,0),(45,6,0),(46,6,0),(47,6,0),(48,6,0),(49,6,0),(50,6,0),(51,6,0),(52,6,0),(53,6,0),(54,6,0),(55,6,0),(56,6,0),(76,15,0),(81,15,0),(70,15,0),(65,15,0),(83,15,0),(78,15,0),(64,15,0),(79,15,0),(67,6,0),(57,6,0),(72,15,0),(82,15,0),(66,15,0),(69,15,0),(89,15,0),(75,15,0),(87,15,0),(59,15,0),(60,15,0),(58,15,0),(77,15,0),(71,15,0),(63,15,0),(68,15,0),(61,15,0),(74,6,0),(85,15,0),(86,15,0),(62,15,0),(73,15,0),(84,15,0),(80,15,0),(10,16,0),(16,11,0),(6,16,0),(12,13,0),(3,13,0),(4,11,0),(13,17,0),(8,11,0),(7,16,0),(5,11,0),(19,6,0),(11,9,0),(9,18,0),(15,13,0),(18,9,0),(17,13,0),(2,11,0),(14,18,0),(20,7,0),(21,17,0),(28,7,0),(29,17,0),(30,17,0),(31,7,0),(32,7,0),(34,17,0),(35,17,0),(36,7,0),(39,17,0),(40,17,0),(27,17,0),(37,7,0),(38,7,0),(33,17,0),(24,7,0),(23,7,0),(25,7,0),(22,7,0),(26,7,0),(41,19,0),(42,19,0),(43,19,0),(44,19,0),(45,19,0),(46,19,0),(47,19,0),(48,19,0),(49,19,0),(50,19,0),(51,19,0),(52,19,0),(53,19,0),(54,19,0),(55,19,0),(56,19,0),(76,20,0),(81,20,0),(70,20,0),(65,20,0),(83,20,0),(78,20,0),(64,20,0),(79,20,0),(67,20,0),(57,20,0),(72,20,0),(82,20,0),(66,20,0),(69,20,0),(89,20,0),(75,20,0),(87,20,0),(59,20,0),(60,20,0),(58,20,0),(77,20,0),(71,20,0),(63,20,0),(68,20,0),(61,20,0),(74,20,0),(85,20,0),(86,20,0),(62,20,0),(73,20,0),(84,20,0),(80,20,0),(10,11,0),(16,6,0),(6,21,0),(3,22,0),(4,9,0),(13,11,0),(8,18,0),(7,10,0),(5,18,0),(19,23,0),(11,21,0),(9,24,0),(18,11,0),(17,9,0),(2,10,0),(14,24,0),(20,25,0),(21,25,0),(28,25,0),(29,11,0),(30,25,0),(31,25,0),(32,25,0),(34,25,0),(35,25,0),(36,25,0),(39,25,0),(40,25,0),(27,16,0),(37,16,0),(38,25,0),(33,16,0),(24,16,0),(23,16,0),(25,25,0),(22,16,0),(26,16,0),(41,26,0),(42,26,0),(43,26,0),(44,26,0),(45,26,0),(46,26,0),(47,26,0),(48,26,0),(49,26,0),(50,26,0),(51,26,0),(52,26,0),(53,26,0),(54,26,0),(55,26,0),(56,26,0),(76,12,0),(81,12,0),(70,12,0),(65,12,0),(83,12,0),(78,12,0),(64,12,0),(79,12,0),(67,12,0),(57,12,0),(72,12,0),(82,12,0),(66,12,0),(69,12,0),(89,12,0),(75,12,0),(87,12,0),(59,12,0),(60,12,0),(58,12,0),(77,12,0),(71,12,0),(63,12,0),(68,12,0),(61,12,0),(74,12,0),(85,12,0),(86,12,0),(62,12,0),(73,12,0),(84,12,0),(80,12,0),(10,18,0),(16,18,0),(3,27,0),(4,22,0),(13,24,0),(7,21,0),(5,21,0),(11,18,0),(18,18,0),(17,27,0),(2,18,0),(20,21,0),(21,18,0),(28,21,0),(29,23,0),(30,23,0),(31,23,0),(32,21,0),(34,27,0),(35,21,0),(36,27,0),(39,21,0),(40,22,0),(27,18,0),(37,24,0),(38,18,0),(33,23,0),(23,23,0),(25,18,0),(22,21,0),(26,23,0),(41,23,0),(42,23,0),(43,21,0),(44,24,0),(46,23,0),(47,24,0),(48,23,0),(49,23,0),(50,23,0),(51,18,0),(52,18,0),(53,23,0),(54,18,0),(55,27,0),(56,23,0),(76,18,0),(81,18,0),(70,18,0),(65,18,0),(83,18,0),(78,18,0),(64,18,0),(79,18,0),(67,18,0),(57,18,0),(72,18,0),(82,18,0),(66,18,0),(69,18,0),(89,18,0),(75,18,0),(87,18,0),(59,18,0),(60,18,0),(58,18,0),(77,18,0),(71,18,0),(63,18,0),(68,18,0),(61,18,0),(74,18,0),(85,18,0),(86,18,0),(62,18,0),(73,18,0),(84,18,0),(80,18,0),(16,24,0),(4,21,0),(7,28,0),(29,18,0),(30,18,0),(35,18,0),(36,18,0),(39,18,0),(23,24,0),(41,18,0),(42,24,0),(49,27,0),(54,28,0),(55,18,0),(76,28,0),(81,28,0),(70,28,0),(65,28,0),(83,28,0),(78,28,0),(64,28,0),(79,28,0),(67,28,0),(57,28,0),(72,28,0),(82,28,0),(66,28,0),(69,28,0),(89,28,0),(75,28,0),(87,28,0),(59,28,0),(60,28,0),(58,28,0),(77,28,0),(71,28,0),(63,28,0),(68,28,0),(61,28,0),(74,21,0),(85,28,0),(86,28,0),(62,28,0),(73,28,0),(84,28,0),(80,28,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_section`
--

LOCK TABLES `course_section` WRITE;
/*!40000 ALTER TABLE `course_section` DISABLE KEYS */;
INSERT INTO `course_section` VALUES (1,4,1,0,0,9,5),(2,5,1,0,0,9,3),(3,3,1,0,0,21,9),(4,2,1,0,0,16,10),(5,1,1,0,0,32,12),(6,18,1,0,0,27,16),(7,14,1,0,0,14,9),(8,20,1,0,0,14,7),(9,21,1,0,0,7,3),(10,16,1,0,0,5,3),(11,10,1,0,0,10,6),(12,6,1,0,0,33,12),(13,11,1,0,0,6,1),(14,19,1,0,0,7,1),(15,17,1,0,0,29,12),(16,7,1,0,0,10,4),(17,15,1,0,0,10,2),(18,29,1,0,0,55,24),(19,13,1,0,0,16,10),(20,12,1,0,0,32,12),(21,25,1,0,0,13,4),(22,22,1,0,0,3,0),(23,24,1,0,0,15,9),(24,28,1,0,0,9,3),(25,9,1,0,0,13,6),(26,8,1,0,0,16,10),(27,23,1,0,0,6,4),(28,27,1,0,0,33,14);
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
  `section_number` int DEFAULT NULL,
  `period` int DEFAULT NULL,
  `classroom` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formatted_output`
--

LOCK TABLES `formatted_output` WRITE;
/*!40000 ALTER TABLE `formatted_output` DISABLE KEYS */;
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
INSERT INTO `mentor_availability` VALUES (3,10,'06:00:00','18:00:00'),(5,10,'06:00:00','18:00:00');
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
-- Table structure for table `periods`
--

DROP TABLE IF EXISTS `periods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `periods` (
  `id` int DEFAULT NULL,
  `day_id` int DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `periods_left` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periods`
--

LOCK TABLES `periods` WRITE;
/*!40000 ALTER TABLE `periods` DISABLE KEYS */;
INSERT INTO `periods` VALUES (1,2,'09:00:00','10:40:00',7),(1,4,'09:00:00','10:40:00',7),(1,6,'09:00:00','10:00:00',7),(2,2,'10:50:00','12:30:00',7),(2,4,'10:50:00','12:30:00',7),(2,6,'10:05:00','11:05:00',7),(3,2,'13:50:00','15:30:00',7),(3,4,'13:50:00','15:30:00',7),(3,6,'11:15:00','12:15:00',7),(4,3,'09:00:00','10:40:00',7),(4,5,'09:00:00','10:40:00',7),(4,6,'09:00:00','10:00:00',7),(5,3,'10:50:00','12:30:00',7),(5,5,'10:50:00','12:30:00',7),(5,6,'10:05:00','11:05:00',7),(6,3,'13:50:00','15:30:00',7),(6,5,'13:50:00','15:30:00',7),(6,6,'11:15:00','12:15:00',7);
/*!40000 ALTER TABLE `periods` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (2,'Beach, Jack','M',12,2),(3,'Caldwell, Libby','F',12,2),(4,'Castaneda, Gabby','F',12,1),(5,'Godinez, Alejandra','F',12,2),(6,'Heaney, Robert','M',12,1),(7,'Herrera, Aaron','M',12,1),(8,'Hohn, Andrew','M',12,2),(9,'Jackson, McKinley','F',12,2),(10,'Johnson, Khia','F',12,2),(11,'Mancinas, Samantha','F',12,2),(12,'McKell, Keyaira','F',12,2),(13,'Platt, Ruby','F',12,2),(14,'Radloff, Rachel','F',12,1),(15,'Ramirez, Annel','F',12,1),(16,'Smith, Josh','M',12,2),(17,'Valadez, Julian','M',12,1),(18,'Vollmer, Joey','M',12,2),(19,'Woodworth, Tristin','M',12,2),(20,'Aguilar, Estacy','F',11,2),(21,'Bates, Ayden','M',11,2),(22,'Burkum, Everly','F',11,2),(23,'Castaneda, Milie','F',11,2),(24,'Castaneda, Martha ','F',11,2),(25,'Conner, Ryan','M',11,2),(26,'Gallego, Ruben','M',11,2),(27,'Gama, Jannice','F',11,2),(28,'Guggenmos, Bailee','F',11,2),(29,'Hoskins, Levi','M',11,1),(30,'Lukery, Fiona','F',11,1),(31,'Martinez, Ezekiel','M',11,2),(32,'Montanez, Jose','M',11,2),(33,'Reyes, Leila','F',11,1),(34,'Rietz, Natalia','F',11,2),(35,'Robinson, Daniyah','F',11,1),(36,'Simmons, Josiah','M',11,2),(37,'Smith, Kaiden','M',11,1),(38,'Smith, Kejuan','M',11,2),(39,'Stratford, Faith','F',11,1),(40,'Swartz, Naomi','F',11,1),(41,'Agraz-Gonzalez, Alondra ','F',10,1),(42,'Alvarez-Brown, Gabi','F',10,1),(43,'Ayensu-Aboagye, Yaw','M',10,1),(44,'Braimah, Noah','M',10,2),(45,'Cooper, Marissa','F',10,2),(46,'Diederich, Grant','M',10,2),(47,'Flores, Nevaeh','F',10,2),(48,'Garcia, Anthony','M',10,2),(49,'Macias Aguilar, Isaias','M',10,1),(50,'Montoya, Ricky','M',10,2),(51,'Ornelas, Daissy','F',10,2),(52,'Ramirez, Gael','M',10,2),(53,'Valadez, Sebastian','M',10,2),(54,'Vlahos, Michael','M',10,2),(55,'Vollmer, Sean','M',10,1),(56,'William, Khya','F',10,2),(57,'Schoell, Tatyana','F',9,1),(58,'Field, Kaida','F',9,1),(59,'Carter, Irelynd','F',9,1),(60,'Hahn, Jason','M',9,1),(61,'Wasser, Lilly','F',9,1),(62,'McGill, Nick','M',9,1),(63,'Herrera, Griffin','M',9,1),(64,'Baker, Atticus','M',9,1),(65,'Peters, Sebastian','M',9,1),(66,'Peterson, Vivian','F',9,1),(67,'DeNomme, Chloe','F',9,1),(68,'Cooper, Vanessa','F',9,1),(69,'Martin, Maurissa','F',9,1),(70,'Shoemaker, Victoria','F',9,1),(71,'Lizdas, Elena','F',9,1),(72,'Eggerson, Genesis','F',9,1),(73,'Martin, Pasha','F',9,1),(74,'Odell, Lindsey','F',9,1),(75,'Ahrens, Topher','M',9,1),(76,'Connelly, Seamus','M',9,1),(77,'Freshman 1','F',9,1),(78,'Freshman 2','F',9,1),(79,'Freshman 3','F',9,1),(80,'Freshman 4','F',9,1),(81,'Freshman 5','F',9,1),(82,'Freshman 6','F',9,1),(83,'Freshman 7','F',9,1),(84,'Freshman 8','M',9,1),(85,'Freshman 9','M',9,1),(86,'Freshman 10','M',9,1),(87,'Freshman 11','M',9,1),(89,'Freshman 12','M',9,1);
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
INSERT INTO `student_commitments` VALUES (4,3,2,'09:30:00','11:45:00'),(4,3,4,'09:30:00','11:45:00'),(3,6,3,'09:30:00','11:45:00'),(3,6,5,'09:30:00','11:45:00'),(3,9,3,'09:30:00','11:45:00'),(3,9,5,'09:30:00','11:45:00'),(3,12,3,'09:30:00','11:45:00'),(3,12,5,'09:30:00','11:45:00'),(3,15,3,'09:30:00','11:45:00'),(3,15,5,'09:30:00','11:45:00'),(3,16,3,'09:30:00','11:45:00'),(3,16,5,'09:30:00','11:45:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=471 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_course_preferences`
--

LOCK TABLES `student_course_preferences` WRITE;
/*!40000 ALTER TABLE `student_course_preferences` DISABLE KEYS */;
INSERT INTO `student_course_preferences` VALUES (1,2,4,1),(2,2,20,2),(3,2,10,3),(4,2,16,4),(5,2,29,5),(6,3,5,1),(7,3,16,2),(8,3,11,3),(9,3,22,4),(10,3,23,5),(11,4,4,1),(12,4,16,2),(13,4,10,3),(14,4,21,4),(15,4,22,5),(16,4,25,6),(17,5,5,1),(18,5,18,2),(19,5,10,3),(20,5,29,4),(21,5,25,5),(22,6,5,1),(23,6,20,2),(24,6,7,3),(25,6,25,4),(26,7,5,1),(27,7,21,2),(28,7,7,3),(29,7,16,4),(30,7,25,5),(31,7,27,6),(32,8,4,1),(33,8,18,2),(34,8,10,3),(35,8,29,4),(36,9,5,1),(37,9,11,2),(38,9,29,3),(39,9,28,4),(40,10,4,1),(41,10,18,2),(42,10,7,3),(43,10,10,4),(44,10,29,5),(45,11,4,1),(46,11,6,2),(47,11,21,3),(48,11,25,4),(49,11,29,5),(50,12,5,1),(51,12,21,2),(52,12,11,3),(53,13,4,1),(54,13,20,2),(55,13,15,3),(56,13,10,4),(57,13,28,5),(58,14,5,1),(59,14,11,2),(60,14,29,3),(61,14,28,4),(62,15,5,1),(63,15,21,2),(64,15,11,3),(65,16,4,1),(66,16,14,2),(67,16,10,3),(68,16,18,4),(69,16,29,5),(70,16,28,6),(71,17,5,1),(72,17,16,2),(73,17,11,3),(74,17,21,4),(75,17,23,5),(76,18,4,1),(77,18,14,2),(78,18,21,3),(79,18,10,4),(80,18,29,5),(81,19,4,1),(82,19,10,2),(83,19,18,3),(84,19,24,4),(85,20,3,1),(86,20,19,2),(87,20,14,3),(88,20,9,4),(89,20,25,5),(90,21,3,1),(91,21,20,2),(92,21,15,3),(93,21,9,4),(94,21,29,5),(95,22,3,1),(96,22,19,2),(97,22,14,3),(98,22,7,4),(99,22,25,5),(100,23,3,1),(101,23,19,2),(102,23,14,3),(103,23,7,4),(104,23,24,5),(105,23,28,6),(106,24,3,1),(107,24,19,2),(108,24,14,3),(109,24,7,4),(110,25,3,1),(111,25,18,2),(112,25,14,3),(113,25,9,4),(114,25,29,5),(115,26,3,1),(116,26,18,2),(117,26,14,3),(118,26,7,4),(119,26,24,5),(120,27,3,1),(121,27,20,2),(122,27,15,3),(123,27,7,4),(124,27,29,5),(125,28,3,1),(126,28,19,2),(127,28,14,3),(128,28,9,4),(129,28,25,5),(130,29,3,1),(131,29,20,2),(132,29,15,3),(133,29,10,4),(134,29,24,5),(135,29,29,6),(136,30,3,1),(137,30,20,2),(138,30,15,3),(139,30,9,4),(140,30,24,5),(141,30,29,6),(142,31,3,1),(143,31,18,2),(144,31,14,3),(145,31,9,4),(146,31,24,5),(147,32,3,1),(148,32,20,2),(149,32,14,3),(150,32,9,4),(151,32,25,5),(152,33,3,1),(153,33,19,2),(154,33,15,3),(155,33,7,4),(156,33,24,5),(157,34,3,1),(158,34,20,2),(159,34,15,3),(160,34,9,4),(161,34,23,5),(162,35,3,1),(163,35,20,2),(164,35,15,3),(165,35,9,4),(166,35,25,5),(167,35,29,6),(168,36,3,1),(169,36,20,2),(170,36,14,3),(171,36,9,4),(172,36,23,5),(173,36,29,6),(174,37,3,1),(175,37,19,2),(176,37,14,3),(177,37,7,4),(178,37,28,5),(179,38,3,1),(180,38,18,2),(181,38,14,3),(182,38,9,4),(183,38,29,5),(184,39,3,1),(185,39,20,2),(186,39,15,3),(187,39,9,4),(188,39,25,5),(189,39,29,6),(190,40,3,1),(191,40,20,2),(192,40,15,3),(193,40,9,4),(194,40,22,5),(195,41,2,1),(196,41,18,2),(197,41,13,3),(198,41,8,4),(199,41,24,5),(200,41,29,6),(201,42,2,1),(202,42,18,2),(203,42,13,3),(204,42,8,4),(205,42,24,5),(206,42,28,6),(207,43,2,1),(208,43,20,2),(209,43,13,3),(210,43,8,4),(211,43,25,5),(212,44,2,1),(213,44,18,2),(214,44,13,3),(215,44,8,4),(216,44,28,5),(217,45,2,1),(218,45,18,2),(219,45,13,3),(220,45,8,4),(221,46,2,1),(222,46,18,2),(223,46,13,3),(224,46,8,4),(225,46,24,5),(226,47,2,1),(227,47,18,2),(228,47,13,3),(229,47,8,4),(230,47,28,5),(231,48,2,1),(232,48,18,2),(233,48,13,3),(234,48,8,4),(235,48,24,5),(236,49,2,1),(237,49,18,2),(238,49,13,3),(239,49,8,4),(240,49,24,5),(241,49,23,6),(242,50,2,1),(243,50,18,2),(244,50,13,3),(245,50,8,4),(246,50,24,5),(247,51,2,1),(248,51,18,2),(249,51,13,3),(250,51,8,4),(251,51,29,5),(252,52,2,1),(253,52,18,2),(254,52,13,3),(255,52,8,4),(256,52,29,5),(257,53,2,1),(258,53,18,2),(259,53,13,3),(260,53,8,4),(261,53,24,5),(262,54,2,1),(263,54,18,2),(264,54,13,3),(265,54,8,4),(266,54,29,5),(267,54,27,6),(268,55,2,1),(269,55,18,2),(270,55,13,3),(271,55,8,4),(272,55,23,5),(273,55,29,6),(274,56,2,1),(275,56,18,2),(276,56,13,3),(277,56,8,4),(278,56,24,5),(279,57,1,1),(280,57,18,2),(281,57,12,3),(282,57,6,4),(283,57,29,5),(284,57,27,6),(285,58,1,1),(286,58,17,2),(287,58,12,3),(288,58,6,4),(289,58,29,5),(290,58,27,6),(291,59,1,1),(292,59,17,2),(293,59,12,3),(294,59,6,4),(295,59,29,5),(296,59,27,6),(297,60,1,1),(298,60,17,2),(299,60,12,3),(300,60,6,4),(301,60,29,5),(302,60,27,6),(303,61,1,1),(304,61,17,2),(305,61,12,3),(306,61,6,4),(307,61,29,5),(308,61,27,6),(309,62,1,1),(310,62,17,2),(311,62,12,3),(312,62,6,4),(313,62,29,5),(314,62,27,6),(315,63,1,1),(316,63,17,2),(317,63,12,3),(318,63,6,4),(319,63,29,5),(320,63,27,6),(321,64,1,1),(322,64,17,2),(323,64,12,3),(324,64,6,4),(325,64,29,5),(326,64,27,6),(327,65,1,1),(328,65,17,2),(329,65,12,3),(330,65,6,4),(331,65,29,5),(332,65,27,6),(333,66,1,1),(334,66,17,2),(335,66,12,3),(336,66,6,4),(337,66,29,5),(338,66,27,6),(339,67,1,1),(340,67,18,2),(341,67,12,3),(342,67,6,4),(343,67,29,5),(344,67,27,6),(345,68,1,1),(346,68,17,2),(347,68,12,3),(348,68,6,4),(349,68,29,5),(350,68,27,6),(351,69,1,1),(352,69,17,2),(353,69,12,3),(354,69,6,4),(355,69,29,5),(356,69,27,6),(357,70,1,1),(358,70,17,2),(359,70,12,3),(360,70,6,4),(361,70,29,5),(362,70,27,6),(363,71,1,1),(364,71,17,2),(365,71,12,3),(366,71,6,4),(367,71,29,5),(368,71,27,6),(369,72,1,1),(370,72,17,2),(371,72,12,3),(372,72,6,4),(373,72,29,5),(374,72,27,6),(375,73,1,1),(376,73,17,2),(377,73,12,3),(378,73,6,4),(379,73,29,5),(380,73,27,6),(381,74,1,1),(382,74,18,2),(383,74,12,3),(384,74,6,4),(385,74,29,5),(386,74,25,6),(387,75,1,1),(388,75,17,2),(389,75,12,3),(390,75,6,4),(391,75,29,5),(392,75,27,6),(393,76,1,1),(394,76,17,2),(395,76,12,3),(396,76,6,4),(397,76,29,5),(398,76,27,6),(399,77,1,1),(400,77,17,2),(401,77,12,3),(402,77,6,4),(403,77,29,5),(404,77,27,6),(405,78,1,1),(406,78,17,2),(407,78,12,3),(408,78,6,4),(409,78,29,5),(410,78,27,6),(411,79,1,1),(412,79,17,2),(413,79,12,3),(414,79,6,4),(415,79,29,5),(416,79,27,6),(417,80,1,1),(418,80,17,2),(419,80,12,3),(420,80,6,4),(421,80,29,5),(422,80,27,6),(423,81,1,1),(424,81,17,2),(425,81,12,3),(426,81,6,4),(427,81,29,5),(428,81,27,6),(429,82,1,1),(430,82,17,2),(431,82,12,3),(432,82,6,4),(433,82,29,5),(434,82,27,6),(435,83,1,1),(436,83,17,2),(437,83,12,3),(438,83,6,4),(439,83,29,5),(440,83,27,6),(441,84,1,1),(442,84,17,2),(443,84,12,3),(444,84,6,4),(445,84,29,5),(446,84,27,6),(447,85,1,1),(448,85,17,2),(449,85,12,3),(450,85,6,4),(451,85,29,5),(452,85,27,6),(453,86,1,1),(454,86,17,2),(455,86,12,3),(456,86,6,4),(457,86,29,5),(458,86,27,6),(459,87,1,1),(460,87,17,2),(461,87,12,3),(462,87,6,4),(463,87,29,5),(464,87,27,6),(465,89,1,1),(466,89,17,2),(467,89,12,3),(468,89,6,4),(469,89,29,5),(470,89,27,6);
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
) ENGINE=InnoDB AUTO_INCREMENT=471 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
INSERT INTO `unformatted_preferences` VALUES (2,'Beach, Jack','Male','Senior',2,'TP: English','EP2: Precalculus','TP: American Government','TP: Biochemistry II','Physical Education',''),(3,'Caldwell, Libby','Female','Senior',2,'TP: College Level English','TP: Biochemistry II','TP: Economics','','Anatomy 2','CSP'),(4,'Castaneda, Gabby','Female','Senior',1,'TP: English','TP: Biochemistry II','TP: American Government','EP2: Precalculus Con.','Anatomy 2','Spanish 2'),(5,'Godinez, Alejandra','Female','Senior',2,'TP: College Level English','EP1: Mathematics','TP: American Government','','Physical Education','Spanish 2'),(6,'Heaney, Robert','Male','Senior',1,'TP: College Level English','EP2: Precalculus','FP: Social Science (Upper Grades)','','Spanish 2',''),(7,'Herrera, Aaron','Male','Senior',1,'TP: College Level English','EP2: Precalculus Con.','FP: Social Science (Upper Grades)','TP: Biochemistry II','Spanish 2','Music'),(8,'Hohn, Andrew','Male','Senior',2,'TP: English','EP1: Mathematics','TP: American Government','','Physical Education',''),(9,'Jackson, McKinley','Female','Senior',2,'TP: College Level English','TP: Economics','','','Physical Education','Theater'),(10,'Johnson, Khia','Female','Senior',2,'TP: English','EP1: Mathematics','FP: Social Science (Upper Grades)','TP: American Government','Physical Education',''),(11,'Mancinas, Samantha','Female','Senior',2,'TP: English','FP: Social Sciences','EP2: Precalculus Con.','','Spanish 2','Physical Education'),(12,'McKell, Keyaira','Female','Senior',2,'TP: College Level English','EP2: Precalculus Con.','TP: Economics','','',''),(13,'Platt, Ruby','Female','Senior',2,'TP: English','EP2: Precalculus','EP2: Biochemistry I','TP: American Government','Theater',''),(14,'Radloff, Rachel','Female','Senior',1,'TP: College Level English','TP: Economics','','','Physical Education','Theater'),(15,'Ramirez, Annel','Female','Senior',1,'TP: College Level English','EP2: Precalculus Con.','TP: Economics','','',''),(16,'Smith, Josh','Male','Senior',2,'TP: English','EP2: Integrated Science','TP: American Government','EP1: Mathematics','Physical Education','Theater'),(17,'Valadez, Julian','Male','Senior',1,'TP: College Level English','TP: Biochemistry II','TP: Economics','EP2: Precalculus Con.','CSP',''),(18,'Vollmer, Joey','Male','Senior',2,'TP: English','EP2: Integrated Science','EP2: Precalculus Con.','TP: American Government','Physical Education',''),(19,'Woodworth, Tristin','Male','Senior',2,'TP: English','TP: American Government','EP1: Mathematics','','Spanish 1',''),(20,'Aguilar, Estacy','Female','Junior',2,'EP2: English','EP2: Integrated Math','EP2: Integrated Science','EP2: Social Sciences','Spanish 2',''),(21,'Bates, Ayden','Male','Junior',2,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','EP2: Social Sciences','Physical Education',''),(22,'Burkum, Everly','Female','Junior',2,'EP2: English','EP2: Integrated Math','EP2: Integrated Science','FP: Social Science (Upper Grades)','Spanish 2',''),(23,'Castaneda, Milie','Female','Junior',2,'EP2: English','EP2: Integrated Math','EP2: Integrated Science','FP: Social Science (Upper Grades)','Spanish 1','Theater'),(24,'Castaneda, Martha ','Female','Junior',2,'EP2: English','EP2: Integrated Math','EP2: Integrated Science','FP: Social Science (Upper Grades)','',''),(25,'Conner, Ryan','Male','Junior',2,'EP2: English','EP1: Mathematics','EP2: Integrated Science','EP2: Social Sciences','Physical Education',''),(26,'Gallego, Ruben','Male','Junior',2,'EP2: English','EP1: Mathematics','EP2: Integrated Science','FP: Social Science (Upper Grades)','Spanish 1',''),(27,'Gama, Jannice','Female','Junior',2,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','FP: Social Science (Upper Grades)','Physical Education',''),(28,'Guggenmos, Bailee','Female','Junior',2,'EP2: English','EP2: Integrated Math','EP2: Integrated Science','EP2: Social Sciences','Spanish 2',''),(29,'Hoskins, Levi','Male','Junior',1,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','TP: American Government','Spanish 1','Physical Education'),(30,'Lukery, Fiona','Female','Junior',1,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','EP2: Social Sciences','Spanish 1','Physical Education'),(31,'Martinez, Ezekiel','Male','Junior',2,'EP2: English','EP1: Mathematics','EP2: Integrated Science','EP2: Social Sciences','Spanish 1',''),(32,'Montanez, Jose','Male','Junior',2,'EP2: English','EP2: Precalculus','EP2: Integrated Science','EP2: Social Sciences','Spanish 2',''),(33,'Reyes, Leila','Female','Junior',1,'EP2: English','EP2: Integrated Math','EP2: Biochemistry I','FP: Social Science (Upper Grades)','Spanish 1',''),(34,'Rietz, Natalia','Female','Junior',2,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','EP2: Social Sciences','CSP',''),(35,'Robinson, Daniyah','Female','Junior',1,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','EP2: Social Sciences','Spanish 2','Physical Education'),(36,'Simmons, Josiah','Male','Junior',2,'EP2: English','EP2: Precalculus','EP2: Integrated Science','EP2: Social Sciences','CSP','Physical Education'),(37,'Smith, Kaiden','Male','Junior',1,'EP2: English','EP2: Integrated Math','EP2: Integrated Science','FP: Social Science (Upper Grades)','Theater',''),(38,'Smith, Kejuan','Male','Junior',2,'EP2: English','EP1: Mathematics','EP2: Integrated Science','EP2: Social Sciences','Physical Education',''),(39,'Stratford, Faith','Female','Junior',1,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','EP2: Social Sciences','Spanish 2','Physical Education'),(40,'Swartz, Naomi','Female','Junior',1,'EP2: English','EP2: Precalculus','EP2: Biochemistry I','EP2: Social Sciences','Anatomy 2',''),(41,'Agraz-Gonzalez, Alondra ','Female','Sophomore',1,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 1','Physical Education'),(42,'Alvarez-Brown, Gabi','Female','Sophomore',1,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 1','Theater'),(43,'Ayensu-Aboagye, Yaw','Male','Sophomore',1,'EP1: English','EP2: Precalculus','EP1: Science','EP1: Social Sciences','Spanish 2',''),(44,'Braimah, Noah','Male','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Theater',''),(45,'Cooper, Marissa','Female','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','',''),(46,'Diederich, Grant','Male','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 1',''),(47,'Flores, Nevaeh','Female','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Theater ',''),(48,'Garcia, Anthony','Male','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 1',''),(49,'Macias Aguilar, Isaias','Male','Sophomore',1,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 1','CSP'),(50,'Montoya, Ricky','Male','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 1',''),(51,'Ornelas, Daissy','Female','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Physical Education',''),(52,'Ramirez, Gael','Male','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Physical Education',''),(53,'Valadez, Sebastian','Male','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 1',''),(54,'Vlahos, Michael','Male','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Physical Education','Music'),(55,'Vollmer, Sean','Male','Sophomore',1,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','CSP','Physical Education'),(56,'William, Khya','Female','Sophomore',2,'EP1: English','EP1: Mathematics','EP1: Science','EP1: Social Sciences','Spanish 1',''),(57,'Schoell, Tatyana','Female','Freshman',1,'FP: English','EP1: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(58,'Field, Kaida','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(59,'Carter, Irelynd','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(60,'Hahn, Jason','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(61,'Wasser, Lilly','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(62,'McGill, Nick','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(63,'Herrera, Griffin','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(64,'Baker, Atticus','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(65,'Peters, Sebastian','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(66,'Peterson, Vivian','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(67,'DeNomme, Chloe','Female','Freshman',1,'FP: English','EP1: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(68,'Cooper, Vanessa','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(69,'Martin, Maurissa','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(70,'Shoemaker, Victoria','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(71,'Lizdas, Elena','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(72,'Eggerson, Genesis','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(73,'Martin, Pasha','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music '),(74,'Odell, Lindsey','Female','Freshman',1,'FP: English','EP1: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Spanish 2'),(75,'Ahrens, Topher','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(76,'Connelly, Seamus','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(77,'Freshman 1','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(78,'Freshman 2','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(79,'Freshman 3','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(80,'Freshman 4','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(81,'Freshman 5','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(82,'Freshman 6','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(83,'Freshman 7','Female','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(84,'Freshman 8','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(85,'Freshman 9','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(86,'Freshman 10','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(87,'Freshman 11','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music'),(89,'Freshman 12','Male','Freshman',1,'FP: English','FP: Mathematics','FP: Science','FP: Social Sciences','Physical Education','Music');
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

-- Dump completed on 2020-07-29 10:39:55
