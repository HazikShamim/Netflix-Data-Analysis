# Netflix-Data-Analysis

Analyzed a Netflix dataset sourced from Kaggle using Python for data exploration and cleaning, followed by SQL Server for deeper analysis.

Python (Jupyter Notebook):
Loaded the raw CSV using Pandas, and explored the dataset to identify duplicates, null values, and data inconsistencies, such as language discrepancies and misplaced values across columns. Used SQLAlchemy to push the cleaned data into SQL Server.

SQL Server:
Built normalized tables for directors, countries, cast, and genres. Performed additional cleaning, including handling remaining nulls and removing duplicates using CTEs and Window Functions.
Questions answered through SQL:

Directors who have made both Movies and TV Shows
The country with the highest number of Comedy movies
Top director per year based on movies added to Netflix
Average movie duration by genre
Directors who have directed both Horror and Comedy movies

Tools: Python · Pandas · Jupyter Notebook · SQLAlchemy · SQL Server · Kaggle
