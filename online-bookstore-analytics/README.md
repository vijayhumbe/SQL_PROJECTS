# 📚 Online Bookstore – Database Design & Analytics (SQL)

A SQL project that designs a relational database for an online bookstore and answers common business questions using queries, from simple filtering to joins, aggregations and inventory analysis.

## 🎯 Project Objectives

- Design a normalized relational schema for books, customers and orders
- Practice core SQL: `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, `DISTINCT`
- Apply intermediate/advanced SQL: `JOIN`, `GROUP BY`, `HAVING`, aggregate functions, `COALESCE`
- Derive business insights such as revenue, best-selling books, top customers and remaining stock

## 🛠️ Tech Stack

- **Database:** PostgreSQL (uses `SERIAL` for auto-increment IDs)
- **Language:** SQL
- **Tools:** pgAdmin / psql / DBeaver (any PostgreSQL client)

## 🗂️ Database Schema

The database `OnlineBookstore` contains three tables:

### `Books`
| Column | Type | Description |
|---|---|---|
| Book_ID | SERIAL (PK) | Unique book identifier |
| Title | VARCHAR(100) | Book title |
| Author | VARCHAR(100) | Author name |
| Genre | VARCHAR(50) | Book genre |
| Published_Year | INT | Year of publication |
| Price | NUMERIC(10,2) | Price per unit |
| Stock | INT | Units available in inventory |

### `Customers`
| Column | Type | Description |
|---|---|---|
| Customer_ID | SERIAL (PK) | Unique customer identifier |
| Name | VARCHAR(100) | Customer name |
| Email | VARCHAR(100) | Email address |
| Phone | VARCHAR(15) | Phone number |
| City | VARCHAR(50) | City |
| Country | VARCHAR(150) | Country |

### `Orders`
| Column | Type | Description |
|---|---|---|
| Order_ID | SERIAL (PK) | Unique order identifier |
| Customer_ID | INT (FK) | References `Customers(Customer_ID)` |
| Book_ID | INT (FK) | References `Books(Book_ID)` |
| Order_Date | DATE | Date the order was placed |
| Quantity | INT | Number of copies ordered |
| Total_Amount | NUMERIC(10,2) | Total order value |

### Relationships

```
Customers (1) ────< Orders >──── (1) Books
```

One customer can place many orders, and one book can appear in many orders.

## 📁 Repository Structure

```
.
├── online_bookstore_analysis.sql   # Schema + all queries
└── README.md
```

## 🚀 Getting Started

1. **Install PostgreSQL** and a client such as pgAdmin or psql.
2. **Create and select the database:**
   ```sql
   CREATE DATABASE OnlineBookstore;
   \c OnlineBookstore   -- in psql
   ```
3. **Run the table creation statements** from the `.sql` file.
4. **Load data** into the three tables (import CSVs via pgAdmin's Import/Export tool, or use `COPY`):
   ```sql
   COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
   FROM '/path/to/Books.csv' DELIMITER ',' CSV HEADER;
   ```
   Load `Books` and `Customers` before `Orders` because of the foreign keys.
5. **Run the analysis queries** from the `.sql` file.

> **Note:** The script does not include sample data. You will need to supply your own CSV/INSERT data.

## 🔍 Queries Covered

### Basic Queries
1. Retrieve all books in the "Fiction" genre
2. Find books published after 1950
3. List all customers from Canada
4. Show orders placed in November 2023
5. Total stock of books available
6. Details of the most expensive book
7. Orders with quantity greater than 1
8. Orders where total amount exceeds $20
9. List all distinct genres
10. Book with the lowest stock
11. Total revenue from all orders

### Advanced Queries
1. Total books sold per genre
2. Average price of books in the "Fantasy" genre
3. Customers who have placed at least 2 orders
4. Most frequently ordered book
5. Top 3 most expensive "Fantasy" books
6. Total quantity sold by each author
7. Cities of customers who spent over $30
8. Customer who spent the most
9. Stock remaining after fulfilling all orders

## 💡 Key SQL Concepts Demonstrated

- Filtering and sorting (`WHERE`, `BETWEEN`, `ORDER BY`, `LIMIT`)
- Aggregations (`SUM`, `AVG`, `COUNT`)
- Grouping and group filtering (`GROUP BY`, `HAVING`)
- Joins (`INNER JOIN`, `LEFT JOIN`)
- Null handling with `COALESCE`
- Table aliases and calculated columns

## 📊 Sample Insights You Can Derive

- Which genres and authors sell the most
- Who the highest-spending and repeat customers are
- Which books are best-sellers or running low on stock
- Overall revenue and where high-value customers are located

## 🔧 Possible Improvements

- Add `NOT NULL`, `UNIQUE` (e.g., on `Email`) and `CHECK` constraints (e.g., `Price > 0`)
- Add indexes on `Orders(Customer_ID)`, `Orders(Book_ID)` and `Orders(Order_Date)`
- Split `Orders` into `Orders` and `Order_Items` to support multiple books per order
- Add window-function queries (e.g., `RANK()` for top books per genre) and monthly revenue trends
- Create views for common reports and a trigger to update stock automatically on new orders

## 🤝 Contributing

Suggestions and pull requests are welcome. Feel free to fork the repo and add more queries or improve the schema.

## 📄 License

This project is open source and available under the [MIT License](../LICENSE).
