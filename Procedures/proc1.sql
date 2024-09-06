CREATE PROCEDURE UpdateEmployeeInfo
    @Employee_id int,
    @Employee_first_name char(20),
    @Employee_last_name char(35),
    @Employee_addres char(100),
    @Employee_phone numeric(18,0),
	@UpdatedEmployee_name Char(20)OUTPUT,
	@UpdatedEmployee_last_name char(35)OUTPUT,
	@UpdatedEmployee_addres char(100) OUTPUT,
    @UpdatedEmployee_phone numeric(18,0)OUTPUT
AS
BEGIN
    UPDATE Employee
    SET Employee_first_name = @Employee_first_name,
        Employee_last_name = @Employee_last_name,
        Employee_addres = @Employee_addres,
        Employee_phone = @Employee_phone
    WHERE Employee_id = @Employee_id
	SET @UpdatedEmployee_name = @Employee_first_name
	SET @UpdatedEmployee_last_name = @Employee_last_name
	SET @UpdatedEmployee_addres = @Employee_addres
	SET @UpdatedEmployee_phone = @Employee_phone
END
GO