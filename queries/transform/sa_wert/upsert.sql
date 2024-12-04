merge into production.helper."SA_Wert" using (
    select stg.$1 as "Firma"
        , stg.$2 as "WertKopf"
        , stg.$3 as "ZeilenID"
        , stg.$4 as "SpaltenID"
        , stg.$5 as "Datentyp"
        , stg.$6 as "DecWert"
        , stg.$7 as "CharWert"
        , stg.$8 as "SpaltenNr"
        , stg.$9 as "ZeilenNr"
        , stg.$10 as "Warnstufe"
        , stg.$11 as "Eurokonvertierung"
    from <<FILENAME>> as stg
) as bucket
    on production.helper."SA_Wert"."WertKopf" = bucket."WertKopf"
    and production.helper."SA_Wert"."SpaltenID" = bucket."SpaltenID"
    and production.helper."SA_Wert"."ZeilenNr" = bucket."ZeilenNr"
when matched and (
       ifnull("SA_Wert"."Firma", '') != ifnull(bucket."Firma", '')
    or ifnull("SA_Wert"."ZeilenID", -1) != ifnull(bucket."ZeilenID", -1)
    or ifnull("SA_Wert"."Datentyp", '') != ifnull(bucket."Datentyp", '')
    or ifnull("SA_Wert"."DecWert", '') != ifnull(bucket."DecWert", '')
    or ifnull("SA_Wert"."CharWert", '') != ifnull(bucket."CharWert", '')
    or ifnull("SA_Wert"."SpaltenNr", -1) != ifnull(bucket."SpaltenNr", -1)
    or ifnull("SA_Wert"."Warnstufe", -1) != ifnull(bucket."Warnstufe", -1)
    or ifnull("SA_Wert"."Eurokonvertierung", false) != ifnull(bucket."Eurokonvertierung", false)
) then update set
    "SA_Wert"."Firma" = bucket."Firma"
    , "SA_Wert"."ZeilenID" = bucket."ZeilenID"
    , "SA_Wert"."Datentyp" = bucket."Datentyp"
    , "SA_Wert"."DecWert" = bucket."DecWert"
    , "SA_Wert"."CharWert" = bucket."CharWert"
    , "SA_Wert"."SpaltenNr" = bucket."SpaltenNr"
    , "SA_Wert"."Warnstufe" = bucket."Warnstufe"
    , "SA_Wert"."Eurokonvertierung" = bucket."Eurokonvertierung"
when not matched then insert (
    "Firma"
    , "WertKopf"
    , "ZeilenID"
    , "SpaltenID"
    , "Datentyp"
    , "DecWert"
    , "CharWert"
    , "SpaltenNr"
    , "ZeilenNr"
    , "Warnstufe"
    , "Eurokonvertierung"
) values (
    bucket."Firma"
    , bucket."WertKopf"
    , bucket."ZeilenID"
    , bucket."SpaltenID"
    , bucket."Datentyp"
    , bucket."DecWert"
    , bucket."CharWert"
    , bucket."SpaltenNr"
    , bucket."ZeilenNr"
    , bucket."Warnstufe"
    , bucket."Eurokonvertierung"
);