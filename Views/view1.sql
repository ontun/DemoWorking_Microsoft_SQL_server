CREATE VIEW Employee_info AS
SELECT Employee.Employee_first_name, Employee.Employee_last_name, Post.Post_name,
Post.Post_salary, Post.Post_work_schedule, Post.Post_Responsibilities, Institution.Institution_name, Institution.Institution_addres, City.City_name
FROM Employee
JOIN Post ON Employee.Post_id = Post.Post_id
JOIN Institution ON Employee.Institution_id = Institution.Institution_id
JOIN City ON Employee.City_id = City.City_id;