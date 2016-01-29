-- MySQL Script generated by MySQL Workbench
-- 01/27/16 14:37:26
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema sdd-ufg
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sdd-ufg
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sdd-ufg` DEFAULT CHARACTER SET utf8 ;
USE `sdd-ufg` ;

-- -----------------------------------------------------
-- Table `sdd-ufg`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`courses` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`knowledges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`knowledges` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`subjects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`subjects` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `theoretical_workload` INT(5) NOT NULL,
  `practical_workload` INT(5) NOT NULL,
  `knowledge_id` INT(11) NOT NULL,
  `course_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `course_id` (`course_id` ASC, `knowledge_id` ASC),
  INDEX `knowledge_id` (`knowledge_id` ASC),
  CONSTRAINT `subjects_ibfk_1`
    FOREIGN KEY (`course_id`)
    REFERENCES `sdd-ufg`.`courses` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `subjects_ibfk_2`
    FOREIGN KEY (`knowledge_id`)
    REFERENCES `sdd-ufg`.`knowledges` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`processes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`processes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `initial_date` DATE NOT NULL,
  `teacher_intent_date` DATE NOT NULL,
  `primary_distribution_date` DATE NOT NULL,
  `substitute_intent_date` DATE NOT NULL,
  `secondary_distribution_date` DATE NOT NULL,
  `final_date` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`clazzes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`clazzes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `vacancies` INT(11) NOT NULL,
  `subject_id` INT(11) NOT NULL,
  `process_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `subject_id` (`subject_id` ASC, `process_id` ASC),
  INDEX `process_id` (`process_id` ASC),
  CONSTRAINT `clazzes_ibfk_1`
    FOREIGN KEY (`subject_id`)
    REFERENCES `sdd-ufg`.`subjects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `clazzes_ibfk_2`
    FOREIGN KEY (`process_id`)
    REFERENCES `sdd-ufg`.`processes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`schedules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`schedules` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `week_day` INT(2) NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`locals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`locals` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `address` TEXT NULL DEFAULT NULL,
  `capacity` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`clazzes_schedules_locals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`clazzes_schedules_locals` (
  `clazz_id` INT(11) NOT NULL,
  `schedule_id` INT(11) NOT NULL,
  `local_id` INT(11) NOT NULL,
  PRIMARY KEY (`clazz_id`, `schedule_id`, `local_id`),
  INDEX `clazz_id` (`clazz_id` ASC, `schedule_id` ASC, `local_id` ASC),
  INDEX `schedule_id` (`schedule_id` ASC),
  INDEX `local_id` (`local_id` ASC),
  CONSTRAINT `clazzes_schedules_locals_ibfk_1`
    FOREIGN KEY (`clazz_id`)
    REFERENCES `sdd-ufg`.`clazzes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `clazzes_schedules_locals_ibfk_2`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `sdd-ufg`.`schedules` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `clazzes_schedules_locals_ibfk_3`
    FOREIGN KEY (`local_id`)
    REFERENCES `sdd-ufg`.`locals` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `login` VARCHAR(50) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `is_admin` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`teachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`teachers` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NULL DEFAULT NULL,
  `registry` VARCHAR(20) NOT NULL,
  `url_lattes` TEXT NULL DEFAULT NULL,
  `entry_date` DATE NOT NULL,
  `formation` VARCHAR(100) NULL DEFAULT NULL,
  `workload` INT(11) NOT NULL,
  `about` TEXT NULL DEFAULT NULL,
  `rg` VARCHAR(15) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `birth_date` DATE NOT NULL,
  `situation` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC),
  CONSTRAINT `teachers_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `sdd-ufg`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`clazzes_teachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`clazzes_teachers` (
  `clazz_id` INT(11) NOT NULL,
  `teacher_id` INT(11) NOT NULL,
  `status` VARCHAR(50) NOT NULL DEFAULT 'PENDING',
  PRIMARY KEY (`clazz_id`, `teacher_id`),
  INDEX `clazz_id` (`clazz_id` ASC, `teacher_id` ASC),
  INDEX `teacher_id` (`teacher_id` ASC),
  CONSTRAINT `clazzes_teachers_ibfk_1`
    FOREIGN KEY (`clazz_id`)
    REFERENCES `sdd-ufg`.`clazzes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `clazzes_teachers_ibfk_2`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `sdd-ufg`.`teachers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`knowledges_teachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`knowledges_teachers` (
  `teacher_id` INT(11) NOT NULL,
  `knowledge_id` INT(11) NOT NULL,
  `level` INT(2) NOT NULL DEFAULT '3',
  PRIMARY KEY (`teacher_id`, `knowledge_id`),
  INDEX `knowledge_id` (`knowledge_id` ASC, `teacher_id` ASC),
  CONSTRAINT `knowledges_teachers_ibfk_1`
    FOREIGN KEY (`knowledge_id`)
    REFERENCES `sdd-ufg`.`knowledges` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `knowledges_teachers_ibfk_2`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `sdd-ufg`.`teachers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`phinxlog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`phinxlog` (
  `version` BIGINT(20) NOT NULL,
  `start_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`version`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`process_configurations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`process_configurations` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(50) NOT NULL DEFAULT 'CRITERIA',
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `data_type` VARCHAR(45) NOT NULL,
  `value` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`processes_process_configurations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`processes_process_configurations` (
  `process_id` INT(11) NOT NULL,
  `process_configuration_id` INT(11) NOT NULL,
  PRIMARY KEY (`process_id`, `process_configuration_id`),
  INDEX `process_configuration_id` (`process_configuration_id` ASC, `process_id` ASC),
  CONSTRAINT `processes_process_configurations_ibfk_1`
    FOREIGN KEY (`process_configuration_id`)
    REFERENCES `sdd-ufg`.`process_configurations` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `processes_process_configurations_ibfk_2`
    FOREIGN KEY (`process_id`)
    REFERENCES `sdd-ufg`.`processes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`roles` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(50) NOT NULL DEFAULT 'COORDINATOR',
  `teacher_id` INT(11) NOT NULL,
  `knowledge_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `knowledge_id` (`knowledge_id` ASC, `teacher_id` ASC),
  INDEX `teacher_id` (`teacher_id` ASC),
  CONSTRAINT `roles_ibfk_1`
    FOREIGN KEY (`knowledge_id`)
    REFERENCES `sdd-ufg`.`knowledges` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `roles_ibfk_2`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `sdd-ufg`.`teachers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sdd-ufg`.`teachers_change_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sdd-ufg`.`teachers_change_history` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `teacher_id` INT(11) NOT NULL,
  `modification_date` DATETIME NULL DEFAULT NULL,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `is_admin` TINYINT(1) NOT NULL DEFAULT '0',
  `registry` VARCHAR(20) NOT NULL,
  `url_lattes` TEXT NULL DEFAULT NULL,
  `entry_date` DATE NOT NULL,
  `formation` VARCHAR(100) NULL DEFAULT NULL,
  `workload` INT(11) NOT NULL,
  `about` TEXT NULL DEFAULT NULL,
  `rg` VARCHAR(15) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `birth_date` DATE NOT NULL,
  `situation` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `teacher_id` (`teacher_id` ASC),
  CONSTRAINT `teachers_change_history_ibfk_1`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `sdd-ufg`.`teachers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
