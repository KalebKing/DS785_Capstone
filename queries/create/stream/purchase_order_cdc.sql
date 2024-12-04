create stream if not exists production.star."Purchase Order CDC" on table "Purchase Order"
-- create or replace stream production.star."Purchase Order CDC" on table "Purchase Order"
    comment = 'Monitors and logs changes to the purchase order table'
;