-- 1.創建restaurant database----- ----- ----- ----- ----- ----- -----
create database if not exists restaurant;
-- 2.使用restaurant database----- ----- ----- ----- ----- ----- -----
use restaurant;

-- ----- ----- ----- ----- ----- 會員 ----- ----- ----- ----- -----
create table if not exists members(
	mem_id int not null primary key,
    mem_name varchar(50) not null,
    mem_account varchar(20) not null,
	mem_password varchar(20) not null,
    mem_gender tinyint(1) not null,
	mem_phone varchar(20) not null,
    mem_email varchar(50) not null,
    mem_address varchar(100) not null,
    mem_birthday date not null,
    mem_permission tinyint(1)
);
-- ----- ----- ----- ----- ----- 員工 ----- ----- ----- ----- -----
create table if not exists employee
(
	emp_id int primary key auto_increment not null,
	emp_name varchar(50) not null,
	emp_account varchar(20) not null,
	emp_password varchar(20) not null,
	emp_permission tinyint(1) not null,
	emp_phone varchar(20) not null,
	emp_address varchar(100) not null,
	emp_job varchar(20) not null,
    emp_hiredate datetime not null
);
-- ----- ----- ----- ----- ----- 功能 ----- ----- ----- ----- -----
create table if not exists functions
(
	function_id int primary key not null,
	function_name varchar(10) not null
);
-- ----- ----- ----- ----- ----- 權限 ----- ----- ----- ----- -----
create table if not exists permission
(
	emp_id int not null,
	function_id int not null,
    primary key (emp_id, function_id),
    constraint FK_permission_emp_id foreign key(emp_id) references employee(emp_id),
    constraint FK_permission_function_id  foreign key(function_id) references functions(function_id)
);
-- ----- ----- ----- ----- ----- 候位 ----- ----- ----- ----- -----
create table if not exists waiting
(
	waiting_id int primary key auto_increment not null,
    waiting_date date not null,
    waiting_time tinyint(1) not null,
    current_no int not null,
    current_queued_no int not null
);
-- ----- ----- ----- ----- ----- 排隊人員 ----- ----- ----- ----- -----
create table if not exists queuer
(
	queuer_id  int primary key not null auto_increment,
    waiting_id int not null,
    queuer_status tinyint not null,
    queuer_name varchar(10) not null,
    queuer_phone varchar(20) not null,
    queuer_no int not null,
	constraint FK_queuer_waiting_id
    foreign key(waiting_id) references waiting(waiting_id)
);
-- ----- ----- ----- ----- ----- 桌型 ----- ----- ----- ----- -----
create table if not exists table_type(
	table_type_id int primary key not null ,
    table_type  int not null,
    table_type_number int 
    
);
-- ----- ----- ----- ----- ----- 桌子 ----- ----- ----- ----- -----
create table if not exists seat(
	seat_id int not null,
    table_type_id  int not null,
    primary key (seat_id),
	constraint FK_seat_table_type_id foreign key (table_type_id) references table_type(table_type_id)
);
-- ----- ----- ----- ----- ----- 桌型view ----- ----- ----- ----- -----
-- create view table_type_view (table_type_id, table_type,table_type_number) as
-- select  t.table_type_id,table_type, count(*)  as table_type_number 
-- from table_type t  join seat s on s.table_type_id  =  t.table_type_id
-- group by table_type_id;

-- select * from table_type_view;
-- ----- ----- ----- ----- ----- 訂位 ----- ----- ----- ----- -----
create table if not exists reservation(
reservation_id int not null primary key auto_increment,
mem_id int not null,
table_type_id int,
reservation_num int not null,
reservation_time tinyint(1) not null,
reservation_to_seat tinyint(1) not null,
reservation_date datetime not null,
reservation_eatday datetime not null
,constraint foreign key(mem_id) references members(mem_id),
constraint foreign key(table_type_id) references table_type(table_type_id)
);
-- ----- ----- ----- ----- ----- 訂位控制----- ----- ----- ----- -----
create table if not exists reservation_ctrl
(reservation_ctrl_id int not null primary key,
table_type_id int,
reservation_ctrl_open tinyint(1) not null,
reservation_ctrl_date date not null,
reservation_ctrl_period tinyint(1) not null,
reservation_ctrl_max int not null,
reservation_ctrl_number int not null,
constraint FK_table_type_id foreign key (table_type_id) references table_type(table_type_id)
);

