
CREATE PROCEDURE importData1 
AS
-- declare @path varchar(200)
-- set @path = 'C:\Users\RV\OneDrive\Documents\SQL Server Management Studio\Test\Schools.csv'
BULK INSERT dbo.Schools
FROM 'C:\Users\RV\OneDrive\Documents\SQL Server Management Studio\Test\Schools.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
);

EXEC importData;
