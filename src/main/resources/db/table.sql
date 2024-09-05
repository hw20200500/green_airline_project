DROP DATABASE if exists airline_db;

CREATE DATABASE airline_db;
USE airline_db;

-- 회원 등급
CREATE TABLE member_grade_tb (
   name VARCHAR(10) PRIMARY KEY,
   mileage_rate DOUBLE NOT NULL COMMENT '적립비율',
   rank_up_mileage BIGINT COMMENT '승급기준 마일리지' 
);

-- 사용자
CREATE TABLE user_tb (
   id VARCHAR (50) PRIMARY KEY,
   password VARCHAR (255) NOT NULL,
   user_role VARCHAR (5) NOT NULL DEFAULT '회원',
   join_at TIMESTAMP DEFAULT now() NOT NULL COMMENT '가입날짜',
   withdraw_at TIMESTAMP COMMENT '탈퇴날짜',
   status TINYINT DEFAULT 0 NOT NULL COMMENT '0 : 기본, 1 : 탈퇴' 
);

-- 회원
CREATE TABLE member_tb (
   id VARCHAR(50) PRIMARY KEY,
   kor_name VARCHAR(20) NOT NULL,
   eng_name VARCHAR(50) NOT NULL,
   birth_date DATE NOT NULL,
   gender VARCHAR(1) NOT NULL,
   phone_number VARCHAR(13) NOT NULL,
   email VARCHAR(40) NOT NULL,
   address VARCHAR(200) NOT NULL,
   nationality VARCHAR(50) NOT NULL,
   grade VARCHAR(10) DEFAULT 'Silver', 
   FOREIGN KEY (grade) REFERENCES member_grade_tb (name)
);

-- 관리자
CREATE TABLE manager_tb (
	id VARCHAR(50) PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    gender VARCHAR(1) NOT NULL,
    phone_number VARCHAR(13) NOT NULL,
    email VARCHAR(40) NOT NULL,
    address VARCHAR(200) NOT NULL
);

-- 공항
CREATE TABLE airport_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
    region VARCHAR(50) NOT NULL COMMENT '지역',
    name VARCHAR(50) NOT NULL UNIQUE COMMENT '공항',
    latitude DOUBLE NOT NULL COMMENT '위도', 
    longitude DOUBLE NOT NULL COMMENT '경도'
);

-- 좌석 등급
CREATE TABLE seat_grade_tb (
   name VARCHAR(10) PRIMARY KEY,
   price_multiple INT NOT NULL COMMENT '가격 배수 (기준 : 이코노미)'
);

-- 비행기
CREATE TABLE airplane_tb (
   id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(20) NOT NULL COMMENT '모델명'
);

-- 좌석
CREATE TABLE seat_tb (
    airplane_id INT NOT NULL,
    name VARCHAR(10) NOT NULL COMMENT '좌석명',
    grade VARCHAR(10) NOT NULL COMMENT '좌석등급',
    PRIMARY KEY (airplane_id, name),
    FOREIGN KEY (airplane_id) REFERENCES airplane_tb (id),
    FOREIGN KEY (grade) REFERENCES seat_grade_tb(name)
);

-- 노선
CREATE TABLE route_tb (
   id INT PRIMARY KEY AUTO_INCREMENT,
   departure VARCHAR(50) NOT NULL COMMENT '출발공항',
   destination VARCHAR(50) NOT NULL COMMENT '도착공항',
   flight_time VARCHAR(50) NOT NULL COMMENT '운항시간 : h시간 mm분',
   type TINYINT NOT NULL COMMENT '1 : 국내선, 2 : 국제선',
   FOREIGN KEY (departure) REFERENCES airport_tb (name),
   FOREIGN KEY (destination) REFERENCES airport_tb (name)
);

-- 운항시간별 티켓 가격
create table ticket_price_tb (
   flight_hours int primary key COMMENT '운항시간 : h시간',
   price BIGINT not null
);

-- 운항 일정
CREATE TABLE schedule_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
    departure_date TIMESTAMP NOT NULL COMMENT '출발일자',
    arrival_date TIMESTAMP NOT NULL COMMENT '도착일자',
    airplane_id INT NOT NULL COMMENT '비행기 id',
    FOREIGN KEY (airplane_id) REFERENCES airplane_tb (id),
    route_id INT NOT NULL COMMENT '노선 id', 
    FOREIGN KEY (route_id) REFERENCES route_tb (id)
);

