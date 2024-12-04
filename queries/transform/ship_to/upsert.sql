merge into production.star."Ship To" using (
    select stg.$12 as "Address Line 1"
        , nullif(trim(replace(replace(stg.$25, '&T', ifnull(stg.$13, '')), '&N', ifnull(stg.$14, '')), ' '), '') as "Address Line 2"
        , stg.$14 as "Address Line 3"
        , 'Esser' as "Business Unit"
        , stg.$43 as "Carrier (English)"
        , stg.$42 as "Carrier (German)"
        , nullif(trim(concat_ws(' ', ifnull(stg.$16, ''), ifnull(stg.$18, ''), ifnull(stg.$19, '')), ' '), '') as "City"
        , ifnull(co."Name", stg.$24) as "Country (English)"
        , stg.$26 as "Country (German)"
        , to_timestamp_ntz(stg.$3 || ' ' || stg.$4) as "Create Date"
        , ifnull(cu."Name", stg.$39) as "Currency"
        , stg.$1 as "Customer Number"
        , greatest(
            to_timestamp_ntz(coalesce(stg.$5 || ' ' || stg.$6, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$7 || ' ' || stg.$8, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$22 || ' ' || stg.$23, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$30 || ' ' || stg.$31, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$33 || ' ' || stg.$34, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$37 || ' ' || stg.$38, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$40 || ' ' || stg.$41, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$44 || ' ' || stg.$45, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$46 || ' ' || stg.$47, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$48 || ' ' || stg.$49, '1970-01-01 00:00:00.000'))
        ) as "Effective Date"
        , stg.$21 as "Fax Number"
        , initcap(stg.$36) as "Incoterms (English)"
        , stg.$35 as "Incoterms (German)"
        , ifnull(l."Name", stg.$32) as "Language"
        , nullif(trim(concat_ws(' ', ifnull(stg.$9, ''), ifnull(stg.$10, ''), ifnull(stg.$11, '')), ' '), '') as "Name"
        , stg.$20 as "Phone Number"
        , stg.$17 as "Postal Code"
        , nullif(trim(concat_ws(' ', ifnull(stg.$50, ''), ifnull(stg.$51, '')), ' '), '') as "Salesperson"
        , stg.$2 as "Ship To Number"
        , ifnull(s."Name", concat_ws('-', stg.$24, ifnull(stg.$29, stg.$27))) as "State/Province"
    from <<FILENAME>> as stg
        left join helper.iso."Country" as co
            on stg.$24 = co."Alpha-2 Code"
        left join helper.iso."Country Subdivision" as s
            on concat_ws('-', stg.$24, ifnull(stg.$29, stg.$27)) = s."Code"
        left join helper.iso."Currency" as cu
            on stg.$39 = cu."Alphabetic Code"
        left join helper.iso."Language" as l
            on case
                when stg.$32 = 'D' then 'DE'
                when stg.$32 = 'E' then 'EN'
                else null
            end = l."Alpha-2 Code"
) as bucket on production.star."Ship To"."Customer Number" = bucket."Customer Number"
    and production.star."Ship To"."Ship To Number" = bucket."Ship To Number"
