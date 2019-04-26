SELECT first_name, last_name, email
FROM customer;

SELECT DISTINCT rating
FROM film;

SELECT c.email
FROM customer c
WHERE c.first_name = 'Nancy'
AND c.last_name = 'Thomas';


SELECT f.description
FROM film f
WHERE f.title = 'Outlaw Hanky';


SELECT a.phone
FROM address a
WHERE a.address = '259 Ipoh Drive';


SELECT COUNT(staff_id) FROM payment WHERE staff_id = 1;


SELECT COUNT(DISTINCT (amount)) FROM payment;


SELECT * FROM customer
LIMIT 5;


SELECT first_name, last_name FROM customer
ORDER BY last_name DESC;


SELECT first_name, last_name FROM customer
ORDER BY first_name ASC,
last_name DESC;


SELECT p.customer_id, p.amount
FROM payment p
ORDER BY p.amount DESC
LIMIT 10;


SELECT f.title, f.film_id, f.release_year
FROM film f
ORDER BY f.film_id ASC
LIMIt 5;


SELECT customer_id, amount
FROM payment
WHERE amount
BETWEEN 8 AND 9;


SELECT amount, payment_date
FROM payment
WHERE payment_date BETWEEN '15 Feb 2007' AND '17 Feb 2007';


SELECT amount, payment_date
FROM payment
WHERE payment_date NOT BETWEEN '15 Feb 2007' AND '20 Feb 2007';


SELECT customer_id, rental_id, return_date
FROM rental
WHERE customer_id IN (7,13,10)
ORDER BY return_date DESC;


SELECT first_name, last_name
FROM customer
WHERE first_name LIKE '%er%';


-- Underscore Wildcard looks for an instance 
-- of only a single character before the following value
SELECT first_name, last_name
FROM customer
WHERE first_name LIKE '_her%';


SELECT first_name, last_name
FROM customer
WHERE first_name NOT LIKE 'Jen%';


-- ILIKE Turns off Case Sensitivity for Search String
SELECT first_name, last_name
FROM customer
WHERE first_name ILIKE 'BAR%';


SELECT COUNT(amount) FROM payment
WHERE amount > 5.00;


SELECT COUNT(*) FROM actor
WHERE first_name
LIKE 'P%';


SELECT DISTINCT COUNT(district) FROM address;


SELECT DISTINCT district FROM address;


SELECT COUNT(*) FROM film
WHERE rating = 'R'
AND replacement_cost BETWEEN 5 AND 15;


SELECT COUNT(title) FROM film
WHERE title
LIKE '%Truman%';


SELECT ROUND( AVG(amount), 2) FROM payment;


SELECT MIN(amount) FROM payment;


SELECT MAX(amount) FROM payment;


SELECT ROUND( SUM(amount), 1) FROM payment;

-- Group by works just like Distinct
-- You need to use the Group By column in Select statement
SELECT staff_id, COUNT (amount), SUM (amount)
FROM payment
GROUP BY staff_id;


SELECT rating, AVG (replacement_cost) AS AverageCost
FROM film
GROUP BY rating;


SELECT rating, AVG(rental_rate)
FROM film
WHERE rating IN ('R', 'G', 'PG')
GROUP BY rating
HAVING AVG(rental_rate) < 3;


SELECT customer_id, COUNT(payment_id)
FROM payment
GROUP BY customer_id
HAVING COUNT(payment_id) > 40;


SELECT AVG(rental_duration), rating
FROM film
GROUP BY rating
HAVING AVG(rental_duration) > 5;


SELECT customer_id, SUM(amount)
FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) >= 110;

SELECT COUNT(film_id) FROM film
WHERE title LIKE 'J%';


SELECT first_name, last_name FROM customer
WHERE first_name LIKE 'E%'
AND address_id < 500
ORDER BY customer_id DESC
LIMIT 1;


SELECT customer.customer_id, first_name, last_name, email, amount, payment_date
FROM customer
INNER JOIN payment ON payment.customer_id = customer.customer_id
WHERE first_name LIKE 'A%'
ORDER BY first_name;


SELECT payment.payment_id, payment.amount, staff.first_name, staff.last_name
FROM payment
INNER JOIN staff ON payment.staff_id = staff.staff_id;


