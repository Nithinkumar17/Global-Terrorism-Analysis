
--Top 10 Countries by Recorded Incidents

SELECT TOP 10
     country_txt AS Country,
     COUNT(*) AS TotalAttacks
FROM dbo.GlobalTerrorism
WHERE country_txt IS NOT NULL
GROUP BY country_txt
ORDER BY TotalAttacks DESC;

/*Key business insights
Iraq ranks first: It has 27,521 recorded incidents, the highest count among the countries in your results.
Regional concentration: Iraq, Afghanistan, and Pakistan occupy the top three positions.
India ranks fourth: Your dataset contains 13,929 recorded incidents for India.
The top three countries account for a substantial number of incidents: Together, they have 61,945 recorded incidents.
Important limitation: These are counts of recorded incidents in your dataset, not measures of current risk or the probability of an attack today.*/

--Analyze Attack Types

SELECT
    attacktype1_txt AS AttackType,
    COUNT(*) AS TotalAttacks
FROM dbo.GlobalTerrorism
GROUP BY attacktype1_txt
ORDER BY TotalAttacks DESC;

/* Key insights
Bombing/Explosion dominates: It accounts for approximately 46.8% of all recorded incidents.
Armed Assault ranks second: It accounts for approximately 23.6%.
The two leading categories together represent approximately 70.4% of recorded incidents.
Unknown attack types: 10,942 incidents have their attack type recorded as Unknown. Keep this category in your analysis rather than treating it as missing data.*/

-- Analyze Terrorist Attacks by Region

SELECT 
     region_txt AS Region,
     COUNT(*) AS TotalAttacks
FROM dbo.GlobalTerrorism
WHERE region_txt IS NOT NULL
GROUP BY region_txt
ORDER BY TotalAttacks DESC;

/* Key insights
Highest: Middle East & North Africa, with 58,252 recorded incidents.
Second highest: South Asia, with 54,725 incidents.
Combined concentration: These two regions account for approximately 53.9% of all recorded incidents in your regional results.
Lowest: Australasia & Oceania, with 325 incidents*/

-- Analyze Fatalites by Year

SELECT
     iyear AS AttackYear,
     COUNT(*) AS TotalAttacks,
     SUM(COALESCE(nkill,0)) AS TotalFatalities
FROM dbo.GlobalTerrorism
GROUP BY iyear
ORDER BY iyear;

--Find the year with the highest fatalities

SELECT TOP 10
    iyear AS AttackYear,
    SUM(nkill) AS TotalFatalities,
    SUM(CASE WHEN nkill IS NULL THEN 1 ELSE 0 END)
        AS RecordsWithMissingFatalities
FROM dbo.GlobalTerrorism
GROUP BY iyear
ORDER BY TotalFatalities DESC;

-- Analyze Fatalities by Attack Type

SELECT 
    attacktype1_txt AS AttackType,
    COUNT(*) AS TotalAttacks,
    SUM(nkill) AS TotalFatalities,
    AVG(CAST(nkill AS FLOAT)) AS AverageFatalitiesPerRecordedIncident,
    SUM(CASE
        WHEN nkill IS NULL THEN 1 ELSE 0
        END) as MissingFatalityRecords
FROM dbo.GlobalTerrorism
WHERE attacktype1_txt IS NOT NULL
GROUP BY attacktype1_txt
ORDER BY TotalFatalities DESC;

/* ey analytical insights
1. Armed Assault has the highest recorded fatality total

Armed Assault accounts for 182,325 recorded fatalities, the highest total among the attack categories in your results.

2. Bombing/Explosion has the highest incident count

Bombing/Explosion accounts for 98,158 incidents, but its recorded fatality total is lower than that of Armed Assault.

3. Hijacking has the highest average fatalities per recorded incident

Hijacking has an average of approximately 5.42 fatalities per incident with a recorded fatality count.

However, it has only 759 incidents. A high average in a relatively small category should be interpreted cautiously.

4. Missing data matters

For example, Hostage Taking (Kidnapping) has 3,473 incidents with missing fatality counts. Consequently, its recorded fatality total may not represent the complete number of deaths associated with those incidents.

5. Unknown is a data category, not an attack method

The Unknown category has 48,707 recorded fatalities. Keep it in the analysis, but don't interpret it as a specific attack method.*/

-- Analyze Injuries by Attack Type

SELECT
    attacktype1_txt AS AttackType,
    COUNT(*) AS TotalAttacks,
    SUM(nwound) AS TotalInjuries,
    AVG(CAST(nwound AS FLOAT)) AS AverageInjuriesPerRecordedIncident,
    SUM(
        CASE
            WHEN nwound IS NULL THEN 1
            ELSE 0
        END
    ) AS MissingInjuryRecords
FROM dbo.GlobalTerrorism
WHERE attacktype1_txt IS NOT NULL
GROUP BY attacktype1_txt
ORDER BY TotalInjuries DESC;

/* Key insights

1. Bombing/Explosion accounts for the highest recorded injury total.

It accounts for 401,847 recorded injuries, substantially more than any other category in your results.

2. Hijacking has a high average injury count.

Its average is approximately 33.15 injuries per incident with a recorded injury count. However, the category contains only 759 incidents, and a small number of high-impact events could influence this average considerably.

3. Unarmed Assault also has a high average.

Its average is approximately 13.24 injuries per incident with a recorded injury count. This result is worth checking for unusual values and data quality before drawing conclusions.

4. Missing values affect the results.

For example, Hostage Taking (Kidnapping) has 4,257 records with missing injury counts. Therefore, its total recorded injuries may underestimate the actual total.

Important distinction: The number of injuries and fatalities measures different outcomes. Analyze them separately before combining them into a dashboard.*/


