create table if not exists production.star."Vendor" (
-- create or replace table production.star."Vendor" (
    "Address Line 1" varchar(50) comment 'First line of street address',
    "Address Line 2" varchar(50) comment 'Second line of street address',
    "Address Line 3" varchar(50) comment 'Third line of street address',
    "Address Line 4" varchar(50) comment 'Fourth line of street address',
    "Business Unit" varchar(50) comment 'Business unit to which the vendor belongs',
    "City" varchar(50) comment 'City where the vendor''s located',
    "Country (English)" varchar(50) comment 'Country where the vendor''s located',
    "Country (German)" varchar(50) comment 'Country where the vendor''s located',
    "Create Date" timestamp_ntz(9) comment 'Date when the original vendor record was created',
    "Credit Terms (English)" varchar(50) comment 'Terms of credit payment',
    "Credit Terms (German)" varchar(50) comment 'Terms of credit payment',
    "Currency" varchar(50) comment 'Preferred currency for transactions',
    "Effective Date" timestamp_ntz(9) comment 'Date when current version of vendor record took effect',
    "Fax Number" varchar(50) comment 'Primary contact number for communicating via fax',
    "Key" number comment 'Unique identifier for current version of vendor',
    "Language" varchar(50) comment 'Preferred communication language',
    "Latitude" number(38,5) comment 'Geographic coordinate of north-south position on Earth''s surface',
    "Longitude" number(38,5) comment 'Geographic coordinate of east-west position on Earth''s surface',
    "Name" varchar(255) comment 'Name of the vendor',
    "Phone Number" varchar(50) comment 'Primary contact number for communicating via phone',
    "Postal Code" varchar(10) comment 'Postal or ZIP code where the vendor''s located',
    "State/Province" varchar(50) comment 'State or province where the vendor''s located',
    "Status" varchar(10) comment 'Identifies the vendor as active or inactive',
    "Tax ID" varchar(50) comment 'Official tax identification number',
    "Tax ID Type" varchar(50) comment 'Category or classification of the tax ID',
    "Type" varchar(50) comment 'Type of vendor',
    "Vendor Number" number(38, 0) comment 'Unique identifier for vendor',
    constraint "VendorPK" primary key ("Vendor Number")
)
    comment = 'Current version of records in the vendor dimension'
;