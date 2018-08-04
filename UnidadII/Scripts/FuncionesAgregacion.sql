SELECT A.FIRST_NAME||' '|| A.LAST_NAME AS NAME, SALARY, JOB_ID, B.DEPARTMENT_NAME
FROM EMPLOYEES A
LEFT JOIN DEPARTMENTS B
ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID);


SELECT B.DEPARTMENT_NAME, 
        SUM(SALARY) AS SALARIO_TOTAL, 
        COUNT(*) AS CANTIDAD_EMPLEADOS,
        AVG(SALARY) AS PROMEDIO,
        MAX(SALARY) AS SALARIO_MAXIMO,
        MIN(SALARY) AS SALARIO_MINIMO
FROM EMPLOYEES A
LEFT JOIN DEPARTMENTS B 
ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
GROUP BY B.DEPARTMENT_NAME;

SELECT hire_date, count(*) cantidad_empleados
FROM EMPLOYEES
group by  hire_date;

select *
from employees
where hire_date = to_date('10/03/2005','dd/mm/yyyy');


select to_char(hire_date, 'FMMONTH/YYYY') as mes, hire_date, first_name, last_name
from employees;

--Mostrar la cantidad de empleados que han ingresado por cada mes
select to_char(hire_date, 'FMMONTH/YYYY') as mes, count(*)
from employees
group by to_char(hire_date, 'FMMONTH/YYYY');

----Mostrar la cantidad de empleados que han ingresado por cada año
select to_char(hire_date, 'YYYY') as mes, count(*)
from employees
group by to_char(hire_date, 'YYYY')
order by 1;




select * 
from employees
order by hire_date asc;



select chr(67) from dual;


SELECT CONCAT('Buenas',' tardes') FROM DUAL; 