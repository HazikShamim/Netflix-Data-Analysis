# Netflix-Data-Analysis

This project analyzes the Netflix dataset to extract meaningful insights about movies, genres, and directors. The dataset was sourced from Kaggle, cleaned using Python (Pandas), and analyzed using SQL Server.
The goal of this project was to demonstrate end-to-end data analysis skills  from data cleaning to advanced SQL querying.



1. Tools & Technologies
Python (Pandas)
SQL Server (SSMS)
SQLAlchemy
Kaggle Dataset

2. Project Workflow
1️⃣ Data Collection
Downloaded Netflix dataset from Kaggle (ZIP format)
Extracted and loaded into Jupyter Notebook

2️⃣ Data Cleaning (Python)
Removed duplicate records
Handled missing values
Standardized text fields (language inconsistencies)
Checked and corrected data types
Split multi-value columns (genre, director) into structured tables

3️⃣ Database Upload
Used SQLAlchemy to connect Python with SQL Server
Created normalized tables:
netflix
netflix_genre
netflix_directors


3. Key SQL Analysis
1️⃣ Top Director Per Year (Movies Only)
Filtered dataset for movies
Grouped by director and year added
Used CTE + ROW_NUMBER() to identify the top director each year

2️⃣ Average Movie Duration by Genre
Extracted numeric values from the duration column
Converted text to an integer
Calculated average duration per genre

3️⃣ Directors Who Directed Both Comedy and Horror
Used conditional aggregation (CASE WHEN)
Identified directors who worked across multiple genres
Counted the number of comedy and horror movies per director

4. Skills Demonstrated
Data cleaning and preprocessing
Handling missing values and duplicates
SQL joins and aggregations
Window functions (ROW_NUMBER)
Conditional aggregation
Data normalization
End-to-end analytical workflow
