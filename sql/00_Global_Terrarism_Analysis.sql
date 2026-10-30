
/*
=========================================================
PROJECT: Global Terrorism Analysis
DATABASE: GlobalTerrorismDB
TABLE: dbo.GlobalTerrorism
TOOL: Microsoft SQL Server Management Studio (SSMS)

OBJECTIVE:
Analyze historical terrorist incidents to identify trends
in attack frequency, geographic distribution, attack types,
casualties, weapons, targets, and attack characteristics.

ANALYSIS AREAS:
1. Data quality and validation
2. Yearly attack trends
3. Country-level analysis
4. Attack-type analysis
5. Regional analysis
6. Fatality and injury analysis
7. Weapon-type analysis
8. Target-type analysis
9. Attack success analysis
10. Suicide attack analysis

IMPORTANT DATA NOTES:
- The dataset contains 209,706 recorded incidents.
- Missing casualty values are retained as NULL.
- SUM() ignores NULL values, so casualty totals represent
  recorded values rather than necessarily complete totals.
- Averages calculated using COUNT(nkill) or COUNT(nwound)
  exclude incidents with missing values in the corresponding
  casualty field.
- Findings describe patterns in the dataset and do not
  establish causal relationships.

=========================================================
*/

USE GlobalTerrorismDB;
GO

-- Confirm the total number of records.
SELECT COUNT(*) AS TotalRecords
FROM dbo.GlobalTerrorism;
GO

-- Confirm the number of unique event IDs.
SELECT COUNT(DISTINCT eventid) AS UniqueEventIDs
FROM dbo.GlobalTerrorism;
GO

-- Confirm the available year range.
SELECT
    MIN(iyear) AS FirstYear,
    MAX(iyear) AS LastYear
FROM dbo.GlobalTerrorism;
GO
