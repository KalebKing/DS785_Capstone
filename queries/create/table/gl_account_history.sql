create table if not exists production.star."GL Account History"(
-- create or replace table production.star."GL Account History" (
    "Account" number(38, 0) comment 'Unique identifier for GL account',
    "Business Unit" varchar(50) comment 'Business unit to which the GL account belongs',
    "Create Date" timestamp_ntz(9) comment 'Date when the original GL account record was created',
    "Currency" varchar(50) comment 'Default currency of the GL account',
    "Current Record" boolean comment 'Indicates if the record is the most recent and active entry for the GL account',
    "Effective Date" timestamp_ntz(9) comment 'Date when this version of GL account record took effect',
    "Expiration Date" timestamp_ntz(9) comment 'Date when this version of Gl account record was replaced with a newer version',
    "Key" number(38, 0) comment 'Unique identifier for this version of GL account',
    "Name (English)" varchar(150) comment 'Name of the GL account',
    "Name (German)" varchar(150) comment 'Name of the GL account',
    "Type" varchar(25) comment 'Identifies the account as balance sheet or income statement',
    constraint "GLAccountHistoryPK" primary key ("Key")
)
    comment = 'History of changes to records in the GL account dimension'
;