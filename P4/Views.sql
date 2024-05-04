USE WildlifeSanctuary
Go
----------VIEW ----------------------

--This View provides the complete Employee Information:
CREATE VIEW EmployeeInformation AS
SELECT
    E.Employee_ID,
    E.Employee_Name,
    E.Experience_Years,
    E.Date_Joined,
    C.PLANT_CARE_SPECIALISATION AS Caretaker_Specialization,
    S.CERTIFICATION AS Sanctuary_Staff_Certification,
    G.TRAINING_AND_CERTIFICATIONS AS Guide_Training,
    C1.LEVEL_OF_COACHING AS Coach_Level,
    V.YEARS_OF_EXPERIENCE AS Vet_Years_of_Experience,
    V.SPECIALISATION AS Vet_Specialization
FROM EMPLOYEE E
LEFT JOIN CARETAKER C ON E.Employee_ID = C.CARETAKER_ID
LEFT JOIN SANCTUARY_STAFF S ON E.Employee_ID = S.SANCTUARY_STAFF_ID
LEFT JOIN GUIDE G ON E.Employee_ID = G.GUIDE_ID
LEFT JOIN COACHES C1 ON E.Employee_ID = C1.COACH_ID
LEFT JOIN VET V ON E.Employee_ID = V.VET_ID;

SELECT * FROM EmployeeInformation;



--This view combines information about tourist visits and their feedback.   
CREATE VIEW VisitFeedbackView AS
SELECT
    V.Visit_Id,
    V.Date_of_Visit,
    S.Name AS Sanctuary_Name,
    T.Tourist_Name,
    T.Phone_Number,
    V.Feedback
FROM
    VISITS V
JOIN SANCTUARY S ON V.Sanctuary_Id = S.Sanctuary_Id
JOIN TOURIST T ON V.Tourist_Id = T.Tourist_Id;

SELECT * FROM VisitFeedbackView;




--This view combines information from the HABITAT and FLORA tables to provide details about the habitats in the Wildlife Sanctuary, including the flora in each habitat.
CREATE VIEW HabitatDetails AS
SELECT
    H.Habitat_Id,
    H.Sanctuary_Id,
    H.Habitat_Type,
    H.Habitat_Size,
    H.PH_Level,
    H.Soil_Fertility,
    H.Air_Purity,
    H.Humidity,
    H.Temperature,
    F.Species AS Flora_Species
FROM HABITAT H
LEFT JOIN FLORA_HABITAT FH ON H.Habitat_Id = FH.Habitat_Id
LEFT JOIN FLORA F ON FH.Flora_Id = F.Flora_Id;


SELECT * FROM HabitatDetails;


--This view combines information from the WILDLIFE_TRACKING, WILDLIFE, and EMPLOYEE tables to provide tracking details along with associated wildlife and employee information.                                                                                                                            
CREATE VIEW WildlifeTrackingInformations AS
SELECT
    WT.Tracking_Id,
    WT.GPS_location,
    WT.Tracking_Date,
    W.Wildlife_ID,
    W.Wildlife_Type,
    W.Population,
    W.Species,
    E.Employee_ID,
    E.Employee_Name
FROM WILDLIFE_TRACKING WT
JOIN WILDLIFE W ON WT.WildLife_Id = W.Wildlife_ID
JOIN EMPLOYEE E ON WT.Employee_Id = E.Employee_ID;

SELECT * FROM WildlifeTrackingInformations;


--This view combines information about caretakers and the flora they take care of. 
CREATE VIEW CaretakerInformationView AS
SELECT
    C.Caretaker_ID,
    E.Employee_Name,
    E.Experience_Years,
    C.PLANT_CARE_SPECIALISATION,
    F.Species AS Flora_Species
FROM
    CARETAKER C
JOIN EMPLOYEE E ON C.Caretaker_ID = E.Employee_ID
JOIN FLORA F ON C.Caretaker_ID = F.Caretaker_Id

SELECT * FROM CaretakerInformationView;


