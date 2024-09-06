CREATE TRIGGER check_employee_post
ON Purchase
FOR INSERT
AS
BEGIN
    IF EXISTS(
        SELECT * 
        FROM inserted i 
        JOIN Employee  ON i.Employee_id = Employee.Employee_id 
        JOIN Post ON Employee.Post_id = Post.Post_id 
        WHERE Post.Post_id != 1 OR Post.Post_id = 3
    )
    BEGIN
        RAISERROR('Only waiters can accept orders', 16, 1)
        ROLLBACK TRANSACTION
    END
END
