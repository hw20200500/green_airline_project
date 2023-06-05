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
<style>
.btn--primary {
	color: white;
	border: none;
	background-color: #8ABBE2;
}
.btn--primary:hover {
	color: white;
	border: none;
	background-color: #8ABBE2;
}
</style>
<main>
	
</main>


<input type="hidden" name="menuName" id="menuName" value="수하물 안내">

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
