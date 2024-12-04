insert into production.star."Customer Order History" (
      "Business Unit"
    , "Carrier"
    , "Create Date"
    , "Credit Terms"
    , "Currency"
    , "Customer Key"
    , "Customer Number"
    , "Customer PO"
    , "Customer SKU"
    , "Due Date"
    , "Effective Date"
    , "Entered By"
    , "Euro Exchange Rate"
    , "Extended Price"
    , "Incoterms"
    , "Key"
    , "Language"
    , "Last Shipped Date"
    , "Line Number"
    , "Order Date"
    , "Order Number"
    , "Product Key"
    , "Quantity Cancelled"
    , "Quantity Ordered"
    , "Quantity Shipped"
    , "Quote Line"
    , "Quote Number"
    , "Reference Number"
    , "Salesperson"
    , "Ship To Key"
    , "Ship To Number"
    , "SKU"
    , "Status"
    , "Unit Price"
)
select
      cdc."Business Unit"
    , cdc."Carrier"
    , cdc."Create Date"
    , cdc."Credit Terms"
    , cdc."Currency"
    , c."Key"
    , cdc."Customer Number"
    , cdc."Customer PO"
    , cdc."Customer SKU"
    , cdc."Due Date"
    , case
        when cdc.metadata$action = 'DELETE'
            and cdc.metadata$isupdate = true then ii."Effective Date"
        when cdc.metadata$action = 'DELETE'
            and cdc.metadata$isupdate = false then current_timestamp
        else cdc."Effective Date" end
    , cdc."Entered By"
    , cdc."Euro Exchange Rate"
    , case
        when cdc.metadata$action = 'DELETE' then -cdc."Extended Price"
        else cdc."Extended Price" end
    , cdc."Incoterms"
    , production.star."Customer Order Key".nextval
    , cdc."Language"
    , cdc."Last Shipped Date"
    , cdc."Line Number"
    , cdc."Order Date"
    , cdc."Order Number"
    , p."Key"
    , case
        when cdc.metadata$action = 'DELETE' then -cdc."Quantity Cancelled"
        else cdc."Quantity Cancelled" end
    , case
        when cdc.metadata$action = 'DELETE' then -cdc."Quantity Ordered"
        else cdc."Quantity Ordered" end
    , case
        when cdc.metadata$action = 'DELETE' then -cdc."Quantity Shipped"
        else cdc."Quantity Shipped" end
    , cdc."Quote Line"
    , cdc."Quote Number"
    , cdc."Reference Number"
    , cdc."Salesperson"
    , s."Key"
    , cdc."Ship To Number"
    , cdc."SKU"
    , cdc."Status"
    , cdc."Unit Price"
from
    production.star."Customer Order CDC" as cdc
    left join (
        select metadata$row_id, "Effective Date"
        from production.star."Customer Order CDC"
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