create sequence if not exists production.star."Customer Quote Key"
-- create or replace sequence production.star."Customer Quote Key"
    start = 1
    increment = 1
    order
    comment = 'Generates unique values for the customer quote key column in the customer quote table'
;