<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관</title>
</head>
<body>

<%
   session.invalidate();

%>

<script>
alert("로그아웃이 정상적으로 되었습니다.");
location.href = "index.jsp";


</script>


</body>
</html>