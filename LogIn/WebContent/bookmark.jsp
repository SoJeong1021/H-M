<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%
   String pairid = (String) request.getParameter("pairid");
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
      String back = "view.jsp?pairid=" + pair;

      try {
         Statement ss = con.createStatement();
         ResultSet rsrs = ss.executeQuery("SELECT * FROM test.boardfunction WHERE userID='"
               + session.getAttribute("id") + "' and board_num='" + pairid + "'");
         if (rsrs.next()) {
            if (rsrs.getInt("bookmark") == 1) {
               out.println("<script>");
               out.println("alert('이미 스크랩하였습니다.');");
               out.print("location.href='" + back + "'");
               out.println("</script>");
               out.flush();
            } else {
               PreparedStatement recs = con
                     .prepareStatement("UPDATE test.boardfunction SET bookmark=1 WHERE userID='"
                           + session.getAttribute("id") + "' and board_num='" + pairid + "'");
               recs.executeUpdate();

               out.println("<script>");
               out.println("alert('스크랩되었습니다.');");
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
            pstmt.setInt(3, 1);
            pstmt.setInt(4, 0);
            pstmt.setInt(5, 0);

            pstmt.executeUpdate();

            Statement rec = null;
            rec = con.createStatement();
            ResultSet recrs = rec.executeQuery("SELECT bookmark FROM test.boardfunction WHERE userID='"
                  + session.getAttribute("id") + "' and board_num='" + pairid + "'");

            while (recrs.next()) {
               if (recrs.getInt("bookmark") == 1) {

                  out.println("<script>");
                  out.println("alert('스크랩되었습니다.');");
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