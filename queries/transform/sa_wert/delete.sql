merge into production.helper."SA_Wert" using (
    select target."WertKopf"
        , target."SpaltenID"
        , target."ZeilenNr"
    from production.helper."SA_Wert" as target
        left join <<FILENAME>> as source
            on target."WertKopf" = source.$2
            and target."SpaltenID" = source.$4
            and target."ZeilenNr" = source.$9
    where source.$2 is null
) as bucket
    on production.helper."SA_Wert"."WertKopf" = bucket."WertKopf"
    and production.helper."SA_Wert"."SpaltenID" = bucket."SpaltenID"
    and production.helper."SA_Wert"."ZeilenNr" = bucket."ZeilenNr"
when matched then delete
;