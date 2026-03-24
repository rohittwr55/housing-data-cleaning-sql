# 🏠 Housing Market Analysis Dashboard

## 📌 Project Overview

This project focuses on analyzing housing data to extract meaningful insights about property prices, location trends, and value distribution.

The dataset was initially cleaned and transformed using SQL Server, followed by building an interactive dashboard in Power BI to visualize key metrics and patterns.

---

## 🎯 Objectives

* Analyze housing prices across different cities
* Understand factors affecting property value (bedrooms, land, building value)
* Identify trends and distribution in housing data
* Create an interactive dashboard for easy exploration

---

## 🛠 Tools & Technologies

* SQL Server (Data Cleaning & Transformation)
* Power BI (Data Visualization & Dashboarding)

---

## 🧹 Data Cleaning (SQL)

The dataset contained inconsistencies, missing values, and duplicates. The following steps were performed:

* Standardized date format using `CONVERT`
* Handled missing property addresses using self-join and `ISNULL`
* Split property address into Address and City using `SUBSTRING` and `CHARINDEX`
* Split owner address into Address, City, and State using `PARSENAME` and `REPLACE`
* Normalized categorical values (Yes/No → Y/N)
* Removed duplicate records using `ROW_NUMBER()` and CTE

---

## 📊 Dashboard Features

The Power BI dashboard includes:

* **KPI Cards**:

  * Average Sale Price
  * Total Properties
  * Average Land Value
  * Average Building Value

* **Visualizations**:

  * Average Price by City
  * Price Distribution
  * Bedrooms vs Sale Price (Scatter Plot)
  * Land vs Building Value Comparison

* **Filters (Slicers)**:

  * City
  * Bedrooms
  * Year Built
  * Sold as Vacant

---

## 📈 Key Insights

* Significant variation in property prices across cities
* Strong relationship between property features (bedrooms, building value) and sale price
* Land and building values both contribute differently across locations
* Distribution of prices highlights presence of high-value outliers

---

## 📸 Dashboard Preview

<img width="1363" height="681" alt="DashboardWithFilter" src="https://github.com/user-attachments/assets/6c122ff2-0153-4469-9173-860d0c61276b" />

---

## 🚀 How to Use

1. Download the `.pbix` file from the repository
2. Open in Power BI Desktop
3. Use filters to explore the data interactively

---

## 📁 Project Structure

* `dashboard/` → Power BI file
* `dashboardscreenshot/` → Dashboard images
* `README.md` → Project documentation

---

## 💡 Future Improvements

* Add time-series analysis for price trends
* Include advanced DAX measures for deeper insights
* Integrate additional datasets for richer analysis

---
