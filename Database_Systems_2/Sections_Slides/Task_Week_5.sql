-- 1. Create a function which gives you the maximum of two integers. 

DROP FUNCTION IF EXISTS maxInt;
CREATE FUNCTION maxInt(@num1 int, @num2 int)
RETURNS INT
AS
begin;
  if(@num1 > @num2) RETURN @num1;
  RETURN @num2;
end;

select dbo.maxInt(10, 2) AS maxInt;

-- Suppose that we have two tables named as: 
--		a. Student(fname, studID, sex) 
--		b. Stud_Grade (studID, courseNo,CourseTitle, CrHr, Grade) 
-- Based on the values that could be populated to these tables create a function that returns the 
-- GPA of a student when you pass studID as an argument to the function. 

CREATE FUNCTION calculateGPA (@studID INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @totalQualityPoints FLOAT = 0;
    DECLARE @totalCreditHours FLOAT = 0;
    DECLARE @gpa FLOAT;

    -- Calculate total quality points and total credit hours
    SELECT 
        @totalQualityPoints = SUM(Grade * CrHr),
        @totalCreditHours = SUM(CrHr)
    FROM 
        Stud_Grade
    WHERE 
        studID = @studID;

    IF @totalCreditHours > 0
        SET @gpa = @totalQualityPoints / @totalCreditHours;
    ELSE
        SET @gpa = 0;

    RETURN @gpa;
END;

-- Question 3

-- 1. Scalar Function: Average Price of Books Published by Male Authors
CREATE FUNCTION avgPriceByMaleAuthors()
RETURNS FLOAT
AS
BEGIN
    DECLARE @avgPrice FLOAT;

    SELECT @avgPrice = AVG(b.Unit_Price)
    FROM Author a
    JOIN BookAuthor ba ON a.AuthorID = ba.AuthorID
    JOIN Book b ON ba.ISBN = b.ISBN
    WHERE a.Sex = 'M';

    RETURN @avgPrice;
END;
GO

-- 2. Scalar Function: Total Number of Female Authors Who Published Database Books by Jimma Publishers
CREATE FUNCTION femaleAuthorsForDatabaseByJimma()
RETURNS INT
AS
BEGIN
    DECLARE @total INT;

    SELECT @total = COUNT(DISTINCT a.AuthorID)
    FROM Author a
    JOIN BookAuthor ba ON a.AuthorID = ba.AuthorID
    JOIN Book b ON ba.ISBN = b.ISBN
    JOIN Publisher p ON b.PublisherID = p.PublisherID
    WHERE a.Sex = 'F'
      AND b.BookTitle = 'Database'
      AND p.City = 'Jimma';

    RETURN @total;
END;
GO

-- 3. Scalar Function: Total Number of Authors Who Published Books in the Past 10 Years by Publisher Name
CREATE FUNCTION authorsPublishedInLastTenYears(@publisherName NVARCHAR(255))
RETURNS INT
AS
BEGIN
    DECLARE @totalAuthors INT;

    SELECT @totalAuthors = COUNT(DISTINCT a.AuthorID)
    FROM Author a
    JOIN BookAuthor ba ON a.AuthorID = ba.AuthorID
    JOIN Book b ON ba.ISBN = b.ISBN
    JOIN Publisher p ON b.PublisherID = p.PublisherID
    WHERE p.Publisher_name = @publisherName
      AND b.Year >= YEAR(GETDATE()) - 10;

    RETURN @totalAuthors;
END;
GO

-- 4. Inline Table-Valued Function: List of All Authors Who Published Java Books
CREATE FUNCTION javaBookAuthors()
RETURNS TABLE
AS
RETURN
(
    SELECT a.AuthorID, a.Fname, a.Sex, a.Qualification
    FROM Author a
    JOIN BookAuthor ba ON a.AuthorID = ba.AuthorID
    JOIN Book b ON ba.ISBN = b.ISBN
    WHERE b.BookTitle = 'Java'
);
GO

-- 5. Multi-Statement Table-Valued Function: Find ID, Name, and Sex of All Authors Who Published Books
CREATE FUNCTION authorsWithPublishedBooks()
RETURNS @authorDetails TABLE
(
    AuthorID INT,
    Fname NVARCHAR(255),
    Sex CHAR(1)
)
AS
BEGIN
    INSERT INTO @authorDetails
    SELECT DISTINCT a.AuthorID, a.Fname, a.Sex
    FROM Author a
    JOIN BookAuthor ba ON a.AuthorID = ba.AuthorID;

    RETURN;
END;
GO

-- 5. Scalar Function: Total Number of Books Published by Female Authors
CREATE FUNCTION booksByFemaleAuthors()
RETURNS INT
AS
BEGIN
    DECLARE @totalBooks INT;

    SELECT @totalBooks = COUNT(*)
    FROM authorsWithPublishedBooks()
    WHERE Sex = 'F';

    RETURN @totalBooks;
END;
GO
