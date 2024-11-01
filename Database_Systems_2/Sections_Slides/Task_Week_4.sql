-- 1. Use if …Else statement and write T-SQL program to convert Letter grades into 
--    their corresponding Number grades.

DECLARE @LetterGrade varchar(25);
SET @LetterGrade = 'A';

IF (@LetterGrade = 'A') SELECT 'Your degree between 0 and 50' AS 'Number grades';
ELSE IF (@LetterGrade = 'B') SELECT 'Your degree between 50 and 75' AS 'Number grades';
ELSE IF (@LetterGrade = 'C') SELECT 'Your degree between 75 and 100' AS 'Number grades';


-- 2. Use while… loop and write T-SQL program to find the factorial of a number

DECLARE @num decimal;
SET @num = 5;

DECLARE @numFactorial decimal;
SET @numFactorial = 1;

WHILE (@num > 1) 
	BEGIN;
		SET @numFactorial = @numFactorial * @num;
		SET @num = @num - 1;
	END;
	
SELECT @numFactorial AS 'Factorial of 5';

-- 3. Use CASE……When and classify the payment category of employees as follows: 
--    a. For salary >= 8000………..High paid 
--    b. For salary >= 4000………..Midium paid 
--    c. For salary < 400…………...Low paid

DECLARE @salary decimal;
SET @salary = 8000;

SELECT CASE 
    WHEN @salary >= 8000 THEN 'High paid'
    WHEN @salary >= 4000 THEN 'Midium paid'
    WHEN @salary < 400   THEN 'Low paid'
END AS 'payment category';
