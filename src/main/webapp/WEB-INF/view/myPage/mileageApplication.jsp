<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

	<!-- todo 삭제 -->
	
	<main>
		<h1>구매한 기프티콘/환불 리스트</h1>
		<div class="container">
  <h2><a href="/mileage/application?type=0">구매 리스트</a></h2>
  <h2><a href="/mileage/application?type=1">환불 리스트</a></h2>
  <table class="table">
    <thead>
      <tr>
        <th>편명</th>
        <th>탑승일</th>
        <th>탑승구간</th>
        <th>티켓번호</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${ticketList}" var="ticketList">
      <tr>
        <td><a href="/mileage/request/${ticketList.id}">${ticketList.airplaneName}</a></td>
        <td>${ticketList.formatDepartureDate()}</td>
        <td>${ticketList.departure}</td>
        <td>${ticketList.id}</td> 
      </tr>
      </c:forEach>
    </tbody>
  </table>
</div>
	</main>




<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
