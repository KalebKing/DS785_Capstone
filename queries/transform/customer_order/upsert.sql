merge into production.star."Customer Order" using (
    select 'Esser' as "Business Unit"
        , stg.$35 as "Carrier"
        , to_timestamp_ntz(stg.$20 || ' ' || stg.$21) as "Create Date"
        , stg.$41 as "Credit Terms"
        , ifnull(cu."Name", stg.$44) as "Currency"
        , stg.$28 as "Customer Number"
        , stg.$27 as "Customer PO"
        , nullif(split_part(stg.$6, ';', 1), '') as "Customer SKU"
        , stg.$15 as "Due Date"
        , greatest(
            to_timestamp_ntz(coalesce(stg.$1 || ' ' || stg.$2, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$22 || ' ' || stg.$23, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$30 || ' ' || stg.$31, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$33 || ' ' || stg.$34, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$36 || ' ' || stg.$37, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$39 || ' ' || stg.$40, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$42 || ' ' || stg.$43, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$45 || ' ' || stg.$46, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$47 || ' ' || stg.$48, '1970-01-01 00:00:00.000'))
        ) as "Effective Date"
        , case
            when position(',', stg.$51) > 0 then trim(split_part(stg.$51, ',', 2) || ' ' || split_part(stg.$51, ',', 1))
            else stg.$16 end as "Entered By"
        , stg.$29::number(38, 10) as "Euro Exchange Rate"
        , stg.$11::number(38, 2) * iff(stg.$10::boolean = true, stg.$13 * stg.$12, 1) as "Extended Price"
        , initcap(stg.$38) as "Incoterms"
        , ifnull(l."Name", stg.$25) as "Language"
        , iff(stg.$9 = 0, null, stg.$14) as "Last Shipped Date"
        , stg.$3 as "Line Number"
        , stg.$26 as "Order Date"
        , stg.$24 as "Order Number"
        , stg.$7 as "Quantity Ordered"
        , stg.$8 as "Quantity Cancelled"
        , stg.$9 as "Quantity Shipped"
        , q."Line Number" as "Quote Line"
        , q."Quote Number" as "Quote Number"
        , stg.$52 as "Reference Number"
        , nullif(trim(concat_ws(' ', ifnull(stg.$49, ''), ifnull(stg.$50, '')), ' '), '') as "Salesperson"
        , stg.$32::number(38, 0)::varchar(10) as "Ship To Number"
        , stg.$5 as "SKU"
        , case
            when stg.$4::boolean = true then 'Active'
            else 'Inactive' end as "Status"
        , stg.$11::number(38, 2) * iff(stg.$10::boolean = true, stg.$13 * stg.$12, 1) / iff(stg.$7 - stg.$8 = 0, 1, stg.$7 - stg.$8) as "Unit Price"
    from <<FILENAME>> as stg
        left join helper.iso."Currency" as cu
            on stg.$44 = cu."Alphabetic Code"
        left join helper.iso."Language" as l
            on case
                when stg.$25 = 'D' then 'DE'
                when stg.$25 = 'E' then 'EN'
                else null
            end = l."Alpha-2 Code"
        left join production.star."Customer Quote" as q
            on stg.$17 = q."Reference Number"
            and stg.$18 = q."Line Number"
            and stg.$16 = 'A'
) as bucket
    on production.star."Customer Order"."Order Number" = bucket."Order Number"
    and production.star."Customer Order"."Line Number" = bucket."Line Number"
