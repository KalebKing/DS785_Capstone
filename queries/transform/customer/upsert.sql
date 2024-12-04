merge into production.star."Customer" using (
    select stg.$85 as "Address Line 1"
        , nullif(trim(replace(replace(stg.$125, '&T', ifnull(stg.$86, '')), '&N', ifnull(stg.$88, '')), ' '), '') as "Address Line 2"
        , stg.$87 as "Address Line 3"
        , nullif(split_part(stg.$281, ';', 1), '') as "Bauart 1"
        , nullif(split_part(stg.$281, ';', 2), '') as "Bauart 2"
        , nullif(split_part(stg.$281, ';', 3), '') as "Bauart 3"
        , nullif(split_part(stg.$281, ';', 4), '') as "Bauart 4"
        , 'Esser' as "Business Unit"
        , nullif(trim(concat_ws(' ', ifnull(stg.$91, ''), ifnull(stg.$93, ''), ifnull(stg.$94, '')), ' '), '') as "City"
        , ifnull(co."Name", stg.$123) as "Country (English)"
        , stg.$142 as "Country (German)"
        , to_timestamp_ntz(stg.$60 || ' ' || stg.$61) as "Create Date"
        , stg.$41 as "Credit Limit"
        , stg.$174 as "Credit Terms (English)"
        , stg.$167 as "Credit Terms (German)"
        , ifnull(cu."Name", stg.$305) as "Currency"
        , stg.$5 as "Customer Number"
        , greatest(
            to_timestamp_ntz(coalesce(stg.$2 || ' ' || stg.$3, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$75 || ' ' || stg.$76, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$117 || ' ' || stg.$118, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$145 || ' ' || stg.$146, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$184 || ' ' || stg.$185, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$204 || ' ' || stg.$205, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$208 || ' ' || stg.$209, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$300 || ' ' || stg.$301, '1970-01-01 00:00:00.000'))
        ) as "Effective Date"
        , stg.$100 as "Fax Number"
        , stg.$194 as "Industry (English)"
        , stg.$190 as "Industry (German)"
        , nullif(trim(concat_ws(' ', ifnull(stg.$82, ''), ifnull(stg.$83, ''), ifnull(stg.$84, '')), ' '), '') as "Name"
        , ifnull(l."Name", stg.$13) as "Language"
        , stg.$97 as "Phone Number"
        , stg.$92 as "Postal Code"
        , nullif(trim(concat_ws(' ', ifnull(stg.$230, ''), ifnull(stg.$231, '')), ' '), '') as "Salesperson"
        , ifnull(s."Name", concat_ws('-', stg.$123, ifnull(stg.$324, stg.$320))) as "State/Province"
        , split_part(stg.$298, ';', 1) as "Type"
        , stg.$102 as "Website"
    from <<FILENAME>> as stg
        left join helper.iso."Country" as co
            on stg.$123 = co."Alpha-2 Code"
        left join helper.iso."Country Subdivision" as s
            on concat_ws('-', stg.$123, ifnull(stg.$324, stg.$320)) = s."Code"
        left join helper.iso."Currency" as cu
            on stg.$305 = cu."Alphabetic Code"
        left join helper.iso."Language" as l
            on case
                when stg.$13 = 'D' then 'DE'
                when stg.$13 = 'E' then 'EN'
                else null
            end = l."Alpha-2 Code"
) as bucket on production.star."Customer"."Customer Number" = bucket."Customer Number"
when matched and (
       ifnull("Customer"."Address Line 1", '') != ifnull(bucket."Address Line 1", '')
    or ifnull("Customer"."Address Line 2", '') != ifnull(bucket."Address Line 2", '')
    or ifnull("Customer"."Address Line 3", '') != ifnull(bucket."Address Line 3", '')
    or ifnull("Customer"."Bauart 1", '') != ifnull(bucket."Bauart 1", '')
    or ifnull("Customer"."Bauart 2", '') != ifnull(bucket."Bauart 2", '')
    or ifnull("Customer"."Bauart 3", '') != ifnull(bucket."Bauart 3", '')
    or ifnull("Customer"."Bauart 4", '') != ifnull(bucket."Bauart 4", '')
    or ifnull("Customer"."City", '') != ifnull(bucket."City", '')
    or ifnull("Customer"."Country (English)", '') != ifnull(bucket."Country (English)", '')
    or ifnull("Customer"."Country (German)", '') != ifnull(bucket."Country (German)", '')
    or ifnull("Customer"."Credit Limit", 0) != ifnull(bucket."Credit Limit", 0)
    or ifnull("Customer"."Credit Terms (English)", '') != ifnull(bucket."Credit Terms (English)", '')
    or ifnull("Customer"."Credit Terms (German)", '') != ifnull(bucket."Credit Terms (German)", '')
    or ifnull("Customer"."Currency", '') != ifnull(bucket."Currency", '')
    or ifnull("Customer"."Fax Number", '') != ifnull(bucket."Fax Number", '')
    or ifnull("Customer"."Industry (English)", '') != ifnull(bucket."Industry (English)", '')
    or ifnull("Customer"."Industry (German)", '') != ifnull(bucket."Industry (German)", '')
    or ifnull("Customer"."Language", '') != ifnull(bucket."Language", '')
    or ifnull("Customer"."Name", '') != ifnull(bucket."Name", '')
    or ifnull("Customer"."Phone Number", '') != ifnull(bucket."Phone Number", '')
    or ifnull("Customer"."Postal Code", '') != ifnull(bucket."Postal Code", '')
    or ifnull("Customer"."Salesperson", '') != ifnull(bucket."Salesperson", '')
    or ifnull("Customer"."State/Province", '') != ifnull(bucket."State/Province", '')
    or ifnull("Customer"."Type", '') != ifnull(bucket."Type", '')
    or ifnull("Customer"."Website", '') != ifnull(bucket."Website", '')
) then update set
      "Customer"."Address Line 1" = bucket."Address Line 1"
    , "Customer"."Address Line 2" = bucket."Address Line 2"
    , "Customer"."Address Line 3" = bucket."Address Line 3"
    , "Customer"."Bauart 1" = bucket."Bauart 1"
    , "Customer"."Bauart 2" = bucket."Bauart 2"
    , "Customer"."Bauart 3" = bucket."Bauart 3"
    , "Customer"."Bauart 4" = bucket."Bauart 4"
    , "Customer"."City" = bucket."City"
    , "Customer"."Country (English)" = bucket."Country (English)"
    , "Customer"."Country (German)" = bucket."Country (German)"
    , "Customer"."Credit Limit" = bucket."Credit Limit"
    , "Customer"."Credit Terms (English)" = bucket."Credit Terms (English)"
    , "Customer"."Credit Terms (German)" = bucket."Credit Terms (German)"
    , "Customer"."Currency" = bucket."Currency"
    , "Customer"."Effective Date" = bucket."Effective Date"
    , "Customer"."Fax Number" = bucket."Fax Number"
    , "Customer"."Industry (English)" = bucket."Industry (English)"
    , "Customer"."Industry (German)" = bucket."Industry (German)"
    , "Customer"."Key" = production.star."Customer Key".nextval
    , "Customer"."Language" = bucket."Language"
    , "Customer"."Name" = bucket."Name"
    , "Customer"."Phone Number" = bucket."Phone Number"
    , "Customer"."Postal Code" = bucket."Postal Code"
    , "Customer"."Salesperson" = bucket."Salesperson"
    , "Customer"."State/Province" = bucket."State/Province"
    , "Customer"."Type" = bucket."Type"
    , "Customer"."Website" = bucket."Website"
