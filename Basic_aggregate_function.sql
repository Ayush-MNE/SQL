use mavenmovies;
SELECT 
    TABLE_NAME, 
    COLUMN_NAME 
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE 
    CONSTRAINT_NAME = 'PRIMARY' 
    AND TABLE_SCHEMA = 'mavenmovies';
    
select a.first_name,a.last_name,a.actor_id,awards,aw.last_update from actor a join actor_award aw on a.actor_id=aw.actor_id;
select * from rental r inner join payment p on r.rental_id = p.rental_id;
select r.customer_id,r.rental_id, abs(date (rental_date)- date(return_date)) as no_of_days, r.staff_id, amount from rental r inner join payment p on r.rental_id = p.rental_id;
select country_id, country from country;

SELECT 
    r.customer_id,
    r.rental_id,
    ABS(DATEDIFF(r.return_date, r.rental_date)) AS no_of_days,
    r.staff_id,
    SUM(p.amount) AS total_amount
FROM 
    rental r
JOIN 
    payment p 
    ON r.rental_id = p.rental_id AND r.customer_id = p.customer_id
GROUP BY 
    r.customer_id, r.rental_id, r.rental_date, r.return_date, r.staff_id
ORDER BY 
    total_amount;
SELECT 
    r.customer_id,
    r.rental_id,
    ABS(DATEDIFF(r.return_date, r.rental_date)) AS no_of_days,
    r.staff_id,
    SUM(p.amount) AS total_amount
FROM 
    rental r
JOIN 
    payment p 
    ON r.rental_id = p.rental_id AND r.customer_id = p.customer_id
GROUP BY 
    r.customer_id, r.rental_id, r.rental_date, r.return_date, r.staff_id
ORDER BY 
    total_amount;
SELECT 
    r.rental_id,
    r.customer_id,
    COUNT(p.payment_id) AS num_payments,
    SUM(p.amount) AS total_payment
FROM 
    rental r
LEFT JOIN 
    payment p 
    ON r.rental_id = p.rental_id AND r.customer_id = p.customer_id
GROUP BY 
    r.rental_id, r.customer_id
ORDER BY 
    total_payment DESC;
    
select rental_id from rental where customer_id = 1;
select title,rental_duration from film
where rental_duration>5
order by rental_duration;

select count(distinct film_id) as no_of_film from film 
where replacement_cost between 15 and 20;
select count(distinct left(first_name, 1)) as no_of_first_letter from actor;
select * from customer limit 10;
select * from customer where left(first_name,1)='b' limit 3;
select title from film where rating = 'G' limit 5;
select * from customer where left(first_name,1)='a';
select * from customer where right(first_name,1)='a';
select city_id, city from city where left(city,1)='a' and right(city,1)='a' limit 4;
select * from customer where instr (first_name,'NI')>0;
select * from customer where instr(first_name,'r') = 2;
select * from customer where left(first_name,1)='a' and char_length(first_name)>=5;
select * from customer where left(first_name,1) = 'a' and right(first_name,1)='o';
select * from film where rating in ('PG','PG-13');
select * from film f where char_length(f.description) between 50 and 100;
select * from actor limit 50;
select film_id from inventory 
group by film_id;
select count(rental_id) as no_of_rental from rental;

use sakila;
select avg(datediff(return_date,rental_date)) as avg_no_of_rental_days from rental;
select upper(first_name) upper_first_name, upper(last_name) upper_last_name from customer;

select month(rental_date) rental_month, rental_id from rental;
select customer_id, count(rental_id) no_of_rental from rental
 group by customer_id;
 
 select store_id,sum(amount) total_revenue from payment p inner join store s on p.staff_id=s.manager_staff_id 
 group by store_id;
 SELECT 
    c.name AS category_name,
    COUNT(r.rental_id) AS total_rentals
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    c.name
ORDER BY 
    total_rentals DESC;
    
select count(distinct language_id) from film;
select * from language;
select name, avg(rental_rate) avg_rental_rate from film join language on film.language_id=language.language_id
group by name;
select * from rental;
select  title, first_name, last_name from film f inner join inventory i on f.film_id = i.film_id inner join rental r on i.inventory_id=r.inventory_id inner join customer c on r.customer_id = c.customer_id;
select first_name, last_name from actor a join film_actor fa on a.actor_id = fa.actor_id join film f on 
fa.film_id = f.film_id
where title = 'GONE TROUBLE';
select concat(first_name, ' ',last_name) name, sum(amount) from customer c inner join rental r 
on c.customer_id = r.customer_id inner join 
payment p on 
r.rental_id = p.rental_id
group by name;
use sakila;
select concat(first_name, ' ',last_name) name,
city, title from customer c inner join rental r on c.customer_id= r.customer_id join 
inventory i on r.inventory_id = i.inventory_id
join film f on
i.film_id = f.film_id 
join address ad on 
c.address_id = ad.address_id 
join city on ad.city_id = city.city_id
order by name
;
select title, count(rental_id) no_of_rent from rental r 
join inventory i on 
r.inventory_id = i.inventory_id join film f on 
i.film_id = f.film_id
group by title;


SELECT COUNT(*) 
FROM (
    SELECT customer_id
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    WHERE i.store_id IN (1, 2)
    GROUP BY customer_id
    HAVING COUNT(DISTINCT i.store_id) = 2
) AS both_store_customers;

