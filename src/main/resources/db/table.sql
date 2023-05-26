-- 회원 등급
CREATE TABLE member_grade_tb
(
   name VARCHAR (10) PRIMARY KEY
);
-- 사용자
CREATE TABLE user_tb
(
   id VARCHAR (50) PRIMARY KEY,
   password VARCHAR (255) NOT NULL,
   user_role VARCHAR (5) NOT NULL DEFAULT '회원'
);
-- 회원
<<<<<<< HEAD
CREATE TABLE member_tb(
   id VARCHAR(50) PRIMARY KEY,
   kor_name VARCHAR(20),
   eng_name VARCHAR(50),
   birth_date DATE,
   gender VARCHAR(1) NOT NULL,
   phone_number VARCHAR(13),
   email VARCHAR(40),
   address VARCHAR(200),
   nationality VARCHAR(50),
   grade VARCHAR(10) DEFAULT 'Silver', FOREIGN KEY (grade) REFERENCES member_grade_tb(name)
=======
CREATE TABLE member_tb
(
   id VARCHAR (50) PRIMARY KEY,
   kor_name VARCHAR (20) NOT NULL,
   eng_name VARCHAR (50) NOT NULL,
   birth_date DATE NOT NULL,
   gender VARCHAR (2) NOT NULL,
   phone_number VARCHAR (13) NOT NULL,
   email VARCHAR (40) NOT NULL,
   address VARCHAR (200) NOT NULL,
   nationality VARCHAR (50) NOT NULL,
   grade VARCHAR (10),
   FOREIGN KEY (grade) REFERENCES member_grade_tb (name)
>>>>>>> feature/board
);
-- 관리자
<<<<<<< HEAD
CREATE TABLE manager_tb(
   id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    gender VARCHAR(1) NOT NULL,
    phone_number VARCHAR(13) NOT NULL,
    email VARCHAR(40) NOT NULL,
    address VARCHAR(200) NOT NULL
=======
CREATE TABLE manager_tb
(
   id VARCHAR (50) PRIMARY KEY,
   name VARCHAR (50) NOT NULL,
   birth_date DATE NOT NULL,
   gender VARCHAR (2) NOT NULL,
   phone_number VARCHAR (13) NOT NULL,
   email VARCHAR (40) NOT NULL,
   address VARCHAR (200) NOT NULL
>>>>>>> feature/board
);
-- 공항
CREATE TABLE airport_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
<<<<<<< HEAD
    region VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL UNIQUE
=======
   region VARCHAR (50) NOT NULL,
   name VARCHAR (50) NOT NULL
>>>>>>> feature/board
);
-- 좌석 등급
create table seat_grade_tb
(
   name varchar (10) primary key not null,
   price_multiple int not null
);
-- 비행기
create table airplane_tb
(
   id int primary key AUTO_INCREMENT not null,
   name varchar (20) not null
);
-- 좌석
<<<<<<< HEAD
create table seat_tb(
    airplane_id int not null,
    name varchar(10) not null,
    grade varchar(10) not null,
    PRIMARY KEY (airplane_id, name),
    foreign key (grade) references seat_grade_tb(name),
    foreign key (airplane_id) references airplane_tb(id)
=======
create table seat_tb
(
   airplane_id int not null,
   name varchar (10) not null,
   grade varchar (10) not null,
   PRIMARY KEY
   (
      airplane_id,
      name
   ),
   foreign key (grade) references seat_grade_tb (name),
   foreign key (airplane_id) references airplane_tb (id)
>>>>>>> feature/board
);
-- 노선
create table route_tb
(
   id int primary key auto_increment not null,
<<<<<<< HEAD
   departure varchar(50) not null,
   destination varchar(50) not null,
   flight_time varchar(50) not null,
=======
   departure varchar (50) not null,
   destination varchar (50) not null,
   flight_time varchar (50) not null,
>>>>>>> feature/board
   foreign key (departure) references airport_tb (name),
   foreign key (destination) references airport_tb (name)
);
-- 운항시간별 티켓 가격
create table ticket_price_tb
(
   flight_hours int primary key not null,
   price bigint not null
);
-- 운항 일정
CREATE TABLE schedule_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
<<<<<<< HEAD
    departure_date TIMESTAMP NOT NULL,
    arrival_date TIMESTAMP NOT NULL,
    airplane_id INT NOT NULL,
    FOREIGN KEY (airplane_id) REFERENCES airplane_tb (id),
    route_id INT NOT NULL, 
    FOREIGN KEY (route_id) REFERENCES route_tb (id)
=======
   departure_date TIMESTAMP NOT NULL,
   arrival_date TIMESTAMP NOT NULL,
   airplane_id INT NOT NULL,
   FOREIGN KEY (airplane_id) REFERENCES airplane_tb (id),
   route_id INT NOT NULL,
   FOREIGN KEY (route_id) REFERENCES route_tb (id)
>>>>>>> feature/board
);
-- 예약 티켓
<<<<<<< HEAD
CREATE TABLE ticket_tb(
   id VARCHAR(15) PRIMARY KEY,
    adult_count INT DEFAULT 1 NOT NULL,
    child_count INT DEFAULT 0 NOT NULL,
    infant_count INT DEFAULT 0 NOT NULL,
    seat_grade VARCHAR(10) NOT NULL,
    FOREIGN KEY(seat_grade) REFERENCES seat_grade_tb (name),
    member_id VARCHAR(50) NOT NULL, 
    FOREIGN KEY(member_id) REFERENCES member_tb(id),
    schedule_id INT NOT NULL, 
    FOREIGN KEY(schedule_id) REFERENCES schedule_tb(id),
    reserved_date TIMESTAMP NOT NULL DEFAULT now()
=======
CREATE TABLE ticket_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
   seat_count INT DEFAULT 1 NOT NULL,
   member_id VARCHAR (50) NOT NULL,
   FOREIGN KEY (member_id) REFERENCES member_tb (id),
   schedule_id INT NOT NULL,
   FOREIGN KEY (schedule_id) REFERENCES schedule_tb (id),
   reserved_date TIMESTAMP NOT NULL DEFAULT now ()
>>>>>>> feature/board
);
-- 예약 좌석
<<<<<<< HEAD
CREATE TABLE reserved_seat_tb(
   PRIMARY KEY (schedule_id, seat_name),
   schedule_id INT NOT NULL, 
   FOREIGN KEY(schedule_id) REFERENCES schedule_tb(id),
   seat_name VARCHAR(10) NOT NULL, 
   ticket_id VARCHAR(15) NOT NULL, 
   FOREIGN KEY(ticket_id) REFERENCES ticket_tb(id) ON DELETE CASCADE
);


-- 탑승객
CREATE TABLE passenger_tb (
	name VARCHAR(50) NOT NULL,
	gender VARCHAR(1) NOT NULL, 
	birth_date DATE NOT NULL,
	ticket_id VARCHAR(15) NOT NULL,
	FOREIGN KEY (ticket_id) REFERENCES ticket_tb(id) ON DELETE CASCADE
=======
CREATE TABLE reserved_seat_tb
(
   PRIMARY KEY
   (
      schedule_id,
      seat_name
   ),
   schedule_id INT NOT NULL,
   FOREIGN KEY (schedule_id) REFERENCES schedule_tb (id),
   seat_name VARCHAR (10) NOT NULL,
   FOREIGN KEY (seat_name) REFERENCES seat_tb (name),
   ticket_id INT NOT NULL,
   FOREIGN KEY (ticket_id) REFERENCES ticket_tb (id)
>>>>>>> feature/board
);
-- 티켓 결제 내역
<<<<<<< HEAD
CREATE TABLE ticket_payment_tb(
	tid VARCHAR(40) PRIMARY KEY, -- 결제고유번호
    ticket_id1 VARCHAR(15) NOT NULL,
    FOREIGN KEY (ticket_id1) REFERENCES ticket_tb(id) ON DELETE CASCADE,
    ticket_id2 VARCHAR(15),
    FOREIGN KEY (ticket_id2) REFERENCES ticket_tb(id) ON DELETE CASCADE,
    amount1 BIGINT NOT NULL,
    amount2 BIGINT,
   	status1 TINYINT DEFAULT 0 NOT NULL,
   	status2 TINYINT
=======
CREATE TABLE ticket_payment_tb
(
   ticket_id INT PRIMARY KEY,
   FOREIGN KEY (ticket_id) REFERENCES ticket_tb (id),
   amount INT NOT NULL,
   use_miles INT NOT NULL DEFAULT 0
>>>>>>> feature/board
);
-- 기내 서비스 종류
CREATE TABLE in_flight_service_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
<<<<<<< HEAD
    name VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    icon_image VARCHAR(50) NOT NULL,
    detail_image VARCHAR(50) NOT NULL
=======
   name VARCHAR (50) NOT NULL,
   description TEXT NOT NULL
>>>>>>> feature/board
);
-- 운항시간별 가용 서비스
CREATE TABLE available_service_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
<<<<<<< HEAD
    flight_hours INT NOT NULL, -- 단위 0, 1, 2, 3, 4 ...
    service_id INT NOT NULL, 
    FOREIGN KEY(service_id) REFERENCES in_flight_service_tb(id)
=======
   flight_hours INT NOT NULL,
   -- 단위 0, 1, 2, 3, 4 ...
   service_id INT NOT NULL,
   FOREIGN KEY (service_id) REFERENCES in_flight_service_tb (id)
>>>>>>> feature/board
);
-- 기내식 종류
CREATE TABLE in_flight_meal_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
<<<<<<< HEAD
    name VARCHAR(50) NOT NULL,
    description TEXT NOT NULL
=======
   name VARCHAR (50) NOT NULL,
   description TEXT NOT NULL
>>>>>>> feature/board
);
-- 기내식 신청
CREATE TABLE request_meal_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
<<<<<<< HEAD
    amount INT NOT NULL,
    meal_id INT NOT NULL DEFAULT 1, 
    ticket_id VARCHAR(15) NOT NULL,
    FOREIGN KEY(ticket_id) REFERENCES ticket_tb(id),
    FOREIGN KEY(meal_id) REFERENCES in_flight_meal_tb(id)
);

