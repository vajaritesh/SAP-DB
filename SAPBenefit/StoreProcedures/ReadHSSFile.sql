use dbDemo;

-- SELECT * FROM HSS.HSSRawData;



DECLARE @RowCount BIGINT = 0;
DECLARE @Line BIGINT = 0;
DECLARE @PayGroup char(3);
DECLARE @PayEndDt date;
DECLARE @EmplId char(11);
DECLARE @DependentBenef char(2);
DECLARE @PlanType char(2);
DECLARE @BenefitPlan char(6);
DECLARE @CoverageElect char(1);
DECLARE @CovrgCD char(2);

DECLARE @CoverageBeginDtStr char(10);
DECLARE @DeductionBeginDtStr char(10);
DECLARE @CoverageBeginDt date;
DECLARE @DeductionBeginDt date;

DECLARE @ZeroFillStr char(7);
DECLARE @ZeroFill int;

DECLARE @LastName char(30);
DECLARE @FirstName char(30);
DECLARE @NationalIdStr char(9);
DECLARE @NationalId int;

DECLARE 
	@HSSRecord varchar(1000)


SELECT @RowCount = COUNT(0) FROM HSS.HSSRawData;

DECLARE load_cursor CURSOR FOR 
    SELECT HSSRecord
    FROM HSS.HSSRawData
OPEN load_cursor 
FETCH NEXT FROM load_cursor INTO @HSSRecord

WHILE @@FETCH_STATUS = 0 
	BEGIN 
		--SELECT @Line;

		IF(@Line=@RowCount-1)					
			BREAK;		

		IF(@Line=0) 
			BEGIN
			--Fetch Header
				SET @PayGroup = SUBSTRING(@HSSRecord,1,3);
				SET @PayEndDt = SUBSTRING(@HSSRecord,4,11);
				-- SELECT @PayEndDt
			END
		ELSE
			BEGIN
				-- SELECT @HSSRecord;
				SET @EmplId = SUBSTRING(@HSSRecord,1,11);
				SET @DependentBenef = SUBSTRING(@HSSRecord,12,13);
				SET @PlanType = SUBSTRING(@HSSRecord,14,15);
				SET @BenefitPlan = SUBSTRING(@HSSRecord,16,21);
				SET @CoverageElect = SUBSTRING(@HSSRecord,22,22);
				SET @CovrgCD = SUBSTRING(@HSSRecord,23,24);
				
				SET @CoverageBeginDtStr = SUBSTRING(@HSSRecord,25,34);
				SET @CoverageBeginDt = CAST(@CoverageBeginDtStr AS date);
				SET @DeductionBeginDtStr = SUBSTRING(@HSSRecord,35,44);
				SET @DeductionBeginDt = CAST(@DeductionBeginDtStr AS date);

				SET @ZeroFillStr = SUBSTRING(@HSSRecord,45,51);
				SET @ZeroFill = CAST(@ZeroFillStr AS int);

				SET @LastName = SUBSTRING(@HSSRecord,52,81);
				SET @FirstName = SUBSTRING(@HSSRecord,82,111);
				
				SET @NationalIdStr = SUBSTRING(@HSSRecord,112,120);
				SET @NationalId = CAST(@NationalIdStr AS int);


				-- SELECT @EmplId, @DependentBenef, @PlanType, @BenefitPlan, @CoverageElect, @CovrgCD, @CoverageBeginDt, @DeductionBeginDt, @ZeroFill, @LastName, @FirstName, @NationalId;				
				-- select @Line;
				/**/
				INSERT INTO HSS.BiWeeklyHSS 
		(
			PayGroup, 
			PayEndDt, 
			EmplId, 
			DependentBenef, 
			PlanType, 
			BenefitPlan, 
			CoverageElect, 
			CovrgCD, 
			CoverageBeginDt, 
			DeductionBeginDt, 
			ZeroFill,
			LastName,
			FirstName,
			NationalId
		) 
		VALUES 
		(
			@PayGroup, 
			@PayEndDt, 
			@EmplId, 
			@DependentBenef, 
			@PlanType, 
			@BenefitPlan, 
			@CoverageElect, 
			@CovrgCD, 
			@CoverageBeginDt, 
			@DeductionBeginDt, 
			@ZeroFill,
			@LastName,
			@FirstName,
			@NationalId
		); 
		/**/
			END


		-- SET @HSSRecord = CHARINDEX(' ', @HSSRecord, 1) 
		-- SELECT SUBSTRING(@HSSRecord,1,3) AS PayCode
		--SELECT @PayCode

		SET @Line = @Line + 1;
		FETCH NEXT FROM load_cursor INTO @HSSRecord		
	END
CLOSE load_cursor 
DEALLOCATE load_cursor 
GO