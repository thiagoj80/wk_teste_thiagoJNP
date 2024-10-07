-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: localhost    Database: wk_teste
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `PedidoId` int NOT NULL AUTO_INCREMENT,
  `DataEmissao` datetime DEFAULT NULL,
  `CodCliente` int DEFAULT NULL,
  `ValorTotal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`PedidoId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,'1899-12-30 00:00:00',1,169.59),(2,'1899-12-30 00:00:00',1,169.59),(3,'1899-12-30 00:00:00',10,472.70),(4,'1899-12-30 00:00:00',3,285.12),(5,'1899-12-30 00:00:00',2,141.68);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidoitens`
--

DROP TABLE IF EXISTS `pedidoitens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidoitens` (
  `PedidoId` int NOT NULL,
  `ItemId` int NOT NULL,
  `CodProduto` varchar(50) DEFAULT NULL,
  `DescProduto` varchar(100) DEFAULT NULL,
  `Quantidade` int DEFAULT NULL,
  `ValorUnitario` decimal(10,2) DEFAULT NULL,
  `ValorTotal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`PedidoId`,`ItemId`),
  CONSTRAINT `pedidoitens_ibfk_1` FOREIGN KEY (`PedidoId`) REFERENCES `pedido` (`PedidoId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidoitens`
--

LOCK TABLES `pedidoitens` WRITE;
/*!40000 ALTER TABLE `pedidoitens` DISABLE KEYS */;
INSERT INTO `pedidoitens` VALUES (3,1,'00000007','00000007 - Açai 450g',2,40.55,81.10),(3,2,'00000003','00000003 - Feijão Carioca',5,5.66,28.30),(3,3,'00000011','00000011 - Vinho Seco Garrafa Chile',6,60.55,363.30),(4,1,'00000012','00000012 - Queijo Parme',12,16.88,202.56),(4,2,'00000006','00000006 - Extrato de Tomate Zica',12,6.88,82.56),(5,1,'00000015','00000015 - Bolo de Fubá',11,12.88,141.68);
/*!40000 ALTER TABLE `pedidoitens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tab_cliente`
--

DROP TABLE IF EXISTS `tab_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tab_cliente` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) NOT NULL,
  `cidade` varchar(60) NOT NULL,
  `uf` varchar(2) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `idcliente_UNIQUE` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tab_cliente`
--

LOCK TABLES `tab_cliente` WRITE;
/*!40000 ALTER TABLE `tab_cliente` DISABLE KEYS */;
INSERT INTO `tab_cliente` VALUES (1,'João Maria','São Paulo','SP'),(2,'Tainá Guimarães','São Paulo','SP'),(3,'Maria Thereza','São Paulo','SP'),(4,'Paulo Souza','Campinas','SP'),(5,'Marcos Silva','Santos','SP'),(6,'Janete Pereira','São Paulo','SP'),(7,'Hilda Furacão','São Paulo','SP'),(8,'Nazaré Tedesco','Rio de Janeiro','RJ'),(9,'Maria do Carmo','Vila Nova','PE'),(10,'Tomaz Tadeu','Curitiba','PR'),(11,'Tião Galinha','São Paulo','SP'),(12,'José Venancio','Lençois','BA'),(13,'Mike Silva','São Paulo','SP'),(14,'Maria Bethania','Santo Amaro da Purificaçã','BA'),(15,'Gal Costa','Salvador','BA'),(16,'Caetano Veloso','Santo Amaro da Purificação','BA'),(17,'Ivete Sangalo','Juazeiro','BA'),(18,'Beijamin Contant','São Paulo','SP'),(19,'Tom Jobim','Rio de Janeiro','RJ'),(20,'João Bosco','Rio de Janeiro','RJ');
/*!40000 ALTER TABLE `tab_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tab_produto`
--

DROP TABLE IF EXISTS `tab_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tab_produto` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(60) NOT NULL,
  `preco_venda` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tab_produto`
--

LOCK TABLES `tab_produto` WRITE;
/*!40000 ALTER TABLE `tab_produto` DISABLE KEYS */;
INSERT INTO `tab_produto` VALUES (1,'Arroz Tio João',10.55),(2,'Arroz Camil',9.99),(3,'Feijão Carioca',5.66),(4,'Feijão Comum',6.00),(5,'Macarrão',4.33),(6,'Extrato de Tomate Zica',6.88),(7,'Açai 450g',40.55),(8,'Suco Laranja',16.88),(9,'Suco Uva 10ml',10.22),(10,'Skol Lata',4.88),(11,'Vinho Seco Garrafa Chile',60.55),(12,'Queijo Parme',16.88),(13,'Queijo Frescal',15.99),(14,'Pão Françês  500gr',10.88),(15,'Bolo de Fubá',12.88),(16,'Nuggets Recheio Queijo',13.22),(17,'Suco Manga 500ml',6.99),(18,'Sabonete',3.33),(19,'Raçao Dog',150.99),(20,'Sorvete Coco 500g',38.77);
/*!40000 ALTER TABLE `tab_produto` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-07 18:53:42
