insert into production.star."Purchase Order History" (
      "Business Unit"
    , "Carrier"
    , "Create Date"
    , "Credit Terms"
    , "Currency"
    , "Due Date"
    , "Effective Date"
    , "Extended Price"
    , "Incoterms"
    , "Key"
    , "Language"
    , "Last Received Date"
    , "Line Number"
    , "Order Date"
    , "Order Number"
    , "Product Key"
    , "Quantity Ordered"
    , "Quantity Received"
    , "Reference Number"
    , "SKU"
    , "Status"
    , "Unit Price"
    , "Vendor Key"
    , "Vendor Number"
)
select
      cdc."Business Unit"
    , cdc."Carrier"
    , cdc."Create Date"
    , cdc."Credit Terms"
    , cdc."Currency"
    , cdc."Due Date"
    , case
        when cdc.metadata$action = 'DELETE'
            and cdc.metadata$isupdate = true then ii."Effective Date"
        when cdc.metadata$action = 'DELETE'
            and cdc.metadata$isupdate = false then current_timestamp
        else cdc."Effective Date" end
    , case
        when cdc.metadata$action = 'DELETE' then -cdc."Extended Price"
        else cdc."Extended Price" end
    , cdc."Incoterms"
    , production.star."Purchase Order Key".nextval
    , cdc."Language"
    , cdc."Last Received Date"
    , cdc."Line Number"
    , cdc."Order Date"
    , cdc."Order Number"
    , p."Key"
    , case
        when cdc.metadata$action = 'DELETE' then -cdc."Quantity Ordered"
        else cdc."Quantity Ordered" end
    , case
        when cdc.metadata$action = 'DELETE' then -cdc."Quantity Received"
        else cdc."Quantity Received" end
    , cdc."Reference Number"
    , cdc."SKU"
    , cdc."Status"
    , cdc."Unit Price"
    , v."Key"
    , cdc."Vendor Number"
from
    production.star."Purchase Order CDC" as cdc
    left join (
        select metadata$row_id, "Effective Date"
        from production.star."Purchase Order CDC"
        where metadata$action = 'INSERT'
            and metadata$isupdate = true
    ) as ii on cdc.metadata$row_id = ii.metadata$row_id
    left join production.star."Vendor History" as v
        on cdc."Vendor Number" = v."Vendor Number"
        and cdc."Effective Date" >= v."Effective Date"
        and cdc."Effective Date" < ifnull(v."Expiration Date", current_timestamp)
    left join production.star."Product History" as p
        on cdc."SKU" = p."SKU"
        and cdc."Effective Date" >= p."Effective Date"
        and cdc."Effective Date" < ifnull(p."Expiration Date", current_timestamp)
;