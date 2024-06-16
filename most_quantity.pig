file = LOAD '/user/mugilmithran/customer_purchases.csv' USING PigStorage(',') AS
(customer_id: int, purchase_date: chararray, product_id: int, product_name: chararray, quantity: int, total_amount: float);

highest_quantity = GROUP file BY (product_id, product_name);

highest_quantity_purchased = FOREACH highest_quantity GENERATE FLATTEN(group) AS (product_id, product_name), SUM(file.quantity) AS total_num;

highest_qty_purchased = ORDER highest_quantity_purchased BY total_num DESC; 

highest_num_purchased = LIMIT highest_qty_purchased 1;

DUMP highest_num_purchased;
