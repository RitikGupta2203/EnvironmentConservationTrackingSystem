-- Drop the database if it exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'WildlifeSanctuary')
DROP DATABASE WildlifeSanctuary
GO

-- Create the database
CREATE DATABASE [WildlifeSanctuary]
GO

-- Use the created database
USE [WildlifeSanctuary]
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Wildlife@2023';

CREATE CERTIFICATE EnvCert WITH SUBJECT = 'Environment Conservatory Encryption';

CREATE SYMMETRIC KEY EnvSymmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE EnvCert;


-- Create tables for RITIK
CREATE TABLE SANCTUARY (
    Sanctuary_Id INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Area DECIMAL(10, 2) NOT NULL
);
-- Index for the WHERE clause in SANCTUARY table
CREATE NONCLUSTERED INDEX IX_Sanctuary_Name
ON SANCTUARY (Name);

-- Execute CREATE FUNCTION dbo.CalculateAge before this
CREATE FUNCTION dbo.CalculateAge (@DateOfBirth DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Age INT

    SET @Age = DATEDIFF(YEAR, @DateOfBirth, GETDATE())

    RETURN @Age
END;

CREATE TABLE EMPLOYEE (
    Employee_ID INT NOT NULL IDENTITY(1,1),
    Employee_Name VARCHAR(255) NOT NULL,
    Experience_Years INT CHECK (Experience_Years >= 1),
    Date_Joined DATE NOT NULL,
    Date_Of_Birth DATE NOT NULL CHECK (DATEDIFF(YEAR, Date_Of_Birth, GETDATE()) >= 18),
    Sex VARCHAR(10) NOT NULL CHECK (Sex IN ('Male', 'Female', 'Other')), -- Added check constraint for Sex
    Age AS dbo.CalculateAge(Date_Of_Birth),
    SSN VARBINARY(8000),
    CONSTRAINT EmployeeID_PK PRIMARY KEY (Employee_ID)
);
-- Index for the WHERE clause in EMPLOYEE table
CREATE NONCLUSTERED INDEX IX_Employee_Name
ON EMPLOYEE (Employee_Name);


CREATE TABLE CARETAKER (
    CARETAKER_ID INT NOT NULL,
    PLANT_CARE_SPECIALISATION VARCHAR(255) NOT NULL,
    EDUCATION_LEVEL VARCHAR(255) NOT NULL,
    CONSTRAINT CARETAKER_PK PRIMARY KEY (CARETAKER_ID),
    CONSTRAINT CARETAKER_EMPLOYEE_FK FOREIGN KEY( CARETAKER_ID) REFERENCES EMPLOYEE(Employee_ID)
);
-- Index for the WHERE clause in CARETAKER table
CREATE NONCLUSTERED INDEX IX_Caretaker_PLANT_CARE_SPECIALISATION
ON CARETAKER (PLANT_CARE_SPECIALISATION);


CREATE TABLE SANCTUARY_STAFF (
    SANCTUARY_STAFF_ID INT NOT NULL ,
    CERTIFICATION VARCHAR(255) NOT NULL,
    EDUCATION_AND_TRAINING VARCHAR(255) NOT NULL,
    CONSTRAINT SANCTUARY_STAFF_PK PRIMARY KEY (SANCTUARY_STAFF_ID),
    CONSTRAINT SANCTUARY_STAFF_EMPLOYEE_FK FOREIGN KEY( SANCTUARY_STAFF_ID) REFERENCES EMPLOYEE(Employee_ID)
);
-- Index for the WHERE clause in SANCTUARY_STAFF table
CREATE NONCLUSTERED INDEX IX_Sanctuary_Staff_CERTIFICATION
ON SANCTUARY_STAFF (CERTIFICATION);


CREATE TABLE GUIDE (
    GUIDE_ID INT NOT NULL ,
    TRAINING_AND_CERTIFICATIONS VARCHAR(255) NOT NULL,
    CONSTRAINT GUIDE_PK PRIMARY KEY (GUIDE_ID),
    CONSTRAINT GUIDE_EMPLOYEE_FK FOREIGN KEY( GUIDE_ID) REFERENCES EMPLOYEE(Employee_ID)
);
-- Index for the WHERE clause in GUIDE table
CREATE NONCLUSTERED INDEX IX_Guide_TRAINING_AND_CERTIFICATIONS
ON GUIDE (TRAINING_AND_CERTIFICATIONS);


CREATE TABLE COACHES (
    COACH_ID INT NOT NULL ,
    LEVEL_OF_COACHING VARCHAR(255) NOT NULL,
    CONSTRAINT COACHES_PK PRIMARY KEY (COACH_ID),
    CONSTRAINT COACHES_EMPLOYEE_FK FOREIGN KEY( COACH_ID) REFERENCES EMPLOYEE(Employee_ID)
);
-- Index for the WHERE clause in COACHES table
CREATE NONCLUSTERED INDEX IX_Coaches_LEVEL_OF_COACHING
ON COACHES (LEVEL_OF_COACHING);

-- Execute CREATE FUNCTION dbo.IsHabitatSuitable before this

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


CREATE TABLE HABITAT (
    Habitat_Id INT PRIMARY KEY,
    Sanctuary_Id INT,
    Habitat_Type VARCHAR(255) NOT NULL,
    Habitat_Size DECIMAL(10, 2) NOT NULL,
    PH_Level DECIMAL(4, 2) CHECK (PH_Level >= 0 AND PH_Level <= 14),
    Soil_Fertility VARCHAR(50) NOT NULL,
    Air_Purity DECIMAL(5, 2) CHECK (Air_Purity >= 0),
    Humidity DECIMAL(5, 2) CHECK (Humidity >= 0),
    Temperature DECIMAL(5, 2) CHECK (Temperature >= 0),
    suitability AS CASE WHEN dbo.IsHabitatSuitable(PH_Level, Air_Purity, Humidity, Temperature) = 1 THEN 'SUITABLE' ELSE 'UNSUITABLE' END,
    FOREIGN KEY (Sanctuary_Id) REFERENCES SANCTUARY(Sanctuary_Id)
);

-- Index for the WHERE clause in HABITAT table
CREATE NONCLUSTERED INDEX IX_Habitat_Habitat_Type
ON HABITAT (Habitat_Type);


CREATE TABLE FLORA (
    Flora_Id INT PRIMARY KEY,
    Caretaker_Id INT,
    Species VARCHAR(255) NOT NULL,
    FOREIGN KEY (Caretaker_Id) REFERENCES CARETAKER(Caretaker_Id)
);
-- Index for the WHERE clause in FLORA table
CREATE NONCLUSTERED INDEX IX_Flora_Species
ON FLORA (Species);


CREATE TABLE FLORA_HABITAT (
    Habitat_Id INT,
    Flora_Id INT,
    PRIMARY KEY (Habitat_Id, Flora_Id),
    FOREIGN KEY (Habitat_Id) REFERENCES HABITAT(Habitat_Id),
    FOREIGN KEY (Flora_Id) REFERENCES FLORA(Flora_Id)
);


-- Create tables for SOMIL
CREATE TABLE VET (
  VET_ID INT NOT NULL,
  LICENSE_NUMBER INT NOT NULL,
  YEARS_OF_EXPERIENCE INT NOT NULL,
  SPECIALISATION VARCHAR(255) NOT NULL,
  CONSTRAINT VET_PK PRIMARY KEY (VET_ID),
  CONSTRAINT VET_EMPLOYEE_FK FOREIGN KEY( VET_ID) REFERENCES EMPLOYEE(Employee_ID)
);
-- Index for the WHERE clause in VET table
CREATE NONCLUSTERED INDEX IX_Vet_SPECIALISATION
ON VET (SPECIALISATION);


CREATE TABLE WILDLIFE (
  Wildlife_ID INT NOT NULL IDENTITY(1,1),
  VET_ID int NOT NULL,
  Wildlife_Type varchar(50) NOT NULL CHECK (Wildlife_Type IN ('Carnivore', 'Herbivore', 'Omnivore')),  
  Population int NOT NULL,
  Species varchar(50) NOT NULL,
  CONSTRAINT WILDLIFE_PK PRIMARY KEY (Wildlife_ID),
  CONSTRAINT WILDLIFE_VET_FK FOREIGN KEY (VET_ID) REFERENCES VET (VET_ID)
);
-- Index for the WHERE clause in WILDLIFE table
CREATE NONCLUSTERED INDEX IX_Wildlife_Wildlife_Type
ON WILDLIFE (Wildlife_Type);


CREATE TABLE CARNIVORE (
  Carnivore_ID int NOT NULL,
  Pack_Size int NOT NULL,
  Hunting_Activity_Period varchar(50) NOT NULL,
  CONSTRAINT CARNIVORE_PK PRIMARY KEY (Carnivore_ID),
  CONSTRAINT CARNIVORE_WILDLIFE_FK FOREIGN KEY(Carnivore_ID) REFERENCES WILDLIFE(Wildlife_ID)
);
-- Index for the WHERE clause in CARNIVORE table
CREATE NONCLUSTERED INDEX IX_Carnivore_Pack_Size
ON CARNIVORE (Pack_Size);


CREATE TABLE OMNIVORE (
  Omnivore_ID int NOT NULL,
  Foraging_Behavior varchar(100) NOT NULL,
  CONSTRAINT OMNIVORE_PK PRIMARY KEY (Omnivore_ID),
  CONSTRAINT OMNIVORE_WILDLIFE_FK FOREIGN KEY(Omnivore_ID) REFERENCES WILDLIFE(Wildlife_ID)
);
-- Index for the WHERE clause in OMNIVORE table
CREATE NONCLUSTERED INDEX IX_Omnivore_Foraging_Behavior
ON OMNIVORE (Foraging_Behavior);


CREATE TABLE HERBIVORE (
  Herbivore_ID int NOT NULL,
  Grazing_Habits varchar(100) NOT NULL,
  Migratory_Patterns varchar(100) NOT NULL,
  CONSTRAINT HERBIVORE_PK PRIMARY KEY (Herbivore_ID),
  CONSTRAINT HERBIVORE_WILDLIFE_FK FOREIGN KEY(Herbivore_ID) REFERENCES WILDLIFE(Wildlife_ID)
);
-- Index for the WHERE clause in HERBIVORE table
CREATE NONCLUSTERED INDEX IX_Herbivore_Grazing_Habits
ON HERBIVORE (Grazing_Habits);


CREATE TABLE WILDLIFE_TRACKING (
    Tracking_Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    WildLife_Id INT NOT NULL,
    Employee_Id INT NOT NULL,
    GPS_location VARCHAR(255) NOT NULL, -- Adjust the data type based on the actual requirements
    Tracking_Date DATE NOT NULL,
    CONSTRAINT WildlifeTracking_Wildlife_FK 
        FOREIGN KEY (WildLife_Id) REFERENCES WILDLIFE(WildLife_Id), -- Replace 'WILDLIFE' with the actual table name
    CONSTRAINT WildlifeTracking_Employee_FK 
        FOREIGN KEY (Employee_Id) REFERENCES EMPLOYEE(Employee_ID), 
    CONSTRAINT CHK_Tracking_Date 
        CHECK (Tracking_Date <= GETDATE()) -- Assuming future tracking dates are not allowed
);

-- Create tables for CHERIL
CREATE TABLE TOURIST (
    Tourist_Id INT PRIMARY KEY,
    Guide_Id INT,
    Sanctuary_Id INT,
    Tourist_Name VARCHAR(255) NOT NULL,
    Phone_Number VARCHAR(10) CHECK (LEN(Phone_Number) = 10 AND Phone_Number NOT LIKE '%[^0-9]%'),
    Email VARCHAR(255),
    FOREIGN KEY (Guide_Id) REFERENCES GUIDE(Guide_Id),
    FOREIGN KEY (Sanctuary_Id) REFERENCES SANCTUARY(Sanctuary_Id)
);
-- Index for the WHERE clause in TOURIST table
CREATE NONCLUSTERED INDEX IX_Tourist_Tourist_Name
ON TOURIST (Tourist_Name);



CREATE TABLE VISITS (
    Visit_Id INT PRIMARY KEY,
    Sanctuary_Id INT,
    Tourist_Id INT,
    Date_of_Visit DATE,
    Feedback VARCHAR(500), -- Adjust the length based on your requirements
    CHECK (Date_of_Visit IS NOT NULL),
    FOREIGN KEY (Sanctuary_Id) REFERENCES SANCTUARY(Sanctuary_Id),
    FOREIGN KEY (Tourist_Id) REFERENCES TOURIST(Tourist_Id)
);
-- Index for the WHERE clause in VISITS table
CREATE NONCLUSTERED INDEX IX_Visits_Date_of_Visit
ON VISITS (Date_of_Visit);


CREATE TABLE OUTREACH_PROGRAM (
    Program_Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Coach_Id INT NOT NULL,
    Organisation_Name VARCHAR(255) NOT NULL,
    Organisation_Type VARCHAR(255) NOT NULL,
    Date_of_Affiliation DATE NOT NULL,
    Program_Period INT ,
    CONSTRAINT Outreach_Program_Coach_FK 
        FOREIGN KEY (Coach_Id) REFERENCES COACHES(COACH_ID)
);
-- Index for the WHERE clause in OUTREACH_PROGRAM table
CREATE NONCLUSTERED INDEX IX_Outreach_Program_Organisation_Name
ON OUTREACH_PROGRAM (Organisation_Name);


CREATE TABLE VOLUNTEER (
    Volunteer_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Program_Id INT NOT NULL,
    Coach_Id INT NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    CONSTRAINT Volunteer_Program_FK 
        FOREIGN KEY (Program_Id) REFERENCES Outreach_Program(Program_Id),
    CONSTRAINT Volunteer_Coach_FK 
        FOREIGN KEY (Coach_Id) REFERENCES COACHES(COACH_ID),
    CONSTRAINT CHK_StartDate_EndDate 
        CHECK (Start_Date <= End_Date)
);
-- Index for the WHERE clause in VOLUNTEER table
CREATE NONCLUSTERED INDEX IX_Volunteer_Name
ON VOLUNTEER (Name);

-------------shweta

CREATE TABLE SUPPLIER (
    Supplier_ID INT PRIMARY KEY,
    Supplier_Name VARCHAR(255) NOT NULL,
    Contact VARCHAR(255) NOT NULL
);

CREATE TABLE FOOD (
    food_id INT PRIMARY KEY,
    food_name VARCHAR(255),
    food_type VARCHAR(255)
);

CREATE TABLE FOOD_SUPPLY (
    supply_ID INT PRIMARY KEY,
    Food_id INT,
    supplier_id INT,
    Food_Quantity INT CHECK (FOOD_Quantity > 0),
    restocking_date DATE NOT NULL,
    date_of_delivery DATE NOT NULL,
    FOREIGN KEY (Food_id) REFERENCES FOOD(Food_id),
    FOREIGN KEY (supplier_id) REFERENCES SUPPLIER(supplier_id),
    CHECK (restocking_date <= date_of_delivery)
);
CREATE INDEX idx_food_supply ON FOOD_SUPPLY (Food_ID, Supplier_ID);


CREATE TABLE WILDLIFE_FOOD (
    Wildlife_ID INT,
    Food_ID INT,
    Quantity_Supplied INT CHECK (Quantity_Supplied > 0),
    Date_Supplied DATE NOT NULL,
    FOREIGN KEY (Wildlife_ID) REFERENCES WILDLIFE(Wildlife_ID),
    FOREIGN KEY (Food_ID) REFERENCES FOOD(Food_ID)
);
CREATE INDEX idx_wildlife_food ON WILDLIFE_FOOD (Wildlife_ID, Food_ID);


CREATE TABLE WILDLIFE_HABITAT (
    WildlifeHabitat_Id INT PRIMARY KEY,
    Wildlife_Id INT,
    Habitat_Id INT,
    Date_of_Localisation DATE,
    FOREIGN KEY (Wildlife_Id) REFERENCES WILDLIFE(Wildlife_ID),
    FOREIGN KEY (Habitat_Id) REFERENCES HABITAT(Habitat_Id),
    CHECK (Date_of_Localisation <= GETDATE())  
);
-- Create a non-clustered index on Date_of_Localisation column
CREATE NONCLUSTERED INDEX IX_Wildlife_Habitat_Date_of_Localisation
ON WILDLIFE_HABITAT (Date_of_Localisation);






-------ALTER Tourist --------
ALTER TABLE Tourist
ADD CONSTRAINT CK_ValidEmail
CHECK (Email LIKE '%_@__%._%');