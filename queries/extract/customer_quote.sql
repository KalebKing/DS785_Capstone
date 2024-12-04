SELECT
    V_BelegPos.AenderungDatum AS "V_BelegPos.AenderungDatum"
    , V_BelegPos.AenderungZeit AS "V_BelegPos.AenderungZeit"
    , V_BelegPos.PositionsNr AS "V_BelegPos.PositionsNr"
    , V_BelegPos.offen AS "V_BelegPos.offen"
    , V_BelegPos.AlternativPosition AS "V_BelegPos.AlternativPosition"
    , V_BelegPos.Artikel AS "V_BelegPos.Artikel"
    , V_BelegPos.ArtVar AS "V_BelegPos.ArtVar"
    , V_BelegPos.Bezeichnung AS "V_BelegPos.Bezeichnung"
    , V_BelegPos.Menge AS "V_BelegPos.Menge"
    , V_BelegPos.Einstandspreis AS "V_BelegPos.Einstandspreis"
    , V_BelegPos.Rabattfaehig AS "V_BelegPos.Rabattfaehig"
    , V_BelegPos.Gesamtpreis AS "V_BelegPos.Gesamtpreis"
    , V_BelegPos.GS_Faktor AS "V_BelegPos.GS_Faktor"
    , V_BelegPos.ZS_Faktor AS "V_BelegPos.ZS_Faktor"
    , V_BelegPos.AnlageDatum AS "V_BelegPos.AnlageDatum"
    , V_BelegPos.AnlageZeit AS "V_BelegPos.AnlageZeit"
    , V_BelegKopf.AenderungDatum AS "V_BelegKopf.AenderungDatum"
    , V_BelegKopf.AenderungZeit AS "V_BelegKopf.AenderungZeit"
    , V_BelegKopf.BelegNummer AS "V_BelegKopf.BelegNummer"
    , V_BelegKopf.Sprache AS "V_BelegKopf.Sprache"
    , V_BelegKopf.BelegDatum AS "V_BelegKopf.BelegDatum"
    , V_BelegKopf.gueltig_bis AS "V_BelegKopf.gueltig_bis"
    , V_BelegKopf.Kunde AS "V_BelegKopf.Kunde"
    , V_BelegKopf.Kurs AS "V_BelegKopf.Kurs"
    , V_BelegKopfAdr.Lieferadresse AS "V_BelegKopfAdr.Lieferadresse"
    , S_VersandArt.AenderungDatum AS "S_VersandArt.AenderungDatum"
    , S_VersandArt.AenderungZeit AS "S_VersandArt.AenderungZeit"
    , S_VersandArtSpr.Bezeichnung AS "S_VersandArtSpr.Bezeichnung"
    , S_LieferBed.AenderungDatum AS "S_LieferBed.AenderungDatum"
    , S_LieferBed.AenderungZeit AS "S_LieferBed.AenderungZeit"
    , S_LieferBedSpr.Bezeichnung AS "S_LieferBedSpr.Bezeichnung"
    , S_ZahlZiel.AenderungDatum AS "S_ZahlZiel.AenderungDatum"
    , S_ZahlZiel.AenderungZeit AS "S_ZahlZiel.AenderungZeit"
    , S_ZahlZielSpr.Bezeichnung AS "S_ZahlZielSpr.Bezeichnung"
    , S_Waehrung.AenderungDatum AS "S_Waehrung.AenderungDatum"
    , S_Waehrung.AenderungZeit AS "S_Waehrung.AenderungZeit"
    , S_Waehrung.ISO_KurzBez AS "S_Waehrung.ISO_KurzBez"
    , S_Vertreter.AenderungDatum AS "S_Vertreter.AenderungDatum"
    , S_Vertreter.AenderungZeit AS "S_Vertreter.AenderungZeit"
    , S_Adresse.AenderungDatum AS "S_Adresse.AenderungDatum"
    , S_Adresse.AenderungZeit AS "S_Adresse.AenderungZeit"
    , S_Adresse.Vorname AS "S_Adresse.Vorname"
    , S_Adresse.Name1 AS "S_Adresse.Name1"
    , V_BelegPos.ReferenzNr AS "V_BelegPos.ReferenzNr"
    , V_BelegKopf.AnlageBenutzer AS "V_BelegKopf.AnlageBenutzer"
    , V_BelegKopf.gueltig_ab AS "V_BelegKopf.gueltig_ab"
FROM
    PUB.V_BelegPos
    INNER JOIN PUB.V_BelegKopf
        ON V_BelegPos.Firma = V_BelegKopf.Firma
        AND V_BelegPos.BelegArt = V_BelegKopf.BelegArt
        AND V_BelegPos.ReferenzNr = V_BelegKopf.ReferenzNr
        AND V_BelegKopf.BelegArt = 'A'
    LEFT JOIN PUB.V_BelegKopfAdr
        ON V_BelegKopf.Firma = V_BelegKopfAdr.Firma
        AND V_BelegKopf.BelegArt = V_BelegKopfAdr.BelegArt
        AND V_BelegKopf.ReferenzNr = V_BelegKopfAdr.ReferenzNr
        AND V_BelegKopfAdr.Typ = 'L'
    LEFT JOIN PUB.S_VersandArt
        ON V_BelegKopf.VersandArt = S_VersandArt.VersandArt
    LEFT JOIN PUB.S_VersandArtSpr
        ON S_VersandArt.VersandArt = S_VersandArtSpr.VersandArt
        AND S_VersandArtSpr.Sprache = 'E'
    LEFT JOIN PUB.S_LieferBed
        ON V_BelegKopf.LieferBedingung = S_LieferBed.LieferBedingung
    LEFT JOIN PUB.S_LieferBedSpr
        ON S_LieferBed.LieferBedingung = S_LieferBedSpr.LieferBedingung
        AND S_LieferBedSpr.Sprache = 'E'
    LEFT JOIN PUB.S_ZahlZiel
        ON V_BelegKopf.ZahlungsZiel = S_ZahlZiel.ZahlungsZiel
    LEFT JOIN PUB.S_ZahlZielSpr
        ON S_ZahlZiel.ZahlungsZiel = S_ZahlZielSpr.ZahlungsZiel
        AND S_ZahlZielSpr.Sprache = 'E'
    LEFT JOIN PUB.S_Waehrung
        ON V_BelegKopf.Waehrung = S_Waehrung.Waehrung
    LEFT JOIN (
        SELECT
            V_BelegKopfVert.Firma
            , V_BelegKopfVert.BelegArt
            , V_BelegKopfVert.BelegNummer
            , MIN(V_BelegKopfVert.Vertreter) AS Vertreter
            , V_BelegKopfVert.ReferenzNr
        FROM
            PUB.V_BelegKopfVert
        GROUP BY
            V_BelegKopfVert.Firma
            , V_BelegKopfVert.BelegArt
            , V_BelegKopfVert.BelegNummer
            , V_BelegKopfVert.ReferenzNr
    ) AS V_BelegKopfVert
        ON V_BelegKopf.Firma = V_BelegKopfVert.Firma
        AND V_BelegKopf.BelegArt = V_BelegKopfVert.BelegArt
        AND V_BelegKopf.ReferenzNr = V_BelegKopfVert.ReferenzNr
    LEFT JOIN PUB.S_Vertreter
        ON V_BelegKopfVert.Firma = S_Vertreter.Firma
        AND V_BelegKopfVert.Vertreter = S_Vertreter.Vertreter
    LEFT JOIN PUB.S_Adresse
        ON S_Vertreter.AdressNr = S_Adresse.AdressNr