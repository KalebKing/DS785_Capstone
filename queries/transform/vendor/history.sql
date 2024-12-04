merge into production.star."Vendor History" as h using (
    select cdc.*
        , case
            when cdc.metadata$action = 'INSERT'
                then null
            when cdc.metadata$action = 'DELETE'
                and cdc.metadata$isupdate = false
                then current_timestamp()
            else u."Effective Date"
            end as "Expiration Date"
    from production.star."Vendor CDC" as cdc
        left join (
            select metadata$row_id
                , "Effective Date"
            from production.star."Vendor CDC"
            where metadata$action = 'INSERT'
                and metadata$isupdate = true
        ) as u on cdc.metadata$row_id = u.metadata$row_id
) as c on h."Key" = c."Key"
    when matched then update set
        "Expiration Date" = c."Expiration Date",
        "Current Record" = false
    when not matched then insert (
        "Address Line 1",
        "Address Line 2",
        "Address Line 3",
        "Address Line 4",
        "Business Unit",
        "City",
        "Country (English)",
        "Country (German)",
        "Create Date",
        "Credit Terms (English)",
        "Credit Terms (German)",
        "Currency",
        "Current Record",
        "Effective Date",
        "Expiration Date",
        "Fax Number",
        "Key",
        "Language",
        "Latitude",
        "Longitude",
        "Name",
        "Phone Number",
        "Postal Code",
        "State/Province",
        "Status",
        "Tax ID",
        "Tax ID Type",
        "Type",
        "Vendor Number"
    ) values (
        c."Address Line 1",
        c."Address Line 2",
        c."Address Line 3",
        c."Address Line 4",
        c."Business Unit",
        c."City",
        c."Country (English)",
        c."Country (German)",
        c."Create Date",
        c."Credit Terms (English)",
        c."Credit Terms (German)",
        c."Currency",
        true,
        c."Effective Date",
        null,
        c."Fax Number",
        c."Key",
        c."Language",
        c."Latitude",
        c."Longitude",
        c."Name",
        c."Phone Number",
        c."Postal Code",
        c."State/Province",
        c."Status",
        c."Tax ID",
        c."Tax ID Type",
        c."Type",
        c."Vendor Number"
    )
;