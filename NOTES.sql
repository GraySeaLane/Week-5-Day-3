SELECT *
FROM staff;

SELECT *
FROM rental;



SELECT first_name, last_name, staff.staff_id, COUNT(staff.staff_id)
FROM staff
FULL JOIN rental
ON staff.staff_id = rental.staff_id
WHERE staff.staff_id IS NOT NULL
GROUP BY staff.staff_id;

SELECT *
FROM actor;

SELECT *
FROM film;

SELECT *
FROM film_actor;


--Query for film_ids from film actor table and which actors 
--appears with film id
SELECT actor.actor_id, first_name, last_name
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id;

--query to select actors in films 
SELECT first_name, last_name, title, description, actor.actor_id, film.film_id
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
on film_actor.film_id = film.film_id;

--left join starting with actor table and film_actor table
SELECT actor.actor_id, first_name, last_name, film_id
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor.id
WHERE first_name IS NULL AND last_name IS NULL;

select country_id
FROM country
WHERE country = 'Angola';

--FIND CUSTOMERS WHO LIVE IN ANGOLA
select country_id
FROM country
WHERE country = 'Angola';

SELECT first_name, last_name, customer.address_id, country.country
FROM customer
INNER JOIN address
ON address.address_id = customer.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON country.country_id = city.country_id AND country = 'Angola';

--another answer
SELECT first_name, last_name, country.country_id, country.country 
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola';


--Subqueries, a query within a query
SELECT customer_id, SUM(amount) 
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount)DESC;

SELECT store_id, first_name, last_name, customer_id
FROM customer
WHERE customer_id IN (
	SELECT customer_iD
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount)> 175
);

SELECT store_id, first_name, last_name, customer_id
FROM customer;


SELECT customer_iD
FROM payment
GROUP BY customer_id
HAVING SUM(amount)> 175;


---query for cust who live in US and made payments over 175
SELECT first_name, last_name, address
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'United States' AND customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);
	---join instead of query
SELECT first_name, last_name, address.address
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id AND country.country = 'United States'
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, first_name, last_name, address
HAVING SUM(amount) > 175;	
	

--subquery within the same table--
--query for amounts paid greater> the average amounts paid
SELECT ROUND(AVG(amount), 2)
FROM payment;

SELECT AVG(amount)::NUMERIC (6, 2)
FROM payment;

SELECT payment_id, amount
FROM payment
WHERE amount > 4.20;


--subquery to find amount paid greater than the average amount paid
SELECT payment_id, amount
FROM payment
WHERE amount >(
	SELECT AVG(amount)FROM payment
);


--Subquery to find customers who live in Dallas
SELECT first_name, last_name, address_id
FROM customer
WHERE address_id IN(
	SELECT address_id
	FROM address
	WHERE city_id IN(
		SELECT city_id
		FROM city
		WHERE city = 'Dallas'
	)
);

-- Query for all action movies

SELECT title, film_id
FROM film
WHERE film_id IN(
	SELECT film_id
	FROM film_category
	WHERE category_id IN(
		SELECT category_id
		FROM category
		WHERE name = 'Action'
	)
)ORDER BY title;



