merge into production.star."Product History" as h using (
    select cdc.*
        , case
            when cdc.metadata$action = 'INSERT'
                then null
            when cdc.metadata$action = 'DELETE'
                and cdc.metadata$isupdate = false
                then current_timestamp()
            else u."Effective Date"
            end as "Expiration Date"
    from production.star."Product CDC" as cdc
        left join (
            select metadata$row_id
                , "Effective Date"
            from production.star."Product CDC"
            where metadata$action = 'INSERT'
                and metadata$isupdate = true
        ) as u on cdc.metadata$row_id = u.metadata$row_id
) as c on h."Key" = c."Key"
    when matched then update set
        "Expiration Date" = c."Expiration Date",
        "Current Record" = false
    when not matched then insert (
        "ABC Code"
        , "Bauart 1"
        , "Bauart 2"
        , "Bauart 3"
        , "Bauart 4"
        , "Business Unit"
        , "Country of Origin (English)"
        , "Country of Origin (German)"
        , "Create Date"
        , "Current Record"
        , "Description (English)"
        , "Description (German)"
        , "Effective Date"
        , "Expiration Date"
        , "Family"
        , "Height"
        , "Height Unit of Measure (English)"
        , "Height Unit of Measure (German)"
        , "HS Code"
        , "Inventory Type"
        , "Key"
        , "Length"
        , "Length Unit of Measure (English)"
        , "Length Unit of Measure (German)"
        , "Line"
        , "SKU"
        , "Source"
        , "Status"
        , "Stocked Flag"
        , "Type"
        , "Unit of Measure (English)"
        , "Unit of Measure (German)"
        , "Vendor"
        , "Weight"
        , "Weight Unit of Measure (English)"
        , "Weight Unit of Measure (German)"
        , "Width"
        , "Width Unit of Measure (English)"
        , "Width Unit of Measure (German)"
    ) values (
        c."ABC Code"
        , c."Bauart 1"
        , c."Bauart 2"
        , c."Bauart 3"
        , c."Bauart 4"
        , c."Business Unit"
        , c."Country of Origin (English)"
        , c."Country of Origin (German)"
        , c."Create Date"
        , true
        , c."Description (English)"
        , c."Description (German)"
        , c."Effective Date"
        , null
        , c."Family"
        , c."Height"
        , c."Height Unit of Measure (English)"
        , c."Height Unit of Measure (German)"
        , c."HS Code"
        , c."Inventory Type"
        , c."Key"
        , c."Length"
        , c."Length Unit of Measure (English)"
        , c."Length Unit of Measure (German)"
        , c."Line"
        , c."SKU"
        , c."Source"
        , c."Status"
        , c."Stocked Flag"
        , c."Type"
        , c."Unit of Measure (English)"
        , c."Unit of Measure (German)"
        , c."Vendor"
        , c."Weight"
        , c."Weight Unit of Measure (English)"
        , c."Weight Unit of Measure (German)"
        , c."Width"
        , c."Width Unit of Measure (English)"
        , c."Width Unit of Measure (German)"
    )