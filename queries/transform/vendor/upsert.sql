merge into production.star."Vendor" using (
    select stg.$52 as "Address Line 1"
        , nullif(trim(replace(replace(stg.$92, '&T', ifnull(stg.$53, '')), '&N', ifnull(stg.$55, '')), ' '), '') as "Address Line 2"
        , stg.$54 as "Address Line 3"
        , 'Esser' as "Business Unit"
        , nullif(trim(concat_ws(' ', ifnull(stg.$58, ''), ifnull(stg.$60, ''), ifnull(stg.$61, '')), ' '), '') as "City"
        , ifnull(co."Name", stg.$90) as "Country (English)"
        , stg.$109 as "Country (German)"
        , to_timestamp_ntz(stg.$37 || ' ' || stg.$38) as "Create Date"
        , stg.$141 as "Credit Terms (English)"
        , stg.$134 as "Credit Terms (German)"
        , ifnull(cu."Name", stg.$151) as "Currency"
        , greatest(
            to_timestamp_ntz(coalesce(stg.$2 || ' ' || stg.$3, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$42 || ' ' || stg.$43, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$84 || ' ' || stg.$85, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$113 || ' ' || stg.$114, '1970-01-01 00:00:00.000'))
        ) as "Effective Date"
        , stg.$67 as "Fax Number"
        , ifnull(l."Name", stg.$12) as "Language"
        , nullif(trim(concat_ws(' ', ifnull(stg.$49, ''), ifnull(stg.$50, ''), ifnull(stg.$51, '')), ' '), '') as "Name"
        , stg.$64 as "Phone Number"
        , stg.$59 as "Postal Code"
        , ifnull(s."Name", concat_ws('-', stg.$90, ifnull(stg.$170, stg.$166))) as "State/Province"
        , stg.$5 as "Vendor Number"
    from <<FILENAME>> as stg
        left join helper.iso."Country" as co
            on stg.$90 = co."Alpha-2 Code"
        left join helper.iso."Country Subdivision" as s
            on concat_ws('-', stg.$90, ifnull(stg.$170, stg.$166)) = s."Code"
        left join helper.iso."Currency" as cu
            on stg.$151 = cu."Alphabetic Code"
        left join helper.iso."Language" as l
            on case
                when stg.$12 = 'D' then 'DE'
                when stg.$12 = 'E' then 'EN'
                else null
            end = l."Alpha-2 Code"        
) as bucket on production.star."Vendor"."Vendor Number" = bucket."Vendor Number"
when matched and (
       ifnull("Vendor"."Address Line 1", '') != ifnull(bucket."Address Line 1", '')
    or ifnull("Vendor"."Address Line 2", '') != ifnull(bucket."Address Line 2", '')
    or ifnull("Vendor"."Address Line 3", '') != ifnull(bucket."Address Line 3", '')
    or ifnull("Vendor"."City", '') != ifnull(bucket."City", '')
    or ifnull("Vendor"."Country (English)", '') != ifnull(bucket."Country (English)", '')
    or ifnull("Vendor"."Country (German)", '') != ifnull(bucket."Country (German)", '')
    or ifnull("Vendor"."Credit Terms (English)", '') != ifnull(bucket."Credit Terms (English)", '')
    or ifnull("Vendor"."Credit Terms (German)", '') != ifnull(bucket."Credit Terms (German)", '')
    or ifnull("Vendor"."Currency", '') != ifnull(bucket."Currency", '')
    or ifnull("Vendor"."Fax Number", '') != ifnull(bucket."Fax Number", '')
    or ifnull("Vendor"."Language", '') != ifnull(bucket."Language", '')
    or ifnull("Vendor"."Name", '') != ifnull(bucket."Name", '')
    or ifnull("Vendor"."Phone Number", '') != ifnull(bucket."Phone Number", '')
    or ifnull("Vendor"."Postal Code", '') != ifnull(bucket."Postal Code", '')
    or ifnull("Vendor"."State/Province", '') != ifnull(bucket."State/Province", '')
) then update set
    "Vendor"."Address Line 1" = bucket."Address Line 1"
    , "Vendor"."Address Line 2" = bucket."Address Line 2"
    , "Vendor"."Address Line 3" = bucket."Address Line 3"
    , "Vendor"."City" = bucket."City"
    , "Vendor"."Country (English)" = bucket."Country (English)"
    , "Vendor"."Country (German)" = bucket."Country (German)"
    , "Vendor"."Credit Terms (English)" = bucket."Credit Terms (English)"
    , "Vendor"."Credit Terms (German)" = bucket."Credit Terms (German)"
    , "Vendor"."Currency" = bucket."Currency"
    , "Vendor"."Effective Date" = bucket."Effective Date"
    , "Vendor"."Fax Number" = bucket."Fax Number"
    , "Vendor"."Key" = production.star."Vendor Key".nextval
    , "Vendor"."Language" = bucket."Language"
    , "Vendor"."Name" = bucket."Name"
    , "Vendor"."Phone Number" = bucket."Phone Number"
    , "Vendor"."Postal Code" = bucket."Postal Code"
    , "Vendor"."State/Province" = bucket."State/Province"
when not matched then insert (
    "Address Line 1"
    , "Address Line 2"
    , "Address Line 3"
    , "Business Unit"
    , "City"
    , "Country (English)"
    , "Country (German)"
    , "Create Date"
    , "Credit Terms (English)"
    , "Credit Terms (German)"
    , "Currency"
    , "Effective Date"
    , "Fax Number"
    , "Key"
    , "Language"
    , "Name"
    , "Phone Number"
    , "Postal Code"
    , "State/Province"
    , "Vendor Number"
) values (
    bucket."Address Line 1"
    , bucket."Address Line 2"
    , bucket."Address Line 3"
    , bucket."Business Unit"
    , bucket."City"
    , bucket."Country (English)"
    , bucket."Country (German)"
    , bucket."Create Date"
    , bucket."Credit Terms (English)"
    , bucket."Credit Terms (German)"
    , bucket."Currency"
    , bucket."Effective Date"
    , bucket."Fax Number"
    , production.star."Vendor Key".nextval
    , bucket."Language"
    , bucket."Name"
    , bucket."Phone Number"
    , bucket."Postal Code"
    , bucket."State/Province"
    , bucket."Vendor Number"
);