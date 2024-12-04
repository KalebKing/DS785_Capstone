create sequence if not exists production.star."Product Key"
-- create or replace sequence production.star."Product Key"
    start = 1
    increment = 1
    order
    comment = 'Generates unique values for the product key column in the product table'
;