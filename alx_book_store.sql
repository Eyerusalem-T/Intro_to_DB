
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS `alx_book_store`
  DEFAULT CHARACTER SET = utf8mb4
  DEFAULT COLLATE = utf8mb4_unicode_ci;

USE `alx_book_store`;

SET FOREIGN_KEY_CHECKS = 1;

-- =========================================================
--  AUTHORS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS `AUTHORS` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `author_name` VARCHAR(215) NOT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- =========================================================
--  BOOKS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS `BOOKS` (
  `book_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(130) NOT NULL,
  `author_id` INT NOT NULL,
  `price` DOUBLE NOT NULL,
  `publication_date` DATE,
  PRIMARY KEY (`book_id`),
  INDEX `idx_books_author` (`author_id`),
  CONSTRAINT `fk_books_author`
    FOREIGN KEY (`author_id`) REFERENCES `AUTHORS`(`author_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- =========================================================
--  CUSTOMERS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS `CUSTOMERS` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(215) NOT NULL,
  `email` VARCHAR(215) NOT NULL UNIQUE,
  `address` TEXT,
  PRIMARY KEY (`customer_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- =========================================================
--  ORDERS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS `ORDERS` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `idx_orders_customer` (`customer_id`),
  CONSTRAINT `fk_orders_customer`
    FOREIGN KEY (`customer_id`) REFERENCES `CUSTOMERS`(`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- =========================================================
--  ORDER DETAILS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS `ORDER_DETAILS` (
  `orderdetailid` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `quantity` DOUBLE NOT NULL,
  PRIMARY KEY (`orderdetailid`),
  INDEX `idx_od_order` (`order_id`),
  INDEX `idx_od_book` (`book_id`),
  CONSTRAINT `fk_od_order`
    FOREIGN KEY (`order_id`) REFERENCES `ORDERS`(`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_od_book`
    FOREIGN KEY (`book_id`) REFERENCES `BOOKS`(`book_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- =========================================================
--  SAMPLE DATA
-- =========================================================
INSERT INTO `AUTHORS` (`author_name`) VALUES
  ('J. K. Rowling'),
  ('George R. R. Martin'),
  ('Isa
