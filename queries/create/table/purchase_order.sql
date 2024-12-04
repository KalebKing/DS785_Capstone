create table if not exists production.star."Purchase Order" (
-- create or replace table production.star."Purchase Order" (
      "Business Unit" varchar(50) comment 'Business unit to which the purchase order belongs'
    , "Carrier" varchar(50) comment 'Carrier used for shipping products'
    , "Create Date" timestamp_ntz(9) comment 'Date when the original purchase order was created'
    , "Credit Terms" varchar(100) comment 'Terms of credit payment for the purchase order'
    , "Currency" varchar(100) comment 'Currency in which the purchase order is denominated'
    , "Due Date" date comment 'Date when we expect to receive the product'
    , "Effective Date" timestamp_ntz(9) comment 'Date when the order took effect'
    , "Extended Price" number(38, 2) comment 'Total price of the line item'
    , "Incoterms" varchar(50) comment 'Shipment and delivery responsibilities between the buyer and seller'
    , "Language" varchar(25) comment 'Language in which the purchase order is written'
    , "Last Received Date" date comment 'Date when the last shipment was received'
    , "Line Number" number(38, 1) comment 'Unique identifier of the specific line within the purchase order'
    , "Order Date" date comment 'Date when the purchase order was placed'
    , "Order Number" number(10, 0) comment 'Unique identifier of the purchase order'
    , "Quantity Ordered" number(38, 3) comment 'Number of units ordered'
    , "Quantity Received" number(38, 3) comment 'Number of units received'
    , "Reference Number" number(10, 0) comment 'Unique identifier for cross-referencing related documents'
    , "SKU" varchar(50) comment 'Stock keeping unit assigned by the company to the product'
    , "Status" varchar(10) comment 'Identifies the purchase order as active or inactive'
    , "Unit Price" number(38, 5) comment 'Price per unit of the line item'
    , "Vendor Number" number(38, 0) comment 'Unique identifier for vendor'
    , constraint "PurchaseOrderPK" primary key ("Order Number", "Line Number")
)
    comment = 'Current version of purchase order records'
;