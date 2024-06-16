file = LOAD '/user/mugilmithran/customer_purchases.csv' USING PigStorage(',') AS
(customer_id: int, purchase_date: chararray, product_id: int, product_name: chararray, quantity: int, total_amount: float);

grouped_customer = GROUP file BY customer_id;

purchase_amount = FOREACH grouped_customer GENERATE group AS customer_id, SUM(file.total_amount) AS tot_amt;

avg_pur_amt = FOREACH grouped_customer GENERATE group AS customer_id, AVG(file.total_amount) AS avg_amt;

most_purchased_prod = FOREACH grouped_customer GENERATE group AS customer_id, COUNT(file) AS most_purchase;

cross_join = JOIN purchase_amount BY customer_id, avg_pur_amt BY customer_id, most_purchased_prod BY customer_id;

final_output = FOREACH cross_join GENERATE purchase_amount::customer_id AS customer_id,tot_amt, most_purchase, avg_amt, (tot_amt > 100 ? 'true' : 'false') AS high_value_customer;

STORE final_output INTO 'user/mugilmithran/final_report' USING PigStorage(',');
