merge into production.star."Customer Quote" using (
    select stg.$5::boolean as "Alternate Line Flag"
        , 'Esser' as "Business Unit"
        , stg.$28 as "Carrier"
        , to_timestamp_ntz(stg.$15 || ' ' || stg.$16) as "Create Date"
        , stg.$34 as "Credit Terms"
        , cu."Name" as "Currency"
        , stg.$23 as "Customer Number"
        , nullif(split_part(stg.$8, ';', 1), '') as "Customer SKU"
        , greatest(
            to_timestamp_ntz(coalesce(stg.$1 || ' ' || stg.$2, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$17 || ' ' || stg.$18, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$26 || ' ' || stg.$27, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$29 || ' ' || stg.$30, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$32 || ' ' || stg.$33, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$35 || ' ' || stg.$36, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$38 || ' ' || stg.$39, '1970-01-01 00:00:00.000'))
            , to_timestamp_ntz(coalesce(stg.$40 || ' ' || stg.$41, '1970-01-01 00:00:00.000'))
        ) as "Effective Date"
        , stg.$45 as "Entered By"
        , stg.$22 as "Expiration Date"
        , ifnull(split_part(c."DecWert", ';', 1), stg.$10) * stg.$9 as "Extended Cost"
        , ifnull(split_part(fc."DecWert", ';', 1), 0) * stg.$9 as "Extended Fixed Overhead Cost"
        , ifnull(split_part(lc."DecWert", ';', 1), 0) * stg.$9 as "Extended Labor Cost"
        , ifnull(split_part(mc."DecWert", ';', 1), stg.$10) * stg.$9 as "Extended Material Cost"
        , stg.$12::number(38, 2) * iff(stg.$11::boolean = true, stg.$14 * stg.$13, 1) * stg.$24::number(38, 10) as "Extended Price"
        , ifnull(split_part(vc."DecWert", ';', 1), 0) * stg.$9 as "Extended Variable Overhead Cost"
        , initcap(stg.$31) as "Incoterms"
        , ifnull(l."Name", stg.$20) as "Language"
        , stg.$3 as "Line Number"
        , stg.$9 as "Quantity"
        , stg.$46 as "Quote Date"
        , stg.$19 as "Quote Number"
        , stg.$44 as "Reference Number"
        , nullif(trim(concat_ws(' ', ifnull(stg.$42, ''), ifnull(stg.$43, '')), ' '), '') as "Salesperson"
        , stg.$25::number(38, 0)::varchar(10) as "Ship To Number"
        , stg.$6 as "SKU"
        , case
            when stg.$4::boolean = true then 'Active'
            else 'Inactive' end as "Status"
        , ifnull(split_part(c."DecWert", ';', 1), stg.$10) as "Unit Cost"
        , ifnull(split_part(fc."DecWert", ';', 1), 0) as "Unit Fixed Overhead Cost"
        , ifnull(split_part(lc."DecWert", ';', 1), 0) as "Unit Labor Cost"
        , ifnull(split_part(mc."DecWert", ';', 1), stg.$10) as "Unit Material Cost"
        , stg.$12::number(38, 2) * iff(stg.$11::boolean = true, stg.$14 * stg.$13, 1) * stg.$24::number(38, 10) / iff(stg.$9 = 0, 1, stg.$9) as "Unit Price"
        , ifnull(split_part(vc."DecWert", ';', 1), 0) as "Unit Variable Overhead Cost"
    from <<FILENAME>> as stg
        left join helper.iso."Currency" as cu
            on cu."Alphabetic Code" = 'EUR'
        left join helper.iso."Language" as l
            on case
                when stg.$20 = 'D' then 'DE'
                when stg.$20 = 'E' then 'EN'
                else null
            end = l."Alpha-2 Code"
        left join (
            select
                "WertKopf"
                , "Schluessel"
                , "KalkVariante"
                , "BezugsDatum"
                , lead("BezugsDatum") over (partition by "Schluessel" order by "BezugsDatum") as "BezugsDatum2"
            from
                production.helper."SA_WertKopf"
            where
                "Belegart" = 'P_S'
                and "VorKalk" = 1
        ) as "SA_WertKopf"
            on upper('SST' || ifnull(stg.$6, '') || ifnull(stg.$7, '')) = upper("SA_WertKopf"."Schluessel")
            and to_date(stg.$21) >= "SA_WertKopf"."BezugsDatum"
            and to_date(stg.$21) < ifnull("SA_WertKopf"."BezugsDatum2", current_timestamp)
        left join production.helper."SA_Wert" as c --unit cost
            on "SA_WertKopf"."WertKopf" = c."WertKopf"
            and c."SpaltenID" = 7
            and c."ZeilenNr" = 2900
        left join production.helper."SA_Wert" as lc --unit labor cost
            on "SA_WertKopf"."WertKopf" = lc."WertKopf"
            and lc."SpaltenID" = 7
            and lc."ZeilenNr" = 1100
        left join production.helper."SA_Wert" as mc --unit material cost
            on "SA_WertKopf"."WertKopf" = mc."WertKopf"
            and mc."SpaltenID" = 7
            and mc."ZeilenNr" = 400
        left join production.helper."SA_Wert" as fc --unit fixed overhead cost
            on "SA_WertKopf"."WertKopf" = fc."WertKopf"
            and fc."SpaltenID" = 8
            and fc."ZeilenNr" = 1900
        left join production.helper."SA_Wert" as vc --unit variable overhead cost
            on "SA_WertKopf"."WertKopf" = vc."WertKopf"
            and vc."SpaltenID" = 9
            and vc."ZeilenNr" = 1900
) as bucket
    on production.star."Customer Quote"."Quote Number" = bucket."Quote Number"
    and production.star."Customer Quote"."Line Number" = bucket."Line Number"