-- 예약 티켓
CREATE TABLE ticket_tb (
	id VARCHAR(15) PRIMARY KEY,
    adult_count INT DEFAULT 1 NOT NULL COMMENT '성인 수',
    child_count INT DEFAULT 0 NOT NULL COMMENT '소아 수',
    infant_count INT DEFAULT 0 NOT NULL COMMENT '유아 수',
    seat_grade VARCHAR(10) NOT NULL COMMENT '좌석등급',
    FOREIGN KEY (seat_grade) REFERENCES seat_grade_tb (name),
    member_id VARCHAR(50) NOT NULL COMMENT '예약자 id', 
    FOREIGN KEY (member_id) REFERENCES member_tb (id),
    schedule_id INT NOT NULL COMMENT '스케줄 id', 
    FOREIGN KEY (schedule_id) REFERENCES schedule_tb (id),
    reserved_date TIMESTAMP NOT NULL DEFAULT now(),
    payment_type TINYINT NOT NULL DEFAULT 0
);

-- 예약 좌석
CREATE TABLE reserved_seat_tb (
   PRIMARY KEY (schedule_id, seat_name),
   schedule_id INT NOT NULL, 
   FOREIGN KEY(schedule_id) REFERENCES schedule_tb(id),
   seat_name VARCHAR(10) NOT NULL, 
   ticket_id VARCHAR(15) NOT NULL, 
   FOREIGN KEY(ticket_id) REFERENCES ticket_tb (id) ON DELETE CASCADE
);

-- 탑승객
CREATE TABLE passenger_tb (
	name VARCHAR(50) NOT NULL,
	gender VARCHAR(1) NOT NULL COMMENT 'M, F', 
	birth_date DATE NOT NULL,
	ticket_id VARCHAR(15) NOT NULL,
	FOREIGN KEY (ticket_id) REFERENCES ticket_tb (id) ON DELETE CASCADE
);

-- 티켓 결제 내역
CREATE TABLE ticket_payment_tb (
	tid VARCHAR(40) PRIMARY KEY COMMENT '결제 고유 번호', 
    ticket_id1 VARCHAR(15) NOT NULL,
    FOREIGN KEY (ticket_id1) REFERENCES ticket_tb(id) ON DELETE CASCADE,
    ticket_id2 VARCHAR(15),
    FOREIGN KEY (ticket_id2) REFERENCES ticket_tb(id) ON DELETE CASCADE,
    amount1 BIGINT NOT NULL,
    amount2 BIGINT,
   	status1 TINYINT DEFAULT 0 NOT NULL COMMENT '0 : 결제 진행중, 1 : 결제 완료, 2 : 환불',
   	status2 TINYINT
);

-- 환불 수수료
CREATE TABLE refund_fee_tb (
	criterion INT NOT NULL COMMENT '출발일 n일 이전 : 90, 60, 15, 4, 0',
	type TINYINT NOT NULL COMMENT '1 : 국내선, 2 : 국제선',
	fee BIGINT NOT NULL COMMENT '환불 수수료'
);

-- 기내 서비스 종류
CREATE TABLE in_flight_service_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    icon_image VARCHAR(50) NOT NULL,
    detail_image VARCHAR(50) NOT NULL
);

-- 운항시간별 가용 서비스
CREATE TABLE available_service_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
    flight_hours INT NOT NULL COMMENT '운항 시간 h시간',
    service_id INT NOT NULL, 
    FOREIGN KEY(service_id) REFERENCES in_flight_service_tb(id)
);

-- 기내식 종류
CREATE TABLE in_flight_meal_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description TEXT NOT NULL
);

-- 기내식 상세
CREATE TABLE in_flight_meal_detail_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name varchar(100) not null,
	description text not null ,
	image varchar(50) not null,
	meal_id INT NOT NULL, 
    FOREIGN KEY(meal_id) REFERENCES in_flight_meal_tb (id)
);

