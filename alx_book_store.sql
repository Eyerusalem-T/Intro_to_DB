

SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS `alx_book_store`
  DEFAULT CHARACTER SET = utf8mb4
  DEFAULT COLLATE = utf8mb4_unicode_ci;
USE `alx_book_store`;

SET FOREIGN_KEY_CHECKS = 1;

-- AUTHORS table
CREATE TABLE IF NOT EXISTS `AUTHORS` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `author_name` VARCHAR(215) NOT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- BOOKS table
CREATE TABLE IF NOT EXISTS `BOOKS` (
  `book_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(130) NOT NULL,
  `author_id` INT NOT NULL,
  `price` DOUBLE NOT NULL,
  `publication_date` DATE NULL,
  PRIMARY KEY (`book_id`),
  INDEX `idx_books_author` (`author_id`),
  CONSTRAINT `fk_books_author`
    FOREIGN KEY (`author_id`) REFERENCES `AUTHORS`(`author_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- CUSTOMERS table
CREATE TABLE IF NOT EXISTS `CUSTOMERS` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(215) NOT NULL,
  `email` VARCHAR(215) NOT NULL UNIQUE,
  `address` TEXT,
  PRIMARY KEY (`customer_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ORDERS table
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
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ORDER_DETAILS table
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
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- OPTIONAL: Basic sample data to test the schema
INSERT INTO `AUTHORS` (`author_name`) VALUES
  ('J. K. Rowling'),
  ('George R. R. Martin'),
  ('Isaac Asimov');

INSERT INTO `BOOKS` (`title`, `author_id`, `price`, `publication_date`) VALUES
  ('Harry Potter and the Philosopher''s Stone', 1, 9.99, '1997-06-26'),
  ('A Game of Thrones', 2, 12.50, '1996-08-06'),
  ('Foundation', 3, 8.00, '1951-06-01');

INSERT INTO `CUSTOMERS` (`customer_name`, `email`, `address`) VALUES
  ('Alice Johnson', 'alice@example.com', '123 Maple St, Springfield'),
  ('Bob Smith', 'bob@example.com', '456 Oak St, Springfield');

INSERT INTO `ORDERS` (`customer_id`, `order_date`) VALUES
  (1, CURRENT_DATE),
  (2, CURRENT_DATE);

INSERT INTO `ORDER_DETAILS` (`order_id`, `book_id`, `quantity`) VALUES
  (1, 1, 1),
  (1, 3, 2),
  (2, 2, 1);

-- SAMPLE QUERIES (for testing)
-- 1) List all books with their author names:
SELECT B.`book_id`, B.`title`, A.`author_name`, B.`price`, B.`publication_date`
FROM `BOOKS` B
JOIN `AUTHORS` A ON B.`author_id` = A.`author_id`;

-- 2) Show a customer's orders and order details:
SELECT C.`customer_name`, O.`order_id`, O.`order_date`, OD.`orderdetailid`, B.`title`, OD.`quantity`, B.`price`
FROM `CUSTOMERS` C
JOIN `ORDERS` O ON C.`customer_id` = O.`customer_id`
JOIN `ORDER_DETAILS` OD ON O.`order_id` = OD.`order_id`
JOIN `BOOKS` B ON OD.`book_id` = B.`book_id`
WHERE C.`customer_id` = 1
ORDER BY O.`order_date` DESC;

-- 3) Compute total value for a specific order:
SELECT O.`order_id`,
       SUM(OD.`quantity` * B.`price`) AS order_total
FROM `ORDERS` O
JOIN `ORDER_DETAILS` OD ON O.`order_id` = OD.`order_id`
JOIN `BOOKS` B ON OD.`book_id` = B.`book_id`
WHERE O.`order_id` = 1
GROUP BY O.`order_id`;
