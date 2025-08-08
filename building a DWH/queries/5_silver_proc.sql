-- BRONZE to SILVER




------------------------------------------
-- Table 1: crm_cust_info

IF OBJECT_ID ('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;
INSERT INTO silver.crm_cust_info (
    cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_material_status,
    cst_gndr,
    cst_create_date
)
SELECT 
    cst_id,
    cst_key,
    -- Trim unwanted spaces in string values
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,
    -- Data standarisation and consistency
    -- Capture gender values with user-friendly terms
    -- Including UPPER in case original values appear in lowercase
    CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
         WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
         ELSE 'Unknown'
    END AS cst_marital_status,
    -- Repeating CASE for gender.
    CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
         WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
         ELSE 'Unknown'
    END AS cst_gndr,
    cst_create_date
    -- Using window function to select the most recent entry.
    FROM (
        SELECT *,
            ROW_NUMBER() OVER (
                PARTITION BY cst_id 
                ORDER BY cst_create_date DESC
            ) as flag_last
        FROM bronze.crm_cust_info
    ) temp
    WHERE flag_last = 1;





------------------------------------------
-- Table 2: crm_prd_info

IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;
GO

CREATE TABLE silver.crm_prd_info (
    prd_id INT,
    cat_id NVARCHAR(50),
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(100),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

INSERT INTO silver.crm_prd_info (
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
SELECT
    prd_id,
    REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id, -- extract category ID
    SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key, -- extract product key
    prd_nm,
    ISNULL(prd_cost, 0) AS prd_cost,
    CASE UPPER(TRIM(prd_line))
        WHEN 'M' THEN 'Mountain'
        WHEN 'R' THEN 'Road'
        WHEN 'S' THEN 'Other Sales'
        WHEN 'T' THEN 'Touring'
        ELSE 'Unknown'
    END AS prd_line, -- map product lines to a more descriptive format
    prd_start_dt,
    CAST(
        DATEADD(DAY, -1,
            LEAD(prd_start_dt) OVER (
                PARTITION BY prd_key ORDER BY prd_start_dt
            )
        ) AS DATE
    ) AS prd_end_dt -- calculated end date as one day before the next start date
FROM bronze.crm_prd_info;
GO




------------------------------------------
-- Table 3: 

SELECT
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
FROM bronze.crm_sales_details;