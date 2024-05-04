-- Computed Column using UDF 
-- Create a UDF to determine whether a wildlife habitat is suitable based on its environmental conditions. 

-- Create a user-defined function to check habitat suitability
CREATE FUNCTION dbo.IsHabitatSuitable (
    @PH_Level DECIMAL(4, 2),
    @Air_Purity DECIMAL(5, 2),
    @Humidity DECIMAL(5, 2),
    @Temperature DECIMAL(5, 2)
)
RETURNS BIT
AS
BEGIN
    DECLARE @Suitable BIT

    -- Define criteria for habitat suitability
    IF @PH_Level >= 6.5 AND @Air_Purity >= 80 AND @Humidity BETWEEN 30 AND 70 AND @Temperature BETWEEN 20 AND 30
        SET @Suitable = 1; -- Suitable
    ELSE
        SET @Suitable = 0; -- Not Suitable

    RETURN @Suitable
END;


-- Add a check constraint using the UDF to ensure habitat suitability
-- ALTER TABLE HABITAT
-- ADD CONSTRAINT CHK_HabitatSuitability CHECK (dbo.IsHabitatSuitable(PH_Level, Air_Purity, Humidity, Temperature) = 1);


-- Use the UDF in a query to find suitable habitats
SELECT *
FROM HABITAT
WHERE dbo.IsHabitatSuitable(PH_Level, Air_Purity, Humidity, Temperature) = 1;