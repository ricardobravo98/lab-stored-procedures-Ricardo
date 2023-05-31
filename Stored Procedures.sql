use sakila;

# 1
# Storing query into procedure action_lovers
DELIMITER //

CREATE PROCEDURE action_movies()
BEGIN
  SELECT first_name, last_name, email
  FROM customer
  JOIN rental ON customer.customer_id = rental.customer_id
  JOIN inventory ON rental.inventory_id = inventory.inventory_id
  JOIN film ON film.film_id = inventory.film_id
  JOIN film_category ON film_category.film_id = film.film_id
  JOIN category ON category.category_id = film_category.category_id
  WHERE category.name = 'Action'
  GROUP BY first_name, last_name, email;
END //

DELIMITER ;

CALL action_movies();



# 2.

create procedure category(in category_name int)
begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = category_name
  group by first_name, last_name, email
end //
DELIMITER ;

# 3. 
select film.name, count(film.film_id) as number_films from film 
join film_category on film_category.film_id =  film.film_id 
join category on category.category_id = film_category.category_id
group by name;

# number of films above which a category will be returned
DELIMITER //
create procedure categories_more_films_than(in more_films_than int)
begin
	select category.name as category_name, count(film.film_id) as number_films from film 
	join film_category on film_category.film_id =  film.film_id 
	join category on category.category_id = film_category.category_id
	group by name
    having n_films > more_films_than;
end //
DELIMITER ;

# Executing stored procedure with boundary set to 50 films
call categories_more_films_than(50);
