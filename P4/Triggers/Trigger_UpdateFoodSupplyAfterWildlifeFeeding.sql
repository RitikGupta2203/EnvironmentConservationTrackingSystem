CREATE TRIGGER UpdateFoodSupplyAfterWildlifeFeeding
ON WILDLIFE_FOOD
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Update Food Supply when new food is added or existing food quantity is updated for wildlife
    DECLARE @foodId INT, @quantitySupplied INT, @newQuantity INT, @oldQuantitySupplied INT;
    
    -- Handling INSERT operation
    IF (SELECT COUNT(*) FROM INSERTED) > 0 AND (SELECT COUNT(*) FROM DELETED) = 0
    BEGIN
        SELECT @foodId = Food_ID, @quantitySupplied = Quantity_Supplied FROM INSERTED;

        -- Decrease the Food_Quantity in FOOD_SUPPLY
        UPDATE FOOD_SUPPLY
        SET Food_Quantity = Food_Quantity - @quantitySupplied
        WHERE Food_id = @foodId;
    END

    -- Handling UPDATE operation
    IF (SELECT COUNT(*) FROM INSERTED) > 0 AND (SELECT COUNT(*) FROM DELETED) > 0
    BEGIN
        SELECT @foodId = Food_ID, @newQuantity = Quantity_Supplied FROM INSERTED;
        SELECT @oldQuantitySupplied = Quantity_Supplied FROM DELETED;

        -- Adjust the Food_Quantity in FOOD_SUPPLY based on the difference
        UPDATE FOOD_SUPPLY
        SET Food_Quantity = Food_Quantity + (@oldQuantitySupplied - @newQuantity)
        WHERE Food_id = @foodId;
    END
END;
GO


-- To reset the DATA
-- TRUNCATE TABLE FOOD_SUPPLY;
-- TRUNCATE TABLE WILDLIFE_FOOD;

-- To check the TRIGGER
INSERT INTO FOOD_SUPPLY (supply_ID, Food_id, supplier_id, Food_Quantity, restocking_date, date_of_delivery)
VALUES (100, 1, 1, 1000, '2023-01-01', '2023-01-02');

INSERT INTO WILDLIFE_FOOD (Wildlife_ID, Food_ID, Quantity_Supplied, Date_Supplied)
VALUES (1, 1, 100, '2023-01-03');

INSERT INTO WILDLIFE_FOOD (Wildlife_ID, Food_ID, Quantity_Supplied, Date_Supplied)
VALUES (2, 1, 150, '2023-01-04');

SELECT * FROM FOOD_SUPPLY;

UPDATE WILDLIFE_FOOD 
SET Quantity_Supplied = 200
WHERE Wildlife_ID = 2 AND Food_ID = 1;