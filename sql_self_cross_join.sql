use sakila;

# 1. provide a list of the pair of actors that worked together on the same movie

SELECT fa1.actor_id AS actor1_id, a1.first_name AS actor1_first_name, a1.last_name AS actor1_last_name,
       fa2.actor_id AS actor2_id, a2.first_name AS actor2_first_name, a2.last_name AS actor2_last_name,
       f.title AS movie_title

# fa represents the table 'film_actor'
       
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id <> fa2.actor_id
JOIN actor a1 ON fa1.actor_id = a1.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
JOIN film f ON fa1.film_id = f.film_id;

#2. Get all pairs of customers that have rented the same film more than 3 times.

SELECT c1.customer_id AS customer1_id, c1.first_name AS customer1_first_name, c1.last_name AS customer1_last_name,
       c2.customer_id AS customer2_id, c2.first_name AS customer2_first_name, c2.last_name AS customer2_last_name,
       f.film_id, f.title, COUNT(*) AS rental_count
FROM rental r1
JOIN rental r2 ON r1.inventory_id = r2.inventory_id AND r1.customer_id < r2.customer_id
JOIN customer c1 ON r1.customer_id = c1.customer_id
JOIN customer c2 ON r2.customer_id = c2.customer_id
JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
JOIN film f ON i1.film_id = f.film_id
GROUP BY c1.customer_id, c1.first_name, c1.last_name, c2.customer_id, c2.first_name, c2.last_name, f.film_id, f.title
HAVING rental_count > 3;

# there are no pairs of customers who have rented the same film more than 3 times 

# 3. Get all possible pairs of actors and films.

SELECT a1.actor_id AS actor1_id, a1.first_name AS actor1_first_name, a1.last_name AS actor1_last_name,
       a2.actor_id AS actor2_id, a2.first_name AS actor2_first_name, a2.last_name AS actor2_last_name,
       f.film_id, f.title
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
JOIN actor a1 ON fa1.actor_id = a1.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
JOIN film f ON fa1.film_id = f.film_id;

# With this query we provide the different combinations of pair of actors and films in a "matrix" fashion