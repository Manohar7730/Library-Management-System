-- Database: LibraryManagement
CREATE DATABASE LibraryManagement;
USE LibraryManagement;

-- Table: Books
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Genre VARCHAR(100),
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    Publisher VARCHAR(255),
    AvailabilityStatus ENUM('Available', 'Borrowed') DEFAULT 'Available'
);

-- Table: Members
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Contact VARCHAR(15),
    MembershipStartDate DATE NOT NULL,
    MembershipEndDate DATE
);

-- Table: Staff
CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Role VARCHAR(100),
    Contact VARCHAR(15)
);

-- Table: BorrowingRecords
CREATE TABLE BorrowingRecords (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    BorrowDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    Penalty DECIMAL(5, 2) DEFAULT 0.00,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Insert sample data into Books
INSERT INTO Books (Title, Author, Genre, ISBN, Publisher)
VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', '9780743273565', 'Scribner'),
('1984', 'George Orwell', 'Dystopian', '9780451524935', 'Harcourt Brace'),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', '9780060935467', 'Harper Perennial');

-- Insert sample data into Members
INSERT INTO Members (Name, Contact, MembershipStartDate, MembershipEndDate)
VALUES 
('Alice Johnson', '555-1234', '2023-01-01', '2024-01-01'),
('Bob Smith', '555-5678', '2023-05-15', NULL);

-- Insert sample data into Staff
INSERT INTO Staff (Name, Role, Contact)
VALUES 
('Emma Brown', 'Librarian', '555-8765'),
('Liam Davis', 'Assistant Librarian', '555-4321');

-- Insert sample data into BorrowingRecords
INSERT INTO BorrowingRecords (MemberID, BookID, BorrowDate, DueDate, Penalty)
VALUES 
(1, 1, '2024-11-01', '2024-11-15', 0.00),
(2, 2, '2024-11-05', '2024-11-19', 5.00);

-- Query 1: List all available books
SELECT * FROM Books WHERE AvailabilityStatus = 'Available';

-- Query 2: Find all overdue books and penalties
SELECT br.RecordID, m.Name AS MemberName, b.Title AS BookTitle, br.DueDate, br.Penalty
FROM BorrowingRecords br
JOIN Members m ON br.MemberID = m.MemberID
JOIN Books b ON br.BookID = b.BookID
WHERE br.DueDate < CURDATE() AND br.ReturnDate IS NULL;

-- Query 3: Borrowing history of a specific member
SELECT br.RecordID, b.Title AS BookTitle, br.BorrowDate, br.DueDate, br.ReturnDate
FROM BorrowingRecords br
JOIN Books b ON br.BookID = b.BookID
WHERE br.MemberID = 1;

