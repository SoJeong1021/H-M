<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <jsp:useBean id="dbu" class="model.DBU"/>
    <% int rst = 0;
    String nickname = (String) request.getParameter("nickname"); 
rst=dbu.nickanamecheck(nickname);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관</title>
</head>
<body>
<% if(rst==1){ %>
이미 존재하는 닉네임입니다.<%}else{ %>
사용 가능한 닉네임입니다.<%} %>
</body>
</html>