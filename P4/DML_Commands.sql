USE WildlifeSanctuary;
GO

------------INSERT DATA-------------

----SANCTUARY
INSERT INTO SANCTUARY (Sanctuary_Id, Name, Location, Area)
VALUES
  (1, 'GreenValley Sanctuary', 'Forest Hills', 1500.75),
  (2, 'WildLife Haven', 'Mountain Range', 2000.50),
  (3, 'Natures Refuge', 'River Valley', 1800.25),
  (4, 'Serenity Sanctuary', 'Meadow Plains', 1200.00),
  (5, 'Azure Forest Reserve', 'Coastal Area', 2500.30),
  (6, 'Harmony Wildlife Park', 'Canyon Region', 3000.75),
  (7, 'Majestic Wilderness', 'Plateau Zone', 2200.40),
  (8, 'Tranquil Oasis', 'Desert Area', 1700.60),
  (9, 'Eco Harmony Reserve', 'Tropical Rainforest', 2800.20),
  (10, 'Evergreen Wildlife Preserve', 'Island Oasis', 1900.80);


----EMPLOYEE

-- ALTER TABLE EMPLOYEE
-- DROP CONSTRAINT UQ__EMPLOYEE__CA1E8E3C974707EA;

-- ALTER TABLE EMPLOYEE
-- ALTER COLUMN SSN VARBINARY(8000);

-- ALTER TABLE EMPLOYEE
-- ADD SSN_NEW VARBINARY(8000);
-- UPDATE EMPLOYEE
-- SET SSN_NEW = CONVERT(VARBINARY(8000), SSN);

-- ALTER TABLE EMPLOYEE
-- DROP COLUMN SSN;

-- EXEC sp_rename 'EMPLOYEE.SSN_NEW', 'SSN', 'COLUMN';

OPEN SYMMETRIC KEY EnvSymmetricKey
   DECRYPTION BY CERTIFICATE EnvCert;

INSERT INTO EMPLOYEE (Employee_Name, Experience_Years, Date_Joined, Date_Of_Birth, Sex, SSN) 
VALUES 
('John Smith', 5, '2018-01-10', '1998-04-19', 'Male', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '123-45-6789')),
('Emily Johnson', 3, '2020-04-15', '1997-04-15', 'Female', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '234-56-7890')),
('Michael Brown', 7, '2016-05-30', '1999-05-30', 'Male', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '345-67-8901')),
('Jessica Davis', 2, '2021-02-20', '1999-02-20', 'Female', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '456-78-9012')),
('Matthew Wilson', 8, '2015-08-11', '1997-08-11', 'Male', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '567-89-0123')),
('Ashley Miller', 4, '2019-07-22', '2001-07-22', 'Female', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '678-90-1234')),
('Christopher Moore', 10, '2013-03-18', '1992-03-18', 'Male', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '789-01-2345')),
('Amanda Taylor', 6, '2017-11-10', '1999-11-10', 'Female', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '890-12-3456')),
('Elizabeth Anderson', 9, '2014-12-05', '1995-12-05', 'Female', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '901-23-4567')),
('Brian Thomas', 1, '2022-06-01', '2004-06-01', 'Male', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '012-34-5678')),
('Sophia Jackson', 3, '2020-09-14', '2001-09-14', 'Female', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '210-43-8765')),
('Ethan White', 2, '2021-08-23', '1999-08-23', 'Male', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '321-54-9876')),
('Madison Harris', 5, '2018-01-07', '1999-01-07', 'Male', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '432-65-0987')),
('Alexander Martin', 6, '2017-04-03', '2000-04-03', 'Male', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '543-76-1098')),
('Olivia Thompson', 4, '2019-10-16', '2001-10-16', 'Female', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '654-87-2109')),
('William Garcia', 7, '2016-02-11', '1999-02-11', 'Male', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '765-98-3210')),
('Isabella Martinez', 8, '2015-05-28', '1997-05-28', 'Other', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '876-09-4321')),
('David Rodriguez', 1, '2022-07-04', '2004-07-04', 'Male', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '987-10-5432')),
('Charlotte Lee', 2, '2021-09-15', '1999-09-15', 'Female', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '098-21-6543')),
('Benjamin Walker', 3, '2020-12-21', '2002-12-21', 'Male', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '789-32-7654')),
('Abigail Hall', 9, '2014-10-30', '1995-10-30', 'Female', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '654-43-8765')),
('Daniel Allen', 5, '2018-06-19', '2000-06-19', 'Other', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '321-54-9876')),
('Emma Young', 4, '2019-03-23', '2001-03-23', 'Female', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '432-65-0987')),
('Lucas Hernandez', 6, '2017-08-09', '2001-08-09', 'Male', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '543-76-1098')),
('Mia King', 7, '2016-11-01', '1999-11-01', 'Female', ENCRYPTBYKEY(KEY_GUID('EnvSymmetricKey'), '654-87-2109'));



