SELECT
    SA_Wert.Firma AS "SA_Wert.Firma"
    , SA_Wert.WertKopf AS "SA_Wert.WertKopf"
    , SA_Wert.ZeilenID AS "SA_Wert.ZeilenID"
    , SA_Wert.SpaltenID AS "SA_Wert.SpaltenID"
    , SA_Wert.Datentyp AS "SA_Wert.Datentyp"
    , SA_Wert.DecWert AS "SA_Wert.DecWert"
    , SA_Wert.CharWert AS "SA_Wert.CharWert"
    , SA_Wert.SpaltenNr AS "SA_Wert.SpaltenNr"
    , SA_Wert.ZeilenNr AS "SA_Wert.ZeilenNr"
    , SA_Wert.Warnstufe AS "SA_Wert.Warnstufe"
    , SA_Wert.Eurokonvertierung AS "SA_Wert.Eurokonvertierung"
FROM 
    PUB.SA_Wert
WHERE
    (SA_Wert.SpaltenID = 7 AND SA_Wert.ZeilenNr = 2900)    --Total
    OR (SA_Wert.SpaltenID = 8 AND SA_Wert.ZeilenNr = 1900) --Fixed Overhead
    OR (SA_Wert.SpaltenID = 9 AND SA_Wert.ZeilenNr = 1900) --Variable Overhead
    OR (SA_Wert.SpaltenID = 7 AND SA_Wert.ZeilenNr = 1100) --Labor
    OR (SA_Wert.SpaltenID = 7 AND SA_Wert.ZeilenNr = 400)  --Material