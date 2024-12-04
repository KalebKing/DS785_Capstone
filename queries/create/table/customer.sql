create table if not exists production.star."Customer" (
-- create or replace table production.star."Customer" (
      "Address Line 1" varchar(100) comment 'First line of street address'
    , "Address Line 2" varchar(100) comment 'Second line of street address'
    , "Address Line 3" varchar(100) comment 'Third line of street address'
    , "Address Line 4" varchar(100) comment 'Fourth line of street address'
    , "Annual Revenue" number comment 'Approximate revenue generated annually'
    , "Bauart 1" varchar(100) comment 'Business unit specific customer classification'
    , "Bauart 2" varchar(100) comment 'Business unit specific customer classification'
    , "Bauart 3" varchar(100) comment 'Business unit specific customer classification'
    , "Bauart 4" varchar(100) comment 'Business unit specific customer classification'
    , "Business Unit" varchar(50) comment 'Business unit to which the customer belongs'
    , "City" varchar(100) comment 'City where the customer''s located'
    , "Country (English)" varchar(100) comment 'Country where the customer''s located'
    , "Country (German)" varchar(100) comment 'Country where the customer''s located'
    , "Create Date" timestamp_ntz(9) comment 'Date when the original customer record was created'
    , "Credit Limit" number comment 'Maximum allowable credit'
    , "Credit Terms (English)" varchar(100) comment 'Terms of credit payment'
    , "Credit Terms (German)" varchar(100) comment 'Terms of credit payment'
    , "Currency" varchar(50) comment 'Preferred currency for transactions'
    , "Customer Number" number(38, 0) comment 'Unique identifier for customer'
    , "Effective Date" timestamp_ntz(9) comment 'Date when current version of customer record took effect'
    , "Fax Number" varchar(50) comment 'Primary contact number for communicating via fax'
    , "Industry (English)" varchar(150) comment 'Primary business sector or market segment the customer operates in'
    , "Industry (German)" varchar(150) comment 'Primary business sector or market segment the customer operates in'
    , "Key" number comment 'Unique identifier for current version of customer'
    , "Language" varchar(50) comment 'Preferred communication language'
    , "Latitude" number(38, 5) comment 'Geographic coordinate of north-south position on Earth''s surface'
    , "Longitude" number(38, 5) comment 'Geographic coordinate of east-west position on Earth''s surface'
    , "Name" varchar(255) comment 'Name of the customer'
    , "Number of Employees" number comment 'Approximate number of people employed by the customer'
    , "Parent Account" varchar(10) comment 'Superior or main account in the corporate hierarchy'
    , "Phone Number" varchar(50) comment 'Primary contact number for communicating via phone'
    , "Postal Code" varchar(10) comment 'Postal or ZIP code where the customer''s located'
    , "Salesperson" varchar(150) comment 'Assigned sales representative'
    , "SIC Code" varchar(4) comment 'Standard industrial classification code'
    , "Service Level" varchar(1) comment 'Priority level of service and support'
    , "State/Province" varchar(100) comment 'State or province where the customer''s located'
    , "Status" varchar(10) comment 'Identifies the customer as active or inactive'
    , "Tax ID" varchar(50) comment 'Official tax identification number'
    , "Tax ID Type" varchar(50) comment 'Category or classification of the tax ID'
    , "Type" varchar(100) comment 'Type of customer'
    , "Website" varchar(100) comment 'Customer''s website URL'
    , constraint "CustomerPK" primary key ("Customer Number")
)
    comment = 'Current version of records in the customer dimension'
;