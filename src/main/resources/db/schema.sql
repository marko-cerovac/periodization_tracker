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
-- Table `periodization_tracker`.`sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`sessions` (
  `session_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` MEDIUMTEXT NULL,
  PRIMARY KEY (`session_id`),
  UNIQUE INDEX `session_id_UNIQUE` (`session_id` ASC) VISIBLE)
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
  `is_done` TINYINT NOT NULL,
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
-- Table `periodization_tracker`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `gender` ENUM('Male', 'Female', 'AlphabetPerson') NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE)
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


-- -----------------------------------------------------
-- Table `periodization_tracker`.`user_logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`user_logs` (
  `user_log_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `age` INT NULL,
  `weight` DOUBLE NULL,
  `height` DOUBLE NULL,
  `bodyfat_percentage` DOUBLE NULL,
  `satisfaction` TINYINT(8) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`user_log_id`),
  INDEX `fk_user_logs_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_logs_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `periodization_tracker`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `periodization_tracker`.`session_logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`session_logs` (
  `session_log_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `difficulty` TINYINT(8) UNSIGNED NULL,
  `session_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`session_log_id`),
  UNIQUE INDEX `session_log_id_UNIQUE` (`session_log_id` ASC) VISIBLE,
  INDEX `fk_session_logs_sessions1_idx` (`session_id` ASC) VISIBLE,
  INDEX `fk_session_logs_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_session_logs_sessions1`
    FOREIGN KEY (`session_id`)
    REFERENCES `periodization_tracker`.`sessions` (`session_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_session_logs_users1`
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
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_training_blocks_has_sessions_sessions1`
    FOREIGN KEY (`session_id`)
    REFERENCES `periodization_tracker`.`sessions` (`session_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `periodization_tracker`;

-- -----------------------------------------------------
-- Placeholder table for view `periodization_tracker`.`exercises_with_targets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`exercises_with_targets` (`exercise_id` INT, `name` INT, `description` INT, `exercise_type_id` INT, `target_id` INT, `target_name` INT, `target_latin_name` INT, `target_description` INT, `target_type_id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `periodization_tracker`.`sets_and_exercises_per_session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `periodization_tracker`.`sets_and_exercises_per_session` (`name` INT, `description` INT, `exercise_type_id` INT, `repetition_type_id` INT, `session_id` INT, `number_of_repetitions` INT, `rest_duration` INT, `weight` INT, `set_id` INT, `rpe` INT, `block` INT, `exercise_id` INT);

-- -----------------------------------------------------
-- procedure add_user_log
-- -----------------------------------------------------

DELIMITER $$
USE `periodization_tracker`$$
CREATE PROCEDURE add_user_log(
    IN p_date DATETIME,
    IN p_age INT,
    IN p_weight DOUBLE,
    IN p_height DOUBLE,
    IN p_bodyfat_percentage DOUBLE,
    IN p_satisfaction TINYINT,
    IN p_user_id INT
)
BEGIN
    DECLARE last_age INT;

    IF p_age IS NULL THEN
        SELECT age INTO last_age
        FROM user_logs
        WHERE user_id = p_user_id
        ORDER BY `date` DESC
        LIMIT 1;
        
        -- if the age is still null, just set it to 18
        IF last_age IS NULL THEN SET last_age = 18; END IF;
    ELSE
        SET last_age = p_age;
    END IF;

    INSERT INTO user_logs (`date`, age, weight, height, bodyfat_percentage, satisfaction, user_id)
    VALUES (p_date, last_age, p_weight, p_height, p_bodyfat_percentage, p_satisfaction, p_user_id);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `periodization_tracker`.`exercises_with_targets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `periodization_tracker`.`exercises_with_targets`;
USE `periodization_tracker`;
CREATE  OR REPLACE VIEW `exercises_with_targets` AS
SELECT e.*, t.target_id, t.name AS target_name,
t.latin_name AS target_latin_name, t.description AS target_description, t.target_type_id
FROM exercises e
LEFT JOIN exercise_hits_targets eht ON e.exercise_id = eht.exercise_id
LEFT JOIN targets t ON eht.target_id = t.target_id;

-- -----------------------------------------------------
-- View `periodization_tracker`.`sets_and_exercises_per_session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `periodization_tracker`.`sets_and_exercises_per_session`;
USE `periodization_tracker`;
CREATE  OR REPLACE VIEW `sets_and_exercises_per_session` AS
SELECT e.name, e.description, 
e.exercise_type_id, s.repetition_type_id, s.session_id, 
s.number_of_repetitions, s.rest_duration, s.weight, 
s.set_id, s.rpe, s.block, e.exercise_id 
FROM exercises e 
LEFT JOIN sets s ON e.exercise_id = s.exercise_id;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
USE `periodization_tracker`;

DELIMITER $$
USE `periodization_tracker`$$
CREATE DEFINER = CURRENT_USER TRIGGER `periodization_tracker`.`users_AFTER_INSERT` AFTER INSERT ON `users` FOR EACH ROW
BEGIN
    INSERT INTO user_logs ( `date`, `age`, `weight`, `height`, `bodyfat_percentage`, `satisfaction`, `user_id`)
    VALUES (NOW(), 18, 80.0, 175.0, 15.0, 5, NEW.user_id);
END$$

DELIMITER ;
