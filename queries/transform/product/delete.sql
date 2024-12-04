merge into production.star."Product" using (
    select target."SKU"
    from production.star."Product" as target
        left join <<FILENAME>> as source
            on target."SKU" = source.$3
    where source.$3 is null
) as bucket on production.star."Product"."SKU" = bucket."SKU"
when matched then delete
;