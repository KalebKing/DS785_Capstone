merge into production.star."Purchase Order" using (
    select 'Esser' as "Business Unit"
        , stg.$21 as "Carrier"
        , to_timestamp_ntz(stg.$11 || ' ' || stg.$12) as "Create Date"
        , stg.$24 as "Credit Terms"
        , cu."Name" as "Currency"
        , stg.$9::date as "Due Date"
        , greatest(
            to_timestamp_ntz(coalesce(stg.$1 || ' ' || stg.$2, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$17 || ' ' || stg.$18, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$19 || ' ' || stg.$20, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$22 || ' ' || stg.$23, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$25 || ' ' || stg.$26, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$28 || ' ' || stg.$29, '1970-01-01 00:00:00.000'))
        ) as "Effective Date"
        , iff(stg.$30 != 'EUR', stg.$8::number(38, 2) * cx."Midpoint", stg.$8::number(38, 2)) as "Extended Price"
        , initcap(stg.$27) as "Incoterms"
        , ifnull(l."Name", stg.$14) as "Language"
        , iff(stg.$7::number(38, 3) = 0, null, stg.$10::date) as "Last Received Date"
        , stg.$3::number(38, 1) as "Line Number"
        , stg.$15::date as "Order Date"
        , stg.$13::number(38, 0) as "Order Number"
        , stg.$6::number(38, 3) as "Quantity Ordered"
        , stg.$7::number(38, 3) as "Quantity Received"
        , stg.$31 as "Reference Number"
        , stg.$5 as "SKU"
        , case
            when stg.$4::boolean = true then 'Active'
            else 'Inactive' end as "Status"
        , iff(stg.$30 != 'EUR', stg.$8::number(38, 2) * cx."Midpoint", stg.$8::number(38, 2)) / iff(stg.$6::number(38, 3) = 0, 1, stg.$6::number(38, 3)) as "Unit Price"
        , stg.$16 as "Vendor Number"
    from <<FILENAME>> as stg
        left join helper.iso."Currency" as cu
            on cu."Alphabetic Code" = 'EUR'
        left join helper.iso."Language" as l
            on case
                when stg.$14 = 'D' then 'DE'
                when stg.$14 = 'E' then 'EN'
                else null
            end = l."Alpha-2 Code"
        left join production.helper."Currency Exchange Rates" as cx
            on stg.$30 = cx."From Currency"
            and cx."To Currency" = 'EUR'
            and to_timestamp_ntz(stg.$17 || ' ' || stg.$18) >= cx."Effective Date"
            and to_timestamp_ntz(stg.$17 || ' ' || stg.$18) < cx."Expiration Date"
) as bucket
    on production.star."Purchase Order"."Order Number" = bucket."Order Number"
    and production.star."Purchase Order"."Line Number" = bucket."Line Number"
when matched and (
       ifnull("Purchase Order"."Business Unit", '') != ifnull(bucket."Business Unit", '')
    or ifnull("Purchase Order"."Carrier", '') != ifnull(bucket."Carrier", '')
    or ifnull("Purchase Order"."Credit Terms", '') != ifnull(bucket."Credit Terms", '')
    or ifnull("Purchase Order"."Currency", '') != ifnull(bucket."Currency", '')
    or ifnull("Purchase Order"."Due Date", '1970-01-01') != ifnull(bucket."Due Date", '1970-01-01')
    or ifnull("Purchase Order"."Extended Price", 0) != ifnull(bucket."Extended Price", 0)
    or ifnull("Purchase Order"."Incoterms", '') != ifnull(bucket."Incoterms", '')
    or ifnull("Purchase Order"."Language", '') != ifnull(bucket."Language", '')
    or ifnull("Purchase Order"."Last Received Date", '1970-01-01') != ifnull(bucket."Last Received Date", '1970-01-01')
    or ifnull("Purchase Order"."Order Date", '1970-01-01') != ifnull(bucket."Order Date", '1970-01-01')
    or ifnull("Purchase Order"."Quantity Ordered", 0) != ifnull(bucket."Quantity Ordered", 0)
    or ifnull("Purchase Order"."Quantity Received", 0) != ifnull(bucket."Quantity Received", 0)
    or ifnull("Purchase Order"."Reference Number", -1) != ifnull(bucket."Reference Number", -1)
    or ifnull("Purchase Order"."SKU", '') != ifnull(bucket."SKU", '')
    or ifnull("Purchase Order"."Status", '') != ifnull(bucket."Status", '')
    or ifnull("Purchase Order"."Vendor Number", -1) != ifnull(bucket."Vendor Number", -1)
) then update set
      "Purchase Order"."Business Unit" = bucket."Business Unit"
    , "Purchase Order"."Carrier" = bucket."Carrier"
    , "Purchase Order"."Credit Terms" = bucket."Credit Terms"
    , "Purchase Order"."Currency" = bucket."Currency"
    , "Purchase Order"."Due Date" = bucket."Due Date"
    , "Purchase Order"."Effective Date" = bucket."Effective Date"
    , "Purchase Order"."Extended Price" = bucket."Extended Price"
    , "Purchase Order"."Incoterms" = bucket."Incoterms"
    , "Purchase Order"."Language" = bucket."Language"
    , "Purchase Order"."Last Received Date" = bucket."Last Received Date"
    , "Purchase Order"."Order Date" = bucket."Order Date"
    , "Purchase Order"."Quantity Ordered" = bucket."Quantity Ordered"
    , "Purchase Order"."Quantity Received" = bucket."Quantity Received"
    , "Purchase Order"."Reference Number" = bucket."Reference Number"
    , "Purchase Order"."SKU" = bucket."SKU"
    , "Purchase Order"."Status" = bucket."Status"
    , "Purchase Order"."Unit Price" = bucket."Unit Price"
    , "Purchase Order"."Vendor Number" = bucket."Vendor Number"
when not matched then insert (
    "Business Unit"
    , "Carrier"
    , "Create Date"
    , "Credit Terms"
    , "Currency"
    , "Due Date"
    , "Effective Date"
    , "Extended Price"
    , "Incoterms"
    , "Language"
    , "Last Received Date"
    , "Line Number"
    , "Order Date"
    , "Order Number"
    , "Quantity Ordered"
    , "Quantity Received"
    , "Reference Number"
    , "SKU"
    , "Status"
    , "Unit Price"
    , "Vendor Number"
) values (
    bucket."Business Unit"
    , bucket."Carrier"
    , bucket."Create Date"
    , bucket."Credit Terms"
    , bucket."Currency"
    , bucket."Due Date"
    , bucket."Create Date"
    , bucket."Extended Price"
    , bucket."Incoterms"
    , bucket."Language"
    , bucket."Last Received Date"
    , bucket."Line Number"
    , bucket."Order Date"
    , bucket."Order Number"
    , bucket."Quantity Ordered"
    , bucket."Quantity Received"
    , bucket."Reference Number"
    , bucket."SKU"
    , bucket."Status"
    , bucket."Unit Price"
    , bucket."Vendor Number"
);