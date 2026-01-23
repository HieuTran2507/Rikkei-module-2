use session9;

create view view_customer_contact as
select id, customer_name, email, phone from customers;

select * from view_customer_contact;