when matched and (
       ifnull("Customer Quote"."Alternate Line Flag", false) != ifnull(bucket."Alternate Line Flag", false)
    or ifnull("Customer Quote"."Business Unit", '') != ifnull(bucket."Business Unit", '')
    or ifnull("Customer Quote"."Carrier", '') != ifnull(bucket."Carrier", '')
    or ifnull("Customer Quote"."Credit Terms", '') != ifnull(bucket."Credit Terms", '')
    or ifnull("Customer Quote"."Currency", '') != ifnull(bucket."Currency", '')
    or ifnull("Customer Quote"."Customer Number", -1) != ifnull(bucket."Customer Number", -1)
    or ifnull("Customer Quote"."Customer SKU", '') != ifnull(bucket."Customer SKU", '')
    or ifnull("Customer Quote"."Entered By", '') != ifnull(bucket."Entered By", '')
    or ifnull("Customer Quote"."Expiration Date", '1970-01-01') != ifnull(bucket."Expiration Date", '1970-01-01')
    or ifnull("Customer Quote"."Extended Cost", 0) != ifnull(bucket."Extended Cost", 0)
    or ifnull("Customer Quote"."Extended Fixed Overhead Cost", 0) != ifnull(bucket."Extended Fixed Overhead Cost", 0)
    or ifnull("Customer Quote"."Extended Labor Cost", 0) != ifnull(bucket."Extended Labor Cost", 0)
    or ifnull("Customer Quote"."Extended Material Cost", 0) != ifnull(bucket."Extended Material Cost", 0)
    or ifnull("Customer Quote"."Extended Price", 0) != ifnull(bucket."Extended Price", 0)
    or ifnull("Customer Quote"."Extended Variable Overhead Cost", 0) != ifnull(bucket."Extended Variable Overhead Cost", 0)
    or ifnull("Customer Quote"."Incoterms", '') != ifnull(bucket."Incoterms", '')
    or ifnull("Customer Quote"."Language", '') != ifnull(bucket."Language", '')
    or ifnull("Customer Quote"."Quantity", 0) != ifnull(bucket."Quantity", 0)
    or ifnull("Customer Quote"."Quote Date", '1970-01-01') != ifnull(bucket."Quote Date", '1970-01-01')
    or ifnull("Customer Quote"."Reference Number", 0) != ifnull(bucket."Reference Number", 0)
    or ifnull("Customer Quote"."Salesperson", '') != ifnull(bucket."Salesperson", '')
    or ifnull("Customer Quote"."Ship To Number", -1) != ifnull(bucket."Ship To Number", -1)
    or ifnull("Customer Quote"."SKU", '') != ifnull(bucket."SKU", '')
    or ifnull("Customer Quote"."Status", '') != ifnull(bucket."Status", '')
    or ifnull("Customer Quote"."Unit Cost", 0) != ifnull(bucket."Unit Cost", 0)
    or ifnull("Customer Quote"."Unit Fixed Overhead Cost", 0) != ifnull(bucket."Unit Fixed Overhead Cost", 0)
    or ifnull("Customer Quote"."Unit Labor Cost", 0) != ifnull(bucket."Unit Labor Cost", 0)
    or ifnull("Customer Quote"."Unit Material Cost", 0) != ifnull(bucket."Unit Material Cost", 0)
    or ifnull("Customer Quote"."Unit Price", 0) != ifnull(bucket."Unit Price", 0)
    or ifnull("Customer Quote"."Unit Variable Overhead Cost", 0) != ifnull(bucket."Unit Variable Overhead Cost", 0)
) then update set
      "Customer Quote"."Alternate Line Flag" = bucket."Alternate Line Flag"
    , "Customer Quote"."Business Unit" = bucket."Business Unit"
    , "Customer Quote"."Carrier" = bucket."Carrier"
    , "Customer Quote"."Credit Terms" = bucket."Credit Terms"
    , "Customer Quote"."Currency" = bucket."Currency"
    , "Customer Quote"."Customer Number" = bucket."Customer Number"
    , "Customer Quote"."Customer SKU" = bucket."Customer SKU"
    , "Customer Quote"."Effective Date" = bucket."Effective Date"
    , "Customer Quote"."Entered By" = bucket."Entered By"
    , "Customer Quote"."Expiration Date" = bucket."Expiration Date"
    , "Customer Quote"."Extended Cost" = bucket."Extended Cost"
    , "Customer Quote"."Extended Fixed Overhead Cost" = bucket."Extended Fixed Overhead Cost"
    , "Customer Quote"."Extended Labor Cost" = bucket."Extended Labor Cost"
    , "Customer Quote"."Extended Material Cost" = bucket."Extended Material Cost"
    , "Customer Quote"."Extended Price" = bucket."Extended Price"
    , "Customer Quote"."Extended Variable Overhead Cost" = bucket."Extended Variable Overhead Cost"
    , "Customer Quote"."Incoterms" = bucket."Incoterms"
    , "Customer Quote"."Language" = bucket."Language"
    , "Customer Quote"."Quantity" = bucket."Quantity"
    , "Customer Quote"."Quote Date" = bucket."Quote Date"
    , "Customer Quote"."Reference Number" = bucket."Reference Number"
    , "Customer Quote"."Salesperson" = bucket."Salesperson"
    , "Customer Quote"."Ship To Number" = bucket."Ship To Number"
    , "Customer Quote"."SKU" = bucket."SKU"
    , "Customer Quote"."Status" = bucket."Status"
    , "Customer Quote"."Unit Cost" = bucket."Unit Cost"
    , "Customer Quote"."Unit Fixed Overhead Cost" = bucket."Unit Fixed Overhead Cost"
    , "Customer Quote"."Unit Labor Cost" = bucket."Unit Labor Cost"
    , "Customer Quote"."Unit Material Cost" = bucket."Unit Material Cost"
    , "Customer Quote"."Unit Price" = bucket."Unit Price"
    , "Customer Quote"."Unit Variable Overhead Cost" = bucket."Unit Variable Overhead Cost"
