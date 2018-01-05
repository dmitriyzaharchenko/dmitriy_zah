-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hotel` DEFAULT CHARACTER SET utf8 ;
USE `hostel` ;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `surname` VARCHAR(20) NOT NULL,
  `phone` VARCHAR(14) NULL,
  `email` VARCHAR(45) NULL,
  `login` VARCHAR(15) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `arrival` DATETIME NOT NULL,
  `departure` DATETIME NOT NULL,
  `user_id` INT NOT NULL,
  `note` VARCHAR(255) NULL,
  `status_id` INT NOT NULL,
  PRIMARY KEY (`id`, `status_id`),
  INDEX `fk_booking_client_idx` (`user_id` ASC),
  INDEX `fk_order_status1_idx` (`status_id` ASC),
  CONSTRAINT `fk_booking_client`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `mydb`.`status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`abstract_room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`abstract_room` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(10) NOT NULL,
  `price` DOUBLE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(10) NOT NULL,
  `places` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`room` (
  `number` INT NOT NULL AUTO_INCREMENT,
  `abstract_room_id` INT NOT NULL,
  `type_id` INT NOT NULL,
  `isDelux` TINYINT NULL,
  PRIMARY KEY (`number`),
  INDEX `fk_room_abstract_room1_idx` (`abstract_room_id` ASC),
  INDEX `fk_room_type1_idx` (`type_id` ASC),
  CONSTRAINT `fk_room_abstract_room1`
    FOREIGN KEY (`abstract_room_id`)
    REFERENCES `mydb`.`abstract_room` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_room_type1`
    FOREIGN KEY (`type_id`)
    REFERENCES `mydb`.`type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order_item` (
  `order_id` INT NOT NULL,
  `room_number` INT NOT NULL,
  PRIMARY KEY (`order_id`, `room_number`),
  INDEX `fk_booking_has_room_room1_idx` (`room_number` ASC),
  INDEX `fk_booking_has_room_booking1_idx` (`order_id` ASC),
  CONSTRAINT `fk_booking_has_room_booking1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_has_room_room1`
    FOREIGN KEY (`room_number`)
    REFERENCES `mydb`.`room` (`number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(10) NOT NULL,
  `price` DOUBLE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order_has_service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order_has_service` (
  `order_id` INT NOT NULL,
  `service_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `service_id`),
  INDEX `fk_order_has_service_service1_idx` (`service_id` ASC),
  INDEX `fk_order_has_service_order1_idx` (`order_id` ASC),
  CONSTRAINT `fk_order_has_service_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_has_service_service1`
    FOREIGN KEY (`service_id`)
    REFERENCES `mydb`.`service` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
