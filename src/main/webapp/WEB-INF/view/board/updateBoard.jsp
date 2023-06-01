<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<style>
  .form-control {
    width: 1110px;
    margin-left: 70px;
  }
</style>
<main>
  <h5>여행일지</h5>

  <form action="/board/update/${id}" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="${id}">
    <table class="table">
      <tr>
        <td><input class="form-control" id="title" type="text" name="title" placeholder="제목"></td>
      </tr>
    </table>
    <div class="container">
      <textarea class="summernote" id="summernote" name="content">${boardDto.content}</textarea>
    </div>
    <div class="custom-file">
      <input type="file" class="custom-file-input" id="customFile" accept=".jpg, .jpeg, .png" name="file">
      <label class="custom-file-label" for="customFile">썸네일용 이미지</label>
    </div>
    <div class="modal-footer">
      <button type="submit" class="btn btn-primary">작성하기</button>
    </div>
  </form>
</main>
<script>
  $(document).ready(function() {
    $('#summernote').summernote({
      height: 500,
      minHeight: null,
      maxHeight: null,
      focus: true,
      lang: 'ko-KR'
    });
  });
</script>
<%@ include file="/WEB-INF/view/layout/footer.jsp"%>