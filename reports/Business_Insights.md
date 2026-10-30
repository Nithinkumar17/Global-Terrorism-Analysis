# Global Terrorism Analysis — Business Insights

## 1. Project Overview

This project analyzes the Global Terrorism Database (GTD) to understand historical patterns in terrorist incidents, geographic distribution, attack methods, casualties, and changes over time.

The analysis was completed using:
- **Python** for data cleaning, preparation, and exploratory analysis
- **Microsoft SQL Server (SSMS 21)** for data validation and structured analysis
- **Power BI** for interactive dashboards and visual storytelling

The dataset used for this project contains **209,706 recorded incidents** across **204 countries**. The analysis covers the years represented in the cleaned dataset (1970–2020).

> **Important data note:** The figures below are based on recorded values in the dataset. Missing casualty values are not treated as zero, and the results should be interpreted in the context of the dataset's definitions, coverage, and limitations.

---

## 2. Executive Summary

The analysis highlights several important patterns:

1. The highest annual number of recorded incidents occurred in **2014**, with **16,960 attacks**.
2. **Iraq** recorded the highest number of incidents (**27,521**), followed by Afghanistan (**18,920**) and Pakistan (**15,504**).
3. **Bombing/Explosion** was the most frequently recorded attack type, with **98,158 incidents**.
4. The **Middle East & North Africa** region recorded the highest number of incidents (**58,252**), closely followed by South Asia (**54,725**).
5. The dataset records **479,348 fatalities** and **585,606 injuries**. These totals represent recorded values; casualty information is missing for some incidents.
6. **88.36%** of incidents were marked successful and **11.64%** unsuccessful.
7. Suicide attacks represented approximately **3.55%** of all recorded incidents.

---

## 3. Key Findings

### 3.1 Overall Incident Profile

| Metric | Result |
|---|---:|
| Total recorded incidents | 209,706 |
| Countries affected | 204 |
| Recorded fatalities | 479,348 |
| Recorded injuries | 585,606 |
| Successful incidents | 185,302 (88.36%) |
| Unsuccessful incidents | 24,404 (11.64%) |
| Suicide attacks | 7,438 (3.55%) |
| Non-suicide attacks | 202,268 (96.45%) |

**Insight:** Most recorded incidents were marked successful. The casualty totals are substantial, but they should be read alongside the missing-value information in the data-quality section.

### 3.2 Yearly Trends

The five years with the highest recorded incident counts were:

| Year | Recorded incidents |
|---:|---:|
| 2014 | 16,960 |
| 2015 | 15,138 |
| 2016 | 14,051 |
| 2013 | 12,047 |
| 2017 | 11,364 |

- **2014** was the peak year, with 16,960 recorded incidents.
- Incidents increased by **4,913 (40.78%)** in 2014 compared with 2013.
- The number of incidents declined by **2,687 (19.12%)** in 2017 compared with 2016.

The highest annual recorded fatality total was also in **2014**, at **44,648**. Recorded fatalities were 38,993 in 2015, 35,239 in 2016, and 26,897 in 2017.

**Insight:** The data shows a pronounced rise in recorded incidents and fatalities around 2014, followed by a decline in incident counts over the next several years. These are descriptive trends and do not, by themselves, explain the causes.

### 3.3 Geographic Distribution

Top 10 countries by recorded incident count:

| Country | Incidents |
|---|---:|
| Iraq | 27,521 |
| Afghanistan | 18,920 |
| Pakistan | 15,504 |
| India | 13,929 |
| Colombia | 8,915 |
| Philippines | 8,271 |
| Peru | 6,111 |
| Yemen | 6,027 |
| Nigeria | 5,550 |
| United Kingdom | 5,513 |

Top regions:

| Region | Incidents |
|---|---:|
| Middle East & North Africa | 58,252 |
| South Asia | 54,725 |
| Sub-Saharan Africa | 23,746 |
| South America | 19,846 |
| Western Europe | 17,328 |
| Southeast Asia | 14,498 |

**Insight:** Recorded incidents were concentrated in the Middle East & North Africa and South Asia. Iraq, Afghanistan, and Pakistan were the three most affected countries by incident count in this dataset.

### 3.4 Attack Characteristics

Most frequently recorded attack types:

| Attack type | Incidents |
|---|---:|
| Bombing/Explosion | 98,158 |
| Armed Assault | 49,553 |
| Assassination | 21,539 |
| Hostage Taking (Kidnapping) | 14,045 |
| Facility/Infrastructure Attack | 12,325 |
| Unknown | 10,942 |

Most frequently recorded weapon types:

