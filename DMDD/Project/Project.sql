-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Hospital
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Hospital
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Hospital` DEFAULT CHARACTER SET utf8 ;
USE `Hospital` ;

-- -----------------------------------------------------
-- Table `Hospital`.`Doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Doctors` (
  `EmpID` INT NOT NULL AUTO_INCREMENT,
  `DoctorsFN` VARCHAR(50) NOT NULL,
  `DoctorsLN` VARCHAR(50) NOT NULL,
  `DoctorsAge` VARCHAR(45) NOT NULL,
  `EmpDeptNo` CHAR(1) NOT NULL,
  PRIMARY KEY (`EmpID`));


-- -----------------------------------------------------
-- Table `Hospital`.`Nurse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Nurse` (
  `EmpId` INT NOT NULL,
  `Nurse_FN` VARCHAR(50) NOT NULL,
  `Nurse_LN` VARCHAR(50) NOT NULL,
  `Nurse_Age` INT NOT NULL,
  PRIMARY KEY (`EmpId`),
  UNIQUE INDEX `EmpId_UNIQUE` (`EmpId` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `Hospital`.`Room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Room` (
  `idRoom` INT NOT NULL AUTO_INCREMENT,
  `idBed` INT NOT NULL,
  `Nurse_Nurse_ID` INT NOT NULL,
  PRIMARY KEY (`idRoom`, `idBed`, `Nurse_Nurse_ID`),
  UNIQUE INDEX `idBed_UNIQUE` (`idBed` ASC) VISIBLE,
  INDEX `fk_Room_Nurse1_idx` (`Nurse_Nurse_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Room_Nurse1`
    FOREIGN KEY (`Nurse_Nurse_ID`)
    REFERENCES `Hospital`.`Nurse` (`EmpId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Hospital`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Patient` (
  `idPatient` INT NOT NULL AUTO_INCREMENT,
  `PatientFN` VARCHAR(45) NOT NULL,
  `PatientLN` VARCHAR(45) NOT NULL,
  `PatientAge` INT NOT NULL,
  `PatientDate_Of_Birth` DATE NOT NULL,
  `Patient_Sex` VARCHAR(1) NOT NULL COMMENT 'M: Male\nF: Female',
  `Room_idRoom` INT NOT NULL,
  `Room_idBed` INT NOT NULL,
  PRIMARY KEY (`idPatient`),
  INDEX `fk_Patient_Room1_idx` (`Room_idRoom` ASC, `Room_idBed` ASC) VISIBLE,
  CONSTRAINT `fk_Patient_Room1`
    FOREIGN KEY (`Room_idRoom` , `Room_idBed`)
    REFERENCES `Hospital`.`Room` (`idRoom` , `idBed`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Hospital`.`Doctors_consults_Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Doctors_consults_Patient` (
  `Doctors_idDoctors` INT NOT NULL,
  `Patient_idPatient` INT NOT NULL,
  PRIMARY KEY (`Doctors_idDoctors`, `Patient_idPatient`),
  INDEX `fk_Doctors_has_Patient_Patient1_idx` (`Patient_idPatient` ASC) VISIBLE,
  INDEX `fk_Doctors_has_Patient_Doctors_idx` (`Doctors_idDoctors` ASC) VISIBLE,
  CONSTRAINT `fk_Doctors_has_Patient_Doctors`
    FOREIGN KEY (`Doctors_idDoctors`)
    REFERENCES `Hospital`.`Doctors` (`EmpID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctors_has_Patient_Patient1`
    FOREIGN KEY (`Patient_idPatient`)
    REFERENCES `Hospital`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Hospital`.`Patient_Contact_Information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Patient_Contact_Information` (
  `Patient_idPatient` INT NOT NULL,
  `Primary Number` CHAR(10) NOT NULL,
  `Secondary Number` CHAR(10) NULL,
  `Street Line 1` VARCHAR(100) NOT NULL,
  `Steet Line 2` VARCHAR(10) NOT NULL,
  `State` VARCHAR(2) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `Email ID` VARCHAR(100) NOT NULL,
  UNIQUE INDEX `Primary Number_UNIQUE` (`Primary Number` ASC) VISIBLE,
  UNIQUE INDEX `Secondary Number_UNIQUE` (`Secondary Number` ASC) VISIBLE,
  UNIQUE INDEX `Email ID_UNIQUE` (`Email ID` ASC) VISIBLE,
  CONSTRAINT `fk_Patient_Contact_Information_Patient1`
    FOREIGN KEY (`Patient_idPatient`)
    REFERENCES `Hospital`.`Patient` (`idPatient`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Hospital`.`Lab Assistant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Lab Assistant` (
  `EmpID` INT NOT NULL,
  `LA_FN` VARCHAR(45) NOT NULL,
  `LA_LN` VARCHAR(45) NOT NULL,
  `LA_Age` INT NOT NULL,
  PRIMARY KEY (`EmpID`),
  UNIQUE INDEX `EmpID_UNIQUE` (`EmpID` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `Hospital`.`Accountant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Accountant` (
  `EmpId` INT NOT NULL,
  `AccountantFN` VARCHAR(50) NOT NULL,
  `AccountantLN` VARCHAR(50) NOT NULL,
  `Age` INT NOT NULL,
  PRIMARY KEY (`EmpId`),
  UNIQUE INDEX `EmpId_UNIQUE` (`EmpId` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `Hospital`.`Employee Contact Info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Employee Contact Info` (
  `Email ID` VARCHAR(100) NOT NULL,
  `Doctors_EmpID` INT NOT NULL,
  `Lab Assistant_EmpID` INT NOT NULL,
  `Nurse_EmpId` INT NOT NULL,
  `Accountant_EmpId` INT NOT NULL,
  `Primary Number` CHAR(10) NOT NULL,
  `Secondary Number` CHAR(10) NULL,
  `Street Line 1` VARCHAR(100) NOT NULL,
  `Street Line 2` VARCHAR(100) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Email ID`, `Doctors_EmpID`, `Lab Assistant_EmpID`, `Nurse_EmpId`, `Accountant_EmpId`),
  INDEX `fk_Employee Contact Info_Doctors1_idx` (`Doctors_EmpID` ASC) VISIBLE,
  INDEX `fk_Employee Contact Info_Lab Assistant1_idx` (`Lab Assistant_EmpID` ASC) VISIBLE,
  INDEX `fk_Employee Contact Info_Nurse1_idx` (`Nurse_EmpId` ASC) VISIBLE,
  INDEX `fk_Employee Contact Info_Accountant1_idx` (`Accountant_EmpId` ASC) VISIBLE,
  CONSTRAINT `fk_Employee Contact Info_Doctors1`
    FOREIGN KEY (`Doctors_EmpID`)
    REFERENCES `Hospital`.`Doctors` (`EmpID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee Contact Info_Lab Assistant1`
    FOREIGN KEY (`Lab Assistant_EmpID`)
    REFERENCES `Hospital`.`Lab Assistant` (`EmpID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee Contact Info_Nurse1`
    FOREIGN KEY (`Nurse_EmpId`)
    REFERENCES `Hospital`.`Nurse` (`EmpId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee Contact Info_Accountant1`
    FOREIGN KEY (`Accountant_EmpId`)
    REFERENCES `Hospital`.`Accountant` (`EmpId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Hospital`.`Operation Theatre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Operation Theatre` (
  `idOperation Theatre` INT NOT NULL AUTO_INCREMENT,
  `Operation_Theatre_Name` VARCHAR(50) NOT NULL,
  `Patient_idPatient` INT NOT NULL,
  `Doctors_idDoctors` INT NOT NULL,
  `Lab Assistant_LA_ID` INT NOT NULL,
  INDEX `fk_Operation Theatre_Lab Assistant1_idx` (`Lab Assistant_LA_ID` ASC) VISIBLE,
  PRIMARY KEY (`idOperation Theatre`, `Patient_idPatient`, `Doctors_idDoctors`, `Lab Assistant_LA_ID`),
  INDEX `fk_Operation Theatre_Doctors1_idx` (`Doctors_idDoctors` ASC) VISIBLE,
  UNIQUE INDEX `Operation_Theatre_Name_UNIQUE` (`Operation_Theatre_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Operation Theatre_Patient1`
    FOREIGN KEY (`Patient_idPatient`)
    REFERENCES `Hospital`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Operation Theatre_Lab Assistant1`
    FOREIGN KEY (`Lab Assistant_LA_ID`)
    REFERENCES `Hospital`.`Lab Assistant` (`EmpID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Operation Theatre_Doctors1`
    FOREIGN KEY (`Doctors_idDoctors`)
    REFERENCES `Hospital`.`Doctors` (`EmpID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Hospital`.`Pharmacy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Pharmacy` (
  `idPharmacy` INT NOT NULL,
  `Pharmacy Name` VARCHAR(45) NOT NULL,
  `Patient_idPatient` INT NOT NULL,
  `Doctors_EmpID` INT NOT NULL,
  PRIMARY KEY (`Patient_idPatient`, `Doctors_EmpID`),
  INDEX `fk_Pharmacy_Patient1_idx` (`Patient_idPatient` ASC) VISIBLE,
  UNIQUE INDEX `Patient_idPatient_UNIQUE` (`Patient_idPatient` ASC) VISIBLE,
  INDEX `fk_Pharmacy_Doctors1_idx` (`Doctors_EmpID` ASC) VISIBLE,
  CONSTRAINT `fk_Pharmacy_Patient1`
    FOREIGN KEY (`Patient_idPatient`)
    REFERENCES `Hospital`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pharmacy_Doctors1`
    FOREIGN KEY (`Doctors_EmpID`)
    REFERENCES `Hospital`.`Doctors` (`EmpID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Hospital`.`Medicines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Medicines` (
  `idMedicines` INT NOT NULL,
  `Pharmacy_idPharmacy` INT NOT NULL,
  `Medicine Name` VARCHAR(100) NOT NULL,
  `Medicine Description` VARCHAR(255) NOT NULL,
  `Medicine Price` DOUBLE NOT NULL,
  PRIMARY KEY (`idMedicines`, `Pharmacy_idPharmacy`),
  UNIQUE INDEX `Medicine Name_UNIQUE` (`Medicine Name` ASC) VISIBLE,
  INDEX `fk_Medicines_Pharmacy1_idx` (`Pharmacy_idPharmacy` ASC) VISIBLE,
  CONSTRAINT `fk_Medicines_Pharmacy1`
    FOREIGN KEY (`Pharmacy_idPharmacy`)
    REFERENCES `Hospital`.`Pharmacy` (`idPharmacy`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Hospital`.`Doctors Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Doctors Department` (
  `Doctors Department` VARCHAR(60) NOT NULL,
  `Department Id` INT NOT NULL,
  UNIQUE INDEX `Doctors Department_UNIQUE` (`Doctors Department` ASC) VISIBLE,
  PRIMARY KEY (`Department Id`));


-- -----------------------------------------------------
-- Table `Hospital`.`Doctors_has_Operation Theatre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Doctors_has_Operation Theatre` (
  `Doctors_idDoctors` INT NOT NULL,
  `Operation Theatre_Patient_idPatient` INT NOT NULL,
  PRIMARY KEY (`Doctors_idDoctors`, `Operation Theatre_Patient_idPatient`),
  INDEX `fk_Doctors_has_Operation Theatre_Operation Theatre1_idx` (`Operation Theatre_Patient_idPatient` ASC) VISIBLE,
  INDEX `fk_Doctors_has_Operation Theatre_Doctors1_idx` (`Doctors_idDoctors` ASC) VISIBLE,
  CONSTRAINT `fk_Doctors_has_Operation Theatre_Doctors1`
    FOREIGN KEY (`Doctors_idDoctors`)
    REFERENCES `Hospital`.`Doctors` (`EmpID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctors_has_Operation Theatre_Operation Theatre1`
    FOREIGN KEY (`Operation Theatre_Patient_idPatient`)
    REFERENCES `Hospital`.`Operation Theatre` (`Patient_idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Hospital`.`Doctors Department_has_Doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Doctors Department_has_Doctors` (
  `Doctors Department_Department Id` INT NOT NULL,
  `Doctors_idDoctors` INT NOT NULL,
  INDEX `fk_Doctors Department_has_Doctors_Doctors1_idx` (`Doctors_idDoctors` ASC) VISIBLE,
  INDEX `fk_Doctors Department_has_Doctors_Doctors Department1_idx` (`Doctors Department_Department Id` ASC) VISIBLE,
  PRIMARY KEY (`Doctors_idDoctors`, `Doctors Department_Department Id`),
  CONSTRAINT `fk_Doctors Department_has_Doctors_Doctors Department1`
    FOREIGN KEY (`Doctors Department_Department Id`)
    REFERENCES `Hospital`.`Doctors Department` (`Department Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctors Department_has_Doctors_Doctors1`
    FOREIGN KEY (`Doctors_idDoctors`)
    REFERENCES `Hospital`.`Doctors` (`EmpID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Hospital`.`Accountant_has_Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Accountant_has_Patient` (
  `Accountant_EmpId` INT NOT NULL,
  `Patient_idPatient` INT NOT NULL,
  PRIMARY KEY (`Accountant_EmpId`, `Patient_idPatient`),
  INDEX `fk_Accountant_has_Patient_Patient1_idx` (`Patient_idPatient` ASC) VISIBLE,
  INDEX `fk_Accountant_has_Patient_Accountant1_idx` (`Accountant_EmpId` ASC) VISIBLE,
  CONSTRAINT `fk_Accountant_has_Patient_Accountant1`
    FOREIGN KEY (`Accountant_EmpId`)
    REFERENCES `Hospital`.`Accountant` (`EmpId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Accountant_has_Patient_Patient1`
    FOREIGN KEY (`Patient_idPatient`)
    REFERENCES `Hospital`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Hospital`.`Doctors`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Doctors` (`EmpID`, `DoctorsFN`, `DoctorsLN`, `DoctorsAge`, `EmpDeptNo`) VALUES (1, 'Piyush', 'Shah', '29', DEFAULT);
INSERT INTO `Hospital`.`Doctors` (`EmpID`, `DoctorsFN`, `DoctorsLN`, `DoctorsAge`, `EmpDeptNo`) VALUES (2, 'Kristen', 'Lowell', '48', DEFAULT);
INSERT INTO `Hospital`.`Doctors` (`EmpID`, `DoctorsFN`, `DoctorsLN`, `DoctorsAge`, `EmpDeptNo`) VALUES (3, 'Emily', 'Lin', '28', DEFAULT);
INSERT INTO `Hospital`.`Doctors` (`EmpID`, `DoctorsFN`, `DoctorsLN`, `DoctorsAge`, `EmpDeptNo`) VALUES (4, 'Coleen', 'Fritze', '36', DEFAULT);
INSERT INTO `Hospital`.`Doctors` (`EmpID`, `DoctorsFN`, `DoctorsLN`, `DoctorsAge`, `EmpDeptNo`) VALUES (5, 'Jay', 'Mehta', '31', DEFAULT);
INSERT INTO `Hospital`.`Doctors` (`EmpID`, `DoctorsFN`, `DoctorsLN`, `DoctorsAge`, `EmpDeptNo`) VALUES (6, 'Smeet', 'Somaiya', '52', DEFAULT);
INSERT INTO `Hospital`.`Doctors` (`EmpID`, `DoctorsFN`, `DoctorsLN`, `DoctorsAge`, `EmpDeptNo`) VALUES (7, 'Shai', 'Hope', '34', DEFAULT);
INSERT INTO `Hospital`.`Doctors` (`EmpID`, `DoctorsFN`, `DoctorsLN`, `DoctorsAge`, `EmpDeptNo`) VALUES (8, 'Akshay', 'Sawant', '62', DEFAULT);
INSERT INTO `Hospital`.`Doctors` (`EmpID`, `DoctorsFN`, `DoctorsLN`, `DoctorsAge`, `EmpDeptNo`) VALUES (9, 'Steve', 'Rogers', '45', DEFAULT);
INSERT INTO `Hospital`.`Doctors` (`EmpID`, `DoctorsFN`, `DoctorsLN`, `DoctorsAge`, `EmpDeptNo`) VALUES (10, 'Tony ', 'Stark', '32', DEFAULT);
INSERT INTO `Hospital`.`Doctors` (`EmpID`, `DoctorsFN`, `DoctorsLN`, `DoctorsAge`, `EmpDeptNo`) VALUES (11, 'Sonia', 'Turner', '28', DEFAULT);
INSERT INTO `Hospital`.`Doctors` (`EmpID`, `DoctorsFN`, `DoctorsLN`, `DoctorsAge`, `EmpDeptNo`) VALUES (12, 'Massie', 'Williams', '36', DEFAULT);
INSERT INTO `Hospital`.`Doctors` (`EmpID`, `DoctorsFN`, `DoctorsLN`, `DoctorsAge`, `EmpDeptNo`) VALUES (13, 'Tory', 'Johra', '50', DEFAULT);
INSERT INTO `Hospital`.`Doctors` (`EmpID`, `DoctorsFN`, `DoctorsLN`, `DoctorsAge`, `EmpDeptNo`) VALUES (14, 'Emilia ', 'Clarke', '29', DEFAULT);
INSERT INTO `Hospital`.`Doctors` (`EmpID`, `DoctorsFN`, `DoctorsLN`, `DoctorsAge`, `EmpDeptNo`) VALUES (15, 'Lita', 'Rollins', '25', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Nurse`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Nurse` (`EmpId`, `Nurse_FN`, `Nurse_LN`, `Nurse_Age`) VALUES (1, 'Pooja', 'Dharmadhikari', 26);
INSERT INTO `Hospital`.`Nurse` (`EmpId`, `Nurse_FN`, `Nurse_LN`, `Nurse_Age`) VALUES (2, 'Apurva', 'Desai', 24);
INSERT INTO `Hospital`.`Nurse` (`EmpId`, `Nurse_FN`, `Nurse_LN`, `Nurse_Age`) VALUES (3, 'Caitlin', 'Stark', 29);
INSERT INTO `Hospital`.`Nurse` (`EmpId`, `Nurse_FN`, `Nurse_LN`, `Nurse_Age`) VALUES (4, 'Hayley', 'Lyons', 25);
INSERT INTO `Hospital`.`Nurse` (`EmpId`, `Nurse_FN`, `Nurse_LN`, `Nurse_Age`) VALUES (5, 'Molly', 'Evans', 27);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Room`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Room` (`idRoom`, `idBed`, `Nurse_Nurse_ID`) VALUES (1, 1, 1);
INSERT INTO `Hospital`.`Room` (`idRoom`, `idBed`, `Nurse_Nurse_ID`) VALUES (1, 2, 1);
INSERT INTO `Hospital`.`Room` (`idRoom`, `idBed`, `Nurse_Nurse_ID`) VALUES (2, 1, 2);
INSERT INTO `Hospital`.`Room` (`idRoom`, `idBed`, `Nurse_Nurse_ID`) VALUES (2, 2, 2);
INSERT INTO `Hospital`.`Room` (`idRoom`, `idBed`, `Nurse_Nurse_ID`) VALUES (3, 1, 3);
INSERT INTO `Hospital`.`Room` (`idRoom`, `idBed`, `Nurse_Nurse_ID`) VALUES (3, 2, 3);
INSERT INTO `Hospital`.`Room` (`idRoom`, `idBed`, `Nurse_Nurse_ID`) VALUES (4, 1, 4);
INSERT INTO `Hospital`.`Room` (`idRoom`, `idBed`, `Nurse_Nurse_ID`) VALUES (4, 2, 4);
INSERT INTO `Hospital`.`Room` (`idRoom`, `idBed`, `Nurse_Nurse_ID`) VALUES (5, 1, 5);
INSERT INTO `Hospital`.`Room` (`idRoom`, `idBed`, `Nurse_Nurse_ID`) VALUES (5, 2, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Patient`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Patient` (`idPatient`, `PatientFN`, `PatientLN`, `PatientAge`, `PatientDate_Of_Birth`, `Patient_Sex`, `Room_idRoom`, `Room_idBed`) VALUES (1, 'Sumeet', 'Gaglani', 24, '07-25-1994', 'M', 1, 1);
INSERT INTO `Hospital`.`Patient` (`idPatient`, `PatientFN`, `PatientLN`, `PatientAge`, `PatientDate_Of_Birth`, `Patient_Sex`, `Room_idRoom`, `Room_idBed`) VALUES (2, 'Nikunj', 'Lad', 25, '02-02-1993', 'M', 1, 2);
INSERT INTO `Hospital`.`Patient` (`idPatient`, `PatientFN`, `PatientLN`, `PatientAge`, `PatientDate_Of_Birth`, `Patient_Sex`, `Room_idRoom`, `Room_idBed`) VALUES (3, 'Varun', 'Jain', 22, '12-12-1996', 'M', 2, 1);
INSERT INTO `Hospital`.`Patient` (`idPatient`, `PatientFN`, `PatientLN`, `PatientAge`, `PatientDate_Of_Birth`, `Patient_Sex`, `Room_idRoom`, `Room_idBed`) VALUES (4, 'Jon', 'Snow', 33, '01-12-1985', 'M', 2, 2);
INSERT INTO `Hospital`.`Patient` (`idPatient`, `PatientFN`, `PatientLN`, `PatientAge`, `PatientDate_Of_Birth`, `Patient_Sex`, `Room_idRoom`, `Room_idBed`) VALUES (5, 'Arya', 'Zee', 43, '12-03-1975', 'F', 3, 1);
INSERT INTO `Hospital`.`Patient` (`idPatient`, `PatientFN`, `PatientLN`, `PatientAge`, `PatientDate_Of_Birth`, `Patient_Sex`, `Room_idRoom`, `Room_idBed`) VALUES (6, 'Dwyane', 'Johnson', 24, '05-05-1994', 'M', 3, 2);
INSERT INTO `Hospital`.`Patient` (`idPatient`, `PatientFN`, `PatientLN`, `PatientAge`, `PatientDate_Of_Birth`, `Patient_Sex`, `Room_idRoom`, `Room_idBed`) VALUES (7, 'Will ', 'Smith', 29, '06-08-1989', 'M', 4, 1);
INSERT INTO `Hospital`.`Patient` (`idPatient`, `PatientFN`, `PatientLN`, `PatientAge`, `PatientDate_Of_Birth`, `Patient_Sex`, `Room_idRoom`, `Room_idBed`) VALUES (8, 'John', 'Cena', 35, '03-09-1983', 'M', 4, 2);
INSERT INTO `Hospital`.`Patient` (`idPatient`, `PatientFN`, `PatientLN`, `PatientAge`, `PatientDate_Of_Birth`, `Patient_Sex`, `Room_idRoom`, `Room_idBed`) VALUES (9, 'Richard', 'Parker', 78, '06-07-1940', 'M', 5, 1);
INSERT INTO `Hospital`.`Patient` (`idPatient`, `PatientFN`, `PatientLN`, `PatientAge`, `PatientDate_Of_Birth`, `Patient_Sex`, `Room_idRoom`, `Room_idBed`) VALUES (10, 'Benjamin', 'Franklin', 55, '04-11-1963', 'M', 5, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Doctors_consults_Patient`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Doctors_consults_Patient` (`Doctors_idDoctors`, `Patient_idPatient`) VALUES (1, 3);
INSERT INTO `Hospital`.`Doctors_consults_Patient` (`Doctors_idDoctors`, `Patient_idPatient`) VALUES (6, 2);
INSERT INTO `Hospital`.`Doctors_consults_Patient` (`Doctors_idDoctors`, `Patient_idPatient`) VALUES (3, 1);
INSERT INTO `Hospital`.`Doctors_consults_Patient` (`Doctors_idDoctors`, `Patient_idPatient`) VALUES (5, 6);
INSERT INTO `Hospital`.`Doctors_consults_Patient` (`Doctors_idDoctors`, `Patient_idPatient`) VALUES (7, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Patient_Contact_Information`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Patient_Contact_Information` (`Patient_idPatient`, `Primary Number`, `Secondary Number`, `Street Line 1`, `Steet Line 2`, `State`, `City`, `Email ID`) VALUES (1, '857999661', '1235695846', '2 Quensberry Street', 'Apt 15', 'MA', 'Boston', 'gaglani.s@gmail.com');
INSERT INTO `Hospital`.`Patient_Contact_Information` (`Patient_idPatient`, `Primary Number`, `Secondary Number`, `Street Line 1`, `Steet Line 2`, `State`, `City`, `Email ID`) VALUES (2, '8579995252', '3594126480', '24 Copley Square', 'Apt 1', 'MA', 'Boston', 'lad.n@hotmail.com');
INSERT INTO `Hospital`.`Patient_Contact_Information` (`Patient_idPatient`, `Primary Number`, `Secondary Number`, `Street Line 1`, `Steet Line 2`, `State`, `City`, `Email ID`) VALUES (3, '2125647895', '3652412598', '75 Peterborough Streer', 'Apt 5', 'MA', 'Boston', 'var.j@gmail.com');
INSERT INTO `Hospital`.`Patient_Contact_Information` (`Patient_idPatient`, `Primary Number`, `Secondary Number`, `Street Line 1`, `Steet Line 2`, `State`, `City`, `Email ID`) VALUES (4, '5698523147', '1596324872', '5 Colombus Ave', 'Apt 2L', 'CA', 'Los Angelos', 'j254.snow@gmail.com');
INSERT INTO `Hospital`.`Patient_Contact_Information` (`Patient_idPatient`, `Primary Number`, `Secondary Number`, `Street Line 1`, `Steet Line 2`, `State`, `City`, `Email ID`) VALUES (5, '9856323524', '526412987', '9 Mass Ave', 'Apt 3R', 'TX', 'Houston', 'Arya945@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Lab Assistant`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Lab Assistant` (`EmpID`, `LA_FN`, `LA_LN`, `LA_Age`) VALUES (1, 'Smith', 'Obzek', 30);
INSERT INTO `Hospital`.`Lab Assistant` (`EmpID`, `LA_FN`, `LA_LN`, `LA_Age`) VALUES (2, 'Yusuf', 'Bugrara', 39);
INSERT INTO `Hospital`.`Lab Assistant` (`EmpID`, `LA_FN`, `LA_LN`, `LA_Age`) VALUES (3, 'Kal', 'Somaiya', 49);
INSERT INTO `Hospital`.`Lab Assistant` (`EmpID`, `LA_FN`, `LA_LN`, `LA_Age`) VALUES (4, 'Mrunal', 'Ghorpade', 24);
INSERT INTO `Hospital`.`Lab Assistant` (`EmpID`, `LA_FN`, `LA_LN`, `LA_Age`) VALUES (5, 'Sailee', 'Bhagat', 25);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Accountant`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Accountant` (`EmpId`, `AccountantFN`, `AccountantLN`, `Age`) VALUES (1, 'Katherine', 'Bugrara', 46);
INSERT INTO `Hospital`.`Accountant` (`EmpId`, `AccountantFN`, `AccountantLN`, `Age`) VALUES (2, 'Patrick', 'Simmons', 52);
INSERT INTO `Hospital`.`Accountant` (`EmpId`, `AccountantFN`, `AccountantLN`, `Age`) VALUES (3, 'Jonny ', 'Sins', 32);
INSERT INTO `Hospital`.`Accountant` (`EmpId`, `AccountantFN`, `AccountantLN`, `Age`) VALUES (4, 'Michael', 'Schwa', 39);
INSERT INTO `Hospital`.`Accountant` (`EmpId`, `AccountantFN`, `AccountantLN`, `Age`) VALUES (5, 'Racheal', 'Green', 27);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Employee Contact Info`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Employee Contact Info` (`Email ID`, `Doctors_EmpID`, `Lab Assistant_EmpID`, `Nurse_EmpId`, `Accountant_EmpId`, `Primary Number`, `Secondary Number`, `Street Line 1`, `Street Line 2`, `State`, `City`) VALUES (DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, '9632512689', '2036489501', '1120 N Street', 'Apt 5', 'CA', 'Sacramento');
INSERT INTO `Hospital`.`Employee Contact Info` (`Email ID`, `Doctors_EmpID`, `Lab Assistant_EmpID`, `Nurse_EmpId`, `Accountant_EmpId`, `Primary Number`, `Secondary Number`, `Street Line 1`, `Street Line 2`, `State`, `City`) VALUES (DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, '8576329421', '2123695214', '1657 Riverside Drive', 'Apt 6L', 'AZ', 'Tempe');
INSERT INTO `Hospital`.`Employee Contact Info` (`Email ID`, `Doctors_EmpID`, `Lab Assistant_EmpID`, `Nurse_EmpId`, `Accountant_EmpId`, `Primary Number`, `Secondary Number`, `Street Line 1`, `Street Line 2`, `State`, `City`) VALUES (DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, '2152652300', '2152652632', '100 S. Main Street', 'Apt 42', 'DE', 'Baltimore');
INSERT INTO `Hospital`.`Employee Contact Info` (`Email ID`, `Doctors_EmpID`, `Lab Assistant_EmpID`, `Nurse_EmpId`, `Accountant_EmpId`, `Primary Number`, `Secondary Number`, `Street Line 1`, `Street Line 2`, `State`, `City`) VALUES (DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, '6513294001', '5064291236', 'South Main Street', 'Apt 100', 'MA', 'Boston');
INSERT INTO `Hospital`.`Employee Contact Info` (`Email ID`, `Doctors_EmpID`, `Lab Assistant_EmpID`, `Nurse_EmpId`, `Accountant_EmpId`, `Primary Number`, `Secondary Number`, `Street Line 1`, `Street Line 2`, `State`, `City`) VALUES (DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, '8579996664', '9578885566', 'South Main Street', 'Apt 101', 'MA', 'Boston');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Operation Theatre`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Operation Theatre` (`idOperation Theatre`, `Operation_Theatre_Name`, `Patient_idPatient`, `Doctors_idDoctors`, `Lab Assistant_LA_ID`) VALUES (1, 'ICU 1', 5, 2, 3);
INSERT INTO `Hospital`.`Operation Theatre` (`idOperation Theatre`, `Operation_Theatre_Name`, `Patient_idPatient`, `Doctors_idDoctors`, `Lab Assistant_LA_ID`) VALUES (2, 'ICU 2', 6, 3, 1);
INSERT INTO `Hospital`.`Operation Theatre` (`idOperation Theatre`, `Operation_Theatre_Name`, `Patient_idPatient`, `Doctors_idDoctors`, `Lab Assistant_LA_ID`) VALUES (3, 'ICU 3', 11, 9, 2);
INSERT INTO `Hospital`.`Operation Theatre` (`idOperation Theatre`, `Operation_Theatre_Name`, `Patient_idPatient`, `Doctors_idDoctors`, `Lab Assistant_LA_ID`) VALUES (4, 'MRI 1', 1, 10, 4);
INSERT INTO `Hospital`.`Operation Theatre` (`idOperation Theatre`, `Operation_Theatre_Name`, `Patient_idPatient`, `Doctors_idDoctors`, `Lab Assistant_LA_ID`) VALUES (5, 'MRI 2', 7, 4, 9);
INSERT INTO `Hospital`.`Operation Theatre` (`idOperation Theatre`, `Operation_Theatre_Name`, `Patient_idPatient`, `Doctors_idDoctors`, `Lab Assistant_LA_ID`) VALUES (6, 'MRI 3', 8, 8, 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Pharmacy`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Pharmacy` (`idPharmacy`, `Pharmacy Name`, `Patient_idPatient`, `Doctors_EmpID`) VALUES (1, 'CVS', 2, DEFAULT);
INSERT INTO `Hospital`.`Pharmacy` (`idPharmacy`, `Pharmacy Name`, `Patient_idPatient`, `Doctors_EmpID`) VALUES (1, 'CVS', 1, DEFAULT);
INSERT INTO `Hospital`.`Pharmacy` (`idPharmacy`, `Pharmacy Name`, `Patient_idPatient`, `Doctors_EmpID`) VALUES (1, 'CVS', 6, DEFAULT);
INSERT INTO `Hospital`.`Pharmacy` (`idPharmacy`, `Pharmacy Name`, `Patient_idPatient`, `Doctors_EmpID`) VALUES (1, 'CVS', 5, DEFAULT);
INSERT INTO `Hospital`.`Pharmacy` (`idPharmacy`, `Pharmacy Name`, `Patient_idPatient`, `Doctors_EmpID`) VALUES (1, 'CVS', 4, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Medicines`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Medicines` (`idMedicines`, `Pharmacy_idPharmacy`, `Medicine Name`, `Medicine Description`, `Medicine Price`) VALUES (1, 1, 'Acetaminophen', 'Acetaminophen is used to treat many conditions such as headache, muscle aches, arthritis, backache, toothaches, colds, and fevers.', 3.49);
INSERT INTO `Hospital`.`Medicines` (`idMedicines`, `Pharmacy_idPharmacy`, `Medicine Name`, `Medicine Description`, `Medicine Price`) VALUES (2, 1, 'Lexapro', 'Lexapro is also used to treat major depressive disorder in adults and adolescents who are at least 12 years old.', 10.99);
INSERT INTO `Hospital`.`Medicines` (`idMedicines`, `Pharmacy_idPharmacy`, `Medicine Name`, `Medicine Description`, `Medicine Price`) VALUES (3, 1, 'Naproxen', 'Naproxen is used to treat pain or inflammation caused by conditions such as arthritis, ankylosing spondylitis, tendinitis, bursitis, gout, or menstrual cramps.', 5.49);
INSERT INTO `Hospital`.`Medicines` (`idMedicines`, `Pharmacy_idPharmacy`, `Medicine Name`, `Medicine Description`, `Medicine Price`) VALUES (4, 1, 'Amitriptyline', 'Amitriptyline is used to treat symptoms of depression.', 4.89);
INSERT INTO `Hospital`.`Medicines` (`idMedicines`, `Pharmacy_idPharmacy`, `Medicine Name`, `Medicine Description`, `Medicine Price`) VALUES (5, 1, 'Metformin', 'Metformin is used together with diet and exercise to improve blood sugar control in adults with type 2 diabetes mellitus.', 6.99);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Doctors Department`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Doctors Department` (`Doctors Department`, `Department Id`) VALUES ('Anaesthetics', 1);
INSERT INTO `Hospital`.`Doctors Department` (`Doctors Department`, `Department Id`) VALUES ('Cardiology', 2);
INSERT INTO `Hospital`.`Doctors Department` (`Doctors Department`, `Department Id`) VALUES ('Chaplaincy', 3);
INSERT INTO `Hospital`.`Doctors Department` (`Doctors Department`, `Department Id`) VALUES ('Diagnostic imaging', 4);
INSERT INTO `Hospital`.`Doctors Department` (`Doctors Department`, `Department Id`) VALUES ('Discharge lounge', 5);
INSERT INTO `Hospital`.`Doctors Department` (`Doctors Department`, `Department Id`) VALUES ('Ear nose and throat', 6);
INSERT INTO `Hospital`.`Doctors Department` (`Doctors Department`, `Department Id`) VALUES ('Elderly services department', 7);
INSERT INTO `Hospital`.`Doctors Department` (`Doctors Department`, `Department Id`) VALUES ('Gastroenterology', 8);
INSERT INTO `Hospital`.`Doctors Department` (`Doctors Department`, `Department Id`) VALUES ('General surgery', 9);
INSERT INTO `Hospital`.`Doctors Department` (`Doctors Department`, `Department Id`) VALUES ('Gynaecology', 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Doctors_has_Operation Theatre`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Doctors_has_Operation Theatre` (`Doctors_idDoctors`, `Operation Theatre_Patient_idPatient`) VALUES (1, 6);
INSERT INTO `Hospital`.`Doctors_has_Operation Theatre` (`Doctors_idDoctors`, `Operation Theatre_Patient_idPatient`) VALUES (2, 5);
INSERT INTO `Hospital`.`Doctors_has_Operation Theatre` (`Doctors_idDoctors`, `Operation Theatre_Patient_idPatient`) VALUES (3, 4);
INSERT INTO `Hospital`.`Doctors_has_Operation Theatre` (`Doctors_idDoctors`, `Operation Theatre_Patient_idPatient`) VALUES (4, 3);
INSERT INTO `Hospital`.`Doctors_has_Operation Theatre` (`Doctors_idDoctors`, `Operation Theatre_Patient_idPatient`) VALUES (5, 2);
INSERT INTO `Hospital`.`Doctors_has_Operation Theatre` (`Doctors_idDoctors`, `Operation Theatre_Patient_idPatient`) VALUES (6, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Hospital`.`Doctors Department_has_Doctors`
-- -----------------------------------------------------
START TRANSACTION;
USE `Hospital`;
INSERT INTO `Hospital`.`Doctors Department_has_Doctors` (`Doctors Department_Department Id`, `Doctors_idDoctors`) VALUES (1, 4);
INSERT INTO `Hospital`.`Doctors Department_has_Doctors` (`Doctors Department_Department Id`, `Doctors_idDoctors`) VALUES (2, 6);
INSERT INTO `Hospital`.`Doctors Department_has_Doctors` (`Doctors Department_Department Id`, `Doctors_idDoctors`) VALUES (3, 8);
INSERT INTO `Hospital`.`Doctors Department_has_Doctors` (`Doctors Department_Department Id`, `Doctors_idDoctors`) VALUES (4, 2);
INSERT INTO `Hospital`.`Doctors Department_has_Doctors` (`Doctors Department_Department Id`, `Doctors_idDoctors`) VALUES (5, 9);
INSERT INTO `Hospital`.`Doctors Department_has_Doctors` (`Doctors Department_Department Id`, `Doctors_idDoctors`) VALUES (6, 7);
INSERT INTO `Hospital`.`Doctors Department_has_Doctors` (`Doctors Department_Department Id`, `Doctors_idDoctors`) VALUES (7, 1);
INSERT INTO `Hospital`.`Doctors Department_has_Doctors` (`Doctors Department_Department Id`, `Doctors_idDoctors`) VALUES (8, 3);
INSERT INTO `Hospital`.`Doctors Department_has_Doctors` (`Doctors Department_Department Id`, `Doctors_idDoctors`) VALUES (9, 4);
INSERT INTO `Hospital`.`Doctors Department_has_Doctors` (`Doctors Department_Department Id`, `Doctors_idDoctors`) VALUES (10, 5);
INSERT INTO `Hospital`.`Doctors Department_has_Doctors` (`Doctors Department_Department Id`, `Doctors_idDoctors`) VALUES (5, 11);
INSERT INTO `Hospital`.`Doctors Department_has_Doctors` (`Doctors Department_Department Id`, `Doctors_idDoctors`) VALUES (6, 13);
INSERT INTO `Hospital`.`Doctors Department_has_Doctors` (`Doctors Department_Department Id`, `Doctors_idDoctors`) VALUES (9, 1);
INSERT INTO `Hospital`.`Doctors Department_has_Doctors` (`Doctors Department_Department Id`, `Doctors_idDoctors`) VALUES (3, 15);

COMMIT;

