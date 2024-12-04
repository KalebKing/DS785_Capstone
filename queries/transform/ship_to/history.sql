merge into production.star."Ship To History" as h using (
    select cdc.*
        , case
            when cdc.metadata$action = 'INSERT'
                then null
            when cdc.metadata$action = 'DELETE'
                and cdc.metadata$isupdate = false
                then current_timestamp()
            else u."Effective Date"
            end as "Expiration Date"
    from production.star."Ship To CDC" as cdc
        left join (
            select metadata$row_id
                , "Effective Date"
            from production.star."Ship To CDC"
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
        "Carrier (English)",
        "Carrier (German)",
        "City",
        "Country (English)",
        "Country (German)",
        "Create Date",
        "Currency",
        "Current Record",
        "Customer Number",
        "Effective Date",
        "Expiration Date",
        "Fax Number",
        "Incoterms (English)",
        "Incoterms (German)",
        "Key",
        "Language",
        "Latitude",
        "Longitude",
        "Name",
        "Phone Number",
        "Postal Code",
        "Salesperson",
        "Ship To Number",
        "State/Province",
        "Status",
        "Tax ID",
        "Tax ID Type",
        "Type"
    ) values (
        c."Address Line 1",
        c."Address Line 2",
        c."Address Line 3",
        c."Address Line 4",
        c."Business Unit",
        c."Carrier (English)",
        c."Carrier (German)",
        c."City",
        c."Country (English)",
        c."Country (German)",
        c."Create Date",
        c."Currency",
        true,
        c."Customer Number",
        c."Effective Date",
        null,
        c."Fax Number",
        c."Incoterms (English)",
        c."Incoterms (German)",
        c."Key",
        c."Language",
        c."Latitude",
        c."Longitude",
        c."Name",
        c."Phone Number",
        c."Postal Code",
        c."Salesperson",
        c."Ship To Number",
        c."State/Province",
        c."Status",
        c."Tax ID",
        c."Tax ID Type",
        c."Type"
);