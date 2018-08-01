
// Create student table
create table student (id Integer, name varchar(30));
fmd1=> select * from student;
WARNING:  database "fmq1" must be vacuumed within 1495571398 transactions
HINT:  To avoid a database shutdown, execute a full-database VACUUM in "fmq1".
 id |  name  | salary 
----+--------+--------
  6 | kapil  |  10000
  5 | ganesh |  50000
  1 | kapil  |  10000
  3 | ramesh |  30000
  4 | suresh |  40000
  2 | mahesh |  20000
(6 rows)

// Finding Nth maximun and minimum

select * from student st1 where  6=
     (select count(*) from student st2 where st2.id >= st1.id)
     
     
//Finding duplicates:

select * from student group by name,salary having count(*)>1;

// Getting duplicates

insert into student values(1,'kapil',10000);
insert into student values(2,'mahesh',20000);
insert into student values(3,'ramesh',30000);
insert into student values(4,'suresh',40000);
insert into student values(5,'ganesh',50000);
insert into student values(6,'kapil',10000);


// Deleting duplicate rows (Every thing deleted)
----  Group by and having does not work with delete , you can only use where clause
delete from student group by name,salary having count(*)>1;


  select * from student stu1 left join 
  (select min(id) as id from student  group by name,salary having count(*)>1)abc  on stu1.id=abc.id
  where abc.id is null;
  
  -- Note below query will not work on postgres , else it is perfectly working fine on all other database.
  delete from student stu1 left join (select min(id) as id from student  group by name,salary having count(*)>1)abc  on stu1.id=abc.id
  and abc.id is not null;
  
  
  
 =============Self Join====================== 
  
  Self Join:
Problem1 : Print which employee belongs to which manager?
Problem2 : Print the Manager who is having more then 2 reportee?
Problem 3: Print employee hierarchy tree?

create table employee(
empId integer,
empName varchar(20),
managerId integer  
);
insert into employee values(1,'kapil',2);
insert into employee values(2,'mahesh',1);
insert into employee values(3,'ramesh',2);
insert into employee values(4,'suresh',3);
insert into employee values(5,'suresh',2);


Solution 1:
select emp.empName as Employee ,man.empName as Manager
from employee emp join employee man
on emp.managerId=man.empId
order by emp.empId


Solution 2:
select man.empName as Manager
from employee emp join employee man
on emp.managerId=man.empId
group by emp.managerId
having (count(emp.managerId)>2)
