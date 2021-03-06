-- MySQL Script generated by MySQL Workbench
-- Mon Jan 20 09:17:21 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema agenceImmo
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `agenceImmo` ;

-- -----------------------------------------------------
-- Schema agenceImmo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `agenceImmo` DEFAULT CHARACTER SET utf8 ;
USE `agenceImmo` ;

-- -----------------------------------------------------
-- Table `agenceImmo`.`Ville`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`Ville` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`Ville` (
  `idVille` INT NOT NULL AUTO_INCREMENT,
  `cp` VARCHAR(45) NULL,
  `nomVille` VARCHAR(45) NULL,
  PRIMARY KEY (`idVille`),
  UNIQUE INDEX `idVille_UNIQUE` (`idVille` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`Adress`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`Adress` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`Adress` (
  `idAdress` INT NOT NULL AUTO_INCREMENT,
  `numRue` INT NULL,
  `nomRue` VARCHAR(45) NULL,
  `complementRue` VARCHAR(45) NULL,
  `Ville_idVille` INT NOT NULL,
  PRIMARY KEY (`idAdress`),
  UNIQUE INDEX `idAdress_UNIQUE` (`idAdress` ASC),
  INDEX `fk_Adress_Ville2_idx` (`Ville_idVille` ASC),
  CONSTRAINT `fk_Adress_Ville2`
    FOREIGN KEY (`Ville_idVille`)
    REFERENCES `agenceImmo`.`Ville` (`idVille`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`TypeProduit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`TypeProduit` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`TypeProduit` (
  `idTypeProduit` INT NOT NULL AUTO_INCREMENT,
  `nameProduct` VARCHAR(45) NULL,
  PRIMARY KEY (`idTypeProduit`),
  UNIQUE INDEX `idTypeProduit_UNIQUE` (`idTypeProduit` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`Products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`Products` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`Products` (
  `idProducts` INT NOT NULL AUTO_INCREMENT,
  `typeProducts` TINYINT NULL,
  `nameProduct` VARCHAR(45) NULL,
  `detailLocation` VARCHAR(45) NULL,
  `debutLocation` DATE NULL,
  `finLocation` DATE NULL,
  `etatProduct` VARCHAR(45) NULL,
  `HistoriqueLocation_idHistoriqueLocation` INT NOT NULL,
  `TypeProduit_idTypeProduit` INT NOT NULL,
  PRIMARY KEY (`idProducts`, `HistoriqueLocation_idHistoriqueLocation`, `TypeProduit_idTypeProduit`),
  UNIQUE INDEX `idProducts_UNIQUE` (`idProducts` ASC),
  INDEX `fk_Products_TypeProduit1_idx` (`TypeProduit_idTypeProduit` ASC),
  CONSTRAINT `fk_Products_TypeProduit1`
    FOREIGN KEY (`TypeProduit_idTypeProduit`)
    REFERENCES `agenceImmo`.`TypeProduit` (`idTypeProduit`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`Duree`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`Duree` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`Duree` (
  `idDuree` INT NOT NULL AUTO_INCREMENT,
  `valeurDuree` DATE NULL,
  PRIMARY KEY (`idDuree`),
  UNIQUE INDEX `idDurée_UNIQUE` (`idDuree` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`Localisation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`Localisation` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`Localisation` (
  `idLocalisation` INT NOT NULL AUTO_INCREMENT,
  `coordonneeGps` VARCHAR(45) NULL,
  PRIMARY KEY (`idLocalisation`),
  UNIQUE INDEX `idLocalisation_UNIQUE` (`idLocalisation` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`Panier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`Panier` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`Panier` (
  `idPanier` INT NOT NULL AUTO_INCREMENT,
  `quantité` INT NULL,
  `tauxTva` INT NULL,
  `Products_idProducts` INT NOT NULL,
  `Products_HistoriqueLocation_idHistoriqueLocation` INT NOT NULL,
  `Products_TypeProduit_idTypeProduit` INT NOT NULL,
  `Durée_idDurée` INT NOT NULL,
  `Localisation_idLocalisation` INT NOT NULL,
  PRIMARY KEY (`idPanier`, `Products_idProducts`, `Products_HistoriqueLocation_idHistoriqueLocation`, `Products_TypeProduit_idTypeProduit`, `Durée_idDurée`, `Localisation_idLocalisation`),
  UNIQUE INDEX `idPanier_UNIQUE` (`idPanier` ASC),
  INDEX `fk_Panier_Products1_idx` (`Products_idProducts` ASC, `Products_HistoriqueLocation_idHistoriqueLocation` ASC, `Products_TypeProduit_idTypeProduit` ASC),
  INDEX `fk_Panier_Durée1_idx` (`Durée_idDurée` ASC),
  INDEX `fk_Panier_Localisation1_idx` (`Localisation_idLocalisation` ASC),
  CONSTRAINT `fk_Panier_Products1`
    FOREIGN KEY (`Products_idProducts` , `Products_HistoriqueLocation_idHistoriqueLocation` , `Products_TypeProduit_idTypeProduit`)
    REFERENCES `agenceImmo`.`Products` (`idProducts` , `HistoriqueLocation_idHistoriqueLocation` , `TypeProduit_idTypeProduit`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Panier_Durée1`
    FOREIGN KEY (`Durée_idDurée`)
    REFERENCES `agenceImmo`.`Duree` (`idDuree`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Panier_Localisation1`
    FOREIGN KEY (`Localisation_idLocalisation`)
    REFERENCES `agenceImmo`.`Localisation` (`idLocalisation`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`Users` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`Users` (
  `idUsers` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `tel` VARCHAR(45) NULL,
  `mail` VARCHAR(45) NULL,
  `birthday` DATE NULL,
  `Location_idLocation` INT NOT NULL,
  `Adress_idAdress` INT NOT NULL,
  `Adress_Ville_idVille` INT NOT NULL,
  `Panier_idPanier` INT NOT NULL,
  `Panier_Products_idProducts` INT NOT NULL,
  `Panier_Products_HistoriqueLocation_idHistoriqueLocation` INT NOT NULL,
  `Panier_Products_TypeProduit_idTypeProduit` INT NOT NULL,
  `Panier_Durée_idDurée` INT NOT NULL,
  `Panier_Localisation_idLocalisation` INT NOT NULL,
  PRIMARY KEY (`idUsers`, `Location_idLocation`, `Adress_idAdress`, `Adress_Ville_idVille`, `Panier_idPanier`, `Panier_Products_idProducts`, `Panier_Products_HistoriqueLocation_idHistoriqueLocation`, `Panier_Products_TypeProduit_idTypeProduit`, `Panier_Durée_idDurée`, `Panier_Localisation_idLocalisation`),
  UNIQUE INDEX `idUsers_UNIQUE` (`idUsers` ASC),
  INDEX `fk_Users_Adress1_idx` (`Adress_idAdress` ASC, `Adress_Ville_idVille` ASC),
  INDEX `fk_Users_Panier1_idx` (`Panier_idPanier` ASC, `Panier_Products_idProducts` ASC, `Panier_Products_HistoriqueLocation_idHistoriqueLocation` ASC, `Panier_Products_TypeProduit_idTypeProduit` ASC, `Panier_Durée_idDurée` ASC, `Panier_Localisation_idLocalisation` ASC),
  CONSTRAINT `fk_Users_Adress1`
    FOREIGN KEY (`Adress_idAdress` , `Adress_Ville_idVille`)
    REFERENCES `agenceImmo`.`Adress` (`idAdress` , `Ville_idVille`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Users_Panier1`
    FOREIGN KEY (`Panier_idPanier` , `Panier_Products_idProducts` , `Panier_Products_HistoriqueLocation_idHistoriqueLocation` , `Panier_Products_TypeProduit_idTypeProduit` , `Panier_Durée_idDurée` , `Panier_Localisation_idLocalisation`)
    REFERENCES `agenceImmo`.`Panier` (`idPanier` , `Products_idProducts` , `Products_HistoriqueLocation_idHistoriqueLocation` , `Products_TypeProduit_idTypeProduit` , `Durée_idDurée` , `Localisation_idLocalisation`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`Ville`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`Ville` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`Ville` (
  `idVille` INT NOT NULL AUTO_INCREMENT,
  `cp` VARCHAR(45) NULL,
  `nomVille` VARCHAR(45) NULL,
  PRIMARY KEY (`idVille`),
  UNIQUE INDEX `idVille_UNIQUE` (`idVille` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`Adress`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`Adress` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`Adress` (
  `idAdress` INT NOT NULL AUTO_INCREMENT,
  `numRue` INT NULL,
  `nomRue` VARCHAR(45) NULL,
  `complementRue` VARCHAR(45) NULL,
  `Ville_idVille` INT NOT NULL,
  PRIMARY KEY (`idAdress`),
  UNIQUE INDEX `idAdress_UNIQUE` (`idAdress` ASC),
  INDEX `fk_Adress_Ville2_idx` (`Ville_idVille` ASC),
  CONSTRAINT `fk_Adress_Ville2`
    FOREIGN KEY (`Ville_idVille`)
    REFERENCES `agenceImmo`.`Ville` (`idVille`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`User` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `birthday` DATE NULL,
  `tel` VARCHAR(45) NULL,
  `mail` VARCHAR(45) NULL,
  `Adress_idAdress1` INT NOT NULL,
  PRIMARY KEY (`idUser`),
  UNIQUE INDEX `idUser_UNIQUE` (`idUser` ASC),
  INDEX `fk_User_Adress1_idx` (`Adress_idAdress1` ASC),
  CONSTRAINT `fk_User_Adress1`
    FOREIGN KEY (`Adress_idAdress1`)
    REFERENCES `agenceImmo`.`Adress` (`idAdress`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`TypeTransaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`TypeTransaction` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`TypeTransaction` (
  `idTypeTransaction` INT NOT NULL AUTO_INCREMENT,
  `TypeTransaction` VARCHAR(45) NULL,
  PRIMARY KEY (`idTypeTransaction`),
  UNIQUE INDEX `idTypeTransaction_UNIQUE` (`idTypeTransaction` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`PriseRdv`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`PriseRdv` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`PriseRdv` (
  `idPriseRdv` INT NOT NULL AUTO_INCREMENT,
  `rdv` DATE NULL,
  PRIMARY KEY (`idPriseRdv`),
  UNIQUE INDEX `idPriseRdv_UNIQUE` (`idPriseRdv` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`TypeProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`TypeProduct` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`TypeProduct` (
  `idTypeProduct` INT NOT NULL AUTO_INCREMENT,
  `nameProduct` VARCHAR(45) NULL,
  PRIMARY KEY (`idTypeProduct`),
  UNIQUE INDEX `idTypeProduct_UNIQUE` (`idTypeProduct` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`DureeLocation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`DureeLocation` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`DureeLocation` (
  `idDureeLocation` INT NOT NULL AUTO_INCREMENT,
  `debutDuree` DATE NULL,
  `finDuree` DATE NULL,
  PRIMARY KEY (`idDureeLocation`),
  UNIQUE INDEX `idDureeLocation_UNIQUE` (`idDureeLocation` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`Localisation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`Localisation` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`Localisation` (
  `idLocalisation` INT NOT NULL AUTO_INCREMENT,
  `coordonneeGps` VARCHAR(45) NULL,
  PRIMARY KEY (`idLocalisation`),
  UNIQUE INDEX `idLocalisation_UNIQUE` (`idLocalisation` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`Map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`Map` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`Map` (
  `idMap` INT NOT NULL AUTO_INCREMENT,
  `gestionMap` VARCHAR(255) NULL,
  `Localisation_idLocalisation` INT NOT NULL,
  PRIMARY KEY (`idMap`, `Localisation_idLocalisation`),
  UNIQUE INDEX `idMap_UNIQUE` (`idMap` ASC),
  INDEX `fk_Map_Localisation1_idx` (`Localisation_idLocalisation` ASC),
  CONSTRAINT `fk_Map_Localisation1`
    FOREIGN KEY (`Localisation_idLocalisation`)
    REFERENCES `agenceImmo`.`Localisation` (`idLocalisation`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`Product` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`Product` (
  `idProduct` INT NOT NULL AUTO_INCREMENT,
  `typeVente` TINYINT NULL,
  `nameProduct` VARCHAR(45) NULL,
  `TypeTransaction_idTypeTransaction` INT NOT NULL,
  `PriseRdv_idPriseRdv` INT NOT NULL,
  `Localisation_idLocalisation` INT NOT NULL,
  `TypeProduct_idTypeProduct` INT NOT NULL,
  `DureeLocation_idDureeLocation` INT NOT NULL,
  `Map_idMap` INT NOT NULL,
  `Map_Localisation_idLocalisation` INT NOT NULL,
  UNIQUE INDEX `idProduct_UNIQUE` (`idProduct` ASC),
  PRIMARY KEY (`idProduct`, `TypeTransaction_idTypeTransaction`, `PriseRdv_idPriseRdv`, `Localisation_idLocalisation`, `TypeProduct_idTypeProduct`, `DureeLocation_idDureeLocation`, `Map_idMap`, `Map_Localisation_idLocalisation`),
  INDEX `fk_Product_TypeTransaction1_idx` (`TypeTransaction_idTypeTransaction` ASC),
  INDEX `fk_Product_PriseRdv1_idx` (`PriseRdv_idPriseRdv` ASC),
  INDEX `fk_Product_TypeProduct1_idx` (`TypeProduct_idTypeProduct` ASC),
  INDEX `fk_Product_DureeLocation1_idx` (`DureeLocation_idDureeLocation` ASC),
  INDEX `fk_Product_Map1_idx` (`Map_idMap` ASC, `Map_Localisation_idLocalisation` ASC),
  CONSTRAINT `fk_Product_TypeTransaction1`
    FOREIGN KEY (`TypeTransaction_idTypeTransaction`)
    REFERENCES `agenceImmo`.`TypeTransaction` (`idTypeTransaction`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Product_PriseRdv1`
    FOREIGN KEY (`PriseRdv_idPriseRdv`)
    REFERENCES `agenceImmo`.`PriseRdv` (`idPriseRdv`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Product_TypeProduct1`
    FOREIGN KEY (`TypeProduct_idTypeProduct`)
    REFERENCES `agenceImmo`.`TypeProduct` (`idTypeProduct`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Product_DureeLocation1`
    FOREIGN KEY (`DureeLocation_idDureeLocation`)
    REFERENCES `agenceImmo`.`DureeLocation` (`idDureeLocation`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Product_Map1`
    FOREIGN KEY (`Map_idMap` , `Map_Localisation_idLocalisation`)
    REFERENCES `agenceImmo`.`Map` (`idMap` , `Localisation_idLocalisation`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agenceImmo`.`Annonce`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `agenceImmo`.`Annonce` ;

CREATE TABLE IF NOT EXISTS `agenceImmo`.`Annonce` (
  `idAnnonce` INT NOT NULL AUTO_INCREMENT,
  `typeAnnonce` TINYINT NULL,
  `nameAnnonce` VARCHAR(45) NULL,
  `prixAnnonce` INT NULL,
  `User_idUser` INT NOT NULL,
  `User_Adress_idAdress` INT NOT NULL,
  `User_Adress_Ville_idVille` INT NOT NULL,
  `Product_idProduct` INT NOT NULL,
  `Product_TypeTransaction_idTypeTransaction` INT NOT NULL,
  `Product_PriseRdv_idPriseRdv` INT NOT NULL,
  `Product_Localisation_idLocalisation` INT NOT NULL,
  `Product_TypeProduct_idTypeProduct` INT NOT NULL,
  `Product_DureeLocation_idDureeLocation` INT NOT NULL,
  `Product_Map_idMap` INT NOT NULL,
  `Product_Map_Localisation_idLocalisation` INT NOT NULL,
  PRIMARY KEY (`idAnnonce`),
  UNIQUE INDEX `idAnnonce_UNIQUE` (`idAnnonce` ASC),
  INDEX `fk_Annonce_User1_idx` (`User_idUser` ASC, `User_Adress_idAdress` ASC, `User_Adress_Ville_idVille` ASC),
  INDEX `fk_Annonce_Product1_idx` (`Product_idProduct` ASC, `Product_TypeTransaction_idTypeTransaction` ASC, `Product_PriseRdv_idPriseRdv` ASC, `Product_Localisation_idLocalisation` ASC, `Product_TypeProduct_idTypeProduct` ASC, `Product_DureeLocation_idDureeLocation` ASC, `Product_Map_idMap` ASC, `Product_Map_Localisation_idLocalisation` ASC),
  CONSTRAINT `fk_Annonce_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `agenceImmo`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Annonce_Product1`
    FOREIGN KEY (`Product_idProduct` , `Product_TypeTransaction_idTypeTransaction` , `Product_PriseRdv_idPriseRdv` , `Product_Localisation_idLocalisation` , `Product_TypeProduct_idTypeProduct` , `Product_DureeLocation_idDureeLocation` , `Product_Map_idMap` , `Product_Map_Localisation_idLocalisation`)
    REFERENCES `agenceImmo`.`Product` (`idProduct` , `TypeTransaction_idTypeTransaction` , `PriseRdv_idPriseRdv` , `Localisation_idLocalisation` , `TypeProduct_idTypeProduct` , `DureeLocation_idDureeLocation` , `Map_idMap` , `Map_Localisation_idLocalisation`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
