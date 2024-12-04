SELECT
    E_BelegPos.AenderungDatum AS "E_BelegPos.AenderungDatum"
    , E_BelegPos.AenderungZeit AS "E_BelegPos.AenderungZeit"
    , E_BelegPos.PositionsNr AS "E_BelegPos.PositionsNr"
    , E_BelegPos.offen AS "E_BelegPos.offen"
    , E_BelegPos.Artikel AS "E_BelegPos.Artikel"
    , E_BelegPos.Menge AS "E_BelegPos.Menge"
    , E_BelegPos.gelieferte_Menge AS "E_BelegPos.gelieferte_Menge"
    , E_BelegPos.Warenwert AS "E_BelegPos.Warenwert"
    , E_BelegPos.Wunschtermin AS "E_BelegPos.Wunschtermin"
    , E_BelegPos.Zugangstermin AS "E_BelegPos.Zugangstermin"
    , E_BelegPos.AnlageDatum AS "E_BelegPos.AnlageDatum"
    , E_BelegPos.AnlageZeit AS "E_BelegPos.AnlageZeit"
    , E_BelegKopf.BelegNummer AS "E_BelegKopf.BelegNummer"
    , E_BelegKopf.Sprache AS "E_BelegKopf.Sprache"
    , E_BelegKopf.BelegDatum AS "E_BelegKopf.BelegDatum"
    , E_BelegKopf.Lieferant AS "E_BelegKopf.Lieferant"
    , E_BelegKopf.AenderungDatum AS "E_BelegKopf.AenderungDatum"
    , E_BelegKopf.AenderungZeit AS "E_BelegKopf.AenderungZeit"
    , S_Versandart.AenderungDatum AS "S_Versandart.AenderungDatum"
    , S_Versandart.AenderungZeit AS "S_Versandart.AenderungZeit"
    , S_VersandartSpr.Bezeichnung AS "S_VersandartSpr.Bezeichnung"
    , S_ZahlZiel.AenderungDatum AS "S_ZahlZiel.AenderungDatum"
    , S_ZahlZiel.AenderungZeit AS "S_ZahlZiel.AenderungZeit"
    , S_Zahlzielspr.Bezeichnung AS "S_Zahlzielspr.Bezeichnung"
    , S_Lieferbed.AenderungDatum AS "S_Lieferbed.AenderungDatum"
    , S_Lieferbed.AenderungZeit AS "S_Lieferbed.AenderungZeit"
    , S_LieferbedSpr.Bezeichnung AS "S_LieferbedSpr.Bezeichnung"
    , S_Waehrung.AenderungDatum AS "S_Waehrung.AenderungDatum"
    , S_Waehrung.AenderungZeit AS "S_Waehrung.AenderungZeit"
    , S_Waehrung.ISO_KurzBez AS "S_Waehrung.ISO_KurzBez"
    , E_BelegPos.ReferenzNr AS "E_BelegPos.ReferenzNr"
FROM
    PUB.E_BelegPos
    INNER JOIN PUB.E_BelegKopf
        ON E_BelegPos.Firma = E_BelegKopf.Firma
        AND E_BelegPos.BelegArt = E_BelegKopf.BelegArt
        AND E_BelegPos.ReferenzNr = E_BelegKopf.ReferenzNr
        AND E_BelegKopf.BelegArt = 'EB'
    LEFT JOIN PUB.S_VersandArt
        ON E_BelegKopf.VersandArt = S_VersandArt.VersandArt
    LEFT JOIN PUB.S_VersandArtSpr
        ON S_VersandArt.VersandArt = S_VersandArtSpr.VersandArt
        AND S_VersandArtSpr.Sprache = 'E'
    LEFT JOIN PUB.S_LieferBed
        ON E_BelegKopf.LieferBedingung = S_LieferBed.LieferBedingung
    LEFT JOIN PUB.S_LieferBedSpr
        ON S_LieferBed.LieferBedingung = S_LieferBedSpr.LieferBedingung
        AND S_LieferBedSpr.Sprache = 'E'
    LEFT JOIN PUB.S_ZahlZiel
        ON E_BelegKopf.ZahlungsZiel = S_ZahlZiel.ZahlungsZiel
    LEFT JOIN PUB.S_ZahlZielSpr
        ON S_ZahlZiel.ZahlungsZiel = S_ZahlZielSpr.ZahlungsZiel
        AND S_ZahlZielSpr.Sprache = 'E'
    LEFT JOIN PUB.S_Waehrung
        ON E_BelegKopf.Waehrung = S_Waehrung.Waehrung
WHERE
    E_BelegPos.Satzart != 'T'