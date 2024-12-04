create sequence if not exists production.star."Customer Order Key"
-- create or replace sequence production.star."Customer Order Key"
    start = 1
    increment = 1
    order
    comment = 'Generates unique values for the customer order key column in the customer order table'
;