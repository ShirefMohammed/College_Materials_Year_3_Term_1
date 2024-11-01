-- Declaring variables --
-- ======================

DECLARE @CountNumber INT;
SET @CountNumber = 10;
SELECT @CountNumber AS 'Count Number';

DECLARE @AllStudentsNumber INT;
SELECT @AllStudentsNumber = (SELECT COUNT(*) FROM students);
SELECT @AllStudentsNumber AS 'All Students Number';

-- If Condition
-- ============

DECLARE @msg varchar(25);
SET @msg = 'OK';

IF @msg = 'OK' print 'OK';
ELSE IF @msg = 'Not OK' print 'Not OK';
ELSE print '...';

if (db_name() = 'CollageSystem')  
	begin;
		Print 'We are in the CollageSystem Database';
		Print '';
		Print 'So whatever code you execute must be done carefully';
	End;
else if (db_name() = 'master') 
	begin;
		Print 'We are in the test master’ database';
		Print 'So Enjoy';
	End;

-- For Loop
-- ========

DECLARE @counter INT;
SET @counter = 1;

WHILE (@counter <= 5) 
	BEGIN;
		PRINT @counter; 
		SET @counter = @counter + 1;
		IF (@counter = 4) break; 
	END;

SET @counter = 1;

WHILE (@counter <=5) 
	BEGIN;
		IF (@counter = 3) 
			BEGIN;
				SET @counter = @counter + 1;
				continue; 
			END;
		PRINT @counter; 
		SET @counter = @counter + 1;
	END;

-- Case When
-- =========

DECLARE @name NVARCHAR(50);
SET @name = 'Mohammed';

SELECT CASE 
    WHEN @name = 'Mohammed' THEN 'Mohammed'
    WHEN @name = 'Shiref' THEN 'Shiref'
    ELSE 'Unknown'
END AS OutputName;

-- Functions
-- =========

DROP FUNCTION IF EXISTS netPay;
CREATE FUNCTION netPay(@sal FLOAT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @np FLOAT;

    IF @sal <= 150 
        SET @np = @sal;
    ELSE IF @sal < 650 
        SET @np = @sal - 0.10 * @sal;
    ELSE IF @sal < 1400 
        SET @np = @sal - (50 + 0.15 * (@sal - 650));
    ELSE IF @sal < 2350 
        SET @np = @sal - (162.50 + 0.20 * (@sal - 1400));
    ELSE IF @sal < 3500 
        SET @np = @sal - (352.50 + 0.25 * (@sal - 2350));
    ELSE IF @sal < 5000 
        SET @np = @sal - (640 + 0.30 * (@sal - 3500));
    ELSE 
        SET @np = @sal - (1090 + 0.35 * (@sal - 5000));

    RETURN @np;
END;

SELECT dbo.netPay(100) AS NetSalary;
