SELECT
    -- S_Artikel.AenderungBenutzer AS "S_Artikel.AenderungBenutzer"
    S_Artikel.AenderungDatum AS "S_Artikel.AenderungDatum"
    , S_Artikel.AenderungZeit AS "S_Artikel.AenderungZeit"
    -- , S_Artikel.Firma AS "S_Artikel.Firma"
    , S_Artikel.Artikel AS "S_Artikel.Artikel"
    -- , S_Artikel.Suchbegriff AS "S_Artikel.Suchbegriff"
    -- , S_Artikel.Selektion AS "S_Artikel.Selektion"
    -- , S_Artikel.SortBezeichnung AS "S_Artikel.SortBezeichnung"
    -- , S_Artikel.VerteilerGruppe AS "S_Artikel.VerteilerGruppe"
    -- , S_Artikel.ArtikelGruppe AS "S_Artikel.ArtikelGruppe"
    , S_Artikel.ArtikelArt AS "S_Artikel.ArtikelArt"
    -- , S_Artikel.SMLeiste AS "S_Artikel.SMLeiste"
    , S_Artikel.archiviert AS "S_Artikel.archiviert"
    -- , S_Artikel.Sparte AS "S_Artikel.Sparte"
    -- , S_Artikel.Ursprungszeugnis AS "S_Artikel.Ursprungszeugnis"
    -- , S_Artikel.Ursprungsland AS "S_Artikel.Ursprungsland"
    -- , S_Artikel.Tarifbezeichnung AS "S_Artikel.Tarifbezeichnung"
    -- , S_Artikel.Embargoware AS "S_Artikel.Embargoware"
    -- , S_Artikel.Kennung AS "S_Artikel.Kennung"
    -- , S_Artikel.BME_Faktor AS "S_Artikel.BME_Faktor"
    -- , S_Artikel.genehmigt_von AS "S_Artikel.genehmigt_von"
    -- , S_Artikel.genehmigt_bis AS "S_Artikel.genehmigt_bis"
    -- , S_Artikel.Gefahrgutnummer AS "S_Artikel.Gefahrgutnummer"
    -- , S_Artikel.WBZ AS "S_Artikel.WBZ"
    -- , S_Artikel.ZeiteinheitWBZ AS "S_Artikel.ZeiteinheitWBZ"
    -- , S_Artikel.WBZ_Lieferant AS "S_Artikel.WBZ_Lieferant"
    -- , S_Artikel.KalkPreis1 AS "S_Artikel.KalkPreis1"
    -- , S_Artikel.KalkDatum1 AS "S_Artikel.KalkDatum1"
    -- , S_Artikel.KalkPreis2 AS "S_Artikel.KalkPreis2"
    -- , S_Artikel.KalkDatum2 AS "S_Artikel.KalkDatum2"
    -- , S_Artikel.SBM_ValueFlowGroup_Obj AS "S_Artikel.SBM_ValueFlowGroup_Obj"
    -- , S_Artikel.Chargenart AS "S_Artikel.Chargenart"
    -- , S_Artikel.SNRArt AS "S_Artikel.SNRArt"
    -- , S_Artikel.SNRTyp AS "S_Artikel.SNRTyp"
    -- , S_Artikel.StkZeilenArt AS "S_Artikel.StkZeilenArt"
    -- , S_Artikel.ArtVarTyp AS "S_Artikel.ArtVarTyp"
    -- , S_Artikel.KommLager AS "S_Artikel.KommLager"
    -- , S_Artikel.Pruefvorschrift AS "S_Artikel.Pruefvorschrift"
    -- , S_Artikel.SB_ProduktManager AS "S_Artikel.SB_ProduktManager"
    , S_Artikel.ABC_Klasse AS "S_Artikel.ABC_Klasse"
    -- , S_Artikel.DIN_ISO AS "S_Artikel.DIN_ISO"
    -- , S_Artikel.LagerME AS "S_Artikel.LagerME"
    -- , S_Artikel.StkFaktor AS "S_Artikel.StkFaktor"
    -- , S_Artikel.StkME AS "S_Artikel.StkME"
    -- , S_Artikel.Bundesland AS "S_Artikel.Bundesland"
    -- , S_Artikel.Planung AS "S_Artikel.Planung"
    -- , S_Artikel.Detailplanung AS "S_Artikel.Detailplanung"
    -- , S_Artikel.Planpreis AS "S_Artikel.Planpreis"
    -- , S_Artikel.SME_Faktor AS "S_Artikel.SME_Faktor"
    -- , S_Artikel.LagerGewicht AS "S_Artikel.LagerGewicht"
    -- , S_Artikel.GewichtME AS "S_Artikel.GewichtME"
    -- , S_Artikel.Gewicht AS "S_Artikel.Gewicht"
    -- , S_Artikel.Kundenstatistik AS "S_Artikel.Kundenstatistik"
    -- , S_Artikel.Rabattfaehig AS "S_Artikel.Rabattfaehig"
    -- , S_Artikel.Rabattgruppe AS "S_Artikel.Rabattgruppe"
    -- , S_Artikel.provisionsfaehig AS "S_Artikel.provisionsfaehig"
    -- , S_Artikel.ProvGruppe AS "S_Artikel.ProvGruppe"
    -- , S_Artikel.Bewertungsgruppe AS "S_Artikel.Bewertungsgruppe"
    -- , S_Artikel.skontofaehig AS "S_Artikel.skontofaehig"
    -- , S_Artikel.Preiseinheit AS "S_Artikel.Preiseinheit"
    -- , S_Artikel.PruefNr AS "S_Artikel.PruefNr"
    -- , S_Artikel.fixSetPreis AS "S_Artikel.fixSetPreis"
    -- , S_Artikel.WEBShop AS "S_Artikel.WEBShop"
    -- , S_Artikel.Bild AS "S_Artikel.Bild"
    -- , S_Artikel.KalkSchema AS "S_Artikel.KalkSchema"
    -- , S_Artikel.Bauteiltyp AS "S_Artikel.Bauteiltyp"
    -- , S_Artikel.Werkstoff AS "S_Artikel.Werkstoff"
    -- , S_Artikel.Eurokonvertierung AS "S_Artikel.Eurokonvertierung"
    -- , S_Artikel.AnlageBenutzer AS "S_Artikel.AnlageBenutzer"
    , S_Artikel.AnlageDatum AS "S_Artikel.AnlageDatum"
    , S_Artikel.AnlageZeit AS "S_Artikel.AnlageZeit"
    -- , S_Artikel.Prioritaet AS "S_Artikel.Prioritaet"
    -- , S_Artikel.WBZFaktor AS "S_Artikel.WBZFaktor"
    -- , S_Artikel.Produktakte AS "S_Artikel.Produktakte"
    -- , S_Artikel.S_Artikel_Obj AS "S_Artikel.S_Artikel_Obj"
    -- , S_Artikel.GewichtBestaetigt AS "S_Artikel.GewichtBestaetigt"
    -- , S_Artikel.StkFormel AS "S_Artikel.StkFormel"
    -- , S_Artikel.AvgPriceVariance AS "S_Artikel.AvgPriceVariance"
    -- , S_Artikel.AvgPriceSurveillance AS "S_Artikel.AvgPriceSurveillance"
    -- , S_Artikel.Driver_Obj AS "S_Artikel.Driver_Obj"
    -- , S_Artikel.StatProcArrival AS "S_Artikel.StatProcArrival"
    -- , S_Artikel.StatProcDispatch AS "S_Artikel.StatProcDispatch"
    -- , S_Artikel.SBM_CustomsTariffNo_Obj AS "S_Artikel.SBM_CustomsTariffNo_Ob"
    -- , S_Artikel.uCE_TypeInstallationVariant AS "S_Artikel.uCE_TypeInstallationVa"
    -- , S_Artikel.uCI_Versandart AS "S_Artikel.uCI_Versandart"
    -- , S_Artikel.uCW_bonusfaehig AS "S_Artikel.uCW_bonusfaehig"
    -- , S_Artikel.uCW_umsatzrelevant AS "S_Artikel.uCW_umsatzrelevant"
    , MLM_StorPartData.OrderPoint__max AS "MLM_StorPartData.OrderPoint"
    , S_ArtikelArt.Bereich AS "S_ArtikelArt.Bereich"
    , S_ArtikelSpr__de.Bezeichnung AS "S_ArtikelSpr__de.Bezeichnung"
    , S_ArtikelSpr__en.Bezeichnung AS "S_ArtikelSpr__en.Bezeichnung"
    , BS_AusprSpr__0010.Bezeichnung AS "BS_AusprSpr__0010.Bezeichnung"
    , BS_AusprSpr__0600.Bezeichnung AS "BS_AusprSpr__0600.Bezeichnung"
    , S_Staat.AenderungDatum AS "S_Staat.AenderungDatum"
    , S_Staat.AenderungZeit AS "S_Staat.AenderungZeit"
    , S_Staat.IsoAlpha2Code AS "S_Staat.IsoAlpha2Code"
    , S_StaatSpr.Bezeichnung AS "S_StaatSpr.Bezeichnung"
    , S_MengenEinheitSpr__de.Bezeichnung AS "S_MengenEinheitSpr__de.Bezeichnu"
    , S_MengenEinheitSpr__en.Bezeichnung AS "S_MengenEinheitSpr__en.Bezeichnu"
    , SBM_CustomsTariffNo.SBM_CustomsTariffNo_ID AS "SBM_CustomsTariffNo.SBM_CustomsT"