when matched and (
       ifnull("Customer Order"."Business Unit", '') != ifnull(bucket."Business Unit", '')
    or ifnull("Customer Order"."Carrier", '') != ifnull(bucket."Carrier", '')
    or ifnull("Customer Order"."Credit Terms", '') != ifnull(bucket."Credit Terms", '')
    or ifnull("Customer Order"."Currency", '') != ifnull(bucket."Currency", '')
    or ifnull("Customer Order"."Customer Number", -1) != ifnull(bucket."Customer Number", -1)
    or ifnull("Customer Order"."Customer PO", '') != ifnull(bucket."Customer PO", '')
    or ifnull("Customer Order"."Customer SKU", '') != ifnull(bucket."Customer SKU", '')
    or ifnull("Customer Order"."Due Date", '1970-01-01') != ifnull(bucket."Due Date", '1970-01-01')
    or ifnull("Customer Order"."Entered By", '') != ifnull(bucket."Entered By", '')
    or ifnull("Customer Order"."Euro Exchange Rate", 0) != ifnull(bucket."Euro Exchange Rate", 0)
    or ifnull("Customer Order"."Extended Price", 0) != ifnull(bucket."Extended Price", 0)
    or ifnull("Customer Order"."Incoterms", '') != ifnull(bucket."Incoterms", '')
    or ifnull("Customer Order"."Language", '') != ifnull(bucket."Language", '')
    or ifnull("Customer Order"."Last Shipped Date", '1970-01-01') != ifnull(bucket."Last Shipped Date", '1970-01-01')
    or ifnull("Customer Order"."Order Date", '1970-01-01') != ifnull(bucket."Order Date", '1970-01-01')
    or ifnull("Customer Order"."Quantity Cancelled", 0) != ifnull(bucket."Quantity Cancelled", 0)
    or ifnull("Customer Order"."Quantity Ordered", 0) != ifnull(bucket."Quantity Ordered", 0)
    or ifnull("Customer Order"."Quantity Shipped", 0) != ifnull(bucket."Quantity Shipped", 0)
    or ifnull("Customer Order"."Quote Line", 0) != ifnull(bucket."Quote Line", 0)
    or ifnull("Customer Order"."Quote Number", 0) != ifnull(bucket."Quote Number", 0)
    or ifnull("Customer Order"."Reference Number", 0) != ifnull(bucket."Reference Number", 0)
    or ifnull("Customer Order"."Salesperson", '') != ifnull(bucket."Salesperson", '')
    or ifnull("Customer Order"."Ship To Number", -1) != ifnull(bucket."Ship To Number", -1)
    or ifnull("Customer Order"."SKU", '') != ifnull(bucket."SKU", '')
    or ifnull("Customer Order"."Status", '') != ifnull(bucket."Status", '')
) then update set
      "Customer Order"."Business Unit" = bucket."Business Unit"
    , "Customer Order"."Carrier" = bucket."Carrier"
    , "Customer Order"."Credit Terms" = bucket."Credit Terms"
    , "Customer Order"."Currency" = bucket."Currency"
    , "Customer Order"."Customer Number" = bucket."Customer Number"
    , "Customer Order"."Customer PO" = bucket."Customer PO"
    , "Customer Order"."Customer SKU" = bucket."Customer SKU"
    , "Customer Order"."Due Date" = bucket."Due Date"
    , "Customer Order"."Effective Date" = bucket."Effective Date"
    , "Customer Order"."Entered By" = bucket."Entered By"
    , "Customer Order"."Euro Exchange Rate" = bucket."Euro Exchange Rate"
    , "Customer Order"."Extended Price" = bucket."Extended Price"
    , "Customer Order"."Incoterms" = bucket."Incoterms"
    , "Customer Order"."Language" = bucket."Language"
    , "Customer Order"."Last Shipped Date" = bucket."Last Shipped Date"
    , "Customer Order"."Order Date" = bucket."Order Date"
    , "Customer Order"."Quantity Cancelled" = bucket."Quantity Cancelled"
    , "Customer Order"."Quantity Ordered" = bucket."Quantity Ordered"
    , "Customer Order"."Quantity Shipped" = bucket."Quantity Shipped"
    , "Customer Order"."Quote Line" = bucket."Quote Line"
    , "Customer Order"."Quote Number" = bucket."Quote Number"
    , "Customer Order"."Reference Number" = bucket."Reference Number"
    , "Customer Order"."Salesperson" = bucket."Salesperson"
    , "Customer Order"."Ship To Number" = bucket."Ship To Number"
    , "Customer Order"."SKU" = bucket."SKU"
    , "Customer Order"."Status" = bucket."Status"
    , "Customer Order"."Unit Price" = bucket."Unit Price"
when not matched then insert (
    "Business Unit"
    , "Carrier"
    , "Create Date"
    , "Credit Terms"
    , "Currency"
    , "Customer Number"
    , "Customer PO"
    , "Customer SKU"
    , "Due Date"
    , "Effective Date"
    , "Entered By"
    , "Euro Exchange Rate"
    , "Extended Price"
    , "Incoterms"
    , "Language"
    , "Last Shipped Date"
    , "Line Number"
    , "Order Date"
    , "Order Number"
    , "Quantity Cancelled"
    , "Quantity Ordered"
    , "Quantity Shipped"
    , "Quote Line"
    , "Quote Number"
    , "Reference Number"
    , "Salesperson"
    , "Ship To Number"
    , "SKU"
    , "Status"
    , "Unit Price"
) values (
      bucket."Business Unit"
    , bucket."Carrier"
    , bucket."Create Date"
    , bucket."Credit Terms"
    , bucket."Currency"
    , bucket."Customer Number"
    , bucket."Customer PO"
    , bucket."Customer SKU"
    , bucket."Due Date"
    , bucket."Create Date"
    , bucket."Entered By"
    , bucket."Euro Exchange Rate"
    , bucket."Extended Price"
    , bucket."Incoterms"
    , bucket."Language"
    , bucket."Last Shipped Date"
    , bucket."Line Number"
    , bucket."Order Date"
    , bucket."Order Number"
    , bucket."Quantity Cancelled"
    , bucket."Quantity Ordered"
    , bucket."Quantity Shipped"
    , bucket."Quote Line"
    , bucket."Quote Number"
    , bucket."Reference Number"
    , bucket."Salesperson"
    , bucket."Ship To Number"
    , bucket."SKU"
    , bucket."Status"
    , bucket."Unit Price"
);