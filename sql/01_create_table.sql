USE GlobalTerrorismDB;
GO

CREATE TABLE dbo.GlobalTerrorism (
    eventid BIGINT NOT NULL PRIMARY KEY,
    iyear SMALLINT,
    imonth TINYINT,
    iday TINYINT,
    country INT,
    country_txt NVARCHAR(100),
    region INT,
    region_txt NVARCHAR(100),
    provstate NVARCHAR(255),
    city NVARCHAR(255),
    latitude FLOAT,
    longitude FLOAT,
    success TINYINT,
    suicide TINYINT,
    attacktype1 TINYINT,
    attacktype1_txt NVARCHAR(100),
    targtype1 TINYINT,
    targtype1_txt NVARCHAR(100),
    targsubtype1 SMALLINT,
    targsubtype1_txt NVARCHAR(255),
    gname NVARCHAR(255),
    weaptype1 TINYINT,
    weaptype1_txt NVARCHAR(100),
    nkill FLOAT,
    nwound FLOAT,
    property SMALLINT,
    propextent TINYINT,
    propextent_txt NVARCHAR(100),
    ishostkid FLOAT,
    INT_LOG SMALLINT,
    INT_IDEO SMALLINT,
    INT_MISC SMALLINT,
    INT_ANY SMALLINT
);
GO

SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'GlobalTerrorism';

EXEC sp_help 'dbo.GlobalTerrorism';