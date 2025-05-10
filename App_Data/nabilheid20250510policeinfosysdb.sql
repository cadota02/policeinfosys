-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               8.0.41 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for policeinfosysdb
CREATE DATABASE IF NOT EXISTS `policeinfosysdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `policeinfosysdb`;

-- Dumping structure for table policeinfosysdb.chargeslist
CREATE TABLE IF NOT EXISTS `chargeslist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `chargename` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `isactive` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table policeinfosysdb.chargeslist: ~3 rows (approximately)
INSERT INTO `chargeslist` (`id`, `chargename`, `price`, `isactive`) VALUES
	(2, 'Application of Police Clearance', 250.00, 1),
	(3, 'Penalty Fee', 500.00, 1),
	(4, 'Certified Thru Copy of Clearance', 50.00, 1);

-- Dumping structure for table policeinfosysdb.complaintactions
CREATE TABLE IF NOT EXISTS `complaintactions` (
  `ActionID` int NOT NULL AUTO_INCREMENT,
  `ComplaintID` int DEFAULT NULL,
  `ActionTaken` varchar(100) DEFAULT NULL,
  `Remarks` text,
  `ActionBy` varchar(100) DEFAULT NULL,
  `ActionDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ActionID`),
  KEY `ComplaintID` (`ComplaintID`),
  CONSTRAINT `complaintactions_ibfk_1` FOREIGN KEY (`ComplaintID`) REFERENCES `complaints` (`ComplaintID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table policeinfosysdb.complaintactions: ~9 rows (approximately)
INSERT INTO `complaintactions` (`ActionID`, `ComplaintID`, `ActionTaken`, `Remarks`, `ActionBy`, `ActionDate`) VALUES
	(1, 1, 'Reviewed', 'sadada', 'ta', '2025-04-16 11:49:47'),
	(2, 3, 'Reviewed', 'test123', 'tes', '2025-04-16 12:15:09'),
	(3, 1, 'Investigating', 'sadadadasd', 'tes', '2025-04-16 12:19:06'),
	(4, 6, 'Reviewed', 'adada', 'asd', '2025-05-10 13:30:56'),
	(5, 7, 'Pending', 'xxx', 'x', '2025-05-10 13:34:00'),
	(6, 7, 'Moved to RTC', 'adad', 'asd', '2025-05-10 13:34:14'),
	(7, 7, 'Rescheduled', 'adad', 'asd', '2025-05-10 13:35:29'),
	(8, 7, 'Investigating', 'adsaddadad', 'asda', '2025-05-10 13:41:10'),
	(9, 8, 'Dismissed', 'dasdsadadadadsadsads', 'asda', '2025-05-10 13:42:23');

-- Dumping structure for table policeinfosysdb.complaints
CREATE TABLE IF NOT EXISTS `complaints` (
  `ComplaintID` int NOT NULL AUTO_INCREMENT,
  `FullName` varchar(100) DEFAULT NULL,
  `Contact` varchar(50) DEFAULT NULL,
  `BriefDetails` text,
  `PlaceOccurrence` varchar(100) DEFAULT NULL,
  `Category` varchar(50) DEFAULT NULL,
  `Status` enum('Pending','Reviewed','Investigating','Resolved','Dismissed') DEFAULT 'Pending',
  `EvidenceImage` varchar(255) DEFAULT NULL,
  `DateFiled` datetime DEFAULT CURRENT_TIMESTAMP,
  `userid` int DEFAULT '0',
  PRIMARY KEY (`ComplaintID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table policeinfosysdb.complaints: ~7 rows (approximately)
INSERT INTO `complaints` (`ComplaintID`, `FullName`, `Contact`, `BriefDetails`, `PlaceOccurrence`, `Category`, `Status`, `EvidenceImage`, `DateFiled`, `userid`) VALUES
	(1, 'asds', 'adadad', 'asdsadadasd', 'dadad', 'Vandalism', 'Investigating', '~/Content/images/complaint/evidence_638803976809777372.JPG', '2025-04-16 10:54:41', 0),
	(3, 'cc', 'cc', 'aac', 'ccc', 'Theft', 'Reviewed', '~/Content/images/complaint/evidence_638804021150636007.JPG', '2025-04-16 12:08:35', 0),
	(6, 'xxxx', 'xxx', 'xxxxxxx', 'xx', 'Vandalism', 'Reviewed', '~/Content/images/complaint/evidence_638824806013442502.JPG', '2025-05-10 13:30:01', 7),
	(7, 'zz', 'zz', 'zxasd', 'zz', 'Theft', 'Investigating', '~/Content/images/complaint/evidence_638824808287616853.JPG', '2025-05-10 13:33:48', 7),
	(8, 'ggg', 'ggg', 'asdadada', 'ggg', 'Theft', 'Dismissed', '~/Content/images/complaint/evidence_638824813232600749.png', '2025-05-10 13:42:03', 7),
	(9, 'HFDG', 'DFGDG', 'GJGJGJ', 'DFGFD', 'DomesticViolence', 'Pending', '~/Content/images/complaint/evidence_638824817647196820.PNG', '2025-05-10 13:49:24', 0),
	(11, 'NELSON A. MENDEZ', '091232131', 'asdasd', 'asda', 'Vandalism', 'Pending', '~/Content/images/complaint/evidence_638824845437272349.jpg', '2025-05-10 14:35:43', 10);

-- Dumping structure for table policeinfosysdb.invoice
CREATE TABLE IF NOT EXISTS `invoice` (
  `invid` int NOT NULL AUTO_INCREMENT,
  `invoiceno` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `invoicedate` date NOT NULL,
  `customerid` varchar(45) NOT NULL,
  `remarks` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `cash` decimal(10,2) DEFAULT '0.00',
  `change` decimal(10,2) DEFAULT '0.00',
  `refno` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`invid`),
  UNIQUE KEY `invoiceno_UNIQUE` (`invoiceno`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table policeinfosysdb.invoice: ~10 rows (approximately)
INSERT INTO `invoice` (`invid`, `invoiceno`, `invoicedate`, `customerid`, `remarks`, `cash`, `change`, `refno`) VALUES
	(2, 'INV-16595477', '2025-05-08', 'Walk-in', 'z', 1500.00, 0.00, ''),
	(3, 'INV-32666927', '2025-05-08', 'Walk-in', '', 1000.00, 0.00, ''),
	(4, 'INV-11169426', '2025-05-08', 'Walk-in', '', 0.00, 0.00, ''),
	(5, 'INV-79668908', '2025-05-08', 'Walk-in', '', 0.00, 0.00, ''),
	(8, 'INV-23041050', '2025-05-09', 'Walk-in', '', 2000.00, 500.00, ''),
	(9, 'INV-85932987', '2025-05-09', 'Walk-in', '', 0.00, 0.00, ''),
	(10, 'INV-84373966', '2025-05-09', 'RICARDO D. MAGTANGGOL', '', 500.00, 500.00, ''),
	(11, 'BN-76763943', '2025-05-09', 'Walk-in', '', 1000.00, 250.00, ''),
	(12, 'BN-02175124', '2025-05-10', 'MANALYN B. SALCEDO', 'test', 1000.00, 650.00, ''),
	(13, 'BN-91689458', '2025-05-10', 'MANALYN B. SALCEDO', '', 5000.00, 5000.00, '');

-- Dumping structure for table policeinfosysdb.invoicecart
CREATE TABLE IF NOT EXISTS `invoicecart` (
  `cartid` int NOT NULL AUTO_INCREMENT,
  `invid` int DEFAULT NULL,
  `chargename` varchar(45) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `datelog` datetime DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `chrgid` int DEFAULT NULL,
  PRIMARY KEY (`cartid`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table policeinfosysdb.invoicecart: ~17 rows (approximately)
INSERT INTO `invoicecart` (`cartid`, `invid`, `chargename`, `price`, `datelog`, `qty`, `chrgid`) VALUES
	(10, 2, 'Certified Thru Copy of Clearance', 50.00, '2025-05-08 23:38:24', 2, NULL),
	(11, 4, 'Certified Thru Copy of Clearance', 50.00, '2025-05-08 23:04:16', 2, NULL),
	(12, 5, 'Certified Thru Copy of Clearance', 50.00, '2025-05-08 23:04:35', 1, NULL),
	(17, 2, 'Application of Police Clearance', 250.00, '2025-05-08 23:39:01', 1, NULL),
	(27, 8, 'Application of Police Clearance', 250.00, '2025-05-09 20:06:18', 2, NULL),
	(28, 8, 'Penalty Fee', 500.00, '2025-05-09 20:07:09', 2, NULL),
	(29, 9, 'Certified Thru Copy of Clearance', 50.00, '2025-05-09 20:07:24', 1, NULL),
	(30, 9, 'Penalty Fee', 500.00, '2025-05-09 20:07:32', 2, NULL),
	(31, 10, 'Application of Police Clearance', 250.00, '2025-05-09 20:10:03', 1, NULL),
	(32, 10, 'Penalty Fee', 500.00, '2025-05-09 20:09:55', 1, NULL),
	(33, 11, 'Application of Police Clearance', 250.00, '2025-05-09 21:04:00', 2, NULL),
	(34, 11, 'Certified Thru Copy of Clearance', 50.00, '2025-05-09 21:04:17', 5, NULL),
	(35, 12, 'Application of Police Clearance', 250.00, '2025-05-10 09:47:50', 1, NULL),
	(36, 12, 'Certified Thru Copy of Clearance', 50.00, '2025-05-10 09:47:56', 2, NULL),
	(37, 13, 'Application of Police Clearance', 250.00, '2025-05-10 11:19:44', 2, NULL),
	(38, 13, 'Certified Thru Copy of Clearance', 50.00, '2025-05-10 11:19:51', 1, NULL),
	(39, 13, 'Application of Police Clearance', 250.00, '2025-05-10 13:47:25', 3, NULL);

-- Dumping structure for table policeinfosysdb.officers
CREATE TABLE IF NOT EXISTS `officers` (
  `OfficerID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `MiddleName` varchar(100) DEFAULT NULL,
  `Position` varchar(100) NOT NULL,
  `PRank` varchar(100) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `ContactNo` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Content` text,
  `ImagePath` varchar(255) DEFAULT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT '1',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`OfficerID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table policeinfosysdb.officers: ~4 rows (approximately)
INSERT INTO `officers` (`OfficerID`, `FirstName`, `LastName`, `MiddleName`, `Position`, `PRank`, `Address`, `ContactNo`, `Email`, `Content`, `ImagePath`, `IsActive`, `CreatedAt`, `UpdatedAt`) VALUES
	(1, 'TANGGOL', 'BABAL', 'A', 'KUPAL', 'MYTHIC', 'TAMONTAKA, COTABATO CITY', '09123131321', 'test@gmail.com', 'SCAMMER', '~/Content/images/officers/avatar04.png', 1, '2025-04-15 08:38:04', '2025-04-16 02:04:56'),
	(3, 'CARDO', 'DALISAY', 'a', 'PATROL OFFICER 3', 'PO3', 'COTABATO CITY', '081231313', 'cardo@gmail.com', 'about me here', '~/Content/images/officers/avatar5.png', 1, '2025-04-16 01:58:33', '2025-04-16 01:58:33'),
	(4, 'NICOLAS', 'TORRE', 'B', 'CIDG CHIEF OF POLICE', 'BG. GENERAL III', 'ASDSADAD', '0912313132', 'TORRE@GMAIL.COM', 'ASDSADADAD', '~/Content/images/officers/user1-128x128.jpg', 1, '2025-04-16 01:59:45', '2025-04-16 01:59:45'),
	(5, 'BATO', 'DELA ROSA', 'S', 'PNP CHIEF', 'GENERAL V', 'ASDADADS', '131313', '2131313@GMAIL.COM', 'ATEST', '~/Content/images/officers/avatar.png', 1, '2025-04-16 02:00:53', '2025-04-16 04:21:30');

-- Dumping structure for table policeinfosysdb.policeclearance
CREATE TABLE IF NOT EXISTS `policeclearance` (
  `ClearanceID` int NOT NULL AUTO_INCREMENT,
  `FullName` varchar(100) NOT NULL,
  `Sex` varchar(10) DEFAULT NULL,
  `DOB` date NOT NULL,
  `Address` varchar(255) NOT NULL,
  `ValidIDType` varchar(50) NOT NULL,
  `ValidID` varchar(100) NOT NULL,
  `ValidIDFilePath` varchar(255) DEFAULT NULL,
  `Purpose` varchar(100) NOT NULL,
  `Status` enum('Pending','Approved','Disapproved','Released') DEFAULT 'Pending',
  `ClearanceNo` varchar(20) DEFAULT NULL,
  `DateFiled` datetime DEFAULT CURRENT_TIMESTAMP,
  `DateStatus` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `preparedby` varchar(100) DEFAULT NULL,
  `approvedby` varchar(100) DEFAULT NULL,
  `userid` int DEFAULT '0',
  `finalaction` tinyint DEFAULT '0',
  PRIMARY KEY (`ClearanceID`),
  UNIQUE KEY `ClearanceNo` (`ClearanceNo`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table policeinfosysdb.policeclearance: ~18 rows (approximately)
INSERT INTO `policeclearance` (`ClearanceID`, `FullName`, `Sex`, `DOB`, `Address`, `ValidIDType`, `ValidID`, `ValidIDFilePath`, `Purpose`, `Status`, `ClearanceNo`, `DateFiled`, `DateStatus`, `preparedby`, `approvedby`, `userid`, `finalaction`) VALUES
	(2, 'SAMRAH LAASDAD SADADADS', 'FEMALE', '2025-04-16', 'ASDSADAD', 'GSIS', '123123131', 'Content/images/clearance/5c926b0f-809b-4ffb-a45a-200fde46bc68.PNG', 'ASDADADADSA', 'Pending', 'PCLR-2025-0002', '2025-04-16 21:36:10', '2025-04-16 21:36:10', NULL, NULL, 0, NULL),
	(3, 'SAMPLE FULLNAME JR', 'MALE', '1991-01-01', 'CURRENT ADDRESS COTABATO CITY, PH', 'Driver\'s License', '421-0912313-232131', 'Content/images/clearance/76ac151e-c024-46dd-9844-b9b55fd007d3.JPG', 'TEST PURPOSE OFFICE WORK', 'Pending', 'PCLR-2025-0003', '2025-04-16 21:42:32', '2025-04-16 21:42:32', NULL, NULL, 0, NULL),
	(4, 'SAMRAH LAASDAD SADADADS', 'FEMALE', '1991-01-01', 'adsada', 'SSS', '12313', 'Content/images/clearance/84b3f440-7ea7-4022-877e-ff6b14360d32.PNG', '', 'Pending', 'PCLR-2025-0004', '2025-04-16 21:48:40', '2025-04-16 23:52:31', '', '', 0, NULL),
	(5, 'asdada', 'FEMALE', '2025-04-16', 'asdsad', 'SSS', '1231313', 'Content/images/clearance/4c46b33a-a1a7-4459-9064-c1b0cb53e8f3.PNG', 'asdadadad', 'Pending', 'PCLR-2025-0005', '2025-04-16 21:51:18', '2025-04-16 21:51:18', NULL, NULL, 0, NULL),
	(6, 'asda', 'FEMALE', '2025-04-15', 'asdada', 'Passport', 'asdada', 'Content/images/clearance/fe9cab98-8425-40f1-9991-6d0ab2396ef6.JPG', 'asdadadadada', 'Pending', 'PCLR-2025-0006', '2025-04-16 21:59:12', '2025-04-16 21:59:12', NULL, NULL, 0, NULL),
	(8, 'asda', 'FEMALE', '2025-04-15', 'asdada', 'SSS', 'sdassda', 'Content/images/clearance/0e143ce9-7fe9-4e77-ba59-c5cd4cdd9d0e.PNG', 'asdad', 'Approved', 'PCLR-2025-0008', '2025-04-16 22:03:42', '2025-04-16 22:47:20', NULL, NULL, 0, NULL),
	(9, 'adsad adsad asdad atest', 'FEMALE', '2025-04-16', 'adadtasad test', 'SSS', '123131', 'Content/images/clearance/326b6693-d1ce-4a7a-a32e-2475d66b2a57.PNG', 'asdadada asdsad a dsada asdadsadsadadas', 'Released', 'PCLR-2025-0009', '2025-04-16 23:31:42', '2025-04-16 23:35:13', 'prepared1231313', 'approved12313213', 0, NULL),
	(10, 'RICARDO D. MAGTANGGOL', 'MALE', '1991-01-01', 'STA. ISABEL, ROSRAY HEIGHTS VIII', 'GSIS', '0123131321', 'Content/images/clearance/aa8dc233-009f-46f3-bf62-840578896204.PNG', 'TEST PURPOSE OFFICE WORK', 'Disapproved', 'PCLR-2025-0010', '2025-05-04 13:37:16', '2025-05-10 10:55:42', '', '', 0, 1),
	(11, 'MANALYN B. SALCEDO', 'FEMALE', '1991-04-27', 'ASDAD', 'Driver\'s License', '1231313', 'Content/images/clearance/f589b851-29e6-455b-b4dc-20be3d7ab985.PNG', 'ASDADA', 'Pending', 'PCLR-2025-0011', '2025-05-04 13:41:28', '2025-05-04 13:41:28', NULL, NULL, 0, NULL),
	(12, 'zzzzz z. zzzzzzzz', 'MALE', '2025-05-05', 'asdada', 'GSIS', '12313131', 'Content/images/clearance/6c6b3a0c-ffc3-49c3-a831-716c6180dedb.PNG', 'asdadadad', 'Approved', 'PCLR-2025-0012', '2025-05-04 14:20:03', '2025-05-04 16:13:59', 'asda', 'dadad', 7, NULL),
	(13, 'user2asdasdsad d. adas', 'MALE', '2025-04-28', 'asd', 'SSS', '1231312', 'Content/images/clearance/33246fc9-1836-475d-aee7-d6bf0d3d333e.PNG', 'xxxzzzzzzz zxczcz', 'Released', 'PCLR-2025-0013', '2025-05-04 16:05:16', '2025-05-04 16:15:45', 'asda', 'dadad', 7, NULL),
	(14, 'vvvvvv v. zz', 'MALE', '2025-04-29', 'vvvvvvv', 'GSIS', 'vvvvvvvvvvvv', 'Content/images/clearance/cc21a211-db5d-483b-b660-313289858199.PNG', 'vvvvvvvvvvvvvv', 'Pending', 'PCLR-2025-0014', '2025-05-04 16:07:01', '2025-05-04 16:07:01', NULL, NULL, 8, NULL),
	(17, 'zzzzzzzzzzzz333333 3. 3', '', '2025-04-28', '3333333', 'GSIS', '333333333333', 'Content/images/clearance/751ebfa8-8aa3-46cb-93f6-b679cf2ee24e.PNG', '333333333333333333333333', 'Disapproved', 'PCLR-2025-0017', '2025-05-04 17:26:23', '2025-05-10 11:00:34', '', '', 7, 2),
	(18, 'gggg g. gggggggggg', 'FEMALE', '2025-05-11', 'gg', 'UMID', 'gg', 'Content/images/clearance/759657c6-159d-4066-88dd-431869afb108.JPG', 'gggggggggggggg g gggggg', 'Approved', 'PCLR-2025-0018', '2025-05-04 18:16:43', '2025-05-10 09:38:42', '', '', 7, NULL),
	(19, 'asd a. adad', 'MALE', '2025-05-11', 'asda', 'UMID', '12313', 'Content/images/clearance/78b9ed2b-8371-457d-81d0-c5feee664051.JPG', 'asdadsadadadad', 'Disapproved', 'PCLR-2025-0019', '2025-05-10 10:04:34', '2025-05-10 10:17:21', '', '', 7, 1),
	(20, 'RICARDO D. MAGTANGGOL', 'MALE', '1991-01-01', 'ADSA', 'GSIS', '12313', 'Content/images/clearance/e85b7d7a-1cca-40ff-bc8d-42aa69efaa06.JPG', 'ASDASDADADADAD', 'Pending', 'PCLR-2025-0020', '2025-05-10 10:52:48', '2025-05-10 10:56:01', '', '', 0, 0),
	(21, 'xx x. xxx', 'MALE', '2025-05-10', 'adasd', 'UMID', '12313', 'Content/images/clearance/4228356a-546a-4ae0-af2f-0f48368d58bb.PNG', 'asdadasaadadad', 'Pending', 'PCLR-2025-0021', '2025-05-10 12:28:09', '2025-05-10 12:30:44', NULL, NULL, 7, 0),
	(22, 'NELSON A. MENDEZ', 'MALE', '2025-05-09', 'asdadad, coatabato city', 'UMID', '12313', 'Content/images/clearance/784cbb90-0efa-4178-bdb9-47c6605e64d1.jpg', 'asdasd', 'Pending', 'PCLR-2025-0022', '2025-05-10 14:35:14', '2025-05-10 14:35:14', NULL, NULL, 10, 0);

-- Dumping structure for table policeinfosysdb.users
CREATE TABLE IF NOT EXISTS `users` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Firstname` varchar(255) DEFAULT NULL,
  `Lastname` varchar(255) DEFAULT NULL,
  `Middlename` varchar(255) DEFAULT NULL,
  `UserPosition` varchar(255) DEFAULT NULL,
  `Username` varchar(100) DEFAULT NULL,
  `PasswordHash` varchar(255) DEFAULT NULL,
  `Address` text,
  `ContactNo` varchar(15) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Role` enum('Admin','Client','Cashier') DEFAULT 'Client',
  `IsApproved` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Dumping data for table policeinfosysdb.users: ~6 rows (approximately)
INSERT INTO `users` (`ID`, `Firstname`, `Lastname`, `Middlename`, `UserPosition`, `Username`, `PasswordHash`, `Address`, `ContactNo`, `Email`, `Role`, `IsApproved`) VALUES
	(2, 'AdminFirst', 'AdminLast', 'AdminMI', 'Administrator', 'admin', '$2a$11$QehzB03I0n5VvdfNn8a4Ke8QqQDO1xY/GtunW5LlMGdPtxjLxMrvq', '', '09123213', 'admin@example.com', 'Admin', 1),
	(3, 'RICARDO', 'MAGTANGGOL', 'DALIDAY', 'Citizen', 'user1', '$2a$11$z3/giHoAeB2CJr1yP7O3duqANIDINgP/9NJ3qXb9KSriSMnQKQw/G', 'STA. ISABEL, ROSRAY HEIGHTS VIII', '', '', 'Client', 0),
	(7, 'zzzzz', 'zzzzzzzz', 'zzzzzzz', 'Citizen', 'user2', '$2a$11$Mc4/Zu/jiSbPRCKFUL90z.bxyKbhbaq5d4aiC9NTfr9AAkoXjtGi.', 'asdada', '', '', 'Client', 1),
	(8, 'vvvvvv', 'zz', 'vvvvvvvvvv', 'Citizen', 'vvv', '$2a$11$OGFEXZXNJV9zukzzxvdeluZhxRxPJ9F2oBQ65PsYHD1CTN7oOb0Tu', 'vvvvvvv', '', '', 'Client', 0),
	(9, 'MARIA OLIVIA', 'SANDATA', 'MANALO', 'Cashier', 'cashier1', '$2a$11$reKh1mM09Qs1lurHjMuHKuavHceYXTpfO/f3SVTxf9Jw8Utd0GUbu', 'asdasda', '0912313131', 'cashier1@gmail.com', 'Cashier', 1),
	(10, 'NELSON', 'MENDEZ', 'ANTONIO', 'NONE', 'nelson', '$2a$11$.3S2uSnjX405Zvovzq0amOen2AUu2B4PxD7hKBPojMCV/4qH/Bu0G', 'asdadad, coatabato city', '091232131', 'nelson01@gmail.com', 'Client', 1);

-- Dumping structure for view policeinfosysdb.vw_invoice
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_invoice` (
	`invid` INT NULL,
	`invoiceno` VARCHAR(1) NULL COLLATE 'utf8mb3_general_ci',
	`invoicedate` DATE NULL,
	`customerid` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`remarks` VARCHAR(1) NULL COLLATE 'utf8mb3_general_ci',
	`cash` DECIMAL(10,2) NULL,
	`change` DECIMAL(10,2) NULL,
	`refno` VARCHAR(1) NULL COLLATE 'utf8mb3_general_ci',
	`amount` DECIMAL(42,2) NULL
) ENGINE=MyISAM;

-- Dumping structure for view policeinfosysdb.vw_invoicereport
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_invoicereport` (
	`cartid` INT NOT NULL,
	`invid` INT NULL,
	`chargename` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`price` DECIMAL(10,2) NULL,
	`datelog` DATETIME NULL,
	`qty` INT NULL,
	`chrgid` INT NULL,
	`invoiceno` VARCHAR(1) NULL COLLATE 'utf8mb3_general_ci',
	`customerid` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`invoicedate` DATE NULL,
	`amount` DECIMAL(20,2) NULL
) ENGINE=MyISAM;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_invoice`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_invoice` AS select `a`.`invid` AS `invid`,`a`.`invoiceno` AS `invoiceno`,`a`.`invoicedate` AS `invoicedate`,`a`.`customerid` AS `customerid`,`a`.`remarks` AS `remarks`,`a`.`cash` AS `cash`,`a`.`change` AS `change`,`a`.`refno` AS `refno`,(select sum((`b`.`qty` * `b`.`price`)) from `invoicecart` `b` where (`b`.`invid` = `a`.`invid`)) AS `amount` from `invoice` `a`
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_invoicereport`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_invoicereport` AS select `a`.`cartid` AS `cartid`,`a`.`invid` AS `invid`,`a`.`chargename` AS `chargename`,`a`.`price` AS `price`,`a`.`datelog` AS `datelog`,`a`.`qty` AS `qty`,`a`.`chrgid` AS `chrgid`,`b`.`invoiceno` AS `invoiceno`,`b`.`customerid` AS `customerid`,`b`.`invoicedate` AS `invoicedate`,(`a`.`price` * `a`.`qty`) AS `amount` from (`invoicecart` `a` left join `invoice` `b` on((`b`.`invid` = `a`.`invid`)))
;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
