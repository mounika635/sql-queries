# sql-queries
# SQL Queries Collection

A collection of useful SQL queries with descriptions.  
This project is designed to help beginners understand and practice SQL commands.

## 🚀 Features
- Basic queries (SELECT, INSERT, UPDATE, DELETE)
- Aggregate functions (COUNT, AVG, SUM)
- Filtering with WHERE and ORDER BY
- Joins and Subqueries
- Real-world examples with explanations

## 📂 Project Structure
project-folder/
│── data.json        # JSON file containing queries and descriptions
│── README.md        # Documentation

## 📦 Example Queries
```json
{
  "sql_queries": [
    {
      "query": "SELECT * FROM employees;",
      "description": "Retrieves all rows and columns from the employees table."
    },
    {
      "query": "SELECT name, age FROM students WHERE age > 18;",
      "description": "Shows names and ages of students older than 18."
    },
    {
      "query": "INSERT INTO customers (id, name, city) VALUES (1, 'Mounika', 'Hyderabad');",
      "description": "Adds a new customer record with ID, name, and city."
    }
  ]
}
