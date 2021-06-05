-- MySQL dump 10.13  Distrib 8.0.22, for osx10.14 (x86_64)
--
-- Host: localhost    Database: automation_center
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add project',7,'add_project'),(26,'Can change project',7,'change_project'),(27,'Can delete project',7,'delete_project'),(28,'Can view project',7,'view_project'),(29,'Can add Token',8,'add_token'),(30,'Can change Token',8,'change_token'),(31,'Can delete Token',8,'delete_token'),(32,'Can view Token',8,'view_token'),(33,'Can add automated case',9,'add_automatedcase'),(34,'Can change automated case',9,'change_automatedcase'),(35,'Can delete automated case',9,'delete_automatedcase'),(36,'Can view automated case',9,'view_automatedcase'),(37,'Can add script function',10,'add_scriptfunction'),(38,'Can change script function',10,'change_scriptfunction'),(39,'Can delete script function',10,'delete_scriptfunction'),(40,'Can view script function',10,'view_scriptfunction'),(41,'Can add script',11,'add_script'),(42,'Can change script',11,'change_script'),(43,'Can delete script',11,'delete_script'),(44,'Can view script',11,'view_script'),(45,'Can add browser',12,'add_browser'),(46,'Can change browser',12,'change_browser'),(47,'Can delete browser',12,'delete_browser'),(48,'Can view browser',12,'view_browser'),(49,'Can add device',13,'add_device'),(50,'Can change device',13,'change_device'),(51,'Can delete device',13,'delete_device'),(52,'Can view device',13,'view_device'),(53,'Can add driver',14,'add_driver'),(54,'Can change driver',14,'change_driver'),(55,'Can delete driver',14,'delete_driver'),(56,'Can view driver',14,'view_driver'),(57,'Can add mobile os',15,'add_mobileos'),(58,'Can change mobile os',15,'change_mobileos'),(59,'Can delete mobile os',15,'delete_mobileos'),(60,'Can view mobile os',15,'view_mobileos'),(61,'Can add platform os',16,'add_platformos'),(62,'Can change platform os',16,'change_platformos'),(63,'Can delete platform os',16,'delete_platformos'),(64,'Can view platform os',16,'view_platformos'),(65,'Can add test environment',17,'add_testenvironment'),(66,'Can change test environment',17,'change_testenvironment'),(67,'Can delete test environment',17,'delete_testenvironment'),(68,'Can view test environment',17,'view_testenvironment'),(69,'Can add test suite',18,'add_testsuite'),(70,'Can change test suite',18,'change_testsuite'),(71,'Can delete test suite',18,'delete_testsuite'),(72,'Can view test suite',18,'view_testsuite'),(73,'Can add role',19,'add_role'),(74,'Can change role',19,'change_role'),(75,'Can delete role',19,'delete_role'),(76,'Can view role',19,'view_role'),(77,'Can add test round',20,'add_testround'),(78,'Can change test round',20,'change_testround'),(79,'Can delete test round',20,'delete_testround'),(80,'Can view test round',20,'view_testround');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$150000$ZmaWpWlQMFFM$EU+sYOif143QOPit0+mMjQ14Xm93xNoASNh/sLYuZ1Y=','2021-05-24 22:41:28.756939',1,'bo','','','jbsv43@sina.com',1,1,'2019-12-20 22:01:57.153210'),(2,'pbkdf2_sha256$150000$JynJx0YRYpMV$dkNQtU0LpUPQbcafPW9tdtZYraBUvHiewwYjuRlqL40=','2020-02-06 18:13:08.601051',0,'test','','','test@byincd.com',0,1,'2020-02-05 17:43:03.013078');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('50053a71f9ab2992f5d102743b349ebe4d29845b','2021-05-31 21:47:03.935243',1),('9f4376b303a9c6bc6719ea16aa5f71436901208d','2020-08-08 22:20:23.185958',2);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_general_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(8,'authtoken','token'),(5,'contenttypes','contenttype'),(12,'execution','browser'),(13,'execution','device'),(14,'execution','driver'),(15,'execution','mobileos'),(16,'execution','platformos'),(17,'execution','testenvironment'),(9,'projects','automatedcase'),(7,'projects','project'),(11,'projects','script'),(10,'projects','scriptfunction'),(20,'projects','testround'),(18,'projects','testsuite'),(6,'sessions','session'),(19,'users','role');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-12-20 21:45:38.672156'),(2,'auth','0001_initial','2019-12-20 21:45:38.747936'),(3,'admin','0001_initial','2019-12-20 21:45:38.897368'),(4,'admin','0002_logentry_remove_auto_add','2019-12-20 21:45:38.941433'),(5,'admin','0003_logentry_add_action_flag_choices','2019-12-20 21:45:38.950641'),(6,'contenttypes','0002_remove_content_type_name','2019-12-20 21:45:38.995816'),(7,'auth','0002_alter_permission_name_max_length','2019-12-20 21:45:39.017326'),(8,'auth','0003_alter_user_email_max_length','2019-12-20 21:45:39.044130'),(9,'auth','0004_alter_user_username_opts','2019-12-20 21:45:39.052666'),(10,'auth','0005_alter_user_last_login_null','2019-12-20 21:45:39.080409'),(11,'auth','0006_require_contenttypes_0002','2019-12-20 21:45:39.082759'),(12,'auth','0007_alter_validators_add_error_messages','2019-12-20 21:45:39.090588'),(13,'auth','0008_alter_user_username_max_length','2019-12-20 21:45:39.120184'),(14,'auth','0009_alter_user_last_name_max_length','2019-12-20 21:45:39.149798'),(15,'auth','0010_alter_group_name_max_length','2019-12-20 21:45:39.165417'),(16,'auth','0011_update_proxy_permissions','2019-12-20 21:45:39.174600'),(17,'sessions','0001_initial','2019-12-20 21:45:39.187533'),(18,'projects','0001_initial','2019-12-21 13:14:17.631271'),(19,'authtoken','0001_initial','2020-01-08 20:06:57.348544'),(20,'authtoken','0002_auto_20160226_1747','2020-01-08 20:06:57.452639'),(21,'projects','0002_project_owner','2020-02-05 17:41:01.669686'),(22,'projects','0003_auto_20200205_1745','2020-02-05 17:45:20.887336'),(23,'projects','0004_project_project_type','2020-02-05 18:18:30.884548'),(24,'projects','0005_automatedcase_script_scriptfunction','2020-04-19 12:28:28.196865'),(25,'execution','0001_initial','2020-06-20 10:40:07.524154'),(26,'execution','0002_device_driver','2020-06-20 10:40:07.556309'),(27,'execution','0003_mobileos_platformos_testenvironment','2020-06-20 10:40:07.598600'),(28,'projects','0006_testsuite','2020-06-20 11:43:44.218653'),(29,'projects','0007_auto_20200813_1750','2020-08-17 19:55:21.309841'),(30,'projects','0008_remove_project_owner','2020-08-17 19:55:21.350632'),(31,'users','0001_initial','2020-08-17 19:55:21.377497'),(32,'projects','0009_auto_20201023_1407','2020-10-26 20:17:20.444201'),(33,'projects','0010_auto_20210518_1649','2021-05-19 21:32:42.316220'),(34,'projects','0011_testsuite_suite_type','2021-05-19 21:32:42.354328'),(35,'projects','0012_testround','2021-05-27 21:33:07.141351'),(36,'projects','0013_auto_20210601_1806','2021-06-02 21:39:46.282500');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('abo6z7sk5ipeam3xjsc6r3yjud7woiem','ZjhmMGNlMmMyMGExZTI4ZTIwZWU2MTUzN2YwYmE1NmZlODU2NmIzYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0OGQ4NjBlYzAxZjk5MjYwYTI3MTgxZjljOWE2M2MyNGFiN2IzMjBmIn0=','2020-02-18 16:59:33.978706'),('chc1354cq4hankqoj6ktgqw5409dsw2y','ZjhmMGNlMmMyMGExZTI4ZTIwZWU2MTUzN2YwYmE1NmZlODU2NmIzYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0OGQ4NjBlYzAxZjk5MjYwYTI3MTgxZjljOWE2M2MyNGFiN2IzMjBmIn0=','2021-06-07 22:41:28.802934'),('giaqva39nhgz7kr0cyrn18iwde46afhi','MmNiNDM1ZTExNjMzOTdiMjA1OTQ2YzM0OWVmN2ZiMjg5NWUwZjRiYTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzZjdkZTM1OWU4YWMyODY4ZGY5MTdhMTE3NjdkYjc4MzRiMWQ5ODZlIn0=','2020-02-20 18:13:08.605006'),('it2bnafnz7bb5d05y05qoif2mgl1e4uj','ZjhmMGNlMmMyMGExZTI4ZTIwZWU2MTUzN2YwYmE1NmZlODU2NmIzYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0OGQ4NjBlYzAxZjk5MjYwYTI3MTgxZjljOWE2M2MyNGFiN2IzMjBmIn0=','2020-07-04 11:54:20.292962'),('j34ljuc0z3l85hwn5ab17vr56hnnu8df','ZjhmMGNlMmMyMGExZTI4ZTIwZWU2MTUzN2YwYmE1NmZlODU2NmIzYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0OGQ4NjBlYzAxZjk5MjYwYTI3MTgxZjljOWE2M2MyNGFiN2IzMjBmIn0=','2020-08-22 22:09:55.495059'),('kkquz7uysgq3s8u2ibswmu4qfbmgkcty','ZjhmMGNlMmMyMGExZTI4ZTIwZWU2MTUzN2YwYmE1NmZlODU2NmIzYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0OGQ4NjBlYzAxZjk5MjYwYTI3MTgxZjljOWE2M2MyNGFiN2IzMjBmIn0=','2020-07-31 19:45:30.991707'),('rndqdpmpdxs7su2hjaoe0958edg0xna1','ZjhmMGNlMmMyMGExZTI4ZTIwZWU2MTUzN2YwYmE1NmZlODU2NmIzYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0OGQ4NjBlYzAxZjk5MjYwYTI3MTgxZjljOWE2M2MyNGFiN2IzMjBmIn0=','2021-05-30 21:40:15.027244');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `execution_browser`
--