| Weapon type | Incidents |
|---|---:|
| Explosives | 103,475 |
| Firearms | 67,648 |
| Unknown | 20,203 |
| Incendiary | 13,133 |
| Melee | 4,307 |

**Insight:** Bombing/Explosion was the leading attack category, while explosives were the most frequently recorded weapon category. These categories describe how incidents were classified in the source data.

### 3.5 Casualty Analysis

The dataset contains:
- **479,348 recorded fatalities**
- **585,606 recorded injuries**

Comparison by suicide classification:

| Category | Incidents | Recorded fatalities | Recorded injuries |
|---|---:|---:|---:|
| Suicide attacks | 7,438 | 74,128 | 146,765 |
| Non-suicide attacks | 202,268 | 405,220 | 438,841 |

Average recorded casualties per incident:

| Category | Average fatalities | Average injuries |
|---|---:|---:|
| Suicide attacks | 10.14 | 21.27 |
| Non-suicide attacks | 2.13 | 2.40 |

**Insight:** Although suicide attacks account for a relatively small share of recorded incidents, their average recorded fatalities and injuries per incident are higher than those for non-suicide attacks in this dataset. This is a descriptive comparison, not a statement about the circumstances or causes of individual incidents.

### 3.6 Target Categories

The most frequently recorded target categories include:
- Private Citizens & Property — **51,985**
- Military — **34,131**
- Police — **28,568**
- Government (General) — **23,828**
- Business — **22,169**

**Insight:** Private citizens and property were the most frequently recorded target category, followed by military and police targets.

---

## 4. Data Quality and Limitations

The cleaned dataset contains **209,706 records** and **209,706 unique event IDs**. No exact duplicate rows or duplicate event IDs were identified in the validation checks.

Selected data-quality checks:

| Data-quality item | Result |
|---|---:|
| Total records | 209,706 |
| Missing year | 0 |
| Missing country | 0 |
| Missing region | 0 |
| Missing attack type | 0 |
| Missing fatality values (`nkill`) | 12,527 |
| Missing injury values (`nwound`) | 19,936 |
| Missing hostage indicator (`ishostkid`) | 797 |
| Unknown month values | 20 |
| Unknown day values | 891 |

### Interpretation cautions

- Missing fatality or injury values mean the casualty count was not recorded; they must not automatically be interpreted as zero.
- Recorded zero casualties are valid values and are different from blank values.
- Some date components are unknown, so not every incident can be analyzed at monthly or daily granularity.
- The dataset has no recorded incidents for **1993**. Year-over-year comparisons that require 1993 as the previous year should remain blank rather than substituting 1992.
- Historical coverage, reporting practices, and classification conventions may vary across countries and years.
- The dataset is observational. The analysis identifies patterns and associations; it does not establish causation.

---

## 5. Dashboard Pages

The Power BI report contains five pages:

1. **Executive Overview** — high-level KPIs, yearly incident trend, outcomes, leading countries, and attack types.
2. **Geographic Analysis** — country and regional distribution of recorded incidents.
3. **Attack Characteristics** — attack methods, weapon types, and suicide-attack classification.
4. **Casualty Analysis** — recorded fatalities, injuries, and casualty patterns.
5. **Yearly Trends** — changes in incident counts and casualties over time.

Interactive filters and visuals allow users to explore patterns across available years, countries, regions, and categories.

---

## 6. Recommendations for Further Analysis

Possible extensions to this project include:

- Investigating country-level trends across selected time periods.
- Comparing attack methods and target categories by region.
- Exploring the relationship between attack characteristics and recorded casualties.
- Examining changes in reporting completeness over time.
- Adding a dedicated data dictionary and methodology document to explain field definitions and cleaning decisions.

These are analytical directions for further investigation, not operational recommendations.

---

## 7. Conclusion

The analysis shows that recorded terrorist incidents in the dataset were unevenly distributed across time and geography. Incident counts peaked in 2014, the highest country totals were recorded for Iraq, Afghanistan, and Pakistan, and Bombing/Explosion was the most common attack type. Suicide attacks made up a small proportion of incidents but had higher average recorded casualties per incident than non-suicide attacks.

The project demonstrates an end-to-end data analytics workflow using Python, SQL Server, and Power BI, from data preparation and validation through SQL analysis and interactive reporting.

---

## 8. Disclaimer

This report is for educational and portfolio purposes only. It summarizes historical records from the Global Terrorism Database and does not endorse, justify, or promote violence or any terrorist activity. All figures are subject to the source dataset's definitions, coverage, and data-quality limitations.
