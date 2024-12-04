create table if not exists production.star."GL Account"(
-- create or replace table production.star."GL Account" (
    "Account" number(38, 0) comment 'Unique identifier for GL account',
    "Business Unit" varchar(50) comment 'Business unit to which the GL account belongs',
    "Create Date" timestamp_ntz(9) comment 'Date when the original GL account record was created',
    "Currency" varchar(50) comment 'Default currency of the GL account',
    "Effective Date" timestamp_ntz(9) comment 'Date when current version of GL account record took effect',
    "Key" number(38, 0) comment 'Unique identifier for current version of GL account',
    "Name (English)" varchar(150) comment 'Name of the GL account',
    "Name (German)" varchar(150) comment 'Name of the GL account in German',
    "Type" varchar(50) comment 'Identifies the account as an asset, liability, equity, revenue, or expense',
    constraint "GLAccountPK" primary key ("Account")
)
    comment = 'Current version of records in the GL account dimension'
;