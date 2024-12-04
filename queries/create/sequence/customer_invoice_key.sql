create sequence if not exists production.star."Customer Invoice Key"
-- create or replace sequence production.star."Customer Invoice Key"
    start = 1
    increment = 1
    order
    comment = 'Generates unique values for the customer invoice key column in the customer invoice table'
;