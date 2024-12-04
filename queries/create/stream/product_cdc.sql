create stream if not exists production.star."Product CDC" on table "Product"
-- create or replace stream production.star."Product CDC" on table "Product"
    comment = 'Monitors and logs changes to the product table'
;