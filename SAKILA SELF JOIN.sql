USE sakila; 

# Get all pairs of actors that worked together.

SELECT a.actor_id, b.actor_id, c.title
FROM film_actor a, film_actor b
JOIN film c ON b.film_id = c.film_id
WHERE a.actor_id = b.actor_id AND a.film_id = b.film_id
ORDER BY a.film_id; 

#Get all pairs of customers that have rented the same film more than 3 times.

SELECT b.inventory_id, a.customer_id
AS customer_1, b.customer_id
AS customer_2, a.customer_id,
COUNT(*) AS 
FROM rental a
JOIN rental b
ON a.inventory_id = c.inventory_id
INNER JOIN inventory c
ON b.inventory_id = c.inventory_id
GROUP BY b.inventory_id, a.customer_id, b.customer_id
HAVING COUNT(*) = 3;

#Get all possible pairs of actors and films.

SELECT film.film_id, actor.actor_id
FROM film
CROSS JOIN actor
WHERE film.film_id = actor.actor_id; 
  