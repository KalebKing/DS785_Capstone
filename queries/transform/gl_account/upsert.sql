merge into production.star."GL Account" using (
    select stg.$3 as "Account"
        , 'Esser' as "Business Unit"
        , to_timestamp_ntz(stg.$5 || ' ' || stg.$6) as "Create Date"
        , ifnull(cu."Name", stg.$11) as "Currency"
        , greatest(
            to_timestamp_ntz(coalesce(stg.$1 || ' ' || stg.$2, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$9 || ' ' || stg.$10, '1970-01-01 00:00:00.000'))
        ) as "Effective Date"
        , stg.$8 as "Name (English)"
        , stg.$7 as "Name (German)"
        , case
            when stg.$4 = 'B' then 'Balance Sheet'
            when stg.$4 = 'G' then 'Income Statement'
            else stg.$4
        end as "Type"
    from <<FILENAME>> as stg
        left join helper.iso."Currency" as cu
            on stg.$11 = cu."Alphabetic Code"
) as bucket on production.star."GL Account"."Account" = bucket."Account"
when matched and (
    ifnull("GL Account"."Currency", '') != ifnull(bucket."Currency", '')
    or ifnull("GL Account"."Name (English)", '') != ifnull(bucket."Name (English)", '')
    or ifnull("GL Account"."Name (German)", '') != ifnull(bucket."Name (German)", '')
    or ifnull("GL Account"."Type", '') != ifnull(bucket."Type", '')
) then update set
    "GL Account"."Currency" = bucket."Currency"
    , "GL Account"."Effective Date" = bucket."Effective Date"
    , "GL Account"."Key" = production.star."GL Account Key".nextval
    , "GL Account"."Name (English)" = bucket."Name (English)"
    , "GL Account"."Name (German)" = bucket."Name (German)"
    , "GL Account"."Type" = bucket."Type"
when not matched then insert (
    "Account"
    , "Business Unit"
    , "Create Date"
    , "Currency"
    , "Effective Date"
    , "Key"
    , "Name (English)"
    , "Name (German)"
    , "Type"
) values (
    bucket."Account"
    , bucket."Business Unit"
    , bucket."Create Date"
    , bucket."Currency"
    , bucket."Create Date"
    , production.star."GL Account Key".nextval
    , bucket."Name (English)"
    , bucket."Name (German)"
    , bucket."Type"
);