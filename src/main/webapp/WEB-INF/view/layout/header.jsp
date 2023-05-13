<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린 항공 홈페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/layout.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
</head>

<style>
	.page--container {
		display: flex;
		flex-direction: column;
		align-items: center;
		min-width: 100em;
		
	}
	
	header {
		margin-top: 20px;
	}
	
	.header--top {
		margin-bottom: 30px;
	}
	
	.header--top, nav {
		width: 1500px;
		min-width: 1000px;
	}
	
	main {
		/* border: 1px solid #ccc; */
		min-width: 1500px;
	}

	.header--top ul {
		display: flex;
		justify-content: flex-end;
	}
	
	.sub--menu {
		height: 100px;
		/* background-color: #ccc; */
		margin-bottom: 40px;
	}
	
	.li--split {
		margin: 0px 15px;
	}
	
	.material--li {
		display: flex; 
		align-items: center;
		margin-right: 5px;
	}
	
	.material-symbols-outlined {
		padding-top: 1px;
	}
	
	.logo {
		min-width: 400px;
		height: 80px;
		background-color: black;
		margin: 0px 15px;
		color: white;
	}
	
	nav {
		display: flex;
	}
	
	.nav--depth1 {
		display: flex;
		align-items: center;
		justify-content: space-between;
		margin: 0;
		width: 100%;
		margin-bottom: 8px;
	}
	
	.nav--depth1 li {
		width: 267px;
	}
	
	.nav--depth1 li a {
		display: inline-block;
		padding: 19px 0;
		font-size: 30px;
		font-weight: 600;
		min-width: 100%;
		text-align: center;
	}
	
	.nav--depth1 li a:hover {
		cursor: pointer;
	}
	
	.nav--bar {
		background-color: black;
		height: 7px;
		width: 267.5px;
		display: none;
		position: relative;
	}
	
	.nav--depth2 {
		border-top: 1px solid #ccc;
		background-color: white;
		width: 100%;
		height: 420px; 
		position: absolute;
		left:0px;
		display: none;
		text-align: center;
	}
	
	.nav--depth2--div {
		display: flex;
		min-width: 1604px;
		justify-content: center;
		height: 100%;
	
	}
	
	.nav--div {
		display: flex;
		justify-content: center;
		align-items: center;
		min-width: 428px; 
		height: 100%;
		background-color: #F3FCFE;
	}
	
	.nav--depth2 ul {
		text-align: center;
		padding: 10px;
		min-width: 266px;
	}
	
	.nav--split {
		min-width: 1px;
		height: 100%;
		background-color: #ccc;
	}
	
	.nav--depth2--background {
		background: rgba(0, 0, 0, 0.5);
	}
	
	.nav--depth2--div li {
		font-size: 20px;
		margin: 5px 0;
		padding: 10px 0;
	}
	.nav--depth2--div li a {
		display: inline-block;
		width: 100%; 
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
			<div class="logo">
				로고
			</div>
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
						<div class="nav--split"></div>
						<div class="nav--div"></div>
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
					<div class="nav--depth2--background">dd</div>
				</div>
			</div>
		</nav>
		
		<div class="sub--menu">
		</div>
	
	<script>
	
	$(".nav--depth1").contents().on("mouseenter", function() {
		
		// 선택된 요소 인덱스
		let thisIndex = $(this).index();
		let navBarLeft = thisIndex * $(this).width();
		
		$(".nav--bar").stop();
		
		// 세부 메뉴 밑으로는 어둡게 처리
		let headerHeight = $(".nav--depth2").position().top + $(".nav--depth2").height();
		let backgroundHeight = $("html").height() - headerHeight;
		if (backgroundHeight < window.innerHeight) {
			$(".nav--depth2--background").css("height", (window.innerHeight - headerHeight));
		} else {
			$(".nav--depth2--background").css("height", backgroundHeight);
		}
		
		// 이미 메뉴가 내려와있는 상태라면
		if ($(".nav--bar").css("display") == "block") {
			$(".nav--bar").animate({left : navBarLeft}, 700);
		} else {
			
			$(".nav--bar").css("display", "block");
			$(".nav--bar").css("left", navBarLeft);
			$(".nav--depth1").css("margin-bottom", "0px");
			//$(".nav--depth2").css("display", "block");
			$(".nav--depth2").slideDown();
		}
		
		
		
	});

	$(".nav--depth2--div").contents().on("mouseover", function() {
		$(".nav--bar").stop();
		let thisIndex = $(this).index();
		let menuIndex;
		if (thisIndex <= 3) {
			menuIndex = 0;
		} else if (thisIndex == 5) {
			menuIndex = 1;
		} else if (thisIndex == 7) {
			menuIndex = 2;
		} else if (thisIndex == 9) {
			menuIndex = 3;
		}
		let navBarLeft = menuIndex * 267.5;
		$(".nav--bar").animate({left : navBarLeft}, 700);
		
	});
	
	$(".main--menu").on("mouseleave", function() {
		$(".nav--bar").css("display", "none");
		$(".nav--depth1").css("margin-bottom", "7px");
		$(".nav--depth2").css("display", "none");
	});
	
	$(".nav--depth2--background").on("mouseover", function() {
		$(".nav--bar").css("display", "none");
		$(".nav--depth1").css("margin-bottom", "7px");
		$(".nav--depth2").css("display", "none");
	});
	
	</script>
	
	</header>
	
	