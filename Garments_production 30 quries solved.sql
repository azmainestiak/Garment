CREATE TABLE garments_employees (
    employee_id     INT PRIMARY KEY,
    name            VARCHAR(50),
    department      VARCHAR(30),
    role            VARCHAR(30),
    hire_date       DATE,
    shift           VARCHAR(20),
    salary          INT,
    factory_unit    VARCHAR(30)
);


CREATE TABLE garments_production (
    order_id        INT PRIMARY KEY,
    product_name    VARCHAR(50),
    category        VARCHAR(30),
    unit            VARCHAR(10),
    quantity        INT,
    order_date      DATE,
    delivery_date   DATE,
    status          VARCHAR(20),
    supervisor_id   INT,
    FOREIGN KEY (supervisor_id)
        REFERENCES garments_employees(employee_id)
);



SELECT * FROM garments_employees;

SELECT * FROM garments_production;



🟢 Basic (1–10)

--Show all employees from the Sewing department

select * from garments_employees
where department = 'sewing';


--List all employees working in Unit A

select * from garments_employees
where factory_unit = 'Unit A';

--Display all production orders with status = "Completed"
select * from garments_production
where status = 'Completed';


--Find all employees working in the Morning shift
select * from garments_employees
where shift = 'Morning';


--Show product_name and quantity from production table

select product_name, quantity
from garments_production;

--Count total number of employees

select count(*)
from garments_employees;

--Count total number of production orders

select count(*) as total_production_order
from garments_production;

--List distinct departments from employees table

select distinct department
from garments_employees;

--Show all orders placed in February 2024

select * from garments_production
where order_date between '2024-02-01' and '2024-02-29';

--Display employees with salary greater than 20,000

select employee_id, name, department, salary
from garments_employees
where salary > 20000;


--🟡 Intermediate (11–20)

--Find average salary of employees

select avg(salary)
from garments_employees;

--Count employees per department

select department, count(*)
from garments_employees
group by department;

--Find total production quantity per product

select product_name, sum(quantity) as total_prd_quantity
from garments_production
group by product_name;

--List employees hired after 2020

select * from garments_employees
where hire_date > '2020-01-01';

--Show production orders with quantity more than 3000.

select product_name, category, quantity
from garments_production
where quantity > 3000;

--Find highest salary in the factory

select employee_id, name, salary
from garments_employees
order by salary desc
limit 1;

--Find lowest production quantity

select product_name, quantity
from garments_production
order by quantity asc
limit 1;

--Count number of orders per status

select status, count(*)
from garments_production
group by status;


--Show employees working in Night shift with salary < 20,000

select * from garments_employees
where shift = 'Night'
and salary < 20000;


--Sort employees by salary descending

select * from garments_employees
order by salary desc;

--🔴 Advanced (21–30)

--Join employees and production tables using supervisor_id
SELECT * FROM garments_employees;

SELECT * FROM garments_production;



select e.name, e.department, p.order_id, p.product_name
from garments_employees e
join
garments_production p
on e.employee_id = p.supervisor_id;

--Show supervisor name with total quantity they supervised

select e.name, p.quantity
from garments_employees e
join
garments_production p
on e.employee_id = p.supervisor_id
group by e.name, p.quantity;

--Find department-wise average salary

select department, avg(salary) as avg_salary
from garments_employees
group by department;

--Find products that are still Pending
SELECT product_name
FROM garments_production
WHERE status = 'Pending';



--Find supervisors who handled more than 2 orders

select supervisor_id, count(*) as order_count
from garments_production
group by supervisor_id
having count(*) > 2;


--Calculate total production quantity per month

SELECT TO_CHAR(order_date, 'YYYY-MM') AS month,
       SUM(quantity) AS total_quantity
FROM garments_production
GROUP BY month
ORDER BY month;

--Find employees who are supervisors.

select department, role
from garments_employees
where role = 'Supervisor';


--Find top 3 highest paid employees.

select salary, name
from garments_employees
order by salary desc
limit 3;

--Show factory_unit-wise employee count.

select factory_unit, count(*)
from garments_employees
group by factory_unit;

--Find production orders where delivery took more than 20 days.

select*,
		delivery_date-order_date as delivery_days
		from garments_production
		where delivery_date-order_date > 20;


