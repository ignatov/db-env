/*

Sakila for Interbase/Firebird is a port of the Sakila example database available for MySQL, which was originally developed by Mike Hillyer of the MySQL AB documentation team. 
This project is designed to help database administrators to decide which database to use for development of new products
The user can run the same SQL against different kind of databases and compare the performance

License: BSD
Copyright DB Software Laboratory
http://www.etl-tools.com

*/

--
-- Table structure for table actor
--
--DROP TABLE actor;

CREATE TABLE actor (
  actor_id numeric NOT NULL ,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY  (actor_id)
  );

CREATE  INDEX idx_actor_last_name ON actor(last_name);
 
--DROP GENERATOR actor_generator;

CREATE GENERATOR actor_generator;

SET TERM ^ ;

CREATE TRIGGER actor_before_trigger FOR actor
ACTIVE
BEFORE INSERT
AS
BEGIN
  IF (NEW.actor_id IS NULL)
    THEN NEW.actor_id = GEN_ID(actor_generator, 1) ;
    NEW.last_update=current_timestamp;
END^

CREATE TRIGGER actor_before_update FOR actor
ACTIVE
BEFORE UPDATE
AS
BEGIN
  NEW.last_update=current_timestamp;
END^

SET TERM ; ^

--
-- Table structure for table country
--

CREATE TABLE country (
  country_id SMALLINT NOT NULL,
  country VARCHAR(50) NOT NULL,
  last_update TIMESTAMP,
  PRIMARY KEY  (country_id)
);

---DROP GENERATOR country_generator;

CREATE GENERATOR country_generator;

SET TERM ^ ;

CREATE TRIGGER country_before_trigger FOR country
ACTIVE
BEFORE INSERT
AS
BEGIN
  IF (NEW.country_id IS NULL)
    THEN NEW.country_id = GEN_ID(country_generator, 1) ;
    NEW.last_update=current_timestamp;
END^

CREATE TRIGGER country_before_update FOR country
ACTIVE
BEFORE UPDATE
AS
BEGIN
  NEW.last_update=current_timestamp;
END^

SET TERM ; ^

--
-- Table structure for table city
--

