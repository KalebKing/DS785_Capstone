merge into production.star."Purchase Order" using (
    select target."Order Number"
        , target."Line Number"
    from production.star."Purchase Order" as target
        left join <<FILENAME>> as source
            on target."Order Number" = source.$13
            and target."Line Number" = source.$3
    where source.$3 is null
) as bucket
    on production.star."Purchase Order"."Order Number" = bucket."Order Number"
    and production.star."Purchase Order"."Line Number" = bucket."Line Number"
when matched then delete
;