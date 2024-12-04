merge into production.star."Customer Quote" using (
    select target."Quote Number"
        , target."Line Number"
    from production.star."Customer Quote" as target
        left join <<FILENAME>> as source
            on target."Quote Number" = source.$19
            and target."Line Number" = source.$3
    where source.$3 is null
) as bucket
    on production.star."Customer Quote"."Quote Number" = bucket."Quote Number"
    and production.star."Customer Quote"."Line Number" = bucket."Line Number"
when matched then delete
;