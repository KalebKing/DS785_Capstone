create stream if not exists production.star."GL Account CDC" on table "GL Account"
-- create or replace stream production.star."GL Account CDC" on table "GL Account"
    comment = 'Monitors and logs changes to the gl account table'
;