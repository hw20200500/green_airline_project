<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

	<!-- 여기 안에 쓰기 -->
	<main>
		<h1>마일리지 신청 미신청 리스트 조회</h1>
		<div class="container">
  <h2>미신청 리스트</h2>
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
      <tr>
        <td>John</td>
        <td>Doe</td>
        <td>john@example.com</td>
        <td>john@example.com</td>
      </tr>
    </tbody>
  </table>
</div>
	</main>




<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
