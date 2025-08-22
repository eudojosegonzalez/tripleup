/* drop DATABASE if exists `b1` ;
CREATE DATABASE if not exists `b1` /*!40100 DEFAULT CHARACTER SET utf8 ;
use b1; */

-- *********************************************************************************
-- Tablas de apoyo
-- *********************************************************************************-- --------------------------------------------------------------------------------
-- Prevision Social 
-- --------------------------------------------------------------------------------
-- AFP
CREATE TABLE `AFP` (
	`id`  bigint auto_increment not null,
	`codigo_previred` varchar(50) NULL,
	`nombre` varchar(100) NULL,
	`cotizacion` numeric(18,4) NULL,
	`cuenta_AFP` varchar(150)  NULL,
	`sis` numeric(18,4) NULL,
	`cuenta_sis_cred` varchar(20) NULL,
	`cuenta_ahorro_AFP_cuenta2` varchar(150) NULL,
	`codigo_direccion_trabajo` varchar(10),
    `created` DATETIME NOT NULL COMMENT 'fecha en que fue creado el parametro',
    `updated` DATETIME NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
    `creator_user` BIGINT NOT NULL COMMENT 'usuario que creó el parametro',
    `updater_user` BIGINT NOT NULL COMMENT 'usuario que actualizó el parametro',    
	PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para almacenar las cuentas AFP';


INSERT INTO AFP VALUES(1 , '08' , 'Provida', 11.450 , '21050001', 1.540 , '21050001' , '21050001' , '6' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO AFP VALUES(2 , '03' , 'Cuprum', 11.440 , '21050001', 1.540 , '21050001' , '21050001' , '13' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO AFP VALUES(3 , '05' , 'Habitat', 11.270 , '21050001', 1.540 , '21050001' , '21050001' , '14' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO AFP VALUES(4 , '29' , 'Plan Vital          ', 11.160 , '21050001', 1.540 , '21050001' , '21050001' , '11' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO AFP VALUES(5 , '33' , 'Capital', 11.440 , '21050001', 1.540 , '21050001' , '21050001' , '31' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO AFP VALUES(6 , '34' , 'Modelo', 10.580 , '21050001', 1.540 , '21050001' , '21050001' , '103' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO AFP VALUES(7 , '00' , 'No está en AFP', 0.000 , '21050001', 1.540 , '21050001' , '21050001' , '100' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO AFP VALUES(8 , '35' , 'Uno', 10.680 , '21050001', 1.540 , '21050001' , '21050001' , '19' , '1990-01-01' , '1990-01-01' , '1' , '1');


-- APVInstituciones
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

insert into  `APVInstituciones` values ('5', 'HABITAT C', 'HABITAT', '21050001', '005', '2024-01-29 01:00:00', '2024-01-29 21:30:26', '1', '1');
insert into  `APVInstituciones` values ('6', 'HABITAT G', 'HABITAT G', '21050001', '006', '2024-01-29 21:32:01', '2024-01-29 21:32:01', '1', '1');
insert into  `APVInstituciones` values ('1005', 'Capital', 'Capital', '21050001', '033', '2024-01-29 01:00:00', '2024-01-29 01:00:00', '1', '1');


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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla para almacenar el historico de las instituciones APV';



-- HistoricoAFP
CREATE TABLE `HistoricoAFP` (
	`id`  bigint auto_increment not null,
	`codigo_previred` varchar(50) NULL,
	`nombre` varchar(100) NULL,
	`cotizacion` numeric(18,4) NULL,
	`cuenta_AFP` varchar(150)  NULL,
	`sis` numeric(18,4) NULL,
	`cuenta_sis_cred` varchar(20) NULL,
	`cuenta_ahorro_AFP_cuenta2` varchar(150) NULL,
	`codigo_direccion_trabajo` varchar(10),
    `created` DATETIME NOT NULL COMMENT 'fecha en que fue creado el AFP',
    `updated` DATETIME NOT NULL COMMENT 'fecha en que fue actualizado el AFP',
    `creator_user` BIGINT NOT NULL COMMENT 'usuario que creó el AFP',
    `updater_user` BIGINT NOT NULL COMMENT 'usuario que actualizó el AFP',   
    `fecha_registro` DATETIME NOT NULL COMMENT 'fecha en que fue creado el registro en el historico',    
	PRIMARY KEY (`id`,`fecha_registro`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para almacenar el historico de las cuentas AFP';



-- PrevisionSalud
CREATE TABLE `PrevisionSalud` (
	`id`  bigint auto_increment not null,
	`codigo_externo` varchar(50)  NULL,
	`nombre` varchar(100) NULL,
	`prevision_salud_cuenta` varchar(150) NULL,
	`codigo_direccion_trabajo` varchar(10) NULL,
    `created` DATETIME NOT NULL COMMENT 'fecha en que fue creado el AFP',
    `updated` DATETIME NOT NULL COMMENT 'fecha en que fue actualizado el AFP',
    `creator_user` BIGINT NOT NULL COMMENT 'usuario que creó el AFP',
    `updater_user` BIGINT NOT NULL COMMENT 'usuario que actualizó el AFP', 
	PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para almacenar los datos de prevision salud';


INSERT INTO PrevisionSalud VALUES(2 , '00' , 'Sin Isapre' , '21050002', NULL , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO PrevisionSalud VALUES(3 , '01' , 'Banmédica' , '21050002' , '3' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO PrevisionSalud VALUES(4 , '02' , 'Consalud' , '21050002' , '9' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO PrevisionSalud VALUES(5 , '03' , 'Vida Tres' , '21050002' , '12' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO PrevisionSalud VALUES(6 , '04' , 'Colmena' , '21050002' , '4' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO PrevisionSalud VALUES(7 , '05' , 'Isapre Cruz Blanca S.A.' , '21050002' , '1' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO PrevisionSalud VALUES(8 , '07' , 'Fonasa' , '21050009' , '102' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO PrevisionSalud VALUES(9 , '09' , 'Chuquicamata' , '21050002' , '37' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO PrevisionSalud VALUES(10 , '000' , 'Ferrosalud' , '21050002', NULL , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO PrevisionSalud VALUES(11 , '11' , 'Inst. de salud Fusat Ltda.' , '21050002' , '39' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO PrevisionSalud VALUES(12 , '12' , 'Isapre Bco. Estado' , '21050002' , '40' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO PrevisionSalud VALUES(13 , '10' , 'Nueva Masvida' , '21050002' , '43' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO PrevisionSalud VALUES(14 , '20' , 'Río Blanco' , '21050002' , '41' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO PrevisionSalud VALUES(15 , '21' , 'San Lorenzo isapre ltda.' , '21050002' , '42' , '1990-01-01' , '1990-01-01' , '1' , '1');
INSERT INTO PrevisionSalud VALUES(16 , '25' , 'Cruz del norte' , '21050002' , '38' , '1990-01-01' , '1990-01-01' , '1' , '1');

-- historico prevision salud
CREATE TABLE `HistoricoPrevisionSalud` (
  `id` bigint NOT NULL AUTO_INCREMENT,  
  `prevision_salud_id` bigint NOT NULL,
  `codigo_externo` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `prevision_salud_cuenta` varchar(150) DEFAULT NULL,
  `codigo_direccion_trabajo` varchar(10) DEFAULT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el AFP',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el AFP',
  `creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el AFP',
  `updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el AFP',
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,  
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla para almacenar los datos historico  de prevision salud';


-- CajasCompesacion
CREATE TABLE IF NOT EXISTS `CajasCompensacion` (
	`id` BIGINT AUTO_INCREMENT NOT NULL,
	`nombre` VARCHAR(200) NOT NULL,
	`codigo_externo` VARCHAR(50) NOT NULL,
	`cuenta_contable` VARCHAR(50) NOT NULL,
	`codigo_direccion_trabajo` VARCHAR(10) NULL,    
	`created` DATETIME NOT NULL COMMENT 'fecha en que fue creado el parametro',
	`updated` DATETIME NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
	`creator_user` BIGINT NOT NULL COMMENT 'usuario que creó el parametro',
	`updater_user` BIGINT NOT NULL COMMENT 'usuario que actualizó el parametro',
	PRIMARY KEY (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT 'Tabla para controlarlar los datos de las cajas de compensacion';

INSERT INTO `CajasCompensacion` VALUES(1, 'Sin CCAF', '00', '21050003', '0', '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO `CajasCompensacion` VALUES(2, 'Los Andes', '01', '21050003', '1', '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO `CajasCompensacion` VALUES(3, 'La Araucana', '02', '21050003', '2', '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO `CajasCompensacion` VALUES(4, 'Los Héroes', '03', '21050003', '3', '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO `CajasCompensacion` VALUES(5, 'Gabriela Mistral', '05', '21050003', NULL, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO `CajasCompensacion` VALUES(6, '18 de Septiembre', '06', '21050003', '4', '1990-01-01', '1990-01-01', '1', '1');

-- CajasCompesacion
CREATE TABLE IF NOT EXISTS `HistoricoCajasCompensacion` (
	`id` BIGINT AUTO_INCREMENT NOT NULL,
	`caja_compensacion_id` BIGINT  NOT NULL,    
	`nombre` VARCHAR(200) NOT NULL,
	`codigo_externo` VARCHAR(50) NOT NULL,
	`cuenta_contable` VARCHAR(50) NOT NULL,
	`codigo_direccion_trabajo` VARCHAR(10) NULL,    
	`created` DATETIME NOT NULL COMMENT 'fecha en que fue creado el parametro',
	`updated` DATETIME NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
	`creator_user` BIGINT NOT NULL COMMENT 'usuario que creó el parametro',
	`updater_user` BIGINT NOT NULL COMMENT 'usuario que actualizó el parametro',
	`fecha_registro` datetime NOT NULL,
	`observaciones` text DEFAULT NULL,    
    PRIMARY KEY (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT 'Tabla para controlarlar los datos historicos de las cajas de compensacion';


-- Mutuales
create table if not exists `Mutuales` (
	`id` bigint auto_increment not null,
	`nombre` varchar(250) not null,	
	`codigo_externo` varchar(50) not null,	    
	`cuenta_contable` varchar(50) not null,	     
	`created` datetime NOT NULL comment 'fecha en que fue creado el parametro',    
	`updated`  datetime NOT NULL  comment 'fecha en que fue actualizado el parametro',   
    `creator_user` BIGINT NOT NULL  comment 'usuario que creó el parametro',     
    `updater_user` BIGINT NOT NULL  comment 'usuario que actualizó el parametro',     
    primary key (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlarlar las empresas mutuales';

INSERT INTO Mutuales VALUES(7, 'Asociación Chilena de seguridad (ACHS) ','01',  '21050004', '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Mutuales VALUES(8, 'Mutual de seguridad CCHC', '21050004', '02', '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Mutuales VALUES(9,  'Instituto de seguridad del trabajo I.S.T ', '03','21050004', '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Mutuales VALUES(12,  'Sin Mutual - Empresa entrega aporte Accidentes del Trabajo al ISL','00', '21050004', '1990-01-01', '1990-01-01', '1', '1');


-- UnidadesPacto
create table if not exists `UnidadesPacto` (
	`id` bigint auto_increment not null,
	`descripcion` varchar(150) not null,    
	`estado` boolean not null comment '0 Inactivo 1 Activo',      
    primary key (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlar las unidades de pacto de los eventos de nomina';


-- tramos de impuesto unico --
CREATE TABLE `TramosImpuestoUnico` (
  `id` bigint auto_increment NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de TramosImpuestoUnico';

insert into  `TramosImpuestoUnico` values ('1','Tramo 1','0.000','13.500','0.000','0.000','2024-02-26 10:00','2024-02-26 10:00','1','1');
insert into  `TramosImpuestoUnico` values ('2','Tramo 2','13.500','30.000','0.040','0.540','2024-02-26 10:00','2024-02-26 10:00','1','1');
insert into  `TramosImpuestoUnico` values ('3','Tramo 3','30.000','50.000','0.080','1.740','2024-02-26 10:00','2024-02-26 10:00','1','1');
insert into  `TramosImpuestoUnico` values ('4','Tramo 4','50.000','70.000','0.135','4.490','2024-02-26 10:00','2024-02-26 10:00','1','1');
insert into  `TramosImpuestoUnico` values ('5','Tramo 5','70.000','90.000','0.230','11.140','2024-02-26 10:00','2024-02-26 10:00','1','1');
insert into  `TramosImpuestoUnico` values ('6','Tramo 6','90.000','120.000','0.304','17.800','2024-02-26 10:00','2024-02-26 10:00','1','1');
insert into  `TramosImpuestoUnico` values ('7','Tramo 7','120.000','10.000','0.350','23.320','2024-02-26 10:00','2024-02-26 10:00','1','1');
insert into  `TramosImpuestoUnico` values ('8','Tramo 8','310.000','999.000','0.400','38.820','2024-02-26 10:00','2024-02-26 10:00','1','1');

-- historico de tramos de impuesto unico
CREATE TABLE `HistoricocoTramosImpuestoUnico` (
	`id` bigint auto_increment NOT NULL,
	`tramo_impuesto_id` bigint NOT NULL,  
	`tramo` varchar(50) NOT NULL,
	`desde` decimal(18,4) NOT NULL,
	`hasta` decimal(18,4) NOT NULL,
	`factor` decimal(18,4) DEFAULT NULL,
	`rebaja` decimal(18,4) DEFAULT NULL,
	`created` datetime NOT NULL,
	`updated` datetime NOT NULL,
	`creator_user` bigint(20) NOT NULL,
	`updater_user` bigint(20) NOT NULL,
	`fecha_registro` datetime NOT NULL,
	`observaciones` text DEFAULT NULL,    
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de Historico de TramosImpuestoUnico';


-- TramosAsignacionFamiliar
CREATE TABLE `TramosAsignacionFamiliar` (
	`id` bigint auto_increment NOT NULL,
	`tramo` nvarchar(5) not NULL,
	`desde` numeric(18,4) NULL,
	`hasta` numeric(18,4) NULL,
	`valor_carga` numeric(18,4) NULL,
	`created` datetime NOT NULL,    
	`updated`  datetime NOT NULL,   
    `creator_user` BIGINT NOT NULL,     
    `updater_user` BIGINT NOT NULL,    
	 PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla de Tramos de Asignacion Familiar';

insert into TramosAsignacionFamiliar values ('1','A','0.000','315841.000','12364','2024-02-27 15:00','2024-02-27 15:00','1','1');
insert into TramosAsignacionFamiliar values ('2','B','315841.000','461320.000','7587','2024-02-27 15:00','2024-02-27 15:00','1','1');
insert into TramosAsignacionFamiliar values ('3','C','461320.000','719502.000','2398','2024-02-27 15:00','2024-02-27 15:00','1','1');
insert into TramosAsignacionFamiliar values ('4','D','719502.000','9999999.000','0','2024-02-27 15:00','2024-02-27 15:00','1','1');

-- TramosAsignacionFamiliar
CREATE TABLE `HistoricoTramosAsignacionFamiliar` (
	`id` bigint auto_increment not NULL,
	`tramo_asignacion_familiar_id` bigint not NULL,    
	`tramo` nvarchar(5) not NULL,
	`desde` numeric(18,4) NULL,
	`hasta` numeric(18,4) NULL,
	`valor_carga` numeric(18,4) NULL,
	`created` datetime NOT NULL,    
	`updated`  datetime NOT NULL,   
    `creator_user` BIGINT NOT NULL,     
    `updater_user` BIGINT NOT NULL,   
	`fecha_registro` datetime NOT NULL,
	`observaciones` text DEFAULT NULL,    
	 PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla de Historico Tramos Asignacion Familiar';

-- InstitucionesAPV
CREATE TABLE `InstitucionesAPV` (
	`id` bigint auto_increment  NOT NULL,
	`nombre` varchar(30) not NULL,
	`nombre_largo` text  NULL,
	`cuenta_contable` varchar(100)  NULL,
	`codigo_externo` nvarchar(50)  NULL,
	`created` datetime NOT NULL,    
	`updated`  datetime NOT NULL,   
    `creator_user` BIGINT NOT NULL,     
    `updater_user` BIGINT NOT NULL,    
	PRIMARY KEY (`id`)
);
-- --------------------------------------------------------------------------------
-- Geograficas 
-- --------------------------------------------------------------------------------
-- Regiones
create table if not exists `Regiones`(
	`id` bigint auto_increment not null,
	`nombre` varchar(250) not null,
	`orden` int not null,        
    primary key (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para almacenar la información geográfica de las Regiones';INSERT INTO `Regiones` VALUES(1, 'Tarapacá', 3);
INSERT INTO `Regiones` VALUES(2, 'Antofagasta', 4);
INSERT INTO `Regiones` VALUES(3, 'Atacama ', 5);
INSERT INTO `Regiones` VALUES(4, 'Coquimbo ', 6);
INSERT INTO `Regiones` VALUES(5, 'Valparaíso ', 7);
INSERT INTO `Regiones` VALUES(6, 'Lib. Gral. B. O''Higgins', 8);
INSERT INTO `Regiones` VALUES(7, 'Maule', 9);
INSERT INTO `Regiones` VALUES(8, 'Bio Bio', 10);
INSERT INTO `Regiones` VALUES(9, 'Araucanía', 11);
INSERT INTO `Regiones` VALUES(10, 'Los Lagos', 12);
INSERT INTO `Regiones` VALUES(11, 'Aysen', 13);
INSERT INTO `Regiones` VALUES(12, 'Magallanes', 14);
INSERT INTO `Regiones` VALUES(13, 'Metropolitana', 1);
INSERT INTO `Regiones` VALUES(14, 'Los Ríos', 16);
INSERT INTO `Regiones` VALUES(15, 'Región de Arica y Parinacota ', 2);

-- Comunas
create table if not exists `Comunas` (
	`id` bigint auto_increment not null,
	`nombre` varchar(150) not null,  
	`region_id` bigint  not null,    
    primary key (`id`),
    constraint `FK_Region_Comuna` foreign key (`region_id`) references `Regiones`(`id`)
    on update cascade on delete restrict
) ENGINE=InnoDB DEFAULT CHARSET=utf8  comment 'Tabla para almacenar la información geográfica de las Comunas';

INSERT INTO `Comunas` Values (1101, 'Iquique', 1);
INSERT INTO `Comunas` Values (1107, 'Alto Hospicio', 1);
INSERT INTO `Comunas` Values (1401, 'Pozo Almonte', 1);
INSERT INTO `Comunas` Values (1402, 'Camiña', 1);
INSERT INTO `Comunas` Values (1403, 'Colchane', 1);
INSERT INTO `Comunas` Values (1404, 'Huara', 1);
INSERT INTO `Comunas` Values (1405, 'Pica', 1);
INSERT INTO `Comunas` Values (2101, 'Antofagasta', 2);
INSERT INTO `Comunas` Values (2102, 'Mejillones', 2);
INSERT INTO `Comunas` Values (2103, 'Sierra Gorda', 2);
INSERT INTO `Comunas` Values (2104, 'Taltal', 2);
INSERT INTO `Comunas` Values (2201, 'Calama', 2);
INSERT INTO `Comunas` Values (2202, 'Ollagüe', 2);
INSERT INTO `Comunas` Values (2203, 'San Pedro de Atacama', 2);
INSERT INTO `Comunas` Values (2301, 'Tocopilla', 2);
INSERT INTO `Comunas` Values (2302, 'María Elena', 2);
INSERT INTO `Comunas` Values (3101, 'Copiapó', 3);
INSERT INTO `Comunas` Values (3102, 'Caldera', 3);
INSERT INTO `Comunas` Values (3103, 'Tierra Amarilla', 3);
INSERT INTO `Comunas` Values (3201, 'Chañaral', 3);
INSERT INTO `Comunas` Values (3202, 'Diego de Almagro', 3);
INSERT INTO `Comunas` Values (3301, 'Vallenar', 3);
INSERT INTO `Comunas` Values (3302, 'Alto del Carmen', 3);
INSERT INTO `Comunas` Values (3303, 'Freirina', 3);
INSERT INTO `Comunas` Values (3304, 'Huasco', 3);
INSERT INTO `Comunas` Values (4101, 'La Serena', 4);
INSERT INTO `Comunas` Values (4102, 'Coquimbo', 4);
INSERT INTO `Comunas` Values (4103, 'Andacollo', 4);
INSERT INTO `Comunas` Values (4104, 'La Higuera', 4);
INSERT INTO `Comunas` Values (4105, 'Paiguano', 4);
INSERT INTO `Comunas` Values (4106, 'Vicuña', 4);
INSERT INTO `Comunas` Values (4201, 'Illapel', 4);
INSERT INTO `Comunas` Values (4202, 'Canela', 4);
INSERT INTO `Comunas` Values (4203, 'Los Vilos', 4);
INSERT INTO `Comunas` Values (4204, 'Salamanca', 4);
INSERT INTO `Comunas` Values (4301, 'Ovalle', 4);
INSERT INTO `Comunas` Values (4302, 'Combarbalá', 4);
INSERT INTO `Comunas` Values (4303, 'Monte Patria', 4);
INSERT INTO `Comunas` Values (4304, 'Punitaqui', 4);
INSERT INTO `Comunas` Values (4305, 'Río Hurtado', 4);
INSERT INTO `Comunas` Values (5101, 'Valparaíso', 5);
INSERT INTO `Comunas` Values (5102, 'Casablanca', 5);
INSERT INTO `Comunas` Values (5103, 'Concón', 5);
INSERT INTO `Comunas` Values (5104, 'Juan Fernández', 5);
INSERT INTO `Comunas` Values (5105, 'Puchuncaví', 5);
INSERT INTO `Comunas` Values (5107, 'Quintero', 5);
INSERT INTO `Comunas` Values (5109, 'Viña del Mar', 5);
INSERT INTO `Comunas` Values (5201, 'Isla de Pascua', 5);
INSERT INTO `Comunas` Values (5301, 'Los Andes', 5);
INSERT INTO `Comunas` Values (5302, 'Calle Larga', 5);
INSERT INTO `Comunas` Values (5303, 'Rinconada', 5);
INSERT INTO `Comunas` Values (5304, 'San Esteban', 5);
INSERT INTO `Comunas` Values (5401, 'La Ligua', 5);
INSERT INTO `Comunas` Values (5402, 'Cabildo', 5);
INSERT INTO `Comunas` Values (5403, 'Papudo', 5);
INSERT INTO `Comunas` Values (5404, 'Petorca', 5);
INSERT INTO `Comunas` Values (5405, 'Zapallar', 5);
INSERT INTO `Comunas` Values (5501, 'Quillota', 5);
INSERT INTO `Comunas` Values (5502, 'Calera', 5);
INSERT INTO `Comunas` Values (5503, 'Hijuelas', 5);
INSERT INTO `Comunas` Values (5504, 'La Cruz', 5);
INSERT INTO `Comunas` Values (5506, 'Nogales', 5);
INSERT INTO `Comunas` Values (5601, 'San Antonio', 5);
INSERT INTO `Comunas` Values (5602, 'Algarrobo', 5);
INSERT INTO `Comunas` Values (5603, 'Cartagena', 5);
INSERT INTO `Comunas` Values (5604, 'El Quisco', 5);
INSERT INTO `Comunas` Values (5605, 'El Tabo', 5);
INSERT INTO `Comunas` Values (5606, 'Santo Domingo', 5);
INSERT INTO `Comunas` Values (5701, 'San Felipe', 5);
INSERT INTO `Comunas` Values (5702, 'Catemu', 5);
INSERT INTO `Comunas` Values (5703, 'Llaillay', 5);
INSERT INTO `Comunas` Values (5704, 'Panquehue', 5);
INSERT INTO `Comunas` Values (5705, 'Putaendo', 5);
INSERT INTO `Comunas` Values (5706, 'Santa María', 5);
INSERT INTO `Comunas` Values (5801, 'Quilpué', 5);
INSERT INTO `Comunas` Values (5802, 'Limache', 5);
INSERT INTO `Comunas` Values (5803, 'Olmué', 5);
INSERT INTO `Comunas` Values (5804, 'Villa Alemana', 5);
INSERT INTO `Comunas` Values (6101, 'Rancagua', 6);
INSERT INTO `Comunas` Values (6102, 'Codegua', 6);
INSERT INTO `Comunas` Values (6103, 'Coinco', 6);
INSERT INTO `Comunas` Values (6104, 'Coltauco', 6);
INSERT INTO `Comunas` Values (6105, 'Doñihue', 6);
INSERT INTO `Comunas` Values (6106, 'Graneros', 6);
INSERT INTO `Comunas` Values (6107, 'Las Cabras', 6);
INSERT INTO `Comunas` Values (6108, 'Machalí', 6);
INSERT INTO `Comunas` Values (6109, 'Malloa', 6);
INSERT INTO `Comunas` Values (6110, 'Mostazal', 6);
INSERT INTO `Comunas` Values (6111, 'Olivar', 6);
INSERT INTO `Comunas` Values (6112, 'Peumo', 6);
INSERT INTO `Comunas` Values (6113, 'Pichidegua', 6);
INSERT INTO `Comunas` Values (6114, 'Quinta de Tilcoco', 6);
INSERT INTO `Comunas` Values (6115, 'Rengo', 6);
INSERT INTO `Comunas` Values (6116, 'Requínoa', 6);
INSERT INTO `Comunas` Values (6117, 'San Vicente', 6);
INSERT INTO `Comunas` Values (6201, 'Pichilemu', 6);
INSERT INTO `Comunas` Values (6202, 'La Estrella', 6);
INSERT INTO `Comunas` Values (6203, 'Litueche', 6);
INSERT INTO `Comunas` Values (6204, 'Marchihue', 6);
INSERT INTO `Comunas` Values (6205, 'Navidad', 6);
INSERT INTO `Comunas` Values (6206, 'Paredones', 6);
INSERT INTO `Comunas` Values (6301, 'San Fernando', 6);
INSERT INTO `Comunas` Values (6302, 'Chépica', 6);
INSERT INTO `Comunas` Values (6303, 'Chimbarongo', 6);
INSERT INTO `Comunas` Values (6304, 'Lolol', 6);
INSERT INTO `Comunas` Values (6305, 'Nancagua', 6);
INSERT INTO `Comunas` Values (6306, 'Palmilla', 6);
INSERT INTO `Comunas` Values (6307, 'Peralillo', 6);
INSERT INTO `Comunas` Values (6308, 'Placilla', 6);
INSERT INTO `Comunas` Values (6309, 'Pumanque', 6);
INSERT INTO `Comunas` Values (6310, 'Santa Cruz', 6);
INSERT INTO `Comunas` Values (7101, 'Talca', 7);
INSERT INTO `Comunas` Values (7102, 'Constitución', 7);
INSERT INTO `Comunas` Values (7103, 'Curepto', 7);
INSERT INTO `Comunas` Values (7104, 'Empedrado', 7);
INSERT INTO `Comunas` Values (7105, 'Maule', 7);
INSERT INTO `Comunas` Values (7106, 'Pelarco', 7);
INSERT INTO `Comunas` Values (7107, 'Pencahue', 7);
INSERT INTO `Comunas` Values (7108, 'Río Claro', 7);
INSERT INTO `Comunas` Values (7109, 'San Clemente', 7);
INSERT INTO `Comunas` Values (7110, 'San Rafael', 7);
INSERT INTO `Comunas` Values (7201, 'Cauquenes', 7);
INSERT INTO `Comunas` Values (7202, 'Chanco', 7);
INSERT INTO `Comunas` Values (7203, 'Pelluhue', 7);
INSERT INTO `Comunas` Values (7301, 'Curicó', 7);
INSERT INTO `Comunas` Values (7302, 'Hualañé', 7);
INSERT INTO `Comunas` Values (7303, 'Licantén', 7);
INSERT INTO `Comunas` Values (7304, 'Molina', 7);
INSERT INTO `Comunas` Values (7305, 'Rauco', 7);
INSERT INTO `Comunas` Values (7306, 'Romeral', 7);
INSERT INTO `Comunas` Values (7307, 'Sagrada Familia', 7);
INSERT INTO `Comunas` Values (7308, 'Teno', 7);
INSERT INTO `Comunas` Values (7309, 'Vichuquén', 7);
INSERT INTO `Comunas` Values (7401, 'Linares', 7);
INSERT INTO `Comunas` Values (7402, 'Colbún', 7);
INSERT INTO `Comunas` Values (7403, 'Longaví', 7);
INSERT INTO `Comunas` Values (7404, 'Parral', 7);
INSERT INTO `Comunas` Values (7405, 'Retiro', 7);
INSERT INTO `Comunas` Values (7406, 'San Javier', 7);
INSERT INTO `Comunas` Values (7407, 'Villa Alegre', 7);
INSERT INTO `Comunas` Values (7408, 'Yerbas Buenas', 7);
INSERT INTO `Comunas` Values (8101, 'Concepción', 8);
INSERT INTO `Comunas` Values (8102, 'Coronel', 8);
INSERT INTO `Comunas` Values (8103, 'Chiguayante', 8);
INSERT INTO `Comunas` Values (8104, 'Florida', 8);
INSERT INTO `Comunas` Values (8105, 'Hualqui', 8);
INSERT INTO `Comunas` Values (8106, 'Lota', 8);
INSERT INTO `Comunas` Values (8107, 'Penco', 8);
INSERT INTO `Comunas` Values (8108, 'San Pedro de la Paz', 8);
INSERT INTO `Comunas` Values (8109, 'Santa Juana', 8);
INSERT INTO `Comunas` Values (8110, 'Talcahuano', 8);
INSERT INTO `Comunas` Values (8111, 'Tomé', 8);
INSERT INTO `Comunas` Values (8112, 'Hualpén', 8);
INSERT INTO `Comunas` Values (8201, 'Lebu', 8);
INSERT INTO `Comunas` Values (8202, 'Arauco', 8);
INSERT INTO `Comunas` Values (8203, 'Cañete', 8);
INSERT INTO `Comunas` Values (8204, 'Contulmo', 8);
INSERT INTO `Comunas` Values (8205, 'Curanilahue', 8);
INSERT INTO `Comunas` Values (8206, 'Los Álamos', 8);
INSERT INTO `Comunas` Values (8207, 'Tirúa', 8);
INSERT INTO `Comunas` Values (8301, 'Los Ángeles', 8);
INSERT INTO `Comunas` Values (8302, 'Antuco', 8);
INSERT INTO `Comunas` Values (8303, 'Cabrero', 8);
INSERT INTO `Comunas` Values (8304, 'Laja', 8);
INSERT INTO `Comunas` Values (8305, 'Mulchén', 8);
INSERT INTO `Comunas` Values (8306, 'Nacimiento', 8);
INSERT INTO `Comunas` Values (8307, 'Negrete', 8);
INSERT INTO `Comunas` Values (8308, 'Quilaco', 8);
INSERT INTO `Comunas` Values (8309, 'Quilleco', 8);
INSERT INTO `Comunas` Values (8310, 'San Rosendo', 8);
INSERT INTO `Comunas` Values (8311, 'Santa Bárbara', 8);
INSERT INTO `Comunas` Values (8312, 'Tucapel', 8);
INSERT INTO `Comunas` Values (8313, 'Yumbel', 8);
INSERT INTO `Comunas` Values (8314, 'Alto Biobío', 8);
INSERT INTO `Comunas` Values (8401, 'Chillán', 8);
INSERT INTO `Comunas` Values (8402, 'Bulnes', 8);
INSERT INTO `Comunas` Values (8403, 'Cobquecura', 8);
INSERT INTO `Comunas` Values (8404, 'Coelemu', 8);
INSERT INTO `Comunas` Values (8405, 'Coihueco', 8);
INSERT INTO `Comunas` Values (8406, 'Chillán Viejo', 8);
INSERT INTO `Comunas` Values (8407, 'El Carmen', 8);
INSERT INTO `Comunas` Values (8408, 'Ninhue', 8);
INSERT INTO `Comunas` Values (8409, 'Ñiquén', 8);
INSERT INTO `Comunas` Values (8410, 'Pemuco', 8);
INSERT INTO `Comunas` Values (8411, 'Pinto', 8);
INSERT INTO `Comunas` Values (8412, 'Portezuelo', 8);
INSERT INTO `Comunas` Values (8413, 'Quillón', 8);
INSERT INTO `Comunas` Values (8414, 'Quirihue', 8);
INSERT INTO `Comunas` Values (8415, 'Ránquil', 8);
INSERT INTO `Comunas` Values (8416, 'San Carlos', 8);
INSERT INTO `Comunas` Values (8417, 'San Fabián', 8);
INSERT INTO `Comunas` Values (8418, 'San Ignacio', 8);
INSERT INTO `Comunas` Values (8419, 'San Nicolás', 8);
INSERT INTO `Comunas` Values (8420, 'Treguaco', 8);
INSERT INTO `Comunas` Values (8421, 'Yungay', 8);
INSERT INTO `Comunas` Values (9101, 'Temuco', 9);
INSERT INTO `Comunas` Values (9102, 'Carahue', 9);
INSERT INTO `Comunas` Values (9103, 'Cunco', 9);
INSERT INTO `Comunas` Values (9104, 'Curarrehue', 9);
INSERT INTO `Comunas` Values (9105, 'Freire', 9);
INSERT INTO `Comunas` Values (9106, 'Galvarino', 9);
INSERT INTO `Comunas` Values (9107, 'Gorbea', 9);
INSERT INTO `Comunas` Values (9108, 'Lautaro', 9);
INSERT INTO `Comunas` Values (9109, 'Loncoche', 9);
INSERT INTO `Comunas` Values (9110, 'Melipeuco', 9);
INSERT INTO `Comunas` Values (9111, 'Nueva Imperial', 9);
INSERT INTO `Comunas` Values (9112, 'Padre Las Casas', 9);
INSERT INTO `Comunas` Values (9113, 'Perquenco', 9);
INSERT INTO `Comunas` Values (9114, 'Pitrufquén', 9);
INSERT INTO `Comunas` Values (9115, 'Pucón', 9);
INSERT INTO `Comunas` Values (9116, 'Saavedra', 9);
INSERT INTO `Comunas` Values (9117, 'Teodoro Schmidt', 9);
INSERT INTO `Comunas` Values (9118, 'Toltén', 9);
INSERT INTO `Comunas` Values (9119, 'Vilcún', 9);
INSERT INTO `Comunas` Values (9120, 'Villarrica', 9);
INSERT INTO `Comunas` Values (9121, 'Cholchol', 9);
INSERT INTO `Comunas` Values (9201, 'Angol', 9);
INSERT INTO `Comunas` Values (9202, 'Collipulli', 9);
INSERT INTO `Comunas` Values (9203, 'Curacautín', 9);
INSERT INTO `Comunas` Values (9204, 'Ercilla', 9);
INSERT INTO `Comunas` Values (9205, 'Lonquimay', 9);
INSERT INTO `Comunas` Values (9206, 'Los Sauces', 9);
INSERT INTO `Comunas` Values (9207, 'Lumaco', 9);
INSERT INTO `Comunas` Values (9208, 'Purén', 9);
INSERT INTO `Comunas` Values (9209, 'Renaico', 9);
INSERT INTO `Comunas` Values (9210, 'Traiguén', 9);
INSERT INTO `Comunas` Values (9211, 'Victoria', 9);
INSERT INTO `Comunas` Values (10101, 'Puerto Montt', 10);
INSERT INTO `Comunas` Values (10102, 'Calbuco', 10);
INSERT INTO `Comunas` Values (10103, 'Cochamó', 10);
INSERT INTO `Comunas` Values (10104, 'Fresia', 10);
INSERT INTO `Comunas` Values (10105, 'Frutillar', 10);
INSERT INTO `Comunas` Values (10106, 'Los Muermos', 10);
INSERT INTO `Comunas` Values (10107, 'Llanquihue', 10);
INSERT INTO `Comunas` Values (10108, 'Maullín', 10);
INSERT INTO `Comunas` Values (10109, 'Puerto Varas', 10);
INSERT INTO `Comunas` Values (10201, 'Castro', 10);
INSERT INTO `Comunas` Values (10202, 'Ancud', 10);
INSERT INTO `Comunas` Values (10203, 'Chonchi', 10);
INSERT INTO `Comunas` Values (10204, 'Curaco de Vélez', 10);
INSERT INTO `Comunas` Values (10205, 'Dalcahue', 10);
INSERT INTO `Comunas` Values (10206, 'Puqueldón', 10);
INSERT INTO `Comunas` Values (10207, 'Queilén', 10);
INSERT INTO `Comunas` Values (10208, 'Quellón', 10);
INSERT INTO `Comunas` Values (10209, 'Quemchi', 10);
INSERT INTO `Comunas` Values (10210, 'Quinchao', 10);
INSERT INTO `Comunas` Values (10301, 'Osorno', 10);
INSERT INTO `Comunas` Values (10302, 'Puerto Octay', 10);
INSERT INTO `Comunas` Values (10303, 'Purranque', 10);
INSERT INTO `Comunas` Values (10304, 'Puyehue', 10);
INSERT INTO `Comunas` Values (10305, 'Río Negro', 10);
INSERT INTO `Comunas` Values (10306, 'San Juan de la Costa', 10);
INSERT INTO `Comunas` Values (10307, 'San Pablo', 10);
INSERT INTO `Comunas` Values (10401, 'Chaitén', 10);
INSERT INTO `Comunas` Values (10402, 'Futaleufú', 10);
INSERT INTO `Comunas` Values (10403, 'Hualaihué', 10);
INSERT INTO `Comunas` Values (10404, 'Palena', 10);
INSERT INTO `Comunas` Values (11101, 'Coyhaique', 11);
INSERT INTO `Comunas` Values (11102, 'Lago Verde', 11);
INSERT INTO `Comunas` Values (11201, 'Aysén', 11);
INSERT INTO `Comunas` Values (11202, 'Cisnes', 11);
INSERT INTO `Comunas` Values (11203, 'Guaitecas', 11);
INSERT INTO `Comunas` Values (11301, 'Cochrane', 11);
INSERT INTO `Comunas` Values (11302, 'O’Higgins', 11);
INSERT INTO `Comunas` Values (11303, 'Tortel', 11);
INSERT INTO `Comunas` Values (11401, 'Chile Chico', 11);
INSERT INTO `Comunas` Values (11402, 'Río Ibáñez', 11);
INSERT INTO `Comunas` Values (12101, 'Punta Arenas', 12);
INSERT INTO `Comunas` Values (12102, 'Laguna Blanca', 12);
INSERT INTO `Comunas` Values (12103, 'Río Verde', 12);
INSERT INTO `Comunas` Values (12104, 'San Gregorio', 12);
INSERT INTO `Comunas` Values (12201, 'Cabo de Hornos (Ex - Navarino)', 12);
INSERT INTO `Comunas` Values (12202, 'Antártica', 12);
INSERT INTO `Comunas` Values (12301, 'Porvenir', 12);
INSERT INTO `Comunas` Values (12302, 'Primavera', 12);
INSERT INTO `Comunas` Values (12303, 'Timaukel', 12);
INSERT INTO `Comunas` Values (12401, 'Natales', 12);
INSERT INTO `Comunas` Values (12402, 'Torres del Paine', 12);
INSERT INTO `Comunas` Values (13101, 'Santiago', 13);
INSERT INTO `Comunas` Values (13102, 'Cerrillos', 13);
INSERT INTO `Comunas` Values (13103, 'Cerro Navia', 13);
INSERT INTO `Comunas` Values (13104, 'Conchalí', 13);
INSERT INTO `Comunas` Values (13105, 'El Bosque', 13);
INSERT INTO `Comunas` Values (13106, 'Estación Central', 13);
INSERT INTO `Comunas` Values (13107, 'Huechuraba', 13);
INSERT INTO `Comunas` Values (13108, 'Independencia', 13);
INSERT INTO `Comunas` Values (13109, 'La Cisterna', 13);
INSERT INTO `Comunas` Values (13110, 'La Florida', 13);
INSERT INTO `Comunas` Values (13111, 'La Granja', 13);
INSERT INTO `Comunas` Values (13112, 'La Pintana', 13);
INSERT INTO `Comunas` Values (13113, 'La Reina', 13);
INSERT INTO `Comunas` Values (13114, 'Las Condes', 13);
INSERT INTO `Comunas` Values (13115, 'Lo Barnechea', 13);
INSERT INTO `Comunas` Values (13116, 'Lo Espejo', 13);
INSERT INTO `Comunas` Values (13117, 'Lo Prado', 13);
INSERT INTO `Comunas` Values (13118, 'Macul', 13);
INSERT INTO `Comunas` Values (13119, 'Maipú', 13);
INSERT INTO `Comunas` Values (13120, 'Ñuñoa', 13);
INSERT INTO `Comunas` Values (13121, 'Pedro Aguirre Cerda', 13);
INSERT INTO `Comunas` Values (13122, 'Peñalolén', 13);
INSERT INTO `Comunas` Values (13123, 'Providencia', 13);
INSERT INTO `Comunas` Values (13124, 'Pudahuel', 13);
INSERT INTO `Comunas` Values (13125, 'Quilicura', 13);
INSERT INTO `Comunas` Values (13126, 'Quinta Normal', 13);
INSERT INTO `Comunas` Values (13127, 'Recoleta', 13);
INSERT INTO `Comunas` Values (13128, 'Renca', 13);
INSERT INTO `Comunas` Values (13129, 'San Joaquín', 13);
INSERT INTO `Comunas` Values (13130, 'San Miguel', 13);
INSERT INTO `Comunas` Values (13131, 'San Ramón', 13);
INSERT INTO `Comunas` Values (13132, 'Vitacura', 13);
INSERT INTO `Comunas` Values (13201, 'Puente Alto', 13);
INSERT INTO `Comunas` Values (13202, 'Pirque', 13);
INSERT INTO `Comunas` Values (13203, 'San José de Maipo', 13);
INSERT INTO `Comunas` Values (13301, 'Colina', 13);
INSERT INTO `Comunas` Values (13302, 'Lampa ', 13);
INSERT INTO `Comunas` Values (13303, 'Tiltil', 13);
INSERT INTO `Comunas` Values (13401, 'San Bernardo', 13);
INSERT INTO `Comunas` Values (13402, 'Buin', 13);
INSERT INTO `Comunas` Values (13403, 'Calera de Tango', 13);
INSERT INTO `Comunas` Values (13404, 'Paine', 13);
INSERT INTO `Comunas` Values (13501, 'Melipilla', 13);
INSERT INTO `Comunas` Values (13502, 'Alhué', 13);
INSERT INTO `Comunas` Values (13503, 'Curacaví', 13);
INSERT INTO `Comunas` Values (13504, 'María Pinto', 13);
INSERT INTO `Comunas` Values (13505, 'San Pedro', 13);
INSERT INTO `Comunas` Values (13601, 'Talagante', 13);
INSERT INTO `Comunas` Values (13602, 'El Monte', 13);
INSERT INTO `Comunas` Values (13603, 'Isla de Maipo', 13);
INSERT INTO `Comunas` Values (13604, 'Padre Hurtado', 13);
INSERT INTO `Comunas` Values (13605, 'Peñaflor', 13);
INSERT INTO `Comunas` Values (14101, 'Valdivia', 14);
INSERT INTO `Comunas` Values (14102, 'Corral', 14);
INSERT INTO `Comunas` Values (14103, 'Lanco', 14);
INSERT INTO `Comunas` Values (14104, 'Los Lagos', 14);
INSERT INTO `Comunas` Values (14105, 'Máfil', 14);
INSERT INTO `Comunas` Values (14106, 'Mariquina', 14);
INSERT INTO `Comunas` Values (14107, 'Paillaco', 14);
INSERT INTO `Comunas` Values (14108, 'Panguipulli', 14);
INSERT INTO `Comunas` Values (14201, 'La Unión', 14);
INSERT INTO `Comunas` Values (14202, 'Futrono', 14);
INSERT INTO `Comunas` Values (14203, 'Lago Ranco', 14);
INSERT INTO `Comunas` Values (14204, 'Río Bueno', 14);
INSERT INTO `Comunas` Values (15101, 'Arica', 15);
INSERT INTO `Comunas` Values (15102, 'Camarones', 15);
INSERT INTO `Comunas` Values (15201, 'Putre', 15);
INSERT INTO `Comunas` Values (15202, 'General Lagos', 15);

-- --------------------------------------------------------------------------------
-- Civiles
-- --------------------------------------------------------------------------------
 -- Nacionalidades
  create table if not exists `Nacionalidad`(
	`id` bigint auto_increment not null,
    `Nacionalidad` varchar(150) not null,
	primary key (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8  comment 'Tabla para las nacionalidades del usuario';

INSERT INTO `Nacionalidad` VALUES(1, 'CHILENA');
INSERT INTO `Nacionalidad` VALUES(2, 'PERUANA');
INSERT INTO `Nacionalidad` VALUES(3, 'VENEZOLANA');
INSERT INTO `Nacionalidad` VALUES(4, 'ESPAÑOLA');
INSERT INTO `Nacionalidad` VALUES(5, 'COLOMBIANA');
INSERT INTO `Nacionalidad` VALUES(6, 'URUGUAYA');
INSERT INTO `Nacionalidad` VALUES(7, 'BOLIVIANA');
INSERT INTO `Nacionalidad` VALUES(1001, 'CUBANA');


 -- EstadoCivil
 create table if not exists `EstadoCivil`(
	`id` bigint auto_increment not null,
    `descripcion` varchar(50) not null,
	primary key (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8  comment 'Tabla para el estado civil del usuario';

INSERT INTO `EstadoCivil` VALUES(1, 'Soltero');
INSERT INTO `EstadoCivil` VALUES(2, 'Casado');
INSERT INTO `EstadoCivil` VALUES(3, 'Viudo');
INSERT INTO `EstadoCivil` VALUES(4, 'Divorciado');

-- Sexo
create table if not exists `Sexo` (
	`id` bigint auto_increment not null,
	`descripcion` varchar(150) not null, 
    primary key (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para el sexo del usuario';

INSERT INTO `Sexo` VALUES('1', 'Hombre');
INSERT INTO `Sexo` VALUES('2', 'Mujer');

-- NivelEstudio
create table if not exists `NivelEstudio` (
	`id` bigint auto_increment not null,
	`descripcion` varchar(150) not null,   
    primary key (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlar los diferentes niveles académicos del usuario';

INSERT INTO  `NivelEstudio` VALUES(1, 'Básica');
INSERT INTO  `NivelEstudio` VALUES(2, 'Media Científico Humanista');
INSERT INTO  `NivelEstudio` VALUES(3, 'Media Técnico Profesional');
INSERT INTO  `NivelEstudio` VALUES(4, 'Superior Técnica (CFT o IP)');
INSERT INTO  `NivelEstudio` VALUES(5, 'Universitaria');

-- ---------------------------------------------------------------------------------
-- Bancarios
-- ---------------------------------------------------------------------------------
-- Bancos
create table if not exists `Bancos` (
	`id` bigint auto_increment not null,
	`codigo` varchar(50) not null,    
	`nombre` varchar(150) not null,   
	`nomina` boolean not null comment '0 No genera Nomina 1 Genera Nomina',  
    `created` DATETIME NOT NULL COMMENT 'fecha en que fue creado el parametro',
    `updated` DATETIME NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
    `creator_user` BIGINT NOT NULL COMMENT 'usuario que creó el parametro',
    `updater_user` BIGINT NOT NULL COMMENT 'usuario que actualizó el parametro',    
    primary key (`id`),
    unique (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlar los diferentes bancos en el sistema';

INSERT INTO Bancos  VALUES ('1','001', 'BANCO CHILE Y EDWARDS', 1, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('2','009', 'BANCO INTERNACIONAL', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('3','011', 'DRESDNER BANK LATINOAMERICA', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('4','012', 'ESTADO', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('5','014', 'SCOTIABANK', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('6','016', 'BANCO DE CREDITOS E INVERSIONES ', 1, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('7','017', 'BANCO DO BRASIL S.A.', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('8','027', 'CORP BANCA', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('9','028', 'BANCO BICE', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('10','029', 'BANCO DE A. EDWARDS', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('11','031', 'HSBC BANK CHILE', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('12','032', 'BANK OF AMERICA, NATIONAL ASSOCIATION', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('13','033', 'BANCO CITIBANK N.A.', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('14','036', 'BANCO DO ESTADO DE SAO PAULO', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('15','037', 'BANCO SANTANDER', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('16','039', 'BANCO ITAU', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('17','040', 'BANCO SUDAMERIS', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('18','041', 'JP MORGAN CHASE BANK', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('19','043', 'BANCO DE LA NACION ARGENTINA', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('20','045', 'THE BANK OF TOKYO- MITSUBISHI UFJ, LTD.', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('21','046', 'ABN AMRO BANK (CHILE)', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('22','049', 'BANCO SECURITY', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('23','051', 'BANCO FALABELLA', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('24','052', 'DEUTSCHE BANK (CHILE)', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('25','053', 'BANCO RIPLEY', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('26','054', 'HNS BANCO', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('27','055', 'BANCO MONEX', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('28','056', 'BANCO PENTA', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('29','057', 'BANCO PARIS', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('30','504', '(BBVA) BANCO BILBAO VIZCAYA ARGENTARIA, CHILE', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('31','507', 'BANCO DEL DESARROLLO', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('32','671', 'COOCRETAL', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('33','672', 'COOPEUCH', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('34','734', 'BANCO CONOSUR', 0, '1990-01-01', '1990-01-01', '1', '1');
INSERT INTO Bancos  VALUES ('35','800', 'SANTANDER-STGO', 0, '1990-01-01', '1990-01-01', '1', '1');

-- *********************************************************************************
-- tablas Maestras
-- *********************************************************************************
-- Empresa
-- Representa las Sociedades
/*
se divide la informacion antes contenida en configuraciones del b1 en dos tablas, 
la de datos propiamente dichos de la empresa y la de los parametros que 
configuran el compotamiento de la empresa
*/
create table if not exists `Sociedad` (
	`id` bigint auto_increment not null,
	`rut` varchar(100) not null,	
	`nombre` varchar(200) not null,	
	`direccion` text not null,
	`region_id`  bigint	not null , -- referencua a Regiones	 Listo
	`comuna_id`  bigint	not null , -- referencua a Comunas Listo
	`ciudad` varchar(250) not null,    
	`created` datetime NOT NULL comment 'fecha en que fue creado el registro',    
	`updated`  datetime NOT NULL  comment 'fecha en que fue actualizado el registro',   
    `creator_user` BIGINT NOT NULL  comment 'usuario que creó el parametro',     
    `updater_user` BIGINT NOT NULL  comment 'usuario que actualizó el parametro',      
    primary key (`id`),
    constraint `FK_Regiones_Empresa` foreign key (`region_id`) references `Regiones` (`id`) 
    on  update cascade on delete restrict,
    constraint `FK_Comunas_Empresa` foreign key (`comuna_id`) references `Comunas` (`id`) 
    on  update cascade on delete restrict
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlarla los datos de la empresa (sociedades)';

insert into `Sociedad` values ('1','RutDemo','Demo','Direccion Demo','1','1101','Demo Ciudad','1990-01-01','1990-01-01','1','1');

-- Roles
CREATE TABLE IF NOT EXISTS `Roles` (
    `id` BIGINT AUTO_INCREMENT NOT NULL,
    `sociedad_id` BIGINT NULL,    
    `descripcion` varchar(250) not NULL, 
    `estado` boolean not NULL, 
	`created` datetime NOT NULL,    
	`updated`  datetime NOT NULL,   
    `creator_user` BIGINT NOT NULL,     
    `updater_user` BIGINT NOT NULL,       
    PRIMARY KEY (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla los roles dentro del sistema';

insert into `Roles` values ('1','1','root','1','1990-01-01','1990-01-01','1','1');
insert into `Roles` values ('2','1','administrador','1','1990-01-01','1990-01-01','1','1');
insert into `Roles` values ('3','1','RRHH Consultor','1','1990-01-01','1990-01-01','1','1');

-- CuentasContables
CREATE TABLE `CuentasContables` (
	`id` bigint  NOT NULL,
	`acct_code` varchar(20)  NOT NULL,
	`sociedad_id` bigint  NOT NULL,
	`acct_name` varchar(100) NOT NULL,
	`finance` char(1) NOT NULL,
	 PRIMARY KEY (`acct_code`),
     unique (`acct_code`),
     constraint `FK_Sociedad_CuentasContables` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
     on update cascade on delete restrict
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlar las cuentas contables';


-- FormasPago
create table if not exists `FormasPago` (
	`id` bigint auto_increment not null,
	`sociedad_id` bigint  NOT NULL,    
	`descripcion` varchar(50) not null,    
    primary key (`id`),
     constraint `FK_Sociedad_FormasPago` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
     on update cascade on delete restrict    
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlar las  diferentes fprmas de pago';

-- ---------------------------------------------------------------------------------
-- Parametrizaciones
-- ---------------------------------------------------------------------------------
-- TiposParametros
create table if not exists `TiposParametros` (
	`id` bigint auto_increment not null,
	`sociedad_id` bigint  NOT NULL,      
	`descripcion` varchar(150) not null,    
	`estado` boolean not null comment '0 Inactivo 1 Activo',      
    primary key (`id`),
     constraint `FK_Sociedad_TiposParametros` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
     on update cascade on delete restrict     
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlar los tipos parametros ';

-- centralizaciones
create table if not exists `Centralizaciones` (
	`id` bigint auto_increment not null,
	`sociedad_id` bigint  NOT NULL,      
	`usa_centros_costos` boolean not null,
	`cuenta_anticipo` varchar(50) null,
	`cuenta_bonos_feriado` varchar(50) null,    
	`cuenta_honoraios` varchar(50) null,
	`cuenta_prestamos_solidarios` varchar(50) null,
	`prestamo_solidario_imponible` boolean not null,    
    primary key (`id`),
     constraint `FK_Sociedad_Centralizaciones` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
     on update cascade on delete restrict     
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlarlas centralizaciones';

-- hay una tabla DetallesCentralizacion
-- ParametrosBasicos
-- esto corrresponde a los elementos que conformarán los calculos
CREATE TABLE IF NOT EXISTS `ParametrosBasicos` (
    `id` BIGINT AUTO_INCREMENT NOT NULL,
    `codigo` varchar(5) NOT NULL comment 'este codigo se utilizará como abreviatura en los cálculos de las formulas',  
	`sociedad_id` bigint  NOT NULL,        
    `concepto` varchar(250) NOT NULL,
    `tipo_parametro_id` bigint NOT NULL,
    `valor` numeric(18,4) NOT NULL,	
    `estado` boolean NOT NULL comment 'especifica si el parametro esta activo o no para el cálculo - 0 Inactivo 1 Activo',	
	`created` datetime NOT NULL comment 'fecha en que fue creado el parametro',    
	`updated`  datetime NOT NULL  comment 'fecha en que fue actualizado el parametro',   
    `creator_user` BIGINT NOT NULL  comment 'usuario que creó el parametro',     
    `updater_user` BIGINT NOT NULL  comment 'usuario que actualizó el parametro',     
    PRIMARY KEY (`id`),
    unique (`codigo`),
     constraint `FK_Sociedad_ParametrosBasicos` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
     on update cascade on delete restrict      
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla que permite controlar los parametros basicos de cálculo de remuneraciones';



-- HistoricoParametrosBasicos
CREATE TABLE IF NOT EXISTS `HistoricoParametrosBasicos` (
    `id` BIGINT NOT NULL,
    `codigo` varchar(5) NOT NULL comment 'este codigo se utilizará como abreviatura en los cálculos de las formulas',    
    `concepto` varchar(250) NOT NULL,
    `tipo_parametro_id` bigint NOT NULL,
    `valor` numeric(18,4) NOT NULL,	
    `estado` boolean NOT NULL comment 'especifica si el parametro esta activo o no para el cálculo - 0 Inactivo 1 Activo',	
	`created` datetime NOT NULL comment 'fecha en que fue creado el parametro',    
	`updated`  datetime NOT NULL  comment 'fecha en que fue actualizado el parametro',   
    `creator_user` BIGINT NOT NULL  comment 'usuario que creó el parametro',     
    `updater_user` BIGINT NOT NULL  comment 'usuario que actualizó el parametro'
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla que permite controlar los parametros basicos de cálculo de remuneraciones';


-- Formulas
CREATE TABLE IF NOT EXISTS `Formulas` (
	`id` BIGINT AUTO_INCREMENT NOT NULL,
	`sociedad_id` bigint  NOT NULL,     
	`nombre` varchar(250) NOT NULL,
	`expresion` text NOT NULL comment 'contentivo de la formua asociada al cálculo, esta fórmula contiene los codigos de los ParametrosBasicos ejemplo  ((p1*10)/b2)',
	`estado` boolean NOT NULL comment 'especifica si la formula esta activa o no para el cálculo - 0 Inactivo 1 Activo',	    
	`created` datetime NOT NULL comment 'fecha en que fue creado el parametro',    
	`updated`  datetime NOT NULL  comment 'fecha en que fue actualizado el parametro',   
	`creator_user` BIGINT NOT NULL  comment 'usuario que creó el parametro',     
	`updater_user` BIGINT NOT NULL  comment 'usuario que actualizó el parametro',   	
	PRIMARY KEY (`id`),
	constraint `FK_Sociedad_Formulas` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
	on update cascade on delete restrict      
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla que permite controlar las fórmulas';


-- HistoricoFormulas
CREATE TABLE IF NOT EXISTS `HistoricoFormulas` (
    `id` BIGINT AUTO_INCREMENT NOT NULL,
    `nombre` varchar(250) NOT NULL,
    `expresion` text NOT NULL comment 'contentivo de la formua asociada al cálculo, esta fórmula contiene los codigos de los ParametrosBasicos ejemplo  ((p1*10)/b2)',
	`estado` boolean NOT NULL comment 'especifica si la formula esta activa o no para el cálculo - 0 Inactivo 1 Activo',	    
	`created` datetime NOT NULL comment 'fecha en que fue creado el parametro',    
	`updated`  datetime NOT NULL  comment 'fecha en que fue actualizado el parametro',   
    `creator_user` BIGINT NOT NULL  comment 'usuario que creó el parametro',     
    `updater_user` BIGINT NOT NULL  comment 'usuario que actualizó el parametro',
	`fecharegistro` datetime NOT NULL,
    primary key (`id`,`fecharegistro`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla que permite controlar las fórmulas';

-- Categorias para los parametros de configuracion

CREATE TABLE `CategoriasConfiguracion` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`sociedad_id` bigint NOT NULL,    
	`nombre` varchar(200) NOT NULL ,
	`activo` boolean NULL,    
	`created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
	`updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
	`creator_user` bigint NOT NULL COMMENT 'usuario que creó el parametro',
	`updater_user` bigint NOT NULL COMMENT 'usuario que actualizó el parametro',
	PRIMARY KEY (`id`),
    constraint `FK_Sociedad_CategoriasConfiguracion` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
		on update cascade on delete restrict
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tabla para las configuraciones de las categorias';


insert into `CategoriasConfiguracion` values ('1','1','CONFIGURACIONES BASICAS','1','2024-02-13 10:00','2024-02-13 10:00','1','1');
insert into `CategoriasConfiguracion` values ('2','1','CONFIGURACIONES DE CENTRALIZACIÓN','1','2024-02-13 10:00','2024-02-13 10:00','1','1');
insert into `CategoriasConfiguracion` values ('3','1','CONFIGURACIÓN DE DATOS DE LA EMPRESA','1','2024-02-13 10:00','2024-02-13 10:00','1','1');
insert into `CategoriasConfiguracion` values ('4','1','CONFIGURACIÓN GENERAL B1 NÓMINA','1','2024-02-13 10:00','2024-02-13 10:00','1','1');
insert into `CategoriasConfiguracion` values ('5','1','CONFIGURACIÓN CAMPOS ADICIONALES DEL EMPLEADO','1','2024-02-13 10:00','2024-02-13 10:00','1','1');
insert into `CategoriasConfiguracion` values ('6','1','CONFIGURACIÓN CAMPOS ADICIONALES REGISTRO DE ASISTENCIA','1','2024-02-13 10:00','2024-02-13 10:00','1','1');
insert into `CategoriasConfiguracion` values ('7','1','PARÁMETROS DE CONEXIÓN','1','2024-02-13 10:00','2024-02-13 10:00','1','1');


CREATE TABLE `HistoricoCategoriasConfiguracion` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`categoria_id` bigint NOT NULL ,
	`sociedad_id` bigint NOT NULL,     
	`nombre` varchar(200) NOT NULL ,
	`activo` boolean NULL,     
	`created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
	`updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
	`creator_user` bigint NOT NULL COMMENT 'usuario que creó el parametro',
	`updater_user` bigint NOT NULL COMMENT 'usuario que actualizó el parametro',
	`fecha_registro` datetime NOT NULL,
	`observaciones` text DEFAULT NULL,    
	PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tabla para los historicos de las configuraciones de las categorias';


-- Configuraciones Esta tabla maneja los aspectos básicoa de la identificacion de la empresa
CREATE TABLE `Configuraciones` (
	`id` bigint auto_increment not null,
	`sociedad_id` bigint not null, -- relacionado con la tabla sociedad   
	`categoria_id` bigint NULL, -- relacionado con la tabla categoriasconfiguracion       
	`nombre` varchar(150) NOT NULL,
	`valor` numeric(18,4) NOT NULL,
	`detalle` text  NULL,
	`cuenta` varchar(20)  NULL,
	`ocultar` integer DEFAULT 0 NOT NULL,
	`tipo_validacion` varchar(30)  NULL,
	`orden` int NULL,
	`created` datetime NOT NULL comment 'fecha en que fue creado el registro',    
	`updated`  datetime NOT NULL  comment 'fecha en que fue actualizado el registro',   
    `creator_user` BIGINT NOT NULL  comment 'usuario que creó el parametro',     
    `updater_user` BIGINT NOT NULL  comment 'usuario que actualizó el parametro', 
	primary key (`id`),
    constraint `FK_Sociedad_Configuraciones` foreign key (`sociedad_id`) references `Sociedad` (`id`)  
    on update cascade on delete restrict,
	constraint `FK_CategoriasConfiguracion_Configuraciones` foreign key (`categoria_id`) references `CategoriasConfiguracion` (`id`)  
    on update cascade on delete restrict
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlar las configuraciones de las sociedades';


insert into b1.Configuraciones values ('1','1','1','Sueldo Minimo ($)','445000.0000','','','0','Numérico','1','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('2','1','1','Seg. invalidez y sobrevivencia (%)','0.0000','','','1','Decimal','2','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('3','1','3','Mutual (%)','0.9300','','','0','Decimal','3','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('4','1','1','Gratificación ingreso minimo (%)','25.0000','','','0','Decimal','4','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('5','1','1','Tope Gratificacion (UF)','4.7500','','','0','Decimal','5','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('6','1','1','% Utilidad liquido anual','0.0000','','','1','Decimal','6','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('7','1','1','$ Utilidad a Repartir','0.0000','','','1','Decimal','7','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('8','1','1','Seguro AFC Empresa (%)','2.4000','','','0','Decimal','8','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('9','1','1','Seguro AFC Empleado (%)','0.6000','','','0','Decimal','9','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('10','1','1','AFC Cont. PlazoFijo (%)','3.0000','','','0','Decimal','10','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('13','1','1','Tope Imposiciones (UF)','81.6000','','','0','Decimal','11','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('14','1','1','Tope de salud (UF)','81.6100','','','0','Decimal','12','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('15','1','1','Tope Seguro AFC (UF)','122.6000','','','0','Decimal','13','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('16','1','1','Tope Ahorro previsional (UF)','50.0000','','','0','Decimal','14','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('18','1','1','Trabajo Pesado','0.8000','','','1','Decimal','15','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('19','1','1','Tope de remuneración finiquito (UF)','90.0000','','','0','Decimal','16','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('20','1','1','Dias de Vacaciones por año','15.0000','','','0','Decimal','17','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('21','1','1','% AFC 11 Años antiguedad','0.8000','','','0','Decimal','18','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('22','1','1','Horas diarias legales','0.0000','','','0','Decimal','19','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('23','1','1','Porcentaje Ley SANA','0.0300','','','0','Decimal','20','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('24','1','1','% Retención de honorarios','10.7500','','','0','Decimal','21','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('25','1','1','Caja de Compensación (%)','6.0000','','','0','Decimal','19','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('104','1','2','Centralización por centro de costo','0.0000','NO','','0','SelectorBool','1','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('105','1','2','Pagar gratificaciones sobre el sueldo base, sin otros imponibles (Ej Bonos)','0.0000','NO','','1','SelectorBool','2','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('106','1','2','Cuenta anticipo (transferencias por pagar)','0.0000','','21020002','0','Cuenta','3','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('107','1','2','Cuenta bonos feriado','0.0000','','21020007','0','Cuenta','4','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('108','1','2','Cuenta de cargo Honorarios','0.0000','','','0','Cuenta','5','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('109','1','2','Cuenta Prestamos Solidarios','0.0000','','21040006','0','Cuenta','6','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('110','1','2','Prestamo solidario sobre el Imponible (SI) / Tributable (NO)','0.0000','SI','','0','SelectorBool','7','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('300','1','3','RUT Empresa','0.0000','77.191.352-0','','0','Alfanumérico-15','1','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('301','1','3','Nombre Empresa','0.0000','B1NTesting','','0','Alfanumérico-500','2','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('302','1','3','N° Mutual Empresa','0.0000','7','','0','Detallada','3','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('303','1','3','N° Caja Compensación','0.0000','2','','0','Detallada','4','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('304','1','3','Dirección Empresa','0.0000','JAIME GUZMAN ERRAZURIZ #3220','','0','Alfanumérico-500','5','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('305','1','3','Responsable Empresa','0.0000','Responsable Empresa Testing','','0','Alfanumérico-500','6','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('306','1','3','Rut responsable empresa','0.0000','12951047-1','','0','Alfanumérico-15','7','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('307','1','3','Responsable remuneraciones','0.0000','Maria Rincon','','0','Alfanumérico-500','8','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('308','1','3','Codigo convenio Banco Chile','0.0000','003','','0','Alfanumérico-500','9','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('309','1','3','Giro Empresa','0.0000','Call Center','','0','Alfanumérico-500','10','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('310','1','3','Ciudad Empresa','0.0000','Santiago','','0','Alfanumérico-500','11','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('311','1','3','Razón Social Empresa','0.0000','Razón Social','','0','Alfanumérico-500','10','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('316','1','3','Aplicar descuento por atrasos','0.0000','SI','','0','SelectorBool','12','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('317','1','3','Minutos de holgura para descuento por atrasos','15.0000','','','0','Numérico','13','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('318','1','4','Servidor de correo','0.0000','smtp.gmail.com','','0','Alfanumérico-500','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('319','1','4','Los correos se enviarán desde','0.0000','','','0','Alfanumérico-500','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('320','1','4','contraseña del correo','0.0000','','','0','Detallada','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('321','1','4','Puertos de correo','587.0000','','','0','Numérico','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('322','1','4','habilitar SSL (envio de Correos)','0.0000','SI','','0','SelectorBool','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('323','1','3','Nomina del Banco','0.0000','016','','0','Detallada','14','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('324','1','3','Ocultar email destinatario y mensaje destinatario en nomina de transferencia BCI ','0.0000','SI','','0','SelectorBool','16','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('325','1','4','Ruta física content','0.0000','/Content/','','0','Alfanumérico-500','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('326','1','3','Número cuenta bancaria de cargo','0.0000','29992150','','0','Alfanumérico-500','15','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('327','1','3','Región Empresa','0.0000','13','','0','Detallada','5','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('328','1','4','Ruta física layout vaucher vacaciones','0.0000','/Content/Reportes/basehtml/LayoutFeriado_V2.html','','0','Alfanumérico-500','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('329','1','4','Ruta física layout correo de autorización de cuentas bancarias','0.0000','/Content/Reportes/basehtml/CorreoAutorizacionCuenta.html','','0','Alfanumérico-500','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('330','1','4','Ruta web del aplicativo','0.0000','http://192.168.10.13/ccapolo/','','0','Alfanumérico-500','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('331','1','4','Nombre sociedad actual','0.0000','B1NTesting','','0','Alfanumérico-200','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('332','1','4','Ruta física layout base liquidación sueldo','0.0000','/Content/Reportes/basehtml/LiquidacionesBase.html','','0','Alfanumérico-500','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('333','1','4','Ruta física layout formulario 1887 persona','0.0000','/Content/Reportes/basehtml/F1887_Personas.html','','0','Alfanumérico-500','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('334','1','4','Ruta física layout  carta de aceptación del prestamo','0.0000','/Content/Reportes/basehtml/AceptacionPrestamo.html','','0','Alfanumérico-500','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('335','1','4','Ruta física temporal para generar documentos comprimidos','0.0000','/Content/Reportes/Comprimidos','','0','Alfanumérico-500','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('336','1','4','Ruta física de documentos cargados del empleado','0.0000','/DocumentosUsr/','','0','Alfanumérico-500','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('337','1','4','Ruta física layout Impuesto Único','0.0000','/Content/Reportes/basehtml/ImpuestoUnico.html','','0','Alfanumérico-500','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('338','1','3','Comuna de la Empresa','0.0000','13123','','0','Detallada','5','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('601','1','5','Campo 1','1.0000','Campañas','','0','Detallada','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('602','1','5','Campo 2','0.0000','Nombre Campo 2','','0','Detallada','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('603','1','5','Campo 3','0.0000','Nombre Campo 3','','0','Detallada','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('604','1','5','Campo 4','0.0000','Nombre Campo 4','','0','Detallada','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('605','1','5','Campo 5','0.0000','Nombre Campo 5','','0','Detallada','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('801','1','6','Campo 1','1.0000','Campaña 1','','0','Detallada','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('802','1','6','Campo 2','0.0000','Campaña 2','','0','Detallada','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('803','1','6','Campo 3','0.0000','Nombre Campo 3','','0','Detallada','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('804','1','6','Campo 4','0.0000','Nombre Campo 4','','0','Detallada','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('805','1','6','Campo 5','0.0000','Nombre Campo 5','','0','Detallada','0','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('1000','1','7','Servidor SAP','0.0000','SAP-MALLECO\SAPMALLECO','','0','Alfanumérico-500','1','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('1001','1','7','Tipo de Servidor','0.0000','SQL','','0','Detallada','2','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('1002','1','7','Versión del Servidor','0.0000','2019','','0','Detallada','3','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('1003','1','7','Nombre de base de datos SAP','0.0000','TEST_2CALL','','0','Alfanumérico-500','4','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('1004','1','7','Usuario Servidor','0.0000','sa','','0','Alfanumérico-500','6','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('1005','1','7','Contraseña Servidor','0.0000','j3CguW4liC8sPpfxApWA1Q==','','0','Detallada','7','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('1006','1','7','Usuario SAP','0.0000','manager','','0','Alfanumérico-500','9','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');
insert into b1.Configuraciones values ('1007','1','7','Contraseña SAP','0.0000','QA8cUIHeEXI=','','0','Detallada','10','2024-02-19 10:00:00','2024-02-19 10:00:00','1','1');



-- HistoricoConfiguraciones
CREATE TABLE `HistoricoConfiguraciones` (
	`id` bigint auto_increment not null,
	`configuracion_id` bigint not null,  
	`sociedad_id` bigint not null, -- relacionado con la tabla sociedad   
	`categoria_id` bigint NULL, -- relacionado con la tabla categoriasconfiguracion  
    `configuraciones_id` bigint NULL, -- relacionado con la tabla categoriasconfiguracion  
	`nombre` varchar(150) NOT NULL,
	`valor` numeric(18,4) NOT NULL,
	`detalle` text  NULL,
	`cuenta` varchar(20)  NULL,
	`ocultar` bit DEFAULT 0 NOT NULL,
	`tipo_validacion` varchar(30)  NULL,
	`orden` int NULL,
	`created` datetime NOT NULL comment 'fecha en que fue creado el registro',    
	`updated`  datetime NOT NULL  comment 'fecha en que fue actualizado el registro',   
    `creator_user` BIGINT NOT NULL  comment 'usuario que creó el parametro',     
    `updater_user` BIGINT NOT NULL  comment 'usuario que actualizó el parametro',
	`fecha_registro` datetime NOT NULL,
	`observaciones` text DEFAULT NULL,    
    primary key (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlarla los datos historicos de las configuraciones de las empresas';



-- Cargos
CREATE TABLE `Cargos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
  `creator_user` bigint NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla para controlar los datos de los cargos';

INSERT INTO b1.Cargos VALUES(1, 'EJECUTIVO DE INFORMACION','2024-02-01 01:01','2024-02-01 01:01','1','1');
INSERT INTO b1.Cargos VALUES(2, 'TEAM LEADER','2024-02-01 01:01','2024-02-01 01:01','1','1');
INSERT INTO b1.Cargos VALUES(3, 'TO','2024-02-01 01:01','2024-02-01 01:01','1','1');
INSERT INTO b1.Cargos VALUES(4, 'Soporte','2024-02-01 01:01','2024-02-01 01:01','1','1');
INSERT INTO b1.Cargos VALUES(5, 'EJECUTIVA DE INFORMACION','2024-02-01 01:01','2024-02-01 01:01','1','1');
INSERT INTO b1.Cargos VALUES(6, 'MONITOR DE CALIDAD ','2024-02-01 01:01','2024-02-01 01:01','1','1');
INSERT INTO b1.Cargos VALUES(7, 'ANALISTA DE DESARROLLO JUNIOR ','2024-02-01 01:01','2024-02-01 01:01','1','1');
INSERT INTO b1.Cargos VALUES(8, 'SUB GERENTE DE OPERACIONES','2024-02-01 01:01','2024-02-01 01:01','1','1');
INSERT INTO b1.Cargos VALUES(9, 'SUPERVISOR DE PLATAFORMA ','2024-02-01 01:01','2024-02-01 01:01','1','1');

-- HistoricoCargos
CREATE TABLE `HistoricoCargos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cargo_id` bigint NOT NULL,  
  `nombre` varchar(200) NOT NULL, 
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint NOT NULL,
  `updater_user` bigint NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8 COMMENT='Tabla para controlar los datos historicos de los cargos';


-- se hace una division de los datos en relacion con la tabla original del B1 Nomina
-- se separan datos personales, direccion, contactom datos bancarios
-- se crea una tabla para hacewr la relacion Sociedad_Usuario
-- Usuario
CREATE TABLE IF NOT EXISTS `Usuario` (
    `id` BIGINT AUTO_INCREMENT NOT NULL,
    `rut` VARCHAR(100) NOT NULL,
    `rut_provisorio` VARCHAR(100) NULL,
    `nombres` VARCHAR(100) NOT NULL,
    `apellido_paterno` VARCHAR(100) NOT NULL,
    `apellido_materno` VARCHAR(100) NULL,
    `fecha_nacimiento` DATE NOT NULL,
    `sexo_id` BIGINT NOT NULL,
    `estado_civil_id` BIGINT NOT NULL,    
    `nacionalidad_id` BIGINT NOT NULL, 
    `username` varchar(250) NOT NULL,    
	`password` varchar(250) NOT NULL,  
	`activo` boolean NOT NULL comment 'campo para activar o no al usuario 0 Inactivo 1 Activo',           
	`created` datetime NOT NULL,    
	`updated`  datetime NOT NULL,   
    `creator_user` BIGINT NOT NULL,     
    `updater_user` BIGINT NOT NULL,      
    PRIMARY KEY (`id`),
    unique (`rut`),
    unique (`username`),
    constraint `FK_Nacionalidad_Usuario` foreign key (`nacionalidad_id`) references `Nacionalidad` (`id`) 
    on  update cascade on delete restrict,   
    constraint `FK_Sexo_Usuario` foreign key (`sexo_id`) references `Sexo` (`id`) 
    on  update cascade on delete restrict,    
    constraint `FK_EstadoCivil_Usuario` foreign key (`estado_civil_id`) references `EstadoCivil` (`id`) 
    on  update cascade on delete restrict
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla de  usuarios';

-- creamos el root del sistema
insert into `Usuario` values ('1','1','','Admin','Root','','1990-01-01','1','1','1','root','$2b$12$6JXJ6qmx9co08Nk5zTE.aeDIB8ohWUtAiLytiVHmBH9YuKJHCIkUm','1','1990-01-01','1990-01-01','1','1');

-- Contacto


CREATE TABLE IF NOT EXISTS `Contacto` (
    `id` BIGINT AUTO_INCREMENT NOT NULL,
    `user_id` BIGINT NULL,    
    `email` varchar(250) NULL,       
    `fijo` varchar(20) NULL,   
    `movil` varchar(20) NULL, 
	`created` datetime NOT NULL,    
	`updated`  datetime NOT NULL,   
    `creator_user` BIGINT NOT NULL,     
    `updater_user` BIGINT NOT NULL,      
    PRIMARY KEY (`id`),
    constraint `FK_Usuario_Contacto` foreign key (`user_id`) references `Usuario` (`id`) 
    on  update cascade on delete restrict
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla de contacto de los usuarios';

-- Ubicación
CREATE TABLE IF NOT EXISTS `Ubicacion` (
    `id` BIGINT AUTO_INCREMENT NOT NULL,
    `user_id` BIGINT NULL, 
    `region_id` BIGINT not NULL,    
    `comuna_id` BIGINT not NULL,    
    `direccion` text not NULL,   
	`created` datetime NOT NULL,    
	`updated`  datetime NOT NULL,   
    `creator_user` BIGINT NOT NULL,     
    `updater_user` BIGINT NOT NULL,     
    PRIMARY KEY (`id`),
    constraint `FK_Usuario_Ubicacion` foreign key (`user_id`) references `Usuario` (`id`) 
    on  update cascade on delete restrict,
    constraint `FK_Region_Ubicacion` foreign key (`region_id`) references `Regiones` (`id`) 
    on  update cascade on delete restrict ,
    constraint `FK_Comuna_Ubicacion` foreign key (`comuna_id`) references `Comunas` (`id`) 
    on  update cascade on delete restrict     
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla de ubicación de los usuarios';


-- archivos de usuario
-- Usados para mostrar en el profile del usuario como referencia
CREATE TABLE `FilesUsers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `url` text NOT NULL,  
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint NOT NULL,
  `updater_user` bigint NOT NULL,
  PRIMARY KEY (`id`),
  constraint `FK_Usuario_FilesUsers` foreign key (`user_id`) references `Usuario`(`id`)
  on update cascade on delete restrict
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de archivos de los usuarios';

-- fotos de usuario
-- Usados para mostrar en el profile del usuario como referencia
CREATE TABLE `PicUsers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `url` text NOT NULL,  
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint NOT NULL,
  `updater_user` bigint NOT NULL,
  PRIMARY KEY (`id`),
  unique (`user_id`),
  constraint `FK_Usuario_FilesUsers` foreign key (`user_id`) references `Usuario`(`id`)
  on update cascade on delete restrict
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de fotos de los usuarios';

-- SociedadUsuario
CREATE TABLE IF NOT EXISTS `SociedadUsuario` (
    `id` BIGINT AUTO_INCREMENT NOT NULL,
    `user_id` BIGINT NULL, 
    `sociedad_id` BIGINT not NULL,
	`created` datetime NOT NULL,    
	`updated`  datetime NOT NULL,   
    `creator_user` BIGINT NOT NULL,     
    `updater_user` BIGINT NOT NULL,     
    PRIMARY KEY (`id`),
    constraint `FK_Usuario_SociedadUsuario` foreign key (`user_id`) references `Usuario` (`id`) 
    on  update cascade on delete restrict,
    constraint `FK_Sociedad_SociedadUsuario` foreign key (`sociedad_id`) references `SociedadUsuario` (`id`) 
    on  update cascade on delete restrict
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla de Asociación de los usuarios con las sociedades del cliente';


-- FormaPagoUsuario
CREATE TABLE IF NOT EXISTS `FormasPagoUsuario` (
    `id` BIGINT AUTO_INCREMENT NOT NULL,
    `user_id` BIGINT NULL, 
	`forma_pago_id` BIGINT NULL,  
	`created` datetime NOT NULL,    
	`updated`  datetime NOT NULL,   
    `creator_user` BIGINT NOT NULL,     
    `updater_user` BIGINT NOT NULL,     
    PRIMARY KEY (`id`),
    constraint `FK_Usuario_FormaPagoUsuario` foreign key (`user_id`) references `Usuario` (`id`) 
    on  update cascade on delete restrict,
    constraint `FK_FormaPago_FormaPagoUsuario` foreign key (`forma_pago_id`) references `FormasPago` (`id`) 
    on  update cascade on delete restrict    
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla de asigancion de formas de pagos del usuario';


-- BancariosUser
CREATE TABLE IF NOT EXISTS `BancariosUser` (
    `id` BIGINT AUTO_INCREMENT NOT NULL,
    `user_id` BIGINT NULL, 
    `banco_id` BIGINT not NULL, 
	`numero_cuenta` varchar(100) not NULL,
	`en_uso` boolean not NULL,    
	`terceros` boolean not NULL,        
	`rut_tercero` varchar(100) NULL,     
	`nombre_tercero` varchar(100) NULL,         
	`email_tercero` varchar(250) NULL,             
	`created` datetime NOT NULL,    
	`updated`  datetime NOT NULL,   
    `creator_user` BIGINT NOT NULL,     
    `updater_user` BIGINT NOT NULL,       
    PRIMARY KEY (`id`),
    constraint `FK_Usuario_BancariosUsuario` foreign key (`user_id`) references `Usuario` (`id`) 
    on  update cascade on delete restrict,
    constraint `FK_Bancos_BancariosUsuario` foreign key (`banco_id`) references `Bancos` (`id`) 
    on  update cascade on delete restrict
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla de datos bancarios de pagos del usuario';


-- historico de bancarios de uuario
CREATE TABLE `HistoricoBancariosUser` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bancario_id` bigint NOT NULL,  
  `user_id` bigint DEFAULT NULL,
  `banco_id` bigint NOT NULL,
  `numero_cuenta` varchar(100) NOT NULL,
  `en_uso` tinyint(1) NOT NULL,
  `terceros` tinyint(1) NOT NULL,
  `rut_tercero` varchar(100) DEFAULT NULL,
  `nombre_tercero` varchar(100) DEFAULT NULL,
  `email_tercero` varchar(250) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint NOT NULL,
  `updater_user` bigint NOT NULL,
  `fecha_registro` datetime NOT NULL,  
  `observaciones` text NULL,    
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de historico datos bancarios de pagos del usuario';

-- datos laborales
CREATE TABLE `DatosLaborales` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`sociedad_id` bigint not null,
	`sede_id` bigint not null,
	`departamento_id` bigint not null,    
	`grupo_id` bigint not null,
	`cargo_id` bigint not null,    
	`user_id` bigint NOT NULL,
	`tipo_contrato` int NOT NULL,  
	`termino_contrato` int NOT NULL,
	`fecha_inicio` date NOT NULL,
	`fecha_fin` date NULL, 
	`periodo_salario` int not null comment 'Representa cual es el periodo en dias de calculo de nomina 1 Quincenal 2 Mensual',  
	`salario_base` numeric(18,4) not null, 
	`modalidad` int not null comment 'Representa 0 Presencial 1 Teletrabajo',   
	`dias_descanso` varchar(50) not null comment 'Es un texto de la siguiente manera 1,2,3,4,5,6,7',    
	`created` datetime NOT NULL,
	`updated` datetime NOT NULL,
	`creator_user` bigint(20) NOT NULL,
	`updater_user` bigint(20) NOT NULL,    
	primary key(`id`),
    constraint `FK_Sociedad_DatosLaborales` foreign key (`sociedad_id`) references `Sociedad` (`id`)
    on update cascade on delete restrict,
    constraint `FK_Sede_DatosLaborales` foreign key (`sede_id`) references `Sede` (`id`)
    on update cascade on delete restrict,
    constraint `FK_Departamento_DatosLaborales` foreign key (`departamento_id`) references `Departamentos` (`id`)
    on update cascade on delete restrict,    
    constraint `FK_Grupo_DatosLaborales` foreign key (`grupo_id`) references `GruposEmpleado` (`id`)
    on update cascade on delete restrict,    
    constraint `FK_Cargo_DatosLaborales` foreign key (`cargo_id`) references `Cargos` (`id`)
    on update cascade on delete restrict,    
    constraint `FK_Usuario_DatosLaborales` foreign key (`user_id`) references `Usuario` (`id`)
    on update cascade on delete restrict        
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de datos  laborales del usuario';


CREATE TABLE `HistoricoDatosLaborales` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`datos_laborales_id` bigint not null,
	`sociedad_id` bigint not null,    
	`sede_id` bigint not null,
	`departamento_id` bigint not null,      
	`grupo_id` bigint not null,
	`cargo_id` bigint not null,    
	`user_id` bigint NOT NULL,
	`tipo_contrato` int NOT NULL,  
	`termino_contrato` int NOT NULL,
	`fecha_inicio` date NOT NULL,
	`fecha_fin` date NULL, 
	`periodo_salario` int not null comment 'Representa cual es el periodo en dias de calculo de nomina 1 Quincenal 2 Mensual',  
	`salario_base` numeric(18,4) not null, 
	`modalidad` int not null comment 'Representa 0 Presencial 1 Teletrabajo',   
	`dias_descanso` varchar(50) not null comment 'Es un texto de la siguiente manera 1,2,3,4,5,6,7',  
	`created` datetime NOT NULL,
	`updated` datetime NOT NULL,
	`creator_user` bigint(20) NOT NULL,
	`updater_user` bigint(20) NOT NULL,    
	`fecha_registro` datetime NOT NULL,
    `observaciones` text NOT NULL,
	primary key(`id`)      
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de Historico de datos  laborales del usuario';

-- -----------------------------------------------
-- datos de pago
CREATE TABLE `DatosPago` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`user_id` bigint NOT NULL,
	`medio` int NOT NULL comment '1 Transfernecia, 2 Cheque, 3 contado',
	`banco_id` bigint NULL,    
	`tipo_cuenta` int NULL comment '1 Corriente 2 Ahorro',    
	`created` datetime NOT NULL,
	`updated` datetime NOT NULL,
	`creator_user` bigint(20) NOT NULL,
	`updater_user` bigint(20) NOT NULL, 
	primary key(`id`),    
    constraint `FK_Usuario_DatosPago` foreign key (`user_id`) references `Usuario` (`id`)
    on update cascade on delete restrict        
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de datos  de pago  del usuario';

-- historico de datos de pago
CREATE TABLE `HistoricoDatosPago` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`datos_pago_id` bigint NOT NULL,    
	`user_id` bigint NOT NULL,
	`medio` int NOT NULL comment '1 Transferencia, 2 Cheque, 3 Contado',
	`banco_id` bigint NULL,    
	`tipo_cuenta` int NULL comment '1 Corriente 2 Ahorro',    
	`created` datetime NOT NULL,
	`updated` datetime NOT NULL,
	`creator_user` bigint(20) NOT NULL,
	`updater_user` bigint(20) NOT NULL, 
	`fecha_registro` datetime NOT NULL,
    `observaciones` text NOT NULL,    
	primary key(`id`)     
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de Historico de datos  de pago  del usuario';





CREATE TABLE `Periodos` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`anio` integer NOT NULL ,
	`mes` integer NOT NULL ,  
	`nombre` varchar(200) NOT NULL ,
	`observaciones` text NULL ,  
	`activo` boolean NULL,    
	`utm` numeric(18,4) default NULL,  
	`uf` numeric(18,4) default NULL,    
	`factor_actualizacion` numeric(18,4) default NULL,    
	`created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
	`updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
	`creator_user` bigint NOT NULL COMMENT 'usuario que creó el parametro',
	`updater_user` bigint NOT NULL COMMENT 'usuario que actualizó el parametro',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tabla para los periodos';


insert into `Periodos`values ('1','2020','1','Enero-2020','','0','0','0','1026','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('2','2020','2','Febrero-2020','','0','0','0','1021','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('3','2020','3','Marzo-2020','','0','0','0','1016','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('4','2020','4','Abril-2020','','0','0','0','1013','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('5','2020','5','Mayo-2020','','0','0','0','1013','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('6','2020','6','Junio-2020','','0','0','0','1014','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('7','2020','7','Julio-2020','','1','50322','28667.440','1014','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('8','2020','8','Agosto-2020','','1','47729.000','28679.450','1013','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('9','2020','9','Septiembre-2020','','1','50322.000','28707.850','1012','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('10','2020','10','Octubre-2020','','1','50372.000','28838.630','1005','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('11','2020','11','Noviembre-2020','','1','50674.000','29030.170','1','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('12','2020','12','Diciembre-2020','','1','51029.000','29070.330','1','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('13','2021','1','Enero-2021','','1','50978.000','29123740','1012.000','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('14','2021','2','Febrero-2021','','1','51131.000','29287380','1010.000','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('15','2021','3','Marzo-2021','','1','51489.000','29394770','1006.000','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('16','2021','4','Abril-2021','','1','51592.000','29494130','1003.000','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('17','2021','5','Mayo-2021','','1','51798.000','29613260','1000.000','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('18','2021','6','Junio-2021','','1','52005.000','29709.830','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('19','2021','7','Julio-2021','','1','52161.000','29757.640','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('20','2021','8','Agosto-2021','','1','52213.000','29935.080','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('21','2021','9','Septiembre-2021','','1','52631.000','30088.370','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('22','2021','10','Octubre-2021','','1','52842.000','30380.530','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('23','2021','11','Noviembre-2021','','1','53476.000','30762.800','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('24','2021','12','Diciembre-2021','','1','54171.000','30991.740','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('25','2022','1','Enero-2022','','1','54442.000','31212.650','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('26','2022','2','Febrero-2022','','1','54878.000','31539.200','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('27','2022','3','Marzo-2022','','1','55537.000','31727.740','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('28','2022','4','Abril-2022','','1','55704.000','32176.490','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('29','2022','5','Mayo-2022','','1','56762.000','32679.540','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('30','2022','6','Junio-2022','','1','57557.000','33086.830','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('31','2022','7','Julio-2022','','1','58248.000','33417.260','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('32','2022','8','Agosto-2022','','1','58772.000','33836.510','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('33','2022','9','Septiembre-2022','','1','59595.000','34258.230','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('34','2022','10','Octubre-2022','','1','60310.000','34600.350','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('35','2022','11','Noviembre-2022','','1','60853.000','34811.800','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('36','2022','12','Diciembre-2022','','1','61157.000','35110.980','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('37','2023','1','Enero-2023','','1','61954.000','35287.500','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('38','2023','2','Febrero-2023','','1','61954.000','35509.680','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('39','2023','3','Marzo-2023','','1','61954.000','35509.680','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('40','2023','4','Abril-2023','','1','62388.000','35838.550','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('41','2023','5','Mayo-2023','','1','63074.000','36032.890','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('42','2023','6','Junio-2023','','1','63263.000','36089.480','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('43','2023','7','Julio-2023','','1','61954.000','36022.440','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('44','2023','8','Agosto-2023','','1','61954.000','36022.440','2.800','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('45','2023','9','Septiembre-2023','','1','61954.000','36022.440','222.000','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('46','2023','10','Octubre-2023','','1','61954.000','36022.440','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('47','2023','11','Noviembre-2023','','0','0','0','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');
insert into `Periodos`values ('48','2023','12','Diciembre-2023','','0','0','0','0','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1');


CREATE TABLE `HistoricoPeriodos` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`periodos_id` bigint NOT NULL ,    
	`anio` integer NOT NULL ,
	`mes` integer NOT NULL ,  
	`nombre` varchar(200) NOT NULL ,
	`observaciones` text NULL ,  
	`activo` boolean NULL,    
	`utm` numeric(18,4) default NULL,  
	`uf` numeric(18,4) default NULL,    
	`factor_actualizacion` numeric(18,4) default NULL,    
	`created` datetime NOT NULL COMMENT 'fecha en que fue creado el parametro',
	`updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el parametro',
	`creator_user` bigint NOT NULL COMMENT 'usuario que creó el parametro',
	`updater_user` bigint NOT NULL COMMENT 'usuario que actualizó el parametro',
	`fecha_registro` datetime NOT NULL,
	`observaciones_update` text DEFAULT NULL,    
	PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Tabla para los Hisotorico Periodos';

insert into `HistoricoPeriodos`values ('1','1','2020','1','Enero-2020','','0','0','0','1026','2024-02-01 01:00:00','2024-02-01 01:00:00','1','1','2024-02-12 20:00','Prueba Historico');


-- CentrosDeCostos 
 CREATE TABLE `CentrosDeCostos` (
	`id` bigint auto_increment NOT NULL,
	`sociedad_id` bigint  NOT NULL,    
	`codigo_sap` varchar(50)  NULL,
	`centro_costo` varchar(200)  NULL,
	`dimension_id` int NULL, -- este campo esta relacionado con la tabla dimensiones, sin embargo puede ser null
	 PRIMARY KEY (`id`),
    constraint `FK_Sociedad_CentrosDeCostos` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
    on  update cascade on delete restrict     
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla de Centros de costos, basicamente usado para conectarse a los ERP';



-- TiposPrestamos 
CREATE TABLE `TiposPrestamos` (
	`id` bigint auto_increment NOT NULL,
	`sociedad_id` bigint  NOT NULL,     
	`descripcion` varchar(150)  NOT NULL,
	`cuenta` varchar(30)  NULL,
	`CCAF` boolean DEFAULT 0 NOT NULL,
	`caja_compensacion_id` bigint NULL,-- esta columna se relaciona con las cajas de compensacion si y solo si la cuenta es CCAF
	`created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
	`updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
	`creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
	`updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
	PRIMARY KEY (`id`),
    constraint `FK_Sociedad_TiposPrestamos` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
    on  update cascade on delete restrict         
) ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla de tipos de prestamos';

/*
IdTipoPrestamo int IDENTITY(1,1) NOT NULL,
TipoPrestamo nvarchar(150) COLLATE Modern_Spanish_CI_AS NOT NULL,
Cuenta nvarchar(30) COLLATE Modern_Spanish_CI_AS NULL,
EsDeCCAF bit DEFAULT 0 NOT NULL,
IdCajaCompensacion int NULL,
*/

insert into `TiposPrestamos` values ('1','1','Empresa','11080003','0',null,'2024-02-21 10:00','2024-02-21 10:00','1','1');
insert into `TiposPrestamos` values ('2','1','CCAF','21050003','1',null,'2024-02-21 10:00','2024-02-21 10:00','1','1');


-- Historico TiposPrestamos 
CREATE TABLE `HistoricoTiposPrestamos` (
	`id` bigint auto_increment NOT NULL,
	`tipo_prestamo_id` bigint NOT NULL,    
	`sociedad_id` bigint  NOT NULL,     
	`descripcion` varchar(150)  NOT NULL,
	`cuenta` varchar(30)  NULL,
	`CCAF` boolean DEFAULT 0 NOT NULL,
	`caja_compensacion_id` bigint NULL,-- esta columna se relaciona con las cajas de compensacion si y solo si la cuenta es CCAF
	`created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
	`updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
	`creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
	`updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
	`fecha_registro` datetime NOT NULL,
	`observaciones` text DEFAULT NULL,    
	PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla de datos historicos de tipos de prestamos';





-- Alertas
CREATE TABLE `Alertas` (
	`id` bigint auto_increment NOT NULL,
	`sociedad_id` bigint NOT NULL,    
	`nombre` varchar(250)  NULL,
	`Activa` boolean DEFAULT 0 NULL,
	`tipo_periodo` char(1)  NOT NULL,
	`hora_envio` time NULL,
	`lunes` boolean DEFAULT 0 NULL,
	`martes` boolean DEFAULT 0 NULL,
	`miercoles` boolean DEFAULT 0 NULL,
	`jueves` boolean DEFAULT 0 NULL,
	`viernes` boolean DEFAULT 0 NULL,
	`sabado` boolean DEFAULT 0 NULL,
	`Ddomingo` boolean DEFAULT 0 NULL,
	`dia_mes` int NULL,
	`destinatarios` text NOT NULL,
	`copia_destinatarios` text NULL,
	`p1` varchar(250)  NULL,
	`descripcion_p1` varchar(250)  NULL,
	`p2` varchar(250)  NULL NULL,
	`descripcion_p2` varchar(250) NULL,
	`consulta_reporte` text NULL, -- esta columna almacena una consulta sql
	`p_texto` text NULL,
	`considerar_jefatura` boolean DEFAULT 0 NOT NULL,
	 PRIMARY KEY (`id`),
	constraint `FK_Sociedad_Alertas` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
    on  update cascade on delete restrict       
) ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla de Alertas';



-- ---------------------------------------------------------------------------------
-- Tablas para Eventos de Nomina
-- ----------------------------------------------------------------------------------- 
-- ConceptosEventos en el sistema antigua EventosConceptos
-- Esta es la forma como se traducen a la dirección del trabajo los conceptos de los bonos
create table if not exists `ConceptosEventos` (
	`id` bigint auto_increment not null,
	`sociedad_id` bigint not null, -- relacionado con la tabla sociedad        
	`descripcion` varchar(150) not null,    
	`activo` boolean not null comment '0 Inactivo 1 Activo',      
    primary key (`id`),
    constraint `FK_Sociedad_ConceptosEventos` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
    on  update cascade on delete restrict       
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlar los conceptos descriptivos de los eventos en el sistema de nomina';


-- TiposEventos
create table if not exists `TiposEvento` (
	`id` bigint auto_increment not null,
	`sociedad_id` bigint not null, -- relacionado con la tabla sociedad        
	`tipo_evento` varchar(150)  NOT NULL,
	PRIMARY KEY (`id`),
    constraint `FK_Sociedad_TiposEvento` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
    on  update cascade on delete restrict      
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlar los tipos de eventos';


-- EstadoEventos
create table if not exists `EstadosEvento` (
	`id` bigint auto_increment NOT NULL,
	`sociedad_id` bigint not null, -- relacionado con la tabla sociedad    		Listo       
	`descripcion` varchar(150) not NULL,
	PRIMARY KEY (`id`),
	constraint `FK_Sociedad_EventosEstado` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
	on  update cascade on delete restrict     
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlar los estados de los eventos';


-- EventosConfigBase
create table if not exists `EventosConfigBase` (
	`id` bigint auto_increment not NULL,
	`sociedad_id` bigint not null comment 'sociedad a la que pertenece esta configuracion de eventos', -- relacionado con la tabla sociedad    		Listo       
	`concepto_evento_id` bigint not null ,   -- relacion con ConceptosEvento 	Listo
	`tipo_evento_id` bigint NOT NULL, -- relacion con tipo de evento 			listo
	`cuenta_contable` varchar(20) NULL comment 'representa una cuanta en el centro de costos, pero puede ser nulo',
	`nombre_evento` text NOT NULL  comment 'nombre del evento',
	`descripcion` text NULL comment 'cualquier descripcion adicional que quierea colocar el operador',
	`unidad_pacto_id` bigint not null comment 'relacionado con la tabla UnidadesPacto', 
	`autorizacion` boolean not NULL comment 'especifica si el evento requiere o no autorización para el pago',
	`proporcional_mes` boolean DEFAULT 0 NOT NULL comment 'especifica si se trata de un calculo relacionado al pago mensual o es un monto absoluto',
	`template_id` bigint NULL comment 'relacion con la tabla de templates de eventos no obligatoria',
	`activo` boolean not null comment '0 Inactivo 1 Activo', 
	`created` datetime NOT NULL,    
	`updated`  datetime NOT NULL,   
    `creator_user` BIGINT NOT NULL,     
    `updater_user` BIGINT NOT NULL,        
	PRIMARY KEY (`id`),
    constraint `FK_Sociedad_EventosConfigBase` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
    on  update cascade on delete restrict,     
    constraint `FK_ConceptosEvento_EventosConfigBase` foreign key (`concepto_evento_id`) references `ConceptosEventos` (`id`)
		on update cascade on delete restrict,    
    constraint `FK_TipoEvento_EventosConfigBase` foreign key (`tipo_evento_id`) references `TiposEvento` (`id`)
		on update cascade on delete restrict,
    constraint `FK_UnidadesPacto_EventosConfigBase` foreign key (`unidad_pacto_id`) references `UnidadesPacto` (`id`)
		on update cascade on delete restrict        
)  ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlar la configuracionde los eventos base';

-- HistoricoEventosConfigBase
create table if not exists `HisoricoEventosConfigBase` (
	`id` bigint not NULL,
	`sociedad_id` bigint not null comment 'sociedad a la que pertenece esta configuracion de eventos', -- relacionado con la tabla sociedad    		Listo       
	`concepto_evento_id` bigint not null comment 'cual es el concepto relacionado, esto es usado en el informe de la DT' ,   -- relacion con ConceptosEvento 	Listo
	`tipo_evento_id` bigint NOT NULL comment 'cual es el concepto relacionado, esto es usado en el informe de la DT', -- relacion con tipo de evento 			listo
	`cuenta_contable` varchar(20) NULL comment 'representa una cuanta en el centro de costos, pero puede ser nulo',
	`nombre_evento` text NOT NULL  comment 'nombre del evento',
	`descripcion` text NULL comment 'cualquier descripcion adicional que quierea colocar el operador',
	`unidad_pacto_id` bigint not null comment 'relacionado con la tabla UnidadesPacto', 
	`autorizacion` boolean not NULL comment 'especifica si el evento requiere o no autorización para el pago',
	`proporcional_mes` boolean DEFAULT 0 NOT NULL comment 'especifica si se trata de un calculo relacionado al pago mensual o es un monto absoluto',
	`template_id` bigint NULL comment 'relacion con la tabla de templates de eventos no obligatoria',
	`activo` boolean not null comment '0 Inactivo 1 Activo', 
	`created` datetime NOT NULL,    
	`updated`  datetime NOT NULL,   
    `creator_user` BIGINT NOT NULL,     
    `updater_user` BIGINT NOT NULL,    
	`fecha_registro_historico` datetime NOT NULL,    
	PRIMARY KEY (`id`,`sociedad_id`,`fecha_registro_historico`)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlar el histórico de la configuracionde los eventos base';


-- Eventos
-- es la preprogramación de lo que va a ocurrir en el momento de la nomina, controlado por la fecha
-- esto generara registros contable y se insertará en la tabla eventoslibro cuando se procese efectivamente
CREATE TABLE `Eventos` (
	`id` bigint auto_increment not NULL,
	`sociedad_id` bigint not null  comment 'sociedad a la que pertenece este eventos', -- relacionado con la tabla sociedad    		Listo           
	`tipo_evento_id` bigint NOT NULL comment 'relacion con la tabla TiposEventos', -- relacion con tipo de evento 			Listo
	`base_evento_id` bigint not NULL  comment 'relacion con la tabla EventosConfigBase',   -- relacion EventosConfigBase			Listo
	`estado_evento_id` bigint not NULL comment 'relacion con la tabla EstadosEventos',   -- relacion EstadosEvento   			Listo
	`periodo_id` bigint not NULL comment 'relacion con la tabla Periodos',   		-- relacion Periodo  	 			Listo    
	`fecha_autorizacion` datetime NULL comment 'Fecha en la que fu confiourado el evento',
	`continuo` boolean DEFAULT 0 NOT NULL comment 'define si el evento es continuo o discontinuo',
	`desde` datetime NULL comment 'fecha en la que comienza el evento',
	`hasta` datetime NULL comment 'fecha en la que termina el evento',
	`nombre_evento` text  NULL comment 'como se llama el evento',
	`observacion` text NULL comment 'cualquier descripcion adicional al evento',
	`centralizacion_id` bigint NULL comment 'relacion con la tabla Centralizaciones si aplica', -- puede o no estar relacionado con la tabla de centralizado 
	`created` datetime NOT NULL,    
	`updated`  datetime NOT NULL,   
    `creator_user` BIGINT NOT NULL,     
    `updater_user` BIGINT NOT NULL,      
	PRIMARY KEY (`id`),
    constraint `FK_Sociedad_Eventos` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
    on  update cascade on delete restrict , 
    constraint `FK_TiposEvento_Eventos` foreign key (`tipo_evento_id`) references `TiposEvento` (`id`) 
    on  update cascade on delete restrict ,
    constraint `FK_EventosConfigBase_Eventos` foreign key (`base_evento_id`) references `EventosConfigBase` (`id`) 
    on  update cascade on delete restrict,
    constraint `FK_EstadosEvento_Eventos` foreign key (`estado_evento_id`) references `EstadosEvento` (`id`) 
    on  update cascade on delete restrict,
    constraint `FK_Periodos_Eventos` foreign key (`periodo_id`) references `Periodos` (`id`) 
    on  update cascade on delete restrict  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlar los eventos de una sociedad';


-- Historico de Eventos
CREATE TABLE `HistoricoEventos` (
	`id` bigint auto_increment not NULL,
	`sociedad_id` bigint not null  comment 'sociedad a la que pertenece este eventos',
	`tipo_evento_id` bigint NOT NULL comment 'relacion con la tabla TiposEventos', 
	`base_evento_id` bigint not NULL  comment 'relacion con la tabla EventosConfigBase',
	`estado_evento_id` bigint not NULL comment 'relacion con la tabla EstadosEventos',
	`periodo_id` bigint not NULL comment 'relacion con la tabla Periodos',
	`fecha_autorizacion` datetime NULL comment 'Fecha en la que fu confiourado el evento',
	`continuo` boolean DEFAULT 0 NOT NULL comment 'define si el evento es continuo o discontinuo',
	`desde` datetime NULL comment 'fecha en la que comienza el evento',
	`hasta` datetime NULL comment 'fecha en la que termina el evento',
	`nombre_evento` text  NULL comment 'como se llama el evento',
	`observacion` text NULL comment 'cualquier descripcion adicional al evento',
	`centralizacion_id` bigint NULL comment 'relacion con la tabla Centralizaciones si aplica',
	`created` datetime NOT NULL,    
	`updated`  datetime NOT NULL,   
    `creator_user` BIGINT NOT NULL,     
    `updater_user` BIGINT NOT NULL,      
	`fecha_historico_created` datetime NOT NULL,        
	PRIMARY KEY (`id`,`fecha_historico_created`)   
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlar el histiro de eventos de una sociedad';

-- falta el libro de eventos, que es el detalle del pago al usuario, la ejecución del evento como tal
CREATE TABLE `LibroEventos` (
	`id` bigint auto_increment not NULL,
	`evento_id` bigint not NULL  comment 'eentocon el que esta relacionado este renglon',    
	`sociedad_id` bigint not null  comment 'sociedad a la que pertenece este eventos', 
	`tipo_evento_id` bigint NOT NULL  comment 'tipo de evento con el que está relacionado',
	`base_evento_id` bigint not NULL  comment 'EventoConfigBase con el que está relacionado',
	`estado_evento_id` bigint not NULL  comment 'estado del evento', 
	`periodo_id` bigint not NULL  comment 'periodo con el que esta relacionado', 
	`user_id` bigint not NULL  comment 'relacion con el usuario al que se le asignó el evento',     
	`monto` numeric (18,4) not NULL  comment 'monto del evento',
	`autorizado` boolean  NULL  comment 'si el evento requiere autorización se usara para verificasr si esta o no autorizado',    
	`created` datetime NOT NULL,    
	`updated`  datetime NOT NULL,   
    `creator_user` BIGINT NOT NULL,     
    `updater_user` BIGINT NOT NULL,      
	PRIMARY KEY (`id`),
    constraint `FK_Eventos_LibroEventos` foreign key (`sociedad_id`) references `Eventos` (`id`) 
    on  update cascade on delete restrict,      
    constraint `FK_Sociedad_LibroEventos` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
    on  update cascade on delete restrict,    
    constraint `FK_TiposEvento_LibroEventos` foreign key (`tipo_evento_id`) references `TiposEvento` (`id`) 
    on  update cascade on delete restrict,        
    constraint `FK_EventosConfigBase_LibroEventos` foreign key (`base_evento_id`) references `EventosConfigBase` (`id`) 
    on  update cascade on delete restrict, 
    constraint `FK_EstadosEvento_LibroEventos` foreign key (`estado_evento_id`) references `EstadosEvento` (`id`) 
    on  update cascade on delete restrict,
    constraint `FK_Periodos_LibroEventos` foreign key (`periodo_id`) references `Periodos` (`id`) 
    on  update cascade on delete restrict     ,
    constraint `FK_Usuario_LibroEventos` foreign key (`user_id`) references `Usuario` (`id`) 
    on  update cascade on delete restrict      
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'Tabla para controlar los eventos de una sociedad';

-- Sedes
CREATE TABLE `Sede` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `direccion` text NOT NULL,
  `region_id` bigint NOT NULL,
  `comuna_id` bigint NOT NULL,
  `ciudad` varchar(250) NOT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
  `creator_user` bigint NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`),
  KEY `FK_Comunas_Sede` (`comuna_id`),
  KEY `FK_Regiones_Sede` (`region_id`),
  KEY `FK_Sociedades_Sede` (`sociedad_id`),
  CONSTRAINT `FK_Comunas_Sede` FOREIGN KEY (`comuna_id`) REFERENCES `Comunas` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Regiones_Sede` FOREIGN KEY (`region_id`) REFERENCES `Regiones` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Sociedades_Sede` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla para controlar los datos de las sedes de  una sociedad';


-- HistoricoSede 
CREATE TABLE `HistoricoSede` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sede_id` bigint NOT NULL,  
  `sociedad_id` bigint NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `direccion` text DEFAULT NULL,
  `region_id` bigint NOT NULL,
  `comuna_id` bigint NOT NULL,
  `ciudad` varchar(250) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint NOT NULL,
  `updater_user` bigint NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8 COMMENT='Tabla para controlar los datos historicos de las sedes de  una sociedad';



-- Departamentos
CREATE TABLE `Departamentos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sociedad_id` bigint NOT NULL , 
  `sede_id` bigint NOT NULL ,   
  `nombre` varchar(200) NOT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
  `creator_user` bigint NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint NOT NULL COMMENT 'usuario que actualizó el parametro',
  PRIMARY KEY (`id`),
  constraint `FK_Sociedad_Departamentos` foreign key (`sociedad_id`) references `Sociedad` (`id`) on update cascade on delete restrict,
  constraint `FK_Sede_Departamentos` foreign key (`sede_id`) references `Sede` (`id`) on update cascade on delete restrict
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla para controlar los datos de los departamentos';

insert into `b1`.`Departamentos` values ('1','1','1','Administración','2024-02-01 10:00','2024-02-01 10:00','1','1');
insert into `b1`.`Departamentos` values ('2','1','1','Contabilidad','2024-02-01 10:00','2024-02-01 10:00','1','1');
insert into `b1`.`Departamentos` values ('3','1','1','Ventas','2024-02-01 10:00','2024-02-01 10:00','1','1');


-- HistoricoDepartamentos
CREATE TABLE `HistoricoDepartamentos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `departamento_id` bigint NOT NULL , 
  `sociedad_id` bigint NOT NULL , 
  `sede_id` bigint NOT NULL ,   
  `nombre` varchar(200) NOT NULL,
  `created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
  `updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
  `creator_user` bigint NOT NULL COMMENT 'usuario que creó el parametro',
  `updater_user` bigint NOT NULL COMMENT 'usuario que actualizó el parametro',
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,  
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla para controlar los datos historico de los departamentos';


-- UsuariosDepartamentos
CREATE TABLE `UsuariosDepartamentos` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`sociedad_id` bigint NOT NULL , 
	`sede_id` bigint NOT NULL ,  
	`departamento_id` bigint NOT NULL ,   
	`user_id` bigint NOT NULL , 
	`created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
	`updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
	`creator_user` bigint NOT NULL COMMENT 'usuario que creó el parametro',
	`updater_user` bigint NOT NULL COMMENT 'usuario que actualizó el parametro',
	PRIMARY KEY (`id`),
	constraint `FK_Sociedad_UsuariosDepartamentos` foreign key (`sociedad_id`) references `Sociedad` (`id`) on update cascade on delete restrict,
	constraint `FK_Sede_UsuariosDepartamentos` foreign key (`sede_id`) references `Sede` (`id`) on update cascade on delete restrict,
	constraint `FK_Departamento_UsuariosDepartamentos` foreign key (`departamento_id`) references `Departamentos` (`id`) on update cascade on delete restrict  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla para controlar los datos de los departamentos';

-- historicoCargosusuario
CREATE TABLE `HistoricoCargosUsuario` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cargos_usuarios_id` bigint NOT NULL ,  
  `sociedad_id` bigint DEFAULT NULL,
  `sede_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `cargo_id` bigint DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint NOT NULL,
  `updater_user` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de datos historico cargos del usuario';


-- grupos

CREATE TABLE `GruposEmpleado` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`sociedad_id` bigint NOT NULL ,  
	`es_honorario` boolean NOT NULL DEFAULT 0,
	`nombre` varchar(200) NOT NULL,
	`created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
	`updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
	`creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
	`updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
	PRIMARY KEY (`id`),
    constraint `FK_Sociedad_GruposEmpleado` foreign key (`sociedad_id`) references `Sociedad` (`id`) on update cascade on delete restrict
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de grupos de empleados';

insert into `GruposEmpleado` values ('1','1','0','Administrativo','2024-02-05 10:00','2024-02-05 10:00','1','1');
insert into `GruposEmpleado` values ('2','1','0','Ejecutivo','2024-02-05 10:00','2024-02-05 10:00','1','1');
insert into `GruposEmpleado` values ('3','1','0','Operaciones','2024-02-05 10:00','2024-02-05 10:00','1','1');


CREATE TABLE `HistoricoGruposEmpleado` (
	`id` bigint NOT NULL AUTO_INCREMENT,
	`sociedad_id` bigint NOT NULL ,    
	`grupo_empleados_id` bigint NOT NULL,  
	`es_honorario` boolean NOT NULL DEFAULT 0,
	`nombre` varchar(200) NOT NULL,
	`created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
	`updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
	`creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
	`updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
	`fecha_registro` datetime NOT NULL COMMENT 'fecha en que fue creado el registro historico',
	`observaciones` text DEFAULT NULL COMMENT 'observaciones del historico',  
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de grupos de empleados';

create table `UsuariosGruposEmpleado`(
	`id` bigint NOT NULL AUTO_INCREMENT,
	`grupo_empleados_id` bigint NOT NULL,  
	`sociedad_id` bigint NOT NULL,
	`sede_id` bigint NOT NULL,  
	`user_id` bigint NOT NULL,  	
	`created` datetime NOT NULL COMMENT 'fecha en que fue creado el registro',
	`updated` datetime NOT NULL COMMENT 'fecha en que fue actualizado el registro',
	`creator_user` bigint(20) NOT NULL COMMENT 'usuario que creó el parametro',
	`updater_user` bigint(20) NOT NULL COMMENT 'usuario que actualizó el parametro',
	`fecha_registro` datetime NOT NULL COMMENT 'fecha en que fue creado el registro historico',
	`observaciones` text DEFAULT NULL COMMENT 'observaciones del historico',  
	PRIMARY KEY (`id`),
	CONSTRAINT `FK_Sociedad_UsuariosGruposEmpleado` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE on delete restrict, 
	CONSTRAINT `FK_Sede_UsuariosGruposEmpleado` FOREIGN KEY (`sede_id`) REFERENCES `Sede` (`id`) ON UPDATE CASCADE on delete restrict,
	CONSTRAINT `FK_Usuario_UsuariosGruposEmpleado` FOREIGN KEY (`user_id`) REFERENCES `Usuario` (`id`) ON UPDATE CASCADE on delete restrict
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla de usuarios grupos de empleados';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de los modulos del sistema';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='Tabla de los modulos del sistema asigandos al usuario';



-- cuentas contables
CREATE TABLE b1.`CuentasContables` (
  `id` bigint(20) NOT NULL auto_increment,
  `sociedad_id` bigint(20) NOT NULL,
  `acct_code` varchar(20) NOT NULL,
  `acct_name` varchar(100) NOT NULL,
  `finance` char(1) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL,  
  PRIMARY KEY (`id`),
  KEY `FK_Sociedad_CuentasContables` (`sociedad_id`),
  CONSTRAINT `FK_Sociedad_CuentasContables` FOREIGN KEY (`sociedad_id`) REFERENCES `Sociedad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla para controlar las cuentas contables';


insert into b1.CuentasContables values ('1','1','11010001','Caja','Y','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('2','1','11010002','Caja Chica','Y','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('3','1','11010003','Banco Chile','Y','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('4','1','11020001','Fondos Mutuos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('5','1','11030001','Clientes','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('6','1','11040001','Cheques por Cobrar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('7','1','11040002','Documentos por Cobrar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('8','1','11050001','Fondo por Rendir','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('9','1','11050002','Anticipo Proveedor','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('10','1','11050003','Fondos por Rendir USD','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('11','1','11060001','Iva Crédito Fiscal','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('12','1','11060002','Pago Provisional Mensual','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('13','1','11060003','Crédito Sence','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('14','1','11060004','Crédito 4% Activo Fijo','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('15','1','11060005','Remanente IVA CF','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('16','1','11060006','Devolución Impto Renta','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('17','1','11070001','Mercaderias','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('18','1','11080001','Deudores Varios','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('19','1','11080002','Anticipo de sueldos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('20','1','11080003','Prestamos al Personal','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('21','1','11080004','Descuentos Convenios','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('22','1','11080005','Deudores Incobrables','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('23','1','11080006','Operaciones Pendientes','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('24','1','11090001','Cuenta Corriente EE.RR.','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('25','1','11100001','Gastos Anticipados','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('26','1','11110001','Otros Activos Circulantes','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('27','1','11110002','Documentos en Garantía','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('28','1','11110003','Préstamos por cobrar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('29','1','11120001','Interes Porción Corto Plazo','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('30','1','12010001','Terrenos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('31','1','12020001','Instalaciones','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('32','1','12030001','Equipos Computacionales','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('33','1','12030002','Muebles y Útiles','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('34','1','12030003','Maquinarias y Equipos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('35','1','12050001','Depreciación Instalaciones','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('36','1','12050002','Depreciación Equipos Computacionales','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('37','1','12050003','Depreciación Muebles y Útiles','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('38','1','12050005','Dep. Acum. Maq. y Equipos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('39','1','13040001','Interés Porción Largo Plazo','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('40','1','21010001','Préstamos Bancarios C/Plazo','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('41','1','21010002','Línea de Crédito Banco Chile','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('42','1','21020001','Proveedores','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('43','1','21020002','Documentos por pagar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('44','1','21020003','Cheques por Pagar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('45','1','21020004','Honorarios por Pagar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('46','1','21020005','Otros por pagar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('47','1','21020006','Remuneraciones por Pagar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('48','1','21020007','Rendiciones por Pagar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('49','1','21020008','Proveedor Extranjero','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('50','1','21020009','PRUEBA','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('51','1','21030001','Anticipo Clientes','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('52','1','21030002','Cuentas por Pagar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('53','1','21030003','Nominas Bancarias Otros Bancos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('54','1','21040001','Iva Débito Fiscal','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('55','1','21040002','Ret Honor. 3% Ptmo Solidario del Estado','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('56','1','21040003','Retenciones de Honorarios','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('57','1','21040004','Imp. Unico Trabajadores','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('58','1','21040005','Iva por Pagar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('59','1','21040006','Ret. Sueldo 3% Ptmo Solidario del Estado','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('60','1','21050001','Afp por pagar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('61','1','21050002','Isapre por pagar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('62','1','21050003','Caja compensación por pagar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('63','1','21050004','Mutual por pagar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('64','1','21050005','Otros Descuentos trabajador','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('65','1','21050006','Provisión PPM','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('66','1','21050007','Provisión Impto Renta','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('67','1','21050008','Provisiones','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('68','1','21050009','Inp / Fonasa por pagar','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('69','1','21060001','Acreedores Varios','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('70','1','21060002','Puente Rendición','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('71','1','21060003','Nomina de Transferencia','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('72','1','22010001','Préstamos Bancarios L/Plazo','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('73','1','30000001','Capital','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('74','1','30000002','Utilidad Acumulada','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('75','1','30000003','Utilidad Ejercicio','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('76','1','30000005','Revaloriz. Capital Propio','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('77','1','30120001','Cta Particular Inversiones BALU SPA','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('78','1','30120002','Cta Particular Inversiones KAREN EIRL','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('79','1','30130001','Apertura SAP','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('80','1','40100001','Ingresos del giro','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('81','1','40200001','Asesorias','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('82','1','50100001','Costos de Telefonía Ip','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('83','1','50100002','Costos de Comunicación','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('84','1','50100003','Costos de Serv. Call Center','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('85','1','50100004','Licencias Call Center','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('86','1','51100001','Remuneraciones Ejecutivos CallCenter','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('87','1','51100002','Beneficios Ejecutivos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('88','1','51100003','Otros no imponible, reembolsos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('89','1','51100004','Gratificacion Ejecutivos Call Center','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('90','1','51100005','Movilización Call Center','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('91','1','51100006','Colación Call Center','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('92','1','51100007','Leyes Sociales Ejec.','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('93','1','51100008','Posteos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('94','1','51200001','Honorarios Ejecutivos Call Center','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('95','1','51200002','Finiquitos Ejecutivos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('96','1','51200003','Gastos de capacitación Ejecutivos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('97','1','51200004','Honorarios por Reclutamiento','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('98','1','51200005','Honorarios Coaching, Auditoria de Calidad','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('99','1','51200006','Honorarios Logística','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('100','1','51200007','Servicios de Reclutamiento','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('101','1','51200008','Servicios Logística','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('102','1','51200009','Servicios Externos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('103','1','51300001','Sub-Contrato Call Center','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('104','1','51300002','Tecnicas para Trabajos con Clientes Dificil','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('105','1','51400001','Cintillos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('106','1','51400002','Insumos Computacionales','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('107','1','51400003','Bajas de Computadores','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('108','1','51400004','Sistemas de Gestión','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('109','1','51500001','Remuneraciones Operación CallCenter','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('110','1','51500002','Otros no imponible, reembolsos Op','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('111','1','51500003','Gratificacion Operación Call Center','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('112','1','51500004','Movilización Operación','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('113','1','51500005','Colación Operación','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('114','1','51500006','Leyes Sociales Op.','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('115','1','51500007','Finiquitos Operaciones','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('116','1','51500008','Gastos de capacitación Operaciones','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('117','1','60110001','Sueldos Adm','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('118','1','60110002','Gratificación Adm','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('119','1','60110003','Movilización Adm','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('120','1','60110004','Colación Adm','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('121','1','60110005','Otros no imponible Adm','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('122','1','60110006','Leyes Sociales Adm','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('123','1','60110007','Otros imponible Adm','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('124','1','60120001','Honorarios','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('125','1','60120002','Finiquitos Administrativos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('126','1','60120003','Seguro Colectivo MetLife','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('127','1','60120004','Seguro Covid','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('128','1','60130001','Sueldos Venta','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('129','1','60130002','Gratificación Venta','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('130','1','60130003','Movilización Venta','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('131','1','60130004','Colación Venta','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('132','1','60130005','Otros no imponible Venta','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('133','1','60130006','Leyes Sociales Venta','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('134','1','60130007','Otros imponible Venta','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('135','1','60130008','Comisiones Venta','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('136','1','60210001','Arriendos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('137','1','60210002','Arriendo Bodega','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('138','1','60210003','Eventos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('139','1','60310001','Mantención Computadores','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('140','1','60310002','Mantención Instalaciones','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('141','1','60410001','Electricidad','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('142','1','60410002','Agua','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('143','1','60410003','Gastos courrier-correo','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('144','1','60410004','Gas','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('145','1','60510001','Útiles de Oficina','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('146','1','60510002','Articulos de aseo','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('147','1','60510003','Alimentación','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('148','1','60510004','Movilización-Estacionamiento','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('149','1','60510005','Papeleria e Impresos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('150','1','60520001','Gastos Notariales','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('151','1','60520002','Patente Municipal','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('152','1','60530001','Regalias al Personal, Eventos','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('153','1','60530002','Celular','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('154','1','60530003','Gastos de Tecnología','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('155','1','60530004','Otros Gastos de Administración','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('156','1','60530005','Seguridad','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('157','1','60530006','Otros Servicios de Tecnología','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('158','1','60530007','Gastos de capacitación Adm','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('159','1','60540001','Gastos de Marketing y Publicidad','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('160','1','60550001','Asesorias Tributarias','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('161','1','60550002','Asesorias Comerciales','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('162','1','60550003','Asesorias Legales','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('163','1','60550004','Honorarios Legales','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('164','1','70100001','Ingresos por Instrumentos Financieros','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('165','1','70100002','Utilidad Diferencia de Cambio','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('166','1','70200001','Utilidad por Venta de Activo Fijo','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('167','1','70300001','Ingresos por Subsidios al Empleo','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('168','1','80100001','Interés financiero devengado factoring','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('169','1','80100002','Intereses LC y Créditos Bancarios','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('170','1','80100003','Perdida Diferencia de Cambio','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('171','1','80100004','Gastos Bancarios','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('172','1','80100005','Diferencia menores','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('173','1','80200001','Baja de Activo Fijo','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('174','1','80200002','Incobrables','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('175','1','80200003','Donaciones','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('176','1','80300001','Corrección Monetaria','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('177','1','80400001','Depreciación','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('178','1','80500001','Impuesto Renta','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');
insert into b1.CuentasContables values ('179','1','CETRANSACCT','Copy Express transport account','N','2024-02-20 10:00:00','2024-02-20 10:00:00','1','1');


-- historico cuentas contables
CREATE TABLE b1.`HistoricoCuentasContables` (
  `id` bigint(20) NOT NULL auto_increment,
  `cuenta_contable_id` bigint(20) NOT NULL,  
  `sociedad_id` bigint(20) NOT NULL,
  `acct_code` varchar(20) NOT NULL,
  `acct_name` varchar(100) NOT NULL,
  `finance` char(1) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `creator_user` bigint(20) NOT NULL,
  `updater_user` bigint(20) NOT NULL, 
  `fecha_registro` datetime NOT NULL,
  `observaciones` text DEFAULT NULL,  
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabla para controlar los datos historicos de las cuentas contables';



-- vistas del sistema ----
CREATE or replace VIEW `b1`.`viewGeneralBancariosUser` AS select `b1`.`Usuario`.`id` AS `user_id`,`b1`.`Usuario`.`rut` AS `rut`,`b1`.`Usuario`.`rut_provisorio` AS `rut_provisorio`,`b1`.`Usuario`.`nombres` AS `nombres`,`b1`.`Usuario`.`apellido_paterno` AS `apellido_paterno`,`b1`.`Usuario`.`apellido_materno` AS `apellido_materno`,`b1`.`BancariosUser`.`id` AS `bancario_id`,`b1`.`BancariosUser`.`banco_id` AS `banco_id`,`b1`.`BancariosUser`.`numero_cuenta` AS `numero_cuenta`,`b1`.`BancariosUser`.`en_uso` AS `en_uso`,`b1`.`BancariosUser`.`terceros` AS `terceros`,`b1`.`BancariosUser`.`rut_tercero` AS `rut_tercero`,`b1`.`BancariosUser`.`nombre_tercero` AS `nombre_tercero`,`b1`.`BancariosUser`.`email_tercero` AS `email_tercero`,`b1`.`Bancos`.`nombre` AS `banco_nombre`,`b1`.`Bancos`.`codigo` AS `banco_codigo` from ((`b1`.`Usuario` join `b1`.`BancariosUser` on(`b1`.`Usuario`.`id` = `b1`.`BancariosUser`.`user_id`)) join `b1`.`Bancos` on(`b1`.`Bancos`.`id` = `b1`.`BancariosUser`.`banco_id`));

CREATE or replace VIEW `b1`.`viewGeneralUser` AS select `b1`.`Usuario`.`id` AS `id`,`b1`.`Usuario`.`rut` AS `rut`,`b1`.`Usuario`.`rut_provisorio` AS `rut_provisorio`,`b1`.`Usuario`.`nombres` AS `nombres`,`b1`.`Usuario`.`apellido_paterno` AS `apellido_paterno`,`b1`.`Usuario`.`apellido_materno` AS `apellido_materno`,`b1`.`Usuario`.`fecha_nacimiento` AS `fecha_nacimiento`,`b1`.`Usuario`.`sexo_id` AS `sexo_id`,`b1`.`Usuario`.`estado_civil_id` AS `estado_civil_id`,`b1`.`Usuario`.`nacionalidad_id` AS `nacionalidad_id`,`b1`.`Usuario`.`username` AS `username`,`b1`.`Usuario`.`password` AS `password`,`b1`.`Usuario`.`activo` AS `activo`,`b1`.`Usuario`.`created` AS `created`,`b1`.`Usuario`.`updated` AS `updated`,`b1`.`Usuario`.`creator_user` AS `creator_user`,`b1`.`Usuario`.`updater_user` AS `updater_user`,`b1`.`Contacto`.`email` AS `email`,`b1`.`Contacto`.`fijo` AS `fijo`,`b1`.`Contacto`.`movil` AS `movil`,`b1`.`Ubicacion`.`region_id` AS `region_id`,`b1`.`Ubicacion`.`comuna_id` AS `comuna_id`,`b1`.`Ubicacion`.`direccion` AS `direccion`,`b1`.`Regiones`.`nombre` AS `nomregion`,`b1`.`Regiones`.`orden` AS `orden`,`b1`.`Comunas`.`nombre` AS `nomcomuna` from ((((`b1`.`Usuario` left join `b1`.`Contacto` on(`b1`.`Usuario`.`id` = `b1`.`Contacto`.`user_id`)) left join `b1`.`Ubicacion` on(`b1`.`Usuario`.`id` = `b1`.`Ubicacion`.`user_id`)) left join `b1`.`Regiones` on(`b1`.`Ubicacion`.`region_id` = `b1`.`Regiones`.`id`)) left join `b1`.`Comunas` on(`b1`.`Ubicacion`.`comuna_id` = `b1`.`Comunas`.`id` and `b1`.`Ubicacion`.`region_id` = `b1`.`Comunas`.`region_id`));

CREATE or replace VIEW `b1`.`viewGeneralUserModulo` AS select `b1`.`UsuarioModulo`.`id` AS `id`,`b1`.`UsuarioModulo`.`user_id` AS `user_id`,`b1`.`UsuarioModulo`.`modulo_id` AS `modulo_id`,`b1`.`UsuarioModulo`.`estado` AS `estado`,`b1`.`UsuarioModulo`.`created` AS `created`,`b1`.`UsuarioModulo`.`updated` AS `updated`,`b1`.`UsuarioModulo`.`creator_user` AS `creator_user`,`b1`.`UsuarioModulo`.`updater_user` AS `updater_user`,`b1`.`Modulo`.`nombre` AS `nombremodulo`,`b1`.`Modulo`.`url` AS `urlmodulo`,`b1`.`Modulo`.`icono` AS `iconomodulo`,`b1`.`Modulo`.`estado` AS `estadomodulo` from (`b1`.`UsuarioModulo` join `b1`.`Modulo` on(`b1`.`UsuarioModulo`.`modulo_id` = `b1`.`Modulo`.`id`));

CREATE or replace VIEW `b1`.`viewGeneralUserSDG` AS 
   select `b1`.`Usuario`.`id` AS `id`,
    `b1`.`Usuario`.`rut` AS `rut`,
    `b1`.`Usuario`.`rut_provisorio` AS `rut_provisorio`,
    `b1`.`Usuario`.`nombres` AS `nombres`,
    `b1`.`Usuario`.`apellido_paterno` AS `apellido_paterno`,
    `b1`.`Usuario`.`apellido_materno` AS `apellido_materno`,
    `b1`.`Usuario`.`fecha_nacimiento` AS `fecha_nacimiento`,
    `b1`.`Usuario`.`sexo_id` AS `sexo_id`,
    `b1`.`Usuario`.`estado_civil_id` AS `estado_civil_id`,
    `b1`.`Usuario`.`nacionalidad_id` AS `nacionalidad_id`,
    `b1`.`Usuario`.`username` AS `username`,
    `b1`.`Usuario`.`password` AS `password`,
    `b1`.`Usuario`.`activo` AS `activo`,
    `b1`.`Usuario`.`created` AS `created`,
    `b1`.`Usuario`.`updated` AS `updated`,
    `b1`.`Usuario`.`creator_user` AS `creator_user`,
    `b1`.`Usuario`.`updater_user` AS `updater_user`,
    `b1`.`Contacto`.`email` AS `email`,
    `b1`.`Contacto`.`fijo` AS `fijo`,
    `b1`.`Contacto`.`movil` AS `movil`,
    `b1`.`Ubicacion`.`region_id` AS `region_id`,
    `b1`.`Ubicacion`.`comuna_id` AS `comuna_id`,
    `b1`.`Ubicacion`.`direccion` AS `direccion`,
    `b1`.`Regiones`.`nombre` AS `nomregion`,
    `b1`.`Regiones`.`orden` AS `orden`,
    `b1`.`Comunas`.`nombre` AS `nomcomuna`, 
    `b1`.`UsuariosDepartamentos`.`sociedad_id` as `sociedad_id`,
    `b1`.`UsuariosDepartamentos`.`sede_id` as `sede_id`,
    `b1`.`UsuariosDepartamentos`.`departamento_id` as `departamento_id`,
    `b1`.`Departamentos`.`nombre` as `nomdepartamento`,
    `b1`.`UsuariosGruposEmpleado`.`grupo_empleados_id` as `grupo_empleados_id`,
    `b1`.`GruposEmpleado`.`nombre` as `nombre_grupo`,
    `b1`.`Sede`.`nombre` as `nombre_sede`
    from ((((`b1`.`Usuario` 
    left join `b1`.`Contacto` on(`b1`.`Usuario`.`id` = `b1`.`Contacto`.`user_id`)) 
    left join `b1`.`Ubicacion` on(`b1`.`Usuario`.`id` = `b1`.`Ubicacion`.`user_id`)) 
    left join `b1`.`Regiones` on(`b1`.`Ubicacion`.`region_id` = `b1`.`Regiones`.`id`)) 
    left join `b1`.`Comunas` on(`b1`.`Ubicacion`.`comuna_id` = `b1`.`Comunas`.`id` and `b1`.`Ubicacion`.`region_id` = `b1`.`Comunas`.`region_id`))
    inner join `b1`.`UsuariosDepartamentos` on (`b1`.`UsuariosDepartamentos`.`user_id`=`b1`.`Usuario`.`id`)
    inner join `b1`.`Departamentos` on (`b1`.`UsuariosDepartamentos`.`departamento_id`=`b1`.`Departamentos`.`id`)
    inner join `b1`.`UsuariosGruposEmpleado` on (`b1`.`UsuariosGruposEmpleado`.`user_id`=`b1`.`Usuario`.`id`)
    inner join `b1`.`GruposEmpleado` on (`b1`.`GruposEmpleado`.`id`=`b1`.`UsuariosGruposEmpleado`.`grupo_empleados_id`)
    inner join `b1`.`Sede` on (`b1`.`Sede`.`id`=`b1`.`UsuariosDepartamentos`.`sede_id`);

-- vistas del sistema ----------



/*

-- GruposEmpleados
CREATE TABLE `GruposEmpleado` (
	`id` bigint auto_increment not null,
	`sociedad_id` bigint  not null, -- sociedad con la cual esta relacionado el grupo    
	`es_honorario` boolean DEFAULT 0 NOT NULL,
	`nombre` varchar(200)  NOT NULL,
	`monto_max_prestamo` numeric(18,4) NULL,
	`cuotas_max_prestamo` int NULL,
	`porcentaje_tope_cuota_prestamo` numeric(18,4) NULL,
	`monto_max_anticipo` numeric(18,4) NULL,
	`porcentaje_max_anticipo` numeric(18,4) NULL,
	`calcular_porcentaje_segun` varchar(10)  NULL,
	`factura_mas_pago` boolean DEFAULT 0 NOT NULL,
	`cuenta_factura_proveedor` varchar(20),
	`cuenta_pago_factura` varchar(20) NULL,
	`cuenta_remunera_deb` varchar(20) NULL,
	`cuenta_AFP_debitar` varchar(20) NULL,
	`cuenta_salud_Deb` varchar(20) NULL,
	`cuenta_gratificacion_deb` varchar(20) NULL,
	`cuentas_horas_ext_debitar` varchar(20)  NULL,
	`cuenta_seguro_AFC_debitar` varchar(20)  NULL,
	`cuenta_mov_debitar` varchar(20)  NULL,
	`cuenta_colacion_debitar` nvarchar(20)   NULL,
	`cuenta_otras_asignaciones_debitar` varchar(20)  NULL,
	`cuenta_SIS_debitar` varchar(20)  NULL,
	`cuenta_mutual_debitar` nvarchar(20)   NULL,
	`CueImpUnic_Deb` nvarchar(20)   NULL,
	`CueAsigFami_Deb` nvarchar(20)   NULL,
	`CueAfcEmpresa_Cred` nvarchar(20)   NULL,
	`CueAsigFami_Cred` nvarchar(20)   NULL,
	`CueImpUnic_Cred` nvarchar(20)   NULL,
	`CueSueldoxPagar_Cred` nvarchar(20)   NULL,
	`created` datetime NOT NULL comment 'fecha en que fue creado el registro',    
	`updated`  datetime NOT NULL  comment 'fecha en que fue actualizado el registro',   
    `creator_user` BIGINT NOT NULL  comment 'usuario que creó el parametro',     
    `updater_user` BIGINT NOT NULL  comment 'usuario que actualizó el parametro',     
	 PRIMARY KEY (`id`),
    constraint `FK_Sociedad_GruposEmpleado` foreign key (`sociedad_id`) references `Sociedad` (`id`) 
    on  update cascade on delete restrict      
)  ENGINE=INNODB DEFAULT CHARSET=UTF8 comment 'Tabla de grupos de empleados';


CREATE TABLE B1NTesting.dbo.EventosDetalle (
	IdEvento int NOT NULL,
	UserId uniqueidentifier NOT NULL,
	Lin int NOT NULL,
	FechaCreacionReg datetime NULL,
	UserCrea uniqueidentifier NULL,
	UserUpdate uniqueidentifier NULL,
	FechaUpdate datetime NULL,
	IdCargo int NULL,
	ValorPers numeric(18,4) NULL,
	CuentaContable nvarchar(20)   NULL,
	IdGrupo int NULL,
	IdAutorizacion int NULL,
	IdEtapaAutorizacion int NULL,
	IdEstadoLinea int NULL,
	CONSTRAINT PK_LinEventosUsuario PRIMARY KEY (IdEvento,UserId,Lin)
);
ALTER TABLE B1NTesting.dbo.EventosDetalle ADD CONSTRAINT FK_EventosDetalle_AutorizacionesEtapas 
	FOREIGN KEY (IdAutorizacion,IdEtapaAutorizacion) REFERENCES B1NTesting.dbo.AutorizacionesEtapas(IdAutorizacion,IdEtapa);
ALTER TABLE B1NTesting.dbo.EventosDetalle ADD CONSTRAINT FK_EventosDetalle_EventosEstadoDetalle 
	FOREIGN KEY (IdEstadoLinea) REFERENCES B1NTesting.dbo.EventosEstadoDetalle(IdEstadoLinea);
ALTER TABLE B1NTesting.dbo.EventosDetalle ADD CONSTRAINT FK_LinEventosUsuario_EventosUsuario 
	FOREIGN KEY (IdEvento) REFERENCES B1NTesting.dbo.Eventos(IdEvento);
ALTER TABLE B1NTesting.dbo.EventosDetalle ADD CONSTRAINT FK_LinEventosUsuario_aspnet_ProfileUsers 
	FOREIGN KEY (UserId) REFERENCES B1NTesting.dbo.aspnet_ProfileUsers(UserId);
CREATE TABLE B1NTesting.dbo.EventosDetalleHistoria (
	FechaRegistro datetime NOT NULL,
	IdEvento int NOT NULL,
	UserId uniqueidentifier NOT NULL,
	Lin int NOT NULL,
	FechaCreacionReg datetime NULL,
	UserCrea uniqueidentifier NULL,
	UserUpdate uniqueidentifier NULL,
	FechaUpdate datetime NULL,
	IdCargo int NULL,
	ValorPers numeric(18,4) NULL,
	CuentaContable nvarchar(20)   NULL,
	IdGrupo int NULL,
	IdAutorizacion int NULL,
	IdEtapaAutorizacion int NULL,
	IdEstadoLinea int NULL,
	CONSTRAINT PK_LinEventosHistoria PRIMARY KEY (FechaRegistro,IdEvento,Lin)
);
CREATE TABLE B1NTesting.dbo.EventosEstadoDetalle (
	IdEstadoLinea int NOT NULL,
	EstadoLinea nvarchar(100)   NOT NULL,
	CONSTRAINT PK_EventosEstadoDetalle PRIMARY KEY (IdEstadoLinea)
);
CREATE TABLE B1NTesting.dbo.EventosHistoria (
	FechaRegistro datetime NOT NULL,
	IdEvento int NOT NULL,
	FechaCreacion datetime NOT NULL,
	UsrCreo uniqueidentifier NOT NULL,
	FechaUpdate datetime NULL,
	UsrUpdate uniqueidentifier NULL,
	IdEstadoEvento int NULL,
	UserAutoriza uniqueidentifier NULL,
	FechaAutorizacion datetime NULL,
	IdTipoEvento int NOT NULL,
	Activo bit NOT NULL,
	Continuo bit NOT NULL,
	Desde datetime NULL,
	Hasta datetime NULL,
	NombreEvento nvarchar(500)   NULL,
	IdBaseEvento int NULL,
	Observacion nvarchar(1000)   NULL,
	IdCentralización int NULL,
	PeriodosInvolucrados nvarchar(500)   NULL,
	CONSTRAINT PK_EventosHistoria PRIMARY KEY (FechaRegistro)
);CREATE TABLE B1NTesting.dbo.EventosLibro (
	IdRegistro int IDENTITY(1,1) NOT NULL,
	IdPeriodo int NOT NULL,
	IdSueldo int NOT NULL,
	UserId uniqueidentifier NOT NULL,
	TipoProceso char(1)   NULL,
	IdTipoEvento int NULL,
	Evento int NULL,
	NombreEvento nvarchar(500)   NULL,
	Prestamo int NULL,
	TipoPrestamo nvarchar(500)   NULL,
	IdInstitucionAPV int NULL,
	PagoDirectoIndirecto bit NULL,
	NombreAPV nvarchar(30)   NULL,
	CodExternoAPV nvarchar(5)   NULL,
	Monto numeric(18,4) NULL,
	MontoAPVCEmpleador numeric(18,4) NULL,
	ApvEsColectivo bit NULL,
	Regimen char(1)   NULL,
	IdConcepto int NULL,
	CONSTRAINT PK_EventosLibro PRIMARY KEY (IdRegistro,IdPeriodo,IdSueldo,UserId)
);
 CREATE NONCLUSTERED INDEX NonClusteredIndex-20200514-154241 ON dbo.EventosLibro (  IdRegistro ASC  , IdPeriodo ASC  , IdSueldo ASC  , UserId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
ALTER TABLE B1NTesting.dbo.EventosLibro ADD CONSTRAINT FK_EventosLibro_SueldoHead 
	FOREIGN KEY (IdSueldo) REFERENCES B1NTesting.dbo.SueldoHead(IdSueldo);
CREATE TABLE B1NTesting.dbo.EventosLibroHonorario (
	IdRegistro int IDENTITY(1,1) NOT NULL,
	IdPeriodo int NOT NULL,
	IdSueldoH int NOT NULL,
	UserId uniqueidentifier NOT NULL,
	TipoProceso char(1)   NULL,
	IdTipoEvento int NULL,
	Evento int NULL,
	NombreEvento nvarchar(500)   NULL,
	Prestamo int NULL,
	TipoPrestamo nvarchar(500)   NULL,
	IdInstitucionAPV int NULL,
	PagoDirectoIndirecto bit NULL,
	NombreAPV nvarchar(30)   NULL,
	CodExternoAPV nvarchar(5)   NULL,
	Monto numeric(18,4) NULL,
	CONSTRAINT PK_EventosLibroH PRIMARY KEY (IdRegistro,IdPeriodo,IdSueldoH,UserId)
);
ALTER TABLE B1NTesting.dbo.EventosLibroHonorario ADD CONSTRAINT FK_EventosLibroH_SueldosHonorariosH 
	FOREIGN KEY (IdSueldoH) REFERENCES B1NTesting.dbo.SueldosHonorariosH(IdSueldo);
CREATE TABLE B1NTesting.dbo.EventosLibroTemp (
	IdRegistro int IDENTITY(1,1) NOT NULL,
	IdPeriodo int NOT NULL,
	IdSueldo int NOT NULL,
	UserId uniqueidentifier NOT NULL,
	TipoProceso char(1)   NULL,
	IdTipoEvento int NULL,
	Evento int NULL,
	NombreEvento nvarchar(500)   NULL,
	Prestamo int NULL,
	TipoPrestamo nvarchar(500)   NULL,
	IdInstitucionAPV int NULL,
	PagoDirectoIndirecto bit DEFAULT 1 NULL,
	NombreAPV nvarchar(30)   NULL,
	CodExternoAPV nvarchar(5)   NULL,
	Monto numeric(18,4) NULL,
	MontoAPVCEmpleador numeric(18,4) NULL,
	ApvEsColectivo bit NULL,
	Regimen char(1)   NULL,
	IdConcepto int NULL,
	CONSTRAINT PK_EventosLibroTemp PRIMARY KEY (IdRegistro,IdPeriodo,IdSueldo,UserId)
);CREATE TABLE B1NTesting.dbo.EventosPeriodos (
	IdEvento int NOT NULL,
	IdPeriodo int NOT NULL,
	CONSTRAINT PK_EventosPeriodos PRIMARY KEY (IdEvento,IdPeriodo)
);
ALTER TABLE B1NTesting.dbo.EventosPeriodos ADD CONSTRAINT FK_EventosPeriodos_Eventos 
	FOREIGN KEY (IdEvento) REFERENCES B1NTesting.dbo.Eventos(IdEvento);
ALTER TABLE B1NTesting.dbo.EventosPeriodos ADD CONSTRAINT FK_EventosPeriodos_Periodos 
	FOREIGN KEY (IdPeriodo) REFERENCES B1NTesting.dbo.Periodos(IdPeriodo);
CREATE TABLE B1NTesting.dbo.EventosAutomaticos (
	IdEventoAut int NOT NULL,
	EventoAutomatico nvarchar(300)   NOT NULL,
	Activo bit DEFAULT 0 NOT NULL,
	EsProporcional bit DEFAULT 0 NOT NULL,
	Cuenta nvarchar(50)   NULL,
	MontoEvento int DEFAULT 0 NOT NULL,
	Config_1 int NULL,
	NombreConf_1 nvarchar(50)   NULL,
	Descripcion nvarchar(1000)   NULL,
	CONSTRAINT PK_EventosAutomaticos PRIMARY KEY (IdEventoAut)
);
CREATE TABLE EventosLibro (
	IdRegistro int IDENTITY(1,1) NOT NULL,
	IdPeriodo int NOT NULL,
	IdSueldo int NOT NULL,
	UserId uniqueidentifier NOT NULL,
	TipoProceso char(1) COLLATE Modern_Spanish_CI_AS NULL,
	IdTipoEvento int NULL,
	Evento int NULL,
	NombreEvento nvarchar(500) COLLATE Modern_Spanish_CI_AS NULL,
	Prestamo int NULL,
	TipoPrestamo nvarchar(500) COLLATE Modern_Spanish_CI_AS NULL,
	IdInstitucionAPV int NULL,
	PagoDirectoIndirecto bit NULL,
	NombreAPV nvarchar(30) COLLATE Modern_Spanish_CI_AS NULL,
	CodExternoAPV nvarchar(5) COLLATE Modern_Spanish_CI_AS NULL,
	Monto numeric(18,4) NULL,
	MontoAPVCEmpleador numeric(18,4) NULL,
	ApvEsColectivo bit NULL,
	Regimen char(1) COLLATE Modern_Spanish_CI_AS NULL,
	IdConcepto int NULL,
	CONSTRAINT PK_EventosLibro PRIMARY KEY (IdRegistro,IdPeriodo,IdSueldo,UserId)
);
 CREATE NONCLUSTERED INDEX NonClusteredIndex-20200514-154241 ON dbo.EventosLibro (  IdRegistro ASC  , IdPeriodo ASC  , IdSueldo ASC  , UserId ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
-- B1NTesting.dbo.EventosLibro foreign keysALTER TABLE B1NTesting.dbo.EventosLibro ADD CONSTRAINT FK_EventosLibro_SueldoHead FOREIGN KEY (IdSueldo) REFERENCES B1NTesting.dbo.SueldoHead(IdSueldo);*/
select 'termine' , Now()
