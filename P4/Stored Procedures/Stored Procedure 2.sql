-- Procedure 2: Create stored procedure to get Wildlife information based on Habitat ID
CREATE PROCEDURE GetWildlifeInfoByHabitatID
    @InputHabitatID INT,
    @OutputWildlifeID INT OUT,
    @OutputSpecies VARCHAR(50) OUT,
    @OutputType VARCHAR(50) OUT,
    @CommitTransaction BIT = 1
AS
BEGIN
    IF @CommitTransaction = 1
        BEGIN TRANSACTION;

    DECLARE @ErrorOccurred BIT = 0;

    BEGIN TRY
        SET NOCOUNT ON;

        -- Declare variables to store the output values
        DECLARE @WildlifeID INT;
        DECLARE @Species VARCHAR(50);
        DECLARE @Type VARCHAR(50);

        -- Retrieve Wildlife information based on Habitat ID
        SELECT
            @WildlifeID = W.Wildlife_ID,
            @Species = W.Species,
            @Type = W.Wildlife_Type
        FROM
            HABITAT H
        INNER JOIN
            WILDLIFE_HABITAT WH ON H.Habitat_Id = WH.Habitat_Id
        INNER JOIN
            WILDLIFE W ON WH.Wildlife_Id = W.Wildlife_ID
        WHERE
            H.Habitat_Id = @InputHabitatID;

        -- Check if Wildlife information is found
        IF (@WildlifeID IS NULL)
        BEGIN
            SET @ErrorOccurred = 1;
            -- Raise an error and terminate the stored procedure
            THROW 50000, 'Wildlife information not found for the specified Habitat ID.', 1;
        END

        -- Assign values to output parameters
        SET @OutputWildlifeID = @WildlifeID;
        SET @OutputSpecies = @Species;
        SET @OutputType = @Type;
    END TRY
    BEGIN CATCH
        SET @ErrorOccurred = 1;
        -- Log the error
        INSERT INTO ErrorLog (ErrorMessage, ErrorSeverity, ErrorState)
        VALUES (ERROR_MESSAGE(), ERROR_SEVERITY(), ERROR_STATE());

        -- Re-throw the error to the calling application
        THROW;
    END CATCH;

    IF @CommitTransaction = 1
    BEGIN
        IF @ErrorOccurred = 1
            ROLLBACK;
        ELSE
            COMMIT; -- Commit the transaction
    END
END;


--************************COMMAND TO EXECUTE Procedure 2************************
--DECLARE @HabitatID INT = 1; -- Provide the desired Habitat ID
--DECLARE @WildlifeIDResult INT;
--DECLARE @SpeciesResult VARCHAR(50);
--DECLARE @TypeResult VARCHAR(50);

--EXEC GetWildlifeInfoByHabitatID
--    @InputHabitatID = @HabitatID,
--    @OutputWildlifeID = @WildlifeIDResult OUTPUT,
--    @OutputSpecies = @SpeciesResult OUTPUT,
--    @OutputType = @TypeResult OUTPUT,
--    @CommitTransaction = 1; -- Set to 1 to commit the transaction

---- Display the results
--PRINT 'Wildlife ID: ' + CAST(@WildlifeIDResult AS VARCHAR(10));
--PRINT 'Species: ' + @SpeciesResult;
--PRINT 'Type: ' + @TypeResult;

