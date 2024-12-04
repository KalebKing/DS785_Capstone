create sequence if not exists production.star."GL Account Key"
-- create or replace sequence production.star."GL Account Key"
    start = 1
    increment = 1
    order
    comment = 'Generates unique values for the gl account key column in the gl account table'
;