<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관</title>
</head>
<body>
<h1 align="center">
		<a href="index.jsp">듣는 미술관</a>
	</h1>
	<br />
	<br />
	<div align="center">
	<h2>
	<%
	String ckid = request.getParameter("id");
	Statement stmt=null;
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root",
			"04090118aa");
	stmt=conn.createStatement();
	
	ResultSet pwrs = stmt.executeQuery("SELECT passwd from test.user where id= '" + ckid +"'");
				while (pwrs.next()) {
					out.println("찾으시는 비밀번호는 " + pwrs.getString("passwd") + " 입니다." );
				}
					%></h2>
					
					<a href="index.jsp"><input type="button" value="로그인하기"></a>
</div>
</body>
</html>