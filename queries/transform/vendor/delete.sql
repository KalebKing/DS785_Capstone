merge into production.star."Vendor" using (
    select target."Vendor Number"
    from production.star."Vendor" as target
        left join <<FILENAME>> as source
            on target."Vendor Number" = source.$5
    where source.$5 is null
) as bucket on production.star."Vendor"."Vendor Number" = bucket."Vendor Number"
when matched then delete
;