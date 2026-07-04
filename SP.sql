
# Exercise 1: Create a procedure to display all employees.

DELIMITER //

CREATE PROCEDURE usp_get_all_employees()
BEGIN
SELECT 
    `e`.employee_id,
    `e`.first_name,
    `e`.last_name,
	`e`.parking_spot_id
    FROM employees AS `e`; 
END//
DELIMITER ;

CALL usp_get_all_employees;


# Exercise 2: Create a procedure to display all parking spots.

DELIMITER //

CREATE PROCEDURE usp_get_all_parking_spots()
BEGIN
SELECT 
	`ps`.parking_spot_id,
	`ps`.spot_number,
	`ps`.basement_level
	FROM parking_spots AS `ps`;
END//

DELIMITER ;

CALL usp_get_all_parking_spots;


# Exercise 3: Create a procedure to display a single employee by employee id.

DELIMITER //

CREATE PROCEDURE usp_get_employee_by_employee_id(IN empID INT)
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
    parking_spots AS `ps` ON `e`.parking_spot_id = `ps`.parking_spot_id 
    WHERE `e`.employee_id=empID;
END//

DELIMITER ;

CALL usp_get_employee_by_employee_id(101);


# Exercise 4: Create a procedure to display a parking spot by parking spot id

DELIMITER //

CREATE PROCEDURE usp_get_parking_spot_by_parking_spot_id(IN spotID INT)
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
    parking_spots AS `ps` ON `e`.parking_spot_id = `ps`.parking_spot_id 
    WHERE `ps`.parking_spot_id=spotID;
END//

DELIMITER ;

CALL usp_get_parking_spot_by_parking_spot_id(201);


# Exercise 5: Create a procedure to display all employees who have assigned parking spots.

DELIMITER //

CREATE PROCEDURE usp_get_all_employees_assigned_parking()
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

DELIMITER ;

CALL usp_get_all_employees_assigned_parking;


# Exercise 6: Create a procedure to display employees without parking spots.

DELIMITER //

CREATE PROCEDURE usp_get_all_employees_not_assigned_parking()
BEGIN
SELECT 
    `e`.employee_id,
    `e`.first_name,
    `e`.last_name,
    `ps`.parking_spot_id
FROM
    employees AS `e`
        LEFT JOIN
    parking_spots AS `ps` ON `e`.parking_spot_id = `ps`.parking_spot_id 
    WHERE `ps`.parking_spot_id IS NULL;
END//

DELIMITER ;

CALL usp_get_all_employees_not_assigned_parking;


# Exercise 7: Create a procedure to display parking spots which are unassigned.

DELIMITER //

CREATE PROCEDURE usp_get_all_parking_spots_not_assigned()
BEGIN 
SELECT 
    `ps`.parking_spot_id,
    `ps`.spot_number,
    `ps`.basement_level
FROM
     parking_spots AS `ps`
        LEFT JOIN
    employees AS `e` ON `ps`.parking_spot_id = `e`.parking_spot_id 
    WHERE `e`.employee_id IS NULL;
END//

DELIMITER ;

CALL usp_get_all_parking_spots_not_assigned;


# Exercise 8: Create a procedure to insert a parking spot.

DELIMITER //

CREATE PROCEDURE usp_insert_parking_spot(IN spotNumber INT,IN basementLevel INT)
BEGIN
INSERT INTO 
	parking_spots(spot_number,basement_level) 
		VALUES (spotNumber,basementLevel);
END//

DELIMITER ;

CALL usp_insert_parking_spot(6,1);


# Exercise 9: Create a procedure that inserts an employee with a parking spot.

DELIMITER //

CREATE PROCEDURE usp_insert_employee_with_parking_spot(IN firstName CHAR(100),IN lastName CHAR(100),IN spotID INT)
BEGIN 
INSERT INTO 
	employees(first_name,last_name,parking_spot_id) 
		VALUES(firstName,lastName,spotID);
END//

DELIMITER ;

CALL usp_insert_employee_with_parking_spot('Goutham','Chary',216);


# Exercise 10: Create a procedure that inserts an employee without a parking spot.

DELIMITER //

CREATE PROCEDURE usp_insert_employee_without_parking_spot_id(IN firstName CHAR(100),IN lastName CHAR(100))
BEGIN 
INSERT INTO 
	employees(first_name,last_name) 
		VALUES (firstName,lastName);
END//

DELIMITER ;

CALL usp_insert_employee_without_parking_spot_id('Sagar','Guptha');


# Exercise 11: Create a procedure to assign a parking spot to an existing employee (manual parking spot assignment).

DELIMITER //

CREATE PROCEDURE usp_update_employee_parking_spot(IN employeeID INT, IN spotID INT)
BEGIN
UPDATE 
	employees 
    SET parking_spot_id=spotID 
    WHERE employee_id=employeeID;
END//

DELIMITER ;

CALL usp_update_employee_parking_spot(123,204);


# Exercise 12: Create a procedure to assign a parking spot to an existing employee (automatic parking spot assignment).

DELIMITER //

CREATE PROCEDURE usp_update_parking_spot_of_an_employee(IN empID INT)
BEGIN
UPDATE 
	employees 
    SET parking_spot_id=205 
    WHERE employee_id=empID;
END//

DELIMITER ;

CALL usp_update_parking_spot_of_an_employee(102);


# Exercise 13: Create a procedure to remove an employee's parking assignment.

DELIMITER //
 
CREATE PROCEDURE usp_remove_an_employee_parking_spot(IN empID INT)
BEGIN 
UPDATE 
	employees SET 
    parking_spot_id = NULL 
    WHERE employee_id=empID;
END//

DELIMITER ;

CALL usp_remove_an_employee_parking_spot(102);


# Exercise 14: Create a procedure to move an employee from one parking spot to another.

DELIMITER //

CREATE PROCEDURE usp_update_employee_parking_spot_to_another(IN empID INT,IN existingSpotID INT,IN newSpotID INT)
BEGIN
UPDATE 
	employees 
    SET parking_spot_id=newSpotID 
    WHERE employee_id=empID AND parking_spot_id=existingSpotID;
END//

DELIMITER ;

CALL usp_update_employee_parking_spot_to_another(106,206,205);
    

# Exercise 15: Create a procedure to remove an employee.

DELIMITER //

CREATE PROCEDURE usp_remove_an_employee(IN empID INT)
BEGIN 
DELETE 
	FROM employees
	WHERE employee_id=empID;
END//

DELIMITER ;

CALL usp_remove_an_employee(115);