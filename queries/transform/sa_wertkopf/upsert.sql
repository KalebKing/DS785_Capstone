merge into production.helper."SA_WertKopf" using (
    select stg.$1 as "Firma"
        , stg.$2 as "WertKopf"
        , stg.$3 as "AuswArt"
        , stg.$4 as "Schluessel"
        , stg.$5 as "SetAusw"
        , stg.$6 as "Belegart"
        , stg.$7 as "KalkVariante"
        , stg.$8 as "VorKalk"
        , stg.$9 as "Variante"
        , stg.$10 as "KalkDatum"
        , stg.$11 as "Bwl"
        , stg.$12 as "PeriodenTyp"
        , stg.$13 as "BuchungsJahr"
        , stg.$14 as "BuchungsPeriode"
        , stg.$15 as "Losgroesse"
        , stg.$16 as "Prozess"
        , stg.$17 as "MatStan"
        , stg.$18 as "MatPlan"
        , stg.$19 as "StandVorKalk"
        , stg.$20 as "Menge_EinzelAnz"
        , stg.$21 as "VerkaufsKoA"
        , stg.$22 as "VerkaufsPreis"
        , stg.$23 as "VerdVariante"
        , stg.$24 as "PlVariante"
        , stg.$25 as "PlanRoll"
        , stg.$26 as "SBM_IncDriverGroup_ID"
        , stg.$27 as "BezugsDatum"
        , stg.$28 as "Gueltig"
        , stg.$29 as "VerSatzArt"
        , stg.$30 as "DatumVerSaetze"
        , stg.$31 as "VorKalkVariante"
        , stg.$32 as "NachKalkVariante"
        , stg.$33 as "SchluesselKen"
        , stg.$34 as "AwALNr"
        , stg.$35 as "AnlageBenutzer"
        , stg.$36 as "AnlageDatum"
        , stg.$37 as "AnlageZeit"
        , stg.$38 as "Eurokonvertierung"
        , stg.$39 as "SA_WertKopf_Obj"
        , stg.$40 as "Calc_BU_Benutzer_Obj"
        , stg.$41 as "CostItemStructure"
        , stg.$42 as "ObligationDate"
        , stg.$43 as "ProcessType"
        , stg.$44 as "MRPArea"
        , stg.$45 as "IndexNo"
        , stg.$46 as "HasChangedProcess"
        , stg.$47 as "AveragePriceCRO"
    from <<FILENAME>> as stg
) as bucket on production.helper."SA_WertKopf"."WertKopf" = bucket."WertKopf"
when matched and (
    ifnull("SA_WertKopf"."Firma", '') != ifnull(bucket."Firma", '')
    or ifnull("SA_WertKopf"."AuswArt", '') != ifnull(bucket."AuswArt", '')
    or ifnull("SA_WertKopf"."Schluessel", '') != ifnull(bucket."Schluessel", '')
    or ifnull("SA_WertKopf"."SetAusw", -1) != ifnull(bucket."SetAusw", -1)
    or ifnull("SA_WertKopf"."Belegart", '') != ifnull(bucket."Belegart", '')
    or ifnull("SA_WertKopf"."KalkVariante", -1) != ifnull(bucket."KalkVariante", -1)
    or ifnull("SA_WertKopf"."VorKalk", false) != ifnull(bucket."VorKalk", false)
    or ifnull("SA_WertKopf"."Variante", -1) != ifnull(bucket."Variante", -1)
    or ifnull("SA_WertKopf"."KalkDatum", '1970-01-01 00:00:00.000') != ifnull(bucket."KalkDatum", '1970-01-01 00:00:00.000')
    or ifnull("SA_WertKopf"."Bwl", false) != ifnull(bucket."Bwl", false)
    or ifnull("SA_WertKopf"."PeriodenTyp", -1) != ifnull(bucket."PeriodenTyp", -1)
    or ifnull("SA_WertKopf"."BuchungsJahr", -1) != ifnull(bucket."BuchungsJahr", -1)
    or ifnull("SA_WertKopf"."BuchungsPeriode", -1) != ifnull(bucket."BuchungsPeriode", -1)
    or ifnull("SA_WertKopf"."Losgroesse", -1) != ifnull(bucket."Losgroesse", -1)
    or ifnull("SA_WertKopf"."Prozess", '') != ifnull(bucket."Prozess", '')
    or ifnull("SA_WertKopf"."MatStan", -1) != ifnull(bucket."MatStan", -1)
    or ifnull("SA_WertKopf"."MatPlan", -1) != ifnull(bucket."MatPlan", -1)
    or ifnull("SA_WertKopf"."StandVorKalk", -1) != ifnull(bucket."StandVorKalk", -1)
    or ifnull("SA_WertKopf"."Menge_EinzelAnz", -1) != ifnull(bucket."Menge_EinzelAnz", -1)
    or ifnull("SA_WertKopf"."VerkaufsKoA", -1) != ifnull(bucket."VerkaufsKoA", -1)
    or ifnull("SA_WertKopf"."VerkaufsPreis", -1) != ifnull(bucket."VerkaufsPreis", -1)
    or ifnull("SA_WertKopf"."VerdVariante", -1) != ifnull(bucket."VerdVariante", -1)
    or ifnull("SA_WertKopf"."PlVariante", -1) != ifnull(bucket."PlVariante", -1)
    or ifnull("SA_WertKopf"."PlanRoll", false) != ifnull(bucket."PlanRoll", false)
    or ifnull("SA_WertKopf"."SBM_IncDriverGroup_ID", -1) != ifnull(bucket."SBM_IncDriverGroup_ID", -1)
    or ifnull("SA_WertKopf"."BezugsDatum", '1970-01-01 00:00:00.000') != ifnull(bucket."BezugsDatum", '1970-01-01 00:00:00.000')
    or ifnull("SA_WertKopf"."Gueltig", false) != ifnull(bucket."Gueltig", false)
    or ifnull("SA_WertKopf"."VerSatzArt", -1) != ifnull(bucket."VerSatzArt", -1)
    or ifnull("SA_WertKopf"."DatumVerSaetze", '1970-01-01 00:00:00.000') != ifnull(bucket."DatumVerSaetze", '1970-01-01 00:00:00.000')
    or ifnull("SA_WertKopf"."VorKalkVariante", -1) != ifnull(bucket."VorKalkVariante", -1)
    or ifnull("SA_WertKopf"."NachKalkVariante", -1) != ifnull(bucket."NachKalkVariante", -1)
    or ifnull("SA_WertKopf"."SchluesselKen", '') != ifnull(bucket."SchluesselKen", '')
    or ifnull("SA_WertKopf"."AwALNr", -1) != ifnull(bucket."AwALNr", -1)
    or ifnull("SA_WertKopf"."AnlageBenutzer", '') != ifnull(bucket."AnlageBenutzer", '')
    or ifnull("SA_WertKopf"."AnlageDatum", '1970-01-01') != ifnull(bucket."AnlageDatum", '1970-01-01')
    or ifnull("SA_WertKopf"."AnlageZeit", '00:00:00.000') != ifnull(bucket."AnlageZeit", '00:00:00.000')
    or ifnull("SA_WertKopf"."Eurokonvertierung", false) != ifnull(bucket."Eurokonvertierung", false)
    or ifnull("SA_WertKopf"."SA_WertKopf_Obj", '') != ifnull(bucket."SA_WertKopf_Obj", '')
    or ifnull("SA_WertKopf"."Calc_BU_Benutzer_Obj", '') != ifnull(bucket."Calc_BU_Benutzer_Obj", '')
    or ifnull("SA_WertKopf"."CostItemStructure", -1) != ifnull(bucket."CostItemStructure", -1)
    or ifnull("SA_WertKopf"."ObligationDate", '1970-01-01 00:00:00.000') != ifnull(bucket."ObligationDate", '1970-01-01 00:00:00.000')
    or ifnull("SA_WertKopf"."ProcessType", '') != ifnull(bucket."ProcessType", '')
    or ifnull("SA_WertKopf"."MRPArea", -1) != ifnull(bucket."MRPArea", -1)
    or ifnull("SA_WertKopf"."IndexNo", '') != ifnull(bucket."IndexNo", '')
    or ifnull("SA_WertKopf"."HasChangedProcess", false) != ifnull(bucket."HasChangedProcess", false)
    or ifnull("SA_WertKopf"."AveragePriceCRO", false) != ifnull(bucket."AveragePriceCRO", false)
) then update set
    "SA_WertKopf"."Firma" = bucket."Firma"
    , "SA_WertKopf"."AuswArt" = bucket."AuswArt"
    , "SA_WertKopf"."Schluessel" = bucket."Schluessel"
    , "SA_WertKopf"."SetAusw" = bucket."SetAusw"
    , "SA_WertKopf"."Belegart" = bucket."Belegart"
    , "SA_WertKopf"."KalkVariante" = bucket."KalkVariante"
    , "SA_WertKopf"."VorKalk" = bucket."VorKalk"
    , "SA_WertKopf"."Variante" = bucket."Variante"
    , "SA_WertKopf"."KalkDatum" = bucket."KalkDatum"
    , "SA_WertKopf"."Bwl" = bucket."Bwl"
    , "SA_WertKopf"."PeriodenTyp" = bucket."PeriodenTyp"
    , "SA_WertKopf"."BuchungsJahr" = bucket."BuchungsJahr"
    , "SA_WertKopf"."BuchungsPeriode" = bucket."BuchungsPeriode"
    , "SA_WertKopf"."Losgroesse" = bucket."Losgroesse"
    , "SA_WertKopf"."Prozess" = bucket."Prozess"
    , "SA_WertKopf"."MatStan" = bucket."MatStan"
    , "SA_WertKopf"."MatPlan" = bucket."MatPlan"
    , "SA_WertKopf"."StandVorKalk" = bucket."StandVorKalk"
    , "SA_WertKopf"."Menge_EinzelAnz" = bucket."Menge_EinzelAnz"
    , "SA_WertKopf"."VerkaufsKoA" = bucket."VerkaufsKoA"
    , "SA_WertKopf"."VerkaufsPreis" = bucket."VerkaufsPreis"
    , "SA_WertKopf"."VerdVariante" = bucket."VerdVariante"
    , "SA_WertKopf"."PlVariante" = bucket."PlVariante"
    , "SA_WertKopf"."PlanRoll" = bucket."PlanRoll"
    , "SA_WertKopf"."SBM_IncDriverGroup_ID" = bucket."SBM_IncDriverGroup_ID"
    , "SA_WertKopf"."BezugsDatum" = bucket."BezugsDatum"
    , "SA_WertKopf"."Gueltig" = bucket."Gueltig"
    , "SA_WertKopf"."VerSatzArt" = bucket."VerSatzArt"
    , "SA_WertKopf"."DatumVerSaetze" = bucket."DatumVerSaetze"
    , "SA_WertKopf"."VorKalkVariante" = bucket."VorKalkVariante"
    , "SA_WertKopf"."NachKalkVariante" = bucket."NachKalkVariante"
    , "SA_WertKopf"."SchluesselKen" = bucket."SchluesselKen"
    , "SA_WertKopf"."AwALNr" = bucket."AwALNr"
    , "SA_WertKopf"."AnlageBenutzer" = bucket."AnlageBenutzer"
    , "SA_WertKopf"."AnlageDatum" = bucket."AnlageDatum"
    , "SA_WertKopf"."AnlageZeit" = bucket."AnlageZeit"
    , "SA_WertKopf"."Eurokonvertierung" = bucket."Eurokonvertierung"
    , "SA_WertKopf"."SA_WertKopf_Obj" = bucket."SA_WertKopf_Obj"
    , "SA_WertKopf"."Calc_BU_Benutzer_Obj" = bucket."Calc_BU_Benutzer_Obj"
    , "SA_WertKopf"."CostItemStructure" = bucket."CostItemStructure"
    , "SA_WertKopf"."ObligationDate" = bucket."ObligationDate"
    , "SA_WertKopf"."ProcessType" = bucket."ProcessType"
    , "SA_WertKopf"."MRPArea" = bucket."MRPArea"
    , "SA_WertKopf"."IndexNo" = bucket."IndexNo"
    , "SA_WertKopf"."HasChangedProcess" = bucket."HasChangedProcess"
    , "SA_WertKopf"."AveragePriceCRO" = bucket."AveragePriceCRO"
