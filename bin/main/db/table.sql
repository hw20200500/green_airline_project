-- 회원 등급
CREATE TABLE member_grade_tb(
   name VARCHAR(10) PRIMARY KEY
);


-- 사용자
CREATE TABLE user_tb(
   id VARCHAR(50) PRIMARY KEY,
   password VARCHAR(255) NOT NULL,
   user_role VARCHAR(5) NOT NULL DEFAULT '회원'
);


-- 회원
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
   grade VARCHAR(10), FOREIGN KEY (grade) REFERENCES member_grade_tb(name)
);


-- 관리자
CREATE TABLE manager_tb(
   id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    gender VARCHAR(1) NOT NULL,
    phone_number VARCHAR(13) NOT NULL,
    email VARCHAR(40) NOT NULL,
    address VARCHAR(200) NOT NULL
);


-- 공항
CREATE TABLE airport_tb(
   id INT PRIMARY KEY AUTO_INCREMENT,
    region VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL UNIQUE
);


-- 좌석 등급
create table seat_grade_tb(
   name varchar(10) primary key not null,
    price_multiple int not null
);


-- 비행기
create table airplane_tb(
   id int primary key AUTO_INCREMENT not null,
    name varchar(20) not null
);


-- 좌석
create table seat_tb(
    airplane_id int not null,
    name varchar(10) not null,
    grade varchar(10) not null,
    PRIMARY KEY (airplane_id, name),
    foreign key (grade) references seat_grade_tb(name),
    foreign key (airplane_id) references airplane_tb(id)
);


-- 노선
create table route_tb(
   id int primary key auto_increment not null,
   departure varchar(50) not null,
   destination varchar(50) not null,
   flight_time varchar(50) not null,
   foreign key (departure) references airport_tb (name),
   foreign key (destination) references airport_tb (name)
);


-- 운항시간별 티켓 가격
create table ticket_price_tb(
   flight_hours int primary key not null,
   price bigint not null
);


-- 운항 일정
CREATE TABLE schedule_tb(
   id INT PRIMARY KEY AUTO_INCREMENT,
    departure_date TIMESTAMP NOT NULL,
    arrival_date TIMESTAMP NOT NULL,
    airplane_id INT NOT NULL,
    FOREIGN KEY (airplane_id) REFERENCES airplane_tb (id),
    route_id INT NOT NULL, 
    FOREIGN KEY (route_id) REFERENCES route_tb (id)
);


-- 예약 티켓
CREATE TABLE ticket_tb(
   id INT PRIMARY KEY,
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
);


-- 예약 좌석
CREATE TABLE reserved_seat_tb(
   PRIMARY KEY (schedule_id, seat_name),
   schedule_id INT NOT NULL, 
   FOREIGN KEY(schedule_id) REFERENCES schedule_tb(id),
   seat_name VARCHAR(10) NOT NULL, 
   ticket_id INT NOT NULL, 
   FOREIGN KEY(ticket_id) REFERENCES ticket_tb(id)
);


-- 탑승객
CREATE TABLE passenger_tb (
	name VARCHAR(50) NOT NULL,
	gender VARCHAR(1) NOT NULL, 
	birth_date DATE NOT NULL,
	ticket_id INT NOT NULL,
	FOREIGN KEY (ticket_id) REFERENCES ticket_tb(id)
);


-- 티켓 결제 내역
CREATE TABLE ticket_payment_tb(
   ticket_id INT PRIMARY KEY,
    FOREIGN KEY (ticket_id) REFERENCES ticket_tb(id),
    amount INT NOT NULL,
    use_miles INT NOT NULL DEFAULT 0
);


-- 기내 서비스 종류
CREATE TABLE in_flight_service_tb(
   id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    icon_image VARCHAR(50) NOT NULL,
    detail_image VARCHAR(50) NOT NULL
);


-- 운항시간별 가용 서비스
CREATE TABLE available_service_tb(
   id INT PRIMARY KEY AUTO_INCREMENT,
    flight_hours INT NOT NULL, -- 단위 0, 1, 2, 3, 4 ...
    service_id INT NOT NULL, 
    FOREIGN KEY(service_id) REFERENCES in_flight_service_tb(id)
);


-- 기내식 종류
CREATE TABLE in_flight_meal_tb(
   id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description TEXT NOT NULL
);


-- 기내식 신청
CREATE TABLE request_meal_tb(
   id INT PRIMARY KEY AUTO_INCREMENT,
    amount INT NOT NULL,
    meal_id INT NOT NULL DEFAULT 1, 
    ticket_id INT NOT NULL,
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

-- 공지사항 카테고리
CREATE TABLE notice_category_tb(
   id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);


-- 공지사항
CREATE TABLE notice_tb(
   id INT PRIMARY KEY AUTO_INCREMENT,
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

-- 추천여행지 게시글
create table recommend_board_tb(
   id int PRIMARY KEY AUTO_INCREMENT,
   title varchar(50) not null,
   content text not null,
   user_id varchar(50) not null,
   view_count INT not null,
   created_at TIMESTAMP default now() NOT NULL,
   FOREIGN KEY (user_id) REFERENCES user_tb (id)  
);


-- 게시글 이미지 (공지사항, 추천 여행지)
create table board_image_tb (
   id int PRIMARY KEY AUTO_INCREMENT,
   origin_name VARCHAR(100) not null,
   file_name VARCHAR(200) not null,
   board_id INT NOT NULL,
   FOREIGN KEY (board_id) REFERENCES recommend_board_tb (id)
);


-- 게시글 좋아요 내역
create table like_heart_tb(
   id int PRIMARY KEY AUTO_INCREMENT,
   board_id int NOT NULL,
   user_id varchar(50) NOT NULL,
   FOREIGN KEY (board_id) REFERENCES recommend_board_tb (id),
   FOREIGN KEY (user_id) REFERENCES user_tb (id)  
);


-- 마일리지 샵 상품
CREATE TABLE shop_product_tb(
   id INT PRIMARY KEY auto_increment,
   brand varchar(20) not null,
   name varchar(50) not null,
   price bigint not null,
   count int not null,
   product_image varchar(200) not null,
   gifticon_image varchar(200) not null
);

-- 마일리지 샵 주문 내역
create table shop_order_tb(
   id int primary key auto_increment,
   amount int not null,
   product_id int not null,
   member_id varchar(50) not null,
   foreign key (product_id) references shop_product_tb (id),
   foreign key (member_id) references member_tb (id)
);

-- 기프티콘
create table gifticon_tb(
   id int primary key auto_increment,
    start_date date not null default (CURRENT_DATE),
    end_date date not null,
    order_id int not null,
    foreign key (order_id) references shop_order_tb (id)
);

-- 마일리지

CREATE TABLE mileage_tb(
	id INT PRIMARY KEY AUTO_INCREMENT,
    balance INT NOT NULL,
	use_mileage INT,
	save_mileage INT,
	mileage_date DATE DEFAULT (CURRENT_DATE),
	description INT,
	member_id VARCHAR(50),
    FOREIGN KEY (member_id) REFERENCES member_tb(id)
);

