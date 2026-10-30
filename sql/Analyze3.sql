USE GlobalTerrorismDB;
GO

/* which weapon types were most frequently used.*/

SELECT 
    weaptype1_txt AS WeaponType,
    COUNT(*) AS TotalAttacks,
    SUM(nkill) AS TotalRecordFatalities,
    SUM(nwound) AS TotalRecordInjured,
    SUM(CASE
            WHEN nkill IS NULL THEN 1
            ELSE 0
        END) AS MissingFatalityRecords
FROM dbo.GlobalTerrorism
WHERE weaptype1_txt IS NOT NULL
GROUP BY weaptype1_txt
ORDER BY COUNT(*) DESC;

/*Finding 1: Explosives were the most frequently recorded weapon type

Explosives accounted for 103,475 attacks, approximately 49.3% of all 209,706 incidents in your dataset.

They were also associated with 195,512 recorded fatalities and 418,946 recorded injuries.

Analytical insight: Explosives were the most frequently recorded weapon category and had the highest recorded injury total among the weapon categories in your results.

Finding 2: Firearms had the highest recorded fatality total

Firearms accounted for 67,648 attacks and 199,520 recorded fatalities—the highest recorded fatality total among the listed categories.

Although explosives were used in more incidents, firearms had a higher recorded fatality total.

Analytical insight: The weapon category with the most attacks is not necessarily the category with the most recorded fatalities.

Finding 3: Unknown weapon classifications represent a significant data category

The dataset contains 20,203 attacks whose weapon type is classified as Unknown.

These incidents account for 61,122 recorded fatalities.

Analytical insight: Unknown classifications are important to retain and analyze because excluding them could distort the overall understanding of the dataset.

Finding 4: Some categories have unusually high injury totals relative to their attack counts

For example, the Chemical category contains 347 attacks and 14,303 recorded injuries, while the Vehicle category contains 186 attacks and 22,604 recorded injuries.

These figures deserve further validation before drawing conclusions.

Possible explanations include incidents with unusually large casualty counts, differences in reporting, or data-quality issues. The results alone do not establish which explanation applies.

Finding 5: Missing fatality values need to be considered

Your results show missing fatality counts for several categories:

Explosives: 4,398
Firearms: 3,962
Unknown: 3,381
Incendiary: 690

These missing values should remain NULL unless you have evidence supporting a replacement value. SQL's SUM() ignores NULL, so your totals represent recorded fatalities, not necessarily complete fatality totals.*/

-- Calculate the percentage of attacks by weapon type

WITH WeaponAnalysis AS
(
    SELECT 
          weaptype1_txt AS WeaponType,
          COUNT(*) AS TotalAttacks,
          SUM(nkill) AS TotalRecordFatalities,
          SUM(nwound) AS TotalRecordInjured
     FROM dbo.GlobalTerrorism
     WHERE weaptype1_txt IS NOT NULL
     GROUP BY weaptype1_txt 
)
SELECT 
      WeaponType,
      TotalAttacks,
      CAST(
           100.0 * TotalAttacks
           /SUM(TotalAttacks) OVER()
           AS DECIMAL(6,2)
           ) AS AttackPercentage,
           TotalRecordFatalities,
           TotalRecordInjured
FROM WeaponAnalysis
ORDER BY TotalAttacks DESC;

/* ### Weapon-Type Analysis

The analysis identified explosives as the most frequently recorded weapon category, accounting for 103,475 attacks, approximately 49.3% of the 209,706 incidents in the dataset. Explosives were associated with 195,512 recorded fatalities and 418,946 recorded injuries.

Firearms ranked second by attack frequency, with 67,648 incidents, but recorded the highest fatality total among the weapon categories, at 199,520. This highlights the importance of evaluating attack frequency and human impact as separate measures.

The dataset also contained 20,203 incidents classified under an unknown weapon type. These incidents contributed 61,122 recorded fatalities, making the unknown category relevant to the analysis.

Missing fatality values and unusually high injury totals in some low-frequency categories should be investigated before making further conclusions. All findings represent recorded values and may be affected by incomplete reporting.
*/


-- analyze attacks by target type

SELECT 
      targtype1_txt AS TargetType,
      COUNT(*) AS TotalAttacks,
      SUM(nkill) AS TotalRecordFatalities,
      SUM(nwound) AS TotalRecordInjured,
      SUM(CASE 
             WHEN nkill IS NULL THEN 1
             ELSE 0
        END
        ) AS MissingFatalityRecords
