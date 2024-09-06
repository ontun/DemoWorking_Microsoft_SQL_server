SELECT Purchase.Purchase_date_time AS Purchase_date, Purchase.Payment_sum, Client.Client_first_name
FROM Purchase
JOIN Client ON Purchase.Client_id = Client.Client_id
WHERE Purchase.Purchase_date_time BETWEEN'2023-15-05' AND '2023-15-06'