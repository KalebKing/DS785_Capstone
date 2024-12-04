create table if not exists production.helper."SA_WertKopf" (
-- create or replace table production.helper."SA_WertKopf" (
    "Firma" varchar(20)
    , "WertKopf" number(10, 0)
    , "AuswArt" varchar(6)
    , "Schluessel" varchar(60)
    , "SetAusw" number(10, 0)
    , "Belegart" varchar(6)
    , "KalkVariante" number(10, 0)
    , "VorKalk" boolean
    , "Variante" number(10, 0)
    , "KalkDatum" timestamp_ntz(9)
    , "Bwl" boolean
    , "PeriodenTyp" number(10, 0)
    , "BuchungsJahr" number(16, 1)
    , "BuchungsPeriode" number(10, 0)
    , "Losgroesse" number(18, 3)
    , "Prozess" varchar(40)
    , "MatStan" number(10, 0)
    , "MatPlan" number(10, 0)
    , "StandVorKalk" number(10, 0)
    , "Menge_EinzelAnz" number(10, 0)
    , "VerkaufsKoA" number(10, 0)
    , "VerkaufsPreis" number(17, 2)
    , "VerdVariante" number(10, 0)
    , "PlVariante" number(10, 0)
    , "PlanRoll" boolean
    , "SBM_IncDriverGroup_ID" number(10, 0)
    , "BezugsDatum" timestamp_ntz(9)
    , "Gueltig" boolean
    , "VerSatzArt" number(10, 0)
    , "DatumVerSaetze" timestamp_ntz(9)
    , "VorKalkVariante" number(10, 0)
    , "NachKalkVariante" number(10, 0)
    , "SchluesselKen" varchar(60)
    , "AwALNr" number(10, 0)
    , "AnlageBenutzer" varchar(24)
    , "AnlageDatum" date
    , "AnlageZeit" time(9)
    , "Eurokonvertierung" boolean
    , "SA_WertKopf_Obj" varchar(120)
    , "Calc_BU_Benutzer_Obj" varchar(120)
    , "CostItemStructure" number(10, 0)
    , "ObligationDate" timestamp_ntz(9)
    , "ProcessType" varchar(40)
    , "MRPArea" number(10, 0)
    , "IndexNo" varchar(6)
    , "HasChangedProcess" boolean
    , "AveragePriceCRO" boolean
);