FROM dbo.GlobalTerrorism
WHERE targtype1_txt IS NOT NULL
GROUP BY targtype1_txt
ORDER BY COUNT(*) DESC;

/*Key findings from your results
Finding 1: Private Citizens & Property was the most frequently targeted category
Total attacks: 51,985
Recorded fatalities: 160,566
Recorded injuries: 200,231
Missing fatality records: 3,353

Private Citizens & Property accounted for approximately 24.8% of all 209,706 incidents in your dataset.

Insight: Private citizens and their property represented the largest target category by attack frequency in this dataset.

Finding 2: Military targets ranked second by attack frequency
Metric	Military
Total attacks	34,131
Recorded fatalities	129,385
Recorded injuries	85,765
Missing fatality records	3,033

Military targets experienced the second-highest number of attacks and the second-highest recorded fatality total among the target categories you provided.

Finding 3: Police targets ranked third by attack frequency

Police targets accounted for:

28,568 attacks
65,456 recorded fatalities
75,136 recorded injuries

This category had substantially fewer attacks than Private Citizens & Property, but its recorded fatalities and injuries were also considerable.

Finding 4: Transportation targets had substantial recorded injury totals

Transportation recorded 7,173 attacks, 14,449 fatalities, and 41,477 injuries.

Its recorded injury total was relatively high compared with its attack count. This is worth investigating further, but the totals alone do not explain why the injury count was high.

Finding 5: Government (General) and Business were also prominent categories
Target type	Total attacks	Recorded fatalities	Recorded injuries
Government (General)	23,828	30,064	45,851
Business	22,169	25,283	58,021

Both categories experienced more than 22,000 attacks in the dataset.*/ 


-- Calculate each target type's percentage

WITH TargetAnalysis AS
(  
     SELECT 
          targtype1_txt AS TargetType,
          COUNT(*) AS TotalAttacks,
          SUM(nkill) AS TotalRecordFatalities,
          SUM(nwound) AS TotalRecordInjured
     FROM dbo.GlobalTerrorism
     WHERE targtype1_txt IS NOT NULL
     GROUP BY targtype1_txt
)
SELECT
      TargetType,
      TotalAttacks,
      CAST(
           100.0* TotalAttacks/
           SUM(TotalAttacks) OVER()
           AS DECIMAL(6,2)
        ) AS AttackPercentage,
        TotalRecordFatalities,
        TotalRecordInjured
FROM TargetAnalysis
ORDER BY TotalAttacks DESC;


/* ### Target Type Analysis

The analysis identified Private Citizens & Property as the most frequently targeted category, with 51,985 incidents, approximately 24.8% of all 209,706 recorded incidents. This category also had the highest recorded fatalities (160,566) and injuries (200,231) among the target categories examined.

Military targets ranked second, with 34,131 attacks and 129,385 recorded fatalities. Police targets ranked third in attack frequency, with 28,568 attacks.

Transportation targets recorded 41,477 injuries across 7,173 incidents, making this category worth further investigation when comparing recorded injuries with attack frequency.

These findings demonstrate the value of examining attack frequency, fatalities, and injuries as separate measures. Because some incidents have missing casualty information, all fatality and injury totals should be interpreted as recorded values rather than complete estimates of human impact.
*/

  
-- Analyze successful vs. unsuccessful attacks

SELECT 
     success AS SucessFlag,
     CASE 
         WHEN success = 1 THEN 'Sucessful'
         WHEN success = 0 THEN 'Unsucessful'
         ELSE 'Unknown'
     END AS AttackOutcome,
     COUNT(*) AS TotalAttacks,
     CAST (
          100.0 * COUNT(*)/
          SUM(COUNT(*)) OVER()
          AS DECIMAL(6,2)
          ) AS AttackPercentage,
     SUM(nkill) AS TotalRecordFatalities,
     SUM(nwound) AS TotalRecordInjred
FROM dbo.GlobalTerrorism
GROUP BY success
ORDER BY success DESC; 

