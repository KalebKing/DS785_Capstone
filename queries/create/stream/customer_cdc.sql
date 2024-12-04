create stream if not exists production.star."Customer CDC" on table "Customer"
-- create or replace stream production.star."Customer CDC" on table "Customer"
    comment = 'Monitors and logs changes to the customer table'
;