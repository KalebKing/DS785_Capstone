SELECT DISTINCT
      FB_Buchung.BuchungsNummer AS "FB_Buchung.BuchungsNummer"
    , FB_Buchung.BuchungsDatum AS "FB_Buchung.BuchungsDatum"
    , FB_Buchung.BelegNummer AS "FB_Buchung.BelegNummer"
    , FB_Buchung.Konto AS "FB_Buchung.Konto"
    , FB_Buchung.Betrag AS "FB_Buchung.Betrag"
    , FB_Buchung.BuchArt AS "FB_Buchung.BuchArt"
    , FB_Buchung.SH_Kennung AS "FB_Buchung.SH_Kennung"
    , FB_Buchung.BuchungsJahr AS "FB_Buchung.BuchungsJahr"
    , FB_Buchung.BuchungsPeriode AS "FB_Buchung.BuchungsPeriode"
    , FB_KalkBuch.LaufNummer AS "FB_KalkBuch.LaufNummer"
    , FB_KalkBuch.KostenStelle AS "FB_KalkBuch.KostenStelle"
    , FB_KalkBuch.Betrag AS "FB_KalkBuch.Betrag"
    , MLL_FNAPost.DocumentPosition AS "MLL_FNAPost.DocumentPosition"
    , S_BelegArtSpr.Bezeichnung AS "S_BelegArtSpr.Bezeichnung"
    , ER_BelegKopf.Lieferant AS "ER_BelegKopf.Lieferant"
    , ER_BelegPos.Herk_ReferenzNr AS "ER_BelegPos.Herk_ReferenzNr"
    , ER_BelegPos.Herk_PositionsNr AS "ER_BelegPos.Herk_PositionsNr"
    , FB_Buchung.BuchArt AS "FB_Buchung.BuchArt"
    , FB_Buchung.BelegDatum AS "FB_Buchung.BelegDatum"
FROM
    PUB.S_Konto
    INNER JOIN PUB.FB_Buchung
        ON S_Konto.Konto = FB_Buchung.Konto
        AND FB_Buchung.BuchungsJahr = <<YEAR>>
        AND FB_Buchung.BuchungsPeriode = <<PERIOD>>
    LEFT JOIN PUB.FB_BuchInfo
        ON FB_Buchung.Firma = FB_BuchInfo.Firma
        AND FB_Buchung.FB_Buchung_Obj = FB_BuchInfo.FB_Buchung_Obj
    LEFT JOIN PUB.FB_BuchInfo AS FB_BuchInfo__parent
        ON FB_BuchInfo.Firma = FB_BuchInfo__parent.Firma
        AND FB_BuchInfo.Parent_FB_Buchung_Obj = FB_BuchInfo__parent.FB_Buchung_Obj
        AND FB_Buchung.OrdnungsNr = FB_BuchInfo__parent.OrdnungsNr
    LEFT JOIN PUB.FB_KalkBuch
        ON FB_BuchInfo__parent.Firma = FB_KalkBuch.Firma
        AND FB_BuchInfo__parent.FB_BuchInfo_Obj = FB_KalkBuch.FB_BuchInfo_Obj
        AND FB_KalkBuch.KostenStelle is not null
    LEFT JOIN PUB.MLL_FNAPost
        ON FB_Buchung.Firma = MLL_FNAPost.Company
        AND FB_Buchung.Herk_ReferenzNr = MLL_FNAPost.FNAIdentNumber
        AND FB_Buchung.BelegNummer = MLL_FNAPost.DocumentNumber
    LEFT JOIN PUB.S_BelegArtSpr as S_BelegArtSpr__en
        ON MLL_FNAPost.DocumentType = S_BelegArtSpr__en.Belegart
        AND S_BelegArtSpr__en.Sprache = 'E'
    LEFT JOIN PUB.ER_BelegKopf
        ON MLL_FNAPost.DocumentType = ER_BelegKopf.Belegart
        AND MLL_FNAPost.DocumentNumber = ER_BelegKopf.Belegnummer
    LEFT JOIN PUB.ER_BelegPos
        ON ER_BelegKopf.Firma = ER_BelegPos.Firma
        AND ER_BelegKopf.ReferenzNr = ER_BelegPos.ReferenzNr
        AND MLL_FNAPost.DocumentPosition = ER_BelegPos.PositionsNr
WHERE
    S_Konto.KontenArt in ('B', 'E', 'G')