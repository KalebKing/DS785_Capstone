create sequence if not exists production.star."Ship To Key"
-- create or replace sequence production.star."Ship To Key"
    start = 1
    increment = 1
    order
    comment = 'Generates unique values for the ship to key column in the ship to table'
;