CLOSE SYMMETRIC KEY EnvSymmetricKey;

----CARETAKER
INSERT INTO CARETAKER (CARETAKER_ID, PLANT_CARE_SPECIALISATION, EDUCATION_LEVEL) 
VALUES 
(2, 'Aquatic Plants', 'Masters Degree'),
(3, 'Desert Plants', 'Bachelors Degree'),
(4, 'Aquatic Plants', 'College Diploma'),
(5, 'Ferns', 'PhD'),
(6, 'Aquatic Plants', 'Associate Degree'),
(7, 'Aquatic Plants', 'Bachelors Degree'),
(8, 'Shrubs', 'Masters Degree'),
(9, 'Shrubs', 'High School Diploma'),
(10, 'Trees', 'Bachelors Degree'),
(11, 'Aquatic Plants', 'College Diploma'),
(12, 'Grasses', 'Associate Degree'),
(13, 'Aquatic Plants', 'PhD'),
(17, 'Carnivorous Plants', 'High School Diploma'),
(22, 'Algae', 'Associate Degree'),
(23, 'Carnivorous Plants', 'Bachelors Degree');


----SANCTUARY_STAFF
INSERT INTO SANCTUARY_STAFF (SANCTUARY_STAFF_ID, CERTIFICATION, EDUCATION_AND_TRAINING) 
VALUES 
(2, 'Endangered Species Specialist', 'MSc in Conservation Biology'),
(6, 'Zookeeping Certificate', 'BSc in Zoology'),
(11, 'Wildlife Tracking Certification', 'BSc in Natural Resource Management'),
(12, 'Conservation Education Certificate', 'MA in Environmental Education'),
(13, 'Aquatic Habitat Specialist', 'PhD in Aquatic Science'),
(15, 'Ecotourism Certificate', 'BA in Sustainable Tourism'),
(16, 'Natural Resource Policy Certificate', 'MSc in Environmental Policy'),
(17, 'Animal Behavior Specialist', 'PhD in Animal Behavior'),
(18, 'Wilderness First Aid Certification', 'Certified Wilderness Responder'),
(21, 'Climate Change Analyst Certificate', 'MA in Climate Science'),
(22, 'Renewable Resources Management', 'BSc in Renewable Resources'),
(23, 'Forest Conservation Technician', 'Diploma in Forestry'),
(24, 'Soil Conservation Certification', 'MS in Soil Science'),
(25, 'Environmental Law Certificate', 'JD with specialization in Environmental Law');


----GUIDE
INSERT INTO GUIDE (GUIDE_ID, TRAINING_AND_CERTIFICATIONS) 
VALUES 
(1, 'Certified Tour Guide, CPR & First Aid'),
(2, 'Wilderness First Responder, Bird Watching Specialist'),
(5, 'Eco-Tourism Certificate, Environmental Educator'),
(6, 'Nature Interpretation Certificate, Hiking Guide'),
(7, 'Adventure Guide Diploma, Rock Climbing Instructor'),
(8, 'Safari Guide Certification, Wildlife Tracking Expert'),
(9, 'Scuba Diving Instructor, Marine Life Specialist'),
(10, 'Botanical Tour Guide, Plant Identification Expert'),
(13, 'Certified Cave Guide, Spelunking Safety Trainer'),
(15, 'Rafting Guide Certification, Swiftwater Rescue Trained'),
(21, 'Certified Bicycle Tour Guide, Bike Mechanic Skills'),
(23, 'Wildlife Safari Leader, Zoology Degree'),
(24, 'Climbing Guide, Certified in Mountain Safety'),
(25, 'Fishing Guide, Deep Sea Fishing Expert');



----COACHES
INSERT INTO COACHES (COACH_ID, LEVEL_OF_COACHING) 
VALUES 
(1, 'Beginner Level'),
(2, 'Intermediate Level'),
(3, 'Advanced Level'),
(5, 'Beginner Level'),
(7, 'Beginner Level'),
(10, 'Beginner Level'),
(12, 'Intermediate Level'),
(13, 'Intermediate Level'),
(23, 'Intermediate Level'),
(14, 'Advanced Level'),
(15, 'Advanced Level'),
(16, 'Advanced Level'),
(24, 'Assistant Coach Level'),
(25, 'Head Coach Level');