-- 기내식 상세 테이블
CREATE TABLE in_flight_meal_detail_tb(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name varchar(100) not null,
	description text not null ,
	image varchar(50) not null,
	meal_id INT NOT NULL, FOREIGN KEY(meal_id) REFERENCES in_flight_meal_tb(id)
);

=======
   amount INT NOT NULL,
   meal_id INT NOT NULL DEFAULT 1,
   ticket_id INT NOT NULL,
   FOREIGN KEY (ticket_id) REFERENCES ticket_tb (id),
   FOREIGN KEY (meal_id) REFERENCES in_flight_meal_tb (id)
);
-- 기내식 상세 테이블
CREATE TABLE in_flight_meal_detail_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
   name varchar (100) not null,
   description text not null,
   meal_id INT NOT NULL,
   FOREIGN KEY (meal_id) REFERENCES in_flight_meal_tb (id)
);
>>>>>>> feature/board
-- 공지사항 카테고리
CREATE TABLE notice_category_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR (50) NOT NULL
);
-- 공지사항
CREATE TABLE notice_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
<<<<<<< HEAD
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    category_id INT NOT NULL, 
    FOREIGN KEY(category_id) REFERENCES notice_category_tb(id)
);

-- 휴대 반입 액체류 
CREATE TABLE carry_on_liquids_tb(
	name VARCHAR(50) PRIMARY KEY,
	target VARCHAR(100) NOT NULL,
	limit_guide TEXT NOT NULL,
	tax_free_guide TEXT NOT NULL
);

