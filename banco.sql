-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: testsql
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `a1`
--

DROP TABLE IF EXISTS `a1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a1` (
  `A1_COD` int NOT NULL,
  `A1_NOME` varchar(100) DEFAULT NULL,
  `A1_TIPO` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`A1_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `a1`
--

LOCK TABLES `a1` WRITE;
/*!40000 ALTER TABLE `a1` DISABLE KEYS */;
INSERT INTO `a1` VALUES (1001,'MARIA DA SILVA','Pessoa Física'),(1002,'JOSE DE ALENCAR','Pessoa Física'),(1003,'AFONSO COSTA','Pessoa Física'),(1004,'JOAO DOS SANTOS','Pessoa Jurídica');
/*!40000 ALTER TABLE `a1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `a3`
--

DROP TABLE IF EXISTS `a3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `a3` (
  `A3_COD` int NOT NULL,
  `A3_NOME` varchar(100) DEFAULT NULL,
  `A3_REGIAO` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`A3_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `a3`
--

LOCK TABLES `a3` WRITE;
/*!40000 ALTER TABLE `a3` DISABLE KEYS */;
INSERT INTO `a3` VALUES (111,'PAULO DA MATA','CENTRO'),(112,'ANDERSON SILVA','LESTE'),(113,'TYLER OLIVEIRA','OESTE'),(114,'OTTO ALBUQUERQUE','NORTE');
/*!40000 ALTER TABLE `a3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c5`
--

DROP TABLE IF EXISTS `c5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c5` (
  `C5_NUM` int NOT NULL,
  `C5_EMISSAO` date DEFAULT NULL,
  `C5_CODCLI` int DEFAULT NULL,
  `C5_CODVEN` int DEFAULT NULL,
  PRIMARY KEY (`C5_NUM`),
  KEY `C5_CODCLI` (`C5_CODCLI`),
  KEY `C5_CODVEN` (`C5_CODVEN`),
  CONSTRAINT `c5_ibfk_1` FOREIGN KEY (`C5_CODCLI`) REFERENCES `a1` (`A1_COD`),
  CONSTRAINT `c5_ibfk_2` FOREIGN KEY (`C5_CODVEN`) REFERENCES `a3` (`A3_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c5`
--

LOCK TABLES `c5` WRITE;
/*!40000 ALTER TABLE `c5` DISABLE KEYS */;
INSERT INTO `c5` VALUES (9001,'2023-01-25',1001,112),(9002,'2023-01-15',1002,111),(9003,'2023-02-02',1003,113),(9004,'2023-03-03',1004,114);
/*!40000 ALTER TABLE `c5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c6`
--

DROP TABLE IF EXISTS `c6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c6` (
  `C6_NUM` int NOT NULL,
  `C6_ITEM` int NOT NULL,
  `C6_CODPROD` int DEFAULT NULL,
  `C6_QTD` int DEFAULT NULL,
  `C6_PRUNIT` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`C6_NUM`,`C6_ITEM`),
  CONSTRAINT `c6_ibfk_1` FOREIGN KEY (`C6_NUM`) REFERENCES `c5` (`C5_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c6`
--

LOCK TABLES `c6` WRITE;
/*!40000 ALTER TABLE `c6` DISABLE KEYS */;
INSERT INTO `c6` VALUES (9001,1,7001,70,15.90),(9001,2,7002,60,19.70),(9003,1,7001,90,11.33),(9003,2,7004,210,21.70);
/*!40000 ALTER TABLE `c6` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-20 22:42:10
