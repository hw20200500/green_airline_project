<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린항공ㅣGREEN AIRLINES</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/layout.css">
<link rel="stylesheet" href="/css/chatbot.css">

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"
	integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500;700;900&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
</head>

<body>
    <!-- 챗봇 버튼 -->
    <button class="chatbot-button" onclick="toggleChat()">💬</button>

    <!-- 챗봇 팝업 -->
    <div class="chatbot-container" id="chatbot-container">
      <div class="chatbot-header" onclick="toggleChat()">그린이</div>
      <div class="chat-container">
        <div class="chat-box" id="chat-box"></div>
        <div class="input-group">
          <input type="text" id="user-input" placeholder="메시지를 입력해주세요." onkeypress="checkEnter(event)" />
          <button onclick="sendMessage()">Send</button>
        </div>
      </div>
    </div>
	<div class="page--container">
		<header>
			<div class="header--top">
				<ul>
					<c:choose>
						<c:when test="${principal == null}">
							<li class="material--li"><span class="material-symbols-outlined" style="font-size: 23px;">help</span></li>
							<li class="top--text--li">비회원</li>
						</c:when>
						<c:when test="${principal.userRole.equals(\"관리자\")}">
							<li class="material--li"><span class="material-symbols-outlined" style="font-size: 23px;">stars</span></li>
							<li class="top--text--li">관리자</li>
						</c:when>
						<c:otherwise>
							<li class="material--li"><span class="material-symbols-outlined" style="font-size: 23px;">account_circle</span></li>
							<li class="top--text--li">회원</li>
						</c:otherwise>
					</c:choose>
				</ul>
				<ul>
					<c:choose>
						<%-- 로그인되지 않은 경우 --%>
						<c:when test="${principal == null}">
							<li class="material--li"><a href="/login"><span class="material-symbols-outlined" style="font-size: 22px;">login</span></a></li>
							<li class="top--text--li"><a href="/login">로그인</a></li>
							<li class="li--split">ㅣ</li>
							<li class="material--li"><a href="/join"><span class="material-symbols-outlined" style="font-size: 22px;">person_add</span></a></li>
							<li class="top--text--li"><a href="/join">회원가입</a></li>
							<li class="li--split">ㅣ</li>
							<li class="material--li"><a href="/notice/noticeList"><span class="material-symbols-outlined" style="font-size: 22px;">support_agent</span></a></li>
							<li class="customer--service--li top--text--li"><a href="/customerCenter">고객센터</a>
								<ul class="ul--dropdown--menu">
									<li class="li--dropdown--menu"><a href="/notice/noticeList">·&nbsp;&nbsp;공지사항</a></li>
									<li class="li--dropdown--menu"><a href="/faq/faqList">·&nbsp;&nbsp;자주 묻는 질문</a></li>
									<li class="li--dropdown--menu"><a href="/voc/list/1">·&nbsp;&nbsp;고객의 말씀</a></li>
								</ul></li>
						</c:when>
						<c:otherwise>
							<li class="material--li"><a href="/logout"><span class="material-symbols-outlined" style="font-size: 22px;">logout</span></a></li>
							<li class="top--text--li"><a href="/logout">로그아웃</a></li>
							<li class="li--split">ㅣ</li>
							<li class="material--li"><a href="/userMain"><span class="material-symbols-outlined" style="font-size: 22px;">badge</span></a></li>
							<li class="top--text--li"><a href="/userMain">마이페이지</a></li>
							<li class="li--split">ㅣ</li>
							<li class="material--li"><a href="/customerCenter"><span class="material-symbols-outlined" style="font-size: 22px;">support_agent</span></a></li>
							<li class="customer--service--li top--text--li"><a href="/customerCenter">고객센터</a>
								<ul class="ul--dropdown--menu">
									<li class="li--dropdown--menu"><a href="/notice/noticeList">·&nbsp;&nbsp;공지사항</a></li>
									<li class="li--dropdown--menu"><a href="/faq/faqList">·&nbsp;&nbsp;자주 묻는 질문</a></li>
									<li class="li--dropdown--menu"><a href="/voc/list/1">·&nbsp;&nbsp;고객의 말씀</a></li>
								</ul>
							</li>
						</c:otherwise>
					</c:choose>
				</ul>

			</div>
			<nav>
				<img alt="" src="/images/logo.jpg" class="logo" onclick="location.href='/';">
				<div class="main--menu" style="width: 100%;">
					<!-- todo : userRole에 따라 다르게 보이게 하기 -->
					<ul class="nav--depth1">
						<li><a href="/ticket/selectSchedule">예약</a></li>
						<li><a href="/inFlightService/inFlightServiceSearch">여행준비</a></li>
						<li><a href="/board/list/1">여행</a></li>
						<li><a href="/product/productMain/clasic">마일리지</a></li>
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
								<li><a href="/ticket/selectSchedule">항공권 예약</a>
								<li><a href="/ticket/list/1">항공권 구매 내역</a>
								<li><a href="/ticket/refundInfo">항공권 환불 안내</a>
							</ul>
							<div class="nav--split"></div>
							<ul>
								<li><a href="/inFlightService/inFlightServiceSearch">기내 서비스 조회</a>
								<li><a href="/inFlightService/inFlightServiceSpecial">특별 기내식</a>
								<li><a href="/inFlightService/inFlightSpecialReq">특별 기내식 신청</a>
								<li><a href="/baggage/checkedBaggage">위탁 수하물 신청</a>
							</ul>
							<div class="nav--split"></div>
							<ul>
								<li><a href="/board/list/1">여행일지</a>
								<li><a href="/map">공항 위치 정보</a>
								<li><a href="/airplane/info/1">항공기 정보</a>
							</ul>
							<div class="nav--split"></div>
							<ul>
								<li><a href="/product/productMain/clasic">마일리지샵</a>
								<li><a href="/gifticon/list">마일리지샵 이용 내역</a>
								<li><a href="/memberGrade">회원 안내</a>
							</ul>
							<div class="nav--split"></div>
						</div>
						<div class="nav--depth2--background"></div>
					</div>
				</div>
			</nav>
		</header>

		<!-- 메인페이지가 아닐 때만 세부 메뉴 표시 -->
		<c:if test="${isMain == null}">
			<div class="header--menu--split">
				<div class="sub--menu">
					<div></div>
					<div>
						<button class="sub--menu--button home--button" onclick="location.href='/';">
							<ul class="d-flex">
								<li class="material--li"><span class="material-symbols-outlined material-symbols-outlined-white">house</span></li>
								<li>HOME</li>
							</ul>
						</button>
					</div>
					<c:if test="${notCategory == null}">
						<div>
							<button id="subMenu1" class="sub--menu--button" style="border-left: hidden;">
								<ul class="d-flex justify-content-between" style="width: 100%">
									<li id="currentMainMenu"></li>
									<li class="material--li"><span class="material-symbols-outlined material-symbols-outlined-white">expand_more</span></li>
								</ul>
							</button>
							<ul id="dropMenu1" class="drop--menu">
								<li><button class="menu--button" onclick="location.href='/ticket/selectSchedule'">예약</button></li>
								<li><button class="menu--button" onclick="location.href='/inFlightService/inFlightServiceSearch'">여행 준비</button></li>
								<li><button class="menu--button" onclick="location.href='/board/list/1'">여행</button></li>
								<li><button class="menu--button" onclick="location.href='/product/productMain/clasic'">마일리지</button></li>
							</ul>
						</div>
						<div>
							<button id="subMenu2" class="sub--menu--button" style="border-left: hidden;">
								<ul class="d-flex justify-content-between" style="width: 100%">
									<li id="currentSubMenu"></li>
									<li class="material--li"><span class="material-symbols-outlined material-symbols-outlined-white">expand_more</span></li>
								</ul>
							</button>
							<ul id="dropMenu2" class="drop--menu">
								<!-- AJAX로 추가 -->
							</ul>
						</div>
					</c:if>
				</div>
			</div>
		</c:if>

<script>
	let userRole = `${principal.userRole}`;
</script>
<script src="/js/chatbot.js"></script>
		<script src="/js/layout.js"></script>
