create stream if not exists production.star."Vendor CDC" on table "Vendor"
-- create or replace stream production.star."Vendor CDC" on table "Vendor"
    comment = 'Monitors and logs changes to the vendor table'
;