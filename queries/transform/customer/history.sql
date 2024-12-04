merge into production.star."Customer History" as h using (
    select cdc.*
        , case
            when cdc.metadata$action = 'INSERT'
                then null
            when cdc.metadata$action = 'DELETE'
                and cdc.metadata$isupdate = false
                then current_timestamp()
            else u."Effective Date"
            end as "Expiration Date"
    from production.star."Customer CDC" as cdc
        left join (
            select metadata$row_id
                , "Effective Date"
            from production.star."Customer CDC"
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
        "Annual Revenue",
        "Bauart 1",
        "Bauart 2",
        "Bauart 3",
        "Bauart 4",
        "Business Unit",
        "City",
        "Country (English)",
        "Country (German)",
        "Create Date",
        "Credit Limit",
        "Credit Terms (English)",
        "Credit Terms (German)",
        "Currency",
        "Current Record",
        "Customer Number",
        "Effective Date",
        "Expiration Date",
        "Fax Number",
        "Industry (English)",
        "Industry (German)",
        "Key",
        "Language",
        "Latitude",
        "Longitude",
        "Name",
        "Number of Employees",
        "Parent Account",
        "Phone Number",
        "Postal Code",
        "Salesperson",
        "SIC Code",
        "Service Level",
        "State/Province",
        "Status",
        "Tax ID",
        "Tax ID Type",
        "Type",
        "Website"
    ) values (
        c."Address Line 1",
        c."Address Line 2",
        c."Address Line 3",
        c."Address Line 4",
        c."Annual Revenue",
        c."Bauart 1",
        c."Bauart 2",
        c."Bauart 3",
        c."Bauart 4",
        c."Business Unit",
        c."City",
        c."Country (English)",
        c."Country (German)",
        c."Create Date",
        c."Credit Limit",
        c."Credit Terms (English)",
        c."Credit Terms (German)",
        c."Currency",
        true,
        c."Customer Number",
        c."Effective Date",
        null,
        c."Fax Number",
        c."Industry (English)",
        c."Industry (German)",
        c."Key",
        c."Language",
        c."Latitude",
        c."Longitude",
        c."Name",
        c."Number of Employees",
        c."Parent Account",
        c."Phone Number",
        c."Postal Code",
        c."Salesperson",
        c."SIC Code",
        c."Service Level",
        c."State/Province",
        c."Status",
        c."Tax ID",
        c."Tax ID Type",
        c."Type",
        c."Website"
);