/*### Attack Success Analysis

The analysis found that 185,302 of the 209,706 recorded incidents (88.36%) were classified as successful, while 24,404 incidents (11.64%) were classified as unsuccessful.

Successful incidents accounted for 459,830 recorded fatalities and 569,893 recorded injuries. Unsuccessful incidents accounted for 19,518 recorded fatalities and 15,713 recorded injuries.

Using the total number of incidents in each group, successful incidents averaged approximately 2.48 recorded fatalities and 3.08 recorded injuries per incident. The corresponding averages for unsuccessful incidents were approximately 0.80 fatalities and 0.64 injuries per incident.

These results describe associations in the dataset and should not be interpreted as evidence of causation. Missing casualty values may affect the averages and totals.
*/



-- Analyze suicide attacks

SELECT 
     suicide AS SucessFlag,
     CASE 
         WHEN suicide = 1 THEN 'Sucide Attack'
         WHEN suicide = 0 THEN 'Non Sucide Attack'
         ELSE 'Unknown'
     END AS AttackCategory,
     COUNT(*) AS TotalAttacks,
     CAST (
          100.0 * COUNT(*)/
          SUM(COUNT(*)) OVER()
          AS DECIMAL(6,2)
          ) AS AttackPercentage,
     SUM(nkill) AS TotalRecordFatalities,
     SUM(nwound) AS TotalRecordInjred,
     SUM(
         CASE
             WHEN nkill IS NULL THEN 1
             ELSE 0
         END
        ) AS MissingFatalityRecord
FROM dbo.GlobalTerrorism
GROUP BY suicide
ORDER BY suicide DESC; 


/* Suicide Attack Analysis

The analysis identified 7,438 suicide attacks, representing 3.55% of the 209,706 recorded incidents. The remaining 202,268 incidents (96.45%) were classified as non-suicide attacks.

Suicide attacks were associated with 74,128 recorded fatalities and 146,765 recorded injuries. Non-suicide attacks accounted for 405,220 recorded fatalities and 438,841 recorded injuries.

When divided by the total number of incidents in each category, suicide attacks averaged approximately 9.97 recorded fatalities and 19.73 recorded injuries per incident. The corresponding averages for non-suicide attacks were approximately 2.00 fatalities and 2.17 injuries per incident.

These findings indicate a higher recorded casualty burden per incident for suicide attacks in this dataset. They describe an observed association rather than a causal relationship. Missing casualty records should be considered when interpreting the results.1*/

-- One important SQL improvement

SELECT 
      suicide AS SuicideFlag,
      CASE
          WHEN suicide = 1 THEN 'Suicide Attack'
          WHEN suicide = 0 THEN 'Non-Suicide Attack'
          ELSE 'Unknown'
      END AS AttackCategory,
      COUNT(*) AS TotalAttacks,
      CAST(
           100.0 * COUNT(*)/
           SUM(COUNT(*)) OVER()
           AS DECIMAL(6,2)
           ) AS AttackPercentage,
      SUM(nkill) AS TotalRecordedFatalities,
      SUM(nwound) AS TotalRecordedInjuries,
      CAST(
           1.0 * SUM(nkill)/
           NULLIF(COUNT(nkill),0)
           AS DECIMAL(10,2)
           ) AS AvgFatalitiesRecordedperAttack,
      CAST(
           1.0 * SUM(nwound)/
           NULLIF(COUNT(nwound),0)
           AS DECIMAL(10,2)
           ) AS AvgInjuriesRecordedperAttack,
      SUM(CASE
              WHEN nkill IS NULL THEN 1 ELSE 0 END
        ) AS MissingfaltalityRecords,
      SUM(CASE
              WHEN nwound IS NULL THEN 1 ELSE 0 END
        ) AS MissingfaltalityRecords
FROM dbo.GlobalTerrorism
GROUP BY suicide
ORDER BY suicide DESC;


/*### Suicide Attack Analysis

The analysis identified 7,438 suicide attacks, representing 3.55% of the 209,706 recorded incidents. The remaining 202,268 incidents (96.45%) were classified as non-suicide attacks.

Suicide attacks were associated with 74,128 recorded fatalities and 146,765 recorded injuries. Non-suicide attacks accounted for 405,220 recorded fatalities and 438,841 recorded injuries.

Among incidents with recorded fatality values, suicide attacks averaged 10.14 fatalities per incident, compared with 2.13 for non-suicide attacks. Among incidents with recorded injury values, the corresponding averages were 21.27 and 2.40 injuries per incident.

These results show a higher recorded casualty burden per incident for suicide attacks in this dataset, while non-suicide attacks accounted for higher overall recorded casualty totals. Missing casualty values should be considered when interpreting these findings.
*/