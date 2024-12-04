merge into production.star."Customer" using (
    select target."Customer Number"
    from production.star."Customer" as target
        left join <<FILENAME>> as source
            on target."Customer Number" = source.$5
    where source.$5 is null
) as bucket on production.star."Customer"."Customer Number" = bucket."Customer Number"
when matched then delete
;