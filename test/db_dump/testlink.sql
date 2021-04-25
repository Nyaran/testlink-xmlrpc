
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
DROP TABLE IF EXISTS `assignment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignment_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `assignment_status` WRITE;
/*!40000 ALTER TABLE `assignment_status` DISABLE KEYS */;
INSERT INTO `assignment_status` VALUES (1,'open'),(2,'closed'),(3,'completed'),(4,'todo_urgent'),(5,'todo');
/*!40000 ALTER TABLE `assignment_status` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `assignment_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignment_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_table` varchar(30) DEFAULT '',
  `description` varchar(100) NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `assignment_types` WRITE;
/*!40000 ALTER TABLE `assignment_types` DISABLE KEYS */;
INSERT INTO `assignment_types` VALUES (1,'testplan_tcversions','testcase_execution'),(2,'tcversions','testcase_review');
/*!40000 ALTER TABLE `assignment_types` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_id` int(10) unsigned NOT NULL DEFAULT 0,
  `fk_table` varchar(250) DEFAULT '',
  `title` varchar(250) DEFAULT '',
  `description` varchar(250) DEFAULT '',
  `file_name` varchar(250) NOT NULL DEFAULT '',
  `file_path` varchar(250) DEFAULT '',
  `file_size` int(11) NOT NULL DEFAULT 0,
  `file_type` varchar(250) NOT NULL DEFAULT '',
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `content` longblob DEFAULT NULL,
  `compression_type` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `attachments_idx1` (`fk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `attachments` WRITE;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
INSERT INTO `attachments` VALUES (1,6,'nodes_hierarchy','','','attachment.png','nodes_hierarchy/6/2c46dff9581a972995ca0f7194cea408.png',13618,'image/png','2021-04-18 20:53:06',NULL,1),(2,11,'tcversions','','','attachment.png','tcversions/11/f3f53e0f28edc4f56d0806c2f2a372c6.png',13618,'image/png','2021-04-18 21:13:36',NULL,1);
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `baseline_l1l2_context`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `baseline_l1l2_context` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) unsigned NOT NULL DEFAULT 0,
  `platform_id` int(10) unsigned NOT NULL DEFAULT 0,
  `being_exec_ts` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_exec_ts` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx1` (`testplan_id`,`platform_id`,`creation_ts`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `baseline_l1l2_context` WRITE;
/*!40000 ALTER TABLE `baseline_l1l2_context` DISABLE KEYS */;
/*!40000 ALTER TABLE `baseline_l1l2_context` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `baseline_l1l2_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `baseline_l1l2_details` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `context_id` int(10) unsigned NOT NULL,
  `top_tsuite_id` int(10) unsigned NOT NULL DEFAULT 0,
  `child_tsuite_id` int(10) unsigned NOT NULL DEFAULT 0,
  `status` char(1) DEFAULT NULL,
  `qty` int(10) unsigned NOT NULL DEFAULT 0,
  `total_tc` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx1` (`context_id`,`top_tsuite_id`,`child_tsuite_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `baseline_l1l2_details` WRITE;
/*!40000 ALTER TABLE `baseline_l1l2_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `baseline_l1l2_details` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `builds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `builds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT 'undefined',
  `notes` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `release_date` date DEFAULT NULL,
  `closed_on_date` date DEFAULT NULL,
  `commit_id` varchar(64) DEFAULT NULL,
  `tag` varchar(64) DEFAULT NULL,
  `branch` varchar(64) DEFAULT NULL,
  `release_candidate` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`testplan_id`,`name`),
  KEY `testplan_id` (`testplan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Available builds';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `builds` WRITE;
/*!40000 ALTER TABLE `builds` DISABLE KEYS */;
INSERT INTO `builds` VALUES (1,13,'Editable Build','<p>Build to be edited on tests</p>\r\n',1,1,NULL,'2021-04-17 23:20:53',NULL,NULL,'','','',''),(2,13,'Closeable Build','<p>Build to be closed on tests</p>\r\n',1,1,NULL,'2021-04-17 23:21:13',NULL,NULL,'','','',''),(3,12,'Build Minefield','<p>Build to be used on tests</p>\r\n',1,1,NULL,'2021-04-17 23:23:42',NULL,NULL,'','','',''),(4,39,'Reportable Build','',1,1,NULL,'2021-04-24 18:17:01','2021-04-01',NULL,'','','','');
/*!40000 ALTER TABLE `builds` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `cfield_build_design_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfield_build_design_values` (
  `field_id` int(10) NOT NULL DEFAULT 0,
  `node_id` int(10) NOT NULL DEFAULT 0,
  `value` varchar(4000) NOT NULL DEFAULT '',
  PRIMARY KEY (`field_id`,`node_id`),
  KEY `idx_cfield_build_design_values` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `cfield_build_design_values` WRITE;
/*!40000 ALTER TABLE `cfield_build_design_values` DISABLE KEYS */;
INSERT INTO `cfield_build_design_values` VALUES (1,1,'CF Build edit Value'),(1,3,'CF Build Value');
/*!40000 ALTER TABLE `cfield_build_design_values` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `cfield_design_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfield_design_values` (
  `field_id` int(10) NOT NULL DEFAULT 0,
  `node_id` int(10) NOT NULL DEFAULT 0,
  `value` varchar(4000) NOT NULL DEFAULT '',
  PRIMARY KEY (`field_id`,`node_id`),
  KEY `idx_cfield_design_values` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `cfield_design_values` WRITE;
/*!40000 ALTER TABLE `cfield_design_values` DISABLE KEYS */;
INSERT INTO `cfield_design_values` VALUES (2,44,'CF Requirement edit Value'),(3,41,'CF Build edit Value'),(3,42,'CF Build edit Value'),(4,9,'Value for CF TC'),(5,12,'Test Plan CF Value'),(5,13,'Editable CF TP'),(6,5,'To edit CF TS'),(6,6,'Value for CF TS');
/*!40000 ALTER TABLE `cfield_design_values` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `cfield_execution_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfield_execution_values` (
  `field_id` int(10) NOT NULL DEFAULT 0,
  `execution_id` int(10) NOT NULL DEFAULT 0,
  `testplan_id` int(10) NOT NULL DEFAULT 0,
  `tcversion_id` int(10) NOT NULL DEFAULT 0,
  `value` varchar(4000) NOT NULL DEFAULT '',
  PRIMARY KEY (`field_id`,`execution_id`,`testplan_id`,`tcversion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `cfield_execution_values` WRITE;
/*!40000 ALTER TABLE `cfield_execution_values` DISABLE KEYS */;
INSERT INTO `cfield_execution_values` VALUES (7,1,12,9,'CF Value execution');
/*!40000 ALTER TABLE `cfield_execution_values` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `cfield_node_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfield_node_types` (
  `field_id` int(10) NOT NULL DEFAULT 0,
  `node_type_id` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`field_id`,`node_type_id`),
  KEY `idx_custom_fields_assign` (`node_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `cfield_node_types` WRITE;
/*!40000 ALTER TABLE `cfield_node_types` DISABLE KEYS */;
INSERT INTO `cfield_node_types` VALUES (1,12),(2,7),(3,6),(4,3),(5,5),(6,2),(7,3),(8,3);
/*!40000 ALTER TABLE `cfield_node_types` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `cfield_testplan_design_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfield_testplan_design_values` (
  `field_id` int(10) NOT NULL DEFAULT 0,
  `link_id` int(10) NOT NULL DEFAULT 0 COMMENT 'point to testplan_tcversion id',
  `value` varchar(4000) NOT NULL DEFAULT '',
  PRIMARY KEY (`field_id`,`link_id`),
  KEY `idx_cfield_tplan_design_val` (`link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `cfield_testplan_design_values` WRITE;
/*!40000 ALTER TABLE `cfield_testplan_design_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `cfield_testplan_design_values` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `cfield_testprojects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfield_testprojects` (
  `field_id` int(10) unsigned NOT NULL DEFAULT 0,
  `testproject_id` int(10) unsigned NOT NULL DEFAULT 0,
  `display_order` smallint(5) unsigned NOT NULL DEFAULT 1,
  `location` smallint(5) unsigned NOT NULL DEFAULT 1,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `required_on_design` tinyint(1) NOT NULL DEFAULT 0,
  `required_on_execution` tinyint(1) NOT NULL DEFAULT 0,
  `monitorable` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`field_id`,`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `cfield_testprojects` WRITE;
/*!40000 ALTER TABLE `cfield_testprojects` DISABLE KEYS */;
INSERT INTO `cfield_testprojects` VALUES (1,3,1,1,1,0,0,0,0),(1,4,1,1,1,0,0,0,0),(2,3,1,1,1,0,0,0,0),(2,4,1,1,1,0,0,0,0),(3,3,1,1,1,0,0,0,0),(3,4,1,1,1,0,0,0,0),(4,3,1,1,1,0,0,0,0),(4,4,1,1,1,0,0,0,0),(5,3,1,1,1,0,0,0,0),(5,4,1,1,1,0,0,0,0),(6,3,1,1,1,0,0,0,0),(6,4,1,1,1,0,0,0,0),(7,3,1,1,1,0,0,0,0),(8,3,1,1,1,0,0,0,0);
/*!40000 ALTER TABLE `cfield_testprojects` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `codetrackers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `codetrackers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` int(10) DEFAULT 0,
  `cfg` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codetrackers_uidx1` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `codetrackers` WRITE;
/*!40000 ALTER TABLE `codetrackers` DISABLE KEYS */;
INSERT INTO `codetrackers` VALUES (1,'LocalStash',1,'');
/*!40000 ALTER TABLE `codetrackers` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_fields` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `label` varchar(64) NOT NULL DEFAULT '' COMMENT 'label to display on user interface',
  `type` smallint(6) NOT NULL DEFAULT 0,
  `possible_values` varchar(4000) NOT NULL DEFAULT '',
  `default_value` varchar(4000) NOT NULL DEFAULT '',
  `valid_regexp` varchar(255) NOT NULL DEFAULT '',
  `length_min` int(10) NOT NULL DEFAULT 0,
  `length_max` int(10) NOT NULL DEFAULT 0,
  `show_on_design` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '1=> show it during specification design',
  `enable_on_design` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '1=> user can write/manage it during specification design',
  `show_on_execution` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '1=> show it during test case execution',
  `enable_on_execution` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT '1=> user can write/manage it during test case execution',
  `show_on_testplan_design` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `enable_on_testplan_design` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_custom_fields_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `custom_fields` WRITE;
/*!40000 ALTER TABLE `custom_fields` DISABLE KEYS */;
INSERT INTO `custom_fields` VALUES (1,'CF_Build','CF Build',0,'','','',0,0,1,1,1,0,0,0),(2,'CF_Requirement','CF Requirement',0,'','','',0,0,1,1,0,0,0,0),(3,'CF_RequirementSD','CF RequirementSD',0,'','','',0,0,1,1,0,0,0,0),(4,'CF_TestCase_TSD','CF TestCase Test Spec Design',0,'','','',0,0,1,1,1,0,0,0),(5,'CF_TestPlan','CF TestPlan',0,'','','',0,0,1,1,1,0,0,0),(6,'CF_TestSuite','CF TestSuite',0,'','','',0,0,1,1,1,0,0,0),(7,'CF_TestCase_TE','CF TestCase Test Execution',0,'','','',0,0,0,0,1,1,0,0),(8,'CF_TestCase_TPD','CF TestCase Test Plan Design',0,'','','',0,0,0,0,1,0,1,1);
/*!40000 ALTER TABLE `custom_fields` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `db_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_version` (
  `version` varchar(50) NOT NULL DEFAULT 'unknown',
  `upgrade_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `db_version` WRITE;
/*!40000 ALTER TABLE `db_version` DISABLE KEYS */;
INSERT INTO `db_version` VALUES ('DB 1.9.20','2021-04-17 17:11:07','TestLink 1.9.20 Raijin');
/*!40000 ALTER TABLE `db_version` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int(10) unsigned NOT NULL DEFAULT 0,
  `log_level` smallint(5) unsigned NOT NULL DEFAULT 0,
  `source` varchar(45) DEFAULT NULL,
  `description` text NOT NULL,
  `fired_at` int(10) unsigned NOT NULL DEFAULT 0,
  `activity` varchar(45) DEFAULT NULL,
  `object_id` int(10) unsigned DEFAULT NULL,
  `object_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `fired_at` (`fired_at`)
) ENGINE=InnoDB AUTO_INCREMENT=757 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,1,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:9:\"127.0.0.1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618679509,'LOGIN',1,'users'),(2,2,2,'GUI','E_NOTICE\nUndefined offset: 0 - in /var/www/html/testlink/lib/general/navBar.php - Line 160',1618679509,'PHP',0,NULL),(3,2,2,'GUI','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/general/navBar.php - Line 160',1618679509,'PHP',0,NULL),(4,2,2,'GUI','E_NOTICE\nUndefined offset: 0 - in /var/www/html/testlink/lib/general/navBar.php - Line 161',1618679509,'PHP',0,NULL),(5,3,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_testproject_created\";s:6:\"params\";a:1:{i:0;s:14:\"InitialProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618679554,'CREATE',1,'testprojects'),(6,4,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_testproject_created\";s:6:\"params\";a:1:{i:0;s:13:\"RemoveProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618679580,'CREATE',2,'testprojects'),(7,5,16,'GUI - Test Project ID : 2','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:23:\"audit_testproject_saved\";s:6:\"params\";a:1:{i:0;s:13:\"RemoveProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618679591,'UPDATE',2,'testprojects'),(8,6,2,'GUI - Test Project ID : 2','E_WARNING\nsizeof(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/object.class.php - Line 600',1618679594,'PHP',0,NULL),(9,7,2,'GUI - Test Project ID : 2','E_WARNING\nsizeof(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/object.class.php - Line 600',1618679595,'PHP',0,NULL),(10,8,16,'GUI - Test Project ID : 2','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_user_created\";s:6:\"params\";a:1:{i:0;s:6:\"Leader\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618679829,'CREATE',2,'users'),(11,9,16,'GUI - Test Project ID : 2','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_user_created\";s:6:\"params\";a:1:{i:0;s:12:\"SeniorTester\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618679848,'CREATE',3,'users'),(12,10,16,'GUI - Test Project ID : 2','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_user_created\";s:6:\"params\";a:1:{i:0;s:12:\"TestDesigner\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618679886,'CREATE',4,'users'),(13,11,16,'GUI - Test Project ID : 2','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_user_created\";s:6:\"params\";a:1:{i:0;s:6:\"Tester\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618679910,'CREATE',5,'users'),(14,12,16,'GUI - Test Project ID : 2','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_user_created\";s:6:\"params\";a:1:{i:0;s:5:\"Guest\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618679933,'CREATE',6,'users'),(15,13,16,'GUI - Test Project ID : 2','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:20:\"audit_cfield_created\";s:6:\"params\";a:1:{i:0;s:8:\"CF_Build\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618680035,'CREATE',1,'custom_fields'),(16,14,16,'GUI - Test Project ID : 2','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:20:\"audit_cfield_created\";s:6:\"params\";a:1:{i:0;s:14:\"CF_Requirement\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618680048,'CREATE',2,'custom_fields'),(17,15,16,'GUI - Test Project ID : 2','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_testproject_created\";s:6:\"params\";a:1:{i:0;s:15:\"TestableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618680122,'CREATE',3,'testprojects'),(18,16,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_cfield_assigned\";s:6:\"params\";a:2:{i:0;s:8:\"CF_Build\";i:1;s:15:\"TestableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618680243,'ASSIGN',3,'testprojects'),(19,16,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_cfield_assigned\";s:6:\"params\";a:2:{i:0;s:14:\"CF_Requirement\";i:1;s:15:\"TestableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618680243,'ASSIGN',3,'testprojects'),(20,17,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:20:\"audit_cfield_created\";s:6:\"params\";a:1:{i:0;s:16:\"CF_RequirementSD\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618680262,'CREATE',3,'custom_fields'),(21,17,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_cfield_assigned\";s:6:\"params\";a:2:{i:0;s:16:\"CF_RequirementSD\";i:1;s:15:\"TestableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618680262,'ASSIGN',3,'testprojects'),(22,18,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:20:\"audit_cfield_created\";s:6:\"params\";a:1:{i:0;s:11:\"CF_TestCase\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618680274,'CREATE',4,'custom_fields'),(23,18,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_cfield_assigned\";s:6:\"params\";a:2:{i:0;s:11:\"CF_TestCase\";i:1;s:15:\"TestableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618680274,'ASSIGN',3,'testprojects'),(24,19,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:20:\"audit_cfield_created\";s:6:\"params\";a:1:{i:0;s:11:\"CF_TestPlan\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618680289,'CREATE',5,'custom_fields'),(25,19,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_cfield_assigned\";s:6:\"params\";a:2:{i:0;s:11:\"CF_TestPlan\";i:1;s:15:\"TestableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618680289,'ASSIGN',3,'testprojects'),(26,20,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:20:\"audit_cfield_created\";s:6:\"params\";a:1:{i:0;s:12:\"CF_TestSuite\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618680305,'CREATE',6,'custom_fields'),(27,20,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_cfield_assigned\";s:6:\"params\";a:2:{i:0;s:12:\"CF_TestSuite\";i:1;s:15:\"TestableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618680305,'ASSIGN',3,'testprojects'),(28,21,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$dialogName - in /var/www/html/testlink/lib/keywords/keywordsEdit.php - Line 68',1618680925,'PHP',0,NULL),(29,21,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/4e0f5905b1186f94cf57bad99d35f682851c4227_0.file.keywordsEdit.tpl.php - Line 60',1618680925,'PHP',0,NULL),(30,21,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/4e0f5905b1186f94cf57bad99d35f682851c4227_0.file.keywordsEdit.tpl.php - Line 71',1618680925,'PHP',0,NULL),(31,21,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$bodyOnUnload - in /var/www/html/testlink/gui/templates_c/4e0f5905b1186f94cf57bad99d35f682851c4227_0.file.keywordsEdit.tpl.php - Line 72',1618680925,'PHP',0,NULL),(32,22,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_keyword_created\";s:6:\"params\";a:1:{i:0;s:12:\"Test Keyword\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618680933,'CREATE',1,'keywords'),(33,22,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/16914a40934ec31abec06188cd69e7d2cc6dc14d_0.file.keywordsView.tpl.php - Line 60',1618680934,'PHP',0,NULL),(34,22,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/16914a40934ec31abec06188cd69e7d2cc6dc14d_0.file.keywordsView.tpl.php - Line 73',1618680934,'PHP',0,NULL),(35,22,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$bodyOnUnload - in /var/www/html/testlink/gui/templates_c/16914a40934ec31abec06188cd69e7d2cc6dc14d_0.file.keywordsView.tpl.php - Line 74',1618680934,'PHP',0,NULL),(36,23,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$platformID - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 61',1618680943,'PHP',0,NULL),(37,23,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$enable_on_design - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 100',1618680943,'PHP',0,NULL),(38,23,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$enable_on_execution - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 108',1618680943,'PHP',0,NULL),(39,24,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618680949,'PHP',0,NULL),(40,24,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618680949,'PHP',0,NULL),(41,24,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618680949,'PHP',0,NULL),(42,24,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618680949,'PHP',0,NULL),(43,24,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618680949,'PHP',0,NULL),(44,25,16,'GUI - Test Project ID : 1','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_testproject_created\";s:6:\"params\";a:1:{i:0;s:16:\"EdtiasbleProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618682666,'CREATE',4,'testprojects'),(45,26,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:23:\"audit_testproject_saved\";s:6:\"params\";a:1:{i:0;s:15:\"EditableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618682682,'UPDATE',4,'testprojects'),(46,27,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618682744,'PHP',0,NULL),(47,28,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618682744,'PHP',0,NULL),(48,29,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618682745,'PHP',0,NULL),(49,30,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_cfield_assigned\";s:6:\"params\";a:2:{i:0;s:8:\"CF_Build\";i:1;s:15:\"EditableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618682807,'ASSIGN',4,'testprojects'),(50,30,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_cfield_assigned\";s:6:\"params\";a:2:{i:0;s:14:\"CF_Requirement\";i:1;s:15:\"EditableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618682807,'ASSIGN',4,'testprojects'),(51,30,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_cfield_assigned\";s:6:\"params\";a:2:{i:0;s:16:\"CF_RequirementSD\";i:1;s:15:\"EditableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618682807,'ASSIGN',4,'testprojects'),(52,30,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_cfield_assigned\";s:6:\"params\";a:2:{i:0;s:11:\"CF_TestCase\";i:1;s:15:\"EditableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618682807,'ASSIGN',4,'testprojects'),(53,30,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_cfield_assigned\";s:6:\"params\";a:2:{i:0;s:11:\"CF_TestPlan\";i:1;s:15:\"EditableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618682807,'ASSIGN',4,'testprojects'),(54,30,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_cfield_assigned\";s:6:\"params\";a:2:{i:0;s:12:\"CF_TestSuite\";i:1;s:15:\"EditableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618682807,'ASSIGN',4,'testprojects'),(55,31,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618682817,'PHP',0,NULL),(56,32,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618682817,'PHP',0,NULL),(57,33,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618682821,'PHP',0,NULL),(58,34,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618682821,'PHP',0,NULL),(59,35,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618682822,'PHP',0,NULL),(60,36,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/tree.class.php - Line 725',1618682866,'PHP',0,NULL),(61,36,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/tree.class.php - Line 725',1618682866,'PHP',0,NULL),(62,37,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618682866,'PHP',0,NULL),(63,38,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618682872,'PHP',0,NULL),(64,39,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618682872,'PHP',0,NULL),(65,40,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618682880,'PHP',0,NULL),(66,41,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618682880,'PHP',0,NULL),(67,42,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618682881,'PHP',0,NULL),(68,43,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/tree.class.php - Line 725',1618682930,'PHP',0,NULL),(69,43,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/tree.class.php - Line 725',1618682930,'PHP',0,NULL),(70,43,2,'GUI - Test Project ID : 3','E_WARNING\nsizeof(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/testsuite.class.php - Line 1107',1618682930,'PHP',0,NULL),(71,44,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618682930,'PHP',0,NULL),(72,45,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/tree.class.php - Line 725',1618682945,'PHP',0,NULL),(73,45,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/tree.class.php - Line 725',1618682945,'PHP',0,NULL),(74,46,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618682945,'PHP',0,NULL),(75,47,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618682964,'PHP',0,NULL),(76,48,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618682964,'PHP',0,NULL),(77,49,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618682974,'PHP',0,NULL),(78,50,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/testcase.class.php - Line 5361',1618683401,'PHP',0,NULL),(79,51,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/testcase.class.php - Line 5361',1618683483,'PHP',0,NULL),(80,51,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/tree.class.php - Line 725',1618683483,'PHP',0,NULL),(81,51,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/tree.class.php - Line 725',1618683483,'PHP',0,NULL),(82,51,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_keyword_assigned_tc\";s:6:\"params\";a:3:{i:0;s:12:\"Test Keyword\";i:1;s:53:\"/TestableProject/Test Suite Minefield/TP-1:TestCase 1\";i:2;i:1;}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618683483,'ASSIGN',9,'nodes_hierarchy'),(83,51,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1618683483,'PHP',0,NULL),(84,52,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618683483,'PHP',0,NULL),(85,53,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618683491,'PHP',0,NULL),(86,54,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618683491,'PHP',0,NULL),(87,55,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/testcase.class.php - Line 5361',1618683497,'PHP',0,NULL),(88,56,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/testcase.class.php - Line 5361',1618683523,'PHP',0,NULL),(89,56,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/tree.class.php - Line 725',1618683523,'PHP',0,NULL),(90,56,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/tree.class.php - Line 725',1618683523,'PHP',0,NULL),(91,56,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1618683523,'PHP',0,NULL),(92,57,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618683523,'PHP',0,NULL),(93,58,2,'GUI - Proyecto de Pruebas ID : 3','E_WARNING\nsizeof(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/object.class.php - Line 600',1618688991,'PHP',0,NULL),(94,58,2,'GUI - Proyecto de Pruebas ID : 3','E_WARNING\nsizeof(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/object.class.php - Line 600',1618688991,'PHP',0,NULL),(95,59,2,'GUI - Proyecto de Pruebas ID : 3','E_WARNING\nsizeof(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/object.class.php - Line 600',1618688992,'PHP',0,NULL),(96,59,2,'GUI - Proyecto de Pruebas ID : 3','E_WARNING\nsizeof(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/object.class.php - Line 600',1618688992,'PHP',0,NULL),(97,60,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618705048,'PHP',0,NULL),(98,60,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618705048,'PHP',0,NULL),(99,60,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618705048,'PHP',0,NULL),(100,60,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618705048,'PHP',0,NULL),(101,60,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618705048,'PHP',0,NULL),(102,61,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618705054,'PHP',0,NULL),(103,62,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618705054,'PHP',0,NULL),(104,63,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618705059,'PHP',0,NULL),(105,64,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618705059,'PHP',0,NULL),(106,65,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$platformID - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 61',1618705071,'PHP',0,NULL),(107,65,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$enable_on_design - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 100',1618705071,'PHP',0,NULL),(108,65,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$enable_on_execution - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 108',1618705071,'PHP',0,NULL),(109,66,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618705079,'PHP',0,NULL),(110,66,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618705079,'PHP',0,NULL),(111,66,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618705079,'PHP',0,NULL),(112,66,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618705079,'PHP',0,NULL),(113,66,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618705079,'PHP',0,NULL),(114,67,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$platformID - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 61',1618705083,'PHP',0,NULL),(115,67,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$enable_on_design - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 100',1618705083,'PHP',0,NULL),(116,67,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$enable_on_execution - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 108',1618705083,'PHP',0,NULL),(117,68,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618705094,'PHP',0,NULL),(118,68,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618705094,'PHP',0,NULL),(119,68,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618705094,'PHP',0,NULL),(120,68,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618705094,'PHP',0,NULL),(121,68,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618705094,'PHP',0,NULL),(122,68,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618705094,'PHP',0,NULL),(123,68,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618705094,'PHP',0,NULL),(124,68,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618705094,'PHP',0,NULL),(125,68,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618705094,'PHP',0,NULL),(126,69,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618705100,'PHP',0,NULL),(127,69,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$platformID - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 61',1618705100,'PHP',0,NULL),(128,70,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618705107,'PHP',0,NULL),(129,70,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618705107,'PHP',0,NULL),(130,70,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618705107,'PHP',0,NULL),(131,70,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618705107,'PHP',0,NULL),(132,70,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618705107,'PHP',0,NULL),(133,70,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618705107,'PHP',0,NULL),(134,70,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618705107,'PHP',0,NULL),(135,70,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618705107,'PHP',0,NULL),(136,70,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618705107,'PHP',0,NULL),(137,70,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618705107,'PHP',0,NULL),(138,71,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 130',1618705180,'PHP',0,NULL),(139,71,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined property: stdClass::$itemID - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 152',1618705180,'PHP',0,NULL),(140,72,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 130',1618705212,'PHP',0,NULL),(141,72,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$itemID - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 152',1618705212,'PHP',0,NULL),(142,73,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:22:\"audit_testplan_created\";s:6:\"params\";a:2:{i:0;s:15:\"TestableProject\";i:1;s:19:\"Test Plan Minefield\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618705250,'CREATED',12,'testplans'),(143,74,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 130',1618705257,'PHP',0,NULL),(144,74,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$itemID - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 152',1618705257,'PHP',0,NULL),(145,75,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:22:\"audit_testplan_created\";s:6:\"params\";a:2:{i:0;s:15:\"EditableProject\";i:1;s:17:\"Editable TestPlan\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618705281,'CREATED',13,'testplans'),(146,76,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 130',1618705282,'PHP',0,NULL),(147,76,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$itemID - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 152',1618705282,'PHP',0,NULL),(148,77,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:22:\"audit_testplan_created\";s:6:\"params\";a:2:{i:0;s:15:\"EditableProject\";i:1;s:12:\"Closeable TP\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618705294,'CREATED',14,'testplans'),(149,77,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:32:\"audit_users_roles_added_testplan\";s:6:\"params\";a:3:{i:0;s:5:\"admin\";i:1;s:12:\"Closeable TP\";i:2;s:5:\"admin\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618705294,'ASSIGN',14,'testplans'),(150,78,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 130',1618705299,'PHP',0,NULL),(151,78,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$itemID - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 152',1618705299,'PHP',0,NULL),(152,79,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:22:\"audit_testplan_created\";s:6:\"params\";a:2:{i:0;s:15:\"EditableProject\";i:1;s:9:\"Remove TP\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618705311,'CREATED',15,'testplans'),(153,79,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:32:\"audit_users_roles_added_testplan\";s:6:\"params\";a:3:{i:0;s:5:\"admin\";i:1;s:9:\"Remove TP\";i:2;s:5:\"admin\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618705311,'ASSIGN',15,'testplans'),(154,80,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 130',1618705314,'PHP',0,NULL),(155,80,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$itemID - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 152',1618705314,'PHP',0,NULL),(156,80,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index:  - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 302',1618705314,'PHP',0,NULL),(157,81,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:20:\"audit_testplan_saved\";s:6:\"params\";a:2:{i:0;s:15:\"EditableProject\";i:1;s:9:\"Remove TP\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618705321,'SAVE',15,'testplans'),(158,82,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 130',1618705391,'PHP',0,NULL),(159,82,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$itemID - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 152',1618705391,'PHP',0,NULL),(160,82,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index:  - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 302',1618705391,'PHP',0,NULL),(161,83,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618705413,'PHP',0,NULL),(162,83,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618705413,'PHP',0,NULL),(163,83,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618705413,'PHP',0,NULL),(164,83,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618705413,'PHP',0,NULL),(165,83,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618705413,'PHP',0,NULL),(166,83,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618705413,'PHP',0,NULL),(167,83,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618705413,'PHP',0,NULL),(168,83,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618705413,'PHP',0,NULL),(169,83,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618705413,'PHP',0,NULL),(170,84,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618705415,'PHP',0,NULL),(171,84,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$platformID - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 61',1618705415,'PHP',0,NULL),(172,85,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618705417,'PHP',0,NULL),(173,85,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618705417,'PHP',0,NULL),(174,85,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618705417,'PHP',0,NULL),(175,85,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618705417,'PHP',0,NULL),(176,85,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618705417,'PHP',0,NULL),(177,85,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618705417,'PHP',0,NULL),(178,85,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618705417,'PHP',0,NULL),(179,85,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618705417,'PHP',0,NULL),(180,85,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618705417,'PHP',0,NULL),(181,86,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 130',1618705437,'PHP',0,NULL),(182,86,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$itemID - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 152',1618705437,'PHP',0,NULL),(183,86,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index:  - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 302',1618705437,'PHP',0,NULL),(184,87,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618705567,'PHP',0,NULL),(185,88,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618706021,'PHP',0,NULL),(186,88,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618706021,'PHP',0,NULL),(187,88,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618706021,'PHP',0,NULL),(188,88,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618706021,'PHP',0,NULL),(189,88,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618706021,'PHP',0,NULL),(190,88,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618706021,'PHP',0,NULL),(191,88,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618706021,'PHP',0,NULL),(192,88,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618706021,'PHP',0,NULL),(193,88,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618706021,'PHP',0,NULL),(194,89,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 130',1618706031,'PHP',0,NULL),(195,89,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$itemID - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 152',1618706031,'PHP',0,NULL),(196,90,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618706052,'PHP',0,NULL),(197,90,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618706052,'PHP',0,NULL),(198,90,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618706052,'PHP',0,NULL),(199,90,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618706052,'PHP',0,NULL),(200,90,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618706052,'PHP',0,NULL),(201,90,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618706052,'PHP',0,NULL),(202,90,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618706052,'PHP',0,NULL),(203,90,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618706052,'PHP',0,NULL),(204,90,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618706052,'PHP',0,NULL),(205,91,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 130',1618706059,'PHP',0,NULL),(206,91,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$itemID - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 152',1618706059,'PHP',0,NULL),(207,92,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618706093,'PHP',0,NULL),(208,92,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618706093,'PHP',0,NULL),(209,92,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618706093,'PHP',0,NULL),(210,92,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618706093,'PHP',0,NULL),(211,92,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618706093,'PHP',0,NULL),(212,92,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618706093,'PHP',0,NULL),(213,92,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618706093,'PHP',0,NULL),(214,92,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618706093,'PHP',0,NULL),(215,92,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618706093,'PHP',0,NULL),(216,93,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$platformID - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 61',1618706095,'PHP',0,NULL),(217,93,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$enable_on_design - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 100',1618706095,'PHP',0,NULL),(218,93,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$enable_on_execution - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 108',1618706095,'PHP',0,NULL),(219,94,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618706117,'PHP',0,NULL),(220,94,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618706117,'PHP',0,NULL),(221,94,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618706117,'PHP',0,NULL),(222,94,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618706117,'PHP',0,NULL),(223,94,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618706117,'PHP',0,NULL),(224,94,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618706117,'PHP',0,NULL),(225,94,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618706117,'PHP',0,NULL),(226,94,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618706117,'PHP',0,NULL),(227,94,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618706117,'PHP',0,NULL),(228,94,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618706117,'PHP',0,NULL),(229,94,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618706117,'PHP',0,NULL),(230,94,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618706117,'PHP',0,NULL),(231,94,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618706117,'PHP',0,NULL),(232,95,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618706154,'PHP',0,NULL),(233,95,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$platformID - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 61',1618706154,'PHP',0,NULL),(234,96,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618706160,'PHP',0,NULL),(235,96,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618706160,'PHP',0,NULL),(236,96,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618706160,'PHP',0,NULL),(237,96,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618706160,'PHP',0,NULL),(238,96,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618706160,'PHP',0,NULL),(239,96,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618706160,'PHP',0,NULL),(240,96,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618706160,'PHP',0,NULL),(241,96,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618706160,'PHP',0,NULL),(242,96,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618706160,'PHP',0,NULL),(243,96,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618706160,'PHP',0,NULL),(244,96,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618706160,'PHP',0,NULL),(245,96,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618706160,'PHP',0,NULL),(246,96,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618706160,'PHP',0,NULL),(247,96,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618706160,'PHP',0,NULL),(248,97,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/general/frmWorkArea.php - Line 216',1618706559,'PHP',0,NULL),(249,98,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$creation_ts - in /var/www/html/testlink/lib/plan/buildEdit.php - Line 390',1618708853,'PHP',0,NULL),(250,98,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_build_created\";s:6:\"params\";a:3:{i:0;s:15:\"EditableProject\";i:1;s:17:\"Editable TestPlan\";i:2;s:14:\"Editable Build\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618708853,'CREATE',1,'builds'),(251,99,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: selected - in /var/www/html/testlink/gui/templates_c/79522dc1278942a4f217d64d244d60b7e6f5c944_0.file.buildEdit.tpl.php - Line 252',1618708855,'PHP',0,NULL),(252,100,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$creation_ts - in /var/www/html/testlink/lib/plan/buildEdit.php - Line 390',1618708873,'PHP',0,NULL),(253,100,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_build_created\";s:6:\"params\";a:3:{i:0;s:15:\"EditableProject\";i:1;s:17:\"Editable TestPlan\";i:2;s:15:\"Closeable Build\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618708873,'CREATE',2,'builds'),(254,101,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:17:\"audit_build_saved\";s:6:\"params\";a:3:{i:0;s:15:\"EditableProject\";i:1;s:17:\"Editable TestPlan\";i:2;s:14:\"Editable Build\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618708963,'SAVE',1,'builds'),(255,102,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined offset: 0 - in /var/www/html/testlink/lib/general/navBar.php - Line 160',1618708979,'PHP',0,NULL),(256,102,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/general/navBar.php - Line 160',1618708979,'PHP',0,NULL),(257,102,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined offset: 0 - in /var/www/html/testlink/lib/general/navBar.php - Line 161',1618708979,'PHP',0,NULL),(258,103,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$creation_ts - in /var/www/html/testlink/lib/plan/buildEdit.php - Line 390',1618709022,'PHP',0,NULL),(259,103,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_build_created\";s:6:\"params\";a:3:{i:0;s:15:\"TestableProject\";i:1;s:19:\"Test Plan Minefield\";i:2;s:15:\"Build Minefield\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618709022,'CREATE',3,'builds'),(260,104,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618713449,'PHP',0,NULL),(261,104,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$platformID - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 61',1618713449,'PHP',0,NULL),(262,105,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618713451,'PHP',0,NULL),(263,105,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618713451,'PHP',0,NULL),(264,105,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 159',1618713451,'PHP',0,NULL),(265,105,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 160',1618713451,'PHP',0,NULL),(266,105,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618713451,'PHP',0,NULL),(267,105,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618713451,'PHP',0,NULL),(268,106,2,'GUI','E_WARNING\nInvalid argument supplied for foreach() - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 2123',1618713555,'PHP',0,NULL),(269,106,2,'GUI','E_WARNING\nInvalid argument supplied for foreach() - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 2130',1618713555,'PHP',0,NULL),(270,106,2,'GUI','E_WARNING\nusort() expects parameter 1 to be array, null given - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 2140',1618713555,'PHP',0,NULL),(271,107,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:17:\"TP-1 : TestCase 1\";i:1;s:1:\"1\";i:2;s:19:\"Test Plan Minefield\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618713569,'ASSIGN',12,'testplans'),(272,107,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/2c6fbd9cbc621ba876a94ac25ac7d0693233c926_0.file.tcView.tpl.php - Line 215',1618713569,'PHP',0,NULL),(273,108,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618713569,'PHP',0,NULL),(274,109,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618713608,'PHP',0,NULL),(275,110,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 705',1618713610,'PHP',0,NULL),(276,110,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 710',1618713610,'PHP',0,NULL),(277,110,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 747',1618713610,'PHP',0,NULL),(278,111,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618713630,'PHP',0,NULL),(279,112,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618713632,'PHP',0,NULL),(280,112,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 159',1618713632,'PHP',0,NULL),(281,112,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 160',1618713632,'PHP',0,NULL),(282,112,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618713632,'PHP',0,NULL),(283,112,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618713632,'PHP',0,NULL),(284,113,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618713637,'PHP',0,NULL),(285,114,2,'GUI - Test Project ID : 3','E_WARNING\ngetimagesize(http://127.0.0.1/testlink/gui/themes/default/images/tl-logo-transparent-25.png): failed to open stream: Permission denied - in /var/www/html/testlink/lib/functions/print.inc.php - Line 679',1618713639,'PHP',0,NULL),(286,115,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 705',1618713641,'PHP',0,NULL),(287,115,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 710',1618713641,'PHP',0,NULL),(288,115,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 747',1618713641,'PHP',0,NULL),(289,116,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618713661,'PHP',0,NULL),(290,116,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618713661,'PHP',0,NULL),(291,116,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618713661,'PHP',0,NULL),(292,116,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618713661,'PHP',0,NULL),(293,116,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618713661,'PHP',0,NULL),(294,116,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618713661,'PHP',0,NULL),(295,116,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618713661,'PHP',0,NULL),(296,116,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618713661,'PHP',0,NULL),(297,116,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618713661,'PHP',0,NULL),(298,116,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1618713661,'PHP',0,NULL),(299,116,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1618713661,'PHP',0,NULL),(300,116,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618713661,'PHP',0,NULL),(301,116,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618713661,'PHP',0,NULL),(302,117,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1618713669,'PHP',0,NULL),(303,117,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 159',1618713669,'PHP',0,NULL),(304,117,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 160',1618713669,'PHP',0,NULL),(305,117,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1618713669,'PHP',0,NULL),(306,117,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1618713669,'PHP',0,NULL),(307,118,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 130',1618713683,'PHP',0,NULL),(308,118,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$itemID - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 152',1618713683,'PHP',0,NULL),(309,118,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index:  - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 302',1618713683,'PHP',0,NULL),(310,119,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: bulk_tester_div - in /var/www/html/testlink/lib/plan/tc_exec_assignment.php - Line 259',1618713693,'PHP',0,NULL),(311,119,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 705',1618713693,'PHP',0,NULL),(312,119,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 710',1618713693,'PHP',0,NULL),(313,119,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: platform_id - in /var/www/html/testlink/lib/functions/specview.php - Line 747',1618713693,'PHP',0,NULL),(314,119,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 747',1618713693,'PHP',0,NULL),(315,119,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 1747',1618713693,'PHP',0,NULL),(316,120,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: bulk_tester_div - in /var/www/html/testlink/lib/plan/tc_exec_assignment.php - Line 259',1618713700,'PHP',0,NULL),(317,120,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 705',1618713700,'PHP',0,NULL),(318,120,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 710',1618713700,'PHP',0,NULL),(319,120,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 747',1618713700,'PHP',0,NULL),(320,120,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 1164',1618713700,'PHP',0,NULL),(321,121,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618713725,'PHP',0,NULL),(322,122,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 705',1618713726,'PHP',0,NULL),(323,122,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 710',1618713726,'PHP',0,NULL),(324,122,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 747',1618713726,'PHP',0,NULL),(325,123,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 705',1618713729,'PHP',0,NULL),(326,123,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 710',1618713729,'PHP',0,NULL),(327,123,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 747',1618713729,'PHP',0,NULL),(328,123,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 1164',1618713729,'PHP',0,NULL),(329,123,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/2c48ad15c5f46480b294a7fadaaf2d39b9076c8d_0.file.planAddTC_m1.tpl.php - Line 462',1618713729,'PHP',0,NULL),(330,123,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/2c48ad15c5f46480b294a7fadaaf2d39b9076c8d_0.file.planAddTC_m1.tpl.php - Line 467',1618713729,'PHP',0,NULL),(331,123,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/2c48ad15c5f46480b294a7fadaaf2d39b9076c8d_0.file.planAddTC_m1.tpl.php - Line 479',1618713729,'PHP',0,NULL),(332,124,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 705',1618713747,'PHP',0,NULL),(333,124,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 710',1618713747,'PHP',0,NULL),(334,124,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 747',1618713747,'PHP',0,NULL),(335,124,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 1164',1618713747,'PHP',0,NULL),(336,125,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618713748,'PHP',0,NULL),(337,126,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 705',1618713751,'PHP',0,NULL),(338,126,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 710',1618713751,'PHP',0,NULL),(339,126,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 747',1618713751,'PHP',0,NULL),(340,126,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 1164',1618713751,'PHP',0,NULL),(341,127,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618713751,'PHP',0,NULL),(342,128,2,'GUI','E_NOTICE\nUndefined index: keywords - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 7096',1618714382,'PHP',0,NULL),(343,128,2,'GUI','E_NOTICE\nUndefined index: keywords - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 7126',1618714382,'PHP',0,NULL),(344,129,2,'GUI','E_NOTICE\nUndefined index: keywords - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 7096',1618714392,'PHP',0,NULL),(345,129,2,'GUI','E_NOTICE\nUndefined index: keywords - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 7126',1618714392,'PHP',0,NULL),(346,130,2,'GUI','E_NOTICE\nUndefined index: keywords - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 7096',1618714407,'PHP',0,NULL),(347,130,2,'GUI','E_NOTICE\nUndefined index: keywords - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 7126',1618714407,'PHP',0,NULL),(348,131,2,'GUI','E_NOTICE\nUndefined index: keywords - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 7096',1618714843,'PHP',0,NULL),(349,131,2,'GUI','E_NOTICE\nUndefined index: keywords - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 7126',1618714843,'PHP',0,NULL),(350,132,2,'GUI','E_NOTICE\nUndefined index: keywords - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 7096',1618714867,'PHP',0,NULL),(351,132,2,'GUI','E_NOTICE\nUndefined index: keywords - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 7126',1618714867,'PHP',0,NULL),(352,133,2,'GUI','E_NOTICE\nUndefined index: keywords - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 7096',1618715021,'PHP',0,NULL),(353,133,2,'GUI','E_NOTICE\nUndefined index: keywords - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 7126',1618715021,'PHP',0,NULL),(354,134,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618715053,'PHP',0,NULL),(355,135,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618715053,'PHP',0,NULL),(356,136,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618764365,'PHP',0,NULL),(357,137,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618765150,'PHP',0,NULL),(358,138,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618765151,'PHP',0,NULL),(359,139,2,'GUI','E_NOTICE\nUndefined index: executionid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5374',1618765322,'PHP',0,NULL),(360,139,2,'GUI','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5400',1618765322,'PHP',0,NULL),(361,140,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$dialogName - in /var/www/html/testlink/lib/keywords/keywordsEdit.php - Line 68',1618765395,'PHP',0,NULL),(362,140,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/4e0f5905b1186f94cf57bad99d35f682851c4227_0.file.keywordsEdit.tpl.php - Line 60',1618765395,'PHP',0,NULL),(363,140,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/4e0f5905b1186f94cf57bad99d35f682851c4227_0.file.keywordsEdit.tpl.php - Line 71',1618765395,'PHP',0,NULL),(364,140,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnUnload - in /var/www/html/testlink/gui/templates_c/4e0f5905b1186f94cf57bad99d35f682851c4227_0.file.keywordsEdit.tpl.php - Line 72',1618765395,'PHP',0,NULL),(365,141,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_keyword_created\";s:6:\"params\";a:1:{i:0;s:18:\"Assignable keyword\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618765404,'CREATE',2,'keywords'),(366,141,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/16914a40934ec31abec06188cd69e7d2cc6dc14d_0.file.keywordsView.tpl.php - Line 60',1618765404,'PHP',0,NULL),(367,141,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/16914a40934ec31abec06188cd69e7d2cc6dc14d_0.file.keywordsView.tpl.php - Line 73',1618765404,'PHP',0,NULL),(368,141,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnUnload - in /var/www/html/testlink/gui/templates_c/16914a40934ec31abec06188cd69e7d2cc6dc14d_0.file.keywordsView.tpl.php - Line 74',1618765404,'PHP',0,NULL),(369,142,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$dialogName - in /var/www/html/testlink/lib/keywords/keywordsEdit.php - Line 68',1618765409,'PHP',0,NULL),(370,142,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/4e0f5905b1186f94cf57bad99d35f682851c4227_0.file.keywordsEdit.tpl.php - Line 60',1618765409,'PHP',0,NULL),(371,142,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/4e0f5905b1186f94cf57bad99d35f682851c4227_0.file.keywordsEdit.tpl.php - Line 71',1618765409,'PHP',0,NULL),(372,142,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnUnload - in /var/www/html/testlink/gui/templates_c/4e0f5905b1186f94cf57bad99d35f682851c4227_0.file.keywordsEdit.tpl.php - Line 72',1618765409,'PHP',0,NULL),(373,143,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_keyword_saved\";s:6:\"params\";a:1:{i:0;s:18:\"Assignable keyword\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618765421,'SAVE',2,'keywords'),(374,143,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/16914a40934ec31abec06188cd69e7d2cc6dc14d_0.file.keywordsView.tpl.php - Line 60',1618765421,'PHP',0,NULL),(375,143,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/16914a40934ec31abec06188cd69e7d2cc6dc14d_0.file.keywordsView.tpl.php - Line 73',1618765421,'PHP',0,NULL),(376,143,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnUnload - in /var/www/html/testlink/gui/templates_c/16914a40934ec31abec06188cd69e7d2cc6dc14d_0.file.keywordsView.tpl.php - Line 74',1618765421,'PHP',0,NULL),(377,144,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$dialogName - in /var/www/html/testlink/lib/keywords/keywordsEdit.php - Line 68',1618765422,'PHP',0,NULL),(378,144,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/4e0f5905b1186f94cf57bad99d35f682851c4227_0.file.keywordsEdit.tpl.php - Line 60',1618765422,'PHP',0,NULL),(379,144,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/4e0f5905b1186f94cf57bad99d35f682851c4227_0.file.keywordsEdit.tpl.php - Line 71',1618765422,'PHP',0,NULL),(380,144,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnUnload - in /var/www/html/testlink/gui/templates_c/4e0f5905b1186f94cf57bad99d35f682851c4227_0.file.keywordsEdit.tpl.php - Line 72',1618765422,'PHP',0,NULL),(381,145,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_keyword_created\";s:6:\"params\";a:1:{i:0;s:16:\"Assigned keyword\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618765438,'CREATE',3,'keywords'),(382,145,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/16914a40934ec31abec06188cd69e7d2cc6dc14d_0.file.keywordsView.tpl.php - Line 60',1618765438,'PHP',0,NULL),(383,145,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in /var/www/html/testlink/gui/templates_c/16914a40934ec31abec06188cd69e7d2cc6dc14d_0.file.keywordsView.tpl.php - Line 73',1618765438,'PHP',0,NULL),(384,145,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$bodyOnUnload - in /var/www/html/testlink/gui/templates_c/16914a40934ec31abec06188cd69e7d2cc6dc14d_0.file.keywordsView.tpl.php - Line 74',1618765438,'PHP',0,NULL),(385,146,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618765443,'PHP',0,NULL),(386,147,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_keyword_assigned_tc\";s:6:\"params\";a:3:{i:0;s:16:\"Assigned keyword\";i:1;s:46:\"/EditableProject/Editable TS/EP-1:Editable TC1\";i:2;N;}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618765449,'ASSIGN',11,'nodes_hierarchy'),(387,148,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618765449,'PHP',0,NULL),(388,149,2,'GUI','E_WARNING\nimplode(): Invalid arguments passed - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 7301',1618765550,'PHP',0,NULL),(389,149,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_keyword_assigned_tc\";s:6:\"params\";a:3:{i:0;s:18:\"Assignable keyword\";i:1;s:46:\"/EditableProject/Editable TS/EP-1:Editable TC1\";i:2;N;}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618765550,'ASSIGN',11,'nodes_hierarchy'),(390,149,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_keyword_assigned_tc\";s:6:\"params\";a:3:{i:0;s:16:\"Assigned keyword\";i:1;s:46:\"/EditableProject/Editable TS/EP-1:Editable TC1\";i:2;N;}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618765550,'ASSIGN',11,'nodes_hierarchy'),(391,150,2,'GUI','E_WARNING\nimplode(): Invalid arguments passed - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 7301',1618765860,'PHP',0,NULL),(392,150,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:35:\"audit_keyword_assignment_removed_tc\";s:6:\"params\";a:2:{i:0;s:18:\"Assignable keyword\";i:1;s:12:\"Editable TC1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618765860,'ASSIGN',10,'nodes_hierarchy'),(393,150,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:35:\"audit_keyword_assignment_removed_tc\";s:6:\"params\";a:2:{i:0;s:16:\"Assigned keyword\";i:1;s:12:\"Editable TC1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618765860,'ASSIGN',10,'nodes_hierarchy'),(394,151,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618765896,'PHP',0,NULL),(395,152,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618765896,'PHP',0,NULL),(396,153,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$dialogName - in /var/www/html/testlink/lib/keywords/keywordsEdit.php - Line 68',1618765903,'PHP',0,NULL),(397,154,2,'GUI','E_WARNING\nimplode(): Invalid arguments passed - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 7301',1618765930,'PHP',0,NULL),(398,154,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_keyword_assigned_tc\";s:6:\"params\";a:3:{i:0;s:18:\"Assignable keyword\";i:1;s:46:\"/EditableProject/Editable TS/EP-1:Editable TC1\";i:2;N;}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618765930,'ASSIGN',11,'nodes_hierarchy'),(399,154,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_keyword_assigned_tc\";s:6:\"params\";a:3:{i:0;s:16:\"Assigned keyword\";i:1;s:46:\"/EditableProject/Editable TS/EP-1:Editable TC1\";i:2;N;}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618765930,'ASSIGN',11,'nodes_hierarchy'),(400,155,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618765935,'PHP',0,NULL),(401,156,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618765935,'PHP',0,NULL),(402,157,2,'GUI','E_WARNING\nimplode(): Invalid arguments passed - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 7301',1618765960,'PHP',0,NULL),(403,157,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:35:\"audit_keyword_assignment_removed_tc\";s:6:\"params\";a:2:{i:0;s:18:\"Assignable keyword\";i:1;s:12:\"Editable TC1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618765960,'ASSIGN',10,'nodes_hierarchy'),(404,157,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:35:\"audit_keyword_assignment_removed_tc\";s:6:\"params\";a:2:{i:0;s:16:\"Assigned keyword\";i:1;s:12:\"Editable TC1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618765960,'ASSIGN',10,'nodes_hierarchy'),(405,158,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618765967,'PHP',0,NULL),(406,159,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618765967,'PHP',0,NULL),(407,160,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_keyword_assigned_tc\";s:6:\"params\";a:3:{i:0;s:18:\"Assignable keyword\";i:1;s:46:\"/EditableProject/Editable TS/EP-1:Editable TC1\";i:2;N;}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618765993,'ASSIGN',11,'nodes_hierarchy'),(408,161,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618765995,'PHP',0,NULL),(409,162,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618765995,'PHP',0,NULL),(410,163,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_keyword_assigned_tc\";s:6:\"params\";a:3:{i:0;s:16:\"Assigned keyword\";i:1;s:46:\"/EditableProject/Editable TS/EP-1:Editable TC1\";i:2;N;}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618766020,'ASSIGN',11,'nodes_hierarchy'),(411,164,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:35:\"audit_keyword_assignment_removed_tc\";s:6:\"params\";a:2:{i:0;s:16:\"Assigned keyword\";i:1;s:12:\"Editable TC1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618766042,'ASSIGN',10,'nodes_hierarchy'),(412,165,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:35:\"audit_keyword_assignment_removed_tc\";s:6:\"params\";a:2:{i:0;s:18:\"Assignable keyword\";i:1;s:12:\"Editable TC1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618766053,'ASSIGN',10,'nodes_hierarchy'),(413,166,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_keyword_assigned_tc\";s:6:\"params\";a:3:{i:0;s:16:\"Assigned keyword\";i:1;s:46:\"/EditableProject/Editable TS/EP-1:Editable TC1\";i:2;N;}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618766057,'ASSIGN',11,'nodes_hierarchy'),(414,167,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618766058,'PHP',0,NULL),(415,168,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618766058,'PHP',0,NULL),(416,169,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_keyword_assigned_tc\";s:6:\"params\";a:3:{i:0;s:18:\"Assignable keyword\";i:1;s:46:\"/EditableProject/Editable TS/EP-1:Editable TC1\";i:2;N;}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618766064,'ASSIGN',11,'nodes_hierarchy'),(417,170,16,'GUI','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:35:\"audit_keyword_assignment_removed_tc\";s:6:\"params\";a:2:{i:0;s:16:\"Assigned keyword\";i:1;s:12:\"Editable TC1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618766069,'ASSIGN',10,'nodes_hierarchy'),(418,171,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:35:\"audit_keyword_assignment_removed_tc\";s:6:\"params\";a:2:{i:0;s:18:\"Assignable keyword\";i:1;s:12:\"Editable TC1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618766074,'ASSIGN',10,'nodes_hierarchy'),(419,172,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_keyword_assigned_tc\";s:6:\"params\";a:3:{i:0;s:16:\"Assigned keyword\";i:1;s:46:\"/EditableProject/Editable TS/EP-1:Editable TC1\";i:2;N;}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618766076,'ASSIGN',11,'nodes_hierarchy'),(420,173,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618766337,'PHP',0,NULL),(421,174,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618766337,'PHP',0,NULL),(422,175,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618766347,'PHP',0,NULL),(423,176,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined offset: 0 - in /var/www/html/testlink/lib/general/navBar.php - Line 160',1618766355,'PHP',0,NULL),(424,176,2,'GUI - Test Project ID : 1','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/general/navBar.php - Line 160',1618766355,'PHP',0,NULL),(425,176,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined offset: 0 - in /var/www/html/testlink/lib/general/navBar.php - Line 161',1618766355,'PHP',0,NULL),(426,177,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618766362,'PHP',0,NULL),(427,178,2,'GUI - Test Project ID : 1','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618766362,'PHP',0,NULL),(428,179,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618766374,'PHP',0,NULL),(429,180,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618766374,'PHP',0,NULL),(430,181,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618766778,'PHP',0,NULL),(431,182,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618766778,'PHP',0,NULL),(432,183,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618766849,'PHP',0,NULL),(433,184,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618766869,'PHP',0,NULL),(434,185,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618766873,'PHP',0,NULL),(435,186,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618766873,'PHP',0,NULL),(436,187,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618767203,'PHP',0,NULL),(437,188,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618767203,'PHP',0,NULL),(438,189,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618767286,'PHP',0,NULL),(439,190,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618767289,'PHP',0,NULL),(440,191,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/8d5f438b2424fadb9269fb5dd5ca4930831eca07_0.file.inc_tcbody.tpl.php - Line 119',1618767295,'PHP',0,NULL),(441,192,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/8d5f438b2424fadb9269fb5dd5ca4930831eca07_0.file.inc_tcbody.tpl.php - Line 119',1618767312,'PHP',0,NULL),(442,193,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/8d5f438b2424fadb9269fb5dd5ca4930831eca07_0.file.inc_tcbody.tpl.php - Line 119',1618767327,'PHP',0,NULL),(443,194,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/8d5f438b2424fadb9269fb5dd5ca4930831eca07_0.file.inc_tcbody.tpl.php - Line 119',1618767340,'PHP',0,NULL),(444,195,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1618767429,'PHP',0,NULL),(445,196,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/testcase.class.php - Line 5361',1618767433,'PHP',0,NULL),(446,196,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1618767433,'PHP',0,NULL),(447,197,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/testcase.class.php - Line 5361',1618767435,'PHP',0,NULL),(448,197,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1618767435,'PHP',0,NULL),(449,198,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/testcase.class.php - Line 5361',1618767437,'PHP',0,NULL),(450,198,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1618767437,'PHP',0,NULL),(451,199,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618767439,'PHP',0,NULL),(452,200,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/testcase.class.php - Line 5361',1618767443,'PHP',0,NULL),(453,201,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/testcase.class.php - Line 5361',1618767627,'PHP',0,NULL),(454,201,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1618767627,'PHP',0,NULL),(455,202,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618767632,'PHP',0,NULL),(456,203,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/8d5f438b2424fadb9269fb5dd5ca4930831eca07_0.file.inc_tcbody.tpl.php - Line 119',1618767636,'PHP',0,NULL),(457,204,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/8d5f438b2424fadb9269fb5dd5ca4930831eca07_0.file.inc_tcbody.tpl.php - Line 119',1618767653,'PHP',0,NULL),(458,205,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/8d5f438b2424fadb9269fb5dd5ca4930831eca07_0.file.inc_tcbody.tpl.php - Line 119',1618767724,'PHP',0,NULL),(459,206,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1618767732,'PHP',0,NULL),(460,207,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618769629,'PHP',0,NULL),(461,208,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618769629,'PHP',0,NULL),(462,209,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/8d5f438b2424fadb9269fb5dd5ca4930831eca07_0.file.inc_tcbody.tpl.php - Line 119',1618769661,'PHP',0,NULL),(463,210,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1618769664,'PHP',0,NULL),(464,211,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618769688,'PHP',0,NULL),(465,212,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618769688,'PHP',0,NULL),(466,213,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618769710,'PHP',0,NULL),(467,214,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618769710,'PHP',0,NULL),(468,215,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/aea2cf9f32323a27ebae802fb3eff8947f7ae49b_0.file.execSetResults.tpl.php - Line 548',1618769724,'PHP',0,NULL),(469,216,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/aea2cf9f32323a27ebae802fb3eff8947f7ae49b_0.file.execSetResults.tpl.php - Line 548',1618769729,'PHP',0,NULL),(470,217,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/aea2cf9f32323a27ebae802fb3eff8947f7ae49b_0.file.execSetResults.tpl.php - Line 548',1618769729,'PHP',0,NULL),(471,218,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/aea2cf9f32323a27ebae802fb3eff8947f7ae49b_0.file.execSetResults.tpl.php - Line 548',1618769734,'PHP',0,NULL),(472,219,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618769741,'PHP',0,NULL),(473,220,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618769741,'PHP',0,NULL),(474,221,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/8d5f438b2424fadb9269fb5dd5ca4930831eca07_0.file.inc_tcbody.tpl.php - Line 119',1618769744,'PHP',0,NULL),(475,222,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/8d5f438b2424fadb9269fb5dd5ca4930831eca07_0.file.inc_tcbody.tpl.php - Line 119',1618769758,'PHP',0,NULL),(476,223,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/8d5f438b2424fadb9269fb5dd5ca4930831eca07_0.file.inc_tcbody.tpl.php - Line 119',1618769763,'PHP',0,NULL),(477,224,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:20:\"audit_cfield_created\";s:6:\"params\";a:1:{i:0;s:14:\"CF_TestCase_TE\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618780376,'CREATE',7,'custom_fields'),(478,224,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_cfield_assigned\";s:6:\"params\";a:2:{i:0;s:14:\"CF_TestCase_TE\";i:1;s:15:\"TestableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618780376,'ASSIGN',3,'testprojects'),(479,225,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:20:\"audit_cfield_created\";s:6:\"params\";a:1:{i:0;s:15:\"CF_TestCase_TPD\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618780394,'CREATE',8,'custom_fields'),(480,225,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_cfield_assigned\";s:6:\"params\";a:2:{i:0;s:15:\"CF_TestCase_TPD\";i:1;s:15:\"TestableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618780394,'ASSIGN',3,'testprojects'),(481,226,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_cfield_saved\";s:6:\"params\";a:1:{i:0;s:15:\"CF_TestCase_TSD\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618780415,'SAVE',4,'custom_fields'),(482,227,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618780477,'PHP',0,NULL),(483,228,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618780477,'PHP',0,NULL),(484,229,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/aea2cf9f32323a27ebae802fb3eff8947f7ae49b_0.file.execSetResults.tpl.php - Line 548',1618780480,'PHP',0,NULL),(485,230,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618780484,'PHP',0,NULL),(486,231,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618780484,'PHP',0,NULL),(487,232,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/aea2cf9f32323a27ebae802fb3eff8947f7ae49b_0.file.execSetResults.tpl.php - Line 548',1618780486,'PHP',0,NULL),(488,233,2,'GUI - Test Project ID : 3','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/55ed46397183d2e556b9ebc573ef3920604f9ddf_0.file.inc_exec_show_tc_exec.tpl.php - Line 244',1618780503,'PHP',0,NULL),(489,234,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_exec_saved\";s:6:\"params\";a:3:{i:0;s:4:\"TP-1\";i:1;s:15:\"Build Minefield\";i:2;s:19:\"Test Plan Minefield\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618780516,'CREATE',1,'execution'),(490,235,2,'GUI','E_NOTICE\nUndefined index: linkid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5376',1618780536,'PHP',0,NULL),(491,235,2,'GUI','E_NOTICE\nUndefined offset: 4 - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5400',1618780536,'PHP',0,NULL),(492,236,2,'GUI','E_NOTICE\nUndefined index: linkid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5376',1618780545,'PHP',0,NULL),(493,236,2,'GUI','E_NOTICE\nUndefined offset: 4 - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5400',1618780545,'PHP',0,NULL),(494,237,2,'GUI','E_NOTICE\nUndefined index: linkid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5376',1618780558,'PHP',0,NULL),(495,238,2,'GUI','E_NOTICE\nUndefined index: linkid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5376',1618780636,'PHP',0,NULL),(496,239,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 130',1618780663,'PHP',0,NULL),(497,239,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$itemID - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 152',1618780663,'PHP',0,NULL),(498,239,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index:  - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 302',1618780663,'PHP',0,NULL),(499,240,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618780666,'PHP',0,NULL),(500,241,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618780666,'PHP',0,NULL),(501,242,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618780676,'PHP',0,NULL),(502,243,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618780677,'PHP',0,NULL),(503,244,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618780677,'PHP',0,NULL),(504,245,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618780684,'PHP',0,NULL),(505,246,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618780684,'PHP',0,NULL),(506,247,2,'GUI','E_NOTICE\nUndefined index: keywords - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 7096',1618782546,'PHP',0,NULL),(507,247,2,'GUI','E_NOTICE\nUndefined index: keywords - in /var/www/html/testlink/lib/functions/testplan.class.php - Line 7126',1618782546,'PHP',0,NULL),(508,248,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618782556,'PHP',0,NULL),(509,249,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618782556,'PHP',0,NULL),(510,250,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618782620,'PHP',0,NULL),(511,251,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618782620,'PHP',0,NULL),(512,252,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:19:\"EP-1 : Editable TC1\";i:1;s:1:\"1\";i:2;s:46:\"Editable TestPlan - Platform:Platform editable\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618782637,'ASSIGN',13,'testplans'),(513,252,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/2c6fbd9cbc621ba876a94ac25ac7d0693233c926_0.file.tcView.tpl.php - Line 215',1618782637,'PHP',0,NULL),(514,253,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618782637,'PHP',0,NULL),(515,254,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:19:\"EP-2 : Editable TC2\";i:1;s:1:\"1\";i:2;s:46:\"Editable TestPlan - Platform:Platform editable\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618782650,'ASSIGN',13,'testplans'),(516,254,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$steps_results_layout - in /var/www/html/testlink/gui/templates_c/0bb91b8cb47e2f5a097b52eac4a1d0c7f8afa7f6_0.file.tcView_viewer.tpl.php - Line 474',1618782650,'PHP',0,NULL),(517,254,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/2c6fbd9cbc621ba876a94ac25ac7d0693233c926_0.file.tcView.tpl.php - Line 215',1618782650,'PHP',0,NULL),(518,255,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618782650,'PHP',0,NULL),(519,256,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618782655,'PHP',0,NULL),(520,257,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618782655,'PHP',0,NULL),(521,258,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618782657,'PHP',0,NULL),(522,258,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/55ed46397183d2e556b9ebc573ef3920604f9ddf_0.file.inc_exec_show_tc_exec.tpl.php - Line 244',1618782657,'PHP',0,NULL),(523,259,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618782658,'PHP',0,NULL),(524,259,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/55ed46397183d2e556b9ebc573ef3920604f9ddf_0.file.inc_exec_show_tc_exec.tpl.php - Line 244',1618782658,'PHP',0,NULL),(525,260,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618782659,'PHP',0,NULL),(526,260,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/55ed46397183d2e556b9ebc573ef3920604f9ddf_0.file.inc_exec_show_tc_exec.tpl.php - Line 244',1618782659,'PHP',0,NULL),(527,261,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618782659,'PHP',0,NULL),(528,261,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/55ed46397183d2e556b9ebc573ef3920604f9ddf_0.file.inc_exec_show_tc_exec.tpl.php - Line 244',1618782659,'PHP',0,NULL),(529,262,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618782672,'PHP',0,NULL),(530,262,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_exec_saved\";s:6:\"params\";a:3:{i:0;s:4:\"EP-2\";i:1;s:15:\"Closeable Build\";i:2;s:17:\"Editable TestPlan\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618782672,'CREATE',2,'execution'),(531,263,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618782675,'PHP',0,NULL),(532,263,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/55ed46397183d2e556b9ebc573ef3920604f9ddf_0.file.inc_exec_show_tc_exec.tpl.php - Line 244',1618782675,'PHP',0,NULL),(533,264,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618782681,'PHP',0,NULL),(534,264,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_exec_saved\";s:6:\"params\";a:3:{i:0;s:4:\"EP-1\";i:1;s:15:\"Closeable Build\";i:2;s:17:\"Editable TestPlan\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618782681,'CREATE',3,'execution'),(535,265,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618782685,'PHP',0,NULL),(536,266,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618782686,'PHP',0,NULL),(537,267,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618782687,'PHP',0,NULL),(538,268,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618782691,'PHP',0,NULL),(539,269,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618783871,'PHP',0,NULL),(540,270,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618783871,'PHP',0,NULL),(541,271,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618783879,'PHP',0,NULL),(542,272,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618783879,'PHP',0,NULL),(543,273,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:23:\"audit_testproject_saved\";s:6:\"params\";a:1:{i:0;s:15:\"TestableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618783956,'UPDATE',3,'testprojects'),(544,274,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618784068,'PHP',0,NULL),(545,275,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618784098,'PHP',0,NULL),(546,276,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618784098,'PHP',0,NULL),(547,277,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618784957,'PHP',0,NULL),(548,278,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618784957,'PHP',0,NULL),(549,279,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618785057,'PHP',0,NULL),(550,280,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618785057,'PHP',0,NULL),(551,281,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618786293,'PHP',0,NULL),(552,282,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618786293,'PHP',0,NULL),(553,283,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:24:\"audit_attachment_created\";s:6:\"params\";a:2:{i:0;s:0:\"\";i:1;s:14:\"attachment.png\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618786386,'CREATE',6,'attachments'),(554,284,1,'GUI - Test Project ID : 3','Argument \"edit\" has invalid value: ',1618787455,NULL,0,NULL),(555,285,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618787471,'PHP',0,NULL),(556,286,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618787471,'PHP',0,NULL),(557,287,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618787474,'PHP',0,NULL),(558,288,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618787474,'PHP',0,NULL),(559,289,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618787489,'PHP',0,NULL),(560,290,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618787489,'PHP',0,NULL),(561,291,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:23:\"audit_testproject_saved\";s:6:\"params\";a:1:{i:0;s:15:\"TestableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618787508,'UPDATE',3,'testprojects'),(562,292,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618787513,'PHP',0,NULL),(563,293,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618787513,'PHP',0,NULL),(564,294,16,'GUI - Test Project ID : 3','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:23:\"audit_testproject_saved\";s:6:\"params\";a:1:{i:0;s:15:\"TestableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618787526,'UPDATE',3,'testprojects'),(565,295,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618787532,'PHP',0,NULL),(566,296,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618787532,'PHP',0,NULL),(567,297,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618787534,'PHP',0,NULL),(568,298,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618787534,'PHP',0,NULL),(569,299,2,'GUI - Test Project ID : 3','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1618787540,'PHP',0,NULL),(570,300,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618787544,'PHP',0,NULL),(571,301,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618787544,'PHP',0,NULL),(572,302,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618787596,'PHP',0,NULL),(573,303,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618787596,'PHP',0,NULL),(574,304,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:24:\"audit_attachment_created\";s:6:\"params\";a:2:{i:0;s:0:\"\";i:1;s:14:\"attachment.png\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1618787616,'CREATE',11,'attachments'),(575,305,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1618787669,'PHP',0,NULL),(576,306,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1618787669,'PHP',0,NULL),(577,307,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1619265400,'PHP',0,NULL),(578,308,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1619265400,'PHP',0,NULL),(579,309,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/testcase.class.php - Line 5361',1619265413,'PHP',0,NULL),(580,310,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/testcase.class.php - Line 5361',1619265487,'PHP',0,NULL),(581,310,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/lib/testcases/testcaseCommands.class.php - Line 1129',1619265487,'PHP',0,NULL),(582,311,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1619265489,'PHP',0,NULL),(583,312,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1619294882,'PHP',0,NULL),(584,313,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1619294883,'PHP',0,NULL),(585,314,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1619294915,'PHP',0,NULL),(586,315,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1619294915,'PHP',0,NULL),(587,316,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/2c6fbd9cbc621ba876a94ac25ac7d0693233c926_0.file.tcView.tpl.php - Line 215',1619294931,'PHP',0,NULL),(588,317,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/2c6fbd9cbc621ba876a94ac25ac7d0693233c926_0.file.tcView.tpl.php - Line 215',1619294944,'PHP',0,NULL),(589,318,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1619294947,'PHP',0,NULL),(590,319,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 130',1619295001,'PHP',0,NULL),(591,319,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$itemID - in /var/www/html/testlink/gui/templates_c/7db1d88a6ade5717bf7f3e64f3cca3d4835ebd98_0.file.planEdit.tpl.php - Line 152',1619295001,'PHP',0,NULL),(592,320,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:22:\"audit_testplan_created\";s:6:\"params\";a:2:{i:0;s:15:\"EditableProject\";i:1;s:13:\"Reportable TP\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1619295012,'CREATED',39,'testplans'),(593,321,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1619295018,'PHP',0,NULL),(594,322,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1619295018,'PHP',0,NULL),(595,323,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:33:\"EP-4 : Editable TC4 - ReportableA\";i:1;s:1:\"1\";i:2;s:13:\"Reportable TP\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1619295031,'ASSIGN',39,'testplans'),(596,323,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$steps_results_layout - in /var/www/html/testlink/gui/templates_c/0bb91b8cb47e2f5a097b52eac4a1d0c7f8afa7f6_0.file.tcView_viewer.tpl.php - Line 474',1619295031,'PHP',0,NULL),(597,323,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/2c6fbd9cbc621ba876a94ac25ac7d0693233c926_0.file.tcView.tpl.php - Line 215',1619295031,'PHP',0,NULL),(598,324,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:33:\"EP-5 : Editable TC4 - ReportableB\";i:1;s:1:\"1\";i:2;s:13:\"Reportable TP\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1619295041,'ASSIGN',39,'testplans'),(599,324,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$steps_results_layout - in /var/www/html/testlink/gui/templates_c/0bb91b8cb47e2f5a097b52eac4a1d0c7f8afa7f6_0.file.tcView_viewer.tpl.php - Line 474',1619295041,'PHP',0,NULL),(600,324,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/2c6fbd9cbc621ba876a94ac25ac7d0693233c926_0.file.tcView.tpl.php - Line 215',1619295041,'PHP',0,NULL),(601,325,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1619295045,'PHP',0,NULL),(602,326,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1619295045,'PHP',0,NULL),(603,327,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1619295098,'PHP',0,NULL),(604,327,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295098,'PHP',0,NULL),(605,327,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295098,'PHP',0,NULL),(606,327,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295098,'PHP',0,NULL),(607,327,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295098,'PHP',0,NULL),(608,327,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295098,'PHP',0,NULL),(609,327,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295098,'PHP',0,NULL),(610,327,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295098,'PHP',0,NULL),(611,327,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295098,'PHP',0,NULL),(612,327,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295098,'PHP',0,NULL),(613,327,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295098,'PHP',0,NULL),(614,327,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295098,'PHP',0,NULL),(615,327,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295098,'PHP',0,NULL),(616,328,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1619295101,'PHP',0,NULL),(617,328,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$platformID - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 61',1619295101,'PHP',0,NULL),(618,329,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1619295103,'PHP',0,NULL),(619,329,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295103,'PHP',0,NULL),(620,329,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295103,'PHP',0,NULL),(621,329,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295103,'PHP',0,NULL),(622,329,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295103,'PHP',0,NULL),(623,329,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295103,'PHP',0,NULL),(624,329,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295103,'PHP',0,NULL),(625,329,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295103,'PHP',0,NULL),(626,329,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295103,'PHP',0,NULL),(627,329,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295103,'PHP',0,NULL),(628,329,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295103,'PHP',0,NULL),(629,329,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295103,'PHP',0,NULL),(630,329,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295103,'PHP',0,NULL),(631,330,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1619295105,'PHP',0,NULL),(632,331,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1619295105,'PHP',0,NULL),(633,332,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1619295190,'PHP',0,NULL),(634,333,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 705',1619295193,'PHP',0,NULL),(635,333,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 710',1619295193,'PHP',0,NULL),(636,333,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 747',1619295193,'PHP',0,NULL),(637,333,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/lib/functions/specview.php - Line 1164',1619295193,'PHP',0,NULL),(638,334,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1619295197,'PHP',0,NULL),(639,335,2,'GUI - Test Project ID : 4','E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in /var/www/html/testlink/lib/functions/tlPlatform.class.php - Line 107',1619295197,'PHP',0,NULL),(640,336,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$creation_ts - in /var/www/html/testlink/lib/plan/buildEdit.php - Line 390',1619295421,'PHP',0,NULL),(641,336,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_build_created\";s:6:\"params\";a:3:{i:0;s:15:\"EditableProject\";i:1;s:13:\"Reportable TP\";i:2;s:16:\"Reportable Build\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1619295421,'CREATE',4,'builds'),(642,337,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1619295445,'PHP',0,NULL),(643,337,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295445,'PHP',0,NULL),(644,337,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295445,'PHP',0,NULL),(645,337,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295445,'PHP',0,NULL),(646,337,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295445,'PHP',0,NULL),(647,337,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295445,'PHP',0,NULL),(648,337,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295445,'PHP',0,NULL),(649,337,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295445,'PHP',0,NULL),(650,337,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295445,'PHP',0,NULL),(651,337,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295445,'PHP',0,NULL),(652,337,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295445,'PHP',0,NULL),(653,337,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295445,'PHP',0,NULL),(654,337,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295445,'PHP',0,NULL),(655,338,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1619295448,'PHP',0,NULL),(656,338,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295448,'PHP',0,NULL),(657,338,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295448,'PHP',0,NULL),(658,338,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295448,'PHP',0,NULL),(659,338,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295448,'PHP',0,NULL),(660,338,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295448,'PHP',0,NULL),(661,338,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295448,'PHP',0,NULL),(662,338,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295448,'PHP',0,NULL),(663,338,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295448,'PHP',0,NULL),(664,338,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295448,'PHP',0,NULL),(665,338,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295448,'PHP',0,NULL),(666,338,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295448,'PHP',0,NULL),(667,338,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295448,'PHP',0,NULL),(668,339,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$platformID - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 61',1619295450,'PHP',0,NULL),(669,339,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$enable_on_design - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 100',1619295450,'PHP',0,NULL),(670,339,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$enable_on_execution - in /var/www/html/testlink/gui/templates_c/b9f5cad61113ee516ce1d8ad4fb446bf73962e88_0.file.platformsEdit.tpl.php - Line 108',1619295450,'PHP',0,NULL),(671,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1619295523,'PHP',0,NULL),(672,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295523,'PHP',0,NULL),(673,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295523,'PHP',0,NULL),(674,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295523,'PHP',0,NULL),(675,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295523,'PHP',0,NULL),(676,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295523,'PHP',0,NULL),(677,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295523,'PHP',0,NULL),(678,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295523,'PHP',0,NULL),(679,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295523,'PHP',0,NULL),(680,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295523,'PHP',0,NULL),(681,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295523,'PHP',0,NULL),(682,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295523,'PHP',0,NULL),(683,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295523,'PHP',0,NULL),(684,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 159',1619295523,'PHP',0,NULL),(685,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 160',1619295523,'PHP',0,NULL),(686,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295523,'PHP',0,NULL),(687,340,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295523,'PHP',0,NULL),(688,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$user_feedback - in /var/www/html/testlink/lib/platforms/platformsEdit.php - Line 66',1619295528,'PHP',0,NULL),(689,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1619295528,'PHP',0,NULL),(690,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295528,'PHP',0,NULL),(691,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295528,'PHP',0,NULL),(692,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295528,'PHP',0,NULL),(693,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295528,'PHP',0,NULL),(694,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295528,'PHP',0,NULL),(695,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295528,'PHP',0,NULL),(696,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295528,'PHP',0,NULL),(697,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295528,'PHP',0,NULL),(698,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295528,'PHP',0,NULL),(699,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295528,'PHP',0,NULL),(700,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295528,'PHP',0,NULL),(701,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295528,'PHP',0,NULL),(702,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 171',1619295528,'PHP',0,NULL),(703,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: inactive_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 172',1619295528,'PHP',0,NULL),(704,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295528,'PHP',0,NULL),(705,341,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295528,'PHP',0,NULL),(706,342,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined property: stdClass::$tplan_id - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 100',1619295560,'PHP',0,NULL),(707,342,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 159',1619295560,'PHP',0,NULL),(708,342,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 160',1619295560,'PHP',0,NULL),(709,342,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 185',1619295560,'PHP',0,NULL),(710,342,2,'GUI - Test Project ID : 3','E_NOTICE\nUndefined index: active_click_to_change - in /var/www/html/testlink/gui/templates_c/4bf1a5669b6035e63a79e87de2efb8b2bf4609d5_0.file.platformsView.tpl.php - Line 186',1619295560,'PHP',0,NULL),(711,343,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined index: size - in /var/www/html/testlink/gui/templates_c/e251c5f8a60d77fbfa95c2a452c1e0a7a6699653_0.file.inc_filter_panel.tpl.php - Line 351',1619298565,'PHP',0,NULL),(712,344,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/gui/templates_c/827a302ab9851d7d795d11b2578396262daca889_0.file.containerView.tpl.php - Line 123',1619298565,'PHP',0,NULL),(713,345,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:23:\"audit_testproject_saved\";s:6:\"params\";a:1:{i:0;s:15:\"EditableProject\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1619298577,'UPDATE',4,'testprojects'),(714,346,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/0deb37195a337bef449316fe9aff3977fd010e3d_0.file.reqSpecEdit.tpl.php - Line 221',1619298583,'PHP',0,NULL),(715,346,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/0deb37195a337bef449316fe9aff3977fd010e3d_0.file.reqSpecEdit.tpl.php - Line 245',1619298583,'PHP',0,NULL),(716,346,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/0deb37195a337bef449316fe9aff3977fd010e3d_0.file.reqSpecEdit.tpl.php - Line 277',1619298583,'PHP',0,NULL),(717,347,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type bool - in /var/www/html/testlink/lib/requirements/reqSpecCommands.class.php - Line 208',1619298793,'PHP',0,NULL),(718,347,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:22:\"audit_req_spec_created\";s:6:\"params\";a:2:{i:0;s:15:\"EditableProject\";i:1;s:22:\"Editable Requirement 1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1619298793,'CREATE',40,'req_specs'),(719,347,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/0deb37195a337bef449316fe9aff3977fd010e3d_0.file.reqSpecEdit.tpl.php - Line 221',1619298793,'PHP',0,NULL),(720,347,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/0deb37195a337bef449316fe9aff3977fd010e3d_0.file.reqSpecEdit.tpl.php - Line 245',1619298793,'PHP',0,NULL),(721,347,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/0deb37195a337bef449316fe9aff3977fd010e3d_0.file.reqSpecEdit.tpl.php - Line 277',1619298793,'PHP',0,NULL),(722,348,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/ee7c93f8e11f4afc771376f13ef8a73c240b0dd8_0.file.reqEdit.tpl.php - Line 375',1619298856,'PHP',0,NULL),(723,348,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/ee7c93f8e11f4afc771376f13ef8a73c240b0dd8_0.file.reqEdit.tpl.php - Line 398',1619298856,'PHP',0,NULL),(724,348,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/ee7c93f8e11f4afc771376f13ef8a73c240b0dd8_0.file.reqEdit.tpl.php - Line 412',1619298856,'PHP',0,NULL),(725,348,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/ee7c93f8e11f4afc771376f13ef8a73c240b0dd8_0.file.reqEdit.tpl.php - Line 419',1619298856,'PHP',0,NULL),(726,348,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/ee7c93f8e11f4afc771376f13ef8a73c240b0dd8_0.file.reqEdit.tpl.php - Line 443',1619298856,'PHP',0,NULL),(727,349,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/0deb37195a337bef449316fe9aff3977fd010e3d_0.file.reqSpecEdit.tpl.php - Line 221',1619298862,'PHP',0,NULL),(728,349,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/0deb37195a337bef449316fe9aff3977fd010e3d_0.file.reqSpecEdit.tpl.php - Line 245',1619298862,'PHP',0,NULL),(729,349,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/0deb37195a337bef449316fe9aff3977fd010e3d_0.file.reqSpecEdit.tpl.php - Line 277',1619298862,'PHP',0,NULL),(730,350,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/0deb37195a337bef449316fe9aff3977fd010e3d_0.file.reqSpecEdit.tpl.php - Line 221',1619298868,'PHP',0,NULL),(731,350,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/0deb37195a337bef449316fe9aff3977fd010e3d_0.file.reqSpecEdit.tpl.php - Line 245',1619298869,'PHP',0,NULL),(732,350,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/0deb37195a337bef449316fe9aff3977fd010e3d_0.file.reqSpecEdit.tpl.php - Line 277',1619298869,'PHP',0,NULL),(733,351,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/lib/requirements/reqSpecEdit.php - Line 213',1619298905,'PHP',0,NULL),(734,352,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/ee7c93f8e11f4afc771376f13ef8a73c240b0dd8_0.file.reqEdit.tpl.php - Line 375',1619298941,'PHP',0,NULL),(735,352,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/ee7c93f8e11f4afc771376f13ef8a73c240b0dd8_0.file.reqEdit.tpl.php - Line 398',1619298941,'PHP',0,NULL),(736,352,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/ee7c93f8e11f4afc771376f13ef8a73c240b0dd8_0.file.reqEdit.tpl.php - Line 412',1619298941,'PHP',0,NULL),(737,352,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/ee7c93f8e11f4afc771376f13ef8a73c240b0dd8_0.file.reqEdit.tpl.php - Line 419',1619298941,'PHP',0,NULL),(738,352,2,'GUI - Test Project ID : 4','E_NOTICE\nTrying to access array offset on value of type null - in /var/www/html/testlink/gui/templates_c/ee7c93f8e11f4afc771376f13ef8a73c240b0dd8_0.file.reqEdit.tpl.php - Line 443',1619298941,'PHP',0,NULL),(739,353,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_requirement_created\";s:6:\"params\";a:1:{i:0;s:6:\"ReqUC1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1619299160,'CREATE',43,'requirements'),(740,353,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/lib/requirements/reqEdit.php - Line 235',1619299160,'PHP',0,NULL),(741,354,2,'GUI','E_NOTICE\nUndefined index: executionid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5374',1619299603,'PHP',0,NULL),(742,354,2,'GUI','E_NOTICE\nUndefined index: testplanid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5375',1619299603,'PHP',0,NULL),(743,354,2,'GUI','E_NOTICE\nUndefined index: linkid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5376',1619299603,'PHP',0,NULL),(744,355,2,'GUI','E_NOTICE\nUndefined index: executionid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5374',1619299642,'PHP',0,NULL),(745,355,2,'GUI','E_NOTICE\nUndefined index: testplanid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5375',1619299642,'PHP',0,NULL),(746,355,2,'GUI','E_NOTICE\nUndefined index: linkid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5376',1619299642,'PHP',0,NULL),(747,356,2,'GUI','E_NOTICE\nUndefined index: executionid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5374',1619299655,'PHP',0,NULL),(748,356,2,'GUI','E_NOTICE\nUndefined index: testplanid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5375',1619299655,'PHP',0,NULL),(749,356,2,'GUI','E_NOTICE\nUndefined index: linkid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5376',1619299655,'PHP',0,NULL),(750,357,2,'GUI','E_NOTICE\nUndefined index: executionid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5374',1619299696,'PHP',0,NULL),(751,357,2,'GUI','E_NOTICE\nUndefined index: testplanid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5375',1619299696,'PHP',0,NULL),(752,357,2,'GUI','E_NOTICE\nUndefined index: linkid - in /var/www/html/testlink/lib/api/xmlrpc/v1/xmlrpc.class.php - Line 5376',1619299696,'PHP',0,NULL),(753,358,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/lib/requirements/reqEdit.php - Line 235',1619299800,'PHP',0,NULL),(754,359,16,'GUI - Test Project ID : 4','O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:23:\"audit_reqv_assigned_tcv\";s:6:\"params\";a:4:{i:0;s:13:\"Requirement 1\";i:1;s:1:\"1\";i:2;s:12:\"Editable TC1\";i:3;s:1:\"1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}',1619299817,'ASSIGN',0,NULL),(755,359,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/lib/requirements/reqEdit.php - Line 235',1619299817,'PHP',0,NULL),(756,360,2,'GUI - Test Project ID : 4','E_NOTICE\nUndefined property: stdClass::$uploadOp - in /var/www/html/testlink/lib/requirements/reqEdit.php - Line 235',1619299836,'PHP',0,NULL);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `exec_by_date_time`;
/*!50001 DROP VIEW IF EXISTS `exec_by_date_time`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `exec_by_date_time` (
  `testplan_name` tinyint NOT NULL,
  `yyyy_mm_dd` tinyint NOT NULL,
  `yyyy_mm` tinyint NOT NULL,
  `hh` tinyint NOT NULL,
  `hour` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `build_id` tinyint NOT NULL,
  `tester_id` tinyint NOT NULL,
  `execution_ts` tinyint NOT NULL,
  `status` tinyint NOT NULL,
  `testplan_id` tinyint NOT NULL,
  `tcversion_id` tinyint NOT NULL,
  `tcversion_number` tinyint NOT NULL,
  `platform_id` tinyint NOT NULL,
  `execution_type` tinyint NOT NULL,
  `execution_duration` tinyint NOT NULL,
  `notes` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `execution_bugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `execution_bugs` (
  `execution_id` int(10) unsigned NOT NULL DEFAULT 0,
  `bug_id` varchar(64) NOT NULL DEFAULT '0',
  `tcstep_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`execution_id`,`bug_id`,`tcstep_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `execution_bugs` WRITE;
/*!40000 ALTER TABLE `execution_bugs` DISABLE KEYS */;
/*!40000 ALTER TABLE `execution_bugs` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `execution_tcsteps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `execution_tcsteps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `execution_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tcstep_id` int(10) unsigned NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `execution_tcsteps_idx1` (`execution_id`,`tcstep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `execution_tcsteps` WRITE;
/*!40000 ALTER TABLE `execution_tcsteps` DISABLE KEYS */;
INSERT INTO `execution_tcsteps` VALUES (1,1,25,'','p'),(2,1,26,'','p'),(3,2,22,'','p'),(4,2,23,'','p'),(5,2,24,'','p');
/*!40000 ALTER TABLE `execution_tcsteps` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `execution_tcsteps_wip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `execution_tcsteps_wip` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tcstep_id` int(10) unsigned NOT NULL DEFAULT 0,
  `testplan_id` int(10) unsigned NOT NULL DEFAULT 0,
  `platform_id` int(10) unsigned NOT NULL DEFAULT 0,
  `build_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tester_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `execution_tcsteps_wip_idx1` (`tcstep_id`,`testplan_id`,`platform_id`,`build_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `execution_tcsteps_wip` WRITE;
/*!40000 ALTER TABLE `execution_tcsteps_wip` DISABLE KEYS */;
/*!40000 ALTER TABLE `execution_tcsteps_wip` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `executions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `executions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `build_id` int(10) NOT NULL DEFAULT 0,
  `tester_id` int(10) unsigned DEFAULT NULL,
  `execution_ts` datetime DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `testplan_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tcversion_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tcversion_number` smallint(5) unsigned NOT NULL DEFAULT 1,
  `platform_id` int(10) unsigned NOT NULL DEFAULT 0,
  `execution_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 -> manual, 2 -> automated',
  `execution_duration` decimal(6,2) DEFAULT NULL COMMENT 'NULL will be considered as NO DATA Provided by user',
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `executions_idx1` (`testplan_id`,`tcversion_id`,`platform_id`,`build_id`),
  KEY `executions_idx2` (`execution_type`),
  KEY `executions_idx3` (`tcversion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `executions` WRITE;
/*!40000 ALTER TABLE `executions` DISABLE KEYS */;
INSERT INTO `executions` VALUES (1,3,1,'2021-04-18 21:15:16','p',12,9,1,0,1,61.00,''),(2,2,1,'2021-04-18 21:51:12','p',13,21,1,4,1,78.00,'');
/*!40000 ALTER TABLE `executions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testproject_id` int(10) unsigned NOT NULL,
  `owner_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `ipaddress` varchar(255) NOT NULL,
  `content` text DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `modification_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `inventory_idx1` (`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `issuetrackers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issuetrackers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` int(10) DEFAULT 0,
  `cfg` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `issuetrackers_uidx1` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `issuetrackers` WRITE;
/*!40000 ALTER TABLE `issuetrackers` DISABLE KEYS */;
INSERT INTO `issuetrackers` VALUES (1,'LocalBugzilla',1,'');
/*!40000 ALTER TABLE `issuetrackers` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keywords` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `keyword` varchar(100) NOT NULL DEFAULT '',
  `testproject_id` int(10) unsigned NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `keyword_testproject_id` (`keyword`,`testproject_id`),
  KEY `testproject_id` (`testproject_id`),
  KEY `keyword` (`keyword`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `keywords` WRITE;
/*!40000 ALTER TABLE `keywords` DISABLE KEYS */;
INSERT INTO `keywords` VALUES (1,'Test Keyword',3,'Keyword to be used on library tests'),(2,'Assignable keyword',4,'Keyword to be assigned by test execution'),(3,'Assigned keyword',4,'Default assigned keyword');
/*!40000 ALTER TABLE `keywords` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `latest_exec_by_context`;
/*!50001 DROP VIEW IF EXISTS `latest_exec_by_context`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `latest_exec_by_context` (
  `tcversion_id` tinyint NOT NULL,
  `testplan_id` tinyint NOT NULL,
  `build_id` tinyint NOT NULL,
  `platform_id` tinyint NOT NULL,
  `id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `latest_exec_by_testplan`;
/*!50001 DROP VIEW IF EXISTS `latest_exec_by_testplan`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `latest_exec_by_testplan` (
  `tcversion_id` tinyint NOT NULL,
  `testplan_id` tinyint NOT NULL,
  `id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `latest_exec_by_testplan_plat`;
/*!50001 DROP VIEW IF EXISTS `latest_exec_by_testplan_plat`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `latest_exec_by_testplan_plat` (
  `tcversion_id` tinyint NOT NULL,
  `testplan_id` tinyint NOT NULL,
  `platform_id` tinyint NOT NULL,
  `id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `latest_req_version`;
/*!50001 DROP VIEW IF EXISTS `latest_req_version`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `latest_req_version` (
  `req_id` tinyint NOT NULL,
  `version` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `latest_req_version_id`;
/*!50001 DROP VIEW IF EXISTS `latest_req_version_id`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `latest_req_version_id` (
  `req_id` tinyint NOT NULL,
  `version` tinyint NOT NULL,
  `req_version_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `latest_rspec_revision`;
/*!50001 DROP VIEW IF EXISTS `latest_rspec_revision`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `latest_rspec_revision` (
  `req_spec_id` tinyint NOT NULL,
  `testproject_id` tinyint NOT NULL,
  `revision` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `latest_tcase_version_id`;
/*!50001 DROP VIEW IF EXISTS `latest_tcase_version_id`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `latest_tcase_version_id` (
  `testcase_id` tinyint NOT NULL,
  `version` tinyint NOT NULL,
  `tcversion_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `latest_tcase_version_number`;
/*!50001 DROP VIEW IF EXISTS `latest_tcase_version_number`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `latest_tcase_version_number` (
  `testcase_id` tinyint NOT NULL,
  `version` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `milestones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `milestones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) unsigned NOT NULL DEFAULT 0,
  `target_date` date NOT NULL,
  `start_date` date DEFAULT NULL,
  `a` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `b` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `c` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT 'undefined',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_testplan_id` (`name`,`testplan_id`),
  KEY `testplan_id` (`testplan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `milestones` WRITE;
/*!40000 ALTER TABLE `milestones` DISABLE KEYS */;
/*!40000 ALTER TABLE `milestones` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `node_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL DEFAULT 'testproject',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `node_types` WRITE;
/*!40000 ALTER TABLE `node_types` DISABLE KEYS */;
INSERT INTO `node_types` VALUES (1,'testproject'),(2,'testsuite'),(3,'testcase'),(4,'testcase_version'),(5,'testplan'),(6,'requirement_spec'),(7,'requirement'),(8,'requirement_version'),(9,'testcase_step'),(10,'requirement_revision'),(11,'requirement_spec_revision'),(12,'build'),(13,'platform'),(14,'user');
/*!40000 ALTER TABLE `node_types` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `nodes_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nodes_hierarchy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `node_type_id` int(10) unsigned NOT NULL DEFAULT 1,
  `node_order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid_m_nodeorder` (`parent_id`,`node_order`),
  KEY `nodes_hierarchy_node_type_id` (`node_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `nodes_hierarchy` WRITE;
/*!40000 ALTER TABLE `nodes_hierarchy` DISABLE KEYS */;
INSERT INTO `nodes_hierarchy` VALUES (1,'InitialProject',NULL,1,1),(2,'RemoveProject',NULL,1,1),(3,'TestableProject',NULL,1,1),(4,'EditableProject',NULL,1,1),(5,'Editable TS',4,2,1),(6,'Test Suite Minefield',3,2,1),(7,'SubTest Suite',6,2,1),(8,'TestCase 1',6,3,1000),(9,'',8,4,0),(10,'Editable TC1',5,3,1000),(11,'',10,4,0),(12,'Test Plan Minefield',3,5,0),(13,'Editable TestPlan',4,5,0),(14,'Closeable TP',4,5,0),(15,'Remove TP',4,5,0),(16,'Second Editable TS',4,2,2),(20,'Editable TC2',5,3,1001),(21,'',20,4,0),(22,'',21,9,0),(23,'',21,9,0),(24,'',21,9,0),(25,'',9,9,0),(26,'',9,9,0),(27,'Editable TC3 - Unassigned',5,3,1002),(28,'',27,4,0),(29,'Editable TC4 - ReportableA',5,3,1003),(30,'',29,4,0),(31,'',30,9,0),(32,'',30,9,0),(33,'',30,9,0),(34,'Editable TC4 - ReportableB',5,3,1004),(35,'',34,4,0),(36,'',35,9,0),(37,'',35,9,0),(38,'',35,9,0),(39,'Reportable TP',4,5,0),(40,'Editable Requirement Section',4,6,1),(41,'Editable Requirement 1',40,11,0),(42,'Editable Requirement Section',40,11,0),(43,'Requirement 1',40,7,1),(44,'',43,8,0);
/*!40000 ALTER TABLE `nodes_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `object_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_keywords` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_id` int(10) unsigned NOT NULL DEFAULT 0,
  `fk_table` varchar(30) DEFAULT '',
  `keyword_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx01_object_keywords` (`fk_id`,`fk_table`,`keyword_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `object_keywords` WRITE;
/*!40000 ALTER TABLE `object_keywords` DISABLE KEYS */;
INSERT INTO `object_keywords` VALUES (1,6,'nodes_hierarchy',1);
/*!40000 ALTER TABLE `object_keywords` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `platforms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `testproject_id` int(10) unsigned NOT NULL,
  `notes` text NOT NULL,
  `enable_on_design` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `enable_on_execution` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_platforms` (`testproject_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `platforms` WRITE;
/*!40000 ALTER TABLE `platforms` DISABLE KEYS */;
INSERT INTO `platforms` VALUES (1,'Platform minefield',3,'<p>Platform to be used on tests</p>',1,1),(2,'Platform to Add',4,'<p>Platform to add on tests</p>',0,1),(3,'Platform to Remove',4,'<p>Platform to remove on tests</p>',0,1),(4,'Platform editable',4,'<p>Platform to be used on edit tests</p>',0,1),(5,'Reportable Platform',4,'',0,1);
/*!40000 ALTER TABLE `platforms` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basename` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `plugins_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `testproject_id` int(11) NOT NULL,
  `config_key` varchar(255) NOT NULL,
  `config_type` int(11) NOT NULL,
  `config_value` varchar(255) NOT NULL,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `plugins_configuration` WRITE;
/*!40000 ALTER TABLE `plugins_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugins_configuration` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `req_coverage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `req_coverage` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `req_id` int(10) NOT NULL,
  `req_version_id` int(10) NOT NULL,
  `testcase_id` int(10) NOT NULL,
  `tcversion_id` int(10) NOT NULL,
  `link_status` int(11) NOT NULL DEFAULT 1,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `review_requester_id` int(10) unsigned DEFAULT NULL,
  `review_request_ts` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `req_coverage_full_link` (`req_id`,`req_version_id`,`testcase_id`,`tcversion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='relation test case version ** requirement version';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `req_coverage` WRITE;
/*!40000 ALTER TABLE `req_coverage` DISABLE KEYS */;
INSERT INTO `req_coverage` VALUES (1,43,44,10,11,1,1,1,'2021-04-24 19:30:17',NULL,NULL);
/*!40000 ALTER TABLE `req_coverage` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `req_monitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `req_monitor` (
  `req_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `testproject_id` int(11) NOT NULL,
  PRIMARY KEY (`req_id`,`user_id`,`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `req_monitor` WRITE;
/*!40000 ALTER TABLE `req_monitor` DISABLE KEYS */;
/*!40000 ALTER TABLE `req_monitor` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `req_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `req_relations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source_id` int(10) unsigned NOT NULL,
  `destination_id` int(10) unsigned NOT NULL,
  `relation_type` smallint(5) unsigned NOT NULL DEFAULT 1,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `req_relations` WRITE;
/*!40000 ALTER TABLE `req_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `req_relations` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `req_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `req_revisions` (
  `parent_id` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL,
  `revision` smallint(5) unsigned NOT NULL DEFAULT 1,
  `req_doc_id` varchar(64) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `scope` text DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT 'V',
  `type` char(1) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `expected_coverage` int(10) NOT NULL DEFAULT 1,
  `log_message` text DEFAULT NULL,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `modifier_id` int(10) unsigned DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `req_revisions_uidx1` (`parent_id`,`revision`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `req_revisions` WRITE;
/*!40000 ALTER TABLE `req_revisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `req_revisions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `req_specs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `req_specs` (
  `id` int(10) unsigned NOT NULL,
  `testproject_id` int(10) unsigned NOT NULL,
  `doc_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `req_spec_uk1` (`doc_id`,`testproject_id`),
  KEY `testproject_id` (`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dev. Documents (e.g. System Requirements Specification)';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `req_specs` WRITE;
/*!40000 ALTER TABLE `req_specs` DISABLE KEYS */;
INSERT INTO `req_specs` VALUES (40,4,'EditReqS');
/*!40000 ALTER TABLE `req_specs` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `req_specs_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `req_specs_revisions` (
  `parent_id` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL,
  `revision` smallint(5) unsigned NOT NULL DEFAULT 1,
  `doc_id` varchar(64) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `scope` text DEFAULT NULL,
  `total_req` int(10) NOT NULL DEFAULT 0,
  `status` int(10) unsigned DEFAULT 1,
  `type` char(1) DEFAULT NULL,
  `log_message` text DEFAULT NULL,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `modifier_id` int(10) unsigned DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `req_specs_revisions_uidx1` (`parent_id`,`revision`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `req_specs_revisions` WRITE;
/*!40000 ALTER TABLE `req_specs_revisions` DISABLE KEYS */;
INSERT INTO `req_specs_revisions` VALUES (40,41,1,'EditReq1','Editable Requirement 1','<p>Requirement of editable project</p>',0,1,'1','Requirement Specification Created',1,'2021-04-24 19:13:13',NULL,'2021-04-24 23:13:13'),(40,42,2,'EditReqS','Editable Requirement Section','<p>Requirement of editable project</p>',0,1,'1','',1,'2021-04-24 19:15:05',NULL,'2021-04-24 23:15:05');
/*!40000 ALTER TABLE `req_specs_revisions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `req_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `req_versions` (
  `id` int(10) unsigned NOT NULL,
  `version` smallint(5) unsigned NOT NULL DEFAULT 1,
  `revision` smallint(5) unsigned NOT NULL DEFAULT 1,
  `scope` text DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT 'V',
  `type` char(1) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `expected_coverage` int(10) NOT NULL DEFAULT 1,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `modifier_id` int(10) unsigned DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT current_timestamp(),
  `log_message` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `req_versions` WRITE;
/*!40000 ALTER TABLE `req_versions` DISABLE KEYS */;
INSERT INTO `req_versions` VALUES (44,1,1,'<pre>\r\nTest Case Requirement</pre>','D','3',1,1,1,1,'2021-04-24 19:19:20',NULL,'2021-04-24 23:19:20','Requirement Created');
/*!40000 ALTER TABLE `req_versions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `reqmgrsystems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reqmgrsystems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` int(10) DEFAULT 0,
  `cfg` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reqmgrsystems_uidx1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `reqmgrsystems` WRITE;
/*!40000 ALTER TABLE `reqmgrsystems` DISABLE KEYS */;
/*!40000 ALTER TABLE `reqmgrsystems` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requirements` (
  `id` int(10) unsigned NOT NULL,
  `srs_id` int(10) unsigned NOT NULL,
  `req_doc_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `requirements_req_doc_id` (`srs_id`,`req_doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `requirements` WRITE;
/*!40000 ALTER TABLE `requirements` DISABLE KEYS */;
INSERT INTO `requirements` VALUES (43,40,'ReqUC1');
/*!40000 ALTER TABLE `requirements` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rights` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `rights_descr` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `rights` WRITE;
/*!40000 ALTER TABLE `rights` DISABLE KEYS */;
INSERT INTO `rights` VALUES (53,'cfield_assignment'),(18,'cfield_management'),(17,'cfield_view'),(51,'codetracker_management'),(52,'codetracker_view'),(56,'delete_frozen_tcversion'),(22,'events_mgt'),(54,'exec_assign_testcases'),(36,'exec_delete'),(35,'exec_edit_notes'),(49,'exec_ro_access'),(41,'exec_testcases_assigned_to_me'),(31,'issuetracker_management'),(32,'issuetracker_view'),(29,'keyword_assignment'),(9,'mgt_modify_key'),(12,'mgt_modify_product'),(11,'mgt_modify_req'),(7,'mgt_modify_tc'),(48,'mgt_plugins'),(16,'mgt_testplan_create'),(30,'mgt_unfreeze_req'),(13,'mgt_users'),(20,'mgt_view_events'),(8,'mgt_view_key'),(10,'mgt_view_req'),(6,'mgt_view_tc'),(21,'mgt_view_usergroups'),(50,'monitor_requirement'),(24,'platform_management'),(25,'platform_view'),(26,'project_inventory_management'),(27,'project_inventory_view'),(33,'reqmgrsystem_management'),(34,'reqmgrsystem_view'),(28,'req_tcase_link_management'),(14,'role_management'),(19,'system_configuration'),(47,'testcase_freeze'),(43,'testplan_add_remove_platforms'),(2,'testplan_create_build'),(1,'testplan_execute'),(3,'testplan_metrics'),(40,'testplan_milestone_overview'),(4,'testplan_planning'),(45,'testplan_set_urgent_testcases'),(46,'testplan_show_testcases_newest_versions'),(37,'testplan_unlink_executed_testcases'),(44,'testplan_update_linked_testcase_versions'),(5,'testplan_user_role_assignment'),(55,'testproject_add_remove_keywords_executed_tcversions'),(38,'testproject_delete_executed_testcases'),(39,'testproject_edit_executed_testcases'),(42,'testproject_metrics_dashboard'),(23,'testproject_user_role_assignment'),(15,'user_role_assignment');
/*!40000 ALTER TABLE `rights` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `risk_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `risk_assignments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) unsigned NOT NULL DEFAULT 0,
  `node_id` int(10) unsigned NOT NULL DEFAULT 0,
  `risk` char(1) NOT NULL DEFAULT '2',
  `importance` char(1) NOT NULL DEFAULT 'M',
  PRIMARY KEY (`id`),
  UNIQUE KEY `risk_assignments_tplan_node_id` (`testplan_id`,`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `risk_assignments` WRITE;
/*!40000 ALTER TABLE `risk_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `risk_assignments` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `role_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_rights` (
  `role_id` int(10) NOT NULL DEFAULT 0,
  `right_id` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`role_id`,`right_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `role_rights` WRITE;
/*!40000 ALTER TABLE `role_rights` DISABLE KEYS */;
INSERT INTO `role_rights` VALUES (4,3),(4,6),(4,7),(4,8),(4,9),(4,10),(4,11),(4,28),(4,29),(4,30),(4,50),(5,3),(5,6),(5,8),(6,1),(6,2),(6,3),(6,6),(6,7),(6,8),(6,9),(6,11),(6,25),(6,27),(6,28),(6,29),(6,30),(6,50),(7,1),(7,3),(7,6),(7,8),(8,1),(8,2),(8,3),(8,4),(8,5),(8,6),(8,7),(8,8),(8,9),(8,10),(8,11),(8,12),(8,13),(8,14),(8,15),(8,16),(8,17),(8,18),(8,19),(8,20),(8,21),(8,22),(8,23),(8,24),(8,25),(8,26),(8,27),(8,28),(8,29),(8,30),(8,31),(8,32),(8,33),(8,34),(8,35),(8,36),(8,37),(8,38),(8,39),(8,40),(8,41),(8,42),(8,43),(8,44),(8,45),(8,46),(8,47),(8,48),(8,50),(8,51),(8,52),(8,53),(8,54),(9,1),(9,2),(9,3),(9,4),(9,5),(9,6),(9,7),(9,8),(9,9),(9,10),(9,11),(9,15),(9,16),(9,24),(9,25),(9,26),(9,27),(9,28),(9,29),(9,30),(9,47),(9,50);
/*!40000 ALTER TABLE `role_rights` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_rights_roles_descr` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'<reserved system role 1>',NULL),(2,'<reserved system role 2>',NULL),(3,'<no rights>',NULL),(4,'test designer',NULL),(5,'guest',NULL),(6,'senior tester',NULL),(7,'tester',NULL),(8,'admin',NULL),(9,'leader',NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `tcsteps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tcsteps` (
  `id` int(10) unsigned NOT NULL,
  `step_number` int(11) NOT NULL DEFAULT 1,
  `actions` text DEFAULT NULL,
  `expected_results` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `execution_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 -> manual, 2 -> automated',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `tcsteps` WRITE;
/*!40000 ALTER TABLE `tcsteps` DISABLE KEYS */;
INSERT INTO `tcsteps` VALUES (22,1,'<p>First step</p>\r\n','<p>Do something cool</p>\r\n',1,1),(23,2,'<p>Second step</p>\r\n','<p>Coolest thing!</p>\r\n',1,1),(24,3,'<p>Third step</p>\r\n','<p>Meh</p>\r\n',1,1),(25,1,'<p>Testable step 1</p>\r\n','',1,1),(26,2,'<p>Testable step 2</p>\r\n','',1,1),(31,1,'<p>First step</p>\r\n','<p>Do something cool</p>\r\n',1,1),(32,2,'<p>Second step</p>\r\n','<p>Coolest thing!</p>\r\n',1,1),(33,3,'<p>Third step</p>\r\n','<p>Meh</p>\r\n',1,1),(36,1,'<p>First step</p>\r\n','<p>Do something cool</p>\r\n',1,1),(37,2,'<p>Second step</p>\r\n','<p>Coolest thing!</p>\r\n',1,1),(38,3,'<p>Third step</p>\r\n','<p>Meh</p>\r\n',1,1);
/*!40000 ALTER TABLE `tcsteps` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `tcversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tcversions` (
  `id` int(10) unsigned NOT NULL,
  `tc_external_id` int(10) unsigned DEFAULT NULL,
  `version` smallint(5) unsigned NOT NULL DEFAULT 1,
  `layout` smallint(5) unsigned NOT NULL DEFAULT 1,
  `status` smallint(5) unsigned NOT NULL DEFAULT 1,
  `summary` text DEFAULT NULL,
  `preconditions` text DEFAULT NULL,
  `importance` smallint(5) unsigned NOT NULL DEFAULT 2,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `updater_id` int(10) unsigned DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT current_timestamp(),
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `execution_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 -> manual, 2 -> automated',
  `estimated_exec_duration` decimal(6,2) DEFAULT NULL COMMENT 'NULL will be considered as NO DATA Provided by user',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `tcversions` WRITE;
/*!40000 ALTER TABLE `tcversions` DISABLE KEYS */;
INSERT INTO `tcversions` VALUES (9,1,1,1,1,'','',2,1,'2021-04-17 16:18:03',1,'2021-04-18 18:16:03',1,1,1,NULL),(11,1,1,1,1,'','',2,1,'2021-04-17 16:18:43',1,'2021-04-18 17:37:17',1,1,1,NULL),(21,2,1,1,1,'<p>Have steps</p>\r\n','',2,1,'2021-04-18 15:40:27',1,'2021-04-18 17:42:12',1,1,1,NULL),(28,3,1,1,1,'','',2,1,'2021-04-24 09:58:07',NULL,'2021-04-24 13:58:07',1,1,1,NULL),(30,4,1,1,1,'<p>Have steps</p>\r\n','',2,1,'2021-04-24 18:08:51',NULL,'2021-04-24 22:08:51',1,1,1,NULL),(35,5,1,1,1,'<p>Have steps</p>\r\n','',2,1,'2021-04-24 18:09:04',NULL,'2021-04-24 22:09:04',1,1,1,NULL);
/*!40000 ALTER TABLE `tcversions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `tcversions_without_keywords`;
/*!50001 DROP VIEW IF EXISTS `tcversions_without_keywords`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `tcversions_without_keywords` (
  `testcase_id` tinyint NOT NULL,
  `id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `tcversions_without_platforms`;
/*!50001 DROP VIEW IF EXISTS `tcversions_without_platforms`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `tcversions_without_platforms` (
  `testcase_id` tinyint NOT NULL,
  `id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `testcase_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testcase_keywords` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testcase_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tcversion_id` int(10) unsigned NOT NULL DEFAULT 0,
  `keyword_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx01_testcase_keywords` (`testcase_id`,`tcversion_id`,`keyword_id`),
  KEY `idx02_testcase_keywords` (`tcversion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `testcase_keywords` WRITE;
/*!40000 ALTER TABLE `testcase_keywords` DISABLE KEYS */;
INSERT INTO `testcase_keywords` VALUES (1,8,9,1),(10,10,11,3);
/*!40000 ALTER TABLE `testcase_keywords` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `testcase_platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testcase_platforms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testcase_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tcversion_id` int(10) unsigned NOT NULL DEFAULT 0,
  `platform_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx01_testcase_platform` (`testcase_id`,`tcversion_id`,`platform_id`),
  KEY `idx02_testcase_platform` (`tcversion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `testcase_platforms` WRITE;
/*!40000 ALTER TABLE `testcase_platforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `testcase_platforms` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `testcase_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testcase_relations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source_id` int(10) unsigned NOT NULL,
  `destination_id` int(10) unsigned NOT NULL,
  `link_status` tinyint(1) NOT NULL DEFAULT 1,
  `relation_type` smallint(5) unsigned NOT NULL DEFAULT 1,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `testcase_relations` WRITE;
/*!40000 ALTER TABLE `testcase_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `testcase_relations` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `testcase_script_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testcase_script_links` (
  `tcversion_id` int(10) unsigned NOT NULL DEFAULT 0,
  `project_key` varchar(64) NOT NULL,
  `repository_name` varchar(64) NOT NULL,
  `code_path` varchar(255) NOT NULL,
  `branch_name` varchar(64) DEFAULT NULL,
  `commit_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`tcversion_id`,`project_key`,`repository_name`,`code_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `testcase_script_links` WRITE;
/*!40000 ALTER TABLE `testcase_script_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `testcase_script_links` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `testplan_platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testplan_platforms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) unsigned NOT NULL,
  `platform_id` int(10) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_testplan_platforms` (`testplan_id`,`platform_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Connects a testplan with platforms';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `testplan_platforms` WRITE;
/*!40000 ALTER TABLE `testplan_platforms` DISABLE KEYS */;
INSERT INTO `testplan_platforms` VALUES (1,13,3,1),(2,12,1,1),(3,13,4,1),(4,39,5,1);
/*!40000 ALTER TABLE `testplan_platforms` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `testplan_tcversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testplan_tcversions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `testplan_id` int(10) unsigned NOT NULL DEFAULT 0,
  `tcversion_id` int(10) unsigned NOT NULL DEFAULT 0,
  `node_order` int(10) unsigned NOT NULL DEFAULT 1,
  `urgency` smallint(5) NOT NULL DEFAULT 2,
  `platform_id` int(10) unsigned NOT NULL DEFAULT 0,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `testplan_tcversions_tplan_tcversion` (`testplan_id`,`tcversion_id`,`platform_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `testplan_tcversions` WRITE;
/*!40000 ALTER TABLE `testplan_tcversions` DISABLE KEYS */;
INSERT INTO `testplan_tcversions` VALUES (1,12,9,1,2,0,1,'2021-04-18 00:39:29'),(2,13,11,1,2,4,1,'2021-04-18 19:50:37'),(3,13,21,1,2,4,1,'2021-04-18 19:50:50'),(4,39,30,1,2,5,1,'2021-04-24 18:10:31'),(5,39,35,1,2,5,1,'2021-04-24 18:10:41');
/*!40000 ALTER TABLE `testplan_tcversions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `testplans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testplans` (
  `id` int(10) unsigned NOT NULL,
  `testproject_id` int(10) unsigned NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `api_key` varchar(64) NOT NULL DEFAULT '829a2ded3ed0829a2dedd8ab81dfa2c77e8235bc3ed0d8ab81dfa2c77e8235bc',
  PRIMARY KEY (`id`),
  UNIQUE KEY `testplans_api_key` (`api_key`),
  KEY `testplans_testproject_id_active` (`testproject_id`,`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `testplans` WRITE;
/*!40000 ALTER TABLE `testplans` DISABLE KEYS */;
INSERT INTO `testplans` VALUES (12,3,'<p>Test plan to be used on library testing</p>',1,1,1,'41d7bccb1f9fe5b5a82a6fe4b161651b35a65ca132c01307be1fbc04e562b35c'),(13,4,'<p>Test plan to be edited on tests</p>',1,1,1,'19e3e011c2bbe31e8418227cc7d76b4e7cdca82cfad9e1db68915318529e17cd'),(14,4,'<p>Test plan to be closed on tests</p>',0,1,0,'b6b2a9a023454b388028bcbe8e70a6f4cf1fc9595b76e13d84181f2f93019196'),(15,4,'<p>Test plan to be removed on tests</p>',0,1,0,'0af71a3597ef04fb1544714a0932fccc949078a925b4a20d47d09b1c86271538'),(39,4,'',1,1,1,'38d09dde87e9c6fb5c74d789035576e28d767f6e2516a23ae81d980e2da111fa');
/*!40000 ALTER TABLE `testplans` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `testproject_codetracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testproject_codetracker` (
  `testproject_id` int(10) unsigned NOT NULL,
  `codetracker_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `testproject_codetracker` WRITE;
/*!40000 ALTER TABLE `testproject_codetracker` DISABLE KEYS */;
/*!40000 ALTER TABLE `testproject_codetracker` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `testproject_issuetracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testproject_issuetracker` (
  `testproject_id` int(10) unsigned NOT NULL,
  `issuetracker_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `testproject_issuetracker` WRITE;
/*!40000 ALTER TABLE `testproject_issuetracker` DISABLE KEYS */;
/*!40000 ALTER TABLE `testproject_issuetracker` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `testproject_reqmgrsystem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testproject_reqmgrsystem` (
  `testproject_id` int(10) unsigned NOT NULL,
  `reqmgrsystem_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `testproject_reqmgrsystem` WRITE;
/*!40000 ALTER TABLE `testproject_reqmgrsystem` DISABLE KEYS */;
/*!40000 ALTER TABLE `testproject_reqmgrsystem` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `testprojects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testprojects` (
  `id` int(10) unsigned NOT NULL,
  `notes` text DEFAULT NULL,
  `color` varchar(12) NOT NULL DEFAULT '#9BD',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `option_reqs` tinyint(1) NOT NULL DEFAULT 0,
  `option_priority` tinyint(1) NOT NULL DEFAULT 0,
  `option_automation` tinyint(1) NOT NULL DEFAULT 0,
  `options` text DEFAULT NULL,
  `prefix` varchar(16) NOT NULL,
  `tc_counter` int(10) unsigned NOT NULL DEFAULT 0,
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `issue_tracker_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `code_tracker_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `reqmgr_integration_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `api_key` varchar(64) NOT NULL DEFAULT '0d8ab81dfa2c77e8235bc829a2ded3edfa2c78235bc829a27eded3ed0d8ab81d',
  PRIMARY KEY (`id`),
  UNIQUE KEY `testprojects_prefix` (`prefix`),
  UNIQUE KEY `testprojects_api_key` (`api_key`),
  KEY `testprojects_id_active` (`id`,`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `testprojects` WRITE;
/*!40000 ALTER TABLE `testprojects` DISABLE KEYS */;
INSERT INTO `testprojects` VALUES (1,'<p>Initial project to test testlink-xmlrpc Node project.</p>','',1,0,0,0,'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:0;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:0;}','IP',0,1,0,0,0,'786ea4cee95e762f4ca7fee067994c5083021b1b23f89f67b1be5ffa8287d44a'),(2,'<p>Project to be removed during library tests.</p>','',1,0,0,0,'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:0;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:0;}','RP',0,1,0,0,0,'b230b17aba6b9edd4f45f807e825be100f2b0a26e756e54323ab8e71686e3a70'),(3,'<p>Project to be used on tests.</p>','',1,0,0,0,'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:0;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:0;}','TP',1,1,0,0,0,'9af5e446bce39a1ab554be800c659f57132924c778640dcc2790e4958f0b95db'),(4,'<p>Project to be used on tests to add/edit.</p>','',1,0,0,0,'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:1;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:0;}','EP',5,1,0,0,0,'52903fbc71482ae09456b3a13de785a50f92dde0da7b589a59a800c6fc9ec8cb');
/*!40000 ALTER TABLE `testprojects` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `testsuites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testsuites` (
  `id` int(10) unsigned NOT NULL,
  `details` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `testsuites` WRITE;
/*!40000 ALTER TABLE `testsuites` DISABLE KEYS */;
INSERT INTO `testsuites` VALUES (5,''),(6,''),(7,''),(16,'');
/*!40000 ALTER TABLE `testsuites` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `text_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `text_templates` (
  `id` int(10) unsigned NOT NULL,
  `type` smallint(5) unsigned NOT NULL,
  `title` varchar(100) NOT NULL,
  `template_data` text DEFAULT NULL,
  `author_id` int(10) unsigned DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_public` tinyint(1) NOT NULL DEFAULT 0,
  UNIQUE KEY `idx_text_templates` (`type`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Global Project Templates';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `text_templates` WRITE;
/*!40000 ALTER TABLE `text_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `text_templates` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entry_point` varchar(45) NOT NULL DEFAULT '',
  `start_time` int(10) unsigned NOT NULL DEFAULT 0,
  `end_time` int(10) unsigned NOT NULL DEFAULT 0,
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `session_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=361 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,'/testlink/login.php',1618679509,1618679509,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(2,'/testlink/lib/general/navBar.php',1618679509,1618679509,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(3,'/testlink/lib/project/projectEdit.php',1618679554,1618679554,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(4,'/testlink/lib/project/projectEdit.php',1618679580,1618679580,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(5,'/testlink/lib/project/projectEdit.php',1618679591,1618679591,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(6,'/testlink/lib/usermanagement/userInfo.php',1618679594,1618679594,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(7,'/testlink/lib/usermanagement/userInfo.php',1618679595,1618679595,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(8,'/testlink/lib/usermanagement/usersEdit.php',1618679829,1618679829,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(9,'/testlink/lib/usermanagement/usersEdit.php',1618679848,1618679848,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(10,'/testlink/lib/usermanagement/usersEdit.php',1618679886,1618679886,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(11,'/testlink/lib/usermanagement/usersEdit.php',1618679910,1618679910,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(12,'/testlink/lib/usermanagement/usersEdit.php',1618679933,1618679933,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(13,'/testlink/lib/cfields/cfieldsEdit.php',1618680035,1618680035,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(14,'/testlink/lib/cfields/cfieldsEdit.php',1618680048,1618680048,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(15,'/testlink/lib/project/projectEdit.php',1618680122,1618680122,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(16,'/lib/cfields/cfieldsTprojectAssign.php',1618680243,1618680243,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(17,'/testlink/lib/cfields/cfieldsEdit.php',1618680262,1618680262,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(18,'/testlink/lib/cfields/cfieldsEdit.php',1618680274,1618680274,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(19,'/testlink/lib/cfields/cfieldsEdit.php',1618680289,1618680289,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(20,'/testlink/lib/cfields/cfieldsEdit.php',1618680305,1618680305,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(21,'/testlink/lib/keywords/keywordsEdit.php',1618680925,1618680925,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(22,'/testlink/lib/keywords/keywordsEdit.php',1618680933,1618680934,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(23,'/testlink/lib/platforms/platformsEdit.php',1618680943,1618680943,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(24,'/testlink/lib/platforms/platformsEdit.php',1618680949,1618680949,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(25,'/testlink/lib/project/projectEdit.php',1618682666,1618682666,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(26,'/testlink/lib/project/projectEdit.php',1618682682,1618682682,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(27,'/testlink/lib/testcases/archiveData.php',1618682744,1618682744,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(28,'/testlink/lib/testcases/listTestCases.php',1618682744,1618682744,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(29,'/testlink/lib/testcases/archiveData.php',1618682745,1618682745,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(30,'/lib/cfields/cfieldsTprojectAssign.php',1618682807,1618682807,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(31,'/testlink/lib/testcases/archiveData.php',1618682817,1618682817,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(32,'/testlink/lib/testcases/listTestCases.php',1618682817,1618682817,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(33,'/testlink/lib/testcases/listTestCases.php',1618682821,1618682821,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(34,'/testlink/lib/testcases/archiveData.php',1618682821,1618682821,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(35,'/testlink/lib/testcases/archiveData.php',1618682822,1618682822,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(36,'/testlink/lib/testcases/containerEdit.php',1618682866,1618682866,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(37,'/testlink/lib/testcases/listTestCases.php',1618682866,1618682866,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(38,'/testlink/lib/testcases/listTestCases.php',1618682872,1618682872,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(39,'/testlink/lib/testcases/archiveData.php',1618682872,1618682872,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(40,'/testlink/lib/testcases/listTestCases.php',1618682880,1618682880,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(41,'/testlink/lib/testcases/archiveData.php',1618682880,1618682880,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(42,'/testlink/lib/testcases/archiveData.php',1618682881,1618682881,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(43,'/testlink/lib/testcases/containerEdit.php',1618682930,1618682930,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(44,'/testlink/lib/testcases/listTestCases.php',1618682930,1618682930,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(45,'/testlink/lib/testcases/containerEdit.php',1618682945,1618682945,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(46,'/testlink/lib/testcases/listTestCases.php',1618682945,1618682945,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(47,'/testlink/lib/testcases/listTestCases.php',1618682964,1618682964,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(48,'/testlink/lib/testcases/archiveData.php',1618682964,1618682964,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(49,'/testlink/lib/testcases/listTestCases.php',1618682974,1618682974,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(50,'/testlink/lib/testcases/tcEdit.php',1618683401,1618683401,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(51,'/testlink/lib/testcases/tcEdit.php',1618683483,1618683483,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(52,'/testlink/lib/testcases/listTestCases.php',1618683483,1618683483,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(53,'/testlink/lib/testcases/archiveData.php',1618683491,1618683491,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(54,'/testlink/lib/testcases/listTestCases.php',1618683491,1618683491,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(55,'/testlink/lib/testcases/tcEdit.php',1618683497,1618683497,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(56,'/testlink/lib/testcases/tcEdit.php',1618683523,1618683523,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(57,'/testlink/lib/testcases/listTestCases.php',1618683523,1618683523,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(58,'/testlink/lib/usermanagement/userInfo.php',1618688991,1618688991,2,'53vr5uvfuscutos3g6q1fh0pq9'),(59,'/testlink/lib/usermanagement/userInfo.php',1618688992,1618688992,2,'53vr5uvfuscutos3g6q1fh0pq9'),(60,'/testlink/lib/platforms/platformsView.php',1618705048,1618705048,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(61,'/testlink/lib/testcases/archiveData.php',1618705054,1618705054,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(62,'/testlink/lib/testcases/listTestCases.php',1618705054,1618705054,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(63,'/testlink/lib/testcases/archiveData.php',1618705059,1618705059,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(64,'/testlink/lib/testcases/listTestCases.php',1618705059,1618705059,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(65,'/testlink/lib/platforms/platformsEdit.php',1618705071,1618705071,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(66,'/testlink/lib/platforms/platformsEdit.php',1618705079,1618705079,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(67,'/testlink/lib/platforms/platformsEdit.php',1618705083,1618705083,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(68,'/testlink/lib/platforms/platformsEdit.php',1618705094,1618705094,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(69,'/testlink/lib/platforms/platformsEdit.php',1618705100,1618705100,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(70,'/testlink/lib/platforms/platformsEdit.php',1618705107,1618705107,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(71,'/testlink/lib/plan/planEdit.php',1618705180,1618705180,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(72,'/testlink/lib/plan/planEdit.php',1618705212,1618705212,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(73,'/testlink/lib/plan/planEdit.php',1618705250,1618705250,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(74,'/testlink/lib/plan/planEdit.php',1618705257,1618705257,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(75,'/testlink/lib/plan/planEdit.php',1618705281,1618705281,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(76,'/testlink/lib/plan/planEdit.php',1618705282,1618705282,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(77,'/testlink/lib/plan/planEdit.php',1618705294,1618705294,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(78,'/testlink/lib/plan/planEdit.php',1618705299,1618705299,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(79,'/testlink/lib/plan/planEdit.php',1618705311,1618705311,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(80,'/testlink/lib/plan/planEdit.php',1618705314,1618705314,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(81,'/testlink/lib/plan/planEdit.php',1618705321,1618705321,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(82,'/testlink/lib/plan/planEdit.php',1618705391,1618705391,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(83,'/testlink/lib/platforms/platformsView.php',1618705413,1618705413,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(84,'/testlink/lib/platforms/platformsEdit.php',1618705415,1618705415,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(85,'/testlink/lib/platforms/platformsView.php',1618705417,1618705417,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(86,'/testlink/lib/plan/planEdit.php',1618705437,1618705437,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(87,'/testlink/lib/plan/planAddTCNavigator.php',1618705567,1618705567,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(88,'/testlink/lib/platforms/platformsView.php',1618706021,1618706021,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(89,'/testlink/lib/plan/planEdit.php',1618706031,1618706031,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(90,'/testlink/lib/platforms/platformsView.php',1618706052,1618706052,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(91,'/testlink/lib/plan/planEdit.php',1618706059,1618706059,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(92,'/testlink/lib/platforms/platformsView.php',1618706093,1618706093,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(93,'/testlink/lib/platforms/platformsEdit.php',1618706095,1618706095,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(94,'/testlink/lib/platforms/platformsEdit.php',1618706117,1618706117,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(95,'/testlink/lib/platforms/platformsEdit.php',1618706154,1618706154,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(96,'/testlink/lib/platforms/platformsEdit.php',1618706160,1618706160,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(97,'/testlink/lib/general/frmWorkArea.php',1618706559,1618706559,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(98,'/testlink/lib/plan/buildEdit.php',1618708853,1618708853,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(99,'/testlink/lib/plan/buildEdit.php',1618708855,1618708855,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(100,'/testlink/lib/plan/buildEdit.php',1618708873,1618708873,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(101,'/testlink/lib/plan/buildEdit.php',1618708963,1618708963,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(102,'/testlink/lib/general/navBar.php',1618708979,1618708979,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(103,'/testlink/lib/plan/buildEdit.php',1618709022,1618709022,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(104,'/testlink/lib/platforms/platformsEdit.php',1618713449,1618713449,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(105,'/testlink/lib/platforms/platformsEdit.php',1618713451,1618713451,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(106,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618713555,1618713555,1,''),(107,'/testlink/lib/testcases/tcEdit.php',1618713569,1618713569,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(108,'/testlink/lib/testcases/listTestCases.php',1618713569,1618713569,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(109,'/testlink/lib/plan/planAddTCNavigator.php',1618713608,1618713608,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(110,'/testlink/lib/plan/planAddTC.php',1618713610,1618713610,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(111,'/testlink/lib/plan/planAddTCNavigator.php',1618713630,1618713630,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(112,'/testlink/lib/platforms/platformsView.php',1618713632,1618713632,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(113,'/testlink/lib/plan/planAddTCNavigator.php',1618713637,1618713637,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(114,'/testlink/lib/results/printDocument.php',1618713639,1618713639,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(115,'/testlink/lib/plan/planAddTC.php',1618713641,1618713641,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(116,'/testlink/lib/platforms/platformsView.php',1618713661,1618713661,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(117,'/testlink/lib/platforms/platformsView.php',1618713669,1618713669,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(118,'/testlink/lib/plan/planEdit.php',1618713683,1618713683,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(119,'/testlink/lib/plan/tc_exec_assignment.php',1618713693,1618713693,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(120,'/testlink/lib/plan/tc_exec_assignment.php',1618713700,1618713700,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(121,'/testlink/lib/plan/planAddTCNavigator.php',1618713725,1618713725,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(122,'/testlink/lib/plan/planAddTC.php',1618713726,1618713726,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(123,'/testlink/lib/plan/planAddTC.php',1618713729,1618713729,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(124,'/testlink/lib/plan/planAddTC.php',1618713747,1618713747,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(125,'/testlink/lib/plan/planAddTCNavigator.php',1618713748,1618713748,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(126,'/testlink/lib/plan/planAddTC.php',1618713751,1618713751,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(127,'/testlink/lib/plan/planAddTCNavigator.php',1618713751,1618713751,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(128,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618714382,1618714382,1,''),(129,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618714392,1618714392,1,''),(130,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618714407,1618714407,1,''),(131,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618714843,1618714843,1,''),(132,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618714867,1618714867,1,''),(133,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618715021,1618715021,1,''),(134,'/testlink/lib/testcases/archiveData.php',1618715053,1618715053,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(135,'/testlink/lib/testcases/listTestCases.php',1618715053,1618715053,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(136,'/testlink/lib/testcases/listTestCases.php',1618764365,1618764365,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(137,'/testlink/lib/execute/execDashboard.php',1618765150,1618765151,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(138,'/testlink/lib/execute/execDashboard.php',1618765151,1618765151,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(139,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618765322,1618765322,1,''),(140,'/testlink/lib/keywords/keywordsEdit.php',1618765395,1618765395,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(141,'/testlink/lib/keywords/keywordsEdit.php',1618765404,1618765404,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(142,'/testlink/lib/keywords/keywordsEdit.php',1618765409,1618765409,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(143,'/testlink/lib/keywords/keywordsEdit.php',1618765421,1618765421,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(144,'/testlink/lib/keywords/keywordsEdit.php',1618765422,1618765422,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(145,'/testlink/lib/keywords/keywordsEdit.php',1618765438,1618765438,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(146,'/testlink/lib/testcases/listTestCases.php',1618765443,1618765443,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(147,'/testlink/lib/keywords/keywordsAssign.php',1618765449,1618765449,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(148,'/testlink/lib/testcases/listTestCases.php',1618765449,1618765449,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(149,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618765550,1618765550,1,''),(150,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618765860,1618765860,1,''),(151,'/testlink/lib/testcases/archiveData.php',1618765896,1618765896,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(152,'/testlink/lib/testcases/listTestCases.php',1618765896,1618765896,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(153,'/testlink/lib/keywords/keywordsEdit.php',1618765903,1618765903,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(154,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618765930,1618765930,1,''),(155,'/testlink/lib/testcases/listTestCases.php',1618765935,1618765935,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(156,'/testlink/lib/testcases/archiveData.php',1618765935,1618765935,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(157,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618765960,1618765960,1,''),(158,'/testlink/lib/testcases/listTestCases.php',1618765967,1618765967,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(159,'/testlink/lib/testcases/archiveData.php',1618765967,1618765967,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(160,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618765993,1618765993,1,''),(161,'/testlink/lib/testcases/archiveData.php',1618765995,1618765995,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(162,'/testlink/lib/testcases/listTestCases.php',1618765995,1618765995,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(163,'/testlink/lib/testcases/tcEdit.php',1618766020,1618766020,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(164,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618766042,1618766042,1,''),(165,'/testlink/lib/testcases/tcEdit.php',1618766053,1618766053,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(166,'/testlink/lib/testcases/tcEdit.php',1618766057,1618766057,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(167,'/testlink/lib/testcases/listTestCases.php',1618766058,1618766058,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(168,'/testlink/lib/testcases/archiveData.php',1618766058,1618766058,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(169,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618766064,1618766064,1,''),(170,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618766069,1618766069,1,''),(171,'/testlink/lib/testcases/tcEdit.php',1618766074,1618766074,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(172,'/testlink/lib/testcases/tcEdit.php',1618766076,1618766076,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(173,'/testlink/lib/testcases/listTestCases.php',1618766337,1618766337,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(174,'/testlink/lib/testcases/archiveData.php',1618766337,1618766338,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(175,'/testlink/lib/testcases/archiveData.php',1618766347,1618766347,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(176,'/testlink/lib/general/navBar.php',1618766355,1618766355,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(177,'/testlink/lib/testcases/listTestCases.php',1618766362,1618766362,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(178,'/testlink/lib/testcases/archiveData.php',1618766362,1618766362,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(179,'/testlink/lib/testcases/listTestCases.php',1618766374,1618766374,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(180,'/testlink/lib/testcases/archiveData.php',1618766374,1618766374,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(181,'/testlink/lib/testcases/archiveData.php',1618766778,1618766778,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(182,'/testlink/lib/testcases/listTestCases.php',1618766778,1618766778,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(183,'/testlink/lib/testcases/archiveData.php',1618766849,1618766849,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(184,'/testlink/lib/testcases/archiveData.php',1618766869,1618766869,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(185,'/testlink/lib/testcases/archiveData.php',1618766873,1618766873,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(186,'/testlink/lib/testcases/listTestCases.php',1618766873,1618766873,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(187,'/testlink/lib/testcases/listTestCases.php',1618767203,1618767203,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(188,'/testlink/lib/testcases/archiveData.php',1618767203,1618767203,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(189,'/testlink/lib/testcases/archiveData.php',1618767286,1618767286,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(190,'/testlink/lib/testcases/listTestCases.php',1618767289,1618767289,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(191,'/testlink/lib/testcases/tcEdit.php',1618767295,1618767296,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(192,'/testlink/lib/testcases/tcEdit.php',1618767312,1618767312,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(193,'/testlink/lib/testcases/tcEdit.php',1618767327,1618767327,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(194,'/testlink/lib/testcases/tcEdit.php',1618767340,1618767340,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(195,'/testlink/lib/testcases/tcEdit.php',1618767429,1618767429,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(196,'/testlink/lib/testcases/tcEdit.php',1618767433,1618767433,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(197,'/testlink/lib/testcases/tcEdit.php',1618767435,1618767435,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(198,'/testlink/lib/testcases/tcEdit.php',1618767437,1618767437,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(199,'/testlink/lib/testcases/archiveData.php',1618767439,1618767439,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(200,'/testlink/lib/testcases/tcEdit.php',1618767443,1618767443,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(201,'/testlink/lib/testcases/tcEdit.php',1618767627,1618767627,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(202,'/testlink/lib/testcases/listTestCases.php',1618767632,1618767632,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(203,'/testlink/lib/testcases/tcEdit.php',1618767636,1618767636,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(204,'/testlink/lib/testcases/tcEdit.php',1618767653,1618767653,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(205,'/testlink/lib/testcases/tcEdit.php',1618767724,1618767724,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(206,'/testlink/lib/testcases/tcEdit.php',1618767732,1618767732,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(207,'/testlink/lib/testcases/listTestCases.php',1618769629,1618769629,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(208,'/testlink/lib/testcases/archiveData.php',1618769629,1618769629,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(209,'/testlink/lib/testcases/tcEdit.php',1618769661,1618769661,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(210,'/testlink/lib/testcases/tcEdit.php',1618769664,1618769664,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(211,'/testlink/lib/execute/execDashboard.php',1618769688,1618769688,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(212,'/testlink/lib/execute/execDashboard.php',1618769688,1618769688,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(213,'/testlink/lib/execute/execDashboard.php',1618769710,1618769710,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(214,'/testlink/lib/execute/execDashboard.php',1618769710,1618769710,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(215,'/testlink/lib/execute/execSetResults.php',1618769724,1618769724,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(216,'/testlink/lib/execute/execSetResults.php',1618769729,1618769729,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(217,'/testlink/lib/execute/execSetResults.php',1618769729,1618769729,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(218,'/testlink/lib/execute/execSetResults.php',1618769734,1618769734,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(219,'/testlink/lib/testcases/archiveData.php',1618769741,1618769741,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(220,'/testlink/lib/testcases/listTestCases.php',1618769741,1618769741,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(221,'/testlink/lib/testcases/tcEdit.php',1618769744,1618769744,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(222,'/testlink/lib/testcases/tcEdit.php',1618769758,1618769758,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(223,'/testlink/lib/testcases/tcEdit.php',1618769763,1618769763,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(224,'/testlink/lib/cfields/cfieldsEdit.php',1618780376,1618780376,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(225,'/testlink/lib/cfields/cfieldsEdit.php',1618780394,1618780394,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(226,'/testlink/lib/cfields/cfieldsEdit.php',1618780415,1618780415,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(227,'/testlink/lib/execute/execDashboard.php',1618780477,1618780477,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(228,'/testlink/lib/execute/execDashboard.php',1618780477,1618780477,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(229,'/testlink/lib/execute/execSetResults.php',1618780480,1618780480,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(230,'/testlink/lib/execute/execDashboard.php',1618780484,1618780484,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(231,'/testlink/lib/execute/execDashboard.php',1618780484,1618780484,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(232,'/testlink/lib/execute/execSetResults.php',1618780486,1618780486,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(233,'/testlink/lib/execute/execSetResults.php',1618780503,1618780503,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(234,'/testlink/lib/execute/execSetResults.php',1618780516,1618780516,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(235,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618780536,1618780536,1,''),(236,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618780545,1618780545,1,''),(237,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618780558,1618780558,1,''),(238,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618780636,1618780636,1,''),(239,'/testlink/lib/plan/planEdit.php',1618780663,1618780663,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(240,'/testlink/lib/testcases/listTestCases.php',1618780666,1618780666,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(241,'/testlink/lib/testcases/archiveData.php',1618780666,1618780666,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(242,'/testlink/lib/execute/execDashboard.php',1618780676,1618780676,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(243,'/testlink/lib/execute/execDashboard.php',1618780677,1618780677,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(244,'/testlink/lib/execute/execDashboard.php',1618780677,1618780677,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(245,'/testlink/lib/testcases/archiveData.php',1618780684,1618780684,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(246,'/testlink/lib/testcases/listTestCases.php',1618780684,1618780684,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(247,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1618782546,1618782546,1,''),(248,'/testlink/lib/execute/execDashboard.php',1618782556,1618782556,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(249,'/testlink/lib/execute/execDashboard.php',1618782556,1618782556,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(250,'/testlink/lib/testcases/listTestCases.php',1618782620,1618782620,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(251,'/testlink/lib/testcases/archiveData.php',1618782620,1618782620,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(252,'/testlink/lib/testcases/tcEdit.php',1618782637,1618782637,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(253,'/testlink/lib/testcases/listTestCases.php',1618782637,1618782637,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(254,'/testlink/lib/testcases/tcEdit.php',1618782650,1618782650,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(255,'/testlink/lib/testcases/listTestCases.php',1618782650,1618782650,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(256,'/testlink/lib/execute/execDashboard.php',1618782655,1618782655,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(257,'/testlink/lib/execute/execDashboard.php',1618782655,1618782655,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(258,'/testlink/lib/execute/execSetResults.php',1618782657,1618782657,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(259,'/testlink/lib/execute/execSetResults.php',1618782658,1618782658,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(260,'/testlink/lib/execute/execSetResults.php',1618782659,1618782659,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(261,'/testlink/lib/execute/execSetResults.php',1618782659,1618782659,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(262,'/testlink/lib/execute/execSetResults.php',1618782672,1618782672,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(263,'/testlink/lib/execute/execSetResults.php',1618782675,1618782675,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(264,'/testlink/lib/execute/execSetResults.php',1618782681,1618782681,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(265,'/testlink/lib/execute/execSetResults.php',1618782685,1618782685,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(266,'/testlink/lib/execute/execSetResults.php',1618782686,1618782686,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(267,'/testlink/lib/execute/execSetResults.php',1618782687,1618782687,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(268,'/testlink/lib/execute/execSetResults.php',1618782691,1618782691,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(269,'/testlink/lib/testcases/listTestCases.php',1618783871,1618783871,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(270,'/testlink/lib/testcases/archiveData.php',1618783871,1618783871,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(271,'/testlink/lib/testcases/archiveData.php',1618783879,1618783879,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(272,'/testlink/lib/testcases/listTestCases.php',1618783879,1618783879,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(273,'/testlink/lib/project/projectEdit.php',1618783956,1618783956,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(274,'/testlink/lib/testcases/listTestCases.php',1618784068,1618784068,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(275,'/testlink/lib/testcases/listTestCases.php',1618784098,1618784098,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(276,'/testlink/lib/testcases/archiveData.php',1618784098,1618784098,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(277,'/testlink/lib/testcases/listTestCases.php',1618784957,1618784957,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(278,'/testlink/lib/testcases/archiveData.php',1618784957,1618784957,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(279,'/testlink/lib/testcases/archiveData.php',1618785057,1618785057,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(280,'/testlink/lib/testcases/listTestCases.php',1618785057,1618785057,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(281,'/testlink/lib/testcases/listTestCases.php',1618786293,1618786293,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(282,'/testlink/lib/testcases/archiveData.php',1618786293,1618786293,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(283,'/testlink/lib/testcases/containerEdit.php',1618786386,1618786386,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(284,'/testlink/lib/testcases/archiveData.php',1618787455,1618787455,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(285,'/testlink/lib/testcases/archiveData.php',1618787471,1618787471,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(286,'/testlink/lib/testcases/listTestCases.php',1618787471,1618787471,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(287,'/testlink/lib/testcases/archiveData.php',1618787474,1618787474,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(288,'/testlink/lib/testcases/listTestCases.php',1618787474,1618787474,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(289,'/testlink/lib/execute/execDashboard.php',1618787489,1618787489,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(290,'/testlink/lib/execute/execDashboard.php',1618787489,1618787489,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(291,'/testlink/lib/project/projectEdit.php',1618787508,1618787508,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(292,'/testlink/lib/execute/execDashboard.php',1618787513,1618787513,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(293,'/testlink/lib/execute/execDashboard.php',1618787513,1618787513,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(294,'/testlink/lib/project/projectEdit.php',1618787526,1618787526,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(295,'/testlink/lib/testcases/archiveData.php',1618787532,1618787532,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(296,'/testlink/lib/testcases/listTestCases.php',1618787532,1618787532,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(297,'/testlink/lib/execute/execDashboard.php',1618787534,1618787534,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(298,'/testlink/lib/execute/execDashboard.php',1618787534,1618787534,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(299,'/testlink/lib/execute/execDashboard.php',1618787540,1618787540,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(300,'/testlink/lib/testcases/archiveData.php',1618787544,1618787544,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(301,'/testlink/lib/testcases/listTestCases.php',1618787544,1618787544,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(302,'/testlink/lib/testcases/listTestCases.php',1618787596,1618787596,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(303,'/testlink/lib/testcases/archiveData.php',1618787596,1618787596,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(304,'/testlink/lib/testcases/tcEdit.php',1618787616,1618787616,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(305,'/testlink/lib/testcases/listTestCases.php',1618787669,1618787669,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(306,'/testlink/lib/testcases/archiveData.php',1618787669,1618787669,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(307,'/testlink/lib/testcases/listTestCases.php',1619265400,1619265400,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(308,'/testlink/lib/testcases/archiveData.php',1619265400,1619265400,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(309,'/testlink/lib/testcases/tcEdit.php',1619265413,1619265413,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(310,'/testlink/lib/testcases/tcEdit.php',1619265487,1619265487,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(311,'/testlink/lib/testcases/listTestCases.php',1619265489,1619265489,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(312,'/testlink/lib/execute/execDashboard.php',1619294882,1619294882,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(313,'/testlink/lib/execute/execDashboard.php',1619294883,1619294883,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(314,'/testlink/lib/testcases/archiveData.php',1619294915,1619294915,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(315,'/testlink/lib/testcases/listTestCases.php',1619294915,1619294915,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(316,'/testlink/lib/testcases/tcEdit.php',1619294931,1619294931,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(317,'/testlink/lib/testcases/tcEdit.php',1619294944,1619294944,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(318,'/testlink/lib/testcases/listTestCases.php',1619294947,1619294947,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(319,'/testlink/lib/plan/planEdit.php',1619295001,1619295001,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(320,'/testlink/lib/plan/planEdit.php',1619295012,1619295012,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(321,'/testlink/lib/testcases/archiveData.php',1619295018,1619295018,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(322,'/testlink/lib/testcases/listTestCases.php',1619295018,1619295018,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(323,'/testlink/lib/testcases/tcEdit.php',1619295031,1619295031,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(324,'/testlink/lib/testcases/tcEdit.php',1619295041,1619295041,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(325,'/testlink/lib/testcases/listTestCases.php',1619295045,1619295045,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(326,'/testlink/lib/testcases/archiveData.php',1619295045,1619295045,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(327,'/testlink/lib/platforms/platformsView.php',1619295098,1619295098,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(328,'/testlink/lib/platforms/platformsEdit.php',1619295101,1619295101,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(329,'/testlink/lib/platforms/platformsView.php',1619295103,1619295103,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(330,'/testlink/lib/testcases/listTestCases.php',1619295105,1619295105,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(331,'/testlink/lib/testcases/archiveData.php',1619295105,1619295105,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(332,'/testlink/lib/plan/planAddTCNavigator.php',1619295190,1619295190,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(333,'/testlink/lib/plan/planAddTC.php',1619295193,1619295193,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(334,'/testlink/lib/execute/execDashboard.php',1619295197,1619295197,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(335,'/testlink/lib/execute/execDashboard.php',1619295197,1619295197,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(336,'/testlink/lib/plan/buildEdit.php',1619295421,1619295421,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(337,'/testlink/lib/platforms/platformsView.php',1619295445,1619295445,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(338,'/testlink/lib/platforms/platformsView.php',1619295448,1619295448,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(339,'/testlink/lib/platforms/platformsEdit.php',1619295450,1619295450,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(340,'/testlink/lib/platforms/platformsEdit.php',1619295523,1619295523,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(341,'/testlink/lib/platforms/platformsEdit.php',1619295528,1619295528,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(342,'/testlink/lib/platforms/platformsView.php',1619295560,1619295560,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(343,'/testlink/lib/testcases/listTestCases.php',1619298565,1619298565,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(344,'/testlink/lib/testcases/archiveData.php',1619298565,1619298565,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(345,'/testlink/lib/project/projectEdit.php',1619298577,1619298577,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(346,'/testlink/lib/requirements/reqSpecEdit.php',1619298583,1619298583,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(347,'/testlink/lib/requirements/reqSpecEdit.php',1619298793,1619298793,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(348,'/testlink/lib/requirements/reqEdit.php',1619298856,1619298856,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(349,'/testlink/lib/requirements/reqSpecEdit.php',1619298862,1619298862,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(350,'/testlink/lib/requirements/reqSpecEdit.php',1619298868,1619298869,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(351,'/testlink/lib/requirements/reqSpecEdit.php',1619298905,1619298906,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(352,'/testlink/lib/requirements/reqEdit.php',1619298941,1619298941,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(353,'/testlink/lib/requirements/reqEdit.php',1619299160,1619299160,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(354,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1619299603,1619299603,1,''),(355,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1619299642,1619299642,1,''),(356,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1619299655,1619299655,1,''),(357,'/testlink/lib/api/xmlrpc/v1/xmlrpc.php',1619299696,1619299696,1,''),(358,'/testlink/lib/requirements/reqEdit.php',1619299800,1619299800,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(359,'/testlink/lib/requirements/reqEdit.php',1619299817,1619299817,1,'a9d51d8e9m5sbpqkke0cttbjo2'),(360,'/testlink/lib/requirements/reqEdit.php',1619299836,1619299836,1,'a9d51d8e9m5sbpqkke0cttbjo2');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `tsuites_tree_depth_2`;
/*!50001 DROP VIEW IF EXISTS `tsuites_tree_depth_2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `tsuites_tree_depth_2` (
  `prefix` tinyint NOT NULL,
  `testproject_name` tinyint NOT NULL,
  `level1_name` tinyint NOT NULL,
  `level2_name` tinyint NOT NULL,
  `testproject_id` tinyint NOT NULL,
  `level1_id` tinyint NOT NULL,
  `level2_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `user_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_assignments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(10) unsigned NOT NULL DEFAULT 1,
  `feature_id` int(10) unsigned NOT NULL DEFAULT 0,
  `user_id` int(10) unsigned DEFAULT 0,
  `build_id` int(10) unsigned DEFAULT 0,
  `deadline_ts` datetime DEFAULT NULL,
  `assigner_id` int(10) unsigned DEFAULT 0,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(10) unsigned DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `user_assignments_feature_id` (`feature_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user_assignments` WRITE;
/*!40000 ALTER TABLE `user_assignments` DISABLE KEYS */;
INSERT INTO `user_assignments` VALUES (1,1,1,1,3,NULL,1,'2021-04-18 19:15:16',1),(2,1,3,1,2,NULL,1,'2021-04-18 19:51:12',1),(3,1,2,1,2,NULL,1,'2021-04-18 19:51:21',1);
/*!40000 ALTER TABLE `user_assignments` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_group` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `user_group_assign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group_assign` (
  `usergroup_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `idx_user_group_assign` (`usergroup_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user_group_assign` WRITE;
/*!40000 ALTER TABLE `user_group_assign` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group_assign` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `user_testplan_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_testplan_roles` (
  `user_id` int(10) NOT NULL DEFAULT 0,
  `testplan_id` int(10) NOT NULL DEFAULT 0,
  `role_id` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`,`testplan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user_testplan_roles` WRITE;
/*!40000 ALTER TABLE `user_testplan_roles` DISABLE KEYS */;
INSERT INTO `user_testplan_roles` VALUES (1,14,8),(1,15,8);
/*!40000 ALTER TABLE `user_testplan_roles` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `user_testproject_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_testproject_roles` (
  `user_id` int(10) NOT NULL DEFAULT 0,
  `testproject_id` int(10) NOT NULL DEFAULT 0,
  `role_id` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`,`testproject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user_testproject_roles` WRITE;
/*!40000 ALTER TABLE `user_testproject_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_testproject_roles` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `role_id` int(10) unsigned NOT NULL DEFAULT 0,
  `email` varchar(100) NOT NULL DEFAULT '',
  `first` varchar(50) NOT NULL DEFAULT '',
  `last` varchar(50) NOT NULL DEFAULT '',
  `locale` varchar(10) NOT NULL DEFAULT 'en_GB',
  `default_testproject_id` int(10) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `script_key` varchar(32) DEFAULT NULL,
  `cookie_string` varchar(64) NOT NULL DEFAULT '',
  `auth_method` varchar(10) DEFAULT '',
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `expiration_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_login` (`login`),
  UNIQUE KEY `users_cookie_string` (`cookie_string`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='User information';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2y$10$jn.Hm2NxE.CsxtvNDxybL.U.15Y/A3/J5CU46R0JE0Tbft1dYVfdm',8,'','Testlink','Administrator','en_GB',NULL,1,'a4795ab4fe140089c65e82985d20f663','70b5ae2e1f0513dc884132dc611315eba7eab664b08109ff9641ba656babcdef','','2021-04-17 17:11:08',NULL),(2,'Leader','$2y$10$dpSmz5ol9KnE8VdvWkMlDOqI7txXTzZi6MhOCAKKIqiHx0RN/ZWfq',9,'leader@testlink-xmlrpc.com','Leader','Testlink','es_ES',NULL,1,'8623eb015b5d5f90291a45ce83274cdc','bb054c74dfa2b755488eba53c9811659945a56bf58ea700461162edf8967be11','','2021-04-17 17:17:09',NULL),(3,'SeniorTester','$2y$10$dPXIDchYDgaWVVTjAqrtJeQMbwxVOfxpW.2FERxuTAUXPdk1CQQyq',6,'seniortester@testlink-xmlrpc.com','Senior Tester','Testlink','es_ES',NULL,1,NULL,'1844bf73de5206e108c88f001ad835afcbf5945cb27b4dfe4c680e641b310df0','','2021-04-17 17:17:28',NULL),(4,'TestDesigner','$2y$10$05L8nAzIxR9FaU78YanrRuT1uTCaKPsGvKB5W2xPkDk.k4XW3cM82',4,'testdesigner@testlink-xmlrpc.com','Test Designer','Testlink','es_ES',NULL,1,NULL,'48d96e63df029d96a7467eb3b4de6273d48fe38de3548a770822d6aa40ab27c8','','2021-04-17 17:18:06',NULL),(5,'Tester','$2y$10$Kery8v0uYXmmlsrfmYEDgOcNM9xDwXTcXavkm04V6XxuuyTPd6KhG',7,'tester@testlink-xmlrpc.com','Tester','Testlink','es_ES',NULL,1,NULL,'073112624582e9e1a776ec96285f167e62e27de20b83c22c39dd7eb04bcc3d4f','','2021-04-17 17:18:30',NULL),(6,'Guest','$2y$10$foGhtqGNYl8ozvVyOzCeQ.ZueGfVgB4NEl/WoLobCyqxRrfbUbMJi',5,'guest@testlink-xmlrpc.com','Guest','Testlink','es_ES',NULL,1,NULL,'301a8f27d000c13b40e4a6fb5f30c56059fc1b66a7c8f03ec9acbcb36524e0ba','','2021-04-17 17:18:53',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50001 DROP TABLE IF EXISTS `exec_by_date_time`*/;
/*!50001 DROP VIEW IF EXISTS `exec_by_date_time`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `exec_by_date_time` AS (select `NHTPL`.`name` AS `testplan_name`,date_format(`E`.`execution_ts`,'%Y-%m-%d') AS `yyyy_mm_dd`,date_format(`E`.`execution_ts`,'%Y-%m') AS `yyyy_mm`,date_format(`E`.`execution_ts`,'%H') AS `hh`,date_format(`E`.`execution_ts`,'%k') AS `hour`,`E`.`id` AS `id`,`E`.`build_id` AS `build_id`,`E`.`tester_id` AS `tester_id`,`E`.`execution_ts` AS `execution_ts`,`E`.`status` AS `status`,`E`.`testplan_id` AS `testplan_id`,`E`.`tcversion_id` AS `tcversion_id`,`E`.`tcversion_number` AS `tcversion_number`,`E`.`platform_id` AS `platform_id`,`E`.`execution_type` AS `execution_type`,`E`.`execution_duration` AS `execution_duration`,`E`.`notes` AS `notes` from ((`executions` `E` join `testplans` `TPL` on(`TPL`.`id` = `E`.`testplan_id`)) join `nodes_hierarchy` `NHTPL` on(`NHTPL`.`id` = `TPL`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `latest_exec_by_context`*/;
/*!50001 DROP VIEW IF EXISTS `latest_exec_by_context`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_exec_by_context` AS select `executions`.`tcversion_id` AS `tcversion_id`,`executions`.`testplan_id` AS `testplan_id`,`executions`.`build_id` AS `build_id`,`executions`.`platform_id` AS `platform_id`,max(`executions`.`id`) AS `id` from `executions` group by `executions`.`tcversion_id`,`executions`.`testplan_id`,`executions`.`build_id`,`executions`.`platform_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `latest_exec_by_testplan`*/;
/*!50001 DROP VIEW IF EXISTS `latest_exec_by_testplan`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_exec_by_testplan` AS select `executions`.`tcversion_id` AS `tcversion_id`,`executions`.`testplan_id` AS `testplan_id`,max(`executions`.`id`) AS `id` from `executions` group by `executions`.`tcversion_id`,`executions`.`testplan_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `latest_exec_by_testplan_plat`*/;
/*!50001 DROP VIEW IF EXISTS `latest_exec_by_testplan_plat`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_exec_by_testplan_plat` AS select `executions`.`tcversion_id` AS `tcversion_id`,`executions`.`testplan_id` AS `testplan_id`,`executions`.`platform_id` AS `platform_id`,max(`executions`.`id`) AS `id` from `executions` group by `executions`.`tcversion_id`,`executions`.`testplan_id`,`executions`.`platform_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `latest_req_version`*/;
/*!50001 DROP VIEW IF EXISTS `latest_req_version`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_req_version` AS select `RQ`.`id` AS `req_id`,max(`RQV`.`version`) AS `version` from ((`nodes_hierarchy` `NHRQV` join `requirements` `RQ` on(`RQ`.`id` = `NHRQV`.`parent_id`)) join `req_versions` `RQV` on(`RQV`.`id` = `NHRQV`.`id`)) group by `RQ`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `latest_req_version_id`*/;
/*!50001 DROP VIEW IF EXISTS `latest_req_version_id`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_req_version_id` AS select `LRQVN`.`req_id` AS `req_id`,`LRQVN`.`version` AS `version`,`REQV`.`id` AS `req_version_id` from ((`latest_req_version` `LRQVN` join `nodes_hierarchy` `NHRQV` on(`NHRQV`.`parent_id` = `LRQVN`.`req_id`)) join `req_versions` `REQV` on(`REQV`.`id` = `NHRQV`.`id` and `REQV`.`version` = `LRQVN`.`version`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `latest_rspec_revision`*/;
/*!50001 DROP VIEW IF EXISTS `latest_rspec_revision`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_rspec_revision` AS select `RSR`.`parent_id` AS `req_spec_id`,`RS`.`testproject_id` AS `testproject_id`,max(`RSR`.`revision`) AS `revision` from (`req_specs_revisions` `RSR` join `req_specs` `RS` on(`RS`.`id` = `RSR`.`parent_id`)) group by `RSR`.`parent_id`,`RS`.`testproject_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `latest_tcase_version_id`*/;
/*!50001 DROP VIEW IF EXISTS `latest_tcase_version_id`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_tcase_version_id` AS select `LTCVN`.`testcase_id` AS `testcase_id`,`LTCVN`.`version` AS `version`,`TCV`.`id` AS `tcversion_id` from ((`latest_tcase_version_number` `LTCVN` join `nodes_hierarchy` `NHTCV` on(`NHTCV`.`parent_id` = `LTCVN`.`testcase_id`)) join `tcversions` `TCV` on(`TCV`.`id` = `NHTCV`.`id` and `TCV`.`version` = `LTCVN`.`version`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `latest_tcase_version_number`*/;
/*!50001 DROP VIEW IF EXISTS `latest_tcase_version_number`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `latest_tcase_version_number` AS select `NH_TC`.`id` AS `testcase_id`,max(`TCV`.`version`) AS `version` from ((`nodes_hierarchy` `NH_TC` join `nodes_hierarchy` `NH_TCV` on(`NH_TCV`.`parent_id` = `NH_TC`.`id`)) join `tcversions` `TCV` on(`NH_TCV`.`id` = `TCV`.`id`)) group by `NH_TC`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `tcversions_without_keywords`*/;
/*!50001 DROP VIEW IF EXISTS `tcversions_without_keywords`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tcversions_without_keywords` AS select `NHTCV`.`parent_id` AS `testcase_id`,`NHTCV`.`id` AS `id` from `nodes_hierarchy` `NHTCV` where `NHTCV`.`node_type_id` = 4 and !exists(select 1 from `testcase_keywords` `TCK` where `TCK`.`tcversion_id` = `NHTCV`.`id` limit 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `tcversions_without_platforms`*/;
/*!50001 DROP VIEW IF EXISTS `tcversions_without_platforms`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tcversions_without_platforms` AS select `NHTCV`.`parent_id` AS `testcase_id`,`NHTCV`.`id` AS `id` from `nodes_hierarchy` `NHTCV` where `NHTCV`.`node_type_id` = 4 and !exists(select 1 from `testcase_platforms` `TCPL` where `TCPL`.`tcversion_id` = `NHTCV`.`id` limit 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `tsuites_tree_depth_2`*/;
/*!50001 DROP VIEW IF EXISTS `tsuites_tree_depth_2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tsuites_tree_depth_2` AS select `TPRJ`.`prefix` AS `prefix`,`NHTPRJ`.`name` AS `testproject_name`,`NHTS_L1`.`name` AS `level1_name`,`NHTS_L2`.`name` AS `level2_name`,`NHTPRJ`.`id` AS `testproject_id`,`NHTS_L1`.`id` AS `level1_id`,`NHTS_L2`.`id` AS `level2_id` from (((`testprojects` `TPRJ` join `nodes_hierarchy` `NHTPRJ` on(`TPRJ`.`id` = `NHTPRJ`.`id`)) left join `nodes_hierarchy` `NHTS_L1` on(`NHTS_L1`.`parent_id` = `NHTPRJ`.`id`)) left join `nodes_hierarchy` `NHTS_L2` on(`NHTS_L2`.`parent_id` = `NHTS_L1`.`id`)) where `NHTPRJ`.`node_type_id` = 1 and `NHTS_L1`.`node_type_id` = 2 and `NHTS_L2`.`node_type_id` = 2 */;
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

