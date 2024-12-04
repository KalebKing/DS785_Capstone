merge into production.star."Customer Order" using (
    select target."Order Number"
        , target."Line Number"
    from production.star."Customer Order" as target
        left join <<FILENAME>> as source
            on target."Order Number" = source.$24
            and target."Line Number" = source.$3
    where source.$3 is null
) as bucket
    on production.star."Customer Order"."Order Number" = bucket."Order Number"
    and production.star."Customer Order"."Line Number" = bucket."Line Number"
when matched then delete
;