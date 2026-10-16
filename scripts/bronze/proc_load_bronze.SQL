--Truncate clears the whole table before doing the BULK INSERT 
--TABLOCK is for performance optimization to lock the table during loading 

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 

BEGIN
	
	BEGIN TRY 
		PRINT '===============================';
		PRINT 'Load Bronze Layer';
		PRINT '===============================';
		PRINT '-------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-------------------------------';

		DECLARE @start_time DATETIME, @end_time DATETIME;

		SET @start_time= GETDATE();

		PRINT '>> Truncating Table: bronze.crm_cust_info';
		PRINT '>> Inserting Data into bronze.crm.cust_info';
	
		TRUNCATE TABLE bronze.crm_cust_info;
	
		BULK INSERT bronze.crm_cust_info

		FROM 'C:\Users\My PC\Downloads\SQL Journey\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2, 
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		
		SET @end_time= GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds 
		';

		PRINT '>> Truncating Table: bronze.crm_prd_info';
		PRINT '>> Inserting Data into bronze.crm_prd_info';

		TRUNCATE TABLE bronze.crm_prd_info;

		BULK INSERT bronze.crm_prd_info

		FROM 'C:\Users\My PC\Downloads\SQL Journey\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2, 
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '>> Truncating Table: bronze.crm_sales_details';
		PRINT '>> Inserting Data into bronze.crm_sales_details';

		TRUNCATE TABLE bronze.crm_sales_details;

		BULK INSERT bronze.crm_sales_details

		FROM 'C:\Users\My PC\Downloads\SQL Journey\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2, 
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '-------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-------------------------------';

		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		PRINT '>> Inserting Data into bronze.erp_cust_az12';

		TRUNCATE TABLE bronze.erp_cust_az12;

		BULK INSERT bronze.erp_cust_az12

		FROM 'C:\Users\My PC\Downloads\SQL Journey\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2, 
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		PRINT '>> Inserting Data into bronze.erp_loc_a101';

		TRUNCATE TABLE bronze.erp_loc_a101;

		BULK INSERT bronze.erp_loc_a101

		FROM 'C:\Users\My PC\Downloads\SQL Journey\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2, 
			FIELDTERMINATOR = ',',
			TABLOCK
		);


		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		PRINT '>> Inserting Data into bronze.erp_px_cat_g1v2';

		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		BULK INSERT bronze.erp_px_cat_g1v2

		FROM 'C:\Users\My PC\Downloads\SQL Journey\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2, 
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		END TRY 
		BEGIN CATCH 
			PRINT '===============================';
			PRINT 'ERROR OCCURED DURING LOADING THE BRONZE LAYER';
			PRINT 'Error Message' + ERROR_MESSAGE();
			PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT '===============================';
		END CATCH

END 
