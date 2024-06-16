file = LOAD '/user/mugilmithran/customer_purchases.csv' USING PigStorage(',') AS
(customer_id: int, purchase_date: chararray, product_id: int, product_name: chararray, quantity: int, total_amount: float);

grouped_avg_purchase = GROUP file BY customer_id;

avg_purchase = FOREACH grouped_avg_purchase GENERATE group AS customer_id, AVG(file.total_amount) AS avg_amount;

avg_pur = ORDER avg_purchase BY avg_amount DESC;

DUMP avg_pur;