----HABITAT
INSERT INTO HABITAT (Habitat_Id, Sanctuary_Id, Habitat_Type, Habitat_Size, PH_Level, Soil_Fertility, Air_Purity, Humidity, Temperature)
VALUES
  (1, 10, 'Wetland', 500.25, 6.8, 'Rich Loam', 85.0, 60.0, 28.5),
  (2, 1, 'Rainforest', 800.30, 7.2, 'Rocky Soil', 75.0, 65.5, 28.0),
  (3, 3, 'Wetland', 700.20, 6.5, 'Silty Soil', 80.0, 60.0, 22.0),
  (4, 4, 'High Altitude Plateau', 450.75, 6.9, 'Fertile Soil', 85.0, 40.0, 30.0),
  (5, 5, 'Rainforest', 1000.50, 7.5, 'Sandy Soil', 70.0, 55.0, 22.5),
  (6, 6, 'Wetland', 1200.75, 7.8, 'Loamy Soil', 75.0, 45.0, 29.0),
  (7, 7, 'High Altitude Plateau', 900.40, 6.7, 'Silt Loam', 80.0, 55.5, 26.5),
  (8, 8, 'Wetland', 650.60, 7.0, 'Sandy Loam', 85.0, 60.0, 28.5),
  (9, 9, 'Rainforest', 1100.20, 6.4, 'Humus-Rich Soil', 70.0, 65.0, 24.5),
  (10, 10, 'Wetland', 750.80, 7.3, 'Volcanic Soil', 75.0, 50.0, 21.8),
  (11, 1, 'Wetland', 500.45, 6.6, 'Prairie Soil', 80.0, 55.0, 26.0),
  (12, 2, 'Rainforest', 950.55, 7.1, 'Coniferous Soil', 70.0, 60.0, 23.2),
  (13, 3, 'Wetland', 1300.90, 7.4, 'Silty Sand', 75.0, 50.5, 20.5),
  (14, 4, 'Wetland', 850.35, 6.8, 'Marshy Soil', 80.0, 65.0, 27.0),
  (15, 5, 'Rainforest', 800.25, 7.2, 'Savannah Soil', 70.0, 45.0, 28.8),
  (16, 6, 'High Altitude Plateau', 700.70, 6.5, 'Alpine Soil', 75.0, 55.5, 25.5),
  (17, 7, 'Wetland', 450.80, 6.9, 'Woodland Soil', 80.0, 60.5, 20.2),
  (18, 8, 'Wetland', 600.95, 7.7, 'Riverbank Soil', 26.0, 73.2, 23.5),
  (19, 9, 'Rainforest', 950.40, 6.3, 'Biosphere Soil', 21.2, 66.5, 18.5),
  (20, 2, 'High Altitude Plateau', 550.30, 7.0, 'Tundra Soil', 28.0, 77.5, 25.5),
  (21, 1, 'Wetland', 650.65, 6.6, 'Wetland Soil', 24.0, 72.0, 21.2),
  (22, 2, 'High Altitude Plateau', 900.20, 7.3, 'Cliffside Soil', 22.8, 67.8, 19.8),
  (23, 3, 'Wetland', 1050.75, 7.8, 'Sandy Loam', 20.5, 62.5, 17.0),
  (24, 4, 'High Altitude Plateau', 1200.80, 6.7, 'Iceberg Soil', 19.0, 59.0, 16.2),
  (25, 5, 'Wetland', 1100.50, 6.4, 'Plateau Soil', 21.5, 66.0, 18.0);



----FLORA
INSERT INTO FLORA (Flora_Id, Caretaker_Id, Species)
VALUES
  (1, 2, 'Rose'),
  (2, 2, 'Orchid'),
  (3, 3, 'Cactus'),
  (4, 4, 'Water Lily'),
  (5, 5, 'Fern'),
  (6, 6, 'Aloe Vera'),
  (7, 7, 'Succulent'),
  (8, 8, 'Lavender'),
  (9, 9, 'Azalea'),
  (10, 10, 'Oak Tree'),
  (11, 11, 'Sunflower'),
  (12, 12, 'Bamboo'),
  (13, 13, 'Ivy'),
  (14, 4, 'Tomato Plant'),
  (15, 5, 'Echinacea'),
  (16, 6, 'Bonsai Tree'),
  (17, 17, 'Palm Tree'),
  (18, 8, 'Bonsai'),
  (19, 9, 'Tulip'),
  (20, 22, 'Mushroom'),
  (21, 23, 'Moss'),
  (22, 4, 'Algae Bloom'),
  (23, 3, 'Venus Flytrap'),
  (24, 7, 'Pine Tree'),
  (25, 5, 'Rosemary');


----FLORA_HABITAT
INSERT INTO FLORA_HABITAT (Habitat_Id, Flora_Id)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5),
  (6, 6),
  (7, 7),
  (8, 8),
  (9, 9),
  (10, 10),
  (11, 11),
  (12, 12),
  (13, 13),
  (14, 14),
  (15, 15),
  (16, 16),
  (17, 17),
  (18, 18),
  (19, 19),
  (20, 20),
  (21, 21),
  (22, 22),
  (23, 23),
  (24, 24),
  (25, 25);


----VET----
INSERT INTO VET (VET_ID, LICENSE_NUMBER, YEARS_OF_EXPERIENCE, SPECIALISATION) 
VALUES 
(1, 123456, 10, 'General Practitioner'),
(2, 123457, 8, 'Surgeon'),
(4, 123459, 7, 'Cardiology'),
(5, 123460, 6, 'General Practitioner'),
(7, 123462, 3, 'Cardiology'),
(9, 123464, 4, 'General Practitioner'),
(10, 123465, 11, 'General Practitioner'),
(11, 123466, 15, 'Surgeon'),
(14, 123469, 14, 'Radiology'),
(18, 123473, 19, 'Surgeon'),
(19, 123474, 18, 'Radiology'),
(21, 123476, 5, 'Radiology'),
(23, 123478, 4, 'General Practitioner'),
(25, 123480, 22, 'General Practitioner');