-- Identify the 10 Countries with the Highest Recorded Fatalities

SELECT TOP 10
    country_txt AS Country,
    COUNT(*) AS TotalAttacks,
    SUM(nkill) AS TotalFatalities,
    SUM(
        CASE
            WHEN nkill IS NULL THEN 1
            ELSE 0
        END
    ) AS MissingFatalityRecords
FROM dbo.GlobalTerrorism
WHERE country_txt IS NOT NULL
GROUP BY country_txt
ORDER BY TotalFatalities DESC;

/*Key analytical insights
1. Iraq ranks first in both incidents and fatalities

Iraq has 27,521 recorded incidents and 81,675 recorded fatalities, making it the highest-ranked country in both of your analyses.

2. Nigeria ranks third in fatalities despite ranking sixth in incidents

Nigeria has 5,550 incidents but 29,093 recorded fatalities. This illustrates why incident counts alone don't tell the whole story.

3. Syria also stands out

Syria has 2,997 recorded incidents and 18,860 fatalities. Its relatively high fatality total compared with its incident count makes it worth examining further.

4. Missing values must be considered

Somalia has 927 records with missing fatality counts, while Yemen has 831. These missing values could affect comparisons between countries.

Portfolio takeaway: Compare incident counts, recorded fatalities, and missing-data counts together. Avoid interpreting these historical figures as indicators of current risk.*/

--Calculate the Fatality Rate per Attack

SELECT TOP 10
    country_txt AS Country,
    COUNT(*) AS TotalAttacks,
    SUM(nkill) AS TotalFatalities,
    CAST(
        1.0 * SUM(nkill)
        / NULLIF(COUNT(nkill), 0)
        AS DECIMAL(10, 2)
    ) AS AverageFatalitiesPerRecordedIncident,
    SUM(
        CASE
            WHEN nkill IS NULL THEN 1
            ELSE 0
        END
    ) AS MissingFatalityRecords
FROM dbo.GlobalTerrorism
WHERE country_txt IS NOT NULL
GROUP BY country_txt
HAVING COUNT(nkill) > 0
ORDER BY AverageFatalitiesPerRecordedIncident DESC;


/* Key insights

1. Barbados ranks first by average.
It has only three recorded incidents but 76 fatalities, producing an average of 25.33 fatalities per incident. With such a small number of incidents, this average can be heavily influenced by individual events.

2. Rwanda has a high average and a larger incident count.
Rwanda has 3,274 recorded fatalities across 168 incidents, averaging 19.60 per recorded incident.

3. Total and average fatalities tell different stories.

Total fatalities measure the overall recorded human impact.
Average fatalities per incident measure the average recorded death toll per incident.

4. Interpret the results carefully. These figures describe the historical records in your dataset. They don't indicate present-day risk, and missing or incomplete records may affect the averages. */

-- Analyze Year-over-Year Fatality Trends

WITH YearlyFatalities AS
(
    SELECT
        iyear AS AttackYear,
        COUNT(*) AS TotalAttacks,
        SUM(nkill) AS TotalFatalities,
        SUM(
            CASE
                WHEN nkill IS NULL THEN 1
                ELSE 0
            END
        ) AS MissingFatalityRecords
    FROM dbo.GlobalTerrorism
    GROUP BY iyear
),
FatalityComparison AS
(
    SELECT
        AttackYear,
        TotalAttacks,
        TotalFatalities,
        MissingFatalityRecords,
        LAG(TotalFatalities) OVER (
            ORDER BY AttackYear
        ) AS PreviousYearFatalities
    FROM YearlyFatalities
)
SELECT
    AttackYear,
    TotalAttacks,
    TotalFatalities,
    PreviousYearFatalities,
    TotalFatalities - PreviousYearFatalities
        AS FatalityDifference,
    CAST(
        100.0 * (TotalFatalities - PreviousYearFatalities)
        / NULLIF(PreviousYearFatalities, 0)
        AS DECIMAL(10, 2)
    ) AS FatalityPercentageChange,
    MissingFatalityRecords
FROM FatalityComparison
ORDER BY AttackYear;

--Identify the Deadliest Countries by Average Fatalities


SELECT TOP 10
    country_txt AS Country,
    COUNT(*) AS TotalAttacks,
    SUM(nkill) AS TotalFatalities,
    SUM(nwound) AS TotalInjuries,
    CAST(
        1.0 * SUM(nkill)
        / NULLIF(COUNT(nkill), 0)
        AS DECIMAL(10, 2)
    ) AS AverageFatalitiesPerRecordedIncident,
    SUM(
        CASE WHEN nkill IS NULL THEN 1 ELSE 0 END
    ) AS MissingFatalityRecords,
    SUM(
        CASE WHEN nwound IS NULL THEN 1 ELSE 0 END
    ) AS MissingInjuryRecords
FROM dbo.GlobalTerrorism
WHERE country_txt IS NOT NULL
GROUP BY country_txt
ORDER BY SUM(nkill) DESC;

/*Country-Level Terrorism Impact Analysis

The country-level analysis identified Iraq as the country with the highest recorded number of terrorist attacks (27,521), fatalities (81,675), and injuries (139,428) among the countries examined. Afghanistan ranked second in recorded fatalities, with 67,549, while Nigeria ranked third, with 29,093.

Syria recorded the highest average fatalities per incident among these ten countries, at 7.18 fatalities per incident with a recorded fatality value. This demonstrates that countries with the highest total fatalities do not necessarily have the highest average fatalities per incident.

Data completeness is an important consideration when interpreting these findings. Missing fatality and injury records may cause recorded totals to underestimate the actual impact. Therefore, these results should be interpreted as recorded figures rather than complete estimates of the total human impact.
*/

