create table if not exists production.star."Customer Quote History" (
-- create or replace table production.star."Customer Quote History" (
      "Alternate Line Flag" boolean comment 'Indicates if the line item is an alternate to another line item'
    , "Business Unit" varchar(50) comment 'Business unit to which the quote belongs'
    , "Carrier" varchar(150) comment 'Carrier used for shipping products to the customer'
    , "Create Date" timestamp_ntz(9) comment 'Date when the original quote was created'
    , "Credit Terms" varchar(100) comment 'Terms of credit payment for the quote'
    , "Currency" varchar(100) comment 'Currency in which the quote is denominated'
    , "Customer Key" number comment 'Unique identifier for the customer'
    , "Customer Number" number(38, 0) comment 'Unique identifier for customer'
    , "Customer SKU" varchar(100) comment 'Stock keeping unit assigned by the customer to the product'
    , "Effective Date" timestamp_ntz(9) comment 'Date when the quote took effect'
    , "Entered By" varchar(150) comment 'User who entered the quote'
    , "Expiration Date" date comment 'Date when the quote is no longer valid'
    , "Extended Cost" number(38,2) comment 'Total cost of the line item'
    , "Extended Fixed Overhead Cost" number(38,2) comment 'Total fixed overhead cost of the line item'
    , "Extended Labor Cost" number(38,2) comment 'Total labor cost of the line item'
    , "Extended Material Cost" number(38,2) comment 'Total material cost of the line item'
    , "Extended Price" number(38,2) comment 'Total price of the line item'
    , "Extended Variable Overhead Cost" number(38,2) comment 'Total variable overhead cost of the line item'
    , "Incoterms" varchar(150) comment 'Shipment and delivery responsibilities between the buyer and seller'
    , "Key" number comment 'Unique identifier for the quote'
    , "Language" varchar(25) comment 'Language in which the quote is written'
    , "Line Number" number(38, 1) comment 'Unique identifier of the specific line within the quote'
    , "Product Key" number comment 'Unique identifier for the product'
    , "Quantity" number(38, 3) comment 'Number of units quoted to the customer'
    , "Quote Date" date comment 'When the quote was provided to the customer'
    , "Quote Number" number(38, 0) comment 'Unique identifier of the quote'
    , "Reference Number" number(38, 0) comment 'Unique identifier for cross-referencing related documents'
    , "Salesperson" varchar(150) comment 'Assigned sales representative'
    , "Ship To Number" number(38, 0) comment 'Unique identifier of ship to associated with the quote'
    , "Ship To Key" number comment 'Unique identifier for the ship to'
    , "SKU" varchar(50) comment 'Stock keeping unit assigned by the company to the product'
    , "Status" varchar(10) comment 'Identifies the quote as active or inactive'
    , "Unit Cost" number(38,5) comment 'Cost per unit of the line item'
    , "Unit Fixed Overhead Cost" number(38,5) comment 'Fixed overhead cost per unit of the line item'
    , "Unit Labor Cost" number(38,5) comment 'Labor cost per unit of the line item'
    , "Unit Material Cost" number(38,5) comment 'Material cost per unit of the line item'
    , "Unit Price" number(38,5) comment 'Price per unit of the line item'
    , "Unit Variable Overhead Cost" number(38,5) comment 'Variable overhead cost per unit of the line item'
    , constraint "CustomerQuoteHistoryPK" primary key ("Key")
)
    comment = 'History of changes to customer quote records'
;