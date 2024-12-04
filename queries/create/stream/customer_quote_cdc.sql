create stream if not exists production.star."Customer Quote CDC" on table "Customer Quote"
-- create or replace stream production.star."Customer Quote CDC" on table "Customer Quote"
    comment = 'Monitors and logs changes to the customer quote table'
;