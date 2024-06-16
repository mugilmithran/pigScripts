file = LOAD '/user/mugilmithran/customer_purchases.csv' USING PigStorage(',') AS
(customer_id: int, purchase_date: chararray, product_id: int, product_name: chararray, quantity: int, total_amount: float);

grouped_customer_id = GROUP file BY customer_id;

cust_purchase = FOREACH grouped_customers GENERATE group AS customer_id, COUNT(file.quantity) AS pur_count;

highest_purchase_frequency = ORDER cust_purchase BY pur_count DESC;

DUMP highest_purchase_frequency;