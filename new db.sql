create database dharwadhubbalitutorial;
create table student (
student int,
lastname varchar (255),
firstname varchar (255),
address varchar (255),
city varchar (255));
create table fees_details (
name varchar (255),
paid_fees int,
pending_fees int,
total_fees int);
alter table student add email varchar (255);
