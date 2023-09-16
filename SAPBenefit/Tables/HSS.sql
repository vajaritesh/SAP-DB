use dbDemo;

CREATE SCHEMA HSS;

Create table HSS.BiWeeklyHSS (
		PayGroup char(3),
		PayEndDt Date,
		EmplId char(11),
		DependentBenef char(2),
		PlanType char(2),
		BenefitPlan char(6),
		CoverageElect char(1),
		CovrgCD char(2),
		CoverageBeginDt date,
		DeductionBeginDt date,
		ZeroFill int,
		LastName char(30),
		FirstName char(30),
		NationalId int,
		BenefitProgram char(3),
		BenStatus char(4),
		Birthdate date,
		Sex int,
		Relationship char(2),
		DtOfDeath date,
		Student char(1),
		IsDisabled char(1),
		SpaceFill char(14),
		Address1 char(35),
		Address2 char(35),
		City char(30),
		StateName char(6),
		Postal int,
		Country char(3),
		Address1Other char(35),
		Address2Other char(35),
		CityOther char(30),
		StateOther char(6),
		PostalOther int,
		CountryOther char(3),
		RateTblId char(6),
		JobCode char(6),
		FullPartTime char(1),
		UnionCD char(3),
		EmplClass char(3),
		TrailerId char(3),
		TrailerRcdCnt int
);

DECLARE @RowCount BIGINT = 0;
SELECT COUNT(0) FROM HSS.HSSRawData;
SELECT @RowCount;

 
truncate table HSS.BiWeeklyHSS;

Create table HSS.HSSRawData (	
	HSSRecord text
);

select * from HSS.HSSRawData;

BULK INSERT HSS.HSSRawData FROM 'C:\Users\RV\Downloads\usdenrb_20230912_20230911220040.txt'
WITH
(
ROWTERMINATOR = '\n'
)
GO

truncate table HSS.HSSRawData;


select * from HSS.HSSRawData;

DECLARE @CursorTestID INT = 1;
DECLARE @RunningTotal BIGINT = 0;
DECLARE @RowCnt BIGINT = 0;
SELECT @RowCnt = COUNT(0) FROM HSS.HSSRawData;
WHILE @CursorTestID <= @RowCnt
BEGIN
   -- SELECT HSS.HSSRawData  
   Select @CursorTestID
   -- SET RunningTotal = @RunningTotal  + @CursorTestID WHERE CursorTestID = @CursorTestID;
   -- SET @RunningTotal += @CursorTestID    
   SET @CursorTestID = @CursorTestID + 1 
END




BULK INSERT dbo.Schools
FROM 'C:\Users\RV\OneDrive\Documents\SQL Server Management Studio\Test\Schools.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2
);
