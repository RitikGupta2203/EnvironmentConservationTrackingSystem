-- For single employees
-- ALTER FUNCTION dbo.IsEmployeeType(@EmployeeID INT)
-- RETURNS VARCHAR(50)
-- AS
-- BEGIN
--     DECLARE @EmployeeType varchar(50);

--     SELECT @EmployeeType = CASE
--         WHEN EXISTS (SELECT 1 FROM SANCTUARY_STAFF WHERE SANCTUARY_STAFF_ID = @EmployeeID) THEN 'Sanctuary Staff' 
--         WHEN EXISTS (SELECT 1 FROM CARETAKER WHERE CARETAKER_ID = @EmployeeID) THEN 'Caretaker'
--         WHEN EXISTS (SELECT 1 FROM GUIDE WHERE GUIDE_ID = @EmployeeID) THEN  'Guide' 
--         WHEN EXISTS (SELECT 1 FROM COACHES WHERE COACH_ID = @EmployeeID) THEN  'Coach' 
--         ELSE NULL
--     END;

--     RETURN @EmployeeType;
-- END;


CREATE FUNCTION dbo.IsEmployeeType(@EmployeeID INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @EmployeeTypes VARCHAR(100);

    IF EXISTS (SELECT 1 FROM SANCTUARY_STAFF WHERE SANCTUARY_STAFF_ID = @EmployeeID)
        SET @EmployeeTypes = 'Sanctuary Staff';

    IF EXISTS (SELECT 1 FROM CARETAKER WHERE CARETAKER_ID = @EmployeeID)
        SET @EmployeeTypes = ISNULL(@EmployeeTypes + ',', '') + 'Caretaker';

    IF EXISTS (SELECT 1 FROM GUIDE WHERE GUIDE_ID = @EmployeeID)
        SET @EmployeeTypes = ISNULL(@EmployeeTypes + ',', '') + 'Guide';

    IF EXISTS (SELECT 1 FROM COACHES WHERE COACH_ID = @EmployeeID)
        SET @EmployeeTypes = ISNULL(@EmployeeTypes + ',', '') + 'Coach';

    IF EXISTS (SELECT 1 FROM VET WHERE VET_ID = @EmployeeID)
        SET @EmployeeTypes = ISNULL(@EmployeeTypes + ',', '') + 'Vet';

    RETURN @EmployeeTypes;
END;

-- for select
select e.*, dbo.IsEmployeeType(e.Employee_ID)  
from employee e;