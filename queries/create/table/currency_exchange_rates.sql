create table if not exists production.helper."Currency Exchange Rates" (
-- create or replace table production.helper."Currency Exchange Rates" (
      "From Currency" varchar(6) comment 'Currency from which the exchange rate is being converted'
    , "To Currency" varchar(6) comment 'Currency to which the exchange rate is being converted'
    , "Effective Date" timestamp_ntz(9) comment 'Date when the exchange rate took effect'
    , "Expiration Date" timestamp_ntz(9) comment 'Date when the exchange rate expires'
    , "Buying Price" number(25, 10) comment 'Exchange rate at which buyers are willing to purchase securities, goods, services, etc.'
    , "Selling Price" number(25, 10) comment 'Exchange rate at which sellers are willing to sell securities, goods, services, etc.'
    , "Midpoint" number(25, 10) comment 'Average value of buying price and selling price'
    , "Clearing Price" number(25, 10) comment 'Fixed rate that is used within a company group to convert foreign currencies.'
);