<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린항공ㅣGREEN AIRLINES</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/layout.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500;700;900&display=swap" rel="stylesheet">
</head>

<style>
.sub--menu {
	height: 60px;
	background-color: #9b9b9e;
	display: flex;
	justify-content: flex-start;
	width: 1500px;
	z-index: 1;
}

.material-symbols-outlined-fill {
  font-variation-settings:
  'FILL' 1,
  'wght' 400,
  'GRAD' 0,
  'opsz' 48 !important;
}

.sub--menu--button.home--button {
	width: 200px;
	
}

.sub--menu--button {
	background: none;
	width: 300px;
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100%;
	font-size: 18px;
	color: white;
	font-weight: 600;
}

.sub--menu--button > ul {
	margin: 0;
}

.header--menu--split {
	min-width: 100%;
	height: 60px;
	background-color: #ccc;
	display: flex;
	justify-content: center;	
}

</style>

<body>

	<div class="page--container">
	<header>
		<div class="header--top">
			<ul>
				<!-- 로그인되지 않은 경우 -->
				<li class="material--li"><a href="#"><span class="material-symbols-outlined">login</span></a></li>
				<li><a href="#">로그인</a></li>
				<li class="li--split">ㅣ</li>
				<li class="material--li"><a href="#"><span class="material-symbols-outlined">person_add</span></a></li>
				<li><a href="#">회원가입</a></li>
				<li class="li--split">ㅣ</li>
				<li class="material--li"><a href="#"><span class="material-symbols-outlined">support_agent</span></a></li>
				<li><a href="#">고객센터</a></li>
			</ul>
		</div>
		<nav>
			<img alt="" src="/images/logo.jpg" class="logo" onclick="location.href='/';">
			<div class="main--menu" style="width: 100%;">
				<ul class="nav--depth1">
					<li>
						<a href="#">메뉴 1</a>
					</li>
					<li>
						<a href="#">메뉴 2</a>
					</li>
					<li>
						<a href="#">메뉴 3</a>
					</li>
					<li>
						<a href="#">메뉴 4</a>
					</li>
				</ul>
				<div class="nav--bar"></div>
				<!-- 내려오는 메뉴 -->
				<div class="nav--depth2">
					<div class="nav--depth2--div">
						<div class="nav--div1"></div>
						<div class="nav--split"></div>
						<div class="nav--div2"></div>
						<div class="nav--split"></div>
						<ul>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
						</ul>
						<div class="nav--split"></div>
						<ul>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
						</ul>
						<div class="nav--split"></div>
						<ul>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
						</ul>
						<div class="nav--split"></div>
						<ul>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
							<li><a href="#">세부메뉴</a>
						</ul>	
						<div class="nav--split"></div>
					</div>
					<div class="nav--depth2--background"></div>
				</div>
			</div>
		</nav>
	
	</header>
		<div class="header--menu--split">
			<div class="sub--menu">
				<div></div>
				<div>
					<button class="sub--menu--button home--button">
						<ul class="d-flex">
							<li class="material--li"><span class="material-symbols-outlined material-symbols-outlined-fill">house</span></li>
							<li>HOME</li>
						</ul>
					</button>
				</div>
				<div>
					<button class="sub--menu--button">
						
					</button>
				</div>
				<div>
					<button class="sub--menu--button">
						
					</button>
				</div>
			</div>
		</div>
	
	
	<script src="/js/layout.js"></script>