-- 기내식 신청
CREATE TABLE request_meal_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
    amount INT NOT NULL,
    meal_id INT NOT NULL DEFAULT 1, 
    ticket_id VARCHAR(15) NOT NULL,
    FOREIGN KEY(ticket_id) REFERENCES ticket_tb (id) ON DELETE CASCADE,
    FOREIGN KEY(meal_id) REFERENCES in_flight_meal_tb (id)
);

-- 공지사항 카테고리
CREATE TABLE notice_category_tb (
   id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR (50) NOT NULL
);

-- 공지사항
CREATE TABLE notice_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    category_id INT NOT NULL, 
    FOREIGN KEY(category_id) REFERENCES notice_category_tb (id)
);

-- 휴대 반입 액체류 
CREATE TABLE carry_on_liquids_tb (
	name VARCHAR(50) PRIMARY KEY COMMENT '국가',
	target VARCHAR(100) NOT NULL COMMENT '대상',
	limit_guide TEXT NOT NULL COMMENT '제한 지침',
	tax_free_guide TEXT NOT NULL COMMENT '면세품 지침'
);

-- 위탁 수하물
CREATE TABLE checked_baggage_tb(
	id INT PRIMARY KEY AUTO_INCREMENT,
	section VARCHAR(50) NOT NULL COMMENT '구간',
	grade_id VARCHAR(10) COMMENT '좌석등급', 
    FOREIGN KEY(grade_id) REFERENCES seat_grade_tb (name),
	free_allowance VARCHAR(100) NOT NULL COMMENT '무료 수하물 허용량'
);

-- 수하물 유실
CREATE TABLE baggage_miss_tb(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(10) NOT NULL,
	guide VARCHAR(255) COMMENT '지침',
	note VARCHAR(255) COMMENT '유의사항'
);

-- 수하물, 노선 중간 테이블
CREATE TABLE baggage_route_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
	route_id INT NOT NULL, 
    FOREIGN KEY(route_id) REFERENCES route_tb (id),
	baggage_id INT NOT NULL, 
    FOREIGN KEY(baggage_id) REFERENCES checked_baggage_tb (id)
);

-- 수하물 신청
CREATE TABLE baggage_request_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
	amount INT DEFAULT 0 NOT NULL COMMENT '수하물 개수',
	br_id INT, 
    FOREIGN KEY(br_id) REFERENCES baggage_route_tb(id),
	member_id VARCHAR(50), FOREIGN KEY(member_id) REFERENCES member_tb(id)
);

-- 자주 묻는 질문 카테고리
CREATE TABLE faq_category_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL
);

-- 자주묻는질문
CREATE TABLE faq_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(100) NOT NULL,
	content TEXT NOT NULL,
	created_at TIMESTAMP default now(),
	category_id INT NOT NULL, 
    FOREIGN KEY (category_id) REFERENCES faq_category_tb(id)
);

-- 추천여행지 게시글
CREATE TABLE recommend_board_tb (
   id INT PRIMARY KEY AUTO_INCREMENT,
   title VARCHAR(50) NOT NULL,
   content TEXT NOT NULL,
   user_id VARCHAR(50) NOT NULL,
   view_count INT NOT NULL DEFAULT 0 COMMENT '조회수',
   origin_name VARCHAR(100) NOT NULL COMMENT '썸네일 원본 이름',
   file_name VARCHAR(200) NOT NULL COMMENT '썸네일 파일 이름',
   created_at TIMESTAMP default now() NOT NULL,
   FOREIGN KEY (user_id) REFERENCES user_tb (id)
);

-- 게시글 좋아요 내역
CREATE TABLE like_heart_tb (
   id INT PRIMARY KEY AUTO_INCREMENT,
   board_id INT NOT NULL,
   user_id VARCHAR(50) NOT NULL,
   FOREIGN KEY (board_id) REFERENCES recommend_board_tb (id),
   FOREIGN KEY (user_id) REFERENCES user_tb (id)
);

-- 마일리지 샵 상품
CREATE TABLE shop_product_tb (
   id INT PRIMARY KEY auto_increment,
   brand varchar(20) not null,
   name varchar(50) not null,
   price bigint not null,
   count int not null COMMENT '재고',
   product_image varchar (200) not null,
   gifticon_image varchar (200) not null
);

