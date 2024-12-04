merge into production.star."Customer Invoice" using (
    select target."Invoice Number"
        , target."Line Number"
        , target."Line Sequence"
    from production.star."Customer Invoice" as target
        left join <<FILENAME>> as source
            on target."Invoice Number" = source.$19
            and target."Line Number" = source.$4
            and target."Line Sequence" = source.$50
    where source.$4 is null
) as bucket
    on production.star."Customer Invoice"."Invoice Number" = bucket."Invoice Number"
    and production.star."Customer Invoice"."Line Number" = bucket."Line Number"
    and production.star."Customer Invoice"."Line Sequence" = bucket."Line Sequence"
when matched then delete
;