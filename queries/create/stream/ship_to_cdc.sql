create stream if not exists production.star."Ship To CDC" on table "Ship To"
-- create or replace stream production.star."Ship To CDC" on table "Ship To"
    comment = 'Monitors and logs changes to the ship to table'
;