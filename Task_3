pip install psycopg2 faker
import psycopg2
import random
from faker import Faker
from datetime import datetime, timedelta

# Setup connection to PostgreSQL database
conn = psycopg2.connect(
    host="localhost",
    database="lms_db",
    user="your_user",  # replace with your PostgreSQL username
    password="your_password"  # replace with your PostgreSQL password
)

cursor = conn.cursor()

# Instantiate Faker to generate random data
fake = Faker()

# Generate synthetic data for Authors
authors = []
for _ in range(10):
    # Ensure the DOB is properly formatted as string (yyyy-mm-dd)
    dob = fake.date_of_birth(minimum_age=25, maximum_age=80)
    authors.append((fake.name(), dob))

# Insert authors into the Authors table
cursor.executemany("INSERT INTO Authors (Name, DOB) VALUES (%s, %s)", authors)
conn.commit()

# Generate synthetic data for Books
books = []
for _ in range(10):
    author_id = random.randint(1, 10)
    title = fake.sentence(nb_words=5)
    genre = random.choice(['Fantasy', 'Science Fiction', 'Mystery', 'Horror', 'Drama'])
    publication_year = random.randint(1900, 2025)
    books.append((title, genre, publication_year, author_id))

# Insert books into the Books table
cursor.executemany("INSERT INTO Books (Title, Genre, PublicationYear, AuthorID) VALUES (%s, %s, %s, %s)", books)
conn.commit()

# Generate synthetic data for Customers
customers = []
for _ in range(10):
    customers.append((fake.name(), fake.email(), fake.phone_number()))

# Insert customers into the Customers table
cursor.executemany("INSERT INTO Customers (Name, Email, Phone) VALUES (%s, %s, %s)", customers)
conn.commit()

# Generate synthetic data for Transactions (Book issues)
transactions = []
for _ in range(10):
    book_id = random.randint(1, 10)
    customer_id = random.randint(1, 10)
    issue_date = fake.date_this_decade(before_today=True, after_today=False)
    
    # Handle NULL return date properly by setting it as None if not returned
    return_date = random.choice([None, fake.date_this_decade(before_today=True, after_today=False)])
    
    # Ensure that the date is in string format for PostgreSQL to recognize it
    if return_date:
        return_date = return_date.strftime('%Y-%m-%d')  # Convert to string format 'yyyy-mm-dd'
    issue_date = issue_date.strftime('%Y-%m-%d')  # Convert to string format 'yyyy-mm-dd'
    
    transactions.append((book_id, customer_id, issue_date, return_date))

# Insert transactions into the Transactions table
cursor.executemany("INSERT INTO Transactions (BookID, CustomerID, IssueDate, ReturnDate) VALUES (%s, %s, %s, %s)", transactions)
conn.commit()

# Close the connection
cursor.close()
conn.close()

print("Synthetic data has been successfully generated and inserted into the PostgreSQL database.")
