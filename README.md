# Library Management System 📚

### Description
A SQL-based project for managing a library's operations, including books, members, borrowing records, and staff. This project demonstrates database design, query writing, and data management skills.

---

## Features
- Manage books, members, staff, and borrowing records.
- Track overdue books and calculate penalties.
- Search books by genre, author, or title.
- Monitor member borrowing history.

---

## Database Design

### ER Diagram
![Library Management system](https://github.com/user-attachments/assets/b1bfeb9e-5c89-4746-bc39-b4072832c253)


### Schema
The database consists of the following tables:
- **Books**: Information about available and borrowed books.
- **Members**: Registered library members.
- **Staff**: Library staff managing operations.
- **BorrowingRecords**: Tracks book loans, due dates, and penalties.

---

## Queries
### Basic Queries
- **List all available books**
  ```sql
  SELECT * FROM Books WHERE AvailabilityStatus = 'Available';

- **Find overdue books and penalties**
  ```sql
  SELECT br.RecordID, m.Name AS MemberName, b.Title AS BookTitle, br.DueDate, br.Penalty
  FROM BorrowingRecords br
  JOIN Members m ON br.MemberID = m.MemberID
  JOIN Books b ON br.BookID = b.BookID
  WHERE br.DueDate < CURDATE() AND br.ReturnDate IS NULL;

