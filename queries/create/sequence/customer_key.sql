create sequence if not exists production.star."Customer Key"
-- create or replace sequence production.star."Customer Key"
    start = 1
    increment = 1
    order
    comment = 'Generates unique values for the customer key column in the customer table'
;