



USE master; -- in order to create the database at the topmost level 
GO

-- drop and recreate the 'DataWarehouse' database

IF EXISTS (SELECT 1 from sys.dabases WHERE name = 'DataWarehouse')
BEGIN 
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;

GO

CREATE DATABASE DataWareHouse;

USE DataWarehouse;

-- the following is the code for creating the schema 

CREATE SCHEMA bronze; 
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
