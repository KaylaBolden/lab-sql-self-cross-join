-- Get all pairs of actors that worked together.

select f.title, concat(a1.first_name,' ',a1.last_name) as actor1,
concat(a2.first_name,' ',a2.last_name) as actor2 from (
select f1.film_id, f1.actor_id as actor1, f2.actor_id as actor2 from sakila.film_actor f1
join sakila.film_actor f2 on f1.film_id=f2.film_id and f1.actor_id<>f2.actor_id
where f1.actor_id<f2.actor_id
order by f1.film_id)s1
left join sakila.actor a1 on s1.actor1=a1.actor_id
left join sakila.actor a2 on s1.actor2=a2.actor_id
left join sakila.film f on s1.film_id=f.film_id;

-- Get all pairs of customers that have rented the same film more than 3 times.
select  sub1.customer_id as customer1,sub2.customer_id as customer2
, count(sub1.film_id) as filmCount
from (
select customer_id, film_id
from sakila.inventory join sakila.rental using (inventory_id))sub1
inner join (
select customer_id, film_id
from sakila.inventory join sakila.rental using (inventory_id))sub2
on sub1.film_id=sub2.film_id 
and sub1.customer_id<>sub2.customer_id 
and sub1.customer_id<sub2.customer_id
group by sub1.customer_id,sub2.customer_id 
having filmCount >3;

-- Get all possible pairs of actors and films.
select * from (
select distinct title as film from sakila.film)s1
cross join (
select distinct concat(first_name, ' ', last_name) as actor from sakila.actor)s2;