when matched and (
    ifnull("Ship To"."Address Line 1", '') != ifnull(bucket."Address Line 1", '')
    or ifnull("Ship To"."Address Line 2", '') != ifnull(bucket."Address Line 2", '')
    or ifnull("Ship To"."Address Line 3", '') != ifnull(bucket."Address Line 3", '')
    or ifnull("Ship To"."Carrier (English)", '') != ifnull(bucket."Carrier (English)", '')
    or ifnull("Ship To"."Carrier (German)", '') != ifnull(bucket."Carrier (German)", '')
    or ifnull("Ship To"."City", '') != ifnull(bucket."City", '')
    or ifnull("Ship To"."Country (English)", '') != ifnull(bucket."Country (English)", '')
    or ifnull("Ship To"."Country (German)", '') != ifnull(bucket."Country (German)", '')
    or ifnull("Ship To"."Currency", '') != ifnull(bucket."Currency", '')
    or ifnull("Ship To"."Fax Number", '') != ifnull(bucket."Fax Number", '')
    or ifnull("Ship To"."Incoterms (English)", '') != ifnull(bucket."Incoterms (English)", '')
    or ifnull("Ship To"."Incoterms (German)", '') != ifnull(bucket."Incoterms (German)", '')
    or ifnull("Ship To"."Language", '') != ifnull(bucket."Language", '')
    or ifnull("Ship To"."Name", '') != ifnull(bucket."Name", '')
    or ifnull("Ship To"."Phone Number", '') != ifnull(bucket."Phone Number", '')
    or ifnull("Ship To"."Postal Code", '') != ifnull(bucket."Postal Code", '')
    or ifnull("Ship To"."Salesperson", '') != ifnull(bucket."Salesperson", '')
    or ifnull("Ship To"."State/Province", '') != ifnull(bucket."State/Province", '')
) then update set
    "Ship To"."Address Line 1" = bucket."Address Line 1"
    , "Ship To"."Address Line 2" = bucket."Address Line 2"
    , "Ship To"."Address Line 3" = bucket."Address Line 3"
    , "Ship To"."Carrier (English)" = bucket."Carrier (English)"
    , "Ship To"."Carrier (German)" = bucket."Carrier (German)"
    , "Ship To"."City" = bucket."City"
    , "Ship To"."Country (English)" = bucket."Country (English)"
    , "Ship To"."Country (German)" = bucket."Country (German)"
    , "Ship To"."Currency" = bucket."Currency"
    , "Ship To"."Effective Date" = bucket."Effective Date"
    , "Ship To"."Fax Number" = bucket."Fax Number"
    , "Ship To"."Key" = production.star."Ship To Key".nextval
    , "Ship To"."Incoterms (English)" = bucket."Incoterms (English)"
    , "Ship To"."Incoterms (German)" = bucket."Incoterms (German)"
    , "Ship To"."Language" = bucket."Language"
    , "Ship To"."Name" = bucket."Name"
    , "Ship To"."Phone Number" = bucket."Phone Number"
    , "Ship To"."Postal Code" = bucket."Postal Code"
    , "Ship To"."Salesperson" = bucket."Salesperson"
    , "Ship To"."State/Province" = bucket."State/Province"
when not matched then insert (
    "Address Line 1"
    , "Address Line 2"
    , "Address Line 3"
    , "Business Unit"
    , "Carrier (English)"
    , "Carrier (German)"
    , "City"
    , "Country (English)"
    , "Country (German)"
    , "Create Date"
    , "Currency"
    , "Customer Number"
    , "Effective Date"
    , "Fax Number"
    , "Incoterms (English)"
    , "Incoterms (German)"
    , "Key"
    , "Language"
    , "Name"
    , "Phone Number"
    , "Postal Code"
    , "Salesperson"
    , "Ship To Number"
    , "State/Province"
) values (
    bucket."Address Line 1"
    , bucket."Address Line 2"
    , bucket."Address Line 3"
    , bucket."Business Unit"
    , bucket."Carrier (English)"
    , bucket."Carrier (German)"
    , bucket."City"
    , bucket."Country (English)"
    , bucket."Country (German)"
    , bucket."Create Date"
    , bucket."Currency"
    , bucket."Customer Number"
    , bucket."Create Date"
    , bucket."Fax Number"
    , bucket."Incoterms (English)"
    , bucket."Incoterms (German)"
    , production.star."Ship To Key".nextval
    , bucket."Language"
    , bucket."Name"
    , bucket."Phone Number"
    , bucket."Postal Code"
    , bucket."Salesperson"
    , bucket."Ship To Number"
    , bucket."State/Province"
);