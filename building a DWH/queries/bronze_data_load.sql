CREATE OR ALTER PROCEDURE dbo.load_bronze AS 
BEGIN
    PRINT '====================================';
    PRINT 'Loading data into bronze layer...';
    PRINT '====================================';

    PRINT '------------------------------------';
    PRINT 'Loading CRM tables ...';
    PRINT '------------------------------------';
    -- Prep the table for first load by making sure it is empty, or if previously loaded, avoid a duplication error
    TRUNCATE TABLE bronze.crm_cust_info;
    -- load the data from file
    BULK INSERT bronze.crm_cust_info
    FROM 'C:\Users\Bagheera\My Drive\07 DataEng\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
    -- below is we where provide the specification for the upload
    WITH (
        FIRSTROW = 2, -- skip header row
        FIELDTERMINATOR = ',', -- specify the field delimiter
        TABLOCK
    );

    TRUNCATE TABLE bronze.crm_prd_info;
    BULK INSERT bronze.crm_prd_info
    FROM 'C:\Users\Bagheera\My Drive\07 DataEng\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
    -- below is we where provide the specification for the upload
    WITH (
        FIRSTROW = 2, -- skip header row
        FIELDTERMINATOR = ',', -- specify the field delimiter
        TABLOCK
    );

    TRUNCATE TABLE bronze.crm_sales_details;
    BULK INSERT bronze.crm_sales_details
    FROM 'C:\Users\Bagheera\My Drive\07 DataEng\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
    -- below is we where provide the specification for the upload
    WITH (
        FIRSTROW = 2, -- skip header row
        FIELDTERMINATOR = ',', -- specify the field delimiter
        TABLOCK
    );

    PRINT '------------------------------------';
    PRINT 'Loading ERP tables ...';
    PRINT '------------------------------------';
    TRUNCATE TABLE bronze.erp_cust_az12;
    BULK INSERT bronze.erp_cust_az12
    FROM 'C:\Users\Bagheera\My Drive\07 DataEng\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
    -- below is we where provide the specification for the upload
    WITH (
        FIRSTROW = 2, -- skip header row
        FIELDTERMINATOR = ',', -- specify the field delimiter
        TABLOCK
    );

    TRUNCATE TABLE bronze.erp_loc_a101;
    BULK INSERT bronze.erp_loc_a101
    FROM 'C:\Users\Bagheera\My Drive\07 DataEng\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
    -- below is we where provide the specification for the upload
    WITH (
        FIRSTROW = 2, -- skip header row
        FIELDTERMINATOR = ',', -- specify the field delimiter
        TABLOCK
    );

    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    BULK INSERT bronze.erp_px_cat_g1v2
    FROM 'C:\Users\Bagheera\My Drive\07 DataEng\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
    -- below is we where provide the specification for the upload
    WITH (
        FIRSTROW = 2, -- skip header row
        FIELDTERMINATOR = ',', -- specify the field delimiter
        TABLOCK
    );
END
