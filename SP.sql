-- Exercise 1: Create a procedure to display all employees.

DELIMITER //

CREATE PROCEDURE DELIMITER //

CREATE PROCEDURE DisplayAllEmployee()
BEGIN
    SELECT * FROM Employee;
END //

DELIMITER ;

DROP PROCEDURE DisplayAllEmployee;

CALL DisplayAllEmployee();

DELIMITER $$
-- Exercise 2: Create a procedure to display all parking spots.

CREATE PROCEDURE displayALLParking_spots()
begin

select * from Parking_spots;
END$$
DELIMITER ;
CALL DisplayAllParking_spots();
-- Display employee by ID
-- Exercise 3: Create a procedure to display a single employee by employee id.
DELIMITER //
CREATE procedure displayEmployeebyId(In p_employee_id INT)
begin
 SELECT * FROM Employee
 WHERE Employee_id=p.employee_id;
 END$$
 DELIMITER ;
 
 CALL displayEmployeebyId();

 -- Display parkingspot by ID
DELIMITER //
Drop procedure DisplayParkingSpotById;
CREATE PROCEDURE DisplayParkingSpotById(IN p_parking_spot_id INT)
BEGIN
    SELECT *
    FROM Parking_Spot
    WHERE parking_spot_id = p_parking_spot_id;
END //

DELIMITER ;
CALL DisplayParkingSpotById(1);

-- Employees with parking spots
DELIMITER //
create procedure EmployeewithParking()
begin
select * from Employee
where parking_spot_id is not null;
END//
DELIMITER ;
CALL EmployeewithParking();
-- ---------
-- without parking 

DELIMITER //
create procedure EmployeewithoutParking()
begin
select * from Employee
where parking_spot_id is not null;
END//
DELIMITER ;
CALL EmployeewithoutParking();

-- Unassigned parking spots
DELIMITER //
CREATE PROCEDURE UnassignedParkingSpots()
BEGIN
    SELECT *
    FROM Parking_Spots
    WHERE parking_spot_id NOT IN (
        SELECT parking_spot_id
        FROM Employee
        WHERE parking_spot_id IS NOT NULL
    );
END //

DELIMITER ;

CALL  UnassignedParkingSpots();

-- 8 Insert parking spot
DELIMITER //
CREATE PROCEDURE InsertParkingSpot(
    IN p_spot_number INT,
    IN p_basement_level INT
)
BEGIN
    INSERT INTO Parking_Spots(spot_number, basement_level)
    VALUES (p_spot_number, p_basement_level);
END //

DELIMITER ;

CALL InsertParkingSpot(10,2);

-- 9InsertEmployeewithParkingSpot
DELIMITER //
DROP PROCEDURE IF EXISTS InsertEmployeewithParking;
CREATE PROCEDURE InsertEmployeewithParking(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_parking_spot_id INT
)
BEGIN
    INSERT INTO Employee(first_name, last_name, parking_spot_id)
    VALUES (p_first_name, p_last_name, p_parking_spot_id);
END //

DELIMITER ;

CALL InsertEmployeewithParking('chandu','venkat',1);

-- 10 Exercise 10: Insert an employee without a parking spot
DELIMITER //
CREATE PROCEDURE InsertEmployeeWithoutparking(
In p_first_name char(50),
in p_last_name char(50))
Begin
INSERT INTO Employee(first_name,last_name)
values(p_first_name,p_Last_name);
END //
DELIMITER //

CALL InsertEmployeeWithoutparking('Sai','Venkat');
-- Exercise 11: Assign a parking spot manually
DELIMITER //
CREATE PROCEDURE AssignParkingSpotmanual(
In p_employee_id INT,
In p_parking_spot_id int)
begin
update Employee
SET parking_spot_id=p_parking_spot_id
WHERE employee_id=p_employee_id;
END//
DELIMITER ;

CALL AssignParkingSpotmanual(2,3);
-- Exercise 12: Assign a parking spot automatically

DELIMITER //

CREATE PROCEDURE AssignParkingSpotAuto(
    IN p_employee_id INT
)
BEGIN
    DECLARE v_spot INT;

    SELECT parking_spot_id
    INTO v_spot
    FROM Parking_Spots
    WHERE parking_spot_id NOT IN
    (
        SELECT parking_spot_id
        FROM Employee
        WHERE parking_spot_id IS NOT NULL
    )
    LIMIT 1;

    UPDATE Employee
    SET parking_spot_id = v_spot
    WHERE employee_id = p_employee_id;
END //

DELIMITER ;
CALL AssignParkingSpotAuto(5);

-- Exercise 13: Remove an employee's parking assignment
DELIMITER //

CREATE PROCEDURE RemoveParkingAssignment(
    IN p_employee_id INT
)
BEGIN
    UPDATE Employee
    SET parking_spot_id = NULL
    WHERE employee_id = p_employee_id;
END //

DELIMITER ;
CALL RemoveParkingAssignment(2);

-- Exercise 14: Move an employee to another parking spot
DELIMITER //

CREATE PROCEDURE MoveParkingSpot(
    IN p_employee_id INT,
    IN p_old_spot INT,
    IN p_new_spot INT
)
BEGIN
    UPDATE Employee
    SET parking_spot_id = p_new_spot
    WHERE employee_id = p_employee_id
      AND parking_spot_id = p_old_spot;
END //

DELIMITER ;

CALL MoveParkingSpot(2,1,4);

-- Exercise 15: Remove an employee
DELIMITER //
CREATE PROCEDURE DeleteEmployee(
    IN p_employee_id INT
    )
BEGIN
    DELETE FROM Employee
    WHERE employee_id = p_employee_id;
END //
DELIMITER ;
CALL DeleteEmployee(2);