----WILDLIFE
INSERT INTO WILDLIFE (VET_ID, Wildlife_Type, Population, Species)
VALUES
  (1, 'Carnivore', 100, 'Lion'),
  (2, 'Herbivore', 200, 'Elephant'),
  (25, 'Omnivore', 50, 'Bear'),
  (4, 'Carnivore', 75, 'Tiger'),
  (5, 'Herbivore', 150, 'Giraffe'),
  (23, 'Omnivore', 30, 'Raccoon'),
  (7, 'Carnivore', 80, 'Leopard'),
  (21, 'Herbivore', 120, 'Hippopotamus'),
  (9, 'Omnivore', 40, 'Fox'),
  (10, 'Carnivore', 60, 'Cheetah'),
  (11, 'Herbivore', 180, 'Zebra'),
  (19, 'Omnivore', 35, 'Panda'),
  (14, 'Carnivore', 90, 'Jaguar'),
  (14, 'Herbivore', 220, 'Rhino'),
  (18, 'Omnivore', 45, 'Opossum'),
  (14, 'Carnivore', 70, 'Panther'),
  (19, 'Herbivore', 130, 'Kangaroo'),
  (18, 'Omnivore', 55, 'Badger'),
  (19, 'Carnivore', 85, 'Hyena'),
  (21, 'Herbivore', 160, 'Gorilla'),
  (21, 'Omnivore', 25, 'Raven'),
  (2, 'Carnivore', 95, 'Cougar'),
  (23, 'Herbivore', 140, 'Wildebeest'),
  (4, 'Omnivore', 48, 'Coati'),
  (25, 'Carnivore', 65, 'Lynx');
 

----CARNIVORE
INSERT INTO CARNIVORE (Carnivore_ID, Pack_Size, Hunting_Activity_Period)
VALUES
  (1, 10, 'Nocturnal'),    -- Lion
  (4, 8, 'Nocturnal'),      -- Tiger
  (7, 12, 'Crepuscular'),   -- Leopard
  (10, 6, 'Nocturnal'),     -- Cheetah
  (13, 9, 'Crepuscular'),   -- Jaguar
  (16, 7, 'Diurnal'),       -- Panther
  (19, 11, 'Nocturnal'),    -- Hyena
  (22, 8, 'Crepuscular'),   -- Cougar
  (25, 10, 'Diurnal');     -- Lynx

-----OMNIVORE
INSERT INTO OMNIVORE (Omnivore_ID, Foraging_Behavior)
VALUES
  (3, 'Scavenging'),            -- Bear
  (6, 'Foraging'),              -- Raccoon
  (9, 'Hunting and Foraging'),  -- Fox
  (12, 'Bamboo Foraging'),      -- Panda
  (15, 'Foraging'),             -- Opossum
  (18, 'Foraging'),             -- Badger
  (21, 'Scavenging'),           -- Raven
  (24, 'Foraging'),             -- Coati
  (25, 'Hunting and Foraging'); -- Lynx

-----HERBIVORE
INSERT INTO HERBIVORE (Herbivore_ID, Grazing_Habits, Migratory_Patterns)
VALUES
  (2, 'Grass', 'Non-Migratory'),   -- Elephant
  (5, 'Leaves', 'Migratory'),      -- Giraffe
  (8, 'Grass', 'Non-Migratory'),   -- Hippopotamus
  (11, 'Grass', 'Migratory'),      -- Zebra
  (14, 'Grass', 'Non-Migratory'),  -- Rhino
  (17, 'Grass', 'Migratory'),      -- Kangaroo
  (20, 'Leaves', 'Non-Migratory'), -- Gorilla
  (23, 'Grass', 'Migratory');      -- Wildebeest



