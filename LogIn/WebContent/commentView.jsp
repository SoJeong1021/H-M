<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
 <%String nickname = (String) session.getAttribute("nickname"); %>
<% String pairid = (String)request.getParameter("pairid");  String boardnum = pairid; %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <%
   request.setCharacterEncoding("utf-8");
   response.setContentType("text/html; charset=utf-8");
   
    String content = request.getParameter("content");
    String id = (String) session.getAttribute("id"); 
    String pair = (String) session.getAttribute("pairid");
    String back = "view.jsp?pairid="+pair;
    
   Connection conn = null;
   
   try {
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
   } catch (SQLException e1) {
      // TODO Auto-generated catch block
      e1.printStackTrace();
   }
   
   PreparedStatement pstmt=null;

try {      
 
    String sql = "INSERT INTO test.commentdb (board_num, userID, content, name) values (?,?,?,?)";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, pair);
    pstmt.setString(2, id);
    pstmt.setString(3, content);
    pstmt.setString(4, nickname);
    pstmt.executeUpdate();
    conn.close();   
} catch (Exception e) {
    e.printStackTrace();
}    
    %><script>
    alert("정상적으로 등록되었습니다.");
    location.href="view.jsp?pairid=<%=pair%>";
    </script>
</body>
</html>