merge into production.star."General Ledger" using (
    select stg.$4::number(38, 0) as "Account"
        , coalesce( -- Get the first non-null value in the following order
          -- Get value from invoice line
            iff(stg.$7::boolean = false, -inv_line."Extended Price", inv_line."Extended Price")
          -- Get value from FB_KalkBuch.Betrag
          , stg.$12
          -- Get value from FB_Buchung.Betrag
          , iff(stg.$7::boolean = false, -stg.$5, stg.$5)
        ) as "Amount"
        , 'Esser' as "Business Unit"
        , false as "Closing Entry Flag"
        , stg.$11::number(38, 0) as "Cost Center"
        , cur."Name" as "Currency"
        , inv_hdr."Invoice Number" as "Customer Invoice"
        , inv_line."Key" as "Customer Invoice Key"
        , ifnull(inv_line."Line Number", stg.$13) as "Customer Invoice Line"
        , cust."Key" as "Customer Key"
        , inv_hdr."Customer Number" as "Customer Number"
        , inv_line."Order Number" as "Customer Order"
        , inv_line."Order Line" as "Customer Order Line"
        , case -- The posting date and document date may not agree with the accounting period
            when year(stg.$19::date) = stg.$8 and month(stg.$19::date) = stg.$9 then stg.$19
            when year(stg.$2::date) = stg.$8 and month(stg.$2::date) = stg.$9 then stg.$2
            else last_day(date_from_parts(stg.$8, stg.$9, 1))
        end as "Effective Date"
        , null as "Entry ID"
        , prd."Key" as "Product Key"
        , shp."Key" as "Ship To Key"
        , inv_line."Ship To Number" as "Ship To Number"
        , ifnull(inv_line."SKU", po_line."SKU") as "SKU"
        , stg.$1::number(38, 0) as "Transaction Number"
        , vend."Key" as "Vendor Key"
        , po_hdr."Vendor Number" as "Vendor Number"
    from <<FILENAME>> as stg
        left join helper.iso."Currency" as cur
            on cur."Alphabetic Code" = 'EUR'
        left join (
            select distinct "Customer Number", "Invoice Number"
            from production.star."Customer Invoice"
        ) as inv_hdr
            on stg.$3 = inv_hdr."Invoice Number"
            and stg.$4 like '8___'
        left join production.star."Customer History" as cust
            on inv_hdr."Customer Number" = cust."Customer Number"
            and stg.$2 >= cust."Effective Date"
            and stg.$2 < ifnull(cust."Expiration Date", current_date)
        left join (
            select distinct "Vendor Number", "Order Number", "Reference Number"
            from production.star."Purchase Order"
        ) as po_hdr
            on stg.$16 = po_hdr."Reference Number"
        left join production.star."Purchase Order" as po_line
            on stg.$16 = po_line."Order Number"
            and stg.$17 = po_line."Line Number"
        left join production.star."Vendor History" as vend
            on po_hdr."Vendor Number" = vend."Vendor Number"
            and stg.$2 >= vend."Effective Date"
            and stg.$2 < ifnull(vend."Expiration Date", current_date)
        left join production.star."Customer Invoice" as inv_line
            on inv_hdr."Invoice Number" = inv_line."Invoice Number"
            and stg.$13 is null
        left join production.star."Product History" as prd
            on ifnull(inv_line."SKU", po_line."SKU") = prd."SKU"
            and stg.$2 >= prd."Effective Date"
            and stg.$2 < ifnull(prd."Expiration Date", current_date)
        left join production.star."Ship To History" as shp
            on inv_line."Customer Number" = shp."Customer Number"
            and inv_line."Ship To Number" = shp."Ship To Number"
            and stg.$2 >= shp."Effective Date"
            and stg.$2 < ifnull(shp."Expiration Date", current_date)
) as bucket
    on production.star."General Ledger"."Transaction Number" = bucket."Transaction Number"
    and production.star."General Ledger"."Account" = bucket."Account"
    and ifnull(production.star."General Ledger"."Cost Center", 0) = ifnull(bucket."Cost Center", 0)
when not matched then insert (
      "Account"
    , "Amount"
    , "Business Unit"
    , "Closing Entry Flag"
    , "Cost Center"
    , "Currency"
    , "Customer Invoice"
    , "Customer Invoice Key"
    , "Customer Invoice Line"
    , "Customer Key"
    , "Customer Number"
    , "Customer Order"
    , "Customer Order Line"
    , "Effective Date"
    , "Entry ID"
    , "Key"
    , "Product Key"
    , "Ship To Key"
    , "Ship To Number"
    , "SKU"
    , "Transaction Number"
    , "Vendor Key"
    , "Vendor Number"
) values (
      bucket."Account"
    , bucket."Amount"
    , bucket."Business Unit"
    , bucket."Closing Entry Flag"
    , bucket."Cost Center"
    , bucket."Currency"
    , bucket."Customer Invoice"
    , bucket."Customer Invoice Key"
    , bucket."Customer Invoice Line"
    , bucket."Customer Key"
    , bucket."Customer Number"
    , bucket."Customer Order"
    , bucket."Customer Order Line"
    , bucket."Effective Date"
    , bucket."Entry ID"
    , production.star."General Ledger Key".nextval
    , bucket."Product Key"
    , bucket."Ship To Key"
    , bucket."Ship To Number"
    , bucket."SKU"
    , bucket."Transaction Number"
    , bucket."Vendor Key"
    , bucket."Vendor Number"
);