CREATE TABLE city (
  city_id int NOT NULL,
  city VARCHAR(50) NOT NULL,
  country_id SMALLINT NOT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY  (city_id),
  CONSTRAINT fk_city_country FOREIGN KEY (country_id) REFERENCES country (country_id) ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE  INDEX idx_fk_country_id ON city(country_id);

--- DROP GENERATOR city_generator;

CREATE GENERATOR city_generator;

SET TERM ^ ;

CREATE TRIGGER city_before_trigger FOR city
ACTIVE
BEFORE INSERT
AS
BEGIN
  IF (NEW.city_id IS NULL)
    THEN NEW.city_id = GEN_ID(city_generator, 1) ;
    NEW.last_update=current_timestamp;
END^

CREATE TRIGGER city_before_update FOR city
ACTIVE
BEFORE UPDATE
AS
BEGIN
  NEW.last_update=current_timestamp;
END^

SET TERM ; ^

--
-- Table structure for table address
--

CREATE TABLE address (
  address_id int NOT NULL,
  address VARCHAR(50) NOT NULL,
  address2 VARCHAR(50) DEFAULT NULL,
  district VARCHAR(20) NOT NULL,
  city_id INT  NOT NULL,
  postal_code VARCHAR(10) DEFAULT NULL,
  phone VARCHAR(20) NOT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY  (address_id)
);

CREATE  INDEX idx_fk_city_id ON address(city_id);

ALTER TABLE address ADD  CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE NO ACTION ON UPDATE CASCADE;

  --DROP GENERATOR city_generator;

CREATE GENERATOR address_generator;

SET TERM ^ ;

CREATE TRIGGER address_before_trigger FOR address
ACTIVE
BEFORE INSERT
AS
BEGIN
  IF (NEW.address_id IS NULL)
    THEN NEW.address_id = GEN_ID(address_generator, 1) ;
    NEW.last_update=current_timestamp;
END^

CREATE TRIGGER address_before_update FOR address
ACTIVE
BEFORE UPDATE
AS
BEGIN
  NEW.last_update=current_timestamp;
END^

SET TERM ; ^


--
-- Table structure for table language
--

CREATE TABLE language (
  language_id SMALLINT NOT NULL ,
  name CHAR(20) NOT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY (language_id)
);

---DROP GENERATOR language_generator;

CREATE GENERATOR language_generator;

SET TERM ^ ;

CREATE TRIGGER language_before_trigger FOR language
ACTIVE
BEFORE INSERT
AS
BEGIN
  IF (NEW.language_id IS NULL)
    THEN NEW.language_id = GEN_ID(language_generator, 1) ;
    NEW.last_update=current_timestamp;
END^

CREATE TRIGGER language_before_update FOR language
ACTIVE
BEFORE UPDATE
AS
BEGIN
  NEW.last_update=current_timestamp;
END^

SET TERM ; ^

--
-- Table structure for table category
--

CREATE TABLE category (
  category_id SMALLINT NOT NULL,
  name VARCHAR(25) NOT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY  (category_id)
);

---DROP GENERATOR category_generator;

CREATE GENERATOR category_generator;

SET TERM ^ ;

CREATE TRIGGER category_before_trigger FOR category
ACTIVE
BEFORE INSERT
AS
BEGIN
  IF (NEW.category_id IS NULL)
    THEN NEW.category_id = GEN_ID(category_generator, 1) ;
    NEW.last_update=current_timestamp;
END^

CREATE TRIGGER category_before_update FOR category
ACTIVE
BEFORE UPDATE
AS
BEGIN
  NEW.last_update=current_timestamp;
END^

SET TERM ; ^


--
-- Table structure for table customer
--

CREATE TABLE customer (
  customer_id INT NOT NULL,
  store_id INT NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  email VARCHAR(50) DEFAULT NULL,
  address_id INT NOT NULL,
  active CHAR(1) DEFAULT 'Y' NOT NULL,
  create_date TIMESTAMP NOT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY  (customer_id),
  CONSTRAINT fk_customer_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE  INDEX idx_customer_fk_store_id ON customer(store_id);
CREATE  INDEX idx_customer_fk_address_id ON customer(address_id);
CREATE  INDEX idx_customer_last_name ON customer(last_name);

---DROP GENERATOR customer_generator;

CREATE GENERATOR customer_generator;

SET TERM ^ ;

CREATE TRIGGER customer_before_trigger FOR customer
ACTIVE
BEFORE INSERT
AS
BEGIN
  IF (NEW.customer_id IS NULL)
    THEN NEW.customer_id = GEN_ID(customer_generator, 1) ;
    NEW.last_update=current_timestamp;
    NEW.create_date=current_timestamp;
END^

CREATE TRIGGER customer_before_update FOR customer
ACTIVE
BEFORE UPDATE
AS
BEGIN
  NEW.last_update=current_timestamp;
END^

SET TERM ; ^

--
-- Table structure for table film
--

CREATE TABLE film (
  film_id int NOT NULL,
  title VARCHAR(255) NOT NULL,
  description BLOB SUB_TYPE TEXT DEFAULT NULL,
  release_year VARCHAR(4) DEFAULT NULL,
  language_id SMALLINT NOT NULL,
  original_language_id SMALLINT DEFAULT NULL,
  rental_duration SMALLINT  DEFAULT 3 NOT NULL,
  rental_rate DECIMAL(4,2) DEFAULT 4.99 NOT NULL,
  length SMALLINT DEFAULT NULL,
  replacement_cost DECIMAL(5,2) DEFAULT 19.99 NOT NULL,
  rating VARCHAR(10) DEFAULT 'G',
  special_features VARCHAR(100) DEFAULT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY  (film_id),
  CONSTRAINT fk_film_language FOREIGN KEY (language_id) REFERENCES language (language_id) ,
  CONSTRAINT fk_film_language_original FOREIGN KEY (original_language_id) REFERENCES language (language_id)
);

ALTER TABLE film ADD CONSTRAINT CHECK_special_features CHECK(special_features is null or
                                                              special_features like '%Trailers%' or
                                                              special_features like '%Commentaries%' or
                                                              special_features like '%Deleted Scenes%' or
                                                              special_features like '%Behind the Scenes%');

ALTER TABLE film ADD CONSTRAINT CHECK_special_rating CHECK(rating in ('G','PG','PG-13','R','NC-17'));
CREATE  INDEX idx_fk_language_id ON film(language_id);
CREATE  INDEX idx_fk_original_language_id ON film(original_language_id);

---DROP GENERATOR film_generator;

CREATE GENERATOR film_generator;

SET TERM ^ ;

CREATE TRIGGER film_before_trigger FOR film
ACTIVE
BEFORE INSERT
AS
BEGIN
 IF (NEW.film_id IS NULL)
   THEN NEW.film_id = GEN_ID(film_generator, 1) ;
    NEW.last_update=current_timestamp;
END^

CREATE TRIGGER film_before_update FOR film
ACTIVE
BEFORE UPDATE
AS
BEGIN
  NEW.last_update=current_timestamp;
END^

SET TERM ; ^


--
-- Table structure for table film_actor
--

CREATE TABLE film_actor (
  actor_id INT NOT NULL,
  film_id  INT NOT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY  (actor_id,film_id),
  CONSTRAINT fk_film_actor_actor FOREIGN KEY (actor_id) REFERENCES actor (actor_id) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT fk_film_actor_film FOREIGN KEY (film_id) REFERENCES film (film_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE  INDEX idx_fk_film_actor_film ON film_actor(film_id);

CREATE  INDEX idx_fk_film_actor_actor ON film_actor(actor_id) ;


SET TERM ^ ;

CREATE TRIGGER film_actor_before_trigger FOR film_actor
ACTIVE
BEFORE INSERT
AS
BEGIN
    NEW.last_update=current_timestamp;
END^

CREATE TRIGGER film_actor_before_update FOR film_actor
ACTIVE
BEFORE UPDATE
AS
BEGIN
  NEW.last_update=current_timestamp;
END^

SET TERM ; ^


--
-- Table structure for table film_category
--

CREATE TABLE film_category (
  film_id INT NOT NULL,
  category_id SMALLINT  NOT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY (film_id, category_id),
  CONSTRAINT fk_film_category_film FOREIGN KEY (film_id) REFERENCES film (film_id) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT fk_film_category_category FOREIGN KEY (category_id) REFERENCES category (category_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE  INDEX idx_fk_film_category_film ON film_category(film_id);

CREATE  INDEX idx_fk_film_category_category ON film_category(category_id);

SET TERM ^ ;

CREATE TRIGGER film_category_before_trigger FOR film_category
ACTIVE
BEFORE INSERT
AS
BEGIN
    NEW.last_update=current_timestamp;
END^

CREATE TRIGGER film_category_before_update FOR film_category
ACTIVE
BEFORE UPDATE
AS
BEGIN
  NEW.last_update=current_timestamp;
END^

SET TERM ; ^

--
-- Table structure for table film_text
--

CREATE TABLE film_text (
  film_id SMALLINT NOT NULL,
  title VARCHAR(255) NOT NULL,
  description BLOB SUB_TYPE TEXT,
  PRIMARY KEY  (film_id)
);

--
-- Table structure for table inventory
--

CREATE TABLE inventory (
  inventory_id INT NOT NULL,
  film_id INT NOT NULL,
  store_id INT NOT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY  (inventory_id),
  CONSTRAINT fk_inventory_film FOREIGN KEY (film_id) REFERENCES film (film_id) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE  INDEX idx_fk_film_id ON inventory(film_id);

CREATE  INDEX idx_fk_film_id_store_id ON inventory(store_id,film_id);

---DROP GENERATOR inventory_generator;

CREATE GENERATOR inventory_generator;

SET TERM ^ ;

CREATE TRIGGER inventory_before_trigger FOR inventory
ACTIVE
BEFORE INSERT
AS
BEGIN
 IF (NEW.inventory_id IS NULL)
   THEN NEW.inventory_id = GEN_ID(inventory_generator, 1) ;
    NEW.last_update=current_timestamp;
END^

CREATE TRIGGER inventory_before_update FOR inventory
ACTIVE
BEFORE UPDATE
AS
BEGIN
  NEW.last_update=current_timestamp;
END^

SET TERM ; ^

--
-- Table structure for table staff
--

CREATE TABLE staff (
  staff_id SMALLINT NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  address_id INT NOT NULL,
  picture BLOB DEFAULT NULL,
  email VARCHAR(50) DEFAULT NULL,
  store_id INT NOT NULL,
  active SMALLINT DEFAULT 1 NOT NULL,
  username VARCHAR(16) NOT NULL,
  password VARCHAR(40) DEFAULT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY  (staff_id),
  CONSTRAINT fk_staff_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE NO ACTION ON UPDATE CASCADE
);
CREATE  INDEX idx_fk_staff_store_id ON staff(store_id);

CREATE  INDEX idx_fk_staff_address_id ON staff(address_id);

---DROP GENERATOR inventory_generator;

CREATE GENERATOR staff_generator;

SET TERM ^ ;

CREATE TRIGGER staff_before_trigger FOR staff
ACTIVE
BEFORE INSERT
AS
BEGIN
 IF (NEW.staff_id IS NULL)
   THEN NEW.staff_id = GEN_ID(staff_generator, 1) ;
    NEW.last_update=current_timestamp;
END^

CREATE TRIGGER staff_before_update FOR staff
ACTIVE
BEFORE UPDATE
AS
BEGIN
  NEW.last_update=current_timestamp;
END^

SET TERM ; ^

--
-- Table structure for table store
--

CREATE TABLE store (
  store_id INT NOT NULL,
  manager_staff_id SMALLINT NOT NULL,
  address_id INT NOT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY  (store_id),
  CONSTRAINT fk_store_staff FOREIGN KEY (manager_staff_id) REFERENCES staff (staff_id) ,
  CONSTRAINT fk_store_address FOREIGN KEY (address_id) REFERENCES address (address_id)
);

CREATE  INDEX idx_store_fk_manager_staff_id ON store(manager_staff_id);

CREATE  INDEX idx_fk_store_address ON store(address_id);

---DROP GENERATOR store_generator;

CREATE GENERATOR store_generator;

SET TERM ^ ;

CREATE TRIGGER store_before_trigger FOR store
ACTIVE
BEFORE INSERT
AS
BEGIN
 IF (NEW.store_id IS NULL)
   THEN NEW.store_id = GEN_ID(store_generator, 1) ;
    NEW.last_update=current_timestamp;
END^

CREATE TRIGGER store_before_update FOR store
ACTIVE
BEFORE UPDATE
AS
BEGIN
  NEW.last_update=current_timestamp;
END^

SET TERM ; ^

--
-- Table structure for table payment
--

CREATE TABLE payment (
  payment_id int NOT NULL,
  customer_id INT  NOT NULL,
  staff_id SMALLINT NOT NULL,
  rental_id INT DEFAULT NULL,
  amount DECIMAL(5,2) NOT NULL,
  payment_date TIMESTAMP NOT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY  (payment_id),
  CONSTRAINT fk_payment_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ,
  CONSTRAINT fk_payment_staff FOREIGN KEY (staff_id) REFERENCES staff (staff_id)
);
CREATE  INDEX idx_fk_staff_id ON payment(staff_id);
CREATE  INDEX idx_fk_customer_id ON payment(customer_id);

---DROP GENERATOR payment_generator;

CREATE GENERATOR payment_generator;

SET TERM ^ ;

CREATE TRIGGER payment_before_trigger FOR payment
ACTIVE
BEFORE INSERT
AS
BEGIN
 IF (NEW.payment_id IS NULL)
   THEN NEW.payment_id = GEN_ID(payment_generator, 1) ;
    NEW.last_update=current_timestamp;
END^

CREATE TRIGGER payment_before_update FOR payment
ACTIVE
BEFORE UPDATE
AS
BEGIN
  NEW.last_update=current_timestamp;
END^

SET TERM ; ^


CREATE TABLE rental (
  rental_id INT NOT NULL,
  rental_date TIMESTAMP NOT NULL,
  inventory_id INT  NOT NULL,
  customer_id INT  NOT NULL,
  return_date TIMESTAMP DEFAULT NULL,
  staff_id SMALLINT  NOT NULL,
  last_update TIMESTAMP NOT NULL,
  PRIMARY KEY (rental_id),
  CONSTRAINT fk_rental_staff FOREIGN KEY (staff_id) REFERENCES staff (staff_id) ,
  CONSTRAINT fk_rental_inventory FOREIGN KEY (inventory_id) REFERENCES inventory (inventory_id) ,
  CONSTRAINT fk_rental_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);
CREATE INDEX idx_rental_fk_inventory_id ON rental(inventory_id);
CREATE INDEX idx_rental_fk_customer_id ON rental(customer_id);
CREATE INDEX idx_rental_fk_staff_id ON rental(staff_id);
CREATE UNIQUE INDEX   idx_rental_uq  ON rental (rental_date,inventory_id,customer_id);


---DROP GENERATOR payment_generator;

CREATE GENERATOR rental_generator;

SET TERM ^ ;

CREATE TRIGGER rental_before_trigger FOR rental
ACTIVE
BEFORE INSERT
AS
BEGIN
 IF (NEW.rental_id IS NULL)
   THEN NEW.rental_id = GEN_ID(rental_generator, 1) ;
    NEW.last_update=current_timestamp;
END^

CREATE TRIGGER rental_before_update FOR rental
ACTIVE
BEFORE UPDATE
AS
BEGIN
  NEW.last_update=current_timestamp;
END^

SET TERM ; ^


-- FK CONSTRAINTS
ALTER TABLE customer ADD CONSTRAINT fk_customer_store FOREIGN KEY (store_id) REFERENCES store (store_id) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE inventory ADD CONSTRAINT fk_inventory_store FOREIGN KEY (store_id) REFERENCES store (store_id) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE staff ADD CONSTRAINT fk_staff_store FOREIGN KEY (store_id) REFERENCES store (store_id) ON DELETE NO ACTION ON UPDATE CASCADE;
ALTER TABLE payment ADD CONSTRAINT fk_payment_rental FOREIGN KEY (rental_id) REFERENCES rental (rental_id) ON DELETE SET NULL ON UPDATE CASCADE;
--
-- View structure for view customer_list
--

CREATE VIEW customer_list
AS
SELECT cu.customer_id AS ID,
       cu.first_name||' '||cu.last_name AS name,
       a.address AS address,
       a.postal_code AS zip_code,
       a.phone AS phone,
       city.city AS city,
       country.country AS country,
       case when cu.active=1 then 'active' else '' end AS notes,
       cu.store_id AS SID
FROM customer AS cu JOIN address AS a ON cu.address_id = a.address_id JOIN city ON a.city_id = city.city_id
    JOIN country ON city.country_id = country.country_id;
--
-- View structure for view film_list
--

CREATE VIEW film_list
AS
SELECT film.film_id AS FID,
       film.title AS title,
       film.description AS description,
       category.name AS category,
       film.rental_rate AS price,
       film.length AS length,
       film.rating AS rating,
       actor.first_name||' '||actor.last_name AS actors
FROM category LEFT JOIN film_category ON category.category_id = film_category.category_id LEFT JOIN film ON film_category.film_id = film.film_id
        JOIN film_actor ON film.film_id = film_actor.film_id
    JOIN actor ON film_actor.actor_id = actor.actor_id;

--
-- View structure for view staff_list
--

CREATE VIEW staff_list
AS
SELECT s.staff_id AS ID,
       s.first_name||' '||s.last_name AS name,
       a.address AS address,
       a.postal_code AS zip_code,
       a.phone AS phone,
       city.city AS city,
       country.country AS country,
       s.store_id AS SID
FROM staff AS s JOIN address AS a ON s.address_id = a.address_id JOIN city ON a.city_id = city.city_id
    JOIN country ON city.country_id = country.country_id;
--
-- View structure for view sales_by_store
--

CREATE VIEW sales_by_store
AS
SELECT
  s.store_id
 ,c.city||','||cy.country AS store
 ,m.first_name||' '||m.last_name AS manager
 ,SUM(p.amount) AS total_sales
FROM payment AS p
INNER JOIN rental AS r ON p.rental_id = r.rental_id
INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
INNER JOIN store AS s ON i.store_id = s.store_id
INNER JOIN address AS a ON s.address_id = a.address_id
INNER JOIN city AS c ON a.city_id = c.city_id
INNER JOIN country AS cy ON c.country_id = cy.country_id
INNER JOIN staff AS m ON s.manager_staff_id = m.staff_id
GROUP BY  
  s.store_id
, c.city||','||cy.country
, m.first_name||' '||m.last_name;
--
-- View structure for view sales_by_film_category
--
-- Note that total sales will add up to >100% because
-- some titles belong to more than 1 category
--

CREATE VIEW sales_by_film_category
AS
SELECT
c.name AS category
, SUM(p.amount) AS total_sales
FROM payment AS p
INNER JOIN rental AS r ON p.rental_id = r.rental_id
INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
INNER JOIN film AS f ON i.film_id = f.film_id
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name;

--
-- View structure for view actor_info
--

/*
CREATE VIEW actor_info
AS
SELECT
a.actor_id,
a.first_name,
a.last_name,
GROUP_CONCAT(DISTINCT CONCAT(c.name, ': ',
        (SELECT GROUP_CONCAT(f.title ORDER BY f.title SEPARATOR ', ')
                    FROM sakila.film f
                    INNER JOIN sakila.film_category fc
                      ON f.film_id = fc.film_id
                    INNER JOIN sakila.film_actor fa
                      ON f.film_id = fa.film_id
                    WHERE fc.category_id = c.category_id
                    AND fa.actor_id = a.actor_id
                 )
             )
             ORDER BY c.name SEPARATOR '; ')
AS film_info
FROM sakila.actor a
LEFT JOIN sakila.film_actor fa
  ON a.actor_id = fa.actor_id
LEFT JOIN sakila.film_category fc
  ON fa.film_id = fc.film_id
LEFT JOIN sakila.category c
  ON fc.category_id = c.category_id
GROUP BY a.actor_id, a.first_name, a.last_name;
*/

-- TO DO PROCEDURES
-- TO DO TRIGGERS

