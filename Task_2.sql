-- Create the database
CREATE DATABASE IF NOT EXISTS lms_db;

-- Use the database
USE lms_db;

-- Create the Authors table
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DOB DATE
);

-- Create the Books table
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    Genre VARCHAR(50),
    PublicationYear INT,
    AuthorID INT NOT NULL,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
);

-- Create the Customers table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE NOT NULL,
    Phone VARCHAR(15) UNIQUE
);

-- Create the Transactions table
CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT NOT NULL,
    CustomerID INT NOT NULL,
    IssueDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);
SHOW TABLES;

INSERT INTO Authors (Name, DOB) VALUES 
('J.K. Rowling', '1965-07-31'),
('George R.R. Martin', '1948-09-20'),
('J.R.R. Tolkien', '1892-01-03'),
('Agatha Christie', '1890-09-15'),
('Stephen King', '1947-09-21'),
('Isaac Asimov', '1920-01-02'),
('Arthur C. Clarke', '1917-12-16'),
('Philip K. Dick', '1928-12-16'),
('Suzanne Collins', '1962-08-10'),
('Rick Riordan', '1964-06-05');

INSERT INTO Books (Title, Genre, PublicationYear, AuthorID) VALUES 
('Harry Potter and the Sorcerer\'s Stone', 'Fantasy', 1997, 1),
('A Game of Thrones', 'Fantasy', 1996, 2),
('The Hobbit', 'Fantasy', 1937, 3),
('Murder on the Orient Express', 'Mystery', 1934, 4),
('The Casual Vacancy', 'Drama', 2012, 1),
('It', 'Horror', 1986, 5),
('Foundation', 'Science Fiction', 1951, 6),
('Rendezvous with Rama', 'Science Fiction', 1973, 7),
('Do Androids Dream of Electric Sheep?', 'Science Fiction', 1968, 8),
('The Hunger Games', 'Fantasy', 2008, 9);

INSERT INTO Customers (Name, Email, Phone) VALUES 
('Alice Smith', 'alice@example.com', '1234567890'),
('Bob Johnson', 'bob@example.com', '0987654321'),
('Charlie Davis', 'charlie@example.com', '1122334455'),
('Diana Ross', 'diana@example.com', '5566778899'),
('Eve Black', 'eve@example.com', '6677889900'),
('Frank White', 'frank@example.com', '7788990011'),
('Grace Green', 'grace@example.com', '8899001122'),
('Hank Brown', 'hank@example.com', '9900112233'),
('Ivy Blue', 'ivy@example.com', '1234432110'),
('Jack Grey', 'jack@example.com', '9876543210');

INSERT INTO Transactions (BookID, CustomerID, IssueDate, ReturnDate) VALUES 
(1, 1, '2025-01-01', NULL),
(2, 2, '2025-01-10', '2025-01-20'),
(3, 1, '2025-01-15', NULL),
(4, 3, '2024-12-10', NULL),
(5, 4, '2024-12-01', '2024-12-15'),
(1, 2, '2024-11-01', '2024-11-10'),
(3, 3, '2024-10-15', '2024-10-25'),
(6, 5, '2024-12-20', NULL),
(7, 6, '2024-11-05', '2024-11-15'),
(8, 7, '2024-10-01', '2024-10-10');
