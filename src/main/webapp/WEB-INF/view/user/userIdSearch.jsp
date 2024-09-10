<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/view/layout/header.jsp"%>

<style>
main{
   border: 1px solid #ccc;
   display: flex;
   justify-content: center;
}
.title{
   text-align: center;
margin: 30px;
}
label{
padding: 10px;
}
.form-control {
   width: 550px;
   background-color: rgb(243, 243, 243);
   border: none;
}
.btn{
   width: 600px;
   margin-left: 10px;
   margin-top: 30px;
   text-align: center;
   background-color: #8ABBE2;
}
.findId{
   margin-top: 50px;
   background-color: rgb(243, 243, 243);
   width: 550px;
   height: 100px;
   padding: 30px;
   
}
input[type=text]{
   border: none;
   border-bottom: 1px solid #ebebeb;
   width: 600px;
   background: #f8f9fc;
   padding: 10px;
   position: relative;
}
input[type=text]:focus, input[type=password]:focus {
   border: none;
   border-bottom: 1px solid #ebebeb;
   width: 600px;
   background: #f8f9fc;
   outline: none;
}
#serchId{
   margin-top: 30px;
}
</style>


<!-- 여기 안에 쓰기 -->
<main>
   <form action="/findByUserId" method="get">
      <div>
         <h2 class="title">
            <a href="userIdSearch" style="color: #1A3C7E">아이디 찾기</a>
            &nbsp;&nbsp;
            <a href="userPwSearch" style="color: gray">비밀번호 찾기</a>
         </h2>
         <div class="form-group">
            <label for="usr">회원이름</label> <input type="text" class="form-control" id="korName" value="" name="korName">
         </div>

         <div class="form-group">
            <label for="usr">이메일</label> <input type="text" class="form-control" id="email" value="" name="email">
         </div>
         <div class="form-group">
            <label for="usr">생년월일</label> <input type="text" class="form-control" id="birthDate" value="" name="birthDate" class="datepicker input_cal" placeholder="생년월일 " data-dateformat="y.mm.dd D" data-type="single_infinite">
         </div>
         <button type="submit"class="btn">아이디 찾기</button>
      </div>
   <div class="serchId" id="serchId">
   <input type="text" value="${response.korName}님의 아이디는 ${response.id} 입니다." readonly="readonly">
   
   </div>
   </form>
</main>

<script type="text/javascript">
let korName = '<c:out value="${response.korName}"></c:out>';
let id = '<c:out value="${response.id}"></c:out>';
      $("#birthDate").datepicker({
            dateFormat: "yy.mm.dd",
            changeMonth: true,
            changeYear: true
            // 추가적인 옵션 설정
          });
      
      if(id == ''){
         $('#serchId').hide();
      } else{
         $('#serchId').show();
      }

</script>

<input type="hidden" name="menuName" id="menuName" value="">
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>