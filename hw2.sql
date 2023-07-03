#1
With eb as (select e.enum, e.ename, e.dname, b.ename as Boss_Name
from Employee e left join Employee b on e.bossnum = b.enum)
Select distinct e.enum, e.ename, e.boss_name, s.iname
from eb e right join sale s on e.dname = s.dname
where s.iname like 'S%';

#2
With salary_floor as (select avg(e.esalary) as Avg_Salary, d.dfloor 
from employee e left join dept d on e.dname=d.dname group by d.dfloor)
Select e.enum, e.ename, e.esalary, d.dfloor
from employee e left join dept d on e.dname=d.dname 
left join salary_floor s on d.dfloor=s.dfloor
where e.esalary >= s.avg_salary;

#3
With qty as (select iname, sum(sqty) as Total_Sale from Sale group by iname)
SELECT i.itype, low3.iname, low3.Total_Sale
FROM qty low3 left join Item i on low3.iname=i.iname
WHERE (select count(distinct total_sale) 
FROM qty others 
WHERE low3.total_sale>others.total_sale) < 3;

#4
With dept_popular as (select dname from Sale where iname=
(select iname as popular_item from sale group by iname having sum(sqty) = 
(SELECT MAX(SUM(sqty)) FROM sale GROUP BY iname)))
Select dname 
from Dept 
where dname not in (select dname from dept_popular);

#5
With de as (select d.dname as EMP_DEPT, count(e.dname) as Employee_Count 
from Dept d, Employee e where d.dname=e.dname group by d.dname),
ds as (select dname as SALE_DEPT, count(dname) as Sale_Count
from Sale group by dname)
Select de.EMP_DEPT, ds.SALE_DEPT, de.Employee_Count, ds.Sale_Count, 
case 
    when Employee_Count is not null and Sale_Count is not null
    then Sale_Count/Employee_Count
    else null
    end as "Sale per Employee"
from de full join ds on EMP_DEPT=SALE_DEPT
order by SALE_DEPT;

select d.dname as EMP_DEPT, s.dname as SALE_DEPT, 
count(e.dname) as Employee_Count, count(s.dname) as Sale_Count
from Dept d full join Employee e on d.dname=e.dname 
left join Sale s on d.dname=s.dname
group by d.dname, s.dname;

select dname as SALE_DEPT, sum(sqty) as Sale_Count
from Sale group by dname;