-- 위탁 수하물
CREATE TABLE checked_baggage_tb(
	id INT PRIMARY KEY AUTO_INCREMENT,
	section VARCHAR(50) NOT NULL,
	grade_id VARCHAR(10), FOREIGN KEY(grade_id) REFERENCES seat_grade_tb(name),
	free_allowance VARCHAR(100) NOT NULL
);

-- 수하물 유실
CREATE TABLE baggage_miss_tb(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(10) NOT NULL,
	guide VARCHAR(255),
	note VARCHAR(255)
);

-- 수하물, 노선 중간 테이블
CREATE TABLE baggage_route_tb(
	id INT PRIMARY KEY AUTO_INCREMENT,
	route_id INT NOT NULL, FOREIGN KEY(route_id) REFERENCES route_tb(id),
	baggage_id INT NOT NULL, FOREIGN KEY(baggage_id) REFERENCES checked_baggage_tb(id)
);

-- 수하물 신청
CREATE TABLE baggage_request_tb(
	id INT PRIMARY KEY AUTO_INCREMENT,
	amount INT NOT NULL,
	br_id INT, FOREIGN KEY(br_id) REFERENCES baggage_route_tb(id),
	member_id VARCHAR(50), FOREIGN KEY(member_id) REFERENCES member_tb(id)
);