SELECT title, COUNT(title) AS copies_at_store
FROM inventory
INNER JOIN film ON inventory.film_id = film.film_id
WHERE store_id = 1
GROUP BY title
ORDER BY 1;


SELECT * FROM inventory
INNER JOIN film ON inventory.film_id = film.film_id;


SELECT * FROM inventory
FULL OUTER JOIN film ON inventory.film_id = film.film_id;


SELECT * FROM inventory
LEFT OUTER JOIN film ON inventory.film_id = film.film_id;


SELECT title, name AS movie_language
FROM film
INNER JOIN language AS lan ON lan.language_id = film.language_id;

SELECT first_name + ' ' + last_name AS 'Full Name' FROM customer;


SELECT upper(first_name) FROM customer;


SELECT lower(first_name) FROM customer;


-- Self Joinig tables
SELECT a.customer_id, a.first_name, a.last_name, b.customer_id, b.first_name, b.last_name
FROM customer AS a, customer AS b
WHERE a.first_name = b.last_name;


-- Can also get the same results with a regular inner join
SELECT a.customer_id, a.first_name, a.last_name, b.customer_id, b.first_name, b.last_name
FROM customer AS a
JOIN customer AS b
ON a.first_name = b.last_name;

-- Exercise Solutions For Assessment Test 2
SELECT * FROM cd.facilities;

SELECT name, membercost FROM cd.facilities;

SELECT name, membercost FROM cd.facilities
WHERE membercost > 0;

SELECT facid, name, membercost, monthlymaintenance
FROM cd.facilities
WHERE membercost > 0
AND membercost < monthlymaintenance/50;

SELECT name FROM cd.facilities
WHERE name LIKE '%Tennis%';

SELECT facid, name, membercost, monthlymaintenance
FROM cd.facilities
WHERE facid IN (1, 5);

SELECT memid, surname, firstname, joindate
FROM cd.members
WHERE joindate >= '01-09-2012';

SELECT DISTINCT surname FROM cd.members
ORDER BY surname
LIMIT 10;

-- Get the latest join date
SELECT memid, surname, firstname, max(joindate) AS latest
FROM cd.members;

SELECT COUNT(guestcost) FROM cd.facilities
WHERE guestcost >= 10;

SELECT bookings.facid AS facilityid, name, SUM(slots) FROM cd.bookings
LEFT JOIN cd.facilities ON bookings.facid = facilities.facid
WHERE starttime BETWEEN '2012-09-01' AND '2012-09-30'
GROUP BY facilityid, name
ORDER BY SUM(slots) DESC;

SELECT bookings.facid as id, name, SUM(slots) FROM cd.bookings
LEFT JOIN cd.facilities ON bookings.facid = facilities.facid
GROUP BY id, name
HAVING SUM(slots) > 1000;


SELECT bks.starttime AS start, facs.name as name
FROM cd.facilities AS facs
INNER JOIN cd.bookings AS bks ON facs.facid = bks.facid
WHERE facs.facid IN (0,1)
AND bks.starttime >= '2012-09-21' AND bks.starttime < '2012-09-22'
ORDER BY bks.starttime;


SELECT bks.starttime AS start FROM cd.bookings AS bks
INNER JOIN cd.members mems ON mems.memid = bks.memid
WHERE mems.firstname = 'David' AND mems.surname = 'Farrell';


-- CREATE TABLE
CREATE TABLE account(
	user_id    serial        PRIMARY KEY,
	username   VARCHAR(50)   UNIQUE   NOT NULL,
	password   VARCHAR(50)            NOT NULL,
	email      VARCHAR(335)  UNIQUE   NOT NULL,
	created_on TIMESTAMP              NOT NULL,
	last_login TIMESTAMP
);

-- CREATE TABLE WITH FKs
CREATE TABLE account_role (
    user_id   integer   NOT NULL,
    role_id   integer   NOT NULL,
	grant_date timestamp WITHOUT time zone,
	PRIMARY KEY (user_id, role_id),
	
	CONSTRAINT account_role_role_id_fkey FOREIGN KEY (role_id)
		REFERENCES role (role_id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	
	CONSTRAINT account_role_user_id_fkey FOREIGN KEY (user_id)
		REFERENCES account (user_id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION
);








