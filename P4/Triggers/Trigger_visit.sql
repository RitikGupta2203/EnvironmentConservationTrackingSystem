USE [WildlifeSanctuary]
GO





--------Trigger----------
---Update Visit's feedback if no feedback is provided 
   CREATE TRIGGER SetDefaultFeedback
ON VISITS
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO VISITS (Visit_Id, Sanctuary_Id, Tourist_Id, Date_of_Visit, Feedback)
    SELECT 
        Visit_Id, 
        Sanctuary_Id, 
        Tourist_Id, 
        Date_of_Visit, 
        ISNULL(Feedback, 'No Feedback Provided') AS Feedback
    FROM INSERTED;
END;


