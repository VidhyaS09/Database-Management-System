SELECT employee_id, first_name, last_name, hire_date
FROM emp_employees
WHERE hire_date >= TRUNC(SYSDATE) - INTERVAL '1' YEAR
  AND hire_date <= TRUNC(SYSDATE);
  
  SELECT d.department_id, d.department_name, SUM(s.salary) AS total_salary_expenditure
FROM emp_departments d
LEFT JOIN emp_employees e ON d.department_id = e.department_id
LEFT JOIN emp_salaries s ON e.employee_id = s.employee_id
GROUP BY d.department_id, d.department_name;

SELECT e.employee_id, e.first_name, e.last_name, d.department_name, s.salary
FROM (
    SELECT employee_id, salary,
           RANK() OVER (ORDER BY salary DESC) AS salary_rank
    FROM emp_salaries
) s
JOIN emp_employees e ON s.employee_id = e.employee_id
JOIN emp_departments d ON e.department_id = d.department_id
WHERE s.salary_rank <= 5;
