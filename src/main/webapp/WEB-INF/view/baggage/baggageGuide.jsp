<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:choose>
	<c:when test="${\"관리자\".equals(principal.userRole)}">
		<%@ include file="/WEB-INF/view/layout/headerManager.jsp"%>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/view/layout/header.jsp"%>
	</c:otherwise>
</c:choose>

<main>
	<div>
		<h1>수하물 이용 안내</h1>
	</div>
	<div>
		<h3> 수하물이란 ? </h3> <br>
		<p>
			수하물은 고객이 여행 시 휴대 또는 탁송을 의뢰한 소지품 및 물품을 의미하는 단어입니다.<br> 짐을 준비하시는 고객님의 여행이 한결 편할 수 있도록 꼭 알아두셔야 하는 수하물 관련 정보를 안내합니다.
		</p>
	</div>
	<div>
		<h3>수하물 종류</h3>
		<ul>
			<li><a href="/baggage/checkedBaggage">위탁 수하물(Checked Baggage)</a> : 고객이 항공사에 탁송 의뢰하여 수하물표를 발행한 수하물</li>
			<li><a href="/baggage/carryBaggage">휴대 수하물(Carry on Baagage)</a> : 위탁수하물이 아닌, 기내에 휴대하여 운송하는 수하물</li>
		</ul>
	</div>
	
	<div>
		<h3>여행 가방 준비하는 방법</h3>
		<ul>
			<li>영문으로 작성한 이름과 연락처가 기재된 이름표를 가방 외부의 잘 보이는 부분에 부착해주세요.</li>
			<li>항공사에서 지정한 크기와 무게를 지켜서 준비하여 주시고, 내용품이 손상되지 않도록 적절히 포장을 해주세요.</li>
		</ul>
	</div>
	
	<button type="button" class="btn btn-primary" onclick="location.href='/baggage/limit'">운송 제한 물품</button>	
</main>


<input type="hidden" name="menuName" id="menuName" value="수하물 안내">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
