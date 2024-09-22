-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.



HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */

SELECT  vendor_name, product_name, sum(price_for_5_units) AS total_sales
FROM (
			SELECT customer_id, vendor_name, product_name, price_for_5_units -- get list of all customers buying 5 units of all vendor-products
			FROM customer
CROSS JOIN (
			SELECT DISTINCT vendor_name, product_name, 5 * original_price AS price_for_5_units -- get distinct list of vendor-products
			FROM vendor_inventory AS vi
LEFT JOIN vendor  AS v ON vi.vendor_id = v.vendor_id
LEFT JOIN product AS p ON vi.product_id = p.product_id)
ORDER BY customer_id)
GROUP BY vendor_name, product_name;

-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

CREATE TEMP TABLE product_units AS --Using a temp table although not indicated in the instructions as to not change the db
	SELECT * FROM product 
	WHERE product_qty_type = 'unit';

ALTER TABLE temp.product_units ADD COLUMN current_timestamp datetime;

/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

INSERT INTO temp.product_units (product_id, product_name, product_size, product_category_id, product_qty_type, current_timestamp) 
	VALUES ( 99, 'Apple Pie', 'Medium', 9, 'unit', datetime('now'));

-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

DELETE FROM product_units WHERE product_name = 'Apple Pie';

-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE temp.product_units
ADD current_quantity INT;

Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */

WITH cte AS ( --cte gets latest quantity per product by vendor
	SELECT max(market_date) AS 'market_date', vendor_id, product_id FROM vendor_inventory 
	GROUP BY vendor_id, product_id
),

cte2 AS ( --cte2 gets the sum of latest quantity by product regardless of vendor as one product can be carried by more than one vendor
		SELECT product_id, coalesce(sum(quantity),0) AS 'current_qty' FROM ( 

		SELECT  CTE.market_date, cte.vendor_id, cte.product_id, v.quantity 
		FROM CTE
		LEFT JOIN vendor_inventory AS v ON cte.market_date = v.market_date 
			AND cte.vendor_id = v.vendor_id 
			AND cte.product_id - v.product_id 
		)
	GROUP BY product_id
)

UPDATE temp.product_units
SET current_quantity = (
	SELECT current_qty FROM cte2 WHERE product_units.product_id = cte2.product_id)