DROP TABLE IF EXISTS `execution_browser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `execution_browser` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `alias` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `version` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `execution_browser`
--

LOCK TABLES `execution_browser` WRITE;
/*!40000 ALTER TABLE `execution_browser` DISABLE KEYS */;
INSERT INTO `execution_browser` VALUES (1,'Chrome','chrome','75.0.3770.142','2019-07-31 02:46:21.000000','2019-07-31 02:46:21.000000'),(2,'Firefox','firefox','67.0.4','2019-07-31 02:48:37.000000','2019-07-31 02:48:37.000000'),(3,'Safari','Safari','12.1.2','2019-07-31 02:49:54.000000','2019-07-31 02:49:54.000000'),(4,'IE','internet explorer','11','2019-07-31 02:53:20.000000','2019-07-31 02:53:20.000000'),(5,'Edge','MicrosoftEdge','42.17134.1.0','2019-07-31 02:54:49.000000','2019-07-31 02:54:49.000000'),(6,'MobileBrowser','chrome','75.0.3770.142','2019-07-31 02:56:31.000000','2019-07-31 02:56:31.000000'),(7,'Chrome','chrome','76.0.3809.100','2019-10-27 04:06:59.000000','2019-10-27 04:06:59.000000'),(8,'Chrome','chrome','80.0.3987.132','2020-03-10 06:23:05.000000','2020-03-10 06:23:05.000000'),(9,'Chrome','chrome','unknown','2020-03-21 02:05:19.000000','2020-03-21 02:05:19.000000'),(10,'Chrome','chrome','80.0.3987.149','2020-03-21 02:09:52.000000','2020-03-21 02:09:52.000000');
/*!40000 ALTER TABLE `execution_browser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `execution_device`
--