-- 마일리지 샵 주문 내역
CREATE TABLE shop_order_tb (
   id int primary key auto_increment,
   amount int not null,
   product_id int not null,
   member_id varchar(50) not null,
   foreign key (product_id) references shop_product_tb (id),
   foreign key (member_id) references member_tb (id)
);

-- 기프티콘
CREATE TABLE gifticon_tb(
	id int primary key auto_increment,
    start_date date not null default (CURRENT_DATE) COMMENT '발급일자',
    end_date date not null COMMENT '만료일자',
    status int DEFAULT 0 COMMENT '0 : 발급완료, 1 : 환불완료',
    order_id int not null,
    foreign key (order_id) references shop_order_tb (id)
);

-- 기프티콘 환불
CREATE TABLE gifticon_revoke_tb(
   id int PRIMARY KEY auto_increment,
   revoke_date DATE DEFAULT (CURRENT_DATE),
   gifticon_id INT NOT NULL,
   FOREIGN KEY (gifticon_id) REFERENCES gifticon_tb (id)
   );

-- 마일리지
create table mileage_tb(
id int primary key auto_increment,
mileage_date DATE NOT NULL,
use_mileage BIGINT,
description TEXT,
expiration_date DATE,
save_mileage BIGINT,
balance BIGINT,
member_id varchar(50),
ticket_id VARCHAR(15),
foreign key (ticket_id) references ticket_tb (id) on delete cascade,
foreign key (member_id) references member_tb (id)
);

-- 마일리지 금액/사용일자
CREATE TABLE use_mileage_list_tb (
mileage_from_balance BIGINT COMMENT '사용 금액',
buy_mileage_id int NOT NULL,
gifticon_id int,
ticket_id VARCHAR(15),
FOREIGN KEY (ticket_id) REFERENCES ticket_tb (id),
FOREIGN KEY (buy_mileage_id) REFERENCES mileage_tb(id),
FOREIGN KEY (gifticon_id) REFERENCES gifticon_tb(id)
);

-- 고객의 말씀 카테고리
CREATE TABLE voc_category_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(20) NOT NULL
);

-- 고객의 말씀 게시글
CREATE TABLE voc_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
	phone_number VARCHAR(13) NOT NULL,
	email VARCHAR(40) NOT NULL,
	type VARCHAR(2) NOT NULL COMMENT '문의, 칭찬, 불만, 건의',
	title VARCHAR(50) NOT NULL,
	content TEXT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT now(),
	category_id INT NOT NULL,
	FOREIGN KEY (category_id) REFERENCES voc_category_tb (id),
	member_id VARCHAR(50) NOT NULL,
	FOREIGN KEY (member_id) REFERENCES member_tb (id),
	ticket_id VARCHAR(15),
	FOREIGN KEY (ticket_id) REFERENCES ticket_tb (id) ON DELETE SET NULL
);

-- 고객의 말씀 답변
CREATE TABLE voc_answer_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
	content TEXT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT now(),
	voc_id INT NOT NULL,
	FOREIGN KEY (voc_id) REFERENCES voc_tb (id) ON DELETE CASCADE 
);

-- 고객의 말씀 답변 양식
CREATE TABLE voc_answer_form_tb (
	type VARCHAR(2) NOT NULL COMMENT '문의, 칭찬, 불만, 건의',
	content TEXT NOT NULL
);

-- 사이트 메인 메뉴
CREATE TABLE main_menu_tb (
	id INT PRIMARY KEY,
	menu VARCHAR(10) NOT NULL,
	type VARCHAR(10) NOT NULL,
    mapping VARCHAR(50) COMMENT '주소 매핑'
);

-- 사이트 서브 메뉴
CREATE TABLE sub_menu_tb (
	id INT PRIMARY KEY AUTO_INCREMENT,
	main_id INT NOT NULL,
	FOREIGN KEY (main_id) REFERENCES main_menu_tb (id),
	menu VARCHAR(20) NOT NULL,
	mapping VARCHAR(50) COMMENT '주소 매핑'
);

-- 관리자 페이지 메모장
CREATE TABLE memo_tb (
	manager_id VARCHAR(50),
	FOREIGN KEY (manager_id) REFERENCES manager_tb (id),
	content TEXT
);
