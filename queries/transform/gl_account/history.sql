merge into production.star."GL Account History" as h using (
    select cdc.*
        , case
            when cdc.metadata$action = 'INSERT'
                then null
            when cdc.metadata$action = 'DELETE'
                and cdc.metadata$isupdate = false
                then current_timestamp()
            else u."Effective Date"
            end as "Expiration Date"
    from production.star."GL Account CDC" as cdc
        left join (
            select metadata$row_id
                , "Effective Date"
            from production.star."GL Account CDC"
            where metadata$action = 'INSERT'
                and metadata$isupdate = true
        ) as u on cdc.metadata$row_id = u.metadata$row_id
) as c on h."Key" = c."Key"
    when matched then update set
        "Expiration Date" = c."Expiration Date",
        "Current Record" = false
    when not matched then insert (
        "Account",
        "Business Unit",
        "Create Date",
        "Currency",
        "Current Record",
        "Effective Date",
        "Expiration Date",
        "Key",
        "Name (English)",
        "Name (German)",
        "Type"
    ) values (
        c."Account",
        c."Business Unit",
        c."Create Date",
        c."Currency",
        true,
        c."Effective Date",
        null,
        c."Key",
        c."Name (English)",
        c."Name (German)",
        c."Type"
    )
;