DROP TABLE IF EXISTS `execution_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `execution_device` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `execution_device`
--

LOCK TABLES `execution_device` WRITE;
/*!40000 ALTER TABLE `execution_device` DISABLE KEYS */;
INSERT INTO `execution_device` VALUES (1,'Simulator','2019-07-31 06:26:04.000000','2019-07-31 06:26:04.000000'),(2,'Emulator','2019-07-31 06:26:24.000000','2019-07-31 06:26:24.000000'),(3,'MiPlus','2019-07-31 06:26:43.000000','2019-07-31 06:26:43.000000'),(4,'STF','2019-07-31 06:26:49.000000','2019-07-31 06:26:49.000000');
/*!40000 ALTER TABLE `execution_device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `execution_driver`
--

DROP TABLE IF EXISTS `execution_driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `execution_driver` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `version` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `comment` varchar(2000) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `execution_driver`
--

LOCK TABLES `execution_driver` WRITE;
/*!40000 ALTER TABLE `execution_driver` DISABLE KEYS */;
INSERT INTO `execution_driver` VALUES (1,'chromedriver','74.0.3729.6','2019-07-31 03:07:15.000000','2019-07-31 03:07:15.000000','test on macos, chrome 74 and 75.0.3770.142'),(2,'geckodriver','0.24.0','2019-07-31 03:08:09.000000','2019-07-31 03:08:09.000000','test on macos, firefox 67.0'),(3,'safaridriver','12607.3.10','2019-07-31 03:08:38.000000','2019-07-31 03:08:38.000000','test on macos, safari 12.1.2'),(4,'IEDriver','3.9.0.0','2019-07-31 03:09:00.000000','2019-07-31 03:09:00.000000','test on win10, ie 11.706.17134.0'),(5,'MicrosoftWebDriver\r\n','17.17134','2019-07-31 03:09:23.000000','2019-07-31 03:09:23.000000','test on win10, Edge 17134'),(6,'appium','1.11.1','2019-07-31 03:11:13.000000','2019-07-31 03:11:13.000000','test on macos 10.12.6, android 4.4.4 & 5.0.2 & 8.1.0, ios 11.2'),(7,'appium','1.13.0','2019-07-31 03:34:04.000000','2019-07-31 03:34:04.000000','test on macos 10.14.6, android 8.1.0, ios 12.2 & 12.4');
/*!40000 ALTER TABLE `execution_driver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `execution_environment`
--

