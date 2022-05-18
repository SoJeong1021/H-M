<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>

<%
String pairid = (String)request.getParameter("pairid");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관</title>
</head>
<body>
      <%
         String pair = (String) session.getAttribute("pairid");

            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root",
            "04090118aa");
            String back = "view.jsp?pairid="+pair;
            try {
         Statement ss = con.createStatement();
         ResultSet rsrs = ss.executeQuery("SELECT * FROM test.boardfunction WHERE userID='" + session.getAttribute("id") +"' and board_num='"+ pairid + "'");
         if (rsrs.next()) {
            if(rsrs.getInt("recommend")==1){
               out.println("<script>");
               out.println("alert('이미 추천하였습니다.');");
               out.print("location.href='"+back+"'");
               out.println("</script>");
               out.flush();   
            } else {
               PreparedStatement recs = con.prepareStatement("UPDATE test.boardfunction SET recommend=1 WHERE userID='" + session.getAttribute("id") +"' and board_num='"+ pairid + "'");
               recs.executeUpdate();
               
                  out.println("<script>");
                  out.println("alert('추천되었습니다.');");
                  out.print("location.href='" + back + "'");
                  out.println("</script>");

                  out.flush();

               }
            } else {
               String sql = ("INSERT INTO test.boardfunction values(?,?,?,?,?)");
               PreparedStatement pstmt = null;
               pstmt = con.prepareStatement(sql);
               pstmt.setInt(1, 1);
               pstmt.setString(2, (String) session.getAttribute("id"));
               pstmt.setInt(3, 0);
               pstmt.setInt(4, 1);
               pstmt.setString(5, pairid);

               pstmt.executeUpdate();

               Statement rec = null;
               rec = con.createStatement();
               ResultSet recrs = rec.executeQuery("SELECT recommend FROM test.boardfunction WHERE userID='"
                     + session.getAttribute("id") + "' and board_num='" + pairid + "'");

               while (recrs.next()) {
                  if (recrs.getInt("recommend") == 1) {

                     out.println("<script>");
                     out.println("alert('추천되었습니다.');");
                     out.print("location.href='" + back + "'");
                     out.println("</script>");

                     out.flush();
                  }
               }
            }
         } catch (SQLException e) {
            e.printStackTrace();
         }
      %>
</body>
</html>