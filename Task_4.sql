
-- 1. Top 5 most-issued books
SELECT b.Title, COUNT(t.TransactionID) AS IssueCount
FROM Books b
JOIN Transactions t ON b.BookID = t.BookID
GROUP BY b.Title
ORDER BY IssueCount DESC
LIMIT 5;

-- 2. Books and authors in the Fantasy genre
SELECT b.Title, a.Name AS Author, b.PublicationYear
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID
WHERE b.Genre = 'Fantasy'
ORDER BY b.PublicationYear DESC;

-- 3. Top 3 customers who borrowed the most books
SELECT c.Name, COUNT(t.TransactionID) AS BooksBorrowed
FROM Customers c
JOIN Transactions t ON c.CustomerID = t.CustomerID
GROUP BY c.Name
ORDER BY BooksBorrowed DESC
LIMIT 3;
-- 4. Customers with overdue books
SELECT c.Name, c.Email, t.IssueDate
FROM Customers c
JOIN Transactions t ON c.CustomerID = t.CustomerID
WHERE t.ReturnDate IS NULL 
AND t.IssueDate < CURRENT_DATE - INTERVAL '30 days';

-- 5. Authors who wrote more than 3 books
SELECT a.Name, COUNT(b.BookID) AS BookCount
FROM Authors a
JOIN Books b ON a.AuthorID = b.AuthorID
GROUP BY a.Name
HAVING COUNT(b.BookID) > 3;

-- 6. Authors with books issued in the last 6 months
SELECT DISTINCT a.Name
FROM Authors a
JOIN Books b ON a.AuthorID = b.AuthorID
JOIN Transactions t ON b.BookID = t.BookID
WHERE t.IssueDate >= CURRENT_DATE - INTERVAL '6 months';

-- 7. Total books currently issued and percentage issued
SELECT 
    SUM(CASE WHEN t.ReturnDate IS NULL THEN 1 ELSE 0 END) AS CurrentlyIssued,
    ROUND(
        (SUM(CASE WHEN t.ReturnDate IS NULL THEN 1 ELSE 0 END) * 100.0) / 
        COUNT(*), 2
    ) AS PercentageIssued
FROM Transactions t;

-- 8. Monthly report for the past year
SELECT 
    DATE_FORMAT(t.IssueDate, '%Y-%m') AS Month,
    COUNT(DISTINCT t.BookID) AS BookCount,
    COUNT(DISTINCT t.CustomerID) AS UniqueCustomers
FROM Transactions t
WHERE t.IssueDate >= CURDATE() - INTERVAL 1 YEAR
GROUP BY Month
ORDER BY Month;

-- 9. Add indexes for optimization
CREATE INDEX idx_books_genre ON Books(Genre);
CREATE INDEX idx_transactions_issue_date ON Transactions(IssueDate);

-- 10. Analyze query execution plans
-- Example EXPLAIN
EXPLAIN ANALYZE
SELECT b.Title, COUNT(t.TransactionID) AS IssueCount
FROM Books b
JOIN Transactions t ON b.BookID = t.BookID
GROUP BY b.Title
ORDER BY IssueCount DESC
LIMIT 5;