DROP TABLE IF EXISTS `execution_environment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `execution_environment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `execution_environment`
--

LOCK TABLES `execution_environment` WRITE;
/*!40000 ALTER TABLE `execution_environment` DISABLE KEYS */;
INSERT INTO `execution_environment` VALUES (1,'INT'),(2,'QA'),(3,'Regression'),(4,'Staging'),(5,'Production');
/*!40000 ALTER TABLE `execution_environment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `execution_mobile_os`
--

DROP TABLE IF EXISTS `execution_mobile_os`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `execution_mobile_os` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `version` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `execution_mobile_os`
--

LOCK TABLES `execution_mobile_os` WRITE;
/*!40000 ALTER TABLE `execution_mobile_os` DISABLE KEYS */;
INSERT INTO `execution_mobile_os` VALUES (1,'iOS','12.4','2019-07-31 03:21:50.000000','2019-07-31 03:21:50.000000'),(2,'Android','8.1.0','2019-07-31 03:22:49.000000','2019-07-31 03:22:49.000000'),(3,'iOS','unknown','2020-03-21 02:02:59.000000','2020-03-21 02:02:59.000000');
/*!40000 ALTER TABLE `execution_mobile_os` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `execution_platform_os`
--

DROP TABLE IF EXISTS `execution_platform_os`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `execution_platform_os` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `version` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `execution_platform_os`
--

LOCK TABLES `execution_platform_os` WRITE;
/*!40000 ALTER TABLE `execution_platform_os` DISABLE KEYS */;
INSERT INTO `execution_platform_os` VALUES (1,'Windows','Windows-10-10.0.17134-SP0','2019-07-31 06:24:15.000000','2019-07-31 06:24:15.000000'),(2,'Macos','Darwin-16.7.0-x86_64-i386-64bit','2019-07-31 06:24:38.000000','2019-07-31 06:24:38.000000'),(3,'Macos','Darwin-18.7.0-x86_64-i386-64bit','2019-10-27 03:49:54.000000','2019-10-27 03:49:54.000000'),(4,'Macos','Darwin-18.6.0-x86_64-i386-64bit','2020-03-10 06:23:06.000000','2020-03-10 06:23:06.000000');
/*!40000 ALTER TABLE `execution_platform_os` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_automated_case`
--

DROP TABLE IF EXISTS `projects_automated_case`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_automated_case` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `script_function_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `projects_automated_c_script_function_id_cb37cf96_fk_projects_` (`script_function_id`),
  CONSTRAINT `projects_automated_c_script_function_id_cb37cf96_fk_projects_` FOREIGN KEY (`script_function_id`) REFERENCES `projects_script_function` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects_automated_case`
--

LOCK TABLES `projects_automated_case` WRITE;
/*!40000 ALTER TABLE `projects_automated_case` DISABLE KEYS */;
INSERT INTO `projects_automated_case` VALUES (1,'RA-1: post comment amount 0','2019-10-27 03:50:02.000000','2019-10-27 03:50:02.000000',1),(2,'RA-2: post comment amount 1','2019-10-27 03:50:06.000000','2019-10-27 03:50:06.000000',2),(3,'RA-3: post comment amount 2','2019-10-27 03:50:10.000000','2019-10-27 03:50:10.000000',3),(4,'RA-4: posts amount','2019-10-27 03:50:15.000000','2019-10-27 03:50:15.000000',4),(5,'RA-5: create new post and check new amount','2019-10-27 03:50:19.000000','2019-10-27 03:50:19.000000',5),(6,'ByBlog-3: only user who have logged in can see the posts view dropdown in post list page','2019-10-27 04:07:09.000000','2019-10-27 04:07:09.000000',6),(7,'ByBlog-2: user is able to view posts when jump page','2019-10-27 04:07:14.000000','2019-10-27 04:07:14.000000',7),(8,'ByBlog-4: details page url contains post id','2019-10-27 04:07:18.000000','2019-10-27 04:07:18.000000',8),(9,'ByBlog-1: user is able to search posts and view the search result','2019-10-27 04:07:21.000000','2019-10-27 04:07:21.000000',9),(10,'MWeb-1: user is able to search posts and view the search result','2019-10-27 04:10:36.000000','2019-10-27 04:10:36.000000',10);
/*!40000 ALTER TABLE `projects_automated_case` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_project`
--

DROP TABLE IF EXISTS `projects_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_project` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `project_type` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `projects_project_name_1ecf4961_uniq` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects_project`
--

LOCK TABLES `projects_project` WRITE;
/*!40000 ALTER TABLE `projects_project` DISABLE KEYS */;
INSERT INTO `projects_project` VALUES (1,'rest_api','2019-10-27 11:49:55.000000','2019-10-27 11:49:55.000000','internal'),(2,'byblog','2019-10-27 12:07:03.000000','2019-10-27 12:07:03.000000','internal'),(3,'mobile_web','2019-10-27 12:10:29.000000','2019-10-27 12:10:29.000000','internal');
/*!40000 ALTER TABLE `projects_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_script`
--

DROP TABLE IF EXISTS `projects_script`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_script` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `project_id` int NOT NULL,
  `author` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `file_created` date DEFAULT NULL,
  `file_updated` date DEFAULT NULL,
  `maintainer` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `tag` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `version` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `projects_script_project_id_df0c5d0e_fk_projects_project_id` (`project_id`),
  CONSTRAINT `projects_script_project_id_df0c5d0e_fk_projects_project_id` FOREIGN KEY (`project_id`) REFERENCES `projects_project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects_script`
--

LOCK TABLES `projects_script` WRITE;
/*!40000 ALTER TABLE `projects_script` DISABLE KEYS */;
INSERT INTO `projects_script` VALUES (1,'test_post_comment','2019-10-27 03:49:59.000000','2019-10-27 03:49:59.000000',1,'Bob','2019-10-25','2019-10-25','Bob','Completed','API, Comment','1.1'),(2,'test_posts','2019-10-27 03:50:12.000000','2019-10-27 03:50:12.000000',1,'Bob','2019-10-25','2019-10-25','Bob','Completed','API, Posts','1.1'),(3,'test_permission','2019-10-27 04:07:06.000000','2019-10-27 04:07:06.000000',2,'Bob','2019-10-27','2019-10-27','Bob','Completed','Web, Blog, Permission','1.1'),(4,'test_view_posts','2019-10-27 04:07:11.000000','2019-10-27 04:07:11.000000',2,'Bob','2019-10-27','2019-10-27','Bob','Completed','Web, Blog, Posts','1.1'),(5,'test_view_posts','2019-10-27 04:10:33.000000','2019-10-27 04:10:33.000000',3,'Bob','2019-10-27','2019-10-27','Bob','Completed','Mobile, Blog, Posts','1.1');
/*!40000 ALTER TABLE `projects_script` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_script_function`
--

DROP TABLE IF EXISTS `projects_script_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_script_function` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `script_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `projects_script_func_script_id_1bdbe953_fk_projects_` (`script_id`),
  CONSTRAINT `projects_script_func_script_id_1bdbe953_fk_projects_` FOREIGN KEY (`script_id`) REFERENCES `projects_script` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects_script_function`
--

LOCK TABLES `projects_script_function` WRITE;
/*!40000 ALTER TABLE `projects_script_function` DISABLE KEYS */;
INSERT INTO `projects_script_function` VALUES (1,'test_post_comment_amount_0','2019-10-27 03:50:00.000000','2019-10-27 03:50:00.000000',1),(2,'test_post_comment_amount_1','2019-10-27 03:50:04.000000','2019-10-27 03:50:04.000000',1),(3,'test_post_comment_amount_2','2019-10-27 03:50:08.000000','2019-10-27 03:50:08.000000',1),(4,'test_posts_amount','2019-10-27 03:50:13.000000','2019-10-27 03:50:13.000000',2),(5,'test_create_new_post','2019-10-27 03:50:17.000000','2019-10-27 03:50:17.000000',2),(6,'test_sort_posts_only_available_for_logged_in_user','2019-10-27 04:07:07.000000','2019-10-27 04:07:07.000000',3),(7,'test_view_posts_when_jump_page','2019-10-27 04:07:12.000000','2019-10-27 04:07:12.000000',4),(8,'test_post_id_in_detail_page_url','2019-10-27 04:07:16.000000','2019-10-27 04:07:16.000000',4),(9,'test_view_posts_in_search_result','2019-10-27 04:07:20.000000','2019-10-27 04:07:20.000000',4),(10,'test_view_posts_in_search_result','2019-10-27 04:10:34.000000','2019-10-27 04:10:34.000000',5);
/*!40000 ALTER TABLE `projects_script_function` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_test_round`
--

DROP TABLE IF EXISTS `projects_test_round`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_test_round` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `status_type` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `result_type` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `pass_count` int NOT NULL,
  `fail_count` int NOT NULL,
  `warning_count` int NOT NULL,
  `not_run_count` int NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `extra_info` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `browser_id` int DEFAULT NULL,
  `creator_id` int DEFAULT NULL,
  `device_id` int DEFAULT NULL,
  `mobile_os_id` int DEFAULT NULL,
  `platform_os_id` int DEFAULT NULL,
  `project_id` int NOT NULL,
  `test_environment_id` int DEFAULT NULL,
  `test_suite_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projects_test_round_browser_id_f954d767_fk_execution_browser_id` (`browser_id`),
  KEY `projects_test_round_creator_id_3c2e7453_fk_auth_user_id` (`creator_id`),
  KEY `projects_test_round_device_id_f3bcdccd_fk_execution_device_id` (`device_id`),
  KEY `projects_test_round_mobile_os_id_140749cc_fk_execution` (`mobile_os_id`),
  KEY `projects_test_round_platform_os_id_c1c1580a_fk_execution` (`platform_os_id`),
  KEY `projects_test_round_project_id_f69286a1_fk_projects_project_id` (`project_id`),
  KEY `projects_test_round_test_environment_id_6f30e180_fk_execution` (`test_environment_id`),
  KEY `projects_test_round_test_suite_id_567f599e_fk_projects_` (`test_suite_id`),
  CONSTRAINT `projects_test_round_browser_id_f954d767_fk_execution_browser_id` FOREIGN KEY (`browser_id`) REFERENCES `execution_browser` (`id`),
  CONSTRAINT `projects_test_round_creator_id_3c2e7453_fk_auth_user_id` FOREIGN KEY (`creator_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `projects_test_round_device_id_f3bcdccd_fk_execution_device_id` FOREIGN KEY (`device_id`) REFERENCES `execution_device` (`id`),
  CONSTRAINT `projects_test_round_mobile_os_id_140749cc_fk_execution` FOREIGN KEY (`mobile_os_id`) REFERENCES `execution_mobile_os` (`id`),
  CONSTRAINT `projects_test_round_platform_os_id_c1c1580a_fk_execution` FOREIGN KEY (`platform_os_id`) REFERENCES `execution_platform_os` (`id`),
  CONSTRAINT `projects_test_round_project_id_f69286a1_fk_projects_project_id` FOREIGN KEY (`project_id`) REFERENCES `projects_project` (`id`),
  CONSTRAINT `projects_test_round_test_environment_id_6f30e180_fk_execution` FOREIGN KEY (`test_environment_id`) REFERENCES `execution_environment` (`id`),
  CONSTRAINT `projects_test_round_test_suite_id_567f599e_fk_projects_` FOREIGN KEY (`test_suite_id`) REFERENCES `projects_test_suite` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects_test_round`
--

LOCK TABLES `projects_test_round` WRITE;
/*!40000 ALTER TABLE `projects_test_round` DISABLE KEYS */;
INSERT INTO `projects_test_round` VALUES (1,'run blog test','Waiting','NotRun',0,0,0,0,'2021-05-29 11:16:29.637040',NULL,'2021-05-29 11:16:29.637048','2021-05-29 11:16:29.637051','',10,1,NULL,NULL,4,2,2,1);
/*!40000 ALTER TABLE `projects_test_round` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_test_suite`
--

DROP TABLE IF EXISTS `projects_test_suite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_test_suite` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `project_id` int NOT NULL,
  `suite_type` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `projects_test_suite_name_project_id_e22b1fae_uniq` (`name`,`project_id`),
  KEY `projects_test_suite_project_id_32cabb10_fk_projects_project_id` (`project_id`),
  CONSTRAINT `projects_test_suite_project_id_32cabb10_fk_projects_project_id` FOREIGN KEY (`project_id`) REFERENCES `projects_project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects_test_suite`
--

LOCK TABLES `projects_test_suite` WRITE;
/*!40000 ALTER TABLE `projects_test_suite` DISABLE KEYS */;
INSERT INTO `projects_test_suite` VALUES (1,'blog_full_suite','2021-05-16 21:41:20.521749','2021-05-16 21:41:20.521757',2,'Debug'),(2,'blog_full_permission','2021-05-16 21:41:49.322262','2021-05-16 21:41:49.322268',2,'Debug'),(3,'api_full_suite','2021-05-16 21:42:35.078826','2021-05-16 21:42:35.078831',1,'Debug'),(4,'api_bvt_suite','2021-05-16 21:42:35.078826','2021-05-16 21:42:35.078831',1,'Debug'),(5,'mobile_bvt_suite','2021-05-16 21:44:18.182041','2021-05-16 21:44:18.182047',3,'Debug'),(6,'blog_test','2021-05-24 22:36:23.664604','2021-05-24 22:36:23.664613',2,'Debug');
/*!40000 ALTER TABLE `projects_test_suite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects_test_suite_script`
--

DROP TABLE IF EXISTS `projects_test_suite_script`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_test_suite_script` (
  `id` int NOT NULL AUTO_INCREMENT,
  `testsuite_id` int NOT NULL,
  `script_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `projects_test_suite_script_testsuite_id_script_id_a616849b_uniq` (`testsuite_id`,`script_id`),
  KEY `projects_test_suite__script_id_693c565c_fk_projects_` (`script_id`),
  CONSTRAINT `projects_test_suite__script_id_693c565c_fk_projects_` FOREIGN KEY (`script_id`) REFERENCES `projects_script` (`id`),
  CONSTRAINT `projects_test_suite__testsuite_id_1e061133_fk_projects_` FOREIGN KEY (`testsuite_id`) REFERENCES `projects_test_suite` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects_test_suite_script`
--

LOCK TABLES `projects_test_suite_script` WRITE;
/*!40000 ALTER TABLE `projects_test_suite_script` DISABLE KEYS */;
INSERT INTO `projects_test_suite_script` VALUES (1,1,3),(2,1,4),(3,2,3),(4,3,1),(5,3,2),(6,4,1),(7,5,5),(13,6,3);
/*!40000 ALTER TABLE `projects_test_suite_script` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_role`
--

DROP TABLE IF EXISTS `users_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `project_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_role_group_id_project_id_user_id_a6884194_uniq` (`group_id`,`project_id`,`user_id`),
  KEY `users_role_project_id_2837f877_fk_projects_project_id` (`project_id`),
  KEY `users_role_user_id_cbcc337e_fk_auth_user_id` (`user_id`),
  CONSTRAINT `users_role_group_id_2bec884d_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `users_role_project_id_2837f877_fk_projects_project_id` FOREIGN KEY (`project_id`) REFERENCES `projects_project` (`id`),
  CONSTRAINT `users_role_user_id_cbcc337e_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_role`
--

LOCK TABLES `users_role` WRITE;
/*!40000 ALTER TABLE `users_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-05 21:57:21
