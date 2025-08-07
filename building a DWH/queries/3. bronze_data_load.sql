CREATE OR ALTER PROCEDURE dbo.load_bronze AS 
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '====================================';
        PRINT 'Loading data into bronze layer...';
        PRINT '====================================';
        PRINT '------------------------------------';
        PRINT 'Loading CRM tables ...';
        PRINT '------------------------------------';
        SET @start_time = GETDATE()
        PRINT '>> Truncating table: bronze.crm_cust_info';
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
        SET @end_time = GETDATE()
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';

        SET @start_time = GETDATE()
        PRINT '>> Truncating table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\Bagheera\My Drive\07 DataEng\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',', 
            TABLOCK
        );
        SET @end_time = GETDATE()
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';

        SET @start_time = GETDATE()
        PRINT '>> Truncating table: bronze.sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\Bagheera\My Drive\07 DataEng\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',', 
            TABLOCK
        );
        SET @end_time = GETDATE()
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';

        PRINT '------------------------------------';
        PRINT 'Loading ERP tables ...';
        PRINT '------------------------------------';
        SET @start_time = GETDATE()
        PRINT '>> Truncating table: bronze.cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\Bagheera\My Drive\07 DataEng\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',', 
            TABLOCK
        );
        SET @end_time = GETDATE()
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        SET @start_time = GETDATE()
        PRINT '>> Truncating table: bronze.loc_101';
        TRUNCATE TABLE bronze.erp_loc_a101;
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\Bagheera\My Drive\07 DataEng\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',', 
            TABLOCK
        );
        SET @end_time = GETDATE()
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        SET @start_time = GETDATE()
        PRINT '>> Truncating table: px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\Bagheera\My Drive\07 DataEng\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE()
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        
        SET @batch_end_time = GETDATE();
        PRINT '====================================';
        PRINT 'Data loaded into bronze layer successfully.';
        PRINT 'Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '====================================';
    END TRY
    BEGIN CATCH
        PRINT '====================================';
        PRINT 'Error occurred while loading data into Bronze layer:';
        PRINT 'Error Message ' + ERROR_MESSAGE();
        PRINT 'Error Message ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));     
        PRINT 'Error Message ' + CAST(ERROR_STATE() AS NVARCHAR(10));  
        PRINT '====================================';
    END CATCH
END
GO

EXEC dbo.load_bronze;

