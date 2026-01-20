use session3;

create table ex4_users(
	userID int primary key,
    userName varchar(50) unique,
    email varchar(50) unique,
    userPassword varchar(50) not null,
    userStatus varchar(3) default 'OFF'
);

alter table ex4_users modify userStatus varchar(3) default 'OFF'
check (userStatus = 'OFF' or userStatus = 'ON');

drop table ex4_users;