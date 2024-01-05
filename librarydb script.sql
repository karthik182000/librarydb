create DATABASE LibraryDB;

USE LibraryDB;

/*creating books table*/

CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    Genre VARCHAR(50),
    ISBN VARCHAR(20)
	
);

ALTER TABLE Books
ADD CONSTRAINT fk_AuthorID
FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID);


/*creating Auhtors table*/
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    AuthorName VARCHAR(100),
    Birthdate DATE,
    Country VARCHAR(50)
);

/*creating Borowwers table*/
CREATE TABLE Borrowers (
    BorrowerID INT AUTO_INCREMENT PRIMARY KEY,
    BorrowerName VARCHAR(100),
    Email VARCHAR(100),
    Address VARCHAR(255)
);

CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    BorrowerID INT,
    DateBorrowed DATE,
    DateReturned DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
);


INSERT INTO Authors (AuthorName, Birthdate, Country) 
VALUES 
  ('J.K. Rowling', '1965-07-31', 'United Kingdom'),
  ('Stephen King', '1947-09-21', 'United States'),
  ('Agatha Christie', '1890-09-15', 'United Kingdom'),
  ('Ruskin Bond', '1934-05-19', 'India'),
  ('Chetan Bhagat', '1974-04-22', 'India');
  
  INSERT INTO Books (Title, AuthorID, Genre, ISBN) 
VALUES 
  ('Harry Potter and the Philosopher''s Stone', 1, 'Fantasy', '9780747532743'),
  ('The Shining', 2, 'Horror', '9780385121675'),
  ('Murder on the Orient Express', 3, 'Mystery', '9780062693662'),
  ('The Blue Umbrella', 4, 'Fiction', '9788122200072'),
  ('Five Point Someone', 5, 'Fiction', '9788129135508');

INSERT INTO Borrowers (BorrowerName, Email, Address) 
VALUES 
  ('Amit Patel', 'amitp@example.com', '14 Tulsi Lane, Mumbai'),
  ('Neha Gupta', 'neha.gupta@example.com', '22 Lakeview Apartments, Delhi'),
  ('Priya Sharma', 'priya.sharma@example.com', '7A/3 Model Town, Bangalore'),
  ('Rajesh Kumar', 'rajesh.kumar@example.com', '31B Civil Lines, Kolkata'),
  ('Anjali Singh', 'anjali.singh@example.com', '9 Sector 15, Chandigarh');
  
INSERT INTO Transactions (BookID, BorrowerID, DateBorrowed, DateReturned) 
VALUES 
  (1, 1, '2023-01-15', NULL),
  (2, 2, '2023-01-10', '2023-01-25'),
  (3, 3, '2023-02-05', NULL),
  (4, 4, '2023-02-20', NULL),
  (5, 5, '2023-03-01', '2023-03-20');
  
  
  SHOW databases;
  
  select database();
 /*See the Structure of the table */ 
DESCRIBE Authors;
DESCRIBE Books;
DESCRIBE Borrowers;
DESCRIBE Transactions;

-- View inserted data in Authors table,Books table, Borrowers table,Transactions table
SELECT * FROM Authors;
SELECT * FROM Books; 
SELECT * FROM Borrowers;
SELECT * FROM Transactions;

/* Query to join Books and Authors tables to get book details with author names*/
SELECT Books.BookID, Books.Title, Books.Genre, Authors.AuthorName
FROM Books
INNER JOIN Authors ON Books.AuthorID = Authors.AuthorID;

/*Query to demonstrate aliasing of table names for clearer queries*/
SELECT B.BookID, B.Title, B.Genre, A.AuthorName
FROM Books AS B
INNER JOIN Authors AS A ON B.AuthorID = A.AuthorID;

-- Inserting another book for Chetan Bhagat
INSERT INTO Books (Title, AuthorID, Genre, ISBN) 
VALUES ('2 States', 5, 'Fiction', '9788129135509');

/*Example query using aggregate function (Count the number of books by each author)*/
SELECT Authors.AuthorName, COUNT(Books.BookID) AS TotalBooks
FROM Authors
LEFT JOIN Books ON Authors.AuthorID = Books.AuthorID
GROUP BY Authors.AuthorName;

-- Fot 2NF ,Checking for functional dependencies in the Books table
SELECT BookID, Title, AuthorID FROM Books;

SHOW INDEX FROM transactions;

SELECT
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
    TABLE_SCHEMA = 'librarydb'
    AND TABLE_NAME = 'Books'
    AND REFERENCED_TABLE_NAME ='Authors';



