create table if not exists production.helper."SA_Wert" (
-- create or replace table production.helper."SA_Wert" (
    "Firma" varchar(20)
    , "WertKopf" number(10, 0)
    , "ZeilenID" number(10, 0)
    , "SpaltenID" number(10, 0)
    , "Datentyp" varchar(24)
    , "DecWert" varchar(68)
    , "CharWert" varchar(40)
    , "SpaltenNr" number(10, 0)
    , "ZeilenNr" number(10, 0)
    , "Warnstufe" number(10, 0)
    , "Eurokonvertierung" boolean
);