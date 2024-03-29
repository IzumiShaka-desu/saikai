-- MariaDB dump 10.17  Distrib 10.4.13-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: saikai
-- ------------------------------------------------------
-- Server version	10.4.13-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `account`
--

DROP TABLE IF EXISTS `account`;
/*!50001 DROP VIEW IF EXISTS `account`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `account` (
  `id_user` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `password` tinyint NOT NULL,
  `nama` tinyint NOT NULL,
  `phone` tinyint NOT NULL,
  `pekerjaan` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id_category` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(30) NOT NULL,
  PRIMARY KEY (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Appetizers'),(2,'Soups'),(3,'Salads'),(4,'Vegetables'),(5,'Main Dishes'),(6,'Desserts');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `phone` varchar(13) NOT NULL,
  `pekerjaan` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` VALUES (0,' suika','089532','penari'),(2,' suika','18088','penari'),(9,'ku','08754351',''),(10,' sdfsfsfs','',''),(11,' si','','');
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipes`
--

DROP TABLE IF EXISTS `recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipes` (
  `id_recipe` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `date_created` date NOT NULL,
  `title` varchar(100) NOT NULL,
  `id_category` int(11) NOT NULL,
  `servings` int(11) NOT NULL,
  `total_time` int(11) NOT NULL,
  `ingredients` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`ingredients`)),
  `steps` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`steps`)),
  `foto` varchar(50) NOT NULL,
  PRIMARY KEY (`id_recipe`),
  KEY `id_category` (`id_category`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`),
  CONSTRAINT `recipes_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `userlogin` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipes`
--

LOCK TABLES `recipes` WRITE;
/*!40000 ALTER TABLE `recipes` DISABLE KEYS */;
INSERT INTO `recipes` VALUES (1,3,'2020-11-30','ice cream',6,10,1,'[\"milk\",\"cheeze\"]','[\"go to freezer\"]','1606739857_2649be2ad00cb448b26f.jpg'),(5,9,'2020-12-04','mie geki',5,2,12,'[\"mie gekikara 1pcs\",\"saus abs 1pcs\",\"sosis 1pcs\",\"wortel 15gr\",\"timun 15gr\",\"boncabe 1pcs\"]','[\"didihkan air\",\"setelah mendidih masukan mie Dan sayuran\",\"siapkan bumbu tambahkan saus Dan boncabe\",\"angkat mie,tiriskan\",\"taruh mie ke piring berbumbu\",\"aduk rata tambahkan sosis\",\"siap dihidangkan\"]','1606810611_d342341a494445cdf098.jpg'),(6,9,'2020-12-04','spaghetti with chicken stick',5,1,20,'[\"ayam 30gr\",\"sajiku 1pcs\",\"lafonte ayam 1pcs\",\"telur 1 butir\",\"minyak goreng 1/4 liter\"]','[\"bersihkan ayam,lalu potong panjang\",\"kocok telur,siapkan sajiku\",\"celupkan ayam ke telur,balur dengan sajiku\",\"panaskan minyak\",\"goreng ayam tadi\",\"didihkan air\",\"masukan spaghetti\",\"tiriskan\",\"campurkan spaghetti dengan bumbu\",\"hidangkan spaghetti dengan ayam\"]','1607094532_7d01c038bddfd238071a.jpg'),(7,9,'2020-12-04','geki karbo',5,1,5,'[\"mie gekikara karbo\",\"air untuk merebus\"]','[\"didihkan air\",\"masukan mie\",\"siapkan bumbu di wadah\",\"tiriskan mine ketika matang\",\"campurkan mie Dan bumbu\",\"aduk rata, siap dihidangkan\"]','1607144939_fbf1397684aef73922ea.jpg');
/*!40000 ALTER TABLE `recipes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userlogin`
--

DROP TABLE IF EXISTS `userlogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userlogin` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userlogin`
--

LOCK TABLES `userlogin` WRITE;
/*!40000 ALTER TABLE `userlogin` DISABLE KEYS */;
INSERT INTO `userlogin` VALUES (1,'shak@dskjfj','8b5b443d32fb1c77ad187f59a9a5325067f7d801'),(2,'suika@mail.com','7c4a8d09ca3762af61e59520943dc26494f8941b'),(3,'suika@mail.xom','7c4a8d09ca3762af61e59520943dc26494f8941b'),(4,'suik@mail.com','7c4a8d09ca3762af61e59520943dc26494f8941b'),(5,'sda@mail.com','7c4a8d09ca3762af61e59520943dc26494f8941b'),(6,'shok@m.com','7c4a8d09ca3762af61e59520943dc26494f8941b'),(7,'sh@m.com','7c4a8d09ca3762af61e59520943dc26494f8941b'),(8,'shui@m.com','7c4a8d09ca3762af61e59520943dc26494f8941b'),(9,'shuk@mail.com','7c4a8d09ca3762af61e59520943dc26494f8941b'),(10,'s@mail.com','7c4a8d09ca3762af61e59520943dc26494f8941b'),(11,'si@mail.com','7c4a8d09ca3762af61e59520943dc26494f8941b');
/*!40000 ALTER TABLE `userlogin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `account`
--

/*!50001 DROP TABLE IF EXISTS `account`*/;
/*!50001 DROP VIEW IF EXISTS `account`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `account` AS select `userlogin`.`id_user` AS `id_user`,`userlogin`.`email` AS `email`,`userlogin`.`password` AS `password`,`profile`.`nama` AS `nama`,`profile`.`phone` AS `phone`,`profile`.`pekerjaan` AS `pekerjaan` from (`userlogin` join `profile` on(`profile`.`id_user` = `userlogin`.`id_user`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-05 15:17:17
