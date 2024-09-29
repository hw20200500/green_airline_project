<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Upload Error</title>
</head>
<body>
    <script>
        alert("이미지(jpg, jpeg, png) 파일 이외의 파일은 업로드할 수 없습니다.");
        location.replace("/board/insert");
    </script>
</body>
</html>
