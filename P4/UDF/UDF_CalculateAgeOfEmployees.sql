-- Computed Column using UDF 
-- Create a user-defined function to calculate age


-- Create a user-defined function to calculate age
CREATE FUNCTION dbo.CalculateAge (@DateOfBirth DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Age INT

    SET @Age = DATEDIFF(YEAR, @DateOfBirth, GETDATE())

    RETURN @Age
END;

-- Add a computed column to EMPLOYEE table using the UDF
-- ALTER TABLE EMPLOYEE
-- ADD Age AS dbo.CalculateAge(Date_Joined) ;

-- ALTER TABLE EMPLOYEE
-- ADD CONSTRAINT CHK_CheckEmployeeAge CHECK (dbo.CalculateAge(Date_Joined) >= 18);

-- ALTER TABLE [dbo].[EMPLOYEE]  WITH CHECK ADD CHECK  ((dbo.CalculateAge(Date_Joined) >= 18));


-- Use the UDF in a query to retrieve the age of employees
-- SELECT *
-- FROM EMPLOYEE;
