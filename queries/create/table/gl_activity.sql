create table if not exists production.star."GL Activity"(
-- create or replace table production.star."GL Activity" (
    "Account" number(38, 0) comment 'Unique identifier for GL account',
    "Amount" number(38, 2) comment 'Amount of the transaction',
    "Business Unit" varchar(50) comment 'Business unit to which the GL account belongs',
    "Closing Entry Flag" boolean comment 'Indicates if the record is a closing entry',
    "Cost Center" number(38, 0) comment 'Cost center to which the GL account belongs',
    "Currency" varchar(50) comment 'Default currency of the GL account',
    "Customer Invoice" number(38, 0) comment 'Customer invoice number',
    "Customer Invoice Key" number(38, 0) comment 'Unique identifier for customer invoice',
    "Customer Invoice Line" number(38, 1) comment 'Line number of the customer invoice',
    "Customer Key" number(38, 0) comment 'Unique identifier for customer',
    "Customer Number" number(38, 0) comment 'Customer account number',
    "Customer Order" number(38, 0) comment 'Customer order number',
    "Customer Order Line" number(38, 1) comment 'Line number of the customer order',
    "Effective Date" date comment 'Date of the transaction',
    "Entry ID" varchar(120) comment 'Unique identifier for both sides of an entry',
    "Key" number(38, 0) comment 'Unique identifier for the record',
    "Product Key" number(38, 0) comment 'Unique identifier for product',
    "Ship To Key" number(38, 0) comment 'Unique identifier for ship to',
    "Ship To Number" number(38, 0) comment 'Ship to account number',
    "SKU" varchar(50) comment 'Stock keeping unit',
    "Transaction Number" number(38, 0) comment 'Number of the transaction',
    "Vendor Key" number(38, 0) comment 'Unique identifier for vendor',
    "Vendor Number" number(38, 0) comment 'Vendor account number',
    constraint "GLActivityPK" primary key ("Key")
)
    comment = 'GL activity records'
;