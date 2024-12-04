create stream if not exists production.star."Customer Order CDC" on table "Customer Order"
-- create or replace stream production.star."Customer Order CDC" on table "Customer Order"
    comment = 'Monitors and logs changes to the customer order table'
;