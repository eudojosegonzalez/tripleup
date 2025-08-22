-- MariaDB dump 10.19  Distrib 10.11.4-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: b1
-- ------------------------------------------------------
-- Server version	10.11.4-MariaDB-1~deb12u1

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
-- Current Database: `b1`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `b1` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci */;

USE `b1`;

--
-- Table structure for table `AFP`
--

DROP TABLE IF EXISTS `AFP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AFP` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `codigo_previred` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `cotizacion` decimal(18,4) DEFAULT NULL,
  `cuenta_AFP` varchar(150) DEFAULT NULL,
  `sis` decimal(18,4) DEFAULT NULL,
  `cuenta_sis_cred` varchar(20) DEFAULT NULL,
  `cuenta_ahorro_AFP_cuenta2` varchar(150) DEFAULT NULL,
  `codigo_direccion_trabajo` varchar(10) DEFAULT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para almacenar las cuentas AFP';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AFP`
--

LOCK TABLES `AFP` WRITE;
/*!40000 ALTER TABLE `AFP` DISABLE KEYS */;
INSERT INTO `AFP` VALUES
(1,'08','PROVIDA',11.4500,'21050001',1.5400,'21050001','21050001','6','1990-01-01 00:00:00','2024-01-23 16:25:17',1,1),
(2,'03','Cuprum',11.4400,'21050001',1.5400,'21050001','21050001','13','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(3,'05','Habitat',11.2700,'21050001',1.5400,'21050001','21050001','14','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(4,'29','Plan Vital          ',11.1600,'21050001',1.5400,'21050001','21050001','11','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(5,'33','Capital',11.4400,'21050001',1.5400,'21050001','21050001','31','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(6,'34','Modelo',10.5800,'21050001',1.5400,'21050001','21050001','103','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(7,'00','No está en AFP',0.0000,'21050001',1.5400,'21050001','21050001','100','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(8,'35','Uno',10.6800,'21050001',1.5400,'21050001','21050001','19','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1);
/*!40000 ALTER TABLE `AFP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `APVInstituciones`
--

DROP TABLE IF EXISTS `APVInstituciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `APVInstituciones` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `nombre_largo` varchar(250) NOT NULL,
  `cuenta_contable` varchar(100) DEFAULT NULL,
  `codigo_externo` varchar(50) DEFAULT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para almacenar  las instituciones APV';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `APVInstituciones`
--

LOCK TABLES `APVInstituciones` WRITE;
/*!40000 ALTER TABLE `APVInstituciones` DISABLE KEYS */;
INSERT INTO `APVInstituciones` VALUES
(5,'HABITAT C','HABITAT','21050001','005','2024-01-29 01:00:00','2024-01-29 21:30:26',1,1),
(6,'HABITAT G','HABITAT G','21050001','006','2024-01-29 21:32:01','2024-01-29 21:32:01',1,1),
(1005,'Capital','Capital','21050001','033','2024-01-29 01:00:00','2024-01-29 01:00:00',1,1);
/*!40000 ALTER TABLE `APVInstituciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Alertas`
--

DROP TABLE IF EXISTS `Alertas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Alertas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  `Activa` tinyint(1) DEFAULT 0,
  `tipo_periodo` char(1) NOT NULL,
  `hora_envio` time DEFAULT NULL,
  `lunes` tinyint(1) DEFAULT 0,
  `martes` tinyint(1) DEFAULT 0,
  `miercoles` tinyint(1) DEFAULT 0,
  `jueves` tinyint(1) DEFAULT 0,
  `viernes` tinyint(1) DEFAULT 0,
  `sabado` tinyint(1) DEFAULT 0,
  `Ddomingo` tinyint(1) DEFAULT 0,
  `dia_mes` int(11) DEFAULT NULL,
  `destinatarios` text NOT NULL,
  `copia_destinatarios` text DEFAULT NULL,
  `p1` varchar(250) DEFAULT NULL,
  `descripcion_p1` varchar(250) DEFAULT NULL,
  `p2` varchar(250) DEFAULT NULL,
  `descripcion_p2` varchar(250) DEFAULT NULL,
  `consulta_reporte` text DEFAULT NULL,
  `p_texto` text DEFAULT NULL,
  `considerar_jefatura` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_Alertas` (`sociedad_id`),
  CONSTRAINT `FK_Sociedad_Alertas` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de Alertas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Alertas`
--

LOCK TABLES `Alertas` WRITE;
/*!40000 ALTER TABLE `Alertas` DISABLE KEYS */;
/*!40000 ALTER TABLE `Alertas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ArchivosUsuarios`
--

DROP TABLE IF EXISTS `ArchivosUsuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ArchivosUsuarios` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  `url` text NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Usuario_ArchivosUsuarios` (`user_id`),
  CONSTRAINT `FK_Usuario_ArchivosUsuarios` FOREIGN KEY (`user_id`) REFERENCES `Usuario` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de archivos de los usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ArchivosUsuarios`
--

LOCK TABLES `ArchivosUsuarios` WRITE;
/*!40000 ALTER TABLE `ArchivosUsuarios` DISABLE KEYS */;
INSERT INTO `ArchivosUsuarios` VALUES
(1,1,'Captura_de_pantalla_de_2023-07-08_19-20-0881372336-4833-4a68-8fae-8bea735475bb.png','/files_users/Captura_de_pantalla_de_2023-07-08_19-20-0881372336-4833-4a68-8fae-8bea735475bb.png','2023-12-27 15:50:57','2023-12-27 15:50:57',1,1),
(2,1,'Captura_de_pantalla_de_2023-07-08_19-20-0836c7248f-81ab-4522-81ec-53a98af0612d.png','/files_users/Captura_de_pantalla_de_2023-07-08_19-20-0836c7248f-81ab-4522-81ec-53a98af0612d.png','2023-12-27 16:02:33','2023-12-27 16:02:33',1,1),
(3,43,'Captura_de_pantalla_de_2023-07-21_20-22-3476eadb5c-d541-4226-b24b-595c6582e371.png','/files_users/Captura_de_pantalla_de_2023-07-21_20-22-3476eadb5c-d541-4226-b24b-595c6582e371.png','2023-12-27 16:33:13','2023-12-27 16:33:13',1,1),
(4,43,'Captura_de_pantalla_de_2023-07-28_22-07-41499a4f41-d5cb-4919-a1dd-effaba2b248e.png','/files_users/Captura_de_pantalla_de_2023-07-28_22-07-41499a4f41-d5cb-4919-a1dd-effaba2b248e.png','2023-12-27 16:47:14','2023-12-27 16:47:14',1,1),
(5,1,'Captura_de_pantalla_de_2023-07-28_22-07-41a70f61d1-1e47-4e00-b10c-9c059789a7b8.png','/files_users/Captura_de_pantalla_de_2023-07-28_22-07-41a70f61d1-1e47-4e00-b10c-9c059789a7b8.png','2023-12-27 21:26:03','2023-12-27 21:26:03',1,1),
(6,1,'Captura_de_pantalla_de_2023-07-28_22-07-41f86a6fe6-0141-4d40-a6ca-410113cb00d7.png','/files_users/Captura_de_pantalla_de_2023-07-28_22-07-41f86a6fe6-0141-4d40-a6ca-410113cb00d7.png','2023-12-27 21:26:50','2023-12-27 21:26:50',1,1),
(7,1,'Captura_de_pantalla_de_2023-07-11_10-39-26dc8ed4b3-8892-4c10-8c37-8a893a782c03.png','/files_users/Captura_de_pantalla_de_2023-07-11_10-39-26dc8ed4b3-8892-4c10-8c37-8a893a782c03.png','2024-01-02 16:19:13','2024-01-02 16:19:13',1,1);
/*!40000 ALTER TABLE `ArchivosUsuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BancariosUser`
--

DROP TABLE IF EXISTS `BancariosUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BancariosUser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `banco_id` bigint(20) NOT NULL,
  `numero_cuenta` varchar(100) NOT NULL,
  `en_uso` tinyint(1) NOT NULL,
  `terceros` tinyint(1) NOT NULL,
  `rut_tercero` varchar(100) DEFAULT NULL,
  `nombre_tercero` varchar(100) DEFAULT NULL,
  `email_tercero` varchar(250) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Usuario_BancariosUsuario` (`user_id`),
  KEY `FK_Bancos_BancariosUsuario` (`banco_id`),
  CONSTRAINT `FK_Bancos_BancariosUsuario` FOREIGN KEY (`banco_id`) REFERENCES `Bancos` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Usuario_BancariosUsuario` FOREIGN KEY (`user_id`) REFERENCES `Usuario` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de datos bancarios de pagos del usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BancariosUser`
--

LOCK TABLES `BancariosUser` WRITE;
/*!40000 ALTER TABLE `BancariosUser` DISABLE KEYS */;
INSERT INTO `BancariosUser` VALUES
(1,1,1,'18800023158',1,1,'1','Sergio Rivas','example@micorreo.com','2024-01-23 13:51:57','2024-01-23 13:51:57',1,1),
(2,43,1,'18800023158',1,1,'26337084-8','Sergio Rivas d','example@micorreo.com','2024-01-23 14:47:27','2024-01-23 14:47:27',1,1);
/*!40000 ALTER TABLE `BancariosUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Bancos`
--

DROP TABLE IF EXISTS `Bancos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Bancos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `nomina` tinyint(1) NOT NULL COMMENT '0 No genera Nomina 1 Genera Nomina',
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar los diferentes bancos en el sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bancos`
--

LOCK TABLES `Bancos` WRITE;
/*!40000 ALTER TABLE `Bancos` DISABLE KEYS */;
INSERT INTO `Bancos` VALUES
(1,'001','BANCO CHILE Y EDWARDS',1,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(2,'009','BANCO INTERNACIONAL',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(3,'011','DRESDNER BANK LATINOAMERICA',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(4,'012','ESTADO',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(5,'014','SCOTIABANK',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(6,'016','BANCO DE CREDITOS E INVERSIONES ',1,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(7,'017','BANCO DO BRASIL S.A.',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(8,'027','CORP BANCA',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(9,'028','BANCO BICE',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(10,'029','BANCO DE A. EDWARDS',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(11,'031','HSBC BANK CHILE',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(12,'032','BANK OF AMERICA, NATIONAL ASSOCIATION',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(13,'033','BANCO CITIBANK N.A.',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(14,'036','BANCO DO ESTADO DE SAO PAULO',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(15,'037','BANCO SANTANDER',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(16,'039','BANCO ITAU',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(17,'040','BANCO SUDAMERIS',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(18,'041','JP MORGAN CHASE BANK',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(19,'043','BANCO DE LA NACION ARGENTINA',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(20,'045','THE BANK OF TOKYO- MITSUBISHI UFJ, LTD.',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(21,'046','ABN AMRO BANK (CHILE)',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(22,'049','BANCO SECURITY',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(23,'051','BANCO FALABELLA',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(24,'052','DEUTSCHE BANK (CHILE)',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(25,'053','BANCO RIPLEY',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(26,'054','HNS BANCO',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(27,'055','BANCO MONEX',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(28,'056','BANCO PENTA',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(29,'057','BANCO PARIS',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(30,'504','(BBVA) BANCO BILBAO VIZCAYA ARGENTARIA, CHILE',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(31,'507','BANCO DEL DESARROLLO',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(32,'671','COOCRETAL',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(33,'672','COOPEUCH',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(34,'734','BANCO CONOSUR',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(35,'800','SANTANDER-STGO',0,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1);
/*!40000 ALTER TABLE `Bancos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CajasCompesacion`
--

DROP TABLE IF EXISTS `CajasCompesacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CajasCompesacion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `codigo_externo` varchar(50) NOT NULL,
  `cuenta_contable` varchar(50) NOT NULL,
  `codigo_direccion_trabajo` varchar(10) DEFAULT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlarlar las las cajas de compensacion';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CajasCompesacion`
--

LOCK TABLES `CajasCompesacion` WRITE;
/*!40000 ALTER TABLE `CajasCompesacion` DISABLE KEYS */;
INSERT INTO `CajasCompesacion` VALUES
(1,'Sin CCAF','00','21050003','0','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(2,'Los Andes','01','21050003','1','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(3,'La Araucana','02','21050003','2','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(4,'Los Héroes','03','21050003','3','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(5,'Gabriela Mistral','05','21050003',NULL,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(6,'18 de Septiembre','06','21050003','4','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1);
/*!40000 ALTER TABLE `CajasCompesacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cargos`
--

DROP TABLE IF EXISTS `Cargos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cargos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar los datos de los cargos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cargos`
--

LOCK TABLES `Cargos` WRITE;
/*!40000 ALTER TABLE `Cargos` DISABLE KEYS */;
INSERT INTO `Cargos` VALUES
(1,'CARGO DEMO','2024-02-04 19:35:09','2024-02-04 19:37:15',1,1),
(2,'EJECUTIVO DE INFORMACION','2024-02-01 01:01:00','2024-02-01 01:01:00',1,1),
(3,'TEAM LEADER','2024-02-01 01:01:00','2024-02-01 01:01:00',1,1),
(4,'TO','2024-02-01 01:01:00','2024-02-01 01:01:00',1,1),
(5,'Soporte','2024-02-01 01:01:00','2024-02-01 01:01:00',1,1),
(6,'EJECUTIVA DE INFORMACION','2024-02-01 01:01:00','2024-02-01 01:01:00',1,1),
(7,'MONITOR DE CALIDAD ','2024-02-01 01:01:00','2024-02-01 01:01:00',1,1),
(8,'ANALISTA DE DESARROLLO JUNIOR ','2024-02-01 01:01:00','2024-02-01 01:01:00',1,1),
(9,'SUB GERENTE DE OPERACIONES','2024-02-01 01:01:00','2024-02-01 01:01:00',1,1),
(10,'SUPERVISOR DE PLATAFORMA ','2024-02-01 01:01:00','2024-02-01 01:01:00',1,1);
/*!40000 ALTER TABLE `Cargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CargosUsuario`
--

DROP TABLE IF EXISTS `CargosUsuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CargosUsuario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) DEFAULT NULL,
  `sede_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `cargo_id` bigint(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Cargos_CargosUsuario` (`cargo_id`),
  KEY `FK_Sociedad_CargosUsuarios` (`sociedad_id`),
  KEY `FK_Usuario_CargosUsuario` (`user_id`),
  KEY `FK_Sede_CargosUsuario` (`sede_id`),
  CONSTRAINT `FK_Cargos_CargosUsuario` FOREIGN KEY (`cargo_id`) REFERENCES `Cargos` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Sede_CargosUsuario` FOREIGN KEY (`sede_id`) REFERENCES `Sede` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Sociedad_CargosUsuarios` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Usuario_CargosUsuario` FOREIGN KEY (`user_id`) REFERENCES `Usuario` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de datos  cargos del usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CargosUsuario`
--

LOCK TABLES `CargosUsuario` WRITE;
/*!40000 ALTER TABLE `CargosUsuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `CargosUsuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Centralizaciones`
--

DROP TABLE IF EXISTS `Centralizaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Centralizaciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `usa_centros_costos` tinyint(1) NOT NULL,
  `cuenta_anticipo` varchar(50) DEFAULT NULL,
  `cuenta_bonos_feriado` varchar(50) DEFAULT NULL,
  `cuenta_honoraios` varchar(50) DEFAULT NULL,
  `cuenta_prestamos_solidarios` varchar(50) DEFAULT NULL,
  `prestamo_solidario_imponible` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_Centralizaciones` (`sociedad_id`),
  CONSTRAINT `FK_Sociedad_Centralizaciones` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlarlas centralizaciones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Centralizaciones`
--

LOCK TABLES `Centralizaciones` WRITE;
/*!40000 ALTER TABLE `Centralizaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `Centralizaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CentrosDeCostos`
--

DROP TABLE IF EXISTS `CentrosDeCostos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CentrosDeCostos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `codigo_sap` varchar(50) DEFAULT NULL,
  `centro_costo` varchar(200) DEFAULT NULL,
  `dimension_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_CentrosDeCostos` (`sociedad_id`),
  CONSTRAINT `FK_Sociedad_CentrosDeCostos` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de Centros de costos, basicamente usado para conectarse a los ERP';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CentrosDeCostos`
--

LOCK TABLES `CentrosDeCostos` WRITE;
/*!40000 ALTER TABLE `CentrosDeCostos` DISABLE KEYS */;
/*!40000 ALTER TABLE `CentrosDeCostos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Comunas`
--

DROP TABLE IF EXISTS `Comunas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Comunas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `region_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Region_Comuna` (`region_id`),
  CONSTRAINT `FK_Region_Comuna` FOREIGN KEY (`region_id`) REFERENCES `Regiones` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15203 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para almacenar la información geográfica de las Comunas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Comunas`
--

LOCK TABLES `Comunas` WRITE;
/*!40000 ALTER TABLE `Comunas` DISABLE KEYS */;
INSERT INTO `Comunas` VALUES
(1101,'Iquique',1),
(1107,'Alto Hospicio',1),
(1401,'Pozo Almonte',1),
(1402,'Camiña',1),
(1403,'Colchane',1),
(1404,'Huara',1),
(1405,'Pica',1),
(2101,'Antofagasta',2),
(2102,'Mejillones',2),
(2103,'Sierra Gorda',2),
(2104,'Taltal',2),
(2201,'Calama',2),
(2202,'Ollagüe',2),
(2203,'San Pedro de Atacama',2),
(2301,'Tocopilla',2),
(2302,'María Elena',2),
(3101,'Copiapó',3),
(3102,'Caldera',3),
(3103,'Tierra Amarilla',3),
(3201,'Chañaral',3),
(3202,'Diego de Almagro',3),
(3301,'Vallenar',3),
(3302,'Alto del Carmen',3),
(3303,'Freirina',3),
(3304,'Huasco',3),
(4101,'La Serena',4),
(4102,'Coquimbo',4),
(4103,'Andacollo',4),
(4104,'La Higuera',4),
(4105,'Paiguano',4),
(4106,'Vicuña',4),
(4201,'Illapel',4),
(4202,'Canela',4),
(4203,'Los Vilos',4),
(4204,'Salamanca',4),
(4301,'Ovalle',4),
(4302,'Combarbalá',4),
(4303,'Monte Patria',4),
(4304,'Punitaqui',4),
(4305,'Río Hurtado',4),
(5101,'Valparaíso',5),
(5102,'Casablanca',5),
(5103,'Concón',5),
(5104,'Juan Fernández',5),
(5105,'Puchuncaví',5),
(5107,'Quintero',5),
(5109,'Viña del Mar',5),
(5201,'Isla de Pascua',5),
(5301,'Los Andes',5),
(5302,'Calle Larga',5),
(5303,'Rinconada',5),
(5304,'San Esteban',5),
(5401,'La Ligua',5),
(5402,'Cabildo',5),
(5403,'Papudo',5),
(5404,'Petorca',5),
(5405,'Zapallar',5),
(5501,'Quillota',5),
(5502,'Calera',5),
(5503,'Hijuelas',5),
(5504,'La Cruz',5),
(5506,'Nogales',5),
(5601,'San Antonio',5),
(5602,'Algarrobo',5),
(5603,'Cartagena',5),
(5604,'El Quisco',5),
(5605,'El Tabo',5),
(5606,'Santo Domingo',5),
(5701,'San Felipe',5),
(5702,'Catemu',5),
(5703,'Llaillay',5),
(5704,'Panquehue',5),
(5705,'Putaendo',5),
(5706,'Santa María',5),
(5801,'Quilpué',5),
(5802,'Limache',5),
(5803,'Olmué',5),
(5804,'Villa Alemana',5),
(6101,'Rancagua',6),
(6102,'Codegua',6),
(6103,'Coinco',6),
(6104,'Coltauco',6),
(6105,'Doñihue',6),
(6106,'Graneros',6),
(6107,'Las Cabras',6),
(6108,'Machalí',6),
(6109,'Malloa',6),
(6110,'Mostazal',6),
(6111,'Olivar',6),
(6112,'Peumo',6),
(6113,'Pichidegua',6),
(6114,'Quinta de Tilcoco',6),
(6115,'Rengo',6),
(6116,'Requínoa',6),
(6117,'San Vicente',6),
(6201,'Pichilemu',6),
(6202,'La Estrella',6),
(6203,'Litueche',6),
(6204,'Marchihue',6),
(6205,'Navidad',6),
(6206,'Paredones',6),
(6301,'San Fernando',6),
(6302,'Chépica',6),
(6303,'Chimbarongo',6),
(6304,'Lolol',6),
(6305,'Nancagua',6),
(6306,'Palmilla',6),
(6307,'Peralillo',6),
(6308,'Placilla',6),
(6309,'Pumanque',6),
(6310,'Santa Cruz',6),
(7101,'Talca',7),
(7102,'Constitución',7),
(7103,'Curepto',7),
(7104,'Empedrado',7),
(7105,'Maule',7),
(7106,'Pelarco',7),
(7107,'Pencahue',7),
(7108,'Río Claro',7),
(7109,'San Clemente',7),
(7110,'San Rafael',7),
(7201,'Cauquenes',7),
(7202,'Chanco',7),
(7203,'Pelluhue',7),
(7301,'Curicó',7),
(7302,'Hualañé',7),
(7303,'Licantén',7),
(7304,'Molina',7),
(7305,'Rauco',7),
(7306,'Romeral',7),
(7307,'Sagrada Familia',7),
(7308,'Teno',7),
(7309,'Vichuquén',7),
(7401,'Linares',7),
(7402,'Colbún',7),
(7403,'Longaví',7),
(7404,'Parral',7),
(7405,'Retiro',7),
(7406,'San Javier',7),
(7407,'Villa Alegre',7),
(7408,'Yerbas Buenas',7),
(8101,'Concepción',8),
(8102,'Coronel',8),
(8103,'Chiguayante',8),
(8104,'Florida',8),
(8105,'Hualqui',8),
(8106,'Lota',8),
(8107,'Penco',8),
(8108,'San Pedro de la Paz',8),
(8109,'Santa Juana',8),
(8110,'Talcahuano',8),
(8111,'Tomé',8),
(8112,'Hualpén',8),
(8201,'Lebu',8),
(8202,'Arauco',8),
(8203,'Cañete',8),
(8204,'Contulmo',8),
(8205,'Curanilahue',8),
(8206,'Los Álamos',8),
(8207,'Tirúa',8),
(8301,'Los Ángeles',8),
(8302,'Antuco',8),
(8303,'Cabrero',8),
(8304,'Laja',8),
(8305,'Mulchén',8),
(8306,'Nacimiento',8),
(8307,'Negrete',8),
(8308,'Quilaco',8),
(8309,'Quilleco',8),
(8310,'San Rosendo',8),
(8311,'Santa Bárbara',8),
(8312,'Tucapel',8),
(8313,'Yumbel',8),
(8314,'Alto Biobío',8),
(8401,'Chillán',8),
(8402,'Bulnes',8),
(8403,'Cobquecura',8),
(8404,'Coelemu',8),
(8405,'Coihueco',8),
(8406,'Chillán Viejo',8),
(8407,'El Carmen',8),
(8408,'Ninhue',8),
(8409,'Ñiquén',8),
(8410,'Pemuco',8),
(8411,'Pinto',8),
(8412,'Portezuelo',8),
(8413,'Quillón',8),
(8414,'Quirihue',8),
(8415,'Ránquil',8),
(8416,'San Carlos',8),
(8417,'San Fabián',8),
(8418,'San Ignacio',8),
(8419,'San Nicolás',8),
(8420,'Treguaco',8),
(8421,'Yungay',8),
(9101,'Temuco',9),
(9102,'Carahue',9),
(9103,'Cunco',9),
(9104,'Curarrehue',9),
(9105,'Freire',9),
(9106,'Galvarino',9),
(9107,'Gorbea',9),
(9108,'Lautaro',9),
(9109,'Loncoche',9),
(9110,'Melipeuco',9),
(9111,'Nueva Imperial',9),
(9112,'Padre Las Casas',9),
(9113,'Perquenco',9),
(9114,'Pitrufquén',9),
(9115,'Pucón',9),
(9116,'Saavedra',9),
(9117,'Teodoro Schmidt',9),
(9118,'Toltén',9),
(9119,'Vilcún',9),
(9120,'Villarrica',9),
(9121,'Cholchol',9),
(9201,'Angol',9),
(9202,'Collipulli',9),
(9203,'Curacautín',9),
(9204,'Ercilla',9),
(9205,'Lonquimay',9),
(9206,'Los Sauces',9),
(9207,'Lumaco',9),
(9208,'Purén',9),
(9209,'Renaico',9),
(9210,'Traiguén',9),
(9211,'Victoria',9),
(10101,'Puerto Montt',10),
(10102,'Calbuco',10),
(10103,'Cochamó',10),
(10104,'Fresia',10),
(10105,'Frutillar',10),
(10106,'Los Muermos',10),
(10107,'Llanquihue',10),
(10108,'Maullín',10),
(10109,'Puerto Varas',10),
(10201,'Castro',10),
(10202,'Ancud',10),
(10203,'Chonchi',10),
(10204,'Curaco de Vélez',10),
(10205,'Dalcahue',10),
(10206,'Puqueldón',10),
(10207,'Queilén',10),
(10208,'Quellón',10),
(10209,'Quemchi',10),
(10210,'Quinchao',10),
(10301,'Osorno',10),
(10302,'Puerto Octay',10),
(10303,'Purranque',10),
(10304,'Puyehue',10),
(10305,'Río Negro',10),
(10306,'San Juan de la Costa',10),
(10307,'San Pablo',10),
(10401,'Chaitén',10),
(10402,'Futaleufú',10),
(10403,'Hualaihué',10),
(10404,'Palena',10),
(11101,'Coyhaique',11),
(11102,'Lago Verde',11),
(11201,'Aysén',11),
(11202,'Cisnes',11),
(11203,'Guaitecas',11),
(11301,'Cochrane',11),
(11302,'O’Higgins',11),
(11303,'Tortel',11),
(11401,'Chile Chico',11),
(11402,'Río Ibáñez',11),
(12101,'Punta Arenas',12),
(12102,'Laguna Blanca',12),
(12103,'Río Verde',12),
(12104,'San Gregorio',12),
(12201,'Cabo de Hornos (Ex - Navarino)',12),
(12202,'Antártica',12),
(12301,'Porvenir',12),
(12302,'Primavera',12),
(12303,'Timaukel',12),
(12401,'Natales',12),
(12402,'Torres del Paine',12),
(13101,'Santiago',13),
(13102,'Cerrillos',13),
(13103,'Cerro Navia',13),
(13104,'Conchalí',13),
(13105,'El Bosque',13),
(13106,'Estación Central',13),
(13107,'Huechuraba',13),
(13108,'Independencia',13),
(13109,'La Cisterna',13),
(13110,'La Florida',13),
(13111,'La Granja',13),
(13112,'La Pintana',13),
(13113,'La Reina',13),
(13114,'Las Condes',13),
(13115,'Lo Barnechea',13),
(13116,'Lo Espejo',13),
(13117,'Lo Prado',13),
(13118,'Macul',13),
(13119,'Maipú',13),
(13120,'Ñuñoa',13),
(13121,'Pedro Aguirre Cerda',13),
(13122,'Peñalolén',13),
(13123,'Providencia',13),
(13124,'Pudahuel',13),
(13125,'Quilicura',13),
(13126,'Quinta Normal',13),
(13127,'Recoleta',13),
(13128,'Renca',13),
(13129,'San Joaquín',13),
(13130,'San Miguel',13),
(13131,'San Ramón',13),
(13132,'Vitacura',13),
(13201,'Puente Alto',13),
(13202,'Pirque',13),
(13203,'San José de Maipo',13),
(13301,'Colina',13),
(13302,'Lampa ',13),
(13303,'Tiltil',13),
(13401,'San Bernardo',13),
(13402,'Buin',13),
(13403,'Calera de Tango',13),
(13404,'Paine',13),
(13501,'Melipilla',13),
(13502,'Alhué',13),
(13503,'Curacaví',13),
(13504,'María Pinto',13),
(13505,'San Pedro',13),
(13601,'Talagante',13),
(13602,'El Monte',13),
(13603,'Isla de Maipo',13),
(13604,'Padre Hurtado',13),
(13605,'Peñaflor',13),
(14101,'Valdivia',14),
(14102,'Corral',14),
(14103,'Lanco',14),
(14104,'Los Lagos',14),
(14105,'Máfil',14),
(14106,'Mariquina',14),
(14107,'Paillaco',14),
(14108,'Panguipulli',14),
(14201,'La Unión',14),
(14202,'Futrono',14),
(14203,'Lago Ranco',14),
(14204,'Río Bueno',14),
(15101,'Arica',15),
(15102,'Camarones',15),
(15201,'Putre',15),
(15202,'General Lagos',15);
/*!40000 ALTER TABLE `Comunas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ConceptosEventos`
--

DROP TABLE IF EXISTS `ConceptosEventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ConceptosEventos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `activo` tinyint(1) NOT NULL COMMENT '0 Inactivo 1 Activo',
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_ConceptosEventos` (`sociedad_id`),
  CONSTRAINT `FK_Sociedad_ConceptosEventos` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar los conceptos descriptivos de los eventos en el sistema de nomina';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ConceptosEventos`
--

LOCK TABLES `ConceptosEventos` WRITE;
/*!40000 ALTER TABLE `ConceptosEventos` DISABLE KEYS */;
/*!40000 ALTER TABLE `ConceptosEventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Configuraciones`
--

DROP TABLE IF EXISTS `Configuraciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Configuraciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `valor` decimal(18,4) NOT NULL,
  `detalle` text DEFAULT NULL,
  `cuenta` varchar(20) DEFAULT NULL,
  `categoria` varchar(250) DEFAULT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  `ocultar` bit(1) NOT NULL DEFAULT b'0',
  `tipo_validacion` varchar(30) DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_Configuraciones` (`sociedad_id`),
  CONSTRAINT `FK_Sociedad_Configuraciones` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlarla los datos de la empresa (sociedades)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Configuraciones`
--

LOCK TABLES `Configuraciones` WRITE;
/*!40000 ALTER TABLE `Configuraciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `Configuraciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Contacto`
--

DROP TABLE IF EXISTS `Contacto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Contacto` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `fijo` varchar(20) DEFAULT NULL,
  `movil` varchar(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Usuario_Contacto` (`user_id`),
  CONSTRAINT `FK_Usuario_Contacto` FOREIGN KEY (`user_id`) REFERENCES `Usuario` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=309 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de contacto de los usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contacto`
--

LOCK TABLES `Contacto` WRITE;
/*!40000 ALTER TABLE `Contacto` DISABLE KEYS */;
INSERT INTO `Contacto` VALUES
(1,43,'example@micorreo.com','226656168','939024766','1990-01-01 00:00:00','2024-01-04 18:16:41',1,43),
(2,44,'alex.baeza@2callcenter.cl','','961885249','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(3,45,'fanny.laprea@2callcenter.cl','','','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(4,46,'pamela.carrasco@2callcenter.cl','','979634637','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(5,47,'lilarequenam@gmail.com','','967547436','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(6,48,'macarena.bustamante@2callcenter.cl','','982307973','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(7,49,'gonzalo.vergara@2callcenter.cl','','964836387','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(8,50,'July.mendez@2callcenter.cl','','994466252','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(9,51,'danielampperez@gmail.com','','985859841','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(10,52,'Osmar.barrios@2callcenter.cl','','999389352','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(11,53,'jonathan.lara@2callcenter.cl','','966984751','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(12,54,'danitza.itziar@gmail.com','','978333754','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(13,55,'francisco.leon@2callcenter.cl','','953552825','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(14,56,'alba.cardenas@2callcenter.cl','','951036635','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(15,57,'priscila.loyola@2callcenter.cl','','950404725','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(16,58,'Gabriela.torres@2callcenter.cl','',' 950837508','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(17,59,'rebekmoraz@gmail.com','','972415080','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(18,60,'jessica.acosta@2callcenter.cl','','984121091','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(19,61,'jonathan.hernandez@2callcenter.cl','','974369395','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(20,62,'ctillemann@2callcenter.cl','','946968200','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(21,63,'barbara.romero@2callcenter.cl','','993136947','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(22,64,'vlizcano24@gmail.com','','999885021','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(23,65,'desiree.uranga@2callcenter.cl','','946150245','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(24,66,'danny.araya@gmail.com','','982242683','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(25,67,'dimna.pereira@2callcenter.cl','','998922389','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(26,68,'nayareth.ballesteros@2callcenter.cl','','948585955','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(27,69,'ADRIAN@2CALL.CL','','942209822','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(28,70,'karina.gonzalez@2callcenter.cl','','920612645','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(29,71,'rossana.russo@2callcenter.cl','','938924646','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(30,72,'angelicaloaiza36@gmail.com','','956301509','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(31,73,'josefina.villavicencio@2callcenter.cl','226656168','939024766','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(32,74,'dairelis.escalona@2callcenter.cl','','972397577','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(33,75,'thaila.contreras@2callcenter.cl','','933050668','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(34,76,'mariojosemedinaperez@gmail.com','','937635371','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(35,77,'prueba27@apolo.cl','','942991852','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(36,78,'camila.martinez@2callcenter.cl','','973961186','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(37,79,'paulina.palominos@2callcenter.cl','','950725547','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(38,80,'mari.suarez@2callcenter.cl','','935570664','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(39,81,'ronjevire@gmail.com','','978818858','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(40,82,'kevin.pizarro@2callcenter.cl','','949752257','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(41,83,'scarlett.penno@2callcenter.cl','','953331935','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(42,84,'marcela.medina@2callcenter.cl','','982637319','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(43,85,'fanny.gonzalez@2callcenter.cl','','983819393','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(44,86,'johannalexandra.mendez@gmail.com','','990621297','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(45,87,'karina.sanchez@callcenter.cl','223299816','991028590','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(46,88,'mvaleria18@gmail.com','','936484854','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(47,89,'zoradorantes@gmail.com','','937291750','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(48,90,'mileizy.alvarado@2callcenter.cl','','976371250','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(49,91,'kunya.cardenas@2callcenter.cl','','972729631','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(50,92,'Ormaglys.rodulfo@2callcenter.cl','','947783686','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(51,93,'fabiola.lopez@2callcenter.cl','','933693950','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(52,94,'Joinerlevi7@gmail.com','','930138631','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(53,95,'petra.garcia@2callcenter.cl','','936721331','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(54,96,'ivan.perez.abrigo@gmail.com','','991236404','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(55,97,'francisca.encina@2callcenter.cl','','984589181','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(56,98,'beatriz.chavez@2callcenter.cl','','963893893','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(57,99,'gloria.riquelme@2call.cl','','932223338','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(58,100,'valentina.castro@2callcenter.cl','','930542965','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(59,101,'farayaaraneda@hotmail.com','','953938994','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(60,102,'scarv2218@gmail.com','','950146474','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(61,103,'prueba10@apolo.cl','','940631163','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(62,104,'wisbely.sanchez@2callcenter.cl','','931460093','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(63,105,'miguelherwittesepulveda@gmail.com','','957850334','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(64,106,'pia.aguilar@2callcenter.cl','','988302029','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(65,107,'teddysurdaneta@gmail.com','','949694218','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(66,108,'yasmatroco@gmail.com','','936796868','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(67,109,'diego.cifuentes@2callcenter.cl','','920390213','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(68,110,'emily.infante@2callcenter.cl','','941336651 ','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(69,111,'kendra.araneda@2callcenter.cl','','993496945','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(70,112,'samai.aguillon@2callcenter.cl','','959152188','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(71,113,'militza.lopez@2callcenter.cl','','972112006','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(72,114,'andrea.acevedo@2callcenter.cl','','996219593','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(73,115,'laura.duarte@2callcenter.cl','','957796606','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(74,116,'viviana.diaz@2call.cl','','930841255','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(75,117,'maria.leon@2callcenter.cl','','991421880','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(76,118,'lorena.alegria@2callcenter.cl','','958146705','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(77,119,'emmanuel.perez@2callcenter.cl','','951945248','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(78,120,'daniel.alarcon@2callcenter.cl','','936821146','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(79,121,'andreatorrealba1999@gmail.com','','955295363','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(80,122,'dorismelendez120@yahoo.com','','920533674','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(81,123,'esteban-araneda@hotmail.com','','982200356','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(82,124,'angel.ortega@2callcenter.cl','','941135125','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(83,125,'paulina.galleguillos@2callcenter.cl','','936771857','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(84,126,'lyeh.accesorios2806@gmail.com','','937353760','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(85,127,'francisco.carrillo@2callcenter.cl','','940448236','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(86,128,'tiare.baeza@2callcenter.cl','','959657560','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(87,129,'josue.barros@2callcenter.cl','','961533751','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(88,130,'maria.magdeley@2call.cl','','940493594','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(89,131,'carolina.farias@2callcenter.cl','','988897223','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(90,132,'shary.castillo@2callcenter.cl','','936398206','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(91,133,'kiimdayana20@gmail.com','','969038913','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(92,134,'Valeska.aguilera@2callcenter.cl','','953134228','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(93,135,'daniela@prueba.cl','','912345678','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(94,136,'carrillotaimi@gmail.com','','947944465','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(95,137,'claudia.olguin@2callcenter.cl','','955674179','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(96,138,'camila.alarcon@2callcenter.cl','','990743713','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(97,139,'christync.charles@gmail.com','','949848210','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(98,140,'shary.castilloo@2callcenter.cl','','936398206','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(99,141,'jorge.tobar@2callcenter.cl','','965012029','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(100,142,'nohelia.gimenez@2call.cl','','959548101','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(101,143,'natacha.osorio@2callcenter.cl','','988148441','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(102,144,'crowell.pinto@2callcenter.cl','','930958385','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(103,145,'nicole.estay@2callcenter.cl','','950161600','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(104,146,'eloina.mjr123@gmail.com','','962165773','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(105,147,'ana.neira@2callcenter.cl','','954347199','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(106,148,'williestra3@gmail.com','','981247000','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(107,149,'claudia.fuentes@2callcenter.cl','','963619106','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(108,150,'geraldine.mora@2callcenter.cl','','940561524','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(109,151,'massiel.diaz@2callcenter.cl','','998132904','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(110,152,'catherine.casuso@2callcenter.cl','','966770555','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(111,153,'marcelo.gutierrez@2callcenter.cl','','972588129','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(112,154,'tomas.lara@2callcenter.cl','','964536769','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(113,155,'prueba21@apolo.cl','','995087444','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(114,156,'francisco.toloza@2callcenter.cl','','961917600','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(115,157,'keily.villalobos@2callcenter.cl','','936459142','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(116,158,'marcosdiamond2011@gmail.com','','995231732','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(117,159,'saida.valera@gmail.com','','978257816','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(118,160,'prueba13@apolo.cl','','972424701','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(119,161,'argenis.riera@2callcenter.cl','','986766603','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(120,162,'Lauri.rodriguez@2callcenter.cl','','945333565','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(121,163,'paula.galaz@2callcenter.cl','','979558839','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(122,164,'BARRERA_MARTINEZ@sdsdsl.cl','','98888887','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(123,165,'josephlinerojas2@gmail.com','','920074840','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(124,166,'beatriz.martinez@2callcenter.cl','','961975189','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(125,167,'carla.zepeda@2callcenter.cl','','973821038','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(126,168,'prueba19@apolo.cl','','935488449','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(127,169,'vania.herrera@2callcenter.cl','','998276442','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(128,170,'diego@prueba.cl','','912345678','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(129,171,'williestra@gmail.com','','987196954','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(130,172,'simon.barrera@2callcenter.cl','','942894926','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(131,173,'lizmar.sayago@2callcenter.cl','','947610663','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(132,174,'jesus.zarraga@2callcenter.cl','','964242073','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(133,175,'jennifer.osorio@2callcenter.cl','','967506301','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(134,176,'maria.herdocio@2callcenter.cl','','983499579','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(135,177,'Leidy.urbina@2callcenter.cl','','964991097','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(136,178,'isabel.osorio@2callcenter.cl','227485438','972431074','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(137,179,'david.godoy@2callcenter.cl','322844892','942681879','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(138,180,'catalina.ahumada@2callcenter.cl','','941006321','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(139,181,'karen.olave@2callcenter.cl','','971289293','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(140,182,'zsalas8808@gmail.com','','936767261','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(141,183,'paula.barrera@2callcenter.cl','','978887593','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(142,184,'angela@prueba.cl','','912345678','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(143,185,'Claudia.granadillo@2callcenter.cl','','949215661','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(144,186,'ruben.escalona@2callcenter.cl','','999779291','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(145,187,'Johelisrodriguez23@gmail.com','','946379501','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(146,188,'luvys.pereira@2call.cl','','987244159','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(147,189,'jgzm1990@gmail.com','','956153411','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(148,190,'yuraima.hernandez@2callcenter.cl','','936555478','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(149,191,'reina.hernandez@2callcenter.cl','','947748289','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(150,192,'tomas.fuenzalida@2callcenter.cl','','988458854','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(151,193,'xandercarvajalino@gmail.com','','950342966','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(152,194,'alexandra.reyes@2callcenter.cl','','965010188','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(153,195,'prueba14@apolo.cl','','966525142','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(154,196,'yiraromero26@gmail.com','','950797876','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(155,197,'abraham.labra.m@gmail.com','','977067817','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(156,198,'jorge.pinero@2callcenter.cl','','946909817','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(157,199,'ney@2call.cl','','934804817','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(158,200,'gabriela.vargas@2callcenter.cl','','941541364','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(159,201,'bejamin@prueba.cl','','912345678','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(160,202,'tibi15vane@gmail.com','','937390599','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(161,203,'pyell.varela@2callcenter.cl','','958439589','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(162,204,'stephania-0611@hotmail.com','','959517601','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(163,205,'m_paula9431@hotmail.com','','985009520','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(164,206,'cami.ortiz.quezada@gmail.com','','963953300','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(165,207,'richard.german@2callcenter.cl','','994621860','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(166,208,'osdeirty.rincon@2callcenter.cl','','948673054','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(167,209,'jasmine.galvez@2callcenter.cl','','973530208','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(168,210,'mlaura9@gmail.com','','967475394','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(169,211,'daniela.maldonado@2callcenter.cl','56667787877','987329474','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(170,212,'wilson@rreeff.cl','123654456','944510530','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(171,213,'geraldine.avila@2call.cl','443025306','974492353','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(172,214,'ana.ibarra@2callcenter.cl','','997468099','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(173,215,'jhoselynvera0591@gmail.com','','964721709','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(174,216,'adalgiza.alizo@2callcenter.cl','','958994806','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(175,217,'prueba11@apolo.cl','','961554025','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(176,218,'alondra.colmenares@2callcenter.cl','','9 45119498','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(177,219,'jennifer.cardenas@2callcenter.cl','','946753361','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(178,220,'maria.sepulveda@2callcenter.cl','','964571831','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(179,221,'sebastian.cruzat@2callcenter.cl','','957217478','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(180,222,'fabian.lillo@2callcenter.cl','','931894230','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(181,223,'yobanatello90@gmail.com','','933182067','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(182,224,'rosa.arriagada@2callcenter.cl','','948085396','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(183,225,'nicole.fabres@2callcenter.cl','','946982536','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(184,226,'angelica.ramirez@2callcenter.cl','233424079','962157538','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(185,227,'paola.rebolledo@2callcenter.cl','','995022697','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(186,228,'camila.casanova@2callcenter.cl','','957714370','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(187,229,'natalia.gallardo@2callcenter.cl','','973570100','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(188,230,'jean.marin@2callcenter.cl','','968681389','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(189,231,'cristopher.gonzalez@2callcenter.cl','','932749582','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(190,232,'vanessitac31@gmail.com','','936227295','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(191,233,'francelis.pinto@2call.cl','','965919287','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(192,234,'alexandra.palma@2callcenter.cl','','934309022','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(193,235,'maria.silva@2callcenter.cl','','954887124','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(194,236,'Jeakendrys.viera@2callcenter.cl','','972743757','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(195,237,'williestra@gmail.com','981247000','0','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(196,238,'yenke.g@gmail.com','','947413568','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(197,239,'jhonhenryjorgec@gmail.com','','972550720','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(198,240,'jhdm100@hotmail.com','','920533674','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(199,241,'danielanazarethberrios@gmail.com','','954683540','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(200,242,'antoine.rameau@2callcenter.cl','','949466786','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(201,243,'yuleica.sojo@2callcenter.cl','','946350189','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(202,244,'julio.guzman@2callcenter.cl','','962850272','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(203,245,'Adriana.gil@2callcenter.cl','','936750245','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(204,246,'yoletts.cardozo@2callcenter.cl','','994766298','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(205,247,'joanna.hernandez@2callcenter.cl','','940542741','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(206,248,'oscar.osorio@2callcenter.cl','','947872772','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(207,249,'andrea.vargas@2callcenter.cl','','956874229','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(208,250,'emtolozam@gmail.com','','986228567','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(209,251,'kiarapuebla@hotmail.com','','936167138','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(210,252,'luisa.santibanez@2callcenter.cl','','975117469','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(211,253,'yolanda@prueba.cl','','912345678','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(212,254,'francisca.diaz@2callcenter.cl','','922390320','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(213,255,'Robertomercado.p@gmail.com','','950124966','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(214,256,'adrianna.chauran@2callcenter.cl','','944729350','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(215,257,'daniela.gutierrez@2callcenter.cl','','998927831','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(216,258,'nancy.gonzalez@2callcenter.cl','','966557771','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(217,259,'maria.arenas@2callcenter.cl','','954961917','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(218,260,'ariattna01@gmail.com','','968438197','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(219,261,'danielmedinachile@gmail.com','','984332512','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(220,262,'luis.bateca@2callcenter.cl','','942694588','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(221,263,'nicolas@prueba.cl','','912345678','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(222,264,'gemita.alejandra@live.cl','','933923444','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(223,265,'yannifer.jaramillo@2callcenter.cl','','954546235','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(224,266,'ana.fuentes@2callcenter.cl','','998600835','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(225,267,'brayan.hinojosa@2callcenter.cl','','975450806','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(226,268,'nairobi.francois@2callcenter.cl','','934668073','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(227,269,'johanna.leiva@2callcenter.cl','','963704245','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(228,270,'mariana.deluca@2callcenter.cl','','989942040','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(229,271,'Yusmarvi.gamarra@2callcenter.cl','','986665718','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(230,272,'joselyne.martinez@2callcenter.cl','','965532116','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(231,273,'francisca.valenzuela@2callcenter.cl','','946823961','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(232,274,'yonathan.chacon@2callcenter.cl','','953190859','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(233,275,'javiera.hermosilla@2call.cl','233444645','922492522','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(234,276,'roxana.sufia@2callcenter.cl','','949616381','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(235,277,'isamar.molina@2callcenter.cl','','982012498','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(236,278,'williestra4@gmail.com','','981247000','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(237,279,'prueba15@apolo.cl','','999167780','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(238,280,'greta.peraza@2callcenter.cl','','962078918','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(239,281,'maria.aicon@2callcenter.cl','','946695207','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(240,282,'CORREO@HOTM.COM','','98888887','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(241,283,'maria.gallardo@2callcenter.cl','','937340472','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(242,284,'rosa.castro@2callcenter.cl','','956607183','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(243,285,'constanza.quevedo@2callcenter.cl','','933977319','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(244,286,'viviana.arenas@2callcenter.cl','','949177387','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(245,287,'ana.mimiza@2call.cl','','946187355','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(246,288,'camila.arellano@2callcenter.cl','26234377','983002697','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(247,289,'ceciliaceballosorellana86@gmail.com','','963488669','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(248,290,'yogerly.toro@2callcenter.cl','','979489170','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(249,291,'denisse.novoa@2callcenter.cl','','991275332','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(250,292,'sulurbina@gmail.com','','97793317','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(251,293,'claudioobeid_19@outlook.com','','966519075','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(252,294,'yenifer.gutierrez@2call.cl','','937067585','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(253,295,'ivania.alcota@2callcenter.cl','','946705175','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(254,296,'yelitzka@hotmail.com','','961204785','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(255,297,'stephanie.ibarra@2callcenter.cl','','990815881','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(256,298,'korina.jimenez@2callcenter.cl','','958925038','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(257,299,'coni.mendezf@gmail.com','','0','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(258,300,'lucas.rodriguezg@mail.udp.cl','','990410962','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(259,301,'Cortespinochet.katherine@gmail.com','','967268192','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(260,302,'elsa.salazar@2callcenter.cl','','997926038','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(261,303,'gloria.cisternas@2callcenter.cl','','952773415','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(262,304,'ft.javiera7@gmail.com','','933782148','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(263,305,'francisca.panza@2callcenter.cl','','979631659','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(264,306,'elaidisamu@gmail.com','','949977334','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(265,307,'n.balboao@gmail.com','','963410029','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(266,308,'marcelo@prueba.cl','','912345678','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(267,309,'pedrojosegauta@gmail.com','','958376947','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(268,310,'danitza.burgos@2callcenter.cl','','991731170','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(269,311,'williestra2@gmail.com','','981247000','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(270,312,'rebeca.sanchez@2callcenter.cl','','931887539','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1);
/*!40000 ALTER TABLE `Contacto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CuentasContables`
--

DROP TABLE IF EXISTS `CuentasContables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CuentasContables` (
  `id` bigint(20) NOT NULL,
  `acct_code` varchar(20) NOT NULL,
  `sociedad_id` bigint(20) NOT NULL,
  `acct_name` varchar(100) NOT NULL,
  `finance` char(1) NOT NULL,
  PRIMARY KEY (`acct_code`),
  UNIQUE KEY `acct_code` (`acct_code`),
  KEY `FK_Sociedad_CuentasContables` (`sociedad_id`),
  CONSTRAINT `FK_Sociedad_CuentasContables` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar las cuentas contables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CuentasContables`
--

LOCK TABLES `CuentasContables` WRITE;
/*!40000 ALTER TABLE `CuentasContables` DISABLE KEYS */;
/*!40000 ALTER TABLE `CuentasContables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Departamentos`
--

DROP TABLE IF EXISTS `Departamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Departamentos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `sede_id` bigint(20) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_Departamentos` (`sociedad_id`),
  KEY `FK_Sede_Departamentos` (`sede_id`),
  CONSTRAINT `FK_Sede_Departamentos` FOREIGN KEY (`sede_id`) REFERENCES `Sede` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Sociedad_Departamentos` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar los datos de los departamentos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Departamentos`
--

LOCK TABLES `Departamentos` WRITE;
/*!40000 ALTER TABLE `Departamentos` DISABLE KEYS */;
INSERT INTO `Departamentos` VALUES
(1,1,1,'Administración','2024-02-01 10:00:00','2024-02-01 10:00:00',1,1),
(2,1,1,'Contabilidad','2024-02-01 10:00:00','2024-02-01 10:00:00',1,1),
(3,1,1,'Ventas','2024-02-01 10:00:00','2024-02-01 10:00:00',1,1);
/*!40000 ALTER TABLE `Departamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EstadoCivil`
--

DROP TABLE IF EXISTS `EstadoCivil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EstadoCivil` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para el estado civil del usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EstadoCivil`
--

LOCK TABLES `EstadoCivil` WRITE;
/*!40000 ALTER TABLE `EstadoCivil` DISABLE KEYS */;
INSERT INTO `EstadoCivil` VALUES
(1,'Soltero'),
(2,'Casado'),
(3,'Viudo'),
(4,'Divorciado');
/*!40000 ALTER TABLE `EstadoCivil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EstadosEvento`
--

DROP TABLE IF EXISTS `EstadosEvento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EstadosEvento` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_EventosEstado` (`sociedad_id`),
  CONSTRAINT `FK_Sociedad_EventosEstado` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar los estados de los eventos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EstadosEvento`
--

LOCK TABLES `EstadosEvento` WRITE;
/*!40000 ALTER TABLE `EstadosEvento` DISABLE KEYS */;
/*!40000 ALTER TABLE `EstadosEvento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EventosConfigBase`
--

DROP TABLE IF EXISTS `EventosConfigBase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EventosConfigBase` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL COMMENT 'sociedad a la que pertenece esta configuracion de eventos',
  `concepto_evento_id` bigint(20) NOT NULL,
  `tipo_evento_id` bigint(20) NOT NULL,
  `cuenta_contable` varchar(20) DEFAULT NULL COMMENT 'representa una cuanta en el centro de costos, pero puede ser nulo',
  `nombre_evento` text NOT NULL COMMENT 'nombre del evento',
  `descripcion` text DEFAULT NULL COMMENT 'cualquier descripcion adicional que quierea colocar el operador',
  `unidad_pacto_id` bigint(20) NOT NULL COMMENT 'relacionado con la tabla UnidadesPacto',
  `autorizacion` tinyint(1) NOT NULL COMMENT 'especifica si el evento requiere o no autorización para el pago',
  `proporcional_mes` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'especifica si se trata de un calculo relacionado al pago mensual o es un monto absoluto',
  `template_id` bigint(20) DEFAULT NULL COMMENT 'relacion con la tabla de templates de eventos no obligatoria',
  `activo` tinyint(1) NOT NULL COMMENT '0 Inactivo 1 Activo',
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_EventosConfigBase` (`sociedad_id`),
  KEY `FK_ConceptosEvento_EventosConfigBase` (`concepto_evento_id`),
  KEY `FK_TipoEvento_EventosConfigBase` (`tipo_evento_id`),
  KEY `FK_UnidadesPacto_EventosConfigBase` (`unidad_pacto_id`),
  CONSTRAINT `FK_ConceptosEvento_EventosConfigBase` FOREIGN KEY (`concepto_evento_id`) REFERENCES `ConceptosEventos` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Sociedad_EventosConfigBase` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_TipoEvento_EventosConfigBase` FOREIGN KEY (`tipo_evento_id`) REFERENCES `TiposEvento` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_UnidadesPacto_EventosConfigBase` FOREIGN KEY (`unidad_pacto_id`) REFERENCES `UnidadesPacto` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar la configuracionde los eventos base';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EventosConfigBase`
--

LOCK TABLES `EventosConfigBase` WRITE;
/*!40000 ALTER TABLE `EventosConfigBase` DISABLE KEYS */;
/*!40000 ALTER TABLE `EventosConfigBase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FormasPago`
--

DROP TABLE IF EXISTS `FormasPago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FormasPago` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_FormasPago` (`sociedad_id`),
  CONSTRAINT `FK_Sociedad_FormasPago` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar las  diferentes fprmas de pago';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FormasPago`
--

LOCK TABLES `FormasPago` WRITE;
/*!40000 ALTER TABLE `FormasPago` DISABLE KEYS */;
/*!40000 ALTER TABLE `FormasPago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FormasPagoUsuario`
--

DROP TABLE IF EXISTS `FormasPagoUsuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FormasPagoUsuario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `forma_pago_id` bigint(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Usuario_FormaPagoUsuario` (`user_id`),
  KEY `FK_FormaPago_FormaPagoUsuario` (`forma_pago_id`),
  CONSTRAINT `FK_FormaPago_FormaPagoUsuario` FOREIGN KEY (`forma_pago_id`) REFERENCES `FormasPago` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Usuario_FormaPagoUsuario` FOREIGN KEY (`user_id`) REFERENCES `Usuario` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de asigancion de formas de pagos del usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FormasPagoUsuario`
--

LOCK TABLES `FormasPagoUsuario` WRITE;
/*!40000 ALTER TABLE `FormasPagoUsuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `FormasPagoUsuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Formulas`
--

DROP TABLE IF EXISTS `Formulas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Formulas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `expresion` text NOT NULL COMMENT 'contentivo de la formua asociada al cálculo, esta fórmula contiene los codigos de los ParametrosBasicos ejemplo  ((p1*10)/b2)',
  `estado` tinyint(1) NOT NULL COMMENT 'especifica si la formula esta activa o no para el cálculo - 0 Inactivo 1 Activo',
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_Formulas` (`sociedad_id`),
  CONSTRAINT `FK_Sociedad_Formulas` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla que permite controlar las fórmulas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Formulas`
--

LOCK TABLES `Formulas` WRITE;
/*!40000 ALTER TABLE `Formulas` DISABLE KEYS */;
/*!40000 ALTER TABLE `Formulas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FotosUsuarios`
--

DROP TABLE IF EXISTS `FotosUsuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FotosUsuarios` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `url` text NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `FK_Usuario_FilesUsers` FOREIGN KEY (`user_id`) REFERENCES `Usuario` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de fotos de los usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FotosUsuarios`
--

LOCK TABLES `FotosUsuarios` WRITE;
/*!40000 ALTER TABLE `FotosUsuarios` DISABLE KEYS */;
INSERT INTO `FotosUsuarios` VALUES
(1,1,'/pics_users/Captura_de_pantalla_de_2023-07-31_16-55-029fc96691-d5b3-4b70-be67-3b256b773024.png','2024-01-02 16:19:55','2024-01-02 16:19:55',1,1),
(2,2,'/pics_users/anydesk00000d2446e6e-03bc-47f6-9fd3-f947ef6d2fee.png','2024-01-08 09:49:39','2024-01-08 09:49:39',1,1);
/*!40000 ALTER TABLE `FotosUsuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GruposEmpleado`
--

DROP TABLE IF EXISTS `GruposEmpleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GruposEmpleado` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `es_honorario` tinyint(1) NOT NULL DEFAULT 0,
  `nombre` varchar(200) NOT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de grupos de empleados';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GruposEmpleado`
--

LOCK TABLES `GruposEmpleado` WRITE;
/*!40000 ALTER TABLE `GruposEmpleado` DISABLE KEYS */;
INSERT INTO `GruposEmpleado` VALUES
(1,0,'Administrativo','2024-02-05 10:00:00','2024-02-05 10:00:00',1,1),
(2,0,'Ejecutivo','2024-02-05 10:00:00','2024-02-05 10:00:00',1,1),
(3,0,'Operaciones','2024-02-05 10:00:00','2024-02-05 10:00:00',1,1);
/*!40000 ALTER TABLE `GruposEmpleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HisoricoEventosConfigBase`
--

DROP TABLE IF EXISTS `HisoricoEventosConfigBase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HisoricoEventosConfigBase` (
  `id` bigint(20) NOT NULL,
  `sociedad_id` bigint(20) NOT NULL COMMENT 'sociedad a la que pertenece esta configuracion de eventos',
  `concepto_evento_id` bigint(20) NOT NULL COMMENT 'cual es el concepto relacionado, esto es usado en el informe de la DT',
  `tipo_evento_id` bigint(20) NOT NULL COMMENT 'cual es el concepto relacionado, esto es usado en el informe de la DT',
  `cuenta_contable` varchar(20) DEFAULT NULL COMMENT 'representa una cuanta en el centro de costos, pero puede ser nulo',
  `nombre_evento` text NOT NULL COMMENT 'nombre del evento',
  `descripcion` text DEFAULT NULL COMMENT 'cualquier descripcion adicional que quierea colocar el operador',
  `unidad_pacto_id` bigint(20) NOT NULL COMMENT 'relacionado con la tabla UnidadesPacto',
  `autorizacion` tinyint(1) NOT NULL COMMENT 'especifica si el evento requiere o no autorización para el pago',
  `proporcional_mes` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'especifica si se trata de un calculo relacionado al pago mensual o es un monto absoluto',
  `template_id` bigint(20) DEFAULT NULL COMMENT 'relacion con la tabla de templates de eventos no obligatoria',
  `activo` tinyint(1) NOT NULL COMMENT '0 Inactivo 1 Activo',
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  `fecha_registro_historico` datetime NOT NULL,
  PRIMARY KEY (`id`,`sociedad_id`,`fecha_registro_historico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar el histórico de la configuracionde los eventos base';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HisoricoEventosConfigBase`
--

LOCK TABLES `HisoricoEventosConfigBase` WRITE;
/*!40000 ALTER TABLE `HisoricoEventosConfigBase` DISABLE KEYS */;
/*!40000 ALTER TABLE `HisoricoEventosConfigBase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HisotiricoSociedad`
--

DROP TABLE IF EXISTS `HisotiricoSociedad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HisotiricoSociedad` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `rut` varchar(100) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `direccion` text DEFAULT NULL,
  `region_id` bigint(20) NOT NULL,
  `comuna_id` bigint(20) NOT NULL,
  `ciudad` varchar(250) NOT NULL,
  `icono` varchar(250) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HisotiricoSociedad`
--

LOCK TABLES `HisotiricoSociedad` WRITE;
/*!40000 ALTER TABLE `HisotiricoSociedad` DISABLE KEYS */;
/*!40000 ALTER TABLE `HisotiricoSociedad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoAFP`
--

DROP TABLE IF EXISTS `HistoricoAFP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoAFP` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `afp_id` bigint(20) NOT NULL,
  `codigo_previred` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `cotizacion` decimal(18,4) DEFAULT NULL,
  `cuenta_AFP` varchar(150) DEFAULT NULL,
  `sis` decimal(18,4) DEFAULT NULL,
  `cuenta_sis_cred` varchar(20) DEFAULT NULL,
  `cuenta_ahorro_AFP_cuenta2` varchar(150) DEFAULT NULL,
  `codigo_direccion_trabajo` varchar(10) DEFAULT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  `fecha_registro` datetime NOT NULL COMMENT 'fecha en que fue creado el registro historico',
  `observaciones` text DEFAULT NULL COMMENT 'observaciones del historico',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para almacenar el historico de las cuentas AFP';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoAFP`
--

LOCK TABLES `HistoricoAFP` WRITE;
/*!40000 ALTER TABLE `HistoricoAFP` DISABLE KEYS */;
INSERT INTO `HistoricoAFP` VALUES
(1,1,'08','Provida',11.4500,'21050001',1.5400,'21050001','21050001','6','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1,'2024-01-23 16:25:17','Actualización de la data del AFP');
/*!40000 ALTER TABLE `HistoricoAFP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoAPVInstituciones`
--

DROP TABLE IF EXISTS `HistoricoAPVInstituciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoAPVInstituciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apv_id` bigint(20) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `nombre_largo` varchar(250) NOT NULL,
  `cuenta_contable` varchar(100) DEFAULT NULL,
  `codigo_externo` varchar(50) DEFAULT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  `fecha_registro` datetime NOT NULL COMMENT 'fecha en que fue creado el registro historico',
  `observaciones` text DEFAULT NULL COMMENT 'observaciones del historico',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para almacenar el historico de las instituciones APV';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoAPVInstituciones`
--

LOCK TABLES `HistoricoAPVInstituciones` WRITE;
/*!40000 ALTER TABLE `HistoricoAPVInstituciones` DISABLE KEYS */;
INSERT INTO `HistoricoAPVInstituciones` VALUES
(1,5,'Habitat','Habitat','21050001','005','2024-01-29 01:00:00','2024-01-29 01:00:00',1,1,'2024-01-29 21:30:26','Actualización de la data del APV'),
(2,6,'HABITAT G','HABITAT G','21050001','006','2024-01-29 21:32:01','2024-01-29 21:32:01',1,1,'2024-01-29 21:32:01','Se creó un APV en el sistema');
/*!40000 ALTER TABLE `HistoricoAPVInstituciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoArchivosUsuarios`
--

DROP TABLE IF EXISTS `HistoricoArchivosUsuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoArchivosUsuarios` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  `url` text NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de archivos de los usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoArchivosUsuarios`
--

LOCK TABLES `HistoricoArchivosUsuarios` WRITE;
/*!40000 ALTER TABLE `HistoricoArchivosUsuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `HistoricoArchivosUsuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoBancariosUser`
--

DROP TABLE IF EXISTS `HistoricoBancariosUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoBancariosUser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bancario_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `banco_id` bigint(20) NOT NULL,
  `numero_cuenta` varchar(100) NOT NULL,
  `en_uso` tinyint(1) NOT NULL,
  `terceros` tinyint(1) NOT NULL,
  `rut_tercero` varchar(100) DEFAULT NULL,
  `nombre_tercero` varchar(100) DEFAULT NULL,
  `email_tercero` varchar(250) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de historico datos bancarios de pagos del usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoBancariosUser`
--

LOCK TABLES `HistoricoBancariosUser` WRITE;
/*!40000 ALTER TABLE `HistoricoBancariosUser` DISABLE KEYS */;
INSERT INTO `HistoricoBancariosUser` VALUES
(1,2,43,1,'18800023158',1,1,'26337084-8','Sergio Rivas d','example@micorreo.com','2024-01-23 14:47:27','2024-01-23 14:47:27',1,1,'2024-01-23 14:47:27','Se creó la data de contacto del usuario');
/*!40000 ALTER TABLE `HistoricoBancariosUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoBancos`
--

DROP TABLE IF EXISTS `HistoricoBancos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoBancos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `banco_id` bigint(20) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `nomina` tinyint(1) NOT NULL COMMENT '0 No genera Nomina 1 Genera Nomina',
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar el historico de los bancos en el sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoBancos`
--

LOCK TABLES `HistoricoBancos` WRITE;
/*!40000 ALTER TABLE `HistoricoBancos` DISABLE KEYS */;
/*!40000 ALTER TABLE `HistoricoBancos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoCargos`
--

DROP TABLE IF EXISTS `HistoricoCargos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoCargos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cargo_id` bigint(20) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar los datos historicos de los cargos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoCargos`
--

LOCK TABLES `HistoricoCargos` WRITE;
/*!40000 ALTER TABLE `HistoricoCargos` DISABLE KEYS */;
INSERT INTO `HistoricoCargos` VALUES
(1,1,'MASTER DEVELOPER','2024-02-04 19:35:09','2024-02-04 19:35:09',1,1,'2024-02-04 19:35:09','Se creó un cargo en el sistema'),
(2,1,'MASTER DEVELOPER','2024-02-04 19:35:09','2024-02-04 19:35:09',1,1,'2024-02-04 19:37:15','Actualización de la data de la sociedad');
/*!40000 ALTER TABLE `HistoricoCargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoCargosUsuario`
--

DROP TABLE IF EXISTS `HistoricoCargosUsuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoCargosUsuario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cargos_usuarios_id` bigint(20) NOT NULL,
  `sociedad_id` bigint(20) DEFAULT NULL,
  `sede_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `cargo_id` bigint(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de datos historico cargos del usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoCargosUsuario`
--

LOCK TABLES `HistoricoCargosUsuario` WRITE;
/*!40000 ALTER TABLE `HistoricoCargosUsuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `HistoricoCargosUsuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoConfiguraciones`
--

DROP TABLE IF EXISTS `HistoricoConfiguraciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoConfiguraciones` (
  `id` bigint(20) NOT NULL,
  `sociedad_id` bigint(20) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `valor` decimal(18,4) NOT NULL,
  `detalle` text DEFAULT NULL,
  `cuenta` varchar(20) DEFAULT NULL,
  `categoria` varchar(250) DEFAULT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  `ocultar` bit(1) NOT NULL DEFAULT b'0',
  `tipo_validacion` varchar(30) DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  `fecha_historico_created` datetime NOT NULL,
  PRIMARY KEY (`fecha_historico_created`,`id`,`sociedad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlarla los datos de la empresa (sociedades)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoConfiguraciones`
--

LOCK TABLES `HistoricoConfiguraciones` WRITE;
/*!40000 ALTER TABLE `HistoricoConfiguraciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `HistoricoConfiguraciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoContacto`
--

DROP TABLE IF EXISTS `HistoricoContacto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoContacto` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `fijo` varchar(20) DEFAULT NULL,
  `movil` varchar(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de Hitorico de contacto de los usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoContacto`
--

LOCK TABLES `HistoricoContacto` WRITE;
/*!40000 ALTER TABLE `HistoricoContacto` DISABLE KEYS */;
INSERT INTO `HistoricoContacto` VALUES
(1,43,'example@micorreo.com','226656168','939024766','1990-01-01 00:00:00','2023-12-26 12:51:38',1,1,'2024-01-04 18:16:18','Actualización de la data de contacto del usuario'),
(2,43,'example@micorreo.com','226656168777','939024766','1990-01-01 00:00:00','2024-01-04 18:16:18',1,43,'2024-01-04 18:16:41','Actualización de la data de contacto del usuario');
/*!40000 ALTER TABLE `HistoricoContacto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoDepartamentos`
--

DROP TABLE IF EXISTS `HistoricoDepartamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoDepartamentos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `departamento_id` bigint(20) NOT NULL,
  `sociedad_id` bigint(20) NOT NULL,
  `sede_id` bigint(20) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar los datos historico de los departamentos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoDepartamentos`
--

LOCK TABLES `HistoricoDepartamentos` WRITE;
/*!40000 ALTER TABLE `HistoricoDepartamentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `HistoricoDepartamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoEventos`
--

DROP TABLE IF EXISTS `HistoricoEventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoEventos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL COMMENT 'sociedad a la que pertenece este eventos',
  `tipo_evento_id` bigint(20) NOT NULL COMMENT 'relacion con la tabla TiposEventos',
  `base_evento_id` bigint(20) NOT NULL COMMENT 'relacion con la tabla EventosConfigBase',
  `estado_evento_id` bigint(20) NOT NULL COMMENT 'relacion con la tabla EstadosEventos',
  `periodo_id` bigint(20) NOT NULL COMMENT 'relacion con la tabla Periodos',
  `fecha_autorizacion` datetime DEFAULT NULL COMMENT 'Fecha en la que fu confiourado el evento',
  `continuo` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'define si el evento es continuo o discontinuo',
  `desde` datetime DEFAULT NULL COMMENT 'fecha en la que comienza el evento',
  `hasta` datetime DEFAULT NULL COMMENT 'fecha en la que termina el evento',
  `nombre_evento` text DEFAULT NULL COMMENT 'como se llama el evento',
  `observacion` text DEFAULT NULL COMMENT 'cualquier descripcion adicional al evento',
  `centralizacion_id` bigint(20) DEFAULT NULL COMMENT 'relacion con la tabla Centralizaciones si aplica',
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  `fecha_historico_created` datetime NOT NULL,
  PRIMARY KEY (`id`,`fecha_historico_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar el histiro de eventos de una sociedad';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoEventos`
--

LOCK TABLES `HistoricoEventos` WRITE;
/*!40000 ALTER TABLE `HistoricoEventos` DISABLE KEYS */;
/*!40000 ALTER TABLE `HistoricoEventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoFormasPagoUsuario`
--

DROP TABLE IF EXISTS `HistoricoFormasPagoUsuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoFormasPagoUsuario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `forma_pago_usuario_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `forma_pago_id` bigint(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de historico de asigancion de formas de pagos del usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoFormasPagoUsuario`
--

LOCK TABLES `HistoricoFormasPagoUsuario` WRITE;
/*!40000 ALTER TABLE `HistoricoFormasPagoUsuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `HistoricoFormasPagoUsuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoFormulas`
--

DROP TABLE IF EXISTS `HistoricoFormulas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoFormulas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) NOT NULL,
  `expresion` text NOT NULL COMMENT 'contentivo de la formua asociada al cálculo, esta fórmula contiene los codigos de los ParametrosBasicos ejemplo  ((p1*10)/b2)',
  `estado` tinyint(1) NOT NULL COMMENT 'especifica si la formula esta activa o no para el cálculo - 0 Inactivo 1 Activo',
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`id`,`fecharegistro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla que permite controlar las fórmulas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoFormulas`
--

LOCK TABLES `HistoricoFormulas` WRITE;
/*!40000 ALTER TABLE `HistoricoFormulas` DISABLE KEYS */;
/*!40000 ALTER TABLE `HistoricoFormulas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoFotosUsuarios`
--

DROP TABLE IF EXISTS `HistoricoFotosUsuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoFotosUsuarios` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pic_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `url` text NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de historico de fotos de los usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoFotosUsuarios`
--

LOCK TABLES `HistoricoFotosUsuarios` WRITE;
/*!40000 ALTER TABLE `HistoricoFotosUsuarios` DISABLE KEYS */;
INSERT INTO `HistoricoFotosUsuarios` VALUES
(1,2,2,'/pics_users/anydesk00000d2446e6e-03bc-47f6-9fd3-f947ef6d2fee.png','2024-01-08 09:49:39','2024-01-08 09:49:39',1,1,'2024-01-08 09:49:39','Creación de foto del usuario');
/*!40000 ALTER TABLE `HistoricoFotosUsuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoGruposEmpleado`
--

DROP TABLE IF EXISTS `HistoricoGruposEmpleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoGruposEmpleado` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `grupo_empleados_id` bigint(20) NOT NULL,
  `es_honorario` tinyint(1) NOT NULL DEFAULT 0,
  `nombre` varchar(200) NOT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  `fecha_registro` datetime NOT NULL COMMENT 'fecha en que fue creado el registro historico',
  `observaciones` text DEFAULT NULL COMMENT 'observaciones del historico',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de grupos de empleados';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoGruposEmpleado`
--

LOCK TABLES `HistoricoGruposEmpleado` WRITE;
/*!40000 ALTER TABLE `HistoricoGruposEmpleado` DISABLE KEYS */;
/*!40000 ALTER TABLE `HistoricoGruposEmpleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoModulo`
--

DROP TABLE IF EXISTS `HistoricoModulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoModulo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `modulo_id` bigint(20) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `url` varchar(250) DEFAULT NULL,
  `icono` varchar(250) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de los datos historico de los modulos del sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoModulo`
--

LOCK TABLES `HistoricoModulo` WRITE;
/*!40000 ALTER TABLE `HistoricoModulo` DISABLE KEYS */;
/*!40000 ALTER TABLE `HistoricoModulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoMutuales`
--

DROP TABLE IF EXISTS `HistoricoMutuales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoMutuales` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mutuales_id` bigint(20) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `codigo_externo` varchar(50) NOT NULL,
  `cuenta_contable` varchar(50) NOT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlarlar las historico de empresas mutuales';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoMutuales`
--

LOCK TABLES `HistoricoMutuales` WRITE;
/*!40000 ALTER TABLE `HistoricoMutuales` DISABLE KEYS */;
INSERT INTO `HistoricoMutuales` VALUES
(1,7,'ASOCIACIÓN CHILENA DE SEGURIDAD (ACHS)','01','21050004','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1,'2024-01-23 18:40:07','Actualización de la data de la mutual'),
(2,7,'ASOCIACIÓN CHILENA DE SEGURIDAD (ACHS) B','01','21050004','1990-01-01 00:00:00','2024-01-23 18:40:07',1,1,'2024-01-23 18:41:40','Actualización de la data de la mutual'),
(3,13,'PRUEBA ASOCIACIÓN CHILENA DE SEGURIDAD','01656655','21050009','2024-01-23 18:43:33','2024-01-23 18:43:33',1,1,'2024-01-23 18:43:33','Se creó una Mutual en el sistema');
/*!40000 ALTER TABLE `HistoricoMutuales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoParametrosBasicos`
--

DROP TABLE IF EXISTS `HistoricoParametrosBasicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoParametrosBasicos` (
  `id` bigint(20) NOT NULL,
  `codigo` varchar(5) NOT NULL COMMENT 'este codigo se utilizará como abreviatura en los cálculos de las formulas',
  `concepto` varchar(250) NOT NULL,
  `tipo_parametro_id` bigint(20) NOT NULL,
  `valor` decimal(18,4) NOT NULL,
  `estado` tinyint(1) NOT NULL COMMENT 'especifica si el parametro esta activo o no para el cálculo - 0 Inactivo 1 Activo',
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla que permite controlar los parametros basicos de cálculo de remuneraciones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoParametrosBasicos`
--

LOCK TABLES `HistoricoParametrosBasicos` WRITE;
/*!40000 ALTER TABLE `HistoricoParametrosBasicos` DISABLE KEYS */;
/*!40000 ALTER TABLE `HistoricoParametrosBasicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoPeriodos`
--

DROP TABLE IF EXISTS `HistoricoPeriodos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoPeriodos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `anio` int(11) NOT NULL,
  `mes` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `observacion` text DEFAULT NULL,
  `utm` decimal(18,4) DEFAULT NULL,
  `uf` decimal(18,4) DEFAULT NULL,
  `factor_actualizacion` decimal(18,4) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  `fecha_historico_created` datetime NOT NULL,
  PRIMARY KEY (`id`,`sociedad_id`,`fecha_historico_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de Periodos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoPeriodos`
--

LOCK TABLES `HistoricoPeriodos` WRITE;
/*!40000 ALTER TABLE `HistoricoPeriodos` DISABLE KEYS */;
/*!40000 ALTER TABLE `HistoricoPeriodos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoSede`
--

DROP TABLE IF EXISTS `HistoricoSede`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoSede` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sede_id` bigint(20) NOT NULL,
  `sociedad_id` bigint(20) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `direccion` text DEFAULT NULL,
  `region_id` bigint(20) NOT NULL,
  `comuna_id` bigint(20) NOT NULL,
  `ciudad` varchar(250) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar los datos historicos de las sedes de  una sociedad';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoSede`
--

LOCK TABLES `HistoricoSede` WRITE;
/*!40000 ALTER TABLE `HistoricoSede` DISABLE KEYS */;
INSERT INTO `HistoricoSede` VALUES
(1,1,1,'SEDE DEMO','DIRECCION SEDE DEMO',1,1101,'DEMO CIUDAD','2024-02-01 13:13:35','2024-02-01 13:13:35',1,1,'2024-02-01 13:13:35','Se creó una sociedad en el sistema'),
(2,2,1,'SEDE DOS','DIRECCION SEDE DEMO',1,1101,'DEMO CIUDAD','2024-02-01 13:13:46','2024-02-01 13:13:46',1,1,'2024-02-01 13:13:46','Se creó una sociedad en el sistema'),
(3,1,1,'SEDE DEMO','DIRECCION SEDE DEMO',1,1101,'DEMO CIUDAD','2024-02-01 13:13:35','2024-02-01 13:13:35',1,1,'2024-02-01 13:14:54','Actualización de la data de la sociedad');
/*!40000 ALTER TABLE `HistoricoSede` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoUbicacion`
--

DROP TABLE IF EXISTS `HistoricoUbicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoUbicacion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `region_id` bigint(20) NOT NULL,
  `comuna_id` bigint(20) NOT NULL,
  `direccion` text NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla historico de ubicación de los usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoUbicacion`
--

LOCK TABLES `HistoricoUbicacion` WRITE;
/*!40000 ALTER TABLE `HistoricoUbicacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `HistoricoUbicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoUnidadesPacto`
--

DROP TABLE IF EXISTS `HistoricoUnidadesPacto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoUnidadesPacto` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `unidades_id` bigint(20) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `estado` tinyint(1) NOT NULL COMMENT '0 Inactivo 1 Activo',
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar el hitorico de las unidades de pacto de los eventos de nomina';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoUnidadesPacto`
--

LOCK TABLES `HistoricoUnidadesPacto` WRITE;
/*!40000 ALTER TABLE `HistoricoUnidadesPacto` DISABLE KEYS */;
INSERT INTO `HistoricoUnidadesPacto` VALUES
(1,1,'UF',1,'2024-01-24 22:46:04','2024-01-24 22:46:04',1,1,'2024-01-24 22:46:04','Se creó una unidad de pacto en el sistema'),
(2,2,'$',1,'2024-01-24 22:46:51','2024-01-24 22:46:51',1,1,'2024-01-24 22:46:51','Se creó una unidad de pacto en el sistema');
/*!40000 ALTER TABLE `HistoricoUnidadesPacto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoUsuario`
--

DROP TABLE IF EXISTS `HistoricoUsuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoUsuario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `rut` varchar(100) NOT NULL,
  `rut_provisorio` varchar(100) DEFAULT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellido_paterno` varchar(100) NOT NULL,
  `apellido_materno` varchar(100) DEFAULT NULL,
  `fecha_nacimiento` date NOT NULL,
  `sexo_id` bigint(20) NOT NULL,
  `estado_civil_id` bigint(20) NOT NULL,
  `nacionalidad_id` bigint(20) NOT NULL,
  `username` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `activo` tinyint(1) NOT NULL COMMENT 'campo para activar o no al usuario 0 Inactivo 1 Activo',
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de  Datos Historico de Usuarios usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoUsuario`
--

LOCK TABLES `HistoricoUsuario` WRITE;
/*!40000 ALTER TABLE `HistoricoUsuario` DISABLE KEYS */;
INSERT INTO `HistoricoUsuario` VALUES
(1,43,'26560659-8','','MARI ESTELLA','SUÁREZ','SIERRA','2001-09-11',2,1,5,'26560659-8','12345678',1,'2021-09-27 00:00:00','1990-01-01 00:01:00',1,1,'2024-01-04 18:14:02','Activacion del Usuario'),
(2,43,'26560659-8','','MARI ESTELLA','SUÁREZ','SIERRA','2001-09-11',2,1,5,'26560659-8','12345678',1,'2021-09-27 00:00:00','2024-01-04 18:14:02',1,1,'2024-01-04 18:14:17','Desactivacion del Usuario');
/*!40000 ALTER TABLE `HistoricoUsuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HistoricoUsuarioModulo`
--

DROP TABLE IF EXISTS `HistoricoUsuarioModulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HistoricoUsuarioModulo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_modulo_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `modulo_id` bigint(20) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de los de Historico de los modulos del sistema asigandos al usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HistoricoUsuarioModulo`
--

LOCK TABLES `HistoricoUsuarioModulo` WRITE;
/*!40000 ALTER TABLE `HistoricoUsuarioModulo` DISABLE KEYS */;
/*!40000 ALTER TABLE `HistoricoUsuarioModulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InstitucionesAPV`
--

DROP TABLE IF EXISTS `InstitucionesAPV`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `InstitucionesAPV` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `nombre_largo` text DEFAULT NULL,
  `cuenta_contable` varchar(100) DEFAULT NULL,
  `codigo_externo` varchar(50) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InstitucionesAPV`
--

LOCK TABLES `InstitucionesAPV` WRITE;
/*!40000 ALTER TABLE `InstitucionesAPV` DISABLE KEYS */;
/*!40000 ALTER TABLE `InstitucionesAPV` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Modulo`
--

DROP TABLE IF EXISTS `Modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Modulo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) NOT NULL,
  `url` varchar(250) DEFAULT NULL,
  `icono` varchar(250) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de los modulos del sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Modulo`
--

LOCK TABLES `Modulo` WRITE;
/*!40000 ALTER TABLE `Modulo` DISABLE KEYS */;
INSERT INTO `Modulo` VALUES
(1,'Empleados','/empleados','',1,'2024-01-01 01:00:00','2024-01-01 01:00:00',1,1),
(2,'Parametros Básicos','/parametros','',1,'2024-01-01 01:00:00','2024-01-01 01:00:00',1,1),
(3,'Eventos','/eventos','',1,'2024-01-01 01:00:00','2024-01-01 01:00:00',1,1),
(4,'Nomina','/nomina','',1,'2024-01-01 01:00:00','2024-01-01 01:00:00',1,1),
(5,'Vacaciones','/vacaciones','',1,'2024-01-01 01:00:00','2024-01-01 01:00:00',1,1);
/*!40000 ALTER TABLE `Modulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mutuales`
--

DROP TABLE IF EXISTS `Mutuales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Mutuales` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) NOT NULL,
  `codigo_externo` varchar(50) NOT NULL,
  `cuenta_contable` varchar(50) NOT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlarlar las empresas mutuales';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mutuales`
--

LOCK TABLES `Mutuales` WRITE;
/*!40000 ALTER TABLE `Mutuales` DISABLE KEYS */;
INSERT INTO `Mutuales` VALUES
(7,'ASOCIACIÓN CHILENA DE SEGURIDAD (ACHS)','01','21050004','1990-01-01 00:00:00','2024-01-23 18:41:40',1,1),
(8,'Mutual de seguridad CCHC','21050004','02','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(9,'Instituto de seguridad del trabajo I.S.T ','03','21050004','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(12,'Sin Mutual - Empresa entrega aporte Accidentes del Trabajo al ISL','00','21050004','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(13,'PRUEBA ASOCIACIÓN CHILENA DE SEGURIDAD','01656655','21050009','2024-01-23 18:43:33','2024-01-23 18:43:33',1,1);
/*!40000 ALTER TABLE `Mutuales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Nacionalidad`
--

DROP TABLE IF EXISTS `Nacionalidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Nacionalidad` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Nacionalidad` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para las nacionalidades del usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Nacionalidad`
--

LOCK TABLES `Nacionalidad` WRITE;
/*!40000 ALTER TABLE `Nacionalidad` DISABLE KEYS */;
INSERT INTO `Nacionalidad` VALUES
(1,'CHILENA'),
(2,'PERUANA'),
(3,'VENEZOLANA'),
(4,'ESPAÑOLA'),
(5,'COLOMBIANA'),
(6,'URUGUAYA'),
(7,'BOLIVIANA'),
(1001,'CUBANA');
/*!40000 ALTER TABLE `Nacionalidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NivelEstudio`
--

DROP TABLE IF EXISTS `NivelEstudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NivelEstudio` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar los diferentes niveles académicos del usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NivelEstudio`
--

LOCK TABLES `NivelEstudio` WRITE;
/*!40000 ALTER TABLE `NivelEstudio` DISABLE KEYS */;
INSERT INTO `NivelEstudio` VALUES
(1,'Básica'),
(2,'Media Científico Humanista'),
(3,'Media Técnico Profesional'),
(4,'Superior Técnica (CFT o IP)'),
(5,'Universitaria');
/*!40000 ALTER TABLE `NivelEstudio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ParametrosBasicos`
--

DROP TABLE IF EXISTS `ParametrosBasicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ParametrosBasicos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(5) NOT NULL COMMENT 'este codigo se utilizará como abreviatura en los cálculos de las formulas',
  `sociedad_id` bigint(20) NOT NULL,
  `concepto` varchar(250) NOT NULL,
  `tipo_parametro_id` bigint(20) NOT NULL,
  `valor` decimal(18,4) NOT NULL,
  `estado` tinyint(1) NOT NULL COMMENT 'especifica si el parametro esta activo o no para el cálculo - 0 Inactivo 1 Activo',
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `FK_Sociedad_ParametrosBasicos` (`sociedad_id`),
  CONSTRAINT `FK_Sociedad_ParametrosBasicos` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla que permite controlar los parametros basicos de cálculo de remuneraciones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ParametrosBasicos`
--

LOCK TABLES `ParametrosBasicos` WRITE;
/*!40000 ALTER TABLE `ParametrosBasicos` DISABLE KEYS */;
/*!40000 ALTER TABLE `ParametrosBasicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PrevisionSalud`
--

DROP TABLE IF EXISTS `PrevisionSalud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PrevisionSalud` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `codigo_externo` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `prevision_salud_cuenta` varchar(150) DEFAULT NULL,
  `codigo_direccion_trabajo` varchar(10) DEFAULT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el AFP',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el AFP',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el AFP',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el AFP',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para almacenar los datos de prevision salud';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PrevisionSalud`
--

LOCK TABLES `PrevisionSalud` WRITE;
/*!40000 ALTER TABLE `PrevisionSalud` DISABLE KEYS */;
INSERT INTO `PrevisionSalud` VALUES
(2,'00','Sin Isapre','21050002',NULL,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(3,'01','Banmédica','21050002','3','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(4,'02','Consalud','21050002','9','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(5,'03','Vida Tres','21050002','12','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(6,'04','Colmena','21050002','4','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(7,'05','Isapre Cruz Blanca S.A.','21050002','1','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(8,'07','Fonasa','21050009','102','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(9,'09','Chuquicamata','21050002','37','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(10,'000','Ferrosalud','21050002',NULL,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(11,'11','Inst. de salud Fusat Ltda.','21050002','39','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(12,'12','Isapre Bco. Estado','21050002','40','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(13,'10','Nueva Masvida','21050002','43','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(14,'20','Río Blanco','21050002','41','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(15,'21','San Lorenzo isapre ltda.','21050002','42','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(16,'25','Cruz del norte','21050002','38','1990-01-01 00:00:00','1990-01-01 00:00:00',1,1);
/*!40000 ALTER TABLE `PrevisionSalud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Regiones`
--

DROP TABLE IF EXISTS `Regiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Regiones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) NOT NULL,
  `orden` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para almacenar la información geográfica de las Regiones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Regiones`
--

LOCK TABLES `Regiones` WRITE;
/*!40000 ALTER TABLE `Regiones` DISABLE KEYS */;
INSERT INTO `Regiones` VALUES
(1,'Tarapacá',3),
(2,'Antofagasta',4),
(3,'Atacama ',5),
(4,'Coquimbo ',6),
(5,'Valparaíso ',7),
(6,'Lib. Gral. B. O\'Higgins',8),
(7,'Maule',9),
(8,'Bio Bio',10),
(9,'Araucanía',11),
(10,'Los Lagos',12),
(11,'Aysen',13),
(12,'Magallanes',14),
(13,'Metropolitana',1),
(14,'Los Ríos',16),
(15,'Región de Arica y Parinacota ',2);
/*!40000 ALTER TABLE `Regiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Roles`
--

DROP TABLE IF EXISTS `Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) DEFAULT NULL,
  `descripcion` varchar(250) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla los roles dentro del sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Roles`
--

LOCK TABLES `Roles` WRITE;
/*!40000 ALTER TABLE `Roles` DISABLE KEYS */;
INSERT INTO `Roles` VALUES
(1,1,'root',1,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(2,1,'administrador',1,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(3,1,'RRHH Consultor',1,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1);
/*!40000 ALTER TABLE `Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sede`
--

DROP TABLE IF EXISTS `Sede`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sede` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `direccion` text NOT NULL,
  `region_id` bigint(20) NOT NULL,
  `comuna_id` bigint(20) NOT NULL,
  `ciudad` varchar(250) NOT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`),
  KEY `FK_Comunas_Sede` (`comuna_id`),
  KEY `FK_Regiones_Sede` (`region_id`),
  KEY `FK_Sociedades_Sede` (`sociedad_id`),
  CONSTRAINT `FK_Comunas_Sede` FOREIGN KEY (`comuna_id`) REFERENCES `Comunas` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Regiones_Sede` FOREIGN KEY (`region_id`) REFERENCES `Regiones` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Sociedades_Sede` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar los datos de las sedes de  una sociedad';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sede`
--

LOCK TABLES `Sede` WRITE;
/*!40000 ALTER TABLE `Sede` DISABLE KEYS */;
INSERT INTO `Sede` VALUES
(1,1,'SEDE UNO','DIRECCION SEDE DEMO',1,1101,'DEMO CIUDAD','2024-02-01 13:13:35','2024-02-01 13:14:54',1,1),
(2,1,'SEDE DOS','DIRECCION SEDE DEMO',1,1101,'DEMO CIUDAD','2024-02-01 13:13:46','2024-02-01 13:13:46',1,1);
/*!40000 ALTER TABLE `Sede` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sexo`
--

DROP TABLE IF EXISTS `Sexo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sexo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para el sexo del usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sexo`
--

LOCK TABLES `Sexo` WRITE;
/*!40000 ALTER TABLE `Sexo` DISABLE KEYS */;
INSERT INTO `Sexo` VALUES
(1,'Hombre'),
(2,'Mujer');
/*!40000 ALTER TABLE `Sexo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sociedad`
--

DROP TABLE IF EXISTS `Sociedad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sociedad` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rut` varchar(100) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `direccion` text NOT NULL,
  `region_id` bigint(20) NOT NULL,
  `comuna_id` bigint(20) NOT NULL,
  `ciudad` varchar(250) NOT NULL,
  `icono` varchar(250) DEFAULT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`),
  KEY `FK_Regiones_Empresa` (`region_id`),
  KEY `FK_Comunas_Empresa` (`comuna_id`),
  CONSTRAINT `FK_Comunas_Empresa` FOREIGN KEY (`comuna_id`) REFERENCES `Comunas` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Regiones_Empresa` FOREIGN KEY (`region_id`) REFERENCES `Regiones` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlarla los datos de la empresa (sociedades)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sociedad`
--

LOCK TABLES `Sociedad` WRITE;
/*!40000 ALTER TABLE `Sociedad` DISABLE KEYS */;
INSERT INTO `Sociedad` VALUES
(1,'RutDemo','Demo','Direccion Demo',1,1101,'Demo Ciudad',NULL,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1);
/*!40000 ALTER TABLE `Sociedad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SociedadUsuario`
--

DROP TABLE IF EXISTS `SociedadUsuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SociedadUsuario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `sociedad_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Usuario_SociedadUsuario` (`user_id`),
  KEY `FK_Sociedad_SociedadUsuario` (`sociedad_id`),
  CONSTRAINT `FK_Sociedad_SociedadUsuario` FOREIGN KEY (`sociedad_id`) REFERENCES `SociedadUsuario` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Usuario_SociedadUsuario` FOREIGN KEY (`user_id`) REFERENCES `Usuario` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de Asociación de los usuarios con las sociedades del cliente';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SociedadUsuario`
--

LOCK TABLES `SociedadUsuario` WRITE;
/*!40000 ALTER TABLE `SociedadUsuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `SociedadUsuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TiposEvento`
--

DROP TABLE IF EXISTS `TiposEvento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TiposEvento` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `tipo_evento` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_TiposEvento` (`sociedad_id`),
  CONSTRAINT `FK_Sociedad_TiposEvento` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar los tipos de eventos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TiposEvento`
--

LOCK TABLES `TiposEvento` WRITE;
/*!40000 ALTER TABLE `TiposEvento` DISABLE KEYS */;
/*!40000 ALTER TABLE `TiposEvento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TiposParametros`
--

DROP TABLE IF EXISTS `TiposParametros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TiposParametros` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `estado` tinyint(1) NOT NULL COMMENT '0 Inactivo 1 Activo',
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_TiposParametros` (`sociedad_id`),
  CONSTRAINT `FK_Sociedad_TiposParametros` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar los tipos parametros ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TiposParametros`
--

LOCK TABLES `TiposParametros` WRITE;
/*!40000 ALTER TABLE `TiposParametros` DISABLE KEYS */;
/*!40000 ALTER TABLE `TiposParametros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TiposPrestamos`
--

DROP TABLE IF EXISTS `TiposPrestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TiposPrestamos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `cuenta` varchar(30) DEFAULT NULL,
  `CCAF` tinyint(1) NOT NULL DEFAULT 0,
  `caja_compensacion_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_TiposPrestamos` (`sociedad_id`),
  CONSTRAINT `FK_Sociedad_TiposPrestamos` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de tipos de prestamos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TiposPrestamos`
--

LOCK TABLES `TiposPrestamos` WRITE;
/*!40000 ALTER TABLE `TiposPrestamos` DISABLE KEYS */;
/*!40000 ALTER TABLE `TiposPrestamos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TramosAsignacionFamiliar`
--

DROP TABLE IF EXISTS `TramosAsignacionFamiliar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TramosAsignacionFamiliar` (
  `id` bigint(20) NOT NULL,
  `tramo` varchar(5) NOT NULL,
  `desde` decimal(18,4) DEFAULT NULL,
  `hasta` decimal(18,4) DEFAULT NULL,
  `valor_carga` decimal(18,4) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de TramosImpuestoUnico';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TramosAsignacionFamiliar`
--

LOCK TABLES `TramosAsignacionFamiliar` WRITE;
/*!40000 ALTER TABLE `TramosAsignacionFamiliar` DISABLE KEYS */;
/*!40000 ALTER TABLE `TramosAsignacionFamiliar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TramosImpuestoUnico`
--

DROP TABLE IF EXISTS `TramosImpuestoUnico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TramosImpuestoUnico` (
  `id` int(11) NOT NULL,
  `tramo` varchar(50) NOT NULL,
  `desde` decimal(18,4) NOT NULL,
  `hasta` decimal(18,4) NOT NULL,
  `factor` decimal(18,4) DEFAULT NULL,
  `rebaja` decimal(18,4) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de TramosImpuestoUnico';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TramosImpuestoUnico`
--

LOCK TABLES `TramosImpuestoUnico` WRITE;
/*!40000 ALTER TABLE `TramosImpuestoUnico` DISABLE KEYS */;
/*!40000 ALTER TABLE `TramosImpuestoUnico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ubicacion`
--

DROP TABLE IF EXISTS `Ubicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ubicacion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `region_id` bigint(20) NOT NULL,
  `comuna_id` bigint(20) NOT NULL,
  `direccion` text NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Usuario_Ubicacion` (`user_id`),
  KEY `FK_Region_Ubicacion` (`region_id`),
  KEY `FK_Comuna_Ubicacion` (`comuna_id`),
  CONSTRAINT `FK_Comuna_Ubicacion` FOREIGN KEY (`comuna_id`) REFERENCES `Comunas` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Region_Ubicacion` FOREIGN KEY (`region_id`) REFERENCES `Regiones` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Usuario_Ubicacion` FOREIGN KEY (`user_id`) REFERENCES `Usuario` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=310 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de ubicación de los usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ubicacion`
--

LOCK TABLES `Ubicacion` WRITE;
/*!40000 ALTER TABLE `Ubicacion` DISABLE KEYS */;
INSERT INTO `Ubicacion` VALUES
(1,6,6,6101,'Av. Parque Viña Santa Blanca 0411 dpto. 303','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(2,7,13,13110,'JOSE MIGUEL CARRERA 679 CASA 471','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(3,8,13,13130,'Jose Joaquín Prieto 4260 dpto. 610','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(4,9,13,13120,'San Pedro 1751','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(5,10,13,13101,'SANTA ELENA 840 DPTO 604','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(6,11,13,13110,'LOS LITRES 10938 BLOCK 5 DEPTO C12','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(7,12,13,13101,'Zenteno 1482 dpto 1927','2021-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(8,13,13,13101,'EYZAGUIRRE 766 dep 526','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(9,14,13,13130,'QUINTA AVENIDA 1475','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(10,15,13,13130,'Santa Rosa 5741 - Depto. 2001 Torre A','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(11,16,13,13201,'Pasaje el Trazador 3467','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(12,17,13,13106,'COYHAIQUEO 6010','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(13,18,13,13201,'Carmen Doren Sur 05532','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(14,19,13,13505,'Av. Los Parques 651 dpto. 424','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(15,20,5,5801,'Calle Santa María 1221 casa 60','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(16,21,13,13106,'CONDE DEL MAULE 4642 dpto. 1212','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(17,22,13,13101,'CHILOÉ 3601 DPT 306','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(18,23,13,13130,'gran av jose miguel carrera 5380','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(19,24,13,13101,'Vicuña Mackenna 1231 dpto. 2223','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(20,25,13,13126,'Radal 1740 dpto. 35 J','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(21,26,13,13101,'Raulí 596, dpto. 2012','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(22,27,13,13101,'CHILOÉ 1221 DPTO 1201','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(23,28,13,13119,'AVENIDA AMERICO VESPUCIO 1184 dpto 1801','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(24,29,13,13201,'Psje Profesor Diego Barros Arana 425','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(25,30,5,5804,'Calle de la Aguada 654','2022-07-27 00:00:00','1990-01-01 00:01:00',1,1),
(26,31,13,13116,'Tres oriente 6532','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(27,32,13,13130,'WALKER MARTINEZ #6100 dpto E 53','2021-11-02 00:00:00','1990-01-01 00:01:00',1,1),
(28,33,13,13107,'Av. Recoleta 6336','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(29,34,13,13119,'Aves del paraíso 920','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(30,35,13,13113,'AV. BLEST GANA 5784','2020-11-10 00:00:00','1990-01-01 00:01:00',1,1),
(31,36,13,13101,'Ricardo Cumming 1355','2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
(32,37,13,13105,'av independencia 740 torre b dep 1223','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(33,38,13,13101,'CALLE COQUIMBO 1189 DPTO 828','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(34,39,13,13108,'colon 1377 dpto. 1908','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(35,40,13,13111,'Río Bio Bio 994','2020-08-04 00:00:00','1990-01-01 00:01:00',1,1),
(36,41,13,13119,'El verano 1188, maipu','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(37,42,13,13116,'Pje. Doce sur 03308','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(38,43,13,13106,'Av. Ecuador 5065 dpto. 1302','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
(39,44,13,13101,'vicuña mackenna 1725','2021-03-22 00:00:00','2023-12-26 22:48:23',1,1),
(40,45,5,5101,'Noruega 443, dpto. 74','2021-10-26 00:00:00','1990-01-01 00:01:00',1,1),
(41,46,13,13128,'Los Copihues 1815','2021-11-29 00:00:00','1990-01-01 00:01:00',1,1),
(42,47,13,13101,'Moneda 3090, dpto. 604 Torre 3030','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(43,48,13,13126,'Lo Ampuero 1595','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(44,49,13,13130,'SAN NICOLAS 1092 DPTO 606','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(45,50,13,13110,'Candalo Amarillo 10393 casa G','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(46,51,13,13106,'Alameda 4877','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(47,52,13,13122,'Calle Antofagasta 1204-C','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(48,53,13,13101,'Chiloé 1221, dpto. 1317','2021-07-26 00:00:00','1990-01-01 00:01:00',1,1),
(49,54,13,13102,'Ilan Ilan 4305','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(50,55,13,13120,'zañartu 1313 dep 1002','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(51,56,13,13201,'Río Simpson 4551','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(52,57,13,13101,'Santo Domingo 2816','2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
(53,58,13,13130,'Calle San Ignacio 3452 dpto. 115','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(54,59,13,13106,'AV. AEROPUERTO 216','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(55,60,13,13123,'Suecia 2401','2021-07-26 00:00:00','1990-01-01 00:01:00',1,1),
(56,61,13,13126,'Meza Bell 2851 Apto 543 torre K','2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
(57,62,13,13130,'Cuarta Avenida 1170','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(58,63,13,13130,'Locumba 6018 ','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(59,64,13,13201,'AV PLAZA VIVA 02282','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(60,65,13,13104,'MAR DE LAS ANTILLAS 3631 DPTO 6','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(61,66,13,13110,'Avenida Vicuña Mackenna Oriente 6640','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(62,67,13,13124,'SAN GABRIEL 8803-B','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(63,68,13,13201,'PASAJE LONGOVILO 2764','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(64,69,5,5101,'Av. Ecuador 326','2021-10-06 00:00:00','1990-01-01 00:01:00',1,1),
(65,70,13,13126,'pje catorce 4578','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(66,71,13,13101,'SAN FRANCISCO 42','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(67,72,13,13201,'Viña del Cerro Poniente 4472','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(68,73,13,13117,'Neptuno 945 dpto. 204','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(69,74,8,8111,'Los Notros 1020','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(70,75,13,13101,'Santa Isabel 176','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(71,76,5,5801,'Calle Puchuncaví 2171','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(72,77,13,13110,'Avenida La Florida 9650, dpto. 118','2022-02-21 00:00:00','1990-01-01 00:01:00',1,1),
(73,78,13,13130,'Álvarez de Toledo 764','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(74,79,13,13108,'GENERAL PRIETO 1717 DPTO 1208','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(75,80,13,13201,'Puquios 1169','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(76,81,13,13121,'Alcibiades 5310','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(77,82,13,13201,'Pje. Parque del Cielo 2449','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(78,83,13,13401,'Pasaje Amazonas 1382','2022-02-21 00:00:00','1990-01-01 00:01:00',1,1),
(79,84,13,13111,'Isla Picton 8613','2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
(80,85,13,13101,'Calle Arturo Prat 602 dpto. 405 Torre B','2022-02-25 00:00:00','1990-01-01 00:01:00',1,1),
(81,86,13,13302,'PASAJE SANTA CATALINA 372','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(82,87,13,13106,'Coronel Souper 4250 dpto. 1508','2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
(83,88,13,13130,'Pasaje Carlos Walker Martínez 5847, casa 1028','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(84,89,13,13130,'QUINTA AVENIDA 1475 DPTO 710','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(85,90,13,13110,'Senday 1286','2021-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(86,91,13,13201,'Los Salesianos 1883','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(87,92,13,13106,'Carlos Pezoa Veliz 143','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(88,93,13,13120,'TRANVERSAL SUAREZ MUJICA 2900 DPTO 84','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(89,94,13,13124,'PASAJE PUERTO RIO TRANQUILO Nº 127','2020-11-10 00:00:00','1990-01-01 00:01:00',1,1),
(90,95,13,13106,'coronel souper 4222 torre a dep 2310','2021-10-26 00:00:00','1990-01-01 00:01:00',1,1),
(91,96,13,13110,'santa edith 9766','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(92,97,13,13201,'COIHUECO 3263','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(93,98,13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(94,99,13,13101,'GORBEA 2551 DPTO 422','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(95,100,13,13101,'Sazie 2496','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(96,101,13,13101,'Santo Domingo 1161 dpto. 808','2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
(97,102,13,13110,'Los geranios 9608  DEPTO 1','2020-11-25 00:00:00','1990-01-01 00:01:00',1,1),
(98,103,13,13106,'coronel souper 4222 torre a dep 2310','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(99,104,13,13119,'Abisinia 1176 Villa el Abrazo','2021-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(100,105,13,13126,'SANTO DOMINGO 4047 DPTO 1807','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(101,106,8,8110,'Manuel Zañartu 668','2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
(102,107,13,13101,'SAN ISIDRO 96 DEPTO 813 ','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(103,108,13,13103,'Jorge Washington 1318','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
(104,109,13,13129,'AV. VICUÑA MACKENNA 2585 DPTO 205 B','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(105,110,13,13119,'Thiare 1099 dpto. 72','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(106,111,13,13101,'Placilla 047','2023-03-13 00:00:00','1990-01-01 00:01:00',1,1),
(107,112,13,13110,'Limache 767','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(108,113,8,8111,'Mariano Egaña 1061','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(109,114,13,13119,' La balada 391, dpto 3131','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(110,115,13,13101,'Santiago 1320 dpto. 516','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(111,116,13,13109,'Avenida Fernandez Albano 637 dpto. 1120','2022-03-27 00:00:00','1990-01-01 00:01:00',1,1),
(112,117,13,13110,'Las llaretas 2114','2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
(113,118,7,7401,'GUACOLDA 598','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(114,119,13,13605,'Larrain 2964 Casa 15','2022-01-26 00:00:00','1990-01-01 00:01:00',1,1),
(115,120,13,13130,'Guardia Marina Riquelme 4880 dpto. 102','2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
(116,121,13,13101,'SAN PABLO 1353 DEPTO 1401','2020-09-29 00:00:00','1990-01-01 00:01:00',1,1),
(117,122,13,13126,'Rivas Vicuña 1590','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(118,123,13,13101,'Sargento Aldea1156 Apti 1104A','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(119,124,13,13120,'730 Departamento 509-C ','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(120,125,13,13101,'CARMEN 557 dep 308','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(121,126,13,13126,'Jose Besa 1131','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(122,127,13,13109,'RAFAEL MONTT 6447 B11','2023-03-14 00:00:00','1990-01-01 00:01:00',1,1),
(123,128,13,13108,'el molino 1845','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(124,129,13,13106,'Av Ecuador 4578, dpto. 503','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(125,130,4,4102,'Francisco Carmona 630','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(126,131,13,13102,'Pasaje Los Satelites 7593','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(127,132,13,13124,'Av. Santa Victoria 851','2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
(128,133,13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(129,134,13,13125,'Av Infante Larrain 1900 Cond. Patagonia 1 N°23120 ','2020-08-03 00:00:00','2023-08-31 00:00:00',1,1),
(130,135,13,13111,'Av. Américo Vespucio Sur 0355','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(131,136,13,13120,'García Valenzuela 055 dpto.1805 B','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
(132,137,13,13110,'Vicuña Mackenna  10167','2020-08-03 00:00:00','2023-08-31 00:00:00',1,1),
(133,138,13,13125,'Estero Molulco 020','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(134,139,6,6101,'Sendero de La Paloma 3191','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(135,140,13,13101,'CARMEN 418 DPTO 515','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(136,141,13,13124,'Auka 161 depto 12','2020-08-04 00:00:00','1990-01-01 00:01:00',1,1),
(137,142,5,5109,'Angol 36','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(138,143,13,13605,'Pasaje Boldo 542','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(139,144,5,5109,'Calle vista al mar pasaje 3 forestal 161','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(140,145,13,13126,'SANTO DOMINGO 4047 dpto 1303','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(141,146,7,7102,'Egaña 655','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(142,147,13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(143,148,13,13113,'Avenida Tobalaba 7761 depto 41 b','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(144,149,13,13118,'Los Economistas 4638','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(145,150,13,13120,'pasaje 12 n°1508','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(146,151,13,13101,'SAN IGNACIO DE LOYOLA 824 DPTO 505','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(147,152,13,13123,'FRANCISCO PUELMA 26. DPTO 102 TORRE 30','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(148,153,13,13101,'YUNGAY 2570 A5  DPTO 301','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(149,154,13,13201,'pje padre luis espinal campos 1198','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(150,155,13,13120,'Eliecer Parada 1891 dpto. 200','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(151,156,13,13114,'GENERAL CARLOS URZUA 7061','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(152,157,13,13201,'Pasaje Los Ligustros 2274','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(153,158,13,13101,'Atacama 3041','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(154,159,13,13106,'OBISPO UMAÑA 033','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(155,160,13,13201,'PASAJE TENO 0202 OSCARBONILLA','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(156,161,13,13101,'Avenida Portugal 755, Depto 1201','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(157,162,13,13101,'San Pablo 1539 dep 1401','2020-08-04 00:00:00','1990-01-01 00:01:00',1,1),
(158,163,13,13106,'carlos pezoa veliz 143 dep 2816','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(159,164,13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(160,165,13,13101,'CHILOÉ 1221 DPTO 419','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(161,166,13,13201,'Calle el volcán 03102','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(162,167,13,13101,'SANTA ELENA 1722 DEP 309 TORRE B','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(163,168,13,13101,'ELEUTERIO RAMIREZ 825','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(164,169,13,13201,'MARTINICA 1183','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(165,170,13,13101,'Rosas 1339, dpto. 1203','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(166,171,13,13108,'Gamero 1399 dpto. 1412','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(167,172,4,4102,'Enrique Meiggs 120','2022-03-30 00:00:00','1990-01-01 00:01:00',1,1),
(168,173,13,13118,'Escuela Agrícola 1710 Condominio Los Andes Torre G depto 909','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(169,174,13,13201,'Los Paltos 0727','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(170,175,13,13401,'Puerto Murta 15533','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(171,176,13,13102,'Costanera norte 284 B dpto. 203','2022-08-26 00:00:00','1990-01-01 00:01:00',1,1),
(172,177,13,13126,'Los Andes de Violeta Parra 3721 dpto. B33','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(173,178,13,13101,'SANTA ISABEL # 431 DEPTO 1011','2020-09-29 00:00:00','1990-01-01 00:01:00',1,1),
(174,179,13,13101,'SANTA ISABEL 199, APTO 1204','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(175,180,13,13124,'Simon Bolivar 210','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(176,181,13,13120,'Av. José Pedro Alessandri 1498, dpto. 808','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
(177,182,5,5109,'Pasaje 41 Casa 5','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(178,183,13,13201,'misionera de la caridad 2 norte 2731','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(179,184,13,13121,'Lago Constancia 2070','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(180,185,13,13110,'Av. Vicuña Mackenna poniente 6800 dpto. 1303','2022-04-20 00:00:00','1990-01-01 00:01:00',1,1),
(181,186,13,13106,'AV. ECUADOR 4678','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(182,187,13,13401,'Fernando Vonome 1516','2021-10-12 00:00:00','1990-01-01 00:01:00',1,1),
(183,188,13,13110,'San Juan Crisóstomo  10742','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
(184,189,13,13201,'Pasaje Reibo 3865','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(185,190,5,5101,'Rodrigo de Triana 542','2021-10-06 00:00:00','1990-01-01 00:01:00',1,1),
(186,191,13,13130,'Av. Lazo 1171','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(187,192,13,13110,'Los Sauces 620','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(188,193,13,13101,'Teatinos 690 dpto. 2101','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(189,194,13,13120,'Irarrázaval 4900 dpto. 1803','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(190,195,13,13401,'Volcan Maipo 14924','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(191,196,13,13117,'CALLE OSORNO 5241','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(192,197,13,13401,'Franz Schubert 1668','2022-01-28 00:00:00','1990-01-01 00:01:00',1,1),
(193,198,13,13119,'Francisco Coloane IX 263','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(194,199,13,13108,'PABLO URZÚA 1481 dpto 1621A','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(195,200,13,13106,'Placilla 046','2023-03-13 00:00:00','1990-01-01 00:01:00',1,1),
(196,201,13,13106,'AV MARIA ROZAS VELASQUEZ 55','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(197,202,13,13108,'El Molino 1845','2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
(198,203,13,13101,'Calle Arturo Prat 602 dpto. 405 Torre B','2022-02-25 00:00:00','1990-01-01 00:01:00',1,1),
(199,204,13,13101,'Santa Elena 840','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(200,205,5,5804,'Andrés Bobe 2390','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(201,206,13,13109,'Carlos Condell 696','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(202,207,13,13101,'SAN IGNACIO DE LOYOLA 633','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(203,208,13,13101,'Lord Cochrane 376 Dpto 1916','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(204,209,5,5109,'Borinquen 32 Block 4 dpto. 404','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(205,210,13,13118,'Av. Macul 6305. Torre A dpto. 602','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(206,211,13,13116,'Nueve de enero 269','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(207,212,13,13126,'San Pablo 4135 dpto 502','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(208,213,13,13119,'Ignacio García Silva 2643','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(209,214,13,13120,'Elias de la Cruz 6','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(210,215,13,13121,'Estrella Blanca 4768','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(211,216,13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(212,217,13,13120,'La Proa 1276 depto. 24','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
(213,218,13,13101,'Av Manuel Rodríguez 53 depto 1308 ','2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
(214,219,13,13101,'Avenida Vicuña Mackenna 881, dpto. 1910 A','2022-01-28 00:00:00','1990-01-01 00:01:00',1,1),
(215,220,13,13201,'Pasaje Valle de Copiapo 3263','2022-02-21 00:00:00','1990-01-01 00:01:00',1,1),
(216,221,13,13119,'Pasaje los ingenieros 1177','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(217,222,13,13108,'Independencia 740, dpto. 1922 Bloque C','2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
(218,223,13,13101,'Coronel Souper 4222 B','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(219,224,13,13109,'Plaza castelar 01160 torre 4 depto 33','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(220,225,13,13118,'Av. Américo Vespucio 4641, dpto. 1301','2021-07-22 00:00:00','1990-01-01 00:01:00',1,1),
(221,226,13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(222,227,2,2101,'PASAJE NICOLAS GONZALEZ #8654','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(223,228,13,13122,'Parque Dos 1358','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(224,229,13,13110,'San Pablo 10877 dpto. 126','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(225,230,13,13110,'Salvador Sanfuentes 101','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
(226,231,13,13130,'María Auxiliadora 721 dpto. 1708 Torre A','2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
(227,232,13,13108,'Escanilla 255 dpto. 2505','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(228,233,13,13129,'Av. Santa Rosa 2648, dpto. 1110 B','2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
(229,234,13,13119,'REGIDOR ALBERTO BRAVO # 864','2020-09-29 00:00:00','1990-01-01 00:01:00',1,1),
(230,235,13,13201,'Marbella 85','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(231,236,6,6303,'El sauce sin número','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(232,237,13,13130,'Llico 1023','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(233,238,13,13110,'Americo Vespucio 6443 Dpto 111','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(234,239,13,13130,'Segunda avenida 1146 dpto 122','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(235,240,13,13101,'General Gana 1379, dpto. 306','2022-02-21 00:00:00','1990-01-01 00:01:00',1,1),
(236,241,13,1404,'Placilla 048','2023-03-13 00:00:00','1990-01-01 00:01:00',1,1),
(237,242,13,13126,'Carrascal 3880 Depto 406','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(238,243,13,13106,'Nicasio Retamales 115 Torre Oriente Dpto. 202','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(239,244,13,13125,'Pasaje El Llano 1038H dpto. 314','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(240,245,1,1107,'RAFAEL MONTT 6447 B12','2023-03-14 00:00:00','1990-01-01 00:01:00',1,1),
(241,246,13,13122,'Av. Las Torres 5490 block Q dpto 201','2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
(242,247,13,13111,'MANUEL RODRÍGUEZ 0385 ','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(243,248,13,13401,'Pasaje Coltauco 2215','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(244,249,13,13201,'Calle Portal Andino 01041','2021-07-20 00:00:00','1990-01-01 00:01:00',1,1),
(245,250,13,13119,'PASAJE LOS OCEANOS 521','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(246,251,13,13104,'Av. El Cortijo 2000','2021-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(247,252,13,13101,'Avenida viel 1320','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(248,253,13,13101,'portugal 990 dep 604','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(249,254,13,13122,'Calle 402 Ex Guanaqueros 4864','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(250,255,13,13102,'PASAJE PADRE JUAN LUCARINI 2632','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(251,256,13,13201,'Los Magnolios 652','2020-11-25 00:00:00','1990-01-01 00:01:00',1,1),
(252,257,13,13120,'EDUARDO CASTILLO VELASCO 4148','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(253,258,5,5103,'Av. El Lascar 75','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(254,259,13,13106,'av libertador bernardo ohiggins ','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(255,260,6,6101,'Calle Florencia 1787','2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
(256,261,13,13101,'Amunátegui 620','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(257,262,13,13401,'PASAJE PUERTO ESPAÑA 2053,','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(258,263,13,13118,'3 poniente 2765','2020-11-25 00:00:00','1990-01-01 00:01:00',1,1),
(259,264,13,13108,'Amalia Errazuriz 956','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(260,265,13,13119,'Pasaje Minerva 2925','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(261,266,5,5801,'Calle Pelantaro 1380','2022-06-20 00:00:00','1990-01-01 00:01:00',1,1),
(262,267,13,13114,'Duqueco 1965 depto 76','2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
(263,268,13,13120,'Jose Ignacio Vergara 3614','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(264,269,13,13104,'Av. General Gambino 3200 T15 dpto 203','2020-11-25 00:00:00','1990-01-01 00:01:00',1,1),
(265,270,13,13201,'RIO CHOLGUACO 5122','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(266,271,13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(267,272,13,13101,'SAN IGNACIO 1498 DEPTO 506','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(268,273,13,13401,'Urmeneta 381','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(269,274,13,1402,'Placilla 046','2023-03-13 00:00:00','1990-01-01 00:01:00',1,1),
(270,275,13,13106,'Nicasio Retamales 115, dpto. 1009 Torre Sur','2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
(271,276,13,13401,'Quebrada el Toro 1363','2021-04-21 00:00:00','1990-01-01 00:01:00',1,1),
(272,277,13,13126,'Rivas Vicuña 1590 dpto. 105','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(273,278,13,13119,'ANIBAL 2149','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(274,279,13,13201,'calle paine 02344 villa don ramon','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(275,280,13,13101,'MATURANA 750 BELLO CENTRO E306','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(276,281,5,5101,'Subida la Puntilla 20, Cerro Toro','2021-10-06 00:00:00','1990-01-01 00:01:00',1,1),
(277,282,13,13101,'coronel godoy 0128 dep 613','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(278,283,13,13106,'Coronel Souper 4222 B','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(279,284,13,13125,'LAS TORRES 158','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(280,285,13,13126,'Mariana Roman 2448','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(281,286,13,13401,'Jose Miguel Carrera 12030 dpto. 255 Torre Ñ','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(282,287,13,13201,'La Salvia 1885','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(283,288,13,13101,'Santa Rosa 146','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(284,289,15,15101,'RAFAEL MONTT 6447 B13','2023-03-14 00:00:00','2023-09-01 00:00:00',1,1),
(285,290,13,13106,'SANTA PETRONILA 32 DEPA 1922','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(286,291,13,13101,'General Gana 1063, dpto.  1019A','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(287,292,8,8108,'Gabriela Mistral 163','2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
(288,293,13,13101,'AV. SANTA ROSA 991 dpto. 1709','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(289,294,13,13127,'Los Pescadores 3355','2021-07-26 00:00:00','1990-01-01 00:01:00',1,1),
(290,295,13,13101,'GORBEA 2510 DPTO 518','2020-11-13 00:00:00','2023-10-18 00:00:00',1,1),
(291,296,13,13101,'apolo prueba 334','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(292,297,13,13201,'PASAJE HUENTELAUQUEN 807','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(293,298,13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(294,299,13,13101,'HUERFANOS 1400','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(295,300,5,5804,'Ignacio Carrera Pinto 0110 ','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(296,301,13,13101,'AV LIBERTADOR BERNARDO OHIGGINS 580 DEPTO 503','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(297,302,13,13111,'Vicuña Mackenna 0481','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(298,303,13,13101,'Portugal 810 dpto. 1712','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
(299,304,13,13401,'Cerro Yaretas 293','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(300,305,15,15101,'Pasaje 13 12982','2023-03-13 00:00:00','1990-01-01 00:01:00',1,1),
(301,306,13,13117,'Blasco Ibañez 3181','2020-08-03 00:00:00','2023-10-05 00:00:00',1,1),
(302,307,13,13302,'PASAJE SANTA CATALINA 372','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(303,308,13,13106,'conde del maule 4642 dep 303','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(304,309,13,13101,'Calle Santa Victoria 360, dpto. 1016','2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
(305,310,13,13111,'Los Girasoles 692','2021-10-06 00:00:00','1990-01-01 00:01:00',1,1),
(306,311,13,13106,'María Rosa Velázquez 65','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(307,312,13,13120,'av manuel montt 2440 dep 311','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(309,1,13,13106,'alguna dirección dos','2023-12-26 22:43:09','2023-12-26 22:45:30',1,1);
/*!40000 ALTER TABLE `Ubicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UnidadesPacto`
--

DROP TABLE IF EXISTS `UnidadesPacto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UnidadesPacto` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(150) NOT NULL,
  `estado` tinyint(1) NOT NULL COMMENT '0 Inactivo 1 Activo',
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar las unidades de pacto de los eventos de nomina';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UnidadesPacto`
--

LOCK TABLES `UnidadesPacto` WRITE;
/*!40000 ALTER TABLE `UnidadesPacto` DISABLE KEYS */;
INSERT INTO `UnidadesPacto` VALUES
(1,'UF',1,'2024-01-24 22:46:04','2024-01-24 22:46:04',1,1),
(2,'$',1,'2024-01-24 22:46:51','2024-01-24 22:46:51',1,1);
/*!40000 ALTER TABLE `UnidadesPacto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Usuario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rut` varchar(100) NOT NULL,
  `rut_provisorio` varchar(100) DEFAULT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellido_paterno` varchar(100) NOT NULL,
  `apellido_materno` varchar(100) DEFAULT NULL,
  `fecha_nacimiento` date NOT NULL,
  `sexo_id` bigint(20) NOT NULL,
  `estado_civil_id` bigint(20) NOT NULL,
  `nacionalidad_id` bigint(20) NOT NULL,
  `username` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `activo` tinyint(1) NOT NULL COMMENT 'campo para activar o no al usuario 0 Inactivo 1 Activo',
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rut` (`rut`),
  UNIQUE KEY `username` (`username`),
  KEY `FK_Nacionalidad_Usuario` (`nacionalidad_id`),
  KEY `FK_Sexo_Usuario` (`sexo_id`),
  KEY `FK_EstadoCivil_Usuario` (`estado_civil_id`),
  CONSTRAINT `FK_EstadoCivil_Usuario` FOREIGN KEY (`estado_civil_id`) REFERENCES `EstadoCivil` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Nacionalidad_Usuario` FOREIGN KEY (`nacionalidad_id`) REFERENCES `Nacionalidad` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Sexo_Usuario` FOREIGN KEY (`sexo_id`) REFERENCES `Sexo` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=315 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de  usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES
(1,'1','','Admin','Root','','1990-01-01',1,1,1,'root','$2b$12$r/z4etm/Z1izSDLkb9swku2FbOljYJ94gHBKMLjL4B/RaNTdMJIZi',1,'1990-01-01 00:00:00','1990-01-01 00:00:00',1,1),
(2,'12345678912','','PEDRO','PEREZ','MARTINEZ','1990-01-01',1,1,1,'pperez','$2b$12$BL2XazDDIhnsX4gIFe5rQOsSRdQL0NJccMFgbRywi57GszMW2H6.O',1,'2023-12-13 19:27:40','2023-12-13 19:27:40',1,1),
(6,'17133964-2','','MIRELLA DEL PILAR','SEPULVEDA','ORTIZ','1988-11-26',2,2,1,'17133964-2','$2b$12$P8fLOyoAA3d8lyKBMlA7vuQ3nVRbgS4juc/dShMH7TTXJAY4HPfJW',1,'2022-03-28 00:00:00','2023-12-20 21:57:46',1,1),
(7,'17316832-2','','Alex Patricio ','Baeza ','Hidalgo ','1990-04-19',1,1,1,'17316832-2','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(8,'26732301-1','','FANNY YUDMARY ','LAPREA ','BRICEÑO','1972-01-21',2,1,3,'26732301-1','12345678',1,'2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(9,'16713156-5','','PAMELA ANDREA','CARRASCO','YAÑEZ','1987-05-26',2,1,1,'16713156-5','12345678',1,'2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(10,'26744663-6','','Lila Rafaela ','Requeña ','Morillo ','1987-04-27',2,1,3,'26744663-6','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(11,'16643709-1','','Macarena Elizabeth  ','Bustamante ','Sánchez','1987-07-16',2,2,1,'16643709-1','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(12,'18166693-5','','GONZALO EDUARDO','VERGARA','VILCHEZ','1992-05-10',1,1,1,'18166693-5','12345678',1,'2021-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(13,'26791142-8','','July ','Mendez ','Alarcón ','1980-07-29',2,1,3,'26791142-8','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(14,'19280828-6','','Daniela Muriel','Parraguez ','Pérez ','1996-05-18',2,1,1,'19280828-6','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(15,'27016371-8','','Osmar De Jesus ','Barrios','Salazar ','1990-12-18',1,1,3,'27016371-8','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(16,'19027132-3','','JONATHAN BYRON','LARA','PRIETO','1995-07-20',1,1,1,'19027132-3','12345678',1,'2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(17,'19561320-6','','DANITZA ITZIAR','MALDONADO','BASUALTO','1997-07-18',2,1,1,'19561320-6','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(18,'19585453-K','','FRANCISCO JAVIER','LEON','ACOSTA','1997-06-03',1,1,1,'19585453-K','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(19,'27658687-4','','ALBA ANDREINA ','CARDENAS ','MEDINA','1988-03-18',2,1,3,'27658687-4','12345678',1,'2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(20,'15727711-1','','PRISCILA SAMARA',' LOYOLA ','LEIVA','1983-08-05',2,1,1,'15727711-1','12345678',1,'2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(21,'27221867-6','','Gabriela Alejandra ','Torres','Sejias ','1996-06-04',2,1,3,'27221867-6','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(22,'27072989-4','','Rebeca Nataly  ','Mora ','Zapata ','1986-02-24',2,2,3,'27072989-4','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(23,'19657604-5','','Jessica Carolina','Acosta','Blanco','1987-07-14',2,1,1,'19657604-5','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(24,'18832098-8','','JONATHAN PATRICIO ','HERNANDEZ',' RUIZ','1994-08-10',1,1,1,'18832098-8','12345678',1,'2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(25,'19282642-K','','CAMILA CONSTANZA ','TILLEMANN ','ROSALES','1996-03-27',2,1,1,'19282642-K','12345678',1,'2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(26,'26519143-6','','BARBARA PRISCILLA NOHEMI','ROMERO','BOADA','2002-12-04',2,1,3,'26519143-6','12345678',1,'2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(27,'26052313-9','','Veronica Johanna ','Lizcano ','Laguado ','1980-07-21',2,1,3,'26052313-9','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(28,'26322977-0','','Desiree solange ','Uranga ','Paz','1986-07-25',2,1,3,'26322977-0','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(29,'13296134-4','','DANIELA ANDREA','ARAYA','BUSTAMANTE','1977-07-30',2,2,1,'13296134-4','12345678',1,'2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(30,'9201636-6','','DIMNA RAQUEL ','PEREIRA ','VENEGAS','1962-04-24',2,2,1,'9201636-6','12345678',1,'2022-07-27 00:00:00','1990-01-01 00:01:00',1,1),
(31,'18904649-9','','NAYARETH VERIOSKA','BALLESTEROS','PARDO','1994-08-29',2,1,1,'18904649-9','12345678',1,'2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(32,'14149036-2','','ADRIAN ALEJANDRO','AQUEVEQUE','ANABALON','1975-12-29',1,2,1,'14149036-2','12345678',1,'2021-11-02 00:00:00','1990-01-01 00:01:00',1,1),
(33,'20448340-K','','KARINA DE LAS MERCEDES ','GONZÁLEZ','QUILODRAN','2000-05-29',2,1,1,'20448340-K','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(34,'25113955-5','','ROSSANA VANESSA ','RUSSO',' DEDATO','1987-04-15',2,1,3,'25113955-5','12345678',1,'2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(35,'27092969-9','','Angelica Maria ','Loaiza','Marin','1994-09-04',2,1,3,'27092969-9','12345678',1,'2020-11-10 00:00:00','1990-01-01 00:01:00',1,1),
(36,'21078983-9','','Josefina Antonia ','Villavicencio','Tejo','2001-05-08',2,1,1,'21078983-9','12345678',1,'2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
(37,'26427773-6','','Dairelis Milagri','Escalona','Vergara','1982-07-10',2,1,3,'26427773-6','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(38,'26694579-5','','THAILA LORENA','CONTRERAS','CARRERO','1994-01-04',2,1,3,'26694579-5','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(39,'27413879-3','','Mario Jose','Medina','Perez','1963-11-29',1,2,3,'27413879-3','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(40,'13075223-3','','Claudia Carolina  ','Roman ','Acevedo','1976-02-09',2,1,1,'13075223-3','12345678',1,'2020-08-04 00:00:00','1990-01-01 00:01:00',1,1),
(41,'19172460-7','','Camila Aurora','Martínez','Figueroa','1995-08-25',2,1,1,'19172460-7','12345678',1,'2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(42,'18442190-9','','PAULINA FERNANDA','PALOMINOS','LETELIER','1993-05-16',2,2,1,'18442190-9','12345678',1,'2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(43,'26560659-8','','Mari Estella ','Suárez','Sierra','2001-09-11',2,1,5,'26560659-8','12345678',0,'2021-09-27 00:00:00','2024-01-04 18:14:18',1,1),
(44,'26687813-3','','Ronny Jesus','Villa ','Reyes','1995-12-16',1,1,3,'26687813-3','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(45,'15076934-5','','Kevin Mike ','Pizarro','Pizarro','1998-03-05',1,1,1,'15076934-5','12345678',1,'2021-10-26 00:00:00','1990-01-01 00:01:00',1,1),
(46,'20434367-5','','Scarlett Alejandra ','Penno','Angulo','2000-07-08',2,1,1,'20434367-5','12345678',1,'2021-11-29 00:00:00','1990-01-01 00:01:00',1,1),
(47,'12248435-1','','MARCELA PAZ','MEDINA','ROMERO','1971-11-08',2,1,1,'12248435-1','12345678',1,'2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(48,'17769013-9','','FANNY ANDREA','GONZÁLEZ','CÁRCAMO','1990-10-11',2,1,1,'17769013-9','12345678',1,'2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(49,'25971983-6','','Johanna Alexandra ','Mendez ','Campos ','1985-08-03',2,1,3,'25971983-6','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(50,'18361318-9','','KARINA FERNANDA','SÁNCHEZ','BELLO','1993-03-01',2,1,1,'18361318-9','12345678',1,'2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(51,'26985625-4','','Maria Valeria',' Orozco',' Barcos','1992-08-05',2,1,3,'26985625-4','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(52,'27130213-4','','ZORAIMA GREGORIA','DORANTES','','1965-03-09',2,1,3,'27130213-4','12345678',1,'2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(53,'26834387-3','','Mileizy Josefina','Alvarado ','Colmenarez','1990-02-24',2,1,3,'26834387-3','12345678',1,'2021-07-26 00:00:00','1990-01-01 00:01:00',1,1),
(54,'18156986-7','','KUNYA BIHARI','CARDENAS','FARIÑA','1991-04-01',2,1,1,'18156986-7','12345678',1,'2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(55,'26225368-6','','ORMAGLYS KLARETT','RODULFO','HERNANDEZ','1982-10-23',2,2,3,'26225368-6','12345678',1,'2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(56,'19829460-8','','FABIOLA ALEJANDRA','LÓPEZ','RAMÍREZ','1997-10-30',2,1,1,'19829460-8','12345678',1,'2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(57,'25785161-3','','Joiner Levi','Contreras','Serrano','1996-02-07',1,1,3,'25785161-3','12345678',1,'2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
(58,'26603969-7','','PETRA YUBRANNY ','GARCIA','PIÑA','1984-08-22',2,2,3,'26603969-7','12345678',1,'2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(59,'13455128-3','','Iván Javier ','Perez','Abrigo ','1978-10-29',1,1,1,'13455128-3','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(60,'17267685-5','','Francisca Andrea','Encina ','Krumel','1989-08-10',2,1,1,'17267685-5','12345678',1,'2021-07-26 00:00:00','1990-01-01 00:01:00',1,1),
(61,'26767932-0','','Beatriz Catherina','Chavez ','Diaz','1969-04-03',2,1,3,'26767932-0','12345678',1,'2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
(62,'19344356-7','','GLORIA DANIELA','RIQUELME','TAPIA','1996-08-03',2,1,1,'19344356-7','12345678',1,'2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(63,'19585408-4','','Valentina Ignacia','Castro','Meza','1997-06-03',2,1,1,'19585408-4','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(64,'16441251-2','','Nataly Victoria ','Roman','Arrey','1986-08-26',2,1,1,'16441251-2','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(65,'26658938-7','','SCARLETH VANESSA','FALCON','ROSALES','1993-10-07',2,1,3,'26658938-7','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(66,'26091737-4','','Maibelys Grisbeth ','Leon ','Acosta','1994-05-11',2,1,3,'26091737-4','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(67,'27224192-9','','WISBELY DAYANNA','SANCHEZ','LINARES','1988-06-01',2,1,3,'27224192-9','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(68,'14195110-6','','MIGUEL ANGEL','HERWITTE','SEPULVEDA','1981-05-16',1,1,1,'14195110-6','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(69,'19206864-9','','Pía Constanza ','Aguilar ','Orellana','1996-04-09',2,1,1,'19206864-9','12345678',1,'2021-10-06 00:00:00','1990-01-01 00:01:00',1,1),
(70,'26501255-8','','Teddys Eduardo','Urdaneta ','Urdaneta','1985-10-24',1,1,3,'26501255-8','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(71,'26923220-K','','YASMARY DEL CARMEN','TROCONIS','ROJAS','1985-10-22',2,1,3,'26923220-K','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(72,'18103015-1','','DIEGO HERNÁN','CIFUENTES','SANDOVAL','1992-05-04',1,1,1,'18103015-1','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(73,'27030909-7','','EMILY FERNANDA ','INFANTE','GIL','1990-05-13',2,1,3,'27030909-7','12345678',1,'2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(74,'19553601-5','','KENDRA MARION','ARANEDA','OTTERMAM','1996-04-22',2,1,1,'19553601-5','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(75,'26382954-9','','SAMAI NOHEMI','AGUILLON ','RAMIREZ','1990-07-01',2,2,3,'26382954-9','12345678',1,'2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(76,'11620500-9','','MILITZA KAREN ','LOPEZ ','BRICEÑO','1970-04-11',2,1,1,'11620500-9','12345678',1,'2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(77,'15354713-0','','ANDREA DE LOS ANGELES ','ACEVEDO ','RUIZ','1993-01-21',2,1,1,'15354713-0','12345678',1,'2022-02-21 00:00:00','1990-01-01 00:01:00',1,1),
(78,'27081970-2','','LAURA ALEJANDRA','DUARTE','FEREIRA','1999-03-12',2,1,3,'27081970-2','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(79,'26438678-0','','VIVIANA KATHERINE','DIAZ','SALAS','1990-02-06',2,2,3,'26438678-0','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(80,'17610517-8','','MARIA JOSE','LEON','DONOSO','1990-09-28',2,1,1,'17610517-8','12345678',1,'2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(81,'9672610-4','','LORENA IVONNE ','ALEGRIA',' GONZALEZ','1965-10-23',2,1,1,'9672610-4','12345678',1,'2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(82,'26141420-1','','EMMANUEL BENITO ','PEREZ','','1992-07-18',1,2,3,'26141420-1','12345678',1,'2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(83,'18027802-8','','DANIEL PABLO ','ALARCON ','PEREZ','1992-04-29',1,1,1,'18027802-8','12345678',1,'2022-02-21 00:00:00','1990-01-01 00:01:00',1,1),
(84,'27125790-2','','Andrea Carolina','Torrealba ','Quiroz','1999-11-10',2,1,3,'27125790-2','12345678',1,'2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
(85,'27163493-5','','DORIS JOSEFINA',' MELENDEZ','DE HERNANDEZ','1976-11-02',2,1,3,'27163493-5','12345678',1,'2022-02-25 00:00:00','1990-01-01 00:01:00',1,1),
(86,'20473681-2','','Esteban Eduardo ','Araneda ','Rodríguez ','2000-10-28',1,1,1,'20473681-2','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(87,'27231665-1','','ANGEL DE JESUS ','ORTEGA ','TORRES','1988-08-07',1,1,3,'27231665-1','12345678',1,'2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
(88,'16519804-2','','Paulina Marcela','Galleguillos','Ormeño','1987-03-13',2,1,1,'16519804-2','12345678',1,'2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(89,'27160861-6','','LEYLIN MAR','ORDAZ','ORDAZ','1991-06-28',2,1,3,'27160861-6','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(90,'12880697-0','','FRANCISCO JAVIER','CARRILLO','TAGLE','1974-12-22',1,2,1,'12880697-0','12345678',1,'2021-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(91,'20452650-8','','TIARE DANAE','BAEZA','DONOSO','2000-05-08',2,1,1,'20452650-8','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(92,'26928823-K','','JOSUE','BARROS','COBO','1991-02-16',1,1,3,'26928823-K','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(93,'26611433-8','','MARIA MAGDELEY','PEREZ','RIVERO','1968-10-23',2,2,3,'26611433-8','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(94,'15667455-9','','Carolina Inés','Farías','Salazar','1984-01-18',2,1,1,'15667455-9','12345678',1,'2020-11-10 00:00:00','1990-01-01 00:01:00',1,1),
(95,'44280493-1','','Shary Guadalupe ','Castillo ','Hernandez','1994-12-15',2,2,3,'44280493-1','12345678',1,'2021-10-26 00:00:00','1990-01-01 00:01:00',1,1),
(96,'26203037-7','','Kimberly Dayana','Velasquez','Lopez','1994-12-16',2,1,3,'26203037-7','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(97,'17936780-7','','VALESKA PAULINA','AGUILERA','MÁNQUEZ','1991-06-25',2,1,1,'17936780-7','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(98,'17411434-K','','Daniela Margarita','González','Acosta','1999-03-01',2,1,1,'17411434-K','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(99,'26156334-7','','TAIMI','CARRILLO','DIAZ','1989-09-01',2,1,1,'26156334-7','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(100,'19176716-0','','CLAUDIA ESTEFANIA','OLGUIN','LEON','1997-01-24',2,1,1,'19176716-0','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(101,'19848318-4','','CAMILA IGNACIA ','ALARCON ','RAMIREZ','1998-03-27',2,1,1,'19848318-4','12345678',1,'2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
(102,'18076015-6','','CRISTYN ADRIANA','COFRE','CHARLES','1992-05-15',2,1,1,'18076015-6','12345678',1,'2020-11-25 00:00:00','1990-01-01 00:01:00',1,1),
(103,'27629290-0','48215314-3','Shary Guadalupe','Castillo','Hernandez','1994-12-15',2,2,3,'27629290-0','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(104,'19586856-5','','JORGE AGUSTÍN','TOBAR','QUINTANILLA','1997-09-16',1,1,1,'19586856-5','12345678',1,'2021-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(105,'26362258-8','','Nohelia Pastora ','Gimenez ','Sanchez ','1964-09-11',2,2,3,'26362258-8','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(106,'17649726-2','','NATACHA BEATRIZ',' OSORIO ','CARCAMO','1990-07-19',2,2,1,'17649726-2','12345678',1,'2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
(107,'26070028-6','','Rafael','Pinto','Crowell','1974-12-24',1,1,3,'26070028-6','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(108,'17306680-5','','Nicole de Lourdes','Estay','Estay','1990-01-03',2,1,1,'17306680-5','12345678',1,'2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
(109,'26231217-8','','Giojhana Eloina ','Yajure','Perez','1993-09-23',2,1,3,'26231217-8','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(110,'15845827-6','','MARIA GABRIELA ','NEIRA','HIDALGO','1984-10-11',2,1,1,'15845827-6','12345678',1,'2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(111,'38528074-2','','JOSE','RAMIREZ','','1983-08-05',1,1,1,'38528074-2','12345678',1,'2023-03-13 00:00:00','1990-01-01 00:01:00',1,1),
(112,'20225557-4','','CLAUDIA PASCAL','FUENTES','ROJAS','1999-09-11',2,1,1,'20225557-4','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(113,'15170740-8','','GERALDINE ISABEL ','MORA ','BAHAMONDE','1982-09-04',2,1,1,'15170740-8','12345678',1,'2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(114,'19064229-1','','Massiel Scarlette','Diaz ','Carrasco ','1995-08-18',2,1,1,'19064229-1','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(115,'26581867-6','','Catherine','Casuso','Fernández','2000-09-04',2,1,1001,'26581867-6','12345678',1,'2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(116,'19516012-0','','MARCELO FERNANDO','GUTIERREZ ','LOIZA','1996-11-06',1,1,1,'19516012-0','12345678',1,'2022-03-27 00:00:00','1990-01-01 00:01:00',1,1),
(117,'27176740-4','','THOMAS EXEQUIEL ','LARA',' MARTINEZ','2003-08-29',1,1,1,'27176740-4','12345678',1,'2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
(118,'15140657-2','','Yasna Graciela ','Henriquez',' Orellana','1983-08-07',2,1,1,'15140657-2','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(119,'19993608-5','','FRANCISCO JAVIER ','TOLOZA','RAMÍREZ','1998-08-01',1,1,1,'19993608-5','12345678',1,'2022-01-26 00:00:00','1990-01-01 00:01:00',1,1),
(120,'26710014-4','','KEILY MAOLY ','VILLALOBOS ','ALVARADO','1987-06-05',2,1,3,'26710014-4','12345678',1,'2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
(121,'27223670-4','','MARCOS ANTONIO','DIAMOMD','SOLER','1988-02-04',1,1,3,'27223670-4','12345678',1,'2020-09-29 00:00:00','1990-01-01 00:01:00',1,1),
(122,'25590137-0','','SAIDA KRUSKALLA','VALERA','MORENO','1985-01-30',2,2,3,'25590137-0','12345678',1,'2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(123,'26265074-K','','Carla Ydaloi ','Pellegrino ','Garcia','1993-07-16',2,1,3,'26265074-K','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(124,'26756709-3','','Argenis Miguel','Riera','Torres','1958-02-05',2,2,3,'26756709-3','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(125,'27334558-2','','Lauri Beatriz ','Rodriguez','Benitez','1983-07-22',2,2,3,'27334558-2','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(126,'18824199-9','','PAULA CAMILA','GALAZ','MOIL','1994-06-09',2,1,1,'18824199-9','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(127,'16791651-1','','ROSARIO','LOCTOSA','MARTINEZ','1955-05-24',2,2,1,'16791651-1','12345678',1,'2023-03-14 00:00:00','1990-01-01 00:01:00',1,1),
(128,'44208350-9','44208350-9','Josephline Adriana','Rojas ','Salcedo','1996-09-02',2,1,3,'44208350-9','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(129,'25794898-6','','BEATRIZ EULALIA','MARTINEZ','FINOL','1977-12-31',2,2,3,'25794898-6','12345678',1,'2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(130,'12568851-9','','CARLA MARISEL','ZEPEDA','ESCOBAR','1974-07-23',2,1,1,'12568851-9','12345678',1,'2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(131,'13246899-0','','Roberto Eduardo ','Figueroa ','Tapia','1976-10-16',1,1,1,'13246899-0','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(132,'17072831-9','','VANIA ANTONIA','HERRERA','RAVANALES','1989-02-27',2,1,1,'17072831-9','12345678',1,'2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
(133,'26296365-9','','Diego Alejandro','Silva ','Martínez','1999-03-01',1,1,1,'26296365-9','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(134,'27190289-1','','Eliangeli Caterine',' Sánchez ','Ginez','1987-03-31',2,1,3,'27190289-1','12345678',1,'2020-08-03 00:00:00','2023-08-31 00:00:00',1,1),
(135,'19637330-6','','Simón Elías','Barrera','Gutiérrez','1997-10-22',2,1,1,'19637330-6','12345678',1,'2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(136,'26267939-K','','Lizmar Alejandra','Sayago','Moreno','1991-12-03',2,1,3,'26267939-K','12345678',1,'2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
(137,'27135068-6','','Jesús Augusto ','Zárraga  ','Roque','1977-06-12',1,1,3,'27135068-6','12345678',1,'2020-08-03 00:00:00','2023-08-31 00:00:00',1,1),
(138,'18629112-3','','JENNIFER JUDITH',' OSORIO',' VELIZ','1994-05-08',2,1,1,'18629112-3','12345678',1,'2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(139,'19228849-5','','MARIA ISABEL','HERDOCIO',' GONZALEZ','1996-01-22',2,1,1,'19228849-5','12345678',1,'2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(140,'26610299-2','','Leidy Mariana ','Urbina ','Higuera ','1986-12-06',2,1,3,'26610299-2','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(141,'19315710-6','','Isabel Ivonne','Osorio','Mora ','1996-07-31',2,1,1,'19315710-6','12345678',1,'2020-08-04 00:00:00','1990-01-01 00:01:00',1,1),
(142,'21129190-7','','DAVID YERKO BENJAMÍN ','GODOY ','MORENO','2002-09-13',1,1,1,'21129190-7','12345678',1,'2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(143,'19545849-9','','CATALINA JAVIERA ','AHUMADA ','MARTINEZ','1997-01-17',2,1,1,'19545849-9','12345678',1,'2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(144,'20342635-6','','KAREN ANDREA','OLAVE','AHUMADA','1995-06-30',2,1,1,'20342635-6','12345678',1,'2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(145,'26878985-5','','Zulay Coromoto ','Salas ','Colina ','1960-10-03',1,2,3,'26878985-5','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(146,'15835053-K','','Paula Catherine ','Barrera ','Pulgar','1984-06-21',2,1,1,'15835053-K','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(147,'22319984-4','','Angela Maria','Aguilar','Buitrago','1999-03-01',2,1,3,'22319984-4','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(148,'26275957-1','','CLAUDIA BRICEY','GRANADILLO','SANGUINO','1990-09-03',2,1,3,'26275957-1','12345678',1,'2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(149,'26825475-7','','Ruben Dario ','Escalona ','Torrealba','1972-12-08',1,1,3,'26825475-7','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(150,'26955770-2','','YOHELIS DAYEHEN','RODRIGUEZ','LUGO','1993-07-11',2,2,3,'26955770-2','12345678',1,'2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(151,'27128004-1','','LUVYS COROMOTO','PEREIRA','LUJANO','1970-07-24',2,1,3,'27128004-1','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(152,'27169720-1','','Jose Gregorio ','Zamora ','Marcano ','1990-06-19',1,1,3,'27169720-1','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(153,'26777002-6','','Yurayma Mercedes','Hernández ','Guzmán ','1971-09-07',2,1,3,'26777002-6','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(154,'26760332-4','','Reina ','Marbel','Hernandez','1968-01-08',2,1,3,'26760332-4','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(155,'17406767-8','','TOMÁS IGNACIO','FUENZALIDA','CASTRO','1990-04-29',1,1,1,'17406767-8','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(156,'26984006-4','','Alexander Alonso ','Carvajalin ','Castillo ','1974-07-03',1,1,3,'26984006-4','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(157,'17009958-3','','ALEXANDRA CAROLINA','REYES','LOBOS','1989-06-25',2,1,1,'17009958-3','12345678',1,'2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(158,'16619882-8','','Cinthya Angelica ','Loyola ','Dono','1988-01-20',2,1,1,'16619882-8','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(159,'26298547-4','','Yira Del Milagro ','Romero ','Figueroa ','1991-11-26',2,1,3,'26298547-4','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(160,'19004989-2','','ABRAHAM OSIRID','LABRA','MENESES','1995-05-25',1,1,1,'19004989-2','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(161,'27175247-4','','Jorge Luis ','Piñero','Martinez','1956-01-04',1,2,3,'27175247-4','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(162,'26598875-K','','Ney De Jesus ','Duarte','','1980-12-11',1,1,3,'26598875-K','12345678',1,'2020-08-04 00:00:00','1990-01-01 00:01:00',1,1),
(163,'27132993-8','','Gabriela Andrea','Vargas ','Barros','1994-03-02',2,2,3,'27132993-8','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(164,'19889657-8','','Benjamín Jacob','Diaz','Vargas','1999-03-01',1,1,1,'19889657-8','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(165,'26440697-8','','Tibisay Vanessa','Arcia ','Bohórquez ','1991-03-28',2,1,3,'26440697-8','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(166,'16682616-0','','Pyell Ángela Andrea','Varela','Berríos','1988-01-25',2,2,1,'16682616-0','12345678',1,'2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(167,'27117965-0','','Anyi Estefanía ','Marín ','Hernández','1994-06-11',2,1,5,'27117965-0','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(168,'25832848-5','','MARÍA PAULA ','BETANCOURT','REINOSO','1994-10-31',2,1,5,'25832848-5','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(169,'19063164-8','','CAMILA ELENA STEPHAN','ORTIZ','QUEZADA','1995-07-03',2,1,1,'19063164-8','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(170,'26845322-9','','RICHARD GERMAN','GONZALEZ','','1957-08-27',1,2,3,'26845322-9','12345678',1,'2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(171,'25658191-4','','OSDEIRYT CRISTINA','RINCON','SANTOS','1985-09-14',2,1,3,'25658191-4','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(172,'15982188-9','','JASMINE ANDREA ','GALVEZ ','CASTAGNETO','1985-03-11',2,2,1,'15982188-9','12345678',1,'2022-03-30 00:00:00','1990-01-01 00:01:00',1,1),
(173,'27308478-9','','MARIA LAURA','VELIZ ','TORRES','1973-11-09',2,1,3,'27308478-9','12345678',1,'2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(174,'15771049-4','','Daniela Paz ','Maldonado','Cancino','1984-04-28',2,1,1,'15771049-4','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(175,'15667402-8','','Wilson','Rozamel','Fierro','1984-02-27',2,2,3,'15667402-8','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(176,'26584105-8','','GERALDINE ABELINA',' AVILA ','BAUTISTA','1988-01-20',2,1,3,'26584105-8','12345678',1,'2022-08-26 00:00:00','1990-01-01 00:01:00',1,1),
(177,'12087635-K','','ANA PAOLA',' IBARRA ','VALENZUELA','1968-12-21',2,1,1,'12087635-K','12345678',1,'2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(178,'26540713-7','','Jhoselyn Desiree',' Vera',' Rangel','1991-07-15',2,1,3,'26540713-7','12345678',1,'2020-09-29 00:00:00','1990-01-01 00:01:00',1,1),
(179,'27322082-8','','Adalgiza ','Alizo','De Gil ','1964-05-24',2,2,3,'27322082-8','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(180,'13587143-5','','Paola Andrea ','Guarda','Alamos','1979-02-02',2,1,1,'13587143-5','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(181,'26018791-0','','Alondra Vanessa','Colmenares','Amador','2003-12-23',2,1,3,'26018791-0','12345678',1,'2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
(182,'16776630-7','','Jennifer Jacqueline','Cárdenas','Hinojosa','1988-01-25',2,1,1,'16776630-7','12345678',1,'2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(183,'13772708-0','','María De Los Angeles','Sepúlveda','Ruiz','1980-07-21',2,1,1,'13772708-0','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(184,'16355559-K','','Sebastián Ignacio','Cruzat','Hermosilla','1986-03-15',1,1,1,'16355559-K','12345678',1,'2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(185,'19317780-8','','FABIAN IGNACIO',' LILLO ','VALENZUELA','1995-12-22',1,1,1,'19317780-8','12345678',1,'2022-04-20 00:00:00','1990-01-01 00:01:00',1,1),
(186,'27052747-7','','YOBANA ANDREA','TELLO','SÁNCHEZ','1990-12-15',2,1,3,'27052747-7','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(187,'9976247-0','','Rosa Elena ','Arriagada ','Miquelez ','1970-06-12',2,1,1,'9976247-0','12345678',1,'2021-10-12 00:00:00','1990-01-01 00:01:00',1,1),
(188,'17908720-0','','Nicole Beatriz','Fabres ','Tolosa','1992-02-13',2,1,1,'17908720-0','12345678',1,'2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
(189,'13030026-K','','ANGÉLICA YOLANDA','RAMÍREZ','MONTECINOS','1976-03-06',2,1,1,'13030026-K','12345678',1,'2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(190,'16747776-3','','Paola Elizabeth ','Rebolledo ','Leal','1988-02-12',2,1,1,'16747776-3','12345678',1,'2021-10-06 00:00:00','1990-01-01 00:01:00',1,1),
(191,'19996523-9','','CAMILA ANTONIA','CASANOVA','ZARZAR','1998-09-02',2,1,1,'19996523-9','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(192,'15894160-0','','NATALIA MACARENA ','GALLARDO','HERRERA','1984-12-30',2,2,1,'15894160-0','12345678',1,'2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(193,'26576034-1','','Jean Carlos','Marín','Vargas','1988-10-29',1,1,3,'26576034-1','12345678',1,'2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(194,'19116812-7','','CRISTOPHER ANDRÉS','GONZÁLEZ','DONOSO','1995-07-17',1,1,1,'19116812-7','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(195,'14352859-6','','VANESSA ALEJANDRA','CASTRO','OSORES','1978-12-03',2,2,1,'14352859-6','12345678',1,'2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(196,'26908847-8','','FRANCELIS DEL CARMEN','PINTO','TORREALBA','1995-01-07',2,2,3,'26908847-8','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(197,'19024199-8','','ALEXANDRA ROMANE','PALMA','MONSALVEZ','1995-03-08',2,1,1,'19024199-8','12345678',1,'2022-01-28 00:00:00','1990-01-01 00:01:00',1,1),
(198,'20227132-4','','MARIA JOSÉ','SILVA','OSSES','1999-12-16',2,1,1,'20227132-4','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(199,'26684218-K','','JEAKENDRYS CHIQUINQUIRA','VIERA','VIERA','1993-03-24',2,1,3,'26684218-K','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(200,'261341190','','WILLIAMS JOSE ','ESTRADA','PAREDES','1982-08-05',1,2,3,'261341190','12345678',1,'2023-03-13 00:00:00','1990-01-01 00:01:00',1,1),
(201,'26698731-5','','ISMARY YENKELLY','RODRIGUEZ','AYALA','1987-11-21',2,1,3,'26698731-5','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(202,'26311590-2','','Jhon Henry Jorge','Carrillo','Bravo','2000-02-11',1,1,3,'26311590-2','12345678',1,'2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
(203,'27163464-1','','JESUS RAMON ','HERNANDEZ ','PIÑA','1977-09-15',1,1,3,'27163464-1','12345678',1,'2022-02-25 00:00:00','1990-01-01 00:01:00',1,1),
(204,'26375404-2','','Daniela Nazareth',' Berrios ','Ojeda','1994-03-08',2,1,3,'26375404-2','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(205,'19082224-9','','ANTOINE NICOLAS ','RAMEAU ','ROJO','1995-06-19',1,1,1,'19082224-9','12345678',1,'2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(206,'26145993-0','','YULEICA JOSEFINA','SOJO','PÉREZ','1973-02-20',2,1,3,'26145993-0','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(207,'26323676-9','','Julio Cesar ','Guzman ','Vegas','1985-03-03',1,1,3,'26323676-9','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(208,'26434326-7','','ADRIANA DE LOS ANGELES','GIL ','RODRIGUEZ','1990-11-09',2,2,3,'26434326-7','12345678',1,'2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(209,'27551007-6','','YOLETTS ALEJANDRA ','CARDOZO ','ROA','1985-10-28',2,2,3,'27551007-6','12345678',1,'2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(210,'26162521-0','','JOANNA YAMILET','HERNANDEZ','ROA','1972-01-11',2,2,3,'26162521-0','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(211,'10682482-7','','OSCAR LEONARDO ','OSORIO ','FUENTES','1969-02-20',1,2,1,'10682482-7','12345678',1,'2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(212,'26973136-2','','ANDREA ALEJANDRA','VARGAS','MACIAS','2000-09-15',2,1,3,'26973136-2','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(213,'10337937-7','','ELIZABETH DE LAS MERCEDES','TOLOZA','MOLINET','1963-06-11',2,2,1,'10337937-7','12345678',1,'2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(214,'19748142-0','','KIARA ALINE','PUEBLA ','ASTUDILLO','1997-12-13',2,1,1,'19748142-0','12345678',1,'2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(215,'17666116-K','','LUISA ESTER ','SANTIBAÑEZ',' LEON','1991-03-26',2,1,1,'17666116-K','12345678',1,'2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(216,'19232529-3','','Yolanda Elisa','Valenzuela','Tobar','1999-03-01',2,1,1,'19232529-3','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(217,'20646660-K','','Francisca Alejandra','Díaz','Díaz','2001-01-13',2,1,1,'20646660-K','12345678',1,'2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
(218,'17120546-8','','Roberto Andres ','Mercado','Pulgar','1989-03-29',1,1,1,'17120546-8','12345678',1,'2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
(219,'27064626-3','','ADRIANNA','CHAURAN','AREVALO','1980-05-22',2,2,3,'27064626-3','12345678',1,'2022-01-28 00:00:00','1990-01-01 00:01:00',1,1),
(220,'16391294-5','','DANIELA CAROLINA','GUTIERREZ ','MARIN','1996-06-18',2,1,1,'16391294-5','12345678',1,'2022-02-21 00:00:00','1990-01-01 00:01:00',1,1),
(221,'15335977-6','','Nancy Viviana ','González ','Navarrete','1982-03-01',2,1,1,'15335977-6','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(222,'25874511-6','','MARÍA DEL PILAR','ARENAS','DELGADO','1974-12-07',2,1,5,'25874511-6','12345678',1,'2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
(223,'26226039-9','','Ariattna ','Hernandez ','Arellano','1997-04-12',2,1,3,'26226039-9','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(224,'13905902-6','','DANIEL ALONSO','MEDINA ','PEÑA','1980-09-27',1,2,1,'13905902-6','12345678',1,'2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(225,'26648854-8','','Luis Daniel','Bateca','Diaz','1996-12-25',1,1,3,'26648854-8','12345678',1,'2021-07-22 00:00:00','1990-01-01 00:01:00',1,1),
(226,'20053967-2','','Nicolas Guido','Galvez','Venegas','1999-03-01',1,1,1,'20053967-2','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(227,'19099903-3','','GEMITA ALEJANDRA','ABARZA','VARELA','1996-02-22',2,1,1,'19099903-3','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(228,'26115431-5','','YANNIFER GABRIELA ','JARAMILLO',' DE SANCHEZ','1989-12-10',2,2,3,'26115431-5','12345678',1,'2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(229,'19545835-9','','ANA ROSA ','FUENTES',' ORELLANA','1997-01-22',2,1,1,'19545835-9','12345678',1,'2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(230,'20911925-0','','Brayan Jesús ','Hinojosa','Celis','2001-11-11',1,1,1,'20911925-0','12345678',1,'2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
(231,'26884590-9','','NAIROBI COROMOTO','FRANCOIS','SALCEDO','1984-09-28',2,1,3,'26884590-9','12345678',1,'2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
(232,'12477493-4','','JOHANNA ARACELLI',' LEIVA ','DIAZ','1973-09-07',2,1,1,'12477493-4','12345678',1,'2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(233,'26328771-1','','MARIANA','DE LUCA','GARCES','1977-10-27',2,1,3,'26328771-1','12345678',1,'2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
(234,'27326245-8','','Yusmarvy Lourde ','Gamarra','Garcia','1986-02-04',2,2,3,'27326245-8','12345678',1,'2020-09-29 00:00:00','1990-01-01 00:01:00',1,1),
(235,'18363980-3','','JOSELYNE SOLANGE','MARTINEZ','VIDAL','1992-11-18',2,1,1,'18363980-3','12345678',1,'2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(236,'19587710-6','','FRANCISCA SOLEDAD ','VALENZUELA ','LLANTEN','1997-03-01',2,1,1,'19587710-6','12345678',1,'2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(237,'27185903-1','','YONATHAN JOSÉ','CHACÓN','CARRILLO','1989-11-06',1,1,3,'27185903-1','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(238,'17010702-0','','JAVIERA FRANCISCA','HERMOSILLA','CHÁVEZ','1989-07-07',2,1,1,'17010702-0','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(239,'27181711-8','','Roxana Daniela ','Sufia ','Correa','1989-12-26',2,1,3,'27181711-8','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(240,'27213005-1','','ISAMAR','MOLINA ','DELGADO','1990-09-25',2,1,3,'27213005-1','12345678',1,'2022-02-21 00:00:00','1990-01-01 00:01:00',1,1),
(241,'46397309-1','','PEDRO','AGUILAR','','1984-08-05',1,1,1,'46397309-1','12345678',1,'2023-03-13 00:00:00','1990-01-01 00:01:00',1,1),
(242,'25549464-3','','Oscar ','Bravo ','Dinatte','1983-03-26',1,1,3,'25549464-3','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(243,'26684743-2','','GRETA ALEJANDRA','PERAZA','RODRIGUEZ','1994-03-08',2,1,3,'26684743-2','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(244,'18094556-3','','MARÍA PAZ','AICON','AICON','1991-10-12',2,1,1,'18094556-3','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(245,'26337084-8','','ANDREA','PEREZ','','1956-05-24',2,1,2,'26337084-8','12345678',1,'2023-03-14 00:00:00','1990-01-01 00:01:00',1,1),
(246,'16643372-K','','MARIA ALEJANDRA','GALLARDO','OLIVA','1987-06-27',2,1,1,'16643372-K','12345678',1,'2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
(247,'14701265-9','','Rosa Elena ','Castro','Mino ','1955-03-09',2,1,1,'14701265-9','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(248,'19116452-0','','CONSTANZA','QUEVEDO','FERNANDEZ','1995-07-06',2,1,1,'19116452-0','12345678',1,'2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(249,'9690532-7','','Viviana Elsa','Arenas','Moris','1962-01-06',2,1,1,'9690532-7','12345678',1,'2021-07-20 00:00:00','1990-01-01 00:01:00',1,1),
(250,'17250655-0','','ANA MARIA','MIMIZA','PINO','1989-05-23',2,1,1,'17250655-0','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(251,'17432646-0','','CAMILA NATALIA','ARELLANO','CAMPOS','1990-07-17',2,1,1,'17432646-0','12345678',1,'2021-04-27 00:00:00','1990-01-01 00:01:00',1,1),
(252,'16544118-4','','CECILIA ANDREA','CEBALLOS','ORELLANA','1986-09-17',2,1,1,'16544118-4','12345678',1,'2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(253,'27147404-0','','Yogerly Del Valle',' Toro','Mora','1996-04-09',2,1,3,'27147404-0','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(254,'10986710-1','','DENISSE CAROLINA','NOVOA','REYES','1974-05-03',2,2,1,'10986710-1','12345678',1,'2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(255,'26660442-4','','SULMA YUNAIRA','URBINA','VALECILLOS','1985-10-29',2,1,3,'26660442-4','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(256,'19730088-4','','CLAUDIO PAUL','OBEID','CAMPOS','1997-06-10',1,1,1,'19730088-4','12345678',1,'2020-11-25 00:00:00','1990-01-01 00:01:00',1,1),
(257,'27222012-3','','Yenifer Andreina ','Gutierrez','Ruenes','1988-11-29',2,1,3,'27222012-3','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(258,'16775506-2','','IVANIA ELENA','ALCOTA','LLANCOS','1987-10-01',2,1,1,'16775506-2','12345678',1,'2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(259,'27184783-1','','Carmen Yelitzka','Hidalgo','Rincones','1970-11-03',2,2,3,'27184783-1','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(260,'18769336-5','','STEPHANIE ALEXANDRA ','IBARRA',' FUENTES','1994-09-09',2,1,1,'18769336-5','12345678',1,'2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
(261,'27385082-1','','KORINA MIREYA','JIMÉNEZ','NAMIAS','1995-01-06',2,1,3,'27385082-1','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(262,'16571660-4','','Constanza Paz','Méndez ','Fuentes  ','1987-07-31',2,1,1,'16571660-4','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(263,'19185719-4','','LUCAS SALVADOR','RODRIGUEZ','GUTIERREZ','1995-09-12',1,1,1,'19185719-4','12345678',1,'2020-11-25 00:00:00','1990-01-01 00:01:00',1,1),
(264,'17563243-3','','KATHERINE','CORTES','PINOCHET','1989-10-23',2,1,1,'17563243-3','12345678',1,'2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(265,'11263366-9','','ELSA MARIA ','SALAZAR',' SAAVEDRA','1968-03-27',2,2,1,'11263366-9','12345678',1,'2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
(266,'14238085-4','','GLORIA INES ','CISTERNAS ','JERIA','1973-08-25',2,1,1,'14238085-4','12345678',1,'2022-06-20 00:00:00','1990-01-01 00:01:00',1,1),
(267,'17699423-1','','Javiera ','Franco','Tondreau','1991-01-11',2,1,1,'17699423-1','12345678',1,'2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
(268,'18991168-8','','FRANCISCA MERCEDES','PANZA','PARDO','1994-11-15',2,2,1,'18991168-8','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(269,'27222602-4','','ELAIDISA','MONTOYA','URRIBARRI','1984-05-01',2,1,3,'27222602-4','12345678',1,'2020-11-25 00:00:00','1990-01-01 00:01:00',1,1),
(270,'17085121-8','','NICOLAS','BALBOA','ORTEGA','1989-01-19',1,1,1,'17085121-8','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(271,'18057262-7','','Marcelo Antonio','Carreño','Reyes','1999-03-01',1,1,1,'18057262-7','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(272,'26856381-4','','Pedro Jose ','Gauta ','Rodríguez ','1983-08-02',1,1,3,'26856381-4','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(273,'20176959-0','','DANITZA LAURA','BURGOS','PEREZ','1999-01-17',2,1,1,'20176959-0','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(274,'26367606-8','','JUAN','PEREZ','','1982-08-05',1,2,1,'26367606-8','12345678',1,'2023-03-13 00:00:00','1990-01-01 00:01:00',1,1),
(275,'25648456-0','','REBECA ALESMAR','SÁNCHEZ','FLORES','1990-04-11',2,1,3,'25648456-0','12345678',1,'2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
(276,'17663913-K','','Angela Vanessa','Gonzalez','Donoso','1990-11-23',2,1,1,'17663913-K','12345678',1,'2021-04-21 00:00:00','1990-01-01 00:01:00',1,1),
(277,'27200318-1','','Genesis Patricia','Betizagati','Rumbo','1995-02-10',2,1,3,'27200318-1','12345678',1,'2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
(278,'12239217-1','','CLAUDIA ELCIRA','BUCAREY ','VALLEJOS','1972-01-23',2,1,1,'12239217-1','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(279,'15703940-7','','Lorena Yohana','Romero','Muñoz','1984-01-18',2,1,1,'15703940-7','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(280,'26744797-7','','MAGLY COROMOTO','  AVILA ','LEON','1972-01-16',2,1,3,'26744797-7','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(281,'20176282-0','','Israel Abdón ','Cataldo ','Gahona','2000-02-15',1,1,1,'20176282-0','12345678',1,'2021-10-06 00:00:00','1990-01-01 00:01:00',1,1),
(282,'26675244-K','','Viany Yuslemys','Montoya','Lopez','1980-06-26',2,1,3,'26675244-K','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(283,'26357907-0','','Skarlett Maria ','Hernandez ','Arellano','1997-04-12',2,1,3,'26357907-0','12345678',1,'2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
(284,'11525449-9','','Paolo Eduardo','Espinoza ','Astorga ','1970-10-11',1,2,1,'11525449-9','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(285,'26757977-6','','ANA DEL PILAR ','RODRIGUEZ','PRETELL','1977-12-13',2,2,2,'26757977-6','12345678',1,'2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(286,'18294489-0','','DANIELA DE JESUS ','CARRASCO','GONZALEZ','1993-03-05',2,1,1,'18294489-0','12345678',1,'2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(287,'20277925-5','','JAVIERA ANDREA','MIRANDA','TAPIA','1999-08-24',2,1,1,'20277925-5','12345678',1,'2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
(288,'26911858-K','','GENESIS ADRIANA','ABRANTE','CARABALLO','1998-04-23',2,1,3,'26911858-K','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(289,'33811759-0','','ROBERTO','MARTINEZ','Perez','1957-05-24',1,1,2,'33811759-0','12345678',1,'2023-03-14 00:00:00','2023-09-01 00:00:00',1,1),
(290,'26269051-2','','ADRIANA CAROLINA','DIAZ','ALIENDRES','1986-03-18',2,1,3,'26269051-2','12345678',1,'2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
(291,'27270211-K','','YISBELY VICENTA','PADRON','CLEMENTE','1990-07-10',2,1,3,'27270211-K','12345678',1,'2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
(292,'26955355-3','','ANNISU KATTIANA ','AVILA ','GRATERON','1984-04-04',2,1,3,'26955355-3','12345678',1,'2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
(293,'27117848-4','','Oriana Beatriz ','Sandrea','Perez','2001-02-26',2,1,3,'27117848-4','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(294,'20950209-7','','Benjamín Alexander','Lucero','Lucero','2002-01-09',1,1,1,'20950209-7','12345678',1,'2021-07-26 00:00:00','1990-01-01 00:01:00',1,1),
(295,'08986543-3','','Monica Cecilia','Yakich','Godoy','1960-03-02',2,1,1,'08986543-3','12345678',1,'2020-11-13 00:00:00','2023-10-18 00:00:00',1,1),
(296,'27202235-6','','Gilson Jose ','Gonzalez ','Gonzalez ','2000-05-27',1,1,1,'27202235-6','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(297,'13089389-9','','Jorge Ariel','González ','Abarzua ','1976-02-12',1,1,1,'13089389-9','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(298,'20190179-0','','Camila Paz','Albornoz','Villaloboz','1999-03-01',2,1,1,'20190179-0','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(299,'27301945-6','','Evelyn Adriana ','Herrera','Linares ','1988-10-20',2,1,3,'27301945-6','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(300,'26102612-0','','MARIANA ','LIMA','SANTANDER','1986-10-20',2,1,3,'26102612-0','12345678',1,'2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
(301,'27076991-8','','Anahild Michaell','Castañeda ','Borrero','1994-12-15',2,1,3,'27076991-8','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(302,'19025624-3','','MARÍA CAROLINA','CARRASCO','SILVA','1995-04-18',2,1,1,'19025624-3','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(303,'25978397-6','','María Daniela','Valecillos','Saldivia','2002-06-16',2,1,3,'25978397-6','12345678',1,'2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
(304,'19278735-1','','LISSETTE ALEJANDRA','OLAVE','DOMINGUEZ','1996-02-29',2,2,1,'19278735-1','12345678',1,'2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
(305,'14045473-7','','SERGIO JAVIER','FARIAS ','PEREZ','1987-04-12',1,1,1,'14045473-7','12345678',1,'2023-03-13 00:00:00','1990-01-01 00:01:00',1,1),
(306,'18906147-1','','Valentin Ariel ',' Sepúlveda ','Osorio','1994-10-25',1,2,1,'18906147-1','12345678',1,'2020-08-03 00:00:00','2023-10-05 00:00:00',1,1),
(307,'20071751-1','','Katherine Alejandra ','Araneda ','Rodríguez ','1998-10-10',2,1,1,'20071751-1','12345678',1,'2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
(308,'27333664-8','',' Nureyva Yuliner','Romero','Marcano','1976-08-08',2,2,3,'27333664-8','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(309,'27182620-6','','LIRIS DEL CARMEN','HERRERA','LÓPEZ','1993-05-04',2,1,3,'27182620-6','12345678',1,'2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
(310,'20146870-1','','Alannis Fernanda ','Gatica ','Quintana','1999-07-16',2,1,1,'20146870-1','12345678',1,'2021-10-06 00:00:00','1990-01-01 00:01:00',1,1),
(311,'27142936-3','','TEIDE','MARTÍNEZ','ROSALES','1985-11-20',2,1,3,'27142936-3','12345678',1,'2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
(312,'27069849-2','','Leidy Briggitte','Cortes','Torres','1991-06-14',2,2,3,'27069849-2','12345678',1,'2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
(313,'10097733','','EUDO','RUIZ','GONZALEZ','1970-04-23',1,1,1,'egonzalez','$2b$12$tMUAFXIyocDyORY2vZ0P4.pa9cY1hlyyYjwClE4PZMa/f4YXc2XXO',1,'2023-12-20 22:08:20','2023-12-20 22:08:20',1,1),
(314,'13691160','','DANIEL','RUIZ','GONZALEZ','1970-04-23',1,1,1,'dgonzalez','$2b$12$uihynPE2nH6K4DXLSbdQI.hJC40vScTt.YCA8nSnVjIUlwJ5N2foG',1,'2023-12-20 22:10:28','2023-12-20 22:10:28',1,1);
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UsuarioModulo`
--

DROP TABLE IF EXISTS `UsuarioModulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UsuarioModulo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `modulo_id` bigint(20) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Usuario_UsuarioModulo` (`user_id`),
  KEY `FK_Modulo_UsuarioModulo` (`modulo_id`),
  CONSTRAINT `FK_Modulo_UsuarioModulo` FOREIGN KEY (`modulo_id`) REFERENCES `Modulo` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Usuario_UsuarioModulo` FOREIGN KEY (`user_id`) REFERENCES `Usuario` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de los modulos del sistema asigandos al usuario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UsuarioModulo`
--

LOCK TABLES `UsuarioModulo` WRITE;
/*!40000 ALTER TABLE `UsuarioModulo` DISABLE KEYS */;
INSERT INTO `UsuarioModulo` VALUES
(1,1,1,1,'2024-01-01 01:00:00','2024-01-01 01:00:00',1,1),
(2,1,2,2,'2024-01-01 01:00:00','2024-01-01 01:00:00',1,1),
(3,1,3,3,'2024-01-01 01:00:00','2024-01-01 01:00:00',1,1),
(4,1,4,4,'2024-01-01 01:00:00','2024-01-01 01:00:00',1,1);
/*!40000 ALTER TABLE `UsuarioModulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UsuariosDepartamentos`
--

DROP TABLE IF EXISTS `UsuariosDepartamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UsuariosDepartamentos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint(20) NOT NULL,
  `sede_id` bigint(20) NOT NULL,
  `departamento_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_UsuariosDepartamentos` (`sociedad_id`),
  KEY `FK_Sede_UsuariosDepartamentos` (`sede_id`),
  KEY `FK_Departamento_UsuariosDepartamentos` (`departamento_id`),
  CONSTRAINT `FK_Departamento_UsuariosDepartamentos` FOREIGN KEY (`departamento_id`) REFERENCES `Departamentos` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Sede_UsuariosDepartamentos` FOREIGN KEY (`sede_id`) REFERENCES `Sede` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Sociedad_UsuariosDepartamentos` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para controlar los datos de los departamentos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UsuariosDepartamentos`
--

LOCK TABLES `UsuariosDepartamentos` WRITE;
/*!40000 ALTER TABLE `UsuariosDepartamentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `UsuariosDepartamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UsuariosGruposEmpleado`
--

DROP TABLE IF EXISTS `UsuariosGruposEmpleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UsuariosGruposEmpleado` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `grupo_empleados_id` bigint(20) NOT NULL,
  `sociedad_id` bigint(20) NOT NULL,
  `sede_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
  `fecha_registro` datetime NOT NULL COMMENT 'fecha en que fue creado el registro historico',
  `observaciones` text DEFAULT NULL COMMENT 'observaciones del historico',
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_UsuariosGruposEmpleado` (`sociedad_id`),
  KEY `FK_Sede_UsuariosGruposEmpleado` (`sede_id`),
  KEY `FK_Usuario_UsuariosGruposEmpleado` (`user_id`),
  CONSTRAINT `FK_Sede_UsuariosGruposEmpleado` FOREIGN KEY (`sede_id`) REFERENCES `Sede` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Sociedad_UsuariosGruposEmpleado` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Usuario_UsuariosGruposEmpleado` FOREIGN KEY (`user_id`) REFERENCES `Usuario` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de usuarios grupos de empleados';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UsuariosGruposEmpleado`
--

LOCK TABLES `UsuariosGruposEmpleado` WRITE;
/*!40000 ALTER TABLE `UsuariosGruposEmpleado` DISABLE KEYS */;
/*!40000 ALTER TABLE `UsuariosGruposEmpleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_ubicacion`
--

DROP TABLE IF EXISTS `temp_ubicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_ubicacion` (
  `rut` varchar(100) NOT NULL,
  `region_id` bigint(20) NOT NULL,
  `comuna_id` bigint(20) NOT NULL,
  `direccion` text NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de ubicación de los usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_ubicacion`
--

LOCK TABLES `temp_ubicacion` WRITE;
/*!40000 ALTER TABLE `temp_ubicacion` DISABLE KEYS */;
INSERT INTO `temp_ubicacion` VALUES
('17133964-2',6,6101,'Av. Parque Viña Santa Blanca 0411 dpto. 303','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
('17316832-2',13,13110,'JOSE MIGUEL CARRERA 679 CASA 471','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('26732301-1',13,13130,'Jose Joaquín Prieto 4260 dpto. 610','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
('16713156-5',13,13120,'San Pedro 1751','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
('26744663-6',13,13101,'SANTA ELENA 840 DPTO 604','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('16643709-1',13,13110,'LOS LITRES 10938 BLOCK 5 DEPTO C12','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('18166693-5',13,13101,'Zenteno 1482 dpto 1927','2021-04-27 00:00:00','1990-01-01 00:01:00',1,1),
('26791142-8',13,13101,'EYZAGUIRRE 766 dep 526','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('19280828-6',13,13130,'QUINTA AVENIDA 1475','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('27016371-8',13,13130,'Santa Rosa 5741 - Depto. 2001 Torre A','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('19027132-3',13,13201,'Pasaje el Trazador 3467','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
('19561320-6',13,13106,'COYHAIQUEO 6010','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('19585453-K',13,13201,'Carmen Doren Sur 05532','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('27658687-4',13,13505,'Av. Los Parques 651 dpto. 424','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
('15727711-1',5,5801,'Calle Santa María 1221 casa 60','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
('27221867-6',13,13106,'CONDE DEL MAULE 4642 dpto. 1212','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('27072989-4',13,13101,'CHILOÉ 3601 DPT 306','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('19657604-5',13,13130,'gran av jose miguel carrera 5380','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('18832098-8',13,13101,'Vicuña Mackenna 1231 dpto. 2223','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
('19282642-K',13,13126,'Radal 1740 dpto. 35 J','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
('26519143-6',13,13101,'Raulí 596, dpto. 2012','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
('26052313-9',13,13101,'CHILOÉ 1221 DPTO 1201','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('26322977-0',13,13119,'AVENIDA AMERICO VESPUCIO 1184 dpto 1801','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('13296134-4',13,13201,'Psje Profesor Diego Barros Arana 425','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
('9201636-6',5,5804,'Calle de la Aguada 654','2022-07-27 00:00:00','1990-01-01 00:01:00',1,1),
('18904649-9',13,13116,'Tres oriente 6532','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
('14149036-2',13,13130,'WALKER MARTINEZ #6100 dpto E 53','2021-11-02 00:00:00','1990-01-01 00:01:00',1,1),
('20448340-K',13,13107,'Av. Recoleta 6336','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('25113955-5',13,13119,'Aves del paraíso 920','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
('27092969-9',13,13113,'AV. BLEST GANA 5784','2020-11-10 00:00:00','1990-01-01 00:01:00',1,1),
('21078983-9',13,13101,'Ricardo Cumming 1355','2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
('26427773-6',13,13105,'av independencia 740 torre b dep 1223','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('26694579-5',13,13101,'CALLE COQUIMBO 1189 DPTO 828','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('27413879-3',13,13108,'colon 1377 dpto. 1908','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('13075223-3',13,13111,'Río Bio Bio 994','2020-08-04 00:00:00','1990-01-01 00:01:00',1,1),
('19172460-7',13,13119,'El verano 1188, maipu','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
('18442190-9',13,13116,'Pje. Doce sur 03308','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
('26560659-8',13,13106,'Av. Ecuador 5065 dpto. 1302','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
('26687813-3',13,13101,'vicuña mackenna 1725','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('15076934-5',5,5101,'Noruega 443, dpto. 74','2021-10-26 00:00:00','1990-01-01 00:01:00',1,1),
('20434367-5',13,13128,'Los Copihues 1815','2021-11-29 00:00:00','1990-01-01 00:01:00',1,1),
('12248435-1',13,13101,'Moneda 3090, dpto. 604 Torre 3030','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
('17769013-9',13,13126,'Lo Ampuero 1595','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
('25971983-6',13,13130,'SAN NICOLAS 1092 DPTO 606','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('18361318-9',13,13110,'Candalo Amarillo 10393 casa G','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
('26985625-4',13,13106,'Alameda 4877','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('27130213-4',13,13122,'Calle Antofagasta 1204-C','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
('26834387-3',13,13101,'Chiloé 1221, dpto. 1317','2021-07-26 00:00:00','1990-01-01 00:01:00',1,1),
('18156986-7',13,13102,'Ilan Ilan 4305','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
('26225368-6',13,13120,'zañartu 1313 dep 1002','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
('19829460-8',13,13201,'Río Simpson 4551','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
('25785161-3',13,13101,'Santo Domingo 2816','2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
('26603969-7',13,13130,'Calle San Ignacio 3452 dpto. 115','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
('13455128-3',13,13106,'AV. AEROPUERTO 216','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('17267685-5',13,13123,'Suecia 2401','2021-07-26 00:00:00','1990-01-01 00:01:00',1,1),
('26767932-0',13,13126,'Meza Bell 2851 Apto 543 torre K','2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
('19344356-7',13,13130,'Cuarta Avenida 1170','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
('19585408-4',13,13130,'Locumba 6018 ','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('16441251-2',13,13201,'AV PLAZA VIVA 02282','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('26658938-7',13,13104,'MAR DE LAS ANTILLAS 3631 DPTO 6','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('26091737-4',13,13110,'Avenida Vicuña Mackenna Oriente 6640','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('27224192-9',13,13124,'SAN GABRIEL 8803-B','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('14195110-6',13,13201,'PASAJE LONGOVILO 2764','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('19206864-9',5,5101,'Av. Ecuador 326','2021-10-06 00:00:00','1990-01-01 00:01:00',1,1),
('26501255-8',13,13126,'pje catorce 4578','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('26923220-K',13,13101,'SAN FRANCISCO 42','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('18103015-1',13,13201,'Viña del Cerro Poniente 4472','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('27463144-9',13,13106,'Toro Mazotte 76 Dpto. 1506','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('27030909-7',13,13117,'Neptuno 945 dpto. 204','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
('19553601-5',8,8111,'Los Notros 1020','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('26382954-9',13,13101,'Santa Isabel 176','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
('11620500-9',5,5801,'Calle Puchuncaví 2171','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
('15354713-0',13,13110,'Avenida La Florida 9650, dpto. 118','2022-02-21 00:00:00','1990-01-01 00:01:00',1,1),
('27081970-2',13,13130,'Álvarez de Toledo 764','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('26438678-0',13,13108,'GENERAL PRIETO 1717 DPTO 1208','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('17610517-8',13,13201,'Puquios 1169','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
('9672610-4',13,13121,'Alcibiades 5310','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
('26141420-1',13,13201,'Pje. Parque del Cielo 2449','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
('18027802-8',13,13401,'Pasaje Amazonas 1382','2022-02-21 00:00:00','1990-01-01 00:01:00',1,1),
('27125790-2',13,13111,'Isla Picton 8613','2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
('27163493-5',13,13101,'Calle Arturo Prat 602 dpto. 405 Torre B','2022-02-25 00:00:00','1990-01-01 00:01:00',1,1),
('20473681-2',13,13302,'PASAJE SANTA CATALINA 372','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('27231665-1',13,13106,'Coronel Souper 4250 dpto. 1508','2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
('16519804-2',13,13130,'Pasaje Carlos Walker Martínez 5847, casa 1028','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
('10197056-6',13,13101,'','2021-07-23 00:00:00','1990-01-01 00:01:00',1,1),
('27160861-6',13,13130,'QUINTA AVENIDA 1475 DPTO 710','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('12880697-0',13,13110,'Senday 1286','2021-04-27 00:00:00','1990-01-01 00:01:00',1,1),
('20452650-8',13,13201,'Los Salesianos 1883','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('26928823-K',13,13106,'Carlos Pezoa Veliz 143','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('26611433-8',13,13120,'TRANVERSAL SUAREZ MUJICA 2900 DPTO 84','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('15667455-9',13,13124,'PASAJE PUERTO RIO TRANQUILO Nº 127','2020-11-10 00:00:00','1990-01-01 00:01:00',1,1),
('44280493-1',13,13106,'coronel souper 4222 torre a dep 2310','2021-10-26 00:00:00','1990-01-01 00:01:00',1,1),
('26203037-7',13,13110,'santa edith 9766','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('17936780-7',13,13201,'COIHUECO 3263','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('17411434-K',13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('26156334-7',13,13101,'GORBEA 2551 DPTO 422','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('19176716-0',13,13101,'Sazie 2496','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('19848318-4',13,13101,'Santo Domingo 1161 dpto. 808','2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
('18076015-6',13,13110,'Los geranios 9608  DEPTO 1','2020-11-25 00:00:00','1990-01-01 00:01:00',1,1),
('27629290-0',13,13106,'coronel souper 4222 torre a dep 2310','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('19586856-5',13,13119,'Abisinia 1176 Villa el Abrazo','2021-04-27 00:00:00','1990-01-01 00:01:00',1,1),
('26362258-8',13,13126,'SANTO DOMINGO 4047 DPTO 1807','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('17649726-2',8,8110,'Manuel Zañartu 668','2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
('26070028-6',13,13101,'SAN ISIDRO 96 DEPTO 813 ','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('17306680-5',13,13103,'Jorge Washington 1318','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
('26231217-8',13,13129,'AV. VICUÑA MACKENNA 2585 DPTO 205 B','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('15845827-6',13,13119,'Thiare 1099 dpto. 72','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
('38528074-2',13,13101,'Placilla 047','2023-03-13 00:00:00','1990-01-01 00:01:00',1,1),
('20225557-4',13,13110,'Limache 767','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('15170740-8',8,8111,'Mariano Egaña 1061','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
('19064229-1',13,13119,' La balada 391, dpto 3131','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('26581867-6',13,13101,'Santiago 1320 dpto. 516','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
('19516012-0',13,13109,'Avenida Fernandez Albano 637 dpto. 1120','2022-03-27 00:00:00','1990-01-01 00:01:00',1,1),
('27176740-4',13,13110,'Las llaretas 2114','2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
('15140657-2',7,7401,'GUACOLDA 598','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('19993608-5',13,13605,'Larrain 2964 Casa 15','2022-01-26 00:00:00','1990-01-01 00:01:00',1,1),
('26710014-4',13,13130,'Guardia Marina Riquelme 4880 dpto. 102','2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
('27223670-4',13,13101,'SAN PABLO 1353 DEPTO 1401','2020-09-29 00:00:00','1990-01-01 00:01:00',1,1),
('25590137-0',13,13126,'Rivas Vicuña 1590','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
('26265074-K',13,13101,'Sargento Aldea1156 Apti 1104A','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('26756709-3',13,13120,'730 Departamento 509-C ','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('27334558-2',13,13101,'CARMEN 557 dep 308','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('18824199-9',13,13126,'Jose Besa 1131','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('16791651-1',13,13109,'RAFAEL MONTT 6447 B11','2023-03-14 00:00:00','1990-01-01 00:01:00',1,1),
('44208350-9',13,13108,'el molino 1845','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('25794898-6',13,13106,'Av Ecuador 4578, dpto. 503','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
('12568851-9',4,4102,'Francisco Carmona 630','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
('13246899-0',13,13102,'Pasaje Los Satelites 7593','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('17072831-9',13,13124,'Av. Santa Victoria 851','2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
('26296365-9',13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('27190289-1',13,13125,'Av Infante Larrain 1900 Cond. Patagonia 1 N°23120 ','2020-08-03 00:00:00','2023-08-31 00:00:00',1,1),
('19637330-6',13,13111,'Av. Américo Vespucio Sur 0355','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
('26267939-K',13,13120,'García Valenzuela 055 dpto.1805 B','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
('27135068-6',13,13110,'Vicuña Mackenna  10167','2020-08-03 00:00:00','2023-08-31 00:00:00',1,1),
('18629112-3',13,13125,'Estero Molulco 020','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
('19228849-5',6,6101,'Sendero de La Paloma 3191','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
('26610299-2',13,13101,'CARMEN 418 DPTO 515','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('19315710-6',13,13124,'Auka 161 depto 12','2020-08-04 00:00:00','1990-01-01 00:01:00',1,1),
('21129190-7',5,5109,'Angol 36','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
('19545849-9',13,13605,'Pasaje Boldo 542','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
('20342635-6',5,5109,'Calle vista al mar pasaje 3 forestal 161','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
('26878985-5',13,13126,'SANTO DOMINGO 4047 dpto 1303','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('15835053-K',7,7102,'Egaña 655','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('22319984-4',13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('26275957-1',13,13113,'Avenida Tobalaba 7761 depto 41 b','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
('26825475-7',13,13118,'Los Economistas 4638','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('26955770-2',13,13120,'pasaje 12 n°1508','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
('27128004-1',13,13101,'SAN IGNACIO DE LOYOLA 824 DPTO 505','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('27169720-1',13,13123,'FRANCISCO PUELMA 26. DPTO 102 TORRE 30','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('26777002-6',13,13101,'YUNGAY 2570 A5  DPTO 301','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('26760332-4',13,13201,'pje padre luis espinal campos 1198','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('17406767-8',13,13120,'Eliecer Parada 1891 dpto. 200','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('26984006-4',13,13114,'GENERAL CARLOS URZUA 7061','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('17009958-3',13,13201,'Pasaje Los Ligustros 2274','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
('16619882-8',13,13101,'Atacama 3041','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('26298547-4',13,13106,'OBISPO UMAÑA 033','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('26674682-2',13,13119,'CALLE MORRO DE ARICA 0506','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('19004989-2',13,13201,'PASAJE TENO 0202 OSCARBONILLA','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('27175247-4',13,13101,'Avenida Portugal 755, Depto 1201','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('26598875-K',13,13101,'San Pablo 1539 dep 1401','2020-08-04 00:00:00','1990-01-01 00:01:00',1,1),
('27132993-8',13,13106,'carlos pezoa veliz 143 dep 2816','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('19889657-8',13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('26440697-8',13,13101,'CHILOÉ 1221 DPTO 419','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('16682616-0',13,13201,'Calle el volcán 03102','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
('27117965-0',13,13101,'SANTA ELENA 1722 DEP 309 TORRE B','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('25832848-5',13,13101,'ELEUTERIO RAMIREZ 825','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('19063164-8',13,13201,'MARTINICA 1183','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('26845322-9',13,13101,'Rosas 1339, dpto. 1203','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
('25658191-4',13,13108,'Gamero 1399 dpto. 1412','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('15982188-9',4,4102,'Enrique Meiggs 120','2022-03-30 00:00:00','1990-01-01 00:01:00',1,1),
('27308478-9',13,13118,'Escuela Agrícola 1710 Condominio Los Andes Torre G depto 909','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
('15771049-4',13,13201,'Los Paltos 0727','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('15667402-8',13,13401,'Puerto Murta 15533','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('26584105-8',13,13102,'Costanera norte 284 B dpto. 203','2022-08-26 00:00:00','1990-01-01 00:01:00',1,1),
('12087635-K',13,13126,'Los Andes de Violeta Parra 3721 dpto. B33','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
('26540713-7',13,13101,'SANTA ISABEL # 431 DEPTO 1011','2020-09-29 00:00:00','1990-01-01 00:01:00',1,1),
('27322082-8',13,13101,'SANTA ISABEL 199, APTO 1204','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('13587143-5',13,13124,'Simon Bolivar 210','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('26018791-0',13,13120,'Av. José Pedro Alessandri 1498, dpto. 808','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
('16776630-7',5,5109,'Pasaje 41 Casa 5','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
('13772708-0',13,13201,'misionera de la caridad 2 norte 2731','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('16355559-K',13,13121,'Lago Constancia 2070','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
('19317780-8',13,13110,'Av. Vicuña Mackenna poniente 6800 dpto. 1303','2022-04-20 00:00:00','1990-01-01 00:01:00',1,1),
('27052747-7',13,13106,'AV. ECUADOR 4678','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('9976247-0',13,13401,'Fernando Vonome 1516','2021-10-12 00:00:00','1990-01-01 00:01:00',1,1),
('17908720-0',13,13110,'San Juan Crisóstomo  10742','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
('13030026-K',13,13201,'Pasaje Reibo 3865','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
('16747776-3',5,5101,'Rodrigo de Triana 542','2021-10-06 00:00:00','1990-01-01 00:01:00',1,1),
('19996523-9',13,13130,'Av. Lazo 1171','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('15894160-0',13,13110,'Los Sauces 620','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
('26576034-1',13,13101,'Teatinos 690 dpto. 2101','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
('19116812-7',13,13120,'Irarrázaval 4900 dpto. 1803','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('14352859-6',13,13401,'Volcan Maipo 14924','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
('26908847-8',13,13117,'CALLE OSORNO 5241','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('19024199-8',13,13401,'Franz Schubert 1668','2022-01-28 00:00:00','1990-01-01 00:01:00',1,1),
('20227132-4',13,13119,'Francisco Coloane IX 263','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('26684218-K',13,13108,'PABLO URZÚA 1481 dpto 1621A','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('261341190',13,13106,'Placilla 046','2023-03-13 00:00:00','1990-01-01 00:01:00',1,1),
('26698731-5',13,13106,'AV MARIA ROZAS VELASQUEZ 55','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('26311590-2',13,13108,'El Molino 1845','2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
('27163464-1',13,13101,'Calle Arturo Prat 602 dpto. 405 Torre B','2022-02-25 00:00:00','1990-01-01 00:01:00',1,1),
('26375404-2',13,13101,'Santa Elena 840','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('19082224-9',5,5804,'Andrés Bobe 2390','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
('26145993-0',13,13109,'Carlos Condell 696','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('26323676-9',13,13101,'SAN IGNACIO DE LOYOLA 633','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('26434326-7',13,13101,'Lord Cochrane 376 Dpto 1916','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
('27551007-6',5,5109,'Borinquen 32 Block 4 dpto. 404','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
('26162521-0',13,13118,'Av. Macul 6305. Torre A dpto. 602','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('10682482-7',13,13116,'Nueve de enero 269','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
('26973136-2',13,13126,'San Pablo 4135 dpto 502','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('10337937-7',13,13119,'Ignacio García Silva 2643','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
('19748142-0',13,13120,'Elias de la Cruz 6','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
('17666116-K',13,13121,'Estrella Blanca 4768','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
('19232529-3',13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('20646660-K',13,13120,'La Proa 1276 depto. 24','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
('17120546-8',13,13101,'Av Manuel Rodríguez 53 depto 1308 ','2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
('27064626-3',13,13101,'Avenida Vicuña Mackenna 881, dpto. 1910 A','2022-01-28 00:00:00','1990-01-01 00:01:00',1,1),
('16391294-5',13,13201,'Pasaje Valle de Copiapo 3263','2022-02-21 00:00:00','1990-01-01 00:01:00',1,1),
('15335977-6',13,13119,'Pasaje los ingenieros 1177','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('25874511-6',13,13108,'Independencia 740, dpto. 1922 Bloque C','2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
('26226039-9',13,13101,'Coronel Souper 4222 B','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('13905902-6',13,13109,'Plaza castelar 01160 torre 4 depto 33','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
('26648854-8',13,13118,'Av. Américo Vespucio 4641, dpto. 1301','2021-07-22 00:00:00','1990-01-01 00:01:00',1,1),
('20053967-2',13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('19099903-3',2,2101,'PASAJE NICOLAS GONZALEZ #8654','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('26115431-5',13,13122,'Parque Dos 1358','2022-04-27 00:00:00','1990-01-01 00:01:00',1,1),
('19545835-9',13,13110,'San Pablo 10877 dpto. 126','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
('20911925-0',13,13110,'Salvador Sanfuentes 101','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
('16724523-4',13,13101,'','2021-07-23 00:00:00','1990-01-01 00:01:00',1,1),
('26884590-9',13,13130,'María Auxiliadora 721 dpto. 1708 Torre A','2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
('12477493-4',13,13108,'Escanilla 255 dpto. 2505','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
('26328771-1',13,13129,'Av. Santa Rosa 2648, dpto. 1110 B','2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
('27326245-8',13,13119,'REGIDOR ALBERTO BRAVO # 864','2020-09-29 00:00:00','1990-01-01 00:01:00',1,1),
('18363980-3',13,13201,'Marbella 85','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
('19587710-6',6,6303,'El sauce sin número','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
('27185903-1',13,13130,'Llico 1023','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('17010702-0',13,13110,'Americo Vespucio 6443 Dpto 111','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('27181711-8',13,13130,'Segunda avenida 1146 dpto 122','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('27213005-1',13,13101,'General Gana 1379, dpto. 306','2022-02-21 00:00:00','1990-01-01 00:01:00',1,1),
('46397309-1',13,1404,'Placilla 048','2023-03-13 00:00:00','1990-01-01 00:01:00',1,1),
('25549464-3',13,13126,'Carrascal 3880 Depto 406','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('26684743-2',13,13106,'Nicasio Retamales 115 Torre Oriente Dpto. 202','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('18094556-3',13,13125,'Pasaje El Llano 1038H dpto. 314','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('26337084-8',1,1107,'RAFAEL MONTT 6447 B12','2023-03-14 00:00:00','1990-01-01 00:01:00',1,1),
('16643372-K',13,13122,'Av. Las Torres 5490 block Q dpto 201','2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
('14701265-9',13,13111,'MANUEL RODRÍGUEZ 0385 ','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('19116452-0',13,13401,'Pasaje Coltauco 2215','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
('9690532-7',13,13201,'Calle Portal Andino 01041','2021-07-20 00:00:00','1990-01-01 00:01:00',1,1),
('17250655-0',13,13119,'PASAJE LOS OCEANOS 521','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('17432646-0',13,13104,'Av. El Cortijo 2000','2021-04-27 00:00:00','1990-01-01 00:01:00',1,1),
('16544118-4',13,13101,'Avenida viel 1320','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
('27147404-0',13,13101,'portugal 990 dep 604','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('10986710-1',13,13122,'Calle 402 Ex Guanaqueros 4864','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
('26660442-4',13,13102,'PASAJE PADRE JUAN LUCARINI 2632','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('19730088-4',13,13201,'Los Magnolios 652','2020-11-25 00:00:00','1990-01-01 00:01:00',1,1),
('27222012-3',13,13120,'EDUARDO CASTILLO VELASCO 4148','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('16775506-2',5,5103,'Av. El Lascar 75','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
('27184783-1',13,13106,'av libertador bernardo ohiggins ','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('18769336-5',6,6101,'Calle Florencia 1787','2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
('27385082-1',13,13101,'Amunátegui 620','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('16571660-4',13,13401,'PASAJE PUERTO ESPAÑA 2053,','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('19185719-4',13,13118,'3 poniente 2765','2020-11-25 00:00:00','1990-01-01 00:01:00',1,1),
('17563243-3',13,13108,'Amalia Errazuriz 956','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
('15747746-3',8,8301,'Pasaje Río Colombia 1289','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('11263366-9',13,13119,'Pasaje Minerva 2925','2022-06-24 00:00:00','1990-01-01 00:01:00',1,1),
('14238085-4',5,5801,'Calle Pelantaro 1380','2022-06-20 00:00:00','1990-01-01 00:01:00',1,1),
('17699423-1',13,13114,'Duqueco 1965 depto 76','2021-04-05 00:00:00','1990-01-01 00:01:00',1,1),
('18991168-8',13,13120,'Jose Ignacio Vergara 3614','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('27222602-4',13,13104,'Av. General Gambino 3200 T15 dpto 203','2020-11-25 00:00:00','1990-01-01 00:01:00',1,1),
('17085121-8',13,13201,'RIO CHOLGUACO 5122','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('18057262-7',13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('26856381-4',13,13101,'SAN IGNACIO 1498 DEPTO 506','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('20176959-0',13,13401,'Urmeneta 381','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('26367606-8',13,1402,'Placilla 046','2023-03-13 00:00:00','1990-01-01 00:01:00',1,1),
('25648456-0',13,13106,'Nicasio Retamales 115, dpto. 1009 Torre Sur','2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
('17663913-K',13,13401,'Quebrada el Toro 1363','2021-04-21 00:00:00','1990-01-01 00:01:00',1,1),
('27200318-1',13,13126,'Rivas Vicuña 1590 dpto. 105','2021-10-23 00:00:00','1990-01-01 00:01:00',1,1),
('12239217-1',13,13119,'ANIBAL 2149','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('15703940-7',13,13201,'calle paine 02344 villa don ramon','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('26744797-7',13,13101,'MATURANA 750 BELLO CENTRO E306','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('20176282-0',5,5101,'Subida la Puntilla 20, Cerro Toro','2021-10-06 00:00:00','1990-01-01 00:01:00',1,1),
('26675244-K',13,13101,'coronel godoy 0128 dep 613','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('26357907-0',13,13106,'Coronel Souper 4222 B','2020-08-03 00:00:00','1990-01-01 00:01:00',1,1),
('11525449-9',13,13125,'LAS TORRES 158','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('26757977-6',13,13126,'Mariana Roman 2448','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
('18294489-0',13,13401,'Jose Miguel Carrera 12030 dpto. 255 Torre Ñ','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
('20277925-5',13,13201,'La Salvia 1885','2020-11-30 00:00:00','1990-01-01 00:01:00',1,1),
('26911858-K',13,13101,'Santa Rosa 146','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('33811759-0',15,15101,'RAFAEL MONTT 6447 B13','2023-03-14 00:00:00','2023-09-01 00:00:00',1,1),
('26269051-2',13,13106,'SANTA PETRONILA 32 DEPA 1922','2020-11-20 00:00:00','1990-01-01 00:01:00',1,1),
('27270211-K',13,13101,'General Gana 1063, dpto.  1019A','2021-06-25 00:00:00','1990-01-01 00:01:00',1,1),
('26955355-3',8,8108,'Gabriela Mistral 163','2022-05-26 00:00:00','1990-01-01 00:01:00',1,1),
('27117848-4',13,13101,'AV. SANTA ROSA 991 dpto. 1709','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('20950209-7',13,13127,'Los Pescadores 3355','2021-07-26 00:00:00','1990-01-01 00:01:00',1,1),
('08986543-3',13,13101,'GORBEA 2510 DPTO 518','2020-11-13 00:00:00','2023-10-18 00:00:00',1,1),
('27202235-6',13,13101,'apolo prueba 334','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('13089389-9',13,13201,'PASAJE HUENTELAUQUEN 807','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('20190179-0',13,13101,'2 call 1233','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('27301945-6',13,13101,'HUERFANOS 1400','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('26102612-0',5,5804,'Ignacio Carrera Pinto 0110 ','2022-02-17 00:00:00','1990-01-01 00:01:00',1,1),
('27076991-8',13,13101,'AV LIBERTADOR BERNARDO OHIGGINS 580 DEPTO 503','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('19025624-3',13,13111,'Vicuña Mackenna 0481','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('25978397-6',13,13101,'Portugal 810 dpto. 1712','2021-09-27 00:00:00','1990-01-01 00:01:00',1,1),
('19278735-1',13,13401,'Cerro Yaretas 293','2022-03-28 00:00:00','1990-01-01 00:01:00',1,1),
('14045473-7',15,15101,'Pasaje 13 12982','2023-03-13 00:00:00','1990-01-01 00:01:00',1,1),
('18906147-1',13,13117,'Blasco Ibañez 3181','2020-08-03 00:00:00','2023-10-05 00:00:00',1,1),
('20071751-1',13,13302,'PASAJE SANTA CATALINA 372','2020-11-13 00:00:00','1990-01-01 00:01:00',1,1),
('27333664-8',13,13106,'conde del maule 4642 dep 303','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1),
('27182620-6',13,13101,'Calle Santa Victoria 360, dpto. 1016','2021-05-27 00:00:00','1990-01-01 00:01:00',1,1),
('20146870-1',13,13111,'Los Girasoles 692','2021-10-06 00:00:00','1990-01-01 00:01:00',1,1),
('27142936-3',13,13106,'María Rosa Velázquez 65','2021-04-23 00:00:00','1990-01-01 00:01:00',1,1),
('27069849-2',13,13120,'av manuel montt 2440 dep 311','2021-03-22 00:00:00','1990-01-01 00:01:00',1,1);
/*!40000 ALTER TABLE `temp_ubicacion` ENABLE KEYS */;
UNLOCK TABLES;


-- vistas del sistema ----
CREATE or replace VIEW `b1`.`viewGeneralBancariosUser` AS select `b1`.`Usuario`.`id` AS `user_id`,`b1`.`Usuario`.`rut` AS `rut`,`b1`.`Usuario`.`rut_provisorio` AS `rut_provisorio`,`b1`.`Usuario`.`nombres` AS `nombres`,`b1`.`Usuario`.`apellido_paterno` AS `apellido_paterno`,`b1`.`Usuario`.`apellido_materno` AS `apellido_materno`,`b1`.`BancariosUser`.`id` AS `bancario_id`,`b1`.`BancariosUser`.`banco_id` AS `banco_id`,`b1`.`BancariosUser`.`numero_cuenta` AS `numero_cuenta`,`b1`.`BancariosUser`.`en_uso` AS `en_uso`,`b1`.`BancariosUser`.`terceros` AS `terceros`,`b1`.`BancariosUser`.`rut_tercero` AS `rut_tercero`,`b1`.`BancariosUser`.`nombre_tercero` AS `nombre_tercero`,`b1`.`BancariosUser`.`email_tercero` AS `email_tercero`,`b1`.`Bancos`.`nombre` AS `banco_nombre`,`b1`.`Bancos`.`codigo` AS `banco_codigo` from ((`b1`.`Usuario` join `b1`.`BancariosUser` on(`b1`.`Usuario`.`id` = `b1`.`BancariosUser`.`user_id`)) join `b1`.`Bancos` on(`b1`.`Bancos`.`id` = `b1`.`BancariosUser`.`banco_id`));

CREATE or replace VIEW `b1`.`viewGeneralUser` AS select `b1`.`Usuario`.`id` AS `id`,`b1`.`Usuario`.`rut` AS `rut`,`b1`.`Usuario`.`rut_provisorio` AS `rut_provisorio`,`b1`.`Usuario`.`nombres` AS `nombres`,`b1`.`Usuario`.`apellido_paterno` AS `apellido_paterno`,`b1`.`Usuario`.`apellido_materno` AS `apellido_materno`,`b1`.`Usuario`.`fecha_nacimiento` AS `fecha_nacimiento`,`b1`.`Usuario`.`sexo_id` AS `sexo_id`,`b1`.`Usuario`.`estado_civil_id` AS `estado_civil_id`,`b1`.`Usuario`.`nacionalidad_id` AS `nacionalidad_id`,`b1`.`Usuario`.`username` AS `username`,`b1`.`Usuario`.`password` AS `password`,`b1`.`Usuario`.`activo` AS `activo`,`b1`.`Usuario`.`created` AS `created`,`b1`.`Usuario`.`updated` AS `updated`,`b1`.`Usuario`.`creator_user` AS `creator_user`,`b1`.`Usuario`.`updater_user` AS `updater_user`,`b1`.`Contacto`.`email` AS `email`,`b1`.`Contacto`.`fijo` AS `fijo`,`b1`.`Contacto`.`movil` AS `movil`,`b1`.`Ubicacion`.`region_id` AS `region_id`,`b1`.`Ubicacion`.`comuna_id` AS `comuna_id`,`b1`.`Ubicacion`.`direccion` AS `direccion`,`b1`.`Regiones`.`nombre` AS `nomregion`,`b1`.`Regiones`.`orden` AS `orden`,`b1`.`Comunas`.`nombre` AS `nomcomuna` from ((((`b1`.`Usuario` left join `b1`.`Contacto` on(`b1`.`Usuario`.`id` = `b1`.`Contacto`.`user_id`)) left join `b1`.`Ubicacion` on(`b1`.`Usuario`.`id` = `b1`.`Ubicacion`.`user_id`)) left join `b1`.`Regiones` on(`b1`.`Ubicacion`.`region_id` = `b1`.`Regiones`.`id`)) left join `b1`.`Comunas` on(`b1`.`Ubicacion`.`comuna_id` = `b1`.`Comunas`.`id` and `b1`.`Ubicacion`.`region_id` = `b1`.`Comunas`.`region_id`));

CREATE or replace VIEW `b1`.`viewGeneralUserModulo` AS select `b1`.`UsuarioModulo`.`id` AS `id`,`b1`.`UsuarioModulo`.`user_id` AS `user_id`,`b1`.`UsuarioModulo`.`modulo_id` AS `modulo_id`,`b1`.`UsuarioModulo`.`estado` AS `estado`,`b1`.`UsuarioModulo`.`created` AS `created`,`b1`.`UsuarioModulo`.`updated` AS `updated`,`b1`.`UsuarioModulo`.`creator_user` AS `creator_user`,`b1`.`UsuarioModulo`.`updater_user` AS `updater_user`,`b1`.`Modulo`.`nombre` AS `nombremodulo`,`b1`.`Modulo`.`url` AS `urlmodulo`,`b1`.`Modulo`.`icono` AS `iconomodulo`,`b1`.`Modulo`.`estado` AS `estadomodulo` from (`b1`.`UsuarioModulo` join `b1`.`Modulo` on(`b1`.`UsuarioModulo`.`modulo_id` = `b1`.`Modulo`.`id`));


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-05 18:18:14
