merge into production.star."GL Account" using (
    select target."Account"
    from production.star."GL Account" as target
        left join <<FILENAME>> as source
            on target."Account" = source.$3
    where source.$3 is null
) as bucket on production.star."GL Account"."Account" = bucket."Account"
when matched then delete
;