-----WILDLIFE_TRACKING
INSERT INTO WILDLIFE_TRACKING (WildLife_Id, Employee_Id, GPS_location, Tracking_Date)
VALUES
  (1, 1, '35.6895° N, 139.6917° E', '2023-11-25'),
  (2, 2, '40.7128° N, 74.0060° W', '2023-11-24'),
  (3, 3, '38.9072° N, 77.0370° W', '2023-11-23'),
  (4, 4, '34.0522° N, 118.2437° W', '2023-11-22'),
  (5, 5, '37.7749° N, 122.4194° W', '2023-11-21'),
  (6, 6, '41.8781° N, 87.6298° W', '2023-11-20'),
  (7, 7, '33.7490° N, 84.3880° W', '2023-11-19'),
  (8, 8, '38.6270° N, 90.1994° W', '2023-11-18'),
  (9, 9, '41.8781° N, 87.6298° W', '2023-11-17'),
  (10, 10, '32.7767° N, 96.7970° W', '2023-11-16'),
  (11, 11, '40.7128° N, 74.0060° W', '2023-11-15'),
  (12, 12, '37.7749° N, 122.4194° W', '2023-11-14'),
  (13, 13, '34.0522° N, 118.2437° W', '2023-11-13'),
  (14, 14, '33.7490° N, 84.3880° W', '2023-11-12'),
  (15, 15, '38.6270° N, 90.1994° W', '2023-11-11'),
  (16, 16, '41.8781° N, 87.6298° W', '2023-11-10'),
  (17, 17, '32.7767° N, 96.7970° W', '2023-11-09'),
  (18, 18, '40.7128° N, 74.0060° W', '2023-11-08'),
  (19, 19, '37.7749° N, 122.4194° W', '2023-11-07'),
  (20, 20, '34.0522° N, 118.2437° W', '2023-11-06'),
  (21, 21, '33.7490° N, 84.3880° W', '2023-11-05'),
  (22, 22, '38.6270° N, 90.1994° W', '2023-11-04'),
  (23, 23, '41.8781° N, 87.6298° W', '2023-11-03'),
  (24, 24, '32.7767° N, 96.7970° W', '2023-11-02'),
  (25, 25, '40.7128° N, 74.0060° W', '2023-11-01');




----TOURIST
INSERT INTO TOURIST (Tourist_Id, Guide_Id, Sanctuary_Id, Tourist_Name, Phone_Number, Email)
VALUES
  (1, 1, 1, 'Emma Clark', '1002003001', 'emma.clark@email.com'),
  (2, 2, 1, 'Liam Johnson', '1002003002', 'liam.johnson@email.com'),
  (3, 3, 3, 'Olivia Brown', '1002003003', 'olivia.brown@email.com'),
  (4, 4, 4, 'Noah Davis', '1002003004', 'noah.davis@email.com'),
  (5, 5, 5, 'Ava Miller', '1002003005', 'ava.miller@email.com'),
  (6, 6, 6, 'William Taylor', '1002003006', 'william.taylor@email.com'),
  (7, 7, 7, 'Sophia Wilson', '1002003007', 'sophia.wilson@email.com'),
  (8, 8, 8, 'James Anderson', '1002003008', 'james.anderson@email.com'),
  (9, 9, 9, 'Isabella Thomas', '1002003009', 'isabella.thomas@email.com'),
  (10, 10, 10, 'Benjamin Martin', '1002003010', 'benjamin.martin@email.com'),
  (11, 11, 11, 'Mia Hernandez', '1002003011', 'mia.hernandez@email.com'),
  (12, 12, 12, 'Lucas Moore', '1002003012', 'lucas.moore@email.com'),
  (13, 13, 13, 'Amelia Jackson', '1002003013', 'amelia.jackson@email.com'),
  (14, 14, 14, 'Mason Lee', '1002003014', 'mason.lee@email.com'),
  (15, 15, 15, 'Harper Perez', '1002003015', 'harper.perez@email.com'),
  (16, 16, 16, 'Ethan White', '1002003016', 'ethan.white@email.com'),
  (17, 17, 17, 'Evelyn Harris', '1002003017', 'evelyn.harris@email.com'),
  (18, 18, 18, 'Alexander Clark', '1002003018', 'alexander.clark@email.com'),
  (19, 19, 19, 'Abigail Lewis', '1002003019', 'abigail.lewis@email.com'),
  (20, 20, 20, 'Sebastian Walker', '1002003020', 'sebastian.walker@email.com'),
  (21, 21, 21, 'Elizabeth Young', '1002003021', 'elizabeth.young@email.com'),
  (22, 22, 22, 'Jack Hall', '1002003022', 'jack.hall@email.com'),
  (23, 23, 23, 'Sofia Allen', '1002003023', 'sofia.allen@email.com'),
  (24, 24, 24, 'Charlotte King', '1002003024', 'charlotte.king@email.com'),
  (25, 25, 25, 'Owen Wright', '1002003025', 'owen.wright@email.com');

