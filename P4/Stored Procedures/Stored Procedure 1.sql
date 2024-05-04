-- Create ErrorLog table if not exists
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ErrorLog')
BEGIN
    CREATE TABLE ErrorLog (
        LogId INT PRIMARY KEY IDENTITY(1,1),
        ErrorMessage NVARCHAR(MAX),
        ErrorSeverity INT,
        ErrorState INT
    );
END
GO

-- Procedure 1: Create stored procedure to get Flora information based on Habitat ID
CREATE PROCEDURE GetFloraInfoByHabitatID
    @InputHabitatID INT,
    @OutputFloraID INT OUT,
    @OutputFloraSpecies VARCHAR(255) OUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Declare variables to store the output values
        DECLARE @FloraID INT;
        DECLARE @FloraSpecies VARCHAR(255);

        -- Retrieve Flora information based on Habitat ID
        SELECT
            @FloraID = F.Flora_Id,
            @FloraSpecies = F.Species
        FROM
            HABITAT H
        INNER JOIN
            FLORA_HABITAT FH ON H.Habitat_Id = FH.Habitat_Id
        INNER JOIN
            FLORA F ON FH.Flora_Id = F.Flora_Id
        WHERE
            H.Habitat_Id = @InputHabitatID;

        -- Check if Flora information is found
        IF (@FloraID IS NULL)
        BEGIN
            -- Raise an error and terminate the stored procedure
            THROW 50000, 'Flora information not found for the specified Habitat ID.', 1;
        END

        -- Assign values to output parameters
        SET @OutputFloraID = @FloraID;
        SET @OutputFloraSpecies = @FloraSpecies;

        COMMIT; -- Commit the transaction
    END TRY
    BEGIN CATCH
        -- Rollback the transaction
        IF @@TRANCOUNT > 0
            ROLLBACK;

        -- Log the error
        INSERT INTO ErrorLog (ErrorMessage, ErrorSeverity, ErrorState)
        VALUES (ERROR_MESSAGE(), ERROR_SEVERITY(), ERROR_STATE());

        -- Re-throw the error to the calling application
        THROW;
    END CATCH;
END;



--************************COMMAND TO EXECUTE Procedure 1************************
--DECLARE @HabitatID INT = 1;
--DECLARE @FloraIDResult INT;
--DECLARE @FloraSpeciesResult VARCHAR(255);

--EXEC GetFloraInfoByHabitatID
--    @InputHabitatID = @HabitatID,
--    @OutputFloraID = @FloraIDResult OUTPUT,
--    @OutputFloraSpecies = @FloraSpeciesResult OUTPUT;

---- Display the results
--PRINT 'Flora ID: ' + CAST(@FloraIDResult AS VARCHAR(10));
--PRINT 'Flora Species: ' + @FloraSpeciesResult;
