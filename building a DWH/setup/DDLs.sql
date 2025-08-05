
USE DateWarehouse;
GO

CREATE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_material_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);

CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(2),
    prd_start_dt DATE,
    prd_end_dt DATE
);

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num NVARCHAR(16),
    sls_prd_key NVARCHAR(16),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

CREATE TABLE bronze.erp_cust_az12 (
    cst_cid NVARCHAR(50),
    cst_bdate DATE,
    cst_gen NVARCHAR(6)
);

CREATE TABLE bronze.erp_loc_a101 (
    loc_cid NVARCHAR(50),
    loc_cntry NVARCHAR(50)
);

CREATE TABLE bronze.erp_px_cat_g1v2 (
    px_id NVARCHAR(20),
    px_cat NVARCHAR(20),
    px_subcat NVARCHAR(30),
    px_maintenance NVARCHAR(8)
);



