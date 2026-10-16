-- Step 1: DW - Create star schema table
.read 01_create_tables_dw.sql

-- Step 2: DW - Load data from CSV files into tables
.read 02_load_schema_dw.sql
