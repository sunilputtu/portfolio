create database dharwadhublitutorial;
create table student (
student int,
lastname varchar (255),
firstname varchar (255),
address varchar (255),
city varchar (255));

insert into student (student,lastname,firstname,address,city) values ( 202916, 'sunilputtu', 'mk', 'karennanavar', 'dharwad');

Alter table student rename column student to student_id;
ALTER TABLE student
Modify COLUMN student_id int NOT NULL;

insert into student (lastname,firstname,address,city) values ('sunilputtu', 'mk', 'karennanavar', 'dharwad');
insert into student (student_id,lastname,firstname,address,city) values ( 916, 'sunilputtu', 'mk', 'karennanavar', 'dharwad');

select * from Students;
create table Students (
studentID int primary key auto_increment,
lastname varchar (255),
firstname varchar (255),
address varchar (255),
city varchar (255) check (city='dharwad'));
insert into Students (lastname,firstname,address,city) values (  'sunilputtu', 'mk', 'karennanavar', 'dharwad');
insert into Students (lastname,firstname,address,city) values ('sunilputtu', 'mk', 'karennanavar', 'Dharwad');
