file = LOAD '/user/mugilmithran/customer_purchases.csv' USING PigStorage(',') AS
(customer_id: int, purchase_date: chararray, product_id: int, product_name: chararray, quantity: int, total_amount: float);

high_value_cus = FILTER file BY total_amount > 100;

DUMP high_value_cus;
