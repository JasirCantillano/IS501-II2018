----Obtener el porcentaje del salario de cada empleado con respecto al salario total de la empresa.

select *
from hr.employees;

update employees
set salary = 24000
where employee_id = 101;

commit;

--24000
--691416


select (24000/691416)*100 from dual;

select sum(salary)
from employees;


SELECT FIRST_NAME, SALARY, ROUND((SALARY/(SELECT SUM(SALARY) FROM EMPLOYEES))*100,2) AS PORCENTAJE
FROM EMPLOYEES;


SELECT FIRST_NAME, SALARY, (SALARY/(SELECT SUM(SALARY) FROM EMPLOYEES))*100 AS PORCENTAJE
FROM EMPLOYEES;

SELECT X
FROM Y
WHERE Z;

IN
EXIST
=


---Obtener el empleado que gana más.
select first_name, salary, rownum_interno,rownum
from (
    select first_name, salary, rownum as rownum_interno
    from employees
    order by salary desc
)
where rownum = 1; --Filtra el primer registro.

select rowid,first_name, rownum
from employees
where rownum = 1;


SELECT DEPARTMENT_ID , SUM(SALARY) AS SALARIO_TOTAL
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING SUM(SALARY)<=10000;



SELECT *
FROM (
    SELECT DEPARTMENT_ID , SUM(SALARY) AS SALARIO_TOTAL
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
)
WHERE SALARIO_TOTAL <=10000;



SELECT *
FROM EMPLOYEES
WHERE SALARY = (
            SELECT MIN(SALARY)
            FROM EMPLOYEES
        );


