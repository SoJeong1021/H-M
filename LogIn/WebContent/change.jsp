<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.DriverManager"%>
    <%@page import="java.sql.Connection"%>
    <%@page import="java.sql.PreparedStatement" %>
    <%@page import="java.sql.ResultSet" %>
    <%@page import="java.sql.Statement" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");


String uid = (String) session.getAttribute("id");
String passwd = request.getParameter("passwd");
String uname = request.getParameter("uname");
String phone = request.getParameter("phone");
String nickname = request.getParameter("nickname");


PreparedStatement pstmt = null;
ServletContext sc = getServletContext();
Connection conn= (Connection) sc.getAttribute("DBconnection");

//String sql ="UPDATE `test`.`user` SET `phone_number` = '01087341554' WHERE (`id` = '87@34.com')";
//pstmt = conn.prepareStatement("select * from user where id=?");
//pstmt.setString(1, uid);
String sql = "select * from user where id = '" + uid + "'";
Statement st = null;
st = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

ResultSet rs=st.executeQuery(sql);
while(rs.next()) {
      rs.updateString("passwd", passwd);
      rs.updateString("name", uname);
      rs.updateString("phone_number", phone);
      rs.updateString("nickname", nickname);
      rs.updateString("id", uid);
      rs.updateRow();
}
st.close();

%>
<%session.setAttribute("nickname", nickname); %>
  <script>
alert("수정 성공");
location.href="myPage.jsp"
</script>
</body>