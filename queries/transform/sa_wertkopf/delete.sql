merge into production.helper."SA_WertKopf" using (
    select target."WertKopf"
    from production.helper."SA_WertKopf" as target
        left join <<FILENAME>> as source
            on target."WertKopf" = source.$2
    where source.$2 is null
) as bucket on production.helper."SA_WertKopf"."WertKopf" = bucket."WertKopf"
when matched then delete
;