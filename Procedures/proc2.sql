CREATE PROCEDURE AddPost
    @Post_name char(20),
    @Post_salary money,
    @Post_work_schedule char(20),
    @Post_Responsibilities char(50),
    @Post_id int OUTPUT,
    @Post_name_out char(20) OUTPUT,
    @Post_salary_out money OUTPUT
AS
BEGIN
	SET @Post_id = (SELECT MAX(Post_id) FROM Post )+1
    INSERT INTO Post (Post_id,Post_name, Post_salary, Post_work_schedule, Post_Responsibilities)
    VALUES (@Post_id,@Post_name, @Post_salary, @Post_work_schedule, @Post_Responsibilities)
	

    SELECT @Post_name_out = Post_name, @Post_salary_out = Post_salary FROM Post WHERE Post_id = @Post_id
END