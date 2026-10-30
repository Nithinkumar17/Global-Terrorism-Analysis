USE GlobalTerrorismDB;
GO

SELECT COUNT(*) AS TotalRecords
FROM dbo.GlobalTerrorism;

SELECT
    COUNT(*) AS TotalRows,
    COUNT(ishostkid) AS NonNullValues,
    SUM(CASE
        WHEN ishostkid IS NULL THEN 1
        ELSE 0
    END) AS MissingValues
FROM dbo.GlobalTerrorism;

SELECT
    ishostkid,
    COUNT(*) AS RecordCount
FROM dbo.GlobalTerrorism
GROUP BY ishostkid
ORDER BY ishostkid;