-- ----- ----- ----- ----- ----- 餐點種類 ----- ----- ----- ----- -----
create table if not exists meals_category(
	meals_category_id int primary key auto_increment not null ,
	meals_category varchar(10) not null
);

-- ----- ----- ----- ----- ----- 餐點 ----- ----- ----- ----- -----
create table if not exists meals(
	meals_id int not null primary key,
    meals_category_id  int not null,
	meals_name  varchar(10) not null,
    meals_price  int not null,
    meals_info  varchar(100) not null,
    meals_picture  blob ,
    meals_control  tinyint(1) not null,
    constraint FK_meals_category_id foreign key (meals_category_id) references meals_category(meals_category_id)
    );
-- ----- ----- ----- ----- ----- 訂單 ----- ----- ----- ----- -----
create table if not exists orders(
	orders_id int not null  primary key,
    mem_id int not null ,
    emp_counter_id int not null,
	emp_delivery_id int,
    seat_id int,
    orders_type tinyint(1) not null,
    orders_amount int not null,
    orders_status tinyint(1) not null,
    orders_destination varchar(100),
    orders_bulid_date datetime not null,
    orders_make_date datetime not null,
    constraint FK_orders_mem_id foreign key(mem_id) references members(mem_id),
	constraint FK_orders_emp_counter_id foreign key(emp_counter_id) references employee(emp_id),
	constraint FK_orders_emp_delivery_id foreign key(emp_delivery_id ) references employee(emp_id),
	constraint FK_seat_id foreign key(seat_id) references seat(seat_id)
);
-- ----- ----- ----- ----- ----- 訂單明細 ----- ----- ----- ----- -----
create table if not exists orddetails(
	orddetails_id int not null primary key,
    orders_id int not null,
    meals_id int not null ,
    orddetails_meals_quantity int not null,
    orddetails_meals_amount int not null,
    orddetails_meals_status tinyint(1) not null,
	orddetails_deliver_ststus tinyint(1) not null,
	constraint FK_orddetails_orders_id foreign key(orders_id) references orders(orders_id),
	constraint FK_orddetails_meals_id foreign key(meals_id) references meals(meals_id)
);
-- ----- ----- ----- ----- ----- 最新消息 ----- ----- ----- ----- -----
create table if not exists news(
	news_id int not null primary key auto_increment,
	emp_id int not null,
    news_date datetime not null,
    news_title varchar(20) not null,
    news_information varchar(500) not null,
    news_control tinyint(1) not null,
    news_pictures blob,
	constraint FK_news_emp_id foreign key(emp_id) references employee(emp_id)
);
-- ----- ----- ----- ----- ----- 關於我們 ----- ----- ----- ----- -----
CREATE table if not exists about_us(
	about_us_name  varchar(50) not null primary key,
    about_us_content varchar(300) not null
  );  
-- ----- ----- ----- ----- ----- 線上客服 ----- ----- ----- ----- -----
create table if not exists chatroom_service(
	chatroom_service_id int not null primary key auto_increment,
    emp_id int ,
    mem_id int ,
    chatroom_id int not null ,
    chatroom_content varchar(2000) not null,
    chatroom_send_direction tinyint(1) not null,
	chatroom_create_time datetime not null,
    chatroom_end_time datetime not null,
    constraint FK_chatroom_service_emp_id foreign key(emp_id) references employee(emp_id),
	constraint FK_chatroom_service_mem_id foreign key(mem_id) references  members(mem_id)
);
-- ----- ----- ----- ----- ----- 機器人 ----- ----- ----- ----- -----
create table if not exists botqa(
	keyword_id int not null primary key auto_increment,
	keyword_name varchar(50) not null,
	keyword_contnxt varchar(500) not null
);
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----