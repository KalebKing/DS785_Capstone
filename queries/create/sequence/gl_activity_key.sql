create sequence if not exists production.star."General Ledger Key"
-- create or replace sequence production.star."General Ledger Key"
    start = 1
    increment = 1
    order
    comment = 'Generates unique values for the general ledger key column in the general ledger table'
;