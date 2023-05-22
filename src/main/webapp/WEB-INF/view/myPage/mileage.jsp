<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>

	
	<!-- 마일리지 조회 페이지 -->
	<main>
	
		<h1>마일리지 조회</h1>
		<div class="container">
  <h3>회원이름 회원님의 사용가능 마일리지</h3>
  <h3>숫자나오게 마일(글자 중앙 이동 해야함)</h3>
  <table class="table table-bordered">
    <thead>
      <tr>
        <th>구분</th>
        <th>적립 마일리지</th>
        <th>사용 마일리지</th>
        <th>잔여 마일리지</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>뭐라적을지 고민</td>
        <td>${saveMileage.saveMileage}</td>
        <td>${useMileage.useMileage}</td>
        <td>${saveMileage.saveMileage-useMileage.useMileage}</td>
      </tr>
      <tr>
        <td>뭐라적을지 고민2</td>
        <td>Moe</td>
        <td>mary@example.com</td>
        <td>mary@example.com</td>
      </tr>
      <tr>
        <td>합계</td>
        <td>Dooley</td>
        <td>july@example.com</td>
        <td>july@example.com</td>
      </tr>
    </tbody>
  </table>
</div>
	</main>




<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
