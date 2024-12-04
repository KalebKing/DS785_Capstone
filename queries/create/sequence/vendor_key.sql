create sequence if not exists production.star."Vendor Key"
-- create or replace sequence production.star."Vendor Key"
    start = 1
    increment = 1
    order
    comment = 'Generates unique values for the vendor key column in the vendor table'
;