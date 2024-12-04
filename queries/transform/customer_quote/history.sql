insert into production.star."Customer Quote History" (
    "Alternate Line Flag"
    , "Business Unit"
    , "Carrier"
    , "Create Date"
    , "Credit Terms"
    , "Currency"
    , "Customer Key"
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
    , "Key"
    , "Language"
    , "Line Number"
    , "Product Key"
    , "Quantity"
    , "Quote Date"
    , "Quote Number"
    , "Reference Number"
    , "Salesperson"
    , "Ship To Key"
    , "Ship To Number"
    , "SKU"
    , "Status"
    , "Unit Cost"
    , "Unit Fixed Overhead Cost"
    , "Unit Labor Cost"
    , "Unit Material Cost"
    , "Unit Price"
    , "Unit Variable Overhead Cost"
)
select
    cdc."Alternate Line Flag"
    , cdc."Business Unit"
    , cdc."Carrier"
    , cdc."Create Date"
    , cdc."Credit Terms"
    , cdc."Currency"
    , c."Key"
    , cdc."Customer Number"
    , cdc."Customer SKU"
    , case
        when cdc.metadata$action = 'DELETE'
            and cdc.metadata$isupdate = true then ii."Effective Date"
        when cdc.metadata$action = 'DELETE'
            and cdc.metadata$isupdate = false then current_timestamp
        else cdc."Effective Date" end
    , cdc."Entered By"
    , cdc."Expiration Date"
    , case
        when cdc.metadata$action = 'DELETE' then -cdc."Extended Cost"
        else cdc."Extended Cost" end
    , case
        when cdc.metadata$action = 'DELETE' then -cdc."Extended Fixed Overhead Cost"
        else cdc."Extended Fixed Overhead Cost" end
    , case
        when cdc.metadata$action = 'DELETE' then -cdc."Extended Labor Cost"
        else cdc."Extended Labor Cost" end
    , case
        when cdc.metadata$action = 'DELETE' then -cdc."Extended Material Cost"
        else cdc."Extended Material Cost" end
    , case
        when cdc.metadata$action = 'DELETE' then -cdc."Extended Price"
        else cdc."Extended Price" end
    , case
        when cdc.metadata$action = 'DELETE' then -cdc."Extended Variable Overhead Cost"
        else cdc."Extended Variable Overhead Cost" end
    , cdc."Incoterms"
    , production.star."Customer Quote Key".nextval
    , cdc."Language"
    , cdc."Line Number"
    , p."Key"
    , case
        when cdc.metadata$action = 'DELETE' then -cdc."Quantity"
        else cdc."Quantity" end
    , cdc."Quote Date"
    , cdc."Quote Number"
    , cdc."Reference Number"
    , cdc."Salesperson"
    , s."Key"
    , cdc."Ship To Number"
    , cdc."SKU"
    , cdc."Status"
    , cdc."Unit Cost"
    , cdc."Unit Fixed Overhead Cost"
    , cdc."Unit Labor Cost"
    , cdc."Unit Material Cost"
    , cdc."Unit Price"
    , cdc."Unit Variable Overhead Cost"
from
    production.star."Customer Quote CDC" as cdc
    left join (
        select metadata$row_id, "Effective Date"
        from production.star."Customer Quote CDC"
        where metadata$action = 'INSERT'
            and metadata$isupdate = true
    ) as ii on cdc.metadata$row_id = ii.metadata$row_id
    left join production.star."Customer History" as c
        on cdc."Customer Number" = c."Customer Number"
        and cdc."Effective Date" >= c."Effective Date"
        and cdc."Effective Date" < ifnull(c."Expiration Date", current_timestamp)
    left join production.star."Ship To History" as s
        on cdc."Customer Number" = s."Customer Number"
        and cdc."Ship To Number" = s."Ship To Number"
        and cdc."Effective Date" >= s."Effective Date"
        and cdc."Effective Date" < ifnull(s."Expiration Date", current_timestamp)
    left join production.star."Product History" as p
        on cdc."SKU" = p."SKU"
        and cdc."Effective Date" >= p."Effective Date"
        and cdc."Effective Date" < ifnull(p."Expiration Date", current_timestamp)
;