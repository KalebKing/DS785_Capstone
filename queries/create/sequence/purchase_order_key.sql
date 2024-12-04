create sequence if not exists production.star."Purchase Order Key"
-- create or replace sequence production.star."Purchase Order Key"
    start = 1
    increment = 1
    order
    comment = 'Generates unique values for the purchase order key column in the purchase order table'
;