when not matched then insert (
      "Alternate Line Flag"
    , "Business Unit"
    , "Carrier"
    , "Create Date"
    , "Credit Terms"
    , "Currency"
    , "Customer Number"
    , "Customer SKU"
    , "Effective Date"
    , "Entered By"
    , "Expiration Date"
    , "Extended Cost"
    , "Extended Fixed Overhead Cost"
    , "Extended Labor Cost"
    , "Extended Material Cost"
    , "Extended Price"
    , "Extended Variable Overhead Cost"
    , "Incoterms"
    , "Language"
    , "Line Number"
    , "Quantity"
    , "Quote Date"
    , "Quote Number"
    , "Reference Number"
    , "Salesperson"
    , "Ship To Number"
    , "SKU"
    , "Status"
    , "Unit Cost"
    , "Unit Fixed Overhead Cost"
    , "Unit Labor Cost"
    , "Unit Material Cost"
    , "Unit Price"
    , "Unit Variable Overhead Cost"
) values (
      bucket."Alternate Line Flag"
    , bucket."Business Unit"
    , bucket."Carrier"
    , bucket."Create Date"
    , bucket."Credit Terms"
    , bucket."Currency"
    , bucket."Customer Number"
    , bucket."Customer SKU"
    , bucket."Create Date"
    , bucket."Entered By"
    , bucket."Expiration Date"
    , bucket."Extended Cost"
    , bucket."Extended Fixed Overhead Cost"
    , bucket."Extended Labor Cost"
    , bucket."Extended Material Cost"
    , bucket."Extended Price"
    , bucket."Extended Variable Overhead Cost"
    , bucket."Incoterms"
    , bucket."Language"
    , bucket."Line Number"
    , bucket."Quantity"
    , bucket."Quote Date"
    , bucket."Quote Number"
    , bucket."Reference Number"
    , bucket."Salesperson"
    , bucket."Ship To Number"
    , bucket."SKU"
    , bucket."Status"
    , bucket."Unit Cost"
    , bucket."Unit Fixed Overhead Cost"
    , bucket."Unit Labor Cost"
    , bucket."Unit Material Cost"
    , bucket."Unit Price"
    , bucket."Unit Variable Overhead Cost"
);