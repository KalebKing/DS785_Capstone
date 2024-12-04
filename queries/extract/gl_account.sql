SELECT
    S_Konto.AenderungDatum AS "S_Konto.AenderungDatum"
    , S_Konto.AenderungZeit AS "S_Konto.AenderungZeit"
    , S_Konto.Konto AS "S_Konto.Konto"
    , S_Konto.KontenArt AS "S_Konto.KontenArt"
    , S_Konto.AnlageDatum AS "S_Konto.AnlageDatum"
    , S_Konto.AnlageZeit AS "S_Konto.AnlageZeit"
    , S_KontoSpr__de.Bezeichnung AS "S_KontoSpr__de.Bezeichnung"
    , S_KontoSpr__en.Bezeichnung AS "S_KontoSpr__en.Bezeichnung"
    , S_Waehrung.AenderungDatum AS "S_Waehrung.AenderungDatum"
    , S_Waehrung.AenderungZeit AS "S_Waehrung.AenderungZeit"
    , S_Waehrung.ISO_KurzBez AS "S_Waehrung.ISO_KurzBez"
FROM 
    PUB.S_Konto
        LEFT JOIN PUB.S_KontoSpr as S_KontoSpr__de
            ON S_Konto.Firma = S_KontoSpr__de.Firma
            AND S_Konto.Konto = S_KontoSpr__de.Konto
            AND S_KontoSpr__de.Sprache = 'D'
        LEFT JOIN PUB.S_KontoSpr as S_KontoSpr__en
            ON S_Konto.Firma = S_KontoSpr__en.Firma
            AND S_Konto.Konto = S_KontoSpr__en.Konto
            AND S_KontoSpr__en.Sprache = 'E'
        LEFT JOIN PUB.S_Waehrung
            ON S_Konto.Waehrung = S_Waehrung.Waehrung
WHERE
    S_Konto.KontenArt in ('B', 'G')