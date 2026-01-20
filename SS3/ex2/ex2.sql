use session3;

create table ex2_books(
	bookID int primary key,
    bookName varchar(100) not null,
    author varchar(100),
    publicYear year
);

create table ex2_readers(
	readerID int primary key,
    readerName varchar(100) not null,
    borrowingBooks int not null,
    email varchar(100),
    phone varchar(10),
    check(email is not null or phone is not null)
);

create table ex2_borrowings(
	bookID int,
    readerID int,
    borrowedDate date,
    dueDate date,
    primary key (bookID,readerID),
    constraint FK_ex2_1
		foreign key (bookID) references  ex2_books(bookID),
	constraint FK_ex2_2
		foreign key (readerID) references  ex2_readers(readerID)
);

alter table ex2_borrowings 
modify	borrowedDate date not null,
modify    dueDate date not null;
    
