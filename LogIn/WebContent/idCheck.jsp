<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="dbu" class="model.DBU"/>
    <% 
    request.setCharacterEncoding("utf-8");


    int rst = 0; String id = (String) request.getParameter("id"); 
rst=dbu.idcheck(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관</title>
</head>
<body>
<% if(rst==1){ %>
이미 존재하는 아이디입니다.<%}else{ %>
사용 가능한 아이디입니다.<%} %>
</body>
</html>