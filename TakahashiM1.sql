-- Masaki Takahashi
-- CITD 120 SQL Concepts
-- Instructor: Zachary Hoffman 


CREATE DATABASE VET; 
USE VET; 

-- -----------------------------------------------------
-- Table `VET`.`TYPE`.
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `VET`.`TYPE` (
`TypeID` INT NOT NULL COMMENT 'Pet type identifier. The highest type id will be 99. ',
`Food` VARCHAR(20) NOT NULL COMMENT 'Type of food',
`CageSize` CHAR(1) NOT NULL COMMENT 'Size of cage for this pet type ',
`WaterBowlSize` CHAR(1) NOT NULL COMMENT 'Size of water bowl',
`FoodBowlSize` CHAR(1) NOT NULL COMMENT 'Size of food bowl',
  `NeedsWalk` CHAR(1) NOT NULL COMMENT 'Y if this type of pet needs to be walked',
  `NeedsLitter` CHAR(1) NOT NULL COMMENT 'if this type of pet needs litter',
  `NeedsLiner` CHAR(1) NOT NULL COMMENT 'if this type of pet needs a cage liner',
  PRIMARY KEY (`TypeID`));
  
-- -----------------------------------------------------
-- Table `VET`.`PET`
-- -----------------------------------------------------
  
  CREATE TABLE IF NOT EXISTS `VET`.`PET` (
  `PetID` INT NOT NULL COMMENT 'The highest pet id will be 9999 ',
  `OwnerID` CHAR(7) NOT NULL COMMENT 'The id of the pet’s owner ',
  `TypeID` INT NOT NULL COMMENT 'References the Type table ',
  `PetName` VARCHAR(30) NULL,
  `Description` VARCHAR(50) NULL,
  `Birthday` DATETIME NULL,
  `LastVisit` DATETIME NULL,
  PRIMARY KEY (`PetID`, `OwnerID`, `TypeID`));