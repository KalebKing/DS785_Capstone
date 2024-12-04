SELECT
    S_LieferAdresse.Kunde AS "S_LieferAdresse.Kunde"
    , S_LieferAdresse.LieferAdresse AS "S_LieferAdresse.LieferAdresse"
    , S_LieferAdresse.AnlageDatum AS "S_LieferAdresse.AnlageDatum"
    , S_LieferAdresse.AnlageZeit AS "S_LieferAdresse.AnlageZeit"
    , S_LieferAdresse.AenderungDatum AS "S_LieferAdresse.AenderungDatum"
    , S_LieferAdresse.AenderungZeit AS "S_LieferAdresse.AenderungZeit"
    , S_Adresse.AenderungDatum AS "S_Adresse.AenderungDatum"
    , S_Adresse.AenderungZeit AS "S_Adresse.AenderungZeit"
    , S_Adresse.Name1 AS "S_Adresse.Name1"
    , S_Adresse.Name2 AS "S_Adresse.Name2"
    , S_Adresse.Name3 AS "S_Adresse.Name3"
    , S_Adresse.StreetPrefix AS "S_Adresse.StreetPrefix"
    , S_Adresse.Strasse AS "S_Adresse.Strasse"
    , S_Adresse.StreetPostfix AS "S_Adresse.StreetPostfix"
    , S_Adresse.Hausnummer AS "S_Adresse.Hausnummer"
    , S_Adresse.CityPrefix AS "S_Adresse.CityPrefix"
    , S_Adresse.PLZ AS "S_Adresse.PLZ"
    , S_Adresse.Ort AS "S_Adresse.Ort"
    , S_Adresse.CityPostfix AS "S_Adresse.CityPostfix"
    , S_Adresse.Telefon AS "S_Adresse.Telefon"
    , S_Adresse.Telefax AS "S_Adresse.Telefax"
    , S_Staat.AenderungDatum AS "S_Staat.AenderungDatum"
    , S_Staat.AenderungZeit AS "S_Staat.AenderungZeit"
    , S_Staat.IsoAlpha2Code AS "S_Staat.IsoAlpha2Code"
    , S_Staat.StrassenFormat AS "S_Staat.StrassenFormat"
    , S_StaatSpr.Bezeichnung AS "S_StaatSpr.Bezeichnung"
    , S_Bundesland.Bundesland AS "S_Bundesland.Bundesland"
    , S_Bundesland.Bezeichnung AS "S_Bundesland.Bezeichnung"
    , S_Bundesland.ISOAlpha2Code AS "S_Bundesland.ISOAlpha2Code"
    , S_Kunde.AenderungDatum AS "S_Kunde.AenderungDatum"
    , S_Kunde.AenderungZeit AS "S_Kunde.AenderungZeit"
    , S_Kunde.Sprache AS "S_Kunde.Sprache"
    , S_LieferBed.AenderungDatum AS "S_LieferBed.AenderungDatum"
    , S_LieferBed.AenderungZeit AS "S_LieferBed.AenderungZeit"
    , S_LieferBedSpr__de.Bezeichnung AS "S_LieferBedSpr__de.Bezeichnung"
    , S_LieferBedSpr__en.Bezeichnung AS "S_LieferBedSpr__en.Bezeichnung"
    , S_Waehrung.AenderungDatum AS "S_Waehrung.AenderungDatum"
    , S_Waehrung.AenderungZeit AS "S_Waehrung.AenderungZeit"
    , S_Waehrung.ISO_KurzBez AS "S_Waehrung.ISO_KurzBez"
    , S_VersandArt.AenderungDatum AS "S_VersandArt.AenderungDatum"
    , S_VersandArt.AenderungZeit AS "S_VersandArt.AenderungZeit"
    , S_VersandArtSpr__de.Bezeichnung AS "S_VersandArtSpr__de.Bezeichnung"
    , S_VersandArtSpr__en.Bezeichnung AS "S_VersandArtSpr__en.Bezeichnung"
    , S_KundeVertreter.AenderungDatum AS "S_KundeVertreter.AenderungDatum"
    , S_KundeVertreter.AenderungZeit AS "S_KundeVertreter.AenderungZeit"
    , S_Vertreter.AenderungDatum AS "S_Vertreter.AenderungDatum"
    , S_Vertreter.AenderungZeit AS "S_Vertreter.AenderungZeit"
    , S_Adresse__Vertreter.AenderungDatum AS "S_Adresse__Vertreter.AenderungDa"
    , S_Adresse__Vertreter.AenderungZeit AS "S_Adresse__Vertreter.AenderungZe"
    , S_Adresse__Vertreter.Vorname AS "S_Adresse__Vertreter.Vorname"
    , S_Adresse__Vertreter.Name1 AS "S_Adresse__Vertreter.Name1"
FROM 
    PUB.S_LieferAdresse
        LEFT JOIN PUB.S_Adresse
            ON S_LieferAdresse.AdressNr = S_Adresse.AdressNr
        LEFT JOIN PUB.S_Staat
            ON S_Adresse.Staat = S_Staat.Staat
        LEFT JOIN PUB.S_StaatSpr
            ON S_Staat.Staat = S_StaatSpr.Staat
            AND S_StaatSpr.Sprache = 'D'
        LEFT JOIN PUB.S_Bundesland
            ON S_Adresse.Staat = S_Bundesland.Staat
            AND S_Adresse.Bundesland = S_Bundesland.Bundesland
        LEFT JOIN PUB.S_Kunde
            ON S_LieferAdresse.Firma = S_Kunde.Firma
            AND S_LieferAdresse.Kunde = S_Kunde.Kunde
        LEFT JOIN PUB.S_LieferBed
            ON S_Kunde.LieferBedingung = S_LieferBed.LieferBedingung
        LEFT JOIN PUB.S_LieferBedSpr as S_LieferBedSpr__de
            ON S_LieferBed.LieferBedingung = S_LieferBedSpr__de.LieferBedingung
            AND S_LieferBedSpr__de.Sprache = 'D'
        LEFT JOIN PUB.S_LieferBedSpr as S_LieferBedSpr__en
            ON S_LieferBed.LieferBedingung = S_LieferBedSpr__en.LieferBedingung
            AND S_LieferBedSpr__en.Sprache = 'E'
        LEFT JOIN PUB.S_Waehrung
            ON S_Kunde.Waehrung = S_Waehrung.Waehrung
        LEFT JOIN PUB.S_VersandArt
            ON S_Kunde.VersandArt = S_VersandArt.VersandArt
        LEFT JOIN PUB.S_VersandArtSpr as S_VersandArtSpr__de
            ON S_VersandArt.VersandArt = S_VersandArtSpr__de.VersandArt
            AND S_VersandArtSpr__de.Sprache = 'D'
        LEFT JOIN PUB.S_VersandArtSpr as S_VersandArtSpr__en
            ON S_VersandArt.VersandArt = S_VersandArtSpr__en.VersandArt
            AND S_VersandArtSpr__en.Sprache = 'E'
        LEFT JOIN PUB.S_KundeVertreter
            ON S_Kunde.Firma = S_KundeVertreter.Firma
            AND S_Kunde.Kunde = S_KundeVertreter.Kunde
            AND S_KundeVertreter.Hauptvertreter = 1
        LEFT JOIN PUB.S_Vertreter
            ON S_KundeVertreter.Firma = S_Vertreter.Firma
            AND S_KundeVertreter.Vertreter = S_Vertreter.Vertreter
        LEFT JOIN PUB.S_Adresse AS S_Adresse__Vertreter
            ON S_Vertreter.AdressNr = S_Adresse__Vertreter.AdressNr