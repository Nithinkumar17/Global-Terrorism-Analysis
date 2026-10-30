# Global Terrorism Analysis

## Project Overview

This project analyzes historical global terrorism incidents using Python, Microsoft SQL Server, and Power BI.

The objective is to identify historical trends, geographic patterns, attack characteristics, recorded casualties, and changes in incident frequency.

The analysis covers 209,706 recorded incidents from 1970 to 2020.

## Tools & Technologies

* Python — Data cleaning and exploratory data analysis
* Pandas — Data manipulation
* Microsoft SQL Server — Data storage and SQL analysis
* SQL Server Management Studio 21 — Database management
* Power BI Desktop — Interactive dashboard development
* DAX — Calculated measures and KPIs
* Excel — Data inspection

## Project Workflow

1. Data collection and inspection
2. Data cleaning and preprocessing
3. Exploratory data analysis
4. Database creation and data import
5. SQL analysis and validation
6. Power BI dashboard development
7. Business insights and reporting

## SQL Analysis

The SQL analysis covers:

* Annual attack trends
* Year-over-year changes
* Country and regional analysis
* Attack-type distribution
* Weapon-type analysis
* Target-type analysis
* Recorded fatalities and injuries
* Attack success rates
* Suicide attack classification
* Data-quality validation

## Power BI Dashboard

The interactive dashboard contains five pages:

1. Executive Overview
2. Geographic Analysis
3. Attack Characteristics
4. Casualty Analysis
5. Yearly Trends & Comparative Analysis

## Key Findings

* 209,706 recorded incidents were analyzed.
* Iraq recorded 27,521 incidents.
* 2014 had the highest annual incident count, with 16,960 attacks.
* Bombing/Explosion was the most frequent attack type, with 98,158 incidents.
* Explosives were the most frequently recorded weapon category, with 103,475 incidents.
* 88.36% of incidents were classified as successful.
* Suicide attacks represented 3.55% of recorded incidents.

## Data Quality

The dataset contains missing casualty information:

* 12,527 missing fatality records.
* 19,936 missing injury records.

Missing values were retained rather than automatically replaced with zero.

Casualty totals therefore represent recorded values, not necessarily complete totals.

## Project Structure

```text
Global Terrorism Analysis/
├── data/
├── sql/
├── powerbi/
├── reports/
├── visualizations/
└── README.md
```

## Author

Nithinkumar

Data Analyst | Python | SQL | Power BI | Excel

## Disclaimer

This project is intended for educational and analytical purposes. Findings describe patterns in the historical dataset and should not be interpreted as causal conclusions.
