/*
SQLyog - Free MySQL GUI v5.11
Host - 5.6.17 : Database - autopack
*********************************************************************
Server version : 5.6.17
*/


SET NAMES utf8;

SET SQL_MODE='';

create database if not exists `autopark`;

USE `autopark`;

/*Table structure for table `cliente` */

DROP TABLE IF EXISTS `cliente`;

CREATE TABLE `cliente` (
  `rut` bigint(20) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `e-mail` varchar(50) NOT NULL,
  PRIMARY KEY (`rut`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cliente` */

insert into `cliente` (`rut`,`nombre`,`telefono`,`e-mail`) values (15644658,'Diego','32165487','die@gmail.com'),(18057300,'Sebastian','12345678','sf@gmail.com'),(18326977,'adolfo','9638521','hitler@gmail.com');

/*Table structure for table `estacionamiento` */

DROP TABLE IF EXISTS `estacionamiento`;

CREATE TABLE `estacionamiento` (
  `id_estacionamiento` bigint(20) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  `monto` bigint(20) NOT NULL,
  `coordenadas` varchar(200) NOT NULL,
  PRIMARY KEY (`id_estacionamiento`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `estacionamiento` */

insert into `estacionamiento` (`id_estacionamiento`,`descripcion`,`monto`,`coordenadas`) values (1,'Plaza Civica - Valparaiso',2000,'asd'),(2,'Mirador del Sol - Quilpué',3000,'dasd'),(3,'Plaza de Armas - Santiago',500,'65465413'),(4,'Plaza de Armas - Valparaiso',1500,'asdsad');

/*Table structure for table `boucher` */

DROP TABLE IF EXISTS `boucher`;

CREATE TABLE `boucher` (
  `n_boucher` bigint(20) NOT NULL AUTO_INCREMENT,
  `op_de_envio` varchar(50) NOT NULL,
  `forma_de_pago` varchar(50) NOT NULL,
  `total_boleta` bigint(20) NOT NULL,
  `rut_cliente` bigint(20) NOT NULL,
  PRIMARY KEY (`n_boucher`),
  KEY `FK_boucher` (`rut_cliente`),
  CONSTRAINT `boucher_ibfk_1` FOREIGN KEY (`rut_cliente`) REFERENCES `cliente` (`rut`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `boucher` */

insert into `boucher` (`n_boucher`,`op_de_envio`,`forma_de_pago`,`total_boleta`,`rut_cliente`) values (1,'Correo Electronico','Transferencia',1500,18057300),(2,'Direccion Particular','Pago en Linea',2000,15644658),(3,'Correo Electronico','Orden de Compra',2000,18326977);

/*Table structure for table `ticket` */

DROP TABLE IF EXISTS `ticket`;

CREATE TABLE `ticket` (
  `n_ticket` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_estacionamiento` bigint(20) NOT NULL,
  `n_boucher` bigint(20) NOT NULL,
  PRIMARY KEY (`n_ticket`),
  KEY `FK_ticket` (`n_boucher`),
  KEY `id_estacionamiento` (`id_estacionamiento`),
  CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`n_boucher`) REFERENCES `boucher` (`n_boucher`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`id_estacionamiento`) REFERENCES `estacionamiento` (`id_estacionamiento`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `ticket` */

insert into `ticket` (`n_ticket`,`id_estacionamiento`,`n_boucher`) values (1,4,2),(2,3,2),(3,4,1),(4,1,3);