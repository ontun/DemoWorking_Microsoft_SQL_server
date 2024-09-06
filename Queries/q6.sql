SELECT Employee_first_name, Employee_last_name, Post_name
FROM Employee 
JOIN Post ON Employee.Post_id = Post.Post_id 
WHERE Post_salary > 30000;