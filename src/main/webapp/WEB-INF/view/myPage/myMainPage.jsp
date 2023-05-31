<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<style>
.main--img--div {
	width: 100vw;
	height: 450px;
	background-size: 100%;
	position: relative;
	background: url("../images/321.jpg");
	background-size: cover;
}

.main--img--div::before {
	content: "";
	opacity: 0.45;
	position: absolute;
	top: 0px;
	left: 0px;
	right: 0px;
	bottom: 0px;
	background-color: #000;
	color: initial;
}

.box01 {
	color: #fff;
	position: relative;
	padding-left: 500px;
	padding-top: 125px;
	position: absolute;
	Transform: translateX(-20%);
}

.my--right {
	color: #fff;
	position: relative;
	padding-left: 500px;
	padding-top: 125px;
	position: absolute;
	Transform: translateX(130%);
}

#piechart {
	position: relative;
	position: absolute;
	Transform: translateX(-5%);
	Transform: translateY(-40%);
}

.remark {
	position: absolute;
}
.material-symbols-outlined {
	color: white; 
}
.mileage{
font-size: 1.5em;
}
.my--detail{
padding: 10px 300px;
 
display: block;
display:flex;
flex-wrap: wrap;

} 
.bottom--my--info{
    padding: 20px 0 100px;
    margin: 0 auto;
    background-color:#f0f0f0;
}
.my--detail--top{
    padding: 20px 0 30px;
    margin: 0 auto;
    background-color:#f0f0f0;
    display:flex;
}
.my--detail--top a{
display:flex;
padding: 38px;
	 width: 290px;
	height: 163px;
	 background-color: white; 
	display: block; 
	    font-size: 15px;
	    
}
.my--detail--tit{
	    display: inline-block;
    width: 160px;
    font-size: 15px;
}
.num{
	display: block;
    line-height: 1.1;
    font-size: 40px;
    font-weight: bold;
    color: #d60815;
}
#my--detail--gray{
display: inline-block;
    width: 280px;
    height: 165px;
    padding: 22px 0 0 24px;
    margin-left: 20px;
    color: #fff;
    background-color: #6d6e70;
    background-position: right 30px bottom 30px;
    background-repeat: no-repeat;
    font-size: 23px;
    box-sizing: border-box;
}
.text--top{
	background-color: white;
	padding: 35px 40px 20px 40px;
}
.my--detail--bottom{

}
</style>



<main>
	<div>
		<div class="main--img--div">
			<div class="box01">
				<h2>정다운</h2>
				<p>JUNG DAUN</p>
				<h2>등급 나오게</h2>

			</div>
			<div class="my--right">
				<div class="mileage">
					<p>
						소멸 예정 마일리지  <a href="#"><span class="material-symbols-outlined">add_circle</span></a>
					</p>
					<p>0</p>
				</div>
				<div class="mileage">
					<p>적립 예정 마일리지 <a href="#"><span class="material-symbols-outlined">add_circle</span></a></p> 
					<p>0</p>
				</div>
			</div>
		</div>
		<div class="bottom--my--info">
		<div class="my--detail">
		<div class="my--detail--top">
			<a href="#"><span class="my--detail--tit">기능 1</span><br><span class="num">0</span></a>
			<a href="#"><span>기내 서비스 신청 기록??</span><br><span class="num">0</span></a>
			<a href="#"><span>기능 3</span><br><span class="num">0</span></a>
			<a href="#" class="my--detail--gray" id="my--detail--gray"><span>항공권 예약 현황</span></a>
			</div>
			<div class="my--detail--bottom">
			<div class="my--detail--right">
				<div class="text--top">등급 산정 마일리지를 도움말
<span>20,000</span>마일 추가 적립 또는 아시아나항공 <br>
골드회원으로 승급됩니다.<br>
<button type="button" class="btn_XS white">승급 마일리지 조회</button>
<hr>
</div>
			</div>
			<div class="my--detail--left">
			<div class="progress">
  <div class="progress-bar" style="width:30%"></div>
</div>
			</div>
		</div>
		</div>
		
		</div>
	</div>

</main>




<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
