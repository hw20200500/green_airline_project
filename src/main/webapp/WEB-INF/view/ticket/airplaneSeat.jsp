<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<link rel="stylesheet" href="/css/ticket.css">

<!-- 항공기 좌석 배치도 -->

<main>

	<h2>좌석 배치도</h2>
	<hr>
	<br>
	<img alt="" src="/images/ticket/airplane_seat${id}.png">

</main>



<script src="/js/ticket.js"></script>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
