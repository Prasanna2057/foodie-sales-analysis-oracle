# Foodie Sales Analysis (Oracle Database Project)

## Project Overview
This project demonstrates the design and implementation of a data warehouse using Oracle 19c.
This project transforms raw food order data into a structured star schema and performs analytical queries to generate business insights such as revenue trends, customer behavior, and location-based performance.

---

## Technologies Used
- Oracle Database 19c  
- SQL 
- Oracle SQL Developer  

---

## Project Flow
Raw Data → Data Cleaning → Dimension Tables → Fact Table → KPI Analysis → Business Insights

---

---

## How to Run
1. Run data cleaning queries on raw data
2. Create dimension and fact tables
3. Insert data into dimension tables
4. Load data into fact table
5. Execute analysis queries

---

## Database Design
- Fact Table: fact_foodie_orders  
- Dimension Tables:  
  - dim_date  
  - dim_location  
  - dim_restaurant
  - dim_category
  - dim_dish
The project follows a star schema design to optimize data analysis and querying.

---

## Data Cleaning & Transformation
- Handled NULL values using NVL  
- Standardized data formats  
- Performed data validation before loading into tables  
- Ensured data consistency across tables  

---

## Key Analysis
- Price range distribution  
- Total orders analysis  
- Rating and review analysis  
- Location-based insights  

---

## Key Learnings
- Star schema and data warehousing concepts  
- SQL query writing and optimization  
- Data cleaning and transformation techniques  
- Oracle database management  

---

## Author
Prasanna Manandhar
