merge into production.star."Ship To" using (
    select target."Customer Number"
        , target."Ship To Number"
    from production.star."Ship To" as target
        left join <<FILENAME>> as source
            on target."Customer Number" = source.$1
            and target."Ship To Number" = source.$2
    where source.$2 is null
) as bucket on production.star."Ship To"."Customer Number" = bucket."Customer Number"
    and production.star."Ship To"."Ship To Number" = bucket."Ship To Number"
when matched then delete
;