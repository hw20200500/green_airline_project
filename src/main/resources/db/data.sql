INSERT INTO member_grade_tb
VALUES ('골드');

INSERT INTO user_tb 
VALUES ('abc', '1234', '회원');



INSERT INTO shop_product_tb(brand,name,price,count,product_image,gifticon_image)
		VALUES('컴포즈','바닐라 라떼',1234,3,'image.png','image2.png'),
				('스타벅스','아이스 아메리카노',10000,4,'image2.png','image.png'),
				('2번','바닐라 라떼',100,3,'image.png','image2.png'),
				('3번','바닐라 라떼',200,3,'image.png','image2.png'),
				('4번','바닐라 라떼',300,3,'image.png','image2.png'),
				('5번','바닐라 라떼',400,3,'image.png','image2.png'),
				('6번','바닐라 라떼',500,3,'image.png','image2.png'),
				('7번','바닐라 라떼',600,3,'image.png','image2.png'),
				('8번','바닐라 라떼',700,3,'image.png','image2.png'),
				('9번','바닐라 라떼',800,3,'image.png','image2.png'),
				('10번','바닐라 라떼',900,3,'image.png','image2.png'),
				('11번','바닐라 라떼',1000,3,'image.png','image2.png'),
				('12번','바닐라 라떼',1100,3,'image.png','image2.png'),
				('13번','바닐라 라떼',1200,3,'image.png','image2.png'),
				('14번','바닐라 라떼',1300,3,'image.png','image2.png'),
				('15번','바닐라 라떼',1400,3,'image.png','image2.png'),
				('16번','바닐라 라떼',1500,3,'image.png','image2.png'),
				('17번','바닐라 라떼',1600,3,'image.png','image2.png'),
				('18번','바닐라 라떼',1700,3,'image.png','image2.png'),
				('19번','바닐라 라떼',1800,3,'image.png','image2.png'),
				('20번','바닐라 라떼',1900,3,'image.png','image2.png'),
				('21번','바닐라 라떼',2000,3,'image.png','image2.png'),
				('22번','바닐라 라떼',2100,3,'image.png','image2.png'),
				('23번','바닐라 라떼',2200,3,'image.png','image2.png'),
				('24번','바닐라 라떼',2300,3,'image.png','image2.png'),
				('25번','바닐라 라떼',2400,3,'image.png','image2.png'),
				('26번','바닐라 라떼',2500,3,'image.png','image2.png')
				;

INSERT INTO member_tb
VALUES 
	('abc', '김홍아', 'LEE SEOYOUNG', '2000-01-05', 'F', '010-1111-2222', 'os010312@naver.com', '부산광역시 수영구', '대한민국', '골드'),
	('a123', '홍길이', 'LEE SEOYOUNG', '2000-01-05', 'F', '010-1111-2222', 'os010312@naver.com', '부산광역시 수영구', '대한민국', '골드');

INSERT INTO mileage_tb(balance,member_id)
VALUES(10000,'abc');

INSERT INTO airport_tb (nation, name)
VALUES 
	('대한민국', '서울'),
	('대한민국', '부산');
	
INSERT INTO seat_grade_tb
VALUES
	('이코노미', 1),
	('비즈니스', 4);
	
INSERT INTO airplane_tb (name)
VALUES ('그린 403');

INSERT INTO seat_tb
VALUES 
	(1, 'E001', '이코노미'),
	(1, 'E002', '이코노미'),
	(1, 'E003', '이코노미'),
	(1, 'E004', '이코노미'),
	(1, 'E005', '이코노미'),
	(1, 'E006', '이코노미'),
	(1, 'E007', '이코노미'),
	(1, 'E008', '이코노미'),
	(1, 'E009', '이코노미'),
	(1, 'E010', '이코노미'),
	(1, 'E011', '이코노미'),
	(1, 'E012', '이코노미'),
	(1, 'E013', '이코노미'),
	(1, 'E014', '이코노미'),
	(1, 'E015', '이코노미'),
	(1, 'E016', '이코노미'),
	(1, 'E017', '이코노미'),
	(1, 'E018', '이코노미'),
	(1, 'E019', '이코노미'),
	(1, 'E020', '이코노미'),
	(1, 'E021', '이코노미'),
	(1, 'E022', '이코노미'),
	(1, 'E023', '이코노미'),
	(1, 'E024', '이코노미'),
	(1, 'E025', '이코노미'),
	(1, 'E026', '이코노미'),
	(1, 'E027', '이코노미'),
	(1, 'E028', '이코노미'),
	(1, 'E029', '이코노미'),
	(1, 'E030', '이코노미');

INSERT INTO seat_tb
VALUES 
	(1, 'B001', '비즈니스'),
	(1, 'B002', '비즈니스'),
	(1, 'B003', '비즈니스'),
	(1, 'B004', '비즈니스');

INSERT INTO route_tb
VALUES (1, '부산', '서울', '1시간 05분');

INSERT INTO ticket_price_tb
VALUES (1, 86000);

INSERT INTO schedule_tb
VALUES (1, '2023-05-13 13:00', '2023-05-13 14:05', 1, 1);

INSERT INTO ticket_tb
VALUES (1, 4, 'a123', 1, '2023-05-13 12:00');

INSERT INTO reserved_seat_tb
VALUES 
	(1, 'B001', 1),
	(1, 'E011', 1),
	(1, 'E012', 1),
	(1, 'E013', 1);





