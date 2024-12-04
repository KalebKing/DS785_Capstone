merge into production.star."Product" using (
    select
        stg.$6 as "ABC Code"
        , nullif(split_part(stg.$13, ';', 1), '') as "Bauart 1"
        , nullif(split_part(stg.$13, ';', 2), '') as "Bauart 2"
        , nullif(split_part(stg.$13, ';', 3), '') as "Bauart 3"
        , nullif(split_part(stg.$13, ';', 4), '') as "Bauart 4"
        , 'Esser' as "Business Unit"
        , ifnull(c."Name", stg.$17) as "Country of Origin (English)"
        , stg.$18 as "Country of Origin (German)"
        , to_timestamp_ntz(stg.$7 || ' ' || stg.$8) as "Create Date"
        , trim(replace(ifnull(stg.$12, stg.$11), ';', ' ')) as "Description (English)"
        , trim(replace(stg.$11, ';', ' ')) as "Description (German)"
        , greatest(
            to_timestamp_ntz(coalesce(stg.$1 || ' ' || stg.$2, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$15 || ' ' || stg.$16, '1970-01-01 00:00:00.000'))
        ) as "Effective Date"
        , nullif(split_part(stg.$14, ';', 1), '') as "Family"
        , stg.$21 as "HS Code"
        , case
            when stg.$4 in ('10', '19', '50', '62') then 'Raw Material'
            when stg.$4 in ('0', '40') then 'Work in Process'
            when stg.$4 in ('9', '15', '60', '70', '75') then 'Finished Goods'
            else 'Other'
        end as "Inventory Type"
        , nullif(split_part(stg.$14, ';', 2), '') as "Line"
        , stg.$3 as "SKU"
        , case
            when stg.$10 = 'P' then 'Manufactured'
            when stg.$10 = 'E' then 'Purchased'
            else 'Other'
        end as "Source"
        , case
            when stg.$5 = 'False' then 'Active'
            when stg.$5 = 'True' then 'Inactive'
            else stg.$5
        end as "Status"
        , case
            when stg.$9 > 0 then 'Stocked'
            when stg.$9 = 0 then 'Non-Stocked'
            else stg.$9
        end as "Stocked Flag"
        , nullif(split_part(stg.$5, ';', 3), '') as "Type"
        , initcap(
            case
                when stg.$20 = 'piece w/o Nk' then 'piece'
                else stg.$20
            end
        ) as "Unit of Measure (English)"
        , stg.$19 as "Unit of Measure (German)"
    from <<FILENAME>> as stg
        left join helper.iso."Country" as c
            on stg.$17 = c."Alpha-2 Code"
) as bucket on production.star."Product"."SKU" = bucket."SKU"
when matched and (
    ifnull("Product"."ABC Code", '') != ifnull(bucket."ABC Code", '')
    or ifnull("Product"."Bauart 1", '') != ifnull(bucket."Bauart 1", '')
    or ifnull("Product"."Bauart 2", '') != ifnull(bucket."Bauart 2", '')
    or ifnull("Product"."Bauart 3", '') != ifnull(bucket."Bauart 3", '')
    or ifnull("Product"."Bauart 4", '') != ifnull(bucket."Bauart 4", '')
    or ifnull("Product"."Country of Origin (English)", '') != ifnull(bucket."Country of Origin (English)", '')
    or ifnull("Product"."Country of Origin (German)", '') != ifnull(bucket."Country of Origin (German)", '')
    or ifnull("Product"."Description (English)", '') != ifnull(bucket."Description (English)", '')
    or ifnull("Product"."Description (German)", '') != ifnull(bucket."Description (German)", '')
    or ifnull("Product"."Family", '') != ifnull(bucket."Family", '')
    or ifnull("Product"."HS Code", '') != ifnull(bucket."HS Code", '')
    or ifnull("Product"."Inventory Type", '') != ifnull(bucket."Inventory Type", '')
    or ifnull("Product"."Line", '') != ifnull(bucket."Line", '')
    or ifnull("Product"."Source", '') != ifnull(bucket."Source", '')
    or ifnull("Product"."Status", '') != ifnull(bucket."Status", '')
    or ifnull("Product"."Stocked Flag", '') != ifnull(bucket."Stocked Flag", '')
    or ifnull("Product"."Type", '') != ifnull(bucket."Type", '')
    or ifnull("Product"."Unit of Measure (English)", '') != ifnull(bucket."Unit of Measure (English)", '')
    or ifnull("Product"."Unit of Measure (German)", '') != ifnull(bucket."Unit of Measure (German)", '')
) then update set
    "Product"."ABC Code" = bucket."ABC Code"
    , "Product"."Bauart 1" = bucket."Bauart 1"
    , "Product"."Bauart 2" = bucket."Bauart 2"
    , "Product"."Bauart 3" = bucket."Bauart 3"
    , "Product"."Bauart 4" = bucket."Bauart 4"
    , "Product"."Country of Origin (English)" = bucket."Country of Origin (English)"
    , "Product"."Country of Origin (German)" = bucket."Country of Origin (German)"
    , "Product"."Description (English)" = bucket."Description (English)"
    , "Product"."Description (German)" = bucket."Description (German)"
    , "Product"."Effective Date" = bucket."Effective Date"
    , "Product"."Family" = bucket."Family"
    , "Product"."HS Code" = bucket."HS Code"
    , "Product"."Inventory Type" = bucket."Inventory Type"
    , "Product"."Key" = production.star."Product Key".nextval
    , "Product"."Line" = bucket."Line"
    , "Product"."Source" = bucket."Source"
    , "Product"."Status" = bucket."Status"
    , "Product"."Stocked Flag" = bucket."Stocked Flag"
    , "Product"."Type" = bucket."Type"
    , "Product"."Unit of Measure (English)" = bucket."Unit of Measure (English)"
    , "Product"."Unit of Measure (German)" = bucket."Unit of Measure (German)"
when not matched then insert (
    "Product"."ABC Code"
    , "Product"."Bauart 1"
    , "Product"."Bauart 2"
    , "Product"."Bauart 3"
    , "Product"."Bauart 4"
    , "Product"."Business Unit"
    , "Product"."Country of Origin (English)"
    , "Product"."Country of Origin (German)"
    , "Product"."Create Date"
    , "Product"."Description (English)"
    , "Product"."Description (German)"
    , "Product"."Effective Date"
    , "Product"."Family"
    , "Product"."HS Code"
    , "Product"."Inventory Type"
    , "Product"."Key"
    , "Product"."Line"
    , "Product"."SKU"
    , "Product"."Source"
    , "Product"."Status"
    , "Product"."Stocked Flag"
    , "Product"."Type"
    , "Product"."Unit of Measure (English)"
    , "Product"."Unit of Measure (German)"
) values (
    bucket."ABC Code"
    , bucket."Bauart 1"
    , bucket."Bauart 2"
    , bucket."Bauart 3"
    , bucket."Bauart 4"
    , bucket."Business Unit"
    , bucket."Country of Origin (English)"
    , bucket."Country of Origin (German)"
    , bucket."Create Date"
    , bucket."Description (English)"
    , bucket."Description (German)"
    , bucket."Create Date"
    , bucket."Family"
    , bucket."HS Code"
    , bucket."Inventory Type"
    , production.star."Product Key".nextval
    , bucket."Line"
    , bucket."SKU"
    , bucket."Source"
    , bucket."Status"
    , bucket."Stocked Flag"
    , bucket."Type"
    , bucket."Unit of Measure (English)"
    , bucket."Unit of Measure (German)"
);