=======
   title VARCHAR (100) NOT NULL,
   content TEXT NOT NULL,
   created_at TIMESTAMP NOT NULL DEFAULT now (),
   category_id INT NOT NULL,
   FOREIGN KEY (category_id) REFERENCES notice_category_tb (id)
);
>>>>>>> feature/board
-- 추천여행지 게시글
create table recommend_board_tb
(
   id int PRIMARY KEY AUTO_INCREMENT,
   title varchar (50) not null,
   content blob not null,
   user_id varchar (50) not null,
   view_count INT not null,
<<<<<<< HEAD
   created_at TIMESTAMP default now() NOT NULL,
   FOREIGN KEY (user_id) REFERENCES user_tb (id)  
=======
   origin_name VARCHAR (100) not null,
   file_name VARCHAR (200) not null,
   created_at TIMESTAMP default now() NOT NULL,
   FOREIGN KEY (user_id) REFERENCES user_tb (id)
>>>>>>> feature/board
);

-- 게시글 좋아요 내역
create table like_heart_tb
(
   id int PRIMARY KEY AUTO_INCREMENT,
   board_id int NOT NULL,
<<<<<<< HEAD
   user_id varchar(50) NOT NULL,
=======
   user_id varchar (50) NOT NULL,
>>>>>>> feature/board
   FOREIGN KEY (board_id) REFERENCES recommend_board_tb (id),
   FOREIGN KEY (user_id) REFERENCES user_tb (id)
);
-- 마일리지 샵 상품
CREATE TABLE shop_product_tb
(
   id INT PRIMARY KEY auto_increment,
<<<<<<< HEAD
   brand varchar(20) not null,
   name varchar(50) not null,
   price bigint not null,
=======
   brand varchar (20) not null,
   name varchar (50) not null,
   miles_price int not null,
>>>>>>> feature/board
   count int not null,
   product_image varchar (200) not null,
   gifticon_image varchar (200) not null
);
-- 마일리지 샵 주문 내역
create table shop_order_tb
(
   id int primary key auto_increment,
   amount int not null,
   product_id int not null,
   member_id varchar (50) not null,
   foreign key (product_id) references shop_product_tb (id),
   foreign key (member_id) references member_tb (id)
);
-- 기프티콘
<<<<<<< HEAD
create table gifticon_tb(
   id int primary key auto_increment,
    start_date date not null default (CURRENT_DATE),
    end_date date not null,
    order_id int not null,
    foreign key (order_id) references shop_order_tb (id)
);

-- 마일리지 todo inserttime 중간에 _ 넣기
create table mileage_tb(
id int primary key auto_increment,
use_date DATE,
use_mileage BIGINT,
description TEXT,
save_date DATE,
expiration_date DATE,
save_mileage BIGINT,
balance BIGINT,
inserttime DATE default (CURRENT_DATE),
member_id varchar(50),
foreign key (member_id) references member_tb (id)
);

-- 마일리지 신청 내역
create table mileage_request_tb(
id int primary key auto_increment,
request_date DATE default (CURRENT_DATE),
status int default 0,
ticket_id VARCHAR(15),
foreign key (ticket_id) references ticket_tb (id)

=======
create table giffticon_tb
(
   id int primary key auto_increment,
   start_date date not null default (CURRENT_DATE),
   end_date date not null,
   order_id int not null,
   foreign key (order_id) references shop_order_tb (id)
>>>>>>> feature/board
);