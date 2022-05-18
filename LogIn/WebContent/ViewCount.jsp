<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.DriverManager"%>
    <%@page import="java.sql.Connection"%>
    <%@page import="java.sql.PreparedStatement" %>
    <%@page import="java.sql.ResultSet" %>
    <%@page import="java.sql.Statement" %>
<%-- int count=0; 
String number="1";
String id = (String) session.getAttribute("id");
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null; //number->게시글 넘버, ViewCount->조회수
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
String sql = "UPDATE SET ViewCount = ViewCount +1 FROM count WHERE number = '1' ? + id=?";
pstmt = con.prepareStatement(sql);
rs = pstmt.executeQuery();
pstmt.setString(1, number);
pstmt.setString(2, id);
while (rs.next()) {
    count = rs.getInt("ViewCount"); 
    } 
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관</title>
</head>
<body>


</body>
</html>