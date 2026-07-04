USE cdg_hyd_jfs_053;

-- Exercise 1: Create a procedure to display all employees.
    
    DELIMITER //

    CREATE PROCEDURE usp_get_all_employees()
BEGIN
SELECT 
    *
FROM
    employees ;
    END//
    DELIMITER ;
    
    CALL usp_get_all_employees;
    
    -- Exercise 2: Create a procedure to display all parking spots.
    
     DELIMITER //

    CREATE PROCEDURE usp_get_all_parkingspots()
BEGIN
SELECT 
    *
FROM
   parking_spots ;
    END//
    DELIMITER ;
    
    CALL usp_get_all_parkingspots;
    
    -- Exercise 3: Create a procedure to display a single employee by employee id.
    
     DELIMITER //

    CREATE PROCEDURE usp_get_single_employee(IN emp_id INT)
BEGIN
SELECT 
    *
FROM
   employees where employee_id = emp_id;
    END//
    DELIMITER ;
    
    CALL usp_get_single_employee(101);
    
    -- Exercise 4: Create a procedure to display a parking spot by parking spot id.
    
     DELIMITER //

    CREATE PROCEDURE usp_get_single_parkingspot(IN park_id INT)
BEGIN
SELECT 
    *
FROM
   parking_spots where parking_spot_id = park_id;
    END//
    DELIMITER ;
    
    CALL usp_get_single_parkingspot(201);
    
    -- Exercise 5: Create a procedure to display all employees who have assigned parking spots.
    
    DELIMITER //
    CREATE PROCEDURE usp_get_employees_with_parkingspots()
    BEGIN
    SELECT 
		`e`.employee_id,
		`e`.first_name,
		`e`.last_name,
		`ps`.parking_spot_id,
		`ps`.spot_number,
		`ps`.basement_level
FROM
    employees AS `e`
    INNER JOIN 
    parking_spots AS `ps` ON `e`.parking_spot_id = `ps`.parking_spot_id;
    END//
    
   CALL usp_get_employees_with_parkingspots;
   
   
   -- Exercise 6: Create a procedure to display employees without parking spots.
   
    DELIMITER //

    CREATE PROCEDURE usp_get_employees_without_parkingspot()
BEGIN
SELECT 
    *
FROM
   employees WHERE parking_spot_id IS NULL;
    END//
    DELIMITER ;
    
    CALL usp_get_employees_without_parkingspot;
    
    
    -- Exercise 7: Create a procedure to display parking spots which are unassigned.
    
     DELIMITER //

    CREATE PROCEDURE usp_get_unassigned_parkingspots()
BEGIN
SELECT 
		`e`.employee_id,
		`e`.first_name,
		`e`.last_name,
		`ps`.parking_spot_id,
		`ps`.spot_number,
		`ps`.basement_level
FROM
    parking_spots AS `ps`
    LEFT JOIN 
     employees AS `e` ON `e`.parking_spot_id = `ps`.parking_spot_id
    WHERE employee_id IS NULL; 
    END//
    DELIMITER ;
    
    CALL  usp_get_unassigned_parkingspots;
    
    -- Exercise 8: Create a procedure to insert a parking spot.
    
    DELIMITER //
    CREATE PROCEDURE usp_insert_parking_spot(IN SpotNumber TINYINT, IN basementLevel TINYINT)
    BEGIN 
    INSERT INTO parking_spots (spot_number,basement_level) VALUES (SpotNumber,basementLevel);
    SELECT * FROM parking_spots;
    END //
    DELIMITER ;
    
    CALL usp_insert_parking_spot(6,3);
    
   -- Exercise 9: Create a procedure that inserts an employee with a parking spot.
   
     DELIMITER //
    CREATE PROCEDURE usp_insert_employee_with_parking_spot(
    IN firstName CHAR(100),
    IN lastName CHAR(100),
    IN ParkingSpot_id INT)
    
    BEGIN 
    INSERT INTO employees (first_name,last_name,parking_spot_id) 
    VALUES (firstName,lastName,ParkingSpot_id);
    SELECT * FROM employees;
    END //
    DELIMITER ;
    
    CALL usp_insert_employee_with_parking_spot('vamshi','krishna',205);
    
    -- Exercise 10: Create a procedure that inserts an employee without a parking spot.
-- Input: First Name and Last Name

 DELIMITER //
    CREATE PROCEDURE usp_insert_employee_without_parking_spot(
    IN firstName CHAR(100),
    IN lastName CHAR(100)
    )
    
    BEGIN 
    INSERT INTO employees (first_name,last_name) 
    VALUES (firstName,lastName);
    SELECT * FROM employees;
    END //
    DELIMITER ;
    
    CALL usp_insert_employee_without_parking_spot('rohit','sharma');
    
    
    -- Exercise 11: Create a procedure to assign a parking spot to an existing employee (manual parking spot assignment).
    -- Input: Employee ID and Parking Spot ID
    
    
DELIMITER //
    CREATE PROCEDURE usp_assign_parking_spot_to_existing_employee(
    IN EmployeeID INT,
    IN ParkingSpotID INT
    )
    
    BEGIN 
    UPDATE employees SET parking_spot_id = ParkingSpotID  where employee_id = EmployeeID;
    SELECT * FROM employees;
    END //
    DELIMITER ;
    
    CALL usp_assign_parking_spot_to_existing_employee(102,210);
    
    -- Exercise 12: Create a procedure to assign a parking spot to an existing employee (automatic parking spot assignment).
	-- Input: Employee ID
    
    DELIMITER //

CREATE PROCEDURE usp_assign_parking_auto(
    IN employeeID INT
)
BEGIN
    DECLARE spot INT;

    SELECT MIN(parking_spot_id)
    INTO spot
    FROM parking_spots
    WHERE parking_spot_id NOT IN (
        SELECT parking_spot_id
        FROM employees
        WHERE parking_spot_id IS NOT NULL
    );

    UPDATE employees
    SET parking_spot_id = spot
    WHERE employee_id = employeeID;
END //

DELIMITER ;

CALL usp_assign_parking_auto(107);


-- Exercise 13: Create a procedure to remove an employee's parking assignment.
-- Input: Employee ID

DELIMITER //
CREATE PROCEDURE usp_remove_parking_assignement(IN EmployeeID INT)
BEGIN
UPDATE 
	employees SET parking_spot_id = NULL
    WHERE employee_id = EmployeeID;
END //
DELIMITER ;

CALL usp_remove_parking_assignement(101);

-- Exercise 14: Create a procedure to move an employee from one parking spot to another.

DELIMITER //
CREATE PROCEDURE usp_move_parking_spot(
	IN employeeID INT,
	IN Existing_parking_spotID INT,
	IN new_parking_spotID INT
    )
BEGIN 
UPDATE 
	employees SET parking_spot_id = new_parking_spotID 
	WHERE employee_id = employeeID AND parking_spot_id = Existing_parking_spotID;
END //
DELIMITER ;

CALL usp_move_parking_spot(101,201,206);


-- Exercise 15: Create a procedure to remove an employee.
-- Input: Employee ID

DELIMITER //
CREATE PROCEDURE usp_remove_employee(IN EmployeeID INT)
BEGIN
DELETE 
	FROM employees 
    WHERE employee_id = EmployeeID ;
END //
DELIMITER ;

CALL  usp_remove_employee(102);
    
    
    
    
    
    
    
    
    