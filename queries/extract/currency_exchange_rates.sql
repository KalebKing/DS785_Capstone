SELECT 
    S_Waehrung.ISO_KurzBez AS "S_Waehrung.ISO_KurzBez__from"
    , 'EUR' AS "S_Waehrung.ISO_KurzBez__to"
    , a.KursDatum AS "S_TagesKurs.KursDatum__start"
    , COALESCE(
        MIN(b.KursDatum)
        , TO_DATE(TO_CHAR(ADD_MONTHS(CURDATE(), 1), 'YYYY-MM-01'), 'YYYY-MM-DD')
    ) AS "S_TagesKurs.KursDatum__end"
    , a.GeldKurs AS "S_TagesKurs.GeldKurs"
    , a.MittelKurs AS "S_TagesKurs.MittelKurs"
    , a.BriefKurs AS "S_TagesKurs.BriefKurs"
    , a.VerrechnungsKurs AS "S_TagesKurs.VerrechnungsKurs"
FROM 
    PUB.S_TagesKurs AS a
    LEFT JOIN PUB.S_TagesKurs AS b
        ON a.Waehrung = b.Waehrung
        AND a.KursDatum < b.KursDatum
    LEFT JOIN PUB.S_Waehrung
        ON a.Waehrung = S_Waehrung.Waehrung
GROUP BY 
    S_Waehrung.ISO_KurzBez
    , a.KursDatum
    , a.GeldKurs
    , a.MittelKurs
    , a.BriefKurs
    , a.VerrechnungsKurs
UNION ALL
SELECT 
    'EUR' AS "S_Waehrung.ISO_KurzBez__from"
    , S_Waehrung.ISO_KurzBez AS "S_Waehrung.ISO_KurzBez__to"
    , a.KursDatum AS "S_TagesKurs.KursDatum__start"
    , COALESCE(
        MIN(b.KursDatum)
        , TO_DATE(TO_CHAR(ADD_MONTHS(CURDATE(), 1), 'YYYY-MM-01'), 'YYYY-MM-DD')
    ) AS "S_TagesKurs.KursDatum__end"
    , 1 / a.GeldKurs AS "S_TagesKurs.GeldKurs"
    , 1 / a.MittelKurs AS "S_TagesKurs.MittelKurs"
    , 1 / a.BriefKurs AS "S_TagesKurs.BriefKurs"
    , 1 / a.VerrechnungsKurs AS "S_TagesKurs.VerrechnungsKurs"
FROM 
    PUB.S_TagesKurs AS a
    LEFT JOIN PUB.S_TagesKurs AS b
        ON a.Waehrung = b.Waehrung
        AND a.KursDatum < b.KursDatum
    LEFT JOIN PUB.S_Waehrung
        ON a.Waehrung = S_Waehrung.Waehrung
GROUP BY 
    S_Waehrung.ISO_KurzBez
    , a.KursDatum
    , a.GeldKurs
    , a.MittelKurs
    , a.BriefKurs
    , a.VerrechnungsKurs
ORDER BY 
    "S_Waehrung.ISO_KurzBez__from"
    , "S_Waehrung.ISO_KurzBez__to"
    , "S_TagesKurs.KursDatum__start"