----VISITS
INSERT INTO VISITS (Visit_Id, Sanctuary_Id, Tourist_Id, Date_of_Visit, Feedback) VALUES
(1, 1, 1, '2023-01-01', 'An unforgettable experience with nature.'),
(2, 2, 2, '2023-01-02', 'Very informative and enjoyable tour.'),
(3, 3, 3, '2023-01-03', 'A peaceful and beautiful sanctuary.'),
(4, 4, 4, '2023-01-04', 'Loved the diversity of wildlife.'),
(5, 5, 5, '2023-01-05', 'An excellent visit, highly recommend.'),
(6, 6, 6, '2023-01-06', 'The guide was knowledgeable and friendly.'),
(7, 7, 7, '2023-01-07', 'Great for families and children.'),
(8, 8, 8, '2023-01-08', 'A serene escape from the city.'),
(9, 9, 9, '2023-01-09', 'Impressed by the conservation efforts.'),
(10, 10, 10, '2023-01-10', 'A must-visit for nature lovers.'),
(11, 11, 11, '2023-01-11', 'The natural beauty is breathtaking.'),
(12, 12, 12, '2023-01-12', 'Enjoyed learning about the local ecosystem.'),
(13, 13, 13, '2023-01-13', 'A perfect blend of education and entertainment.'),
(14, 14, 14, '2023-01-14', 'The walking trails are well-maintained.'),
(15, 15, 15, '2023-01-15', 'Saw a wide variety of birds and plants.'),
(16, 16, 16, '2023-01-16', 'A relaxing and informative day out.'),
(17, 17, 17, '2023-01-17', 'The staff are passionate about their work.'),
(18, 18, 18, '2023-01-18', 'Learnt a lot about wildlife conservation.'),
(19, 19, 19, '2023-01-19', 'The kids had a great time exploring.'),
(20, 20, 20, '2023-01-20', 'Impressive variety of habitats.'),
(21, 21, 21, '2023-01-21', 'The guided tour added so much value.'),
(22, 22, 22, '2023-01-22', 'A tranquil and beautiful place to visit.'),
(23, 23, 23, '2023-01-23', 'We loved the interactive exhibits.'),
(24, 24, 24, '2023-01-24', 'An excellent way to learn about nature.'),
(25, 25, 25, '2023-01-25', 'A wonderful experience, will visit again.');



----OUTREACH_PROGRAM
INSERT INTO OUTREACH_PROGRAM (Coach_Id, Organisation_Name, Organisation_Type, Date_of_Affiliation, Program_Period) 
VALUES
(1, 'Verdant Visions', 'Wildlife Rehabilitation', '2023-01-01', 12),
(2, 'Blue Planet Alliance', 'Environmental Advocacy', '2023-02-01', 6),
(3, 'Wildhaven Workshop', 'Habitat Preservation', '2023-03-01', 8),
(4, 'EcoPioneer Group', 'Environmental Advocacy', '2023-04-01', 10),
(5, 'Green Canopy Network', 'Wildlife Rehabilitation', '2023-05-01', 9),
(6, 'Solar Synergy Collective', 'Environmental Advocacy', '2023-05-01', 9),
(7, 'AquaGuard Foundation', 'Environmental Advocacy', '2023-05-01', 9),
(8, 'Natures Nexus Society', 'Wildlife Rehabilitation', '2023-05-01', 9),
(9, 'Earthwise Educators', 'Habitat Preservation', '2023-05-01', 9),
(10, 'Conservatech Innovators', 'Wildlife Rehabilitation', '2023-05-01', 9),
(11, 'FloraFauna Friends' , 'Habitat Preservation', '2023-05-01', 9),
(12, 'Climate Crusaders', 'Wildlife Rehabilitation', '2023-05-01', 9),
(13, 'EcoEthic Enthusiasts', 'Habitat Preservation', '2023-05-01', 9),
(14, 'WildTrail Activists', 'Wildlife Rehabilitation', '2023-05-01', 9),
(15, 'SolarFlare Solutions', 'Wildlife Rehabilitation', '2023-05-01', 9),
(16, 'Ocean Odyssey Outreach', 'Environmental Advocacy', '2023-05-01', 9),
(17, 'Peak Pursuit Partners', 'Habitat Preservation', '2023-05-01', 9),
(18, 'Renewable Roots Group', 'Wildlife Rehabilitation', '2023-05-01', 9),
(19, 'EcoEngage Community', 'Habitat Preservation', '2023-05-01', 9),
(20, 'TerraTacticians', 'Habitat Preservation', '2023-05-01', 9),
(21, 'Vital Valley Ventures', 'Environmental Advocacy', '2023-05-01', 9),
(22, 'GreenGrowth Guardians', 'Wildlife Rehabilitation', '2023-05-01', 9),
(23, 'Habitat Harmony Hub', 'Environmental Advocacy', '2023-05-01', 9),
(24, 'EcoIntellect Network', 'Wildlife Rehabilitation', '2023-05-01', 9),
(25, 'Planet Pioneers Project ', 'Environmental Advocacy', '2023-12-01', 7);


