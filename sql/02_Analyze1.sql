
SELECT
    COUNT(*) AS TotalRecords,

    SUM(CASE WHEN iyear IS NULL THEN 1 ELSE 0 END) AS MissingYear,
    SUM(CASE WHEN country_txt IS NULL THEN 1 ELSE 0 END) AS MissingCountry,
    SUM(CASE WHEN region_txt IS NULL THEN 1 ELSE 0 END) AS MissingRegion,
    SUM(CASE WHEN attacktype1_txt IS NULL THEN 1 ELSE 0 END) AS MissingAttackType,
    SUM(CASE WHEN nkill IS NULL THEN 1 ELSE 0 END) AS MissingFatalities,
    SUM(CASE WHEN nwound IS NULL THEN 1 ELSE 0 END) AS MissingInjuries,
    SUM(CASE WHEN ishostkid IS NULL THEN 1 ELSE 0 END) AS MissingHostageIndicator
FROM dbo.GlobalTerrorism;

/*Key findings

1. Strong completeness in core classification fields

Your year, country, region, and attack-type columns have no missing values. This supports analysis of incident trends and geographic distribution.

2. Casualty information contains missing values

Fatalities are missing in approximately 5.97% of records.
Injuries are missing in approximately 9.51% of records.

Do not automatically replace these values with zero. Missing casualty information does not necessarily mean that nobody was killed or injured.

3. The hostage indicator has limited missingness

Only 797 records have missing ishostkid values. Keep them as NULL unless the source provides enough information to determine the correct values.

You can document these findings in your project's data-quality report*/


--Analyze Yearly Terrorism Trends

SELECT 
    iyear as AttackYear,
    COUNT(*) AS TotalAttacks
FROM dbo.GlobalTerrorism
WHERE iyear IS NOT NULL
GROUP BY iyear
ORDER BY TotalAttacks DESC;


--Calculate year-over-year changes

WITH YearlyAttacks AS
(
     SELECT 
         iyear as AttackYear,
         COUNT(*) AS TotalAttacks
     FROM dbo.GlobalTerrorism
     GROUP BY iyear
),
YearlyCamparison AS 
(
     SELECT 
           AttackYear,
           TotalAttacks,
           LAG(TotalAttacks) OVER (
                 ORDER BY AttackYear
            ) AS PreviousYearAttacks
     FROM YearlyAttacks
)
SELECT 
     AttackYear,
     TotalAttacks,
     PreviousYearAttacks,
     TotalAttacks - PreviousYearAttacks AS AttackDifference,
     CAST(
         ( 
             100*(TotalAttacks - PreviousYearAttacks)
             /NULLIF (PreviousYearAttacks, 0)
        ) AS DECIMAL(10,2)
        )AS PercentageChange
From YearlyCamparison
ORDER BY AttackYear;


--Identify the largest annual increase and decrease

WITH YearlyAttacks AS
(
    SELECT
        iyear AS AttackYear,
        COUNT(*) AS TotalAttacks
    FROM dbo.GlobalTerrorism
    GROUP BY iyear
),
YearlyComparison AS
(
    SELECT
        AttackYear,
        TotalAttacks,
        LAG(TotalAttacks) OVER (
            ORDER BY AttackYear
        ) AS PreviousYearAttacks
    FROM YearlyAttacks
)
SELECT
    AttackYear,
    TotalAttacks,
    PreviousYearAttacks,
    TotalAttacks - PreviousYearAttacks AS AttackDifference,
    CAST(
        100.0 * (TotalAttacks - PreviousYearAttacks)
        / NULLIF(PreviousYearAttacks, 0)
        AS DECIMAL(10, 2)
    ) AS PercentageChange
FROM YearlyComparison
ORDER BY AttackDifference DESC;