FROM 
    PUB.S_Artikel
        LEFT JOIN PUB.S_ArtikelArt
            ON S_Artikel.ArtikelArt = S_ArtikelArt.ArtikelArt
        LEFT JOIN PUB.S_ArtikelSpr as S_ArtikelSpr__de
            ON S_Artikel.Firma = S_ArtikelSpr__de.Firma
            AND S_Artikel.Artikel = S_ArtikelSpr__de.Artikel
            AND S_ArtikelSpr__de.Sprache = 'D'
        LEFT JOIN PUB.S_ArtikelSpr as S_ArtikelSpr__en
            ON S_Artikel.Firma = S_ArtikelSpr__en.Firma
            AND S_Artikel.Artikel = S_ArtikelSpr__en.Artikel
            AND S_ArtikelSpr__en.Sprache = 'E'
        LEFT JOIN PUB.BS_Zuord as BS_Zuord__0010
            ON S_Artikel.Firma = BS_Zuord__0010.Firma
            AND S_Artikel.S_Artikel_Obj = BS_Zuord__0010.Owning_Obj
            AND BS_Zuord__0010.SMArt = 'SAR'
            AND BS_Zuord__0010.Merkmal = '0010'
        LEFT JOIN PUB.BS_Auspr as BS_Auspr__0010
            ON BS_Zuord__0010.Firma = BS_Auspr__0010.Firma
            AND BS_Zuord__0010.SMArt = BS_Auspr__0010.SMArt
            AND BS_Zuord__0010.SMLeiste = BS_Auspr__0010.SMLeiste
            AND BS_Zuord__0010.Merkmal = BS_Auspr__0010.Merkmal
            AND BS_Zuord__0010.Auspr = BS_Auspr__0010.Auspr
        LEFT JOIN PUB.BS_AusprSpr AS BS_AusprSpr__0010
            ON BS_Auspr__0010.SMArt = BS_AusprSpr__0010.SMArt
            AND BS_Auspr__0010.Firma = BS_AusprSpr__0010.Firma
            AND BS_Auspr__0010.SMLeiste = BS_AusprSpr__0010.SMLeiste
            AND BS_Auspr__0010.Merkmal = BS_AusprSpr__0010.Merkmal
            AND BS_Auspr__0010.Auspr = BS_AusprSpr__0010.Auspr
            AND BS_AusprSpr__0010.Sprache = 'D'
        LEFT JOIN PUB.BS_Zuord as BS_Zuord__0600
            ON S_Artikel.Firma = BS_Zuord__0600.Firma
            AND S_Artikel.S_Artikel_Obj = BS_Zuord__0600.Owning_Obj
            AND BS_Zuord__0600.SMArt = 'SAR'
            AND BS_Zuord__0600.Merkmal = '0600'
        LEFT JOIN PUB.BS_Auspr as BS_Auspr__0600
            ON BS_Zuord__0600.Firma = BS_Auspr__0600.Firma
            AND BS_Zuord__0600.SMArt = BS_Auspr__0600.SMArt
            AND BS_Zuord__0600.SMLeiste = BS_Auspr__0600.SMLeiste
            AND BS_Zuord__0600.Merkmal = BS_Auspr__0600.Merkmal
            AND BS_Zuord__0600.Auspr = BS_Auspr__0600.Auspr
        LEFT JOIN PUB.BS_AusprSpr AS BS_AusprSpr__0600
            ON BS_Auspr__0600.SMArt = BS_AusprSpr__0600.SMArt
            AND BS_Auspr__0600.Firma = BS_AusprSpr__0600.Firma
            AND BS_Auspr__0600.SMLeiste = BS_AusprSpr__0600.SMLeiste
            AND BS_Auspr__0600.Merkmal = BS_AusprSpr__0600.Merkmal
            AND BS_Auspr__0600.Auspr = BS_AusprSpr__0600.Auspr
            AND BS_AusprSpr__0600.Sprache = 'D'
        LEFT JOIN PUB.S_Staat
            ON S_Artikel.Ursprungsland = S_Staat.Staat
        LEFT JOIN PUB.S_StaatSpr
            ON S_Staat.Staat = S_StaatSpr.Staat
            AND S_StaatSpr.Sprache = 'D'
        LEFT JOIN PUB.S_MengenEinheit
            ON S_Artikel.LagerME = S_MengenEinheit.MengenEinheit
        LEFT JOIN PUB.S_MengenEinheitSpr AS S_MengenEinheitSpr__de
            ON S_MengenEinheit.MengenEinheit = S_MengenEinheitSpr__de.MengenEinheit
            AND S_MengenEinheitSpr__de.Sprache = 'D'
        LEFT JOIN PUB.S_MengenEinheitSpr AS S_MengenEinheitSpr__en
            ON S_MengenEinheit.MengenEinheit = S_MengenEinheitSpr__en.MengenEinheit
            AND S_MengenEinheitSpr__en.Sprache = 'E'
        LEFT JOIN (
            SELECT Company, Part, MAX(OrderPoint) AS OrderPoint__max
            FROM PUB.MLM_StorPartData 
            GROUP BY Company, Part
        ) as MLM_StorPartData
            ON S_Artikel.Firma = MLM_StorPartData.Company
            AND S_Artikel.Artikel = MLM_StorPartData.Part
        LEFT JOIN PUB.SBM_CustomsTariffNo
            ON S_Artikel.SBM_CustomsTariffNo_Obj = SBM_CustomsTariffNo.SBM_CustomsTariffNo_Obj
WHERE
    -- Exclude part numbers with leading or trailing spaces
    -- Snowflake automatically removes them when reading data which leads to duplicates
    S_Artikel.Artikel not like ' %'
    AND S_Artikel.Artikel not like '% '
    -- Exclude partial payments
    AND S_Artikel.ArtikelArt != 60
ORDER BY
    S_Artikel.Artikel