when not matched then insert (
      "Address Line 1"
    , "Address Line 2"
    , "Address Line 3"
    , "Bauart 1"
    , "Bauart 2"
    , "Bauart 3"
    , "Bauart 4"
    , "Business Unit"
    , "City"
    , "Country (English)"
    , "Country (German)"
    , "Create Date"
    , "Credit Limit"
    , "Credit Terms (English)"
    , "Credit Terms (German)"
    , "Currency"
    , "Customer Number"
    , "Effective Date"
    , "Fax Number"
    , "Industry (English)"
    , "Industry (German)"
    , "Key"
    , "Language"
    , "Name"
    , "Phone Number"
    , "Postal Code"
    , "Salesperson"
    , "State/Province"
    , "Type"
    , "Website"
) values (
      bucket."Address Line 1"
    , bucket."Address Line 2"
    , bucket."Address Line 3"
    , bucket."Bauart 1"
    , bucket."Bauart 2"
    , bucket."Bauart 3"
    , bucket."Bauart 4"
    , bucket."Business Unit"
    , bucket."City"
    , bucket."Country (English)"
    , bucket."Country (German)"
    , bucket."Create Date"
    , bucket."Credit Limit"
    , bucket."Credit Terms (English)"
    , bucket."Credit Terms (German)"
    , bucket."Currency"
    , bucket."Customer Number"
    , bucket."Create Date"
    , bucket."Fax Number"
    , bucket."Industry (English)"
    , bucket."Industry (German)"
    , production.star."Customer Key".nextval
    , bucket."Language"
    , bucket."Name"
    , bucket."Phone Number"
    , bucket."Postal Code"
    , bucket."Salesperson"
    , bucket."State/Province"
    , bucket."Type"
    , bucket."Website"
);