----VOLUNTEER
INSERT INTO VOLUNTEER (Program_Id, Coach_Id, Name, Start_Date, End_Date) VALUES
(1, 1, 'Alex Johnson', '2023-01-15', '2023-07-15'),
(2, 2, 'Brianna Smith', '2023-02-01', '2023-08-01'),
(3, 3, 'Carlos Ray', '2023-03-10', '2023-09-10'),
(4, 4, 'Diana Grace', '2023-04-05', '2023-10-05'),
(5, 5, 'Evan Wallace', '2023-05-20', '2023-11-20'),
(6, 6, 'Fiona Gallagher', '2023-06-15', '2023-12-15'),
(7, 7, 'George Knight', '2023-07-01', '2024-01-01'),
(8, 8, 'Hannah Zest', '2023-08-08', '2024-02-08'),
(9, 9, 'Ian Dexter', '2023-09-12', '2024-03-12'),
(10, 10, 'Julia Parks', '2023-10-17', '2024-04-17'),
(11, 11, 'Kevin Malone', '2023-11-22', '2024-05-22'),
(12, 12, 'Linda Gale', '2023-12-30', '2024-06-30'),
(13, 13, 'Mike Donovan', '2023-01-09', '2023-07-09'),
(14, 14, 'Nina Ochoa', '2023-02-14', '2023-08-14'),
(15, 15, 'Oscar Peters', '2023-03-19', '2023-09-19'),
(16, 16, 'Pamela Rose', '2023-04-23', '2023-10-23'),
(17, 17, 'Quinn Fabray', '2023-05-28', '2023-11-28'),
(18, 18, 'Rita Sands', '2023-06-02', '2023-12-02'),
(19, 19, 'Steve Jobs', '2023-07-07', '2024-01-07'),
(20, 20, 'Tina Fey', '2023-08-12', '2024-02-12'),
(21, 21, 'Uma Thurman', '2023-09-17', '2024-03-17'),
(22, 22, 'Victor Vance', '2023-10-22', '2024-04-22'),
(23, 23, 'Wendy Darling', '2023-11-27', '2024-05-27'),
(24, 24, 'Xander York', '2023-12-02', '2024-06-02'),
(25, 25, 'Yara Greyjoy', '2024-01-07', '2024-07-07');



----SUPPLIER
INSERT INTO SUPPLIER (Supplier_ID, Supplier_Name, Contact) 
VALUES 
(1, 'Quality Goods Inc.', 'contact@qualitygoods.com'),
(2, 'Fresh Farm Produce', 'sales@freshfarm.com'),
(3, 'Organic Harvest Co.', 'info@organicharvest.com'),
(4, 'Gourmet Selections', 'support@gourmetselects.com'),
(5, 'Bakers Delight Supplies', 'orders@bakersdelight.com'),
(6, 'Prime Meat Suppliers', 'service@primemeat.com'),
(7, 'Seafood Direct Ltd.', 'inquiries@seafooddirect.com'),
(8, 'Whole Grain Providers', 'contact@wholegrainpro.com'),
(9, 'Dairy Best', 'sales@dairybest.com'),
(10, 'Sweet Treats Confectionery', 'support@sweettreats.com'),
(11, 'Beverage Distributors Inc.', 'info@beverageinc.com'),
(12, 'Frozen Delights LLC', 'orders@frozendelights.com'),
(13, 'Catering Essentials', 'service@cateringessentials.com'),
(14, 'Exotic Spices World', 'inquiries@exoticspices.com'),
(15, 'Healthy Snacks Ltd.', 'contact@healthysnacks.com'),
(16, 'Eco Produce', 'sales@ecoproduce.com'),
(17, 'Farm Fresh Organics', 'support@farmfreshorganics.com'),
(18, 'Urban Greens', 'info@urbangreens.com'),
(19, 'Natura Foods', 'contact@naturafoods.com'),
(20, 'Pure Harvest', 'sales@pureharvest.com'),
(21, 'AgriBest Supplies', 'support@agribest.com'),
(22, 'Fresh Picks', 'orders@freshpicks.com'),
(23, 'Garden Essentials', 'service@gardenessentials.com'),
(24, 'Healthy Choice Produce', 'inquiries@healthychoice.com'),
(25, 'Green Valley Suppliers', 'contact@greenvalley.com');


----FOOD
INSERT INTO food (food_id, food_name, food_type) 
VALUES 
(1, 'Apples', 'Fruit'),
(2, 'Spinach', 'Vegetable'),
(3, 'Almonds', 'Vegetable'),
(4, 'Salmon', 'Fish'),
(5, 'Chicken Breast', 'Poultry'),
(6, 'Beef Steak', 'Red Meat'),
(7, 'Pork Chops', 'Red Meat'),
(8, 'Chicken Breast', 'Poultry'),
(9, 'Turkey Breast', 'Poultry'),
(10, 'Spinach', 'Vegetable'),
(11, 'Turkey Breast', 'Poultry'),
(12, 'Pork Chops', 'Red Meat'),
(13, 'Banana', 'Fruit'),
(14, 'Carrots', 'Vegetable'),
(15, 'Beef Steak', 'Red Meat'),
(16, 'Bananas', 'Fruit'),
(17, 'Broccoli', 'Vegetable'),
(18, 'Salmon', 'Fish'),
(19, 'Trout', 'Fish'),
(20, 'Turkey Breast', 'Poultry'),
(21, 'Lamb Chops', 'Red Meat'),
(22, 'Spinach', 'Vegetable'),
(23, 'Turkey Breast', 'Poultry'),
(24, 'Chicken Breast', 'Poultry'),
(25, 'Carrots', 'Vegetable');


----FOOD_SUPPLY
INSERT INTO food_supply (supply_ID, Food_id, supplier_id, Food_Quantity, restocking_date, date_of_delivery) 
VALUES 
(1, 1, 1, 100, '2023-01-01', '2023-01-02'),
(2, 2, 2, 200, '2023-01-03', '2023-01-04'),
(3, 3, 3, 150, '2023-01-05', '2023-01-06'),
(4, 4, 4, 120, '2023-01-07', '2023-01-08'),
(5, 5, 5, 130, '2023-01-09', '2023-01-10'),
(6, 6, 6, 140, '2023-01-11', '2023-01-12'),
(7, 7, 7, 110, '2023-01-13', '2023-01-14'),
(8, 8, 8, 160, '2023-01-15', '2023-01-16'),
(9, 9, 9, 170, '2023-01-17', '2023-01-18'),
(10, 10, 10, 180, '2023-01-19', '2023-01-20'),
(11, 11, 11, 190, '2023-01-21', '2023-01-22'),
(12, 12, 12, 210, '2023-01-23', '2023-01-24'),
(13, 13, 13, 220, '2023-01-25', '2023-01-26'),
(14, 14, 14, 230, '2023-01-27', '2023-01-28'),
(15, 15, 15, 240, '2023-01-29', '2023-01-30'),
(16, 16, 16, 250, '2023-02-01', '2023-02-02'),
(17, 17, 17, 260, '2023-02-03', '2023-02-04'),
(18, 18, 18, 270, '2023-02-05', '2023-02-06'),
(19, 19, 19, 280, '2023-02-07', '2023-02-08'),
(20, 20, 20, 290, '2023-02-09', '2023-02-10'),
(21, 21, 21, 300, '2023-02-11', '2023-02-12'),
(22, 22, 22, 310, '2023-02-13', '2023-02-14'),
(23, 23, 23, 320, '2023-02-15', '2023-02-16'),
(24, 24, 24, 330, '2023-02-17', '2023-02-18'),
(25, 25, 25, 340, '2023-02-19', '2023-02-20');


----WILDLIFE_FOOD
INSERT INTO WILDLIFE_FOOD (Wildlife_ID, Food_ID, Quantity_Supplied, Date_Supplied) 
VALUES 
(1, 1, 100, '2023-01-01'),
(2, 2, 200, '2023-01-02'),
(3, 3, 150, '2023-01-03'),
(4, 4, 120, '2023-01-04'),
(5, 5, 130, '2023-01-05'),
(6, 6, 140, '2023-01-06'),
(7, 7, 110, '2023-01-07'),
(8, 8, 160, '2023-01-08'),
(9, 9, 170, '2023-01-09'),
(10, 10, 180, '2023-01-10'),
(11, 11, 190, '2023-01-11'),
(12, 12, 210, '2023-01-12'),
(13, 13, 220, '2023-01-13'),
(14, 14, 230, '2023-01-14'),
(15, 15, 240, '2023-01-15'),
(16, 16, 250, '2023-01-16'),
(17, 17, 260, '2023-01-17'),
(18, 18, 270, '2023-01-18'),
(19, 19, 280, '2023-01-19'),
(20, 20, 290, '2023-01-20'),
(21, 21, 300, '2023-01-21'),
(22, 22, 310, '2023-01-22'),
(23, 23, 320, '2023-01-23'),
(24, 24, 330, '2023-01-24'),
(25, 25, 340, '2023-01-25');


----WILDLIFE_HABITAT
INSERT INTO WILDLIFE_HABITAT (WildlifeHabitat_Id, Wildlife_Id, Habitat_Id, Date_of_Localisation) VALUES
(1, 1, 1, '2023-01-01'),
(2, 2, 2, '2023-01-02'),
(3, 3, 3, '2023-01-03'),
(4, 4, 4, '2023-01-04'),
(5, 5, 5, '2023-01-05'),
(6, 6, 6, '2023-01-06'),
(7, 7, 7, '2023-01-07'),
(8, 8, 8, '2023-01-08'),
(9, 9, 9, '2023-01-09'),
(10, 10, 10, '2023-01-10'),
(11, 11, 11, '2023-01-11'),
(12, 12, 12, '2023-01-12'),
(13, 13, 13, '2023-01-13'),
(14, 14, 14, '2023-01-14'),
(15, 15, 15, '2023-01-15'),
(16, 16, 16, '2023-01-16'),
(17, 17, 17, '2023-01-17'),
(18, 18, 18, '2023-01-18'),
(19, 19, 19, '2023-01-19'),
(20, 20, 20, '2023-01-20'),
(21, 21, 21, '2023-01-21'),
(22, 22, 22, '2023-01-22'),
(23, 23, 23, '2023-01-23'),
(24, 24, 24, '2023-01-24'),
(25, 25, 25, '2023-01-25');


