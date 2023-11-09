--1. List all customers who live in Texas (use
--JOINs)
SELECT first_name, last_name, address.district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';


--2. Get all payments above $6.99 with the Customer's Full
--Name
SELECT first_name, last_name, payment.amount 
FROM customer
INNER JOIN payment
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;

--3. Show all customers names who have made payments over $175(use
--subqueries)
SELECT store_id, first_name, last_name, customer_id
FROM customer
WHERE customer_id IN (
	SELECT customer_iD
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount)> 175
);

--4. List all customers that live in Nepal (use the city
--table
SELECT first_name, last_name, customer.address_id, country.country
FROM customer
INNER JOIN address
ON address.address_id = customer.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON country.country_id = city.country_id AND country = 'Nepal';

--5. Which staff member had the most
--transactions?
SELECT COUNT (staff.staff_id), first_name, last_name
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
INNER JOIN rental 
ON payment.rental_id = rental.rental_id
GROUP BY staff.staff_id ORDER BY COUNT(staff.staff_id) DESC
LIMIT 1;


--6. How many movies of each rating are
--there?
SELECT COUNT(rating), rating
FROM film
GROUP BY rating 
ORDER BY COUNT(rating)DESC;

--7.Show all customers who have made a single payment
--above $6.99 (Use Subqueries)


-- SELECT customer.customer_id, first_name, last_name
-- FROM customer
-- INNER JOIN payment ON customer.customer_id = payment.customer_id
-- WHERE payment.amount > 6.99
-- GROUP BY customer.customer_id, first_name, last_name
-- HAVING COUNT(payment.payment_id) = 1 AND COUNT(DISTINCT payment.amount) = 1;


SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
 	FROM payment 
 	WHERE payment.amount > 6.99
 	GROUP BY customer_id
 	HAVING COUNT(payment.amount) = 1
);
	
--8. How many free rentals did our stores give away?
SELECT COUNT(rental)
FROM rental
INNER JOIN payment
ON rental.rental_id = payment.rental_id
WHERE amount = 0.00;