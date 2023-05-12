INSERT INTO user_tb 
VALUES ('abc', '1234', '회원');

INSERT INTO notice_category_tb(id, name)
VALUES(1, '전체'),
	(2, '유류할증료'),
	(3, '여행정보'),
	(4, '제휴사 소식'),
	(5, '기타안내');
	
INSERT INTO notice_tb(title, content, category_id)
VALUES('asfd', 'asfd', 1);