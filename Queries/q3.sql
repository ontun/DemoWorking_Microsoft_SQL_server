SELECT Institution.Institution_name, COUNT(Employee.Employee_id) AS employee_count
FROM Institution
JOIN Employee ON Institution.Institution_id = Employee.Institution_id
GROUP BY Institution.Institution_name
ORDER BY employee_count DESC
