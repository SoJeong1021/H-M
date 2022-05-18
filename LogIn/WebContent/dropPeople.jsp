<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.DriverManager"%>
    <%@page import="java.sql.Connection"%>
    <%@page import="java.sql.PreparedStatement" %>
    <%@page import="java.sql.ResultSet" %>
    <%@page import="java.sql.Statement" %>
    <%
    String uid = (String) session.getAttribute("id");
    String passwd = request.getParameter("pw");
    String pw = (String) request.getAttribute("passwd");
    
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
	
	String sql = "SELECT passwd FROM user WHERE id = ?";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1, uid);
	rs = pstmt.executeQuery();
	
	if(rs.next()) {
		if(passwd.equals(rs.getString("passwd"))) {
			pstmt.close();
			pstmt = null;
			sql = "DELETE FROM user WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			pstmt.executeUpdate();
			
			String sql2 = "DELETE FROM follow WHERE userID=?";
			pstmt = con.prepareStatement(sql2);
			pstmt.setString(1, uid);
			pstmt.executeUpdate();
			
			String sql3 = "DELETE FROM follow WHERE follow_user=?";
			pstmt = con.prepareStatement(sql3);
			pstmt.setString(1, uid);
			pstmt.executeUpdate();
			
			String sql4 = "DELETE FROM commentdb WHERE userID=?";
			pstmt = con.prepareStatement(sql4);
			pstmt.setString(1, uid);
			pstmt.executeUpdate();
			
			session.invalidate();
			
			%>
			<script>
				alert("탈퇴 성공");
				location.href = "index.jsp";
			</script>
			<%
		} else {
			%>
			<script>
				alert("비밀번호 틀림");
				history.back();
			</script>
			<%
		}
	}
%>

  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관</title>
</head>
<body>
<script>



</script>
</body>
</html>