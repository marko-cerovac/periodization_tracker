-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema periodization_tracker
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `periodization_tracker` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `periodization_tracker` ;

-- -----------------------------------------------------
-- Table `periodization_tracker`.`target_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`target_types` (
  `target_type_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`target_type_id`),
  UNIQUE INDEX `id_UNIQUE` (`target_type_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Types of targets.\nThis table should contain entries like:\n- muscle\n- tendon\n- coordination\n- balance';


-- -----------------------------------------------------
-- Table `periodization_tracker`.`targets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`targets` (
  `target_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `latin_name` VARCHAR(255) NULL,
  `description` MEDIUMTEXT NULL,
  `target_type_id` INT NOT NULL,
  PRIMARY KEY (`target_id`),
  UNIQUE INDEX `idtargets_UNIQUE` (`target_id` ASC) VISIBLE,
  INDEX `fk_targets_target_types_idx` (`target_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_targets_target_types`
    FOREIGN KEY (`target_type_id`)
    REFERENCES `periodization_tracker`.`target_types` (`target_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This table is the parrent for all targets that can be hit by an exercise.';


-- -----------------------------------------------------
-- Table `periodization_tracker`.`exercise_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`exercise_types` (
  `exercise_type_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`exercise_type_id`),
  UNIQUE INDEX `idexercise_type_id_UNIQUE` (`exercise_type_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'This table should contain entries like:\n- freeweight\n- machine\n- calistenic\n- pliometric';


-- -----------------------------------------------------
-- Table `periodization_tracker`.`pp_aspects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`pp_aspects` (
  `pp_aspect_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`pp_aspect_id`),
  UNIQUE INDEX `idpp_aspects_UNIQUE` (`pp_aspect_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'This table contains aspects of physical preparednes like:\n- hypertrophy\n- static strength\n- dynamic strength\n- tendon stiffness\n- technique';


-- -----------------------------------------------------
-- Table `periodization_tracker`.`repetition_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`repetition_types` (
  `repetition_type_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`repetition_type_id`),
  UNIQUE INDEX `repetition_type_id_UNIQUE` (`repetition_type_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'This table houses types of repetitions like:\n- slow\n- fast\n- moderate\n- high intention\n- full range\n- partial range\n- isometric';


-- -----------------------------------------------------
-- Table `periodization_tracker`.`exercises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`exercises` (
  `exercise_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `exercise_type_id` INT NOT NULL,
  PRIMARY KEY (`exercise_id`),
  UNIQUE INDEX `exercise_id_UNIQUE` (`exercise_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `fk_exercises_exercise_types1_idx` (`exercise_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_exercises_exercise_types1`
    FOREIGN KEY (`exercise_type_id`)
    REFERENCES `periodization_tracker`.`exercise_types` (`exercise_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'This table contains exercises like:\n- Clean&Jerk\n- Tall Snatch\n- Peck Deck\n- 40m Sprint';


-- -----------------------------------------------------
-- Table `periodization_tracker`.`exercise_targets_pp_aspects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`exercise_targets_pp_aspects` (
  `exercise_id` INT NOT NULL,
  `pp_aspect_id` INT NOT NULL,
  PRIMARY KEY (`exercise_id`, `pp_aspect_id`),
  INDEX `fk_exercises_has_pp_aspects_pp_aspects1_idx` (`pp_aspect_id` ASC) VISIBLE,
  INDEX `fk_exercises_has_pp_aspects_exercises1_idx` (`exercise_id` ASC) VISIBLE,
  CONSTRAINT `fk_exercises_has_pp_aspects_exercises1`
    FOREIGN KEY (`exercise_id`)
    REFERENCES `periodization_tracker`.`exercises` (`exercise_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_exercises_has_pp_aspects_pp_aspects1`
    FOREIGN KEY (`pp_aspect_id`)
    REFERENCES `periodization_tracker`.`pp_aspects` (`pp_aspect_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `periodization_tracker`.`exercise_hits_targets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`exercise_hits_targets` (
  `exercise_id` INT NOT NULL,
  `target_id` INT NOT NULL,
  PRIMARY KEY (`exercise_id`, `target_id`),
  INDEX `fk_exercises_has_targets_targets1_idx` (`target_id` ASC) VISIBLE,
  INDEX `fk_exercises_has_targets_exercises1_idx` (`exercise_id` ASC) VISIBLE,
  CONSTRAINT `fk_exercises_has_targets_exercises1`
    FOREIGN KEY (`exercise_id`)
    REFERENCES `periodization_tracker`.`exercises` (`exercise_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_exercises_has_targets_targets1`
    FOREIGN KEY (`target_id`)
    REFERENCES `periodization_tracker`.`targets` (`target_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `periodization_tracker`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `age` INT UNSIGNED NULL,
  `gender` ENUM('Male', 'Female', 'AlphabetPerson') NULL,
  `weight` DOUBLE NULL,
  `height` DOUBLE NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `periodization_tracker`.`sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`sessions` (
  `session_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`session_id`),
  UNIQUE INDEX `session_id_UNIQUE` (`session_id` ASC) VISIBLE,
  INDEX `fk_sessions_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_sessions_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `periodization_tracker`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `periodization_tracker`.`sets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`sets` (
  `set_id` INT NOT NULL AUTO_INCREMENT,
  `number_of_repetitions` INT UNSIGNED NULL,
  `rest_duration` INT UNSIGNED NULL,
  `weight` DOUBLE NULL,
  `rpe` INT UNSIGNED NULL,
  `block` TINYINT NULL,
  `exercise_id` INT NOT NULL,
  `repetition_type_id` INT NOT NULL,
  `session_id` INT NOT NULL,
  PRIMARY KEY (`set_id`),
  INDEX `fk_sets_repetition_types1_idx` (`repetition_type_id` ASC) VISIBLE,
  INDEX `fk_sets_sessions1_idx` (`session_id` ASC) VISIBLE,
  UNIQUE INDEX `set_id_UNIQUE` (`set_id` ASC) VISIBLE,
  CONSTRAINT `fk_sets_exercises1`
    FOREIGN KEY (`exercise_id`)
    REFERENCES `periodization_tracker`.`exercises` (`exercise_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sets_repetition_types1`
    FOREIGN KEY (`repetition_type_id`)
    REFERENCES `periodization_tracker`.`repetition_types` (`repetition_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sets_sessions1`
    FOREIGN KEY (`session_id`)
    REFERENCES `periodization_tracker`.`sessions` (`session_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This table contains entries that represent a single set.\nA single set is comprised of an exercise performed for a number of repetitions in a given session';


-- -----------------------------------------------------
-- Table `periodization_tracker`.`session_targets_pp_aspects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`session_targets_pp_aspects` (
  `session_id` INT NOT NULL,
  `pp_aspect_id` INT NOT NULL,
  PRIMARY KEY (`session_id`, `pp_aspect_id`),
  INDEX `fk_sessions_has_pp_aspects_pp_aspects1_idx` (`pp_aspect_id` ASC) VISIBLE,
  INDEX `fk_sessions_has_pp_aspects_sessions1_idx` (`session_id` ASC) VISIBLE,
  CONSTRAINT `fk_sessions_has_pp_aspects_sessions1`
    FOREIGN KEY (`session_id`)
    REFERENCES `periodization_tracker`.`sessions` (`session_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sessions_has_pp_aspects_pp_aspects1`
    FOREIGN KEY (`pp_aspect_id`)
    REFERENCES `periodization_tracker`.`pp_aspects` (`pp_aspect_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `periodization_tracker`.`training_blocks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`training_blocks` (
  `training_block_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `description` MEDIUMTEXT NULL,
  `duration` INT UNSIGNED NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`training_block_id`),
  UNIQUE INDEX `training_block_id_UNIQUE` (`training_block_id` ASC) VISIBLE,
  INDEX `fk_training_blocks_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_training_blocks_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `periodization_tracker`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `periodization_tracker`.`training_block_has_sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`training_block_has_sessions` (
  `training_block_id` INT NOT NULL,
  `session_id` INT NOT NULL,
  PRIMARY KEY (`training_block_id`, `session_id`),
  INDEX `fk_training_blocks_has_sessions_sessions1_idx` (`session_id` ASC) VISIBLE,
  INDEX `fk_training_blocks_has_sessions_training_blocks1_idx` (`training_block_id` ASC) VISIBLE,
  CONSTRAINT `fk_training_blocks_has_sessions_training_blocks1`
    FOREIGN KEY (`training_block_id`)
    REFERENCES `periodization_tracker`.`training_blocks` (`training_block_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_training_blocks_has_sessions_sessions1`
    FOREIGN KEY (`session_id`)
    REFERENCES `periodization_tracker`.`sessions` (`session_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `periodization_tracker`.`training_plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`training_plans` (
  `training_plan_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`training_plan_id`),
  UNIQUE INDEX `training_plan_id_UNIQUE` (`training_plan_id` ASC) VISIBLE,
  INDEX `fk_training_plans_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_training_plans_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `periodization_tracker`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `periodization_tracker`.`training_plan_has_training_blocks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`training_plan_has_training_blocks` (
  `training_plan_id` INT NOT NULL,
  `training_block_id` INT NOT NULL,
  PRIMARY KEY (`training_plan_id`, `training_block_id`),
  INDEX `fk_training_plan_has_training_blocks_training_blocks1_idx` (`training_block_id` ASC) VISIBLE,
  INDEX `fk_training_plan_has_training_blocks_training_plan1_idx` (`training_plan_id` ASC) VISIBLE,
  CONSTRAINT `fk_training_plan_has_training_blocks_training_plan1`
    FOREIGN KEY (`training_plan_id`)
    REFERENCES `periodization_tracker`.`training_plans` (`training_plan_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_training_plan_has_training_blocks_training_blocks1`
    FOREIGN KEY (`training_block_id`)
    REFERENCES `periodization_tracker`.`training_blocks` (`training_block_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `periodization_tracker` ;

-- -----------------------------------------------------
-- Placeholder table for view `periodization_tracker`.`muscles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`muscles` (`id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `periodization_tracker`.`tendons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`tendons` (`target_id` INT, `name` INT, `latin_name` INT, `description` INT, `type` INT);

-- -----------------------------------------------------
-- View `periodization_tracker`.`muscles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `periodization_tracker`.`muscles`;
USE `periodization_tracker`;
CREATE  OR REPLACE VIEW `muscles` AS
SELECT
	targets.target_id,
    targets.name,
    targets.latin_name,
    targets.description,
    target_types.name as type
FROM targets
JOIN target_types ON targets.target_id = target_types.target_type_id
WHERE target_types.name = 'muscle';

-- -----------------------------------------------------
-- View `periodization_tracker`.`tendons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `periodization_tracker`.`tendons`;
USE `periodization_tracker`;
CREATE  OR REPLACE VIEW `tendons` AS
    SELECT 
        targets.target_id,
        targets.name,
        targets.latin_name,
        targets.description,
        target_types.name AS type
    FROM
        targets
            JOIN
        target_types ON targets.target_type_id = target_types.target_type_id
    WHERE
        target_types.name = 'tendon';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
