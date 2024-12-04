merge into production.helper."Currency Exchange Rates" using (
    select target."From Currency"
        , target."To Currency"
        , target."Effective Date"
    from production.helper."Currency Exchange Rates" as target
        left join <<FILENAME>> as source
            on target."From Currency" = source.$1
            and target."To Currency" = source.$2
            and target."Effective Date" = source.$3
    where source.$3 is null
) as bucket
    on production.helper."Currency Exchange Rates"."From Currency" = bucket."From Currency"
    and production.helper."Currency Exchange Rates"."To Currency" = bucket."To Currency"
    and production.helper."Currency Exchange Rates"."Effective Date" = bucket."Effective Date"
when matched then delete
;