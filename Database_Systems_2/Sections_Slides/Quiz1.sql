-- Craete The Database
CREATE DATABASE Library_Management_System;

-- Create Tables
CREATE TABLE Books (
    id bigint PRIMARY KEY IDENTITY,
    title varchar(100) NOT NULL,
    author varchar(100) NOT NULL,
	publicationYear bigint NOT NULL,
	genre varchar(50) NOT NULL,
);

-- Insert some date in Books
INSERT INTO Books(title, author, publicationYear, genre)
VALUES ('title 1', 'author 1', 2004, 'any'),
       ('title 2', 'author 2', 2004, 'any'),
       ('title 3', 'author 3', 2004, 'any'),
       ('title 4', 'author 4', 2004, 'any');

CREATE TABLE Borrowers (
    id bigint PRIMARY KEY IDENTITY,
    name varchar(100) NOT NULL,
    contactNumber varchar(20) NOT NULL,
	borrowDate date NOT NULL,
	dueDate date NOT NULL,
	bookID bigint NOT NULL,
	CONSTRAINT Borrowers_Books_FK  FOREIGN KEY (bookID) REFERENCES Books(id)
);

-- Make Stored Procedure to insert a new borrower record
CREATE PROCEDURE insertNewBorrower(@name varchar(100), @contactNumber varchar(20), @bookID bigint)
AS
INSERT INTO Borrowers(name, contactNumber, bookID, borrowDate, dueDate)
VALUES (@name, @contactNumber, @bookID, GETDATE(), DATEADD(DAY, 7, GETDATE()));

-- Test insertNewBorrower
EXEC dbo.insertNewBorrower('Mohammed', '089', 1);

-- Make a function to return a table with not borrowed books
CREATE FUNCTION returnNotBorrowed()
RETURNS TABLE
AS
return SELECT * FROM Books WHERE id NOT IN (SELECT DISTINCT bookID FROM Borrowers)

SELECT * dbo.returnNotBorrowed();
SELECT * FROM Books;