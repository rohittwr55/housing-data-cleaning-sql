# 📌 Project Title

Housing Data Cleaning using SQL Server

📊 Project Overview

Explain clearly:

Dataset contained missing values, duplicates, inconsistent formats
Goal: clean and prepare for analysis
🛠 Tools Used
SQL Server
T-SQL
🔍 Data Cleaning Steps

Explain EACH step like this:

1. Standardizing Date Format

Converted date column into consistent format using CONVERT.

2. Handling Missing Property Address

Used self join on ParcelID to populate missing values.

3. Splitting Address Columns
Property address → Address + City
Owner address → Address + City + State
4. Data Normalization

Replaced Yes/No with Y/N for consistency.

5. Removing Duplicates

Used ROW_NUMBER() with CTE to identify and delete duplicates.
