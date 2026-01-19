use session2;

create table ex4_users(
	userID int primary key,
    userName varchar(100) unique,
    userPassword varchar(50) not null,
    userStatus varchar(8) default 'ACTIVE' check(userStatus='ACTIVE' or userStatus='INACTIVE')
);