use sakila;
select * from film_actor;

WITH film_number AS (
    SELECT 
        actor.first_name,
        actor.last_name,
        film_actor.film_id
    FROM actor
    INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
),
actor_counts AS (
    SELECT  
        CONCAT(first_name, ' ', last_name) AS actor_name, 
        COUNT(film_id) AS no_of_film
    FROM film_number
    GROUP BY CONCAT(first_name, ' ', last_name)
)
SELECT * FROM actor_counts;

with language_CT as (
select title, rental_rate, l.name from film f join language l
on f.language_id = l.language_id) 
select title, rental_rate, name from language_CT;

select * from customer;

with payment_CTE as (
select concat(first_name,' ',last_name) name, amount from 
customer c join payment p on 
c.customer_id=p.customer_id)
select name, sum(amount) total_revenue from payment_CTE
group by name;

WITH ranked_films AS (
    SELECT 
        title,
        rental_duration,
        dense_rank() OVER (ORDER BY rental_duration DESC) AS duration_rank
    FROM film
)
SELECT *
FROM ranked_films
ORDER BY duration_rank;

SELECT * from rental;

with rental_cte as (
select count(rental_id) no_of_rental, customer_id from rental 
group by customer_id
having count(rental_id)>=2)
select * from rental_cte join 
rental on 
rental_cte.customer_id = rental.customer_id
order by no_of_rental;

WITH monthly_rentals AS (
    SELECT 
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(rental_id) AS total_rentals
    FROM rental
    GROUP BY DATE_FORMAT(rental_date, '%Y-%m')
)
SELECT *
FROM monthly_rentals
ORDER BY rental_month;

WITH actor_pairs AS (
    SELECT
        fa1.actor_id AS actor_1,
        fa2.actor_id AS actor_2,
        fa1.film_id
    FROM film_actor fa1
    JOIN film_actor fa2 
        ON fa1.film_id = fa2.film_id
       AND fa1.actor_id < fa2.actor_id  -- avoid duplicates & self-pairs
)
SELECT *
FROM actor_pairs
ORDER BY film_id, actor_1, actor_2;

WITH RECURSIVE employee_hierarchy AS (
    -- Anchor member: the manager
    SELECT 
        staff_id,
        first_name,
        last_name,
        reports_to
    FROM staff
    WHERE staff_id = 1  -- 👈 Replace with the manager's ID

    UNION ALL

    -- Recursive member: find employees who report to those already in the CTE
    SELECT 
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM staff s
    INNER JOIN employee_hierarchy eh ON s.reports_to = eh.staff_id
)
SELECT *
FROM employee_hierarchy;