when not matched then insert (
    "Firma"
    , "WertKopf"
    , "AuswArt"
    , "Schluessel"
    , "SetAusw"
    , "Belegart"
    , "KalkVariante"
    , "VorKalk"
    , "Variante"
    , "KalkDatum"
    , "Bwl"
    , "PeriodenTyp"
    , "BuchungsJahr"
    , "BuchungsPeriode"
    , "Losgroesse"
    , "Prozess"
    , "MatStan"
    , "MatPlan"
    , "StandVorKalk"
    , "Menge_EinzelAnz"
    , "VerkaufsKoA"
    , "VerkaufsPreis"
    , "VerdVariante"
    , "PlVariante"
    , "PlanRoll"
    , "SBM_IncDriverGroup_ID"
    , "BezugsDatum"
    , "Gueltig"
    , "VerSatzArt"
    , "DatumVerSaetze"
    , "VorKalkVariante"
    , "NachKalkVariante"
    , "SchluesselKen"
    , "AwALNr"
    , "AnlageBenutzer"
    , "AnlageDatum"
    , "AnlageZeit"
    , "Eurokonvertierung"
    , "SA_WertKopf_Obj"
    , "Calc_BU_Benutzer_Obj"
    , "CostItemStructure"
    , "ObligationDate"
    , "ProcessType"
    , "MRPArea"
    , "IndexNo"
    , "HasChangedProcess"
    , "AveragePriceCRO"
) values (
    bucket."Firma"
    , bucket."WertKopf"
    , bucket."AuswArt"
    , bucket."Schluessel"
    , bucket."SetAusw"
    , bucket."Belegart"
    , bucket."KalkVariante"
    , bucket."VorKalk"
    , bucket."Variante"
    , bucket."KalkDatum"
    , bucket."Bwl"
    , bucket."PeriodenTyp"
    , bucket."BuchungsJahr"
    , bucket."BuchungsPeriode"
    , bucket."Losgroesse"
    , bucket."Prozess"
    , bucket."MatStan"
    , bucket."MatPlan"
    , bucket."StandVorKalk"
    , bucket."Menge_EinzelAnz"
    , bucket."VerkaufsKoA"
    , bucket."VerkaufsPreis"
    , bucket."VerdVariante"
    , bucket."PlVariante"
    , bucket."PlanRoll"
    , bucket."SBM_IncDriverGroup_ID"
    , bucket."BezugsDatum"
    , bucket."Gueltig"
    , bucket."VerSatzArt"
    , bucket."DatumVerSaetze"
    , bucket."VorKalkVariante"
    , bucket."NachKalkVariante"
    , bucket."SchluesselKen"
    , bucket."AwALNr"
    , bucket."AnlageBenutzer"
    , bucket."AnlageDatum"
    , bucket."AnlageZeit"
    , bucket."Eurokonvertierung"
    , bucket."SA_WertKopf_Obj"
    , bucket."Calc_BU_Benutzer_Obj"
    , bucket."CostItemStructure"
    , bucket."ObligationDate"
    , bucket."ProcessType"
    , bucket."MRPArea"
    , bucket."IndexNo"
    , bucket."HasChangedProcess"
    , bucket."AveragePriceCRO"
);