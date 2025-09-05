
-- Manger's questions and answers

-- 1. Find a list of order IDs where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table. 

SELECT id AS order_id
FROM orders 
WHERE gloss_qty::NUMERIC > 4000 
      OR poster_qty::NUMERIC > 4000;


-- 2. Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000. 

SELECT id AS order_id
FROM orders 
WHERE standard_qty::NUMERIC = 0 
      AND (gloss_qty::NUMERIC > 1000 OR poster_qty::NUMERIC > 1000);


-- 3. Find all the company names that start with a 'C' or 'W', and where the primary contact contains 'ana' or 'Ana', but does not contain 'eana'.

SELECT name AS company_name
FROM accounts 
WHERE (name LIKE 'C%' OR name LIKE 'W%') 
      AND primary_poc ILIKE '%ana%' 
      AND primary_poc NOT ILIKE '%eana%' ;


-- 4. Provide a table that shows the region for each sales rep along with their associated accounts. Your final table should include three columns: the region name, 
-- the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) by account name.

SELECT r.name AS region_name, sp.name AS sales_reps_name, ac.name AS accounts_name 
FROM region r 
LEFT JOIN sales_reps sp 
         ON r.id = sp.region_id 
LEFT JOIN accounts ac 
         ON sp.id = ac.sales_rep_id 
ORDER BY ac.name ;
