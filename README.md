# 🛒 Blinkit Sales Analysis

An interactive **Power BI dashboard** that analyzes **7,060 Blinkit item sales records** to track total sales, average sales, item counts, and customer ratings across outlets, locations, and item categories. Data cleaning and exploratory data analysis (EDA) were done in **MySQL**.

---

## 📌 Project Overview

**Purpose:** To turn raw retail sales data into clear, actionable insights that show which outlet types, locations, and item categories drive the most sales, so teams can make better data-driven decisions.

**Key questions answered:**
- What are the total sales, average sales, and average rating?
- Which outlet types and outlet locations (Tier 1, 2, 3) generate the most sales?
- Which item types sell the most?
- How do Low Fat and Regular items compare in sales?
- How do sales vary by outlet size and outlet establishment year?

---

## 🛠️ Tech Stack

| Category | Tools |
|---|---|
| Data Cleaning & EDA | MySQL |
| Data Visualization | Power BI Desktop |
| Data Modeling & KPIs | DAX |

---

## 📂 Data Source

- **Dataset:** Blinkit sales data with **7,060 records**
- **Main columns:** item_identifier, item_type, item_fat_content, item_weight, item_visibility, outlet_identifier, outlet_establishment_year, outlet_location_type, outlet_size, outlet_type, total_sales, rating

---

## ⚙️ Project Workflow

1. **Data Quality Checks & Cleaning:** Checked and cleaned the data using MySQL.
2. **Exploratory Data Analysis (EDA):** Wrote SQL queries to analyze sales performance, outlet performance, and product trends.
3. **Data Modeling:** Loaded the data into Power BI and created DAX measures: Total Sales, AVG Sales, No Of Items, and AVG Rating.
4. **Dashboard Design:** Built an interactive dashboard with KPI cards, a filter panel, and business visualizations.
5. **Insights:** Analyzed the visuals to find sales patterns across outlets, locations, and item types.

---

## 📊 Dashboard Contents

| Section | What it shows |
|---|---|
| **KPI Cards** | Total Sales, Average Sales, Number of Items, Average Rating |
| **Filter Panel** | Filter by outlet location type, outlet size, and item type |
| **Metric Switcher** | Buttons to switch the charts between Total Sales, AVG Sales, No Of Items, and AVG Rating |
| **Fat Content** | Low Fat vs Regular items, and fat content by outlet location |
| **Item Type** | Sales by item category (Fruits, Snacks, Household, Frozen, Dairy, and more) |
| **Outlet Establishment Year** | Sales trend by the year the outlet was established |
| **Outlet Size & Location** | Sales by outlet size and by location tier (Tier 1, 2, 3) |
| **Outlet Type** | Total sales, items, average sales, and rating for Supermarket Type 1, Supermarket Type 2, and Grocery Store |

---

## ✨ Features

- Interactive dashboard with dynamic filtering through slicers
- KPI cards for the key sales metrics
- Dynamic metric switching built with a DAX-based Metrics table
- Multi-level analysis by item, outlet, size, location, and year
- Clean, branded design with a Blinkit-style color theme

---

## 🔍 Key Insights

- Total sales are about **$997.2K** across **7,060 items**, with an average sale of about **$141** and an average rating of about **4**.
- **Supermarket Type 1** generates about **$787.6K**, roughly **79%** of total sales.
- **Tier 2** locations lead in sales (**$393.15K**), followed by Tier 3 (**$341.42K**) and Tier 1 (**$262.59K**).
- **Fruits and Vegetables** and **Snack Foods** are the top-selling item types.
- **Regular** fat items contribute about **$644.5K**, roughly **65%** of total sales.
- Average sales (about $141) and ratings (about 4) are almost the same across all outlet types.
- Outlets established in **2010** show a sharp sales dip (about **$78K**) compared with about **$130K** for other years.

---

## 🌟 Highlights

- Performed data quality checks, cleaning, and EDA using **MySQL**
- Wrote SQL queries to analyze sales, outlet performance, and product trends
- Built **DAX measures** and a dynamic **Metrics** table for switching KPIs
- Designed an interactive dashboard with KPI cards, slicers, and multiple visualizations
- Generated actionable insights to support data-driven decision-making

---
##  Screen Shot:
![Dashboard Preview]([images/blinkit_dashboard.png]()

---
## 📁 Repository Structure

```
Blinkit-Sales-Analysis-Dashboard/
│
├── Blinkit_Dashboard.pbix     # Power BI file
├── Blinkit_EDA.sql            # MySQL queries
├── images/                    # Dashboard screenshots
└── README.md
```

---

## 🚀 How to Use

1. Download or clone this repository.
2. Open the `.pbix` file in **Power BI Desktop**.
3. Use the filter panel and metric buttons to explore the dashboard.

---

## 👤 Author

**Karan Shinde**
Data Analyst | SQL | Python | Power BI | Tableau | Excel

📧 karanshinde1608@gmail.com
🔗 [LinkedIn](https://www.linkedin.com/in/karan-shinde-56a35529a)
