-- 1. List all customers who live in Texas (use JOINs)

SELECT first_name, last_name
FROM customer
JOIN address 
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name

SELECT concat(first_name, ' ', last_name) AS full_name
FROM customer
JOIN rental
ON customer.customer_id = rental.customer_id
JOIN payment
ON rental.rental_id = payment.rental_id
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries)

SELECT first_name, last_name, customer.customer_id
FROM customer
JOIN payment
ON payment.customer_id = customer.customer_id
WHERE payment.customer_id IN (
	SELECT customer_id 
	FROM payment
	GROUP BY customer_id
	having sum(amount) > 175
)
GROUP BY first_name, last_name, customer.customer_id;

-- 4. List all customers that live in Nepal (use the city table)

SELECT country
FROM country
WHERE country = 'Nepal'

SELECT city, city.country_id
FROM city
WHERE country_id IN (
	SELECT country_id
	FROM country
	WHERE country = 'Nepal'
)

SELECT first_name, last_name, address.address_id
FROM customer 
JOIN address
ON customer.address_id = address.address_id
WHERE address.city_id IN (
	SELECT city_id
	FROM city
	WHERE country_id IN (
		SELECT country_id
		FROM country
		WHERE country = 'Nepal'
	)
);

-- 5.Which staff member had the most transactions?

SELECT first_name, last_name, count(staff.staff_id)
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY first_name, last_name;

-- 6. How many movies of each rating are there?

SELECT DISTINCT rating, count(title)
FROM film
GROUP BY rating;

-- 7. Show all customers who have made a single payment above $6.99 (Use Subqueries)

SELECT first_name, last_name, payment.amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY first_name, last_name, payment.amount
HAVING amount > 6.99;

-- 8. How many free rentals did our stores give away?

SELECT count(amount)
FROM payment
JOIN rental 
ON payment.rental_id = rental.rental_id
where amount = 0;


