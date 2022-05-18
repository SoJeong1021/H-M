<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="model.Counter" %>
<%!
String imgName = null;
String songName = null;
String imgpath = null;
String songpath = null;
String songDesc = null;
String imgDesc = null;
String pair = null;
%>
<%String nickname = (String)session.getAttribute("nickname");


%>

<%
String pairid = (String)request.getParameter("pairid"); 
String id = (String) session.getAttribute("id");
session.setAttribute("pairid", pairid);

try {
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
      String sqlSt = "SELECT distinct imgName,songName, imgDesc, songDesc,(SELECT imgpath FROM imgg WHERE imgid = id) AS imgpath, (SELECT songpath FROM songg WHERE songid = id) AS songpath, pair.id as id FROM pair JOIN imgg,songg WHERE pair.id = " + pairid;
      Statement s = con.createStatement();
      ResultSet rs = s.executeQuery(sqlSt);
      while (rs.next()) {
         imgName = rs.getString("imgName");
         songName = rs.getString("songName");
         imgpath = rs.getString("imgpath");
         songpath = rs.getString("songpath");
         imgDesc = rs.getString("imgDesc");
         songDesc = rs.getString("songDesc");
         pair = rs.getString("id");
      }
      
   }catch(SQLException e) {
      e.printStackTrace();
   }

%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
   src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js">
   
</script>
<meta charset="UTF-8" name="viewport"
   content="user-scalable=no, initial-scale=1, maximum-scale=1" />
<title>관람 페이지</title>
</head>
<style>
#body {
   overflow: scroll;
   color: #ffffff;
}
.geul{
  text-align: right;
  color: #ffffff;
  }
.blind1 {
   position: absolute;
   margin: -1px;
   left: 85%;
}

.blind {
   position: absolute;
   margin: -1px;
   left: 90%;
}

.comment {
   position: absolute;
   margin-left:2%;
   color:#ffbf00;
}

.comment_box {
   position: absolute;
   margin-top: 1.5%;
   left: 10%;
}

.comment_view {
   position: absolute;
   margin-top: 3%;
   left: 10%;
}
a {color:#ffffff; text-decoration: none;} 
a:hover {color: #ffffff; text-decoration: underline;} 
</style>
<script>

alert(pair);
   function recommend() {
      if (confirm("추천하시겠습니까?") == true) {
         location.href = "recommend.jsp?pairid=<%=pair%>";
      } else {
         return false;
      }
   }
   
   function bookmark() {
      if (confirm("스크랩하시겠습니까?") == true) {
         location.href = "bookmark.jsp?pairid=<%=pair%>";
      } else {
         return false;
      }
   }

</script>
<body style="background-color:#2a365c; color:#ffffff">
   <br /><a href="MainPage.jsp"><h1 align="center" style="color:#FFBF00">듣는 미술관</h1></a><br />
   <%


%>
   <div class="geul">
   <h5 style="color:#FFBF00"> <%= session.getAttribute("nickname") %> 님 </h5>
   <a href="logout.jsp"><font size="2px">로그아웃</font></a>
     <a href="new_write.html"><font size="2px">글 쓰기</font></a> 
     <a href="myPage.jsp""><font size="2px">마이페이지</font> </a>
   </div>
   <br>
   <br>
   <br>

   <div style="margin-left:10%">
      <div class="pm">
      <label> IMG - <%=imgName%> SONG - <%=songName%></label> <br/>
      <img src="<%=imgpath%>" width="150px" height="150px"></img>
      <audio src="<%=songpath%>" controls = "controls"></audio><br/>
      <%=imgDesc%><br/>
      <%=songDesc%>
   </div>
   </div>

   <% 
   Connection con =DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
   %>

   <div style="float: right; text-align:right; margin:10px">
      <img src="img/rec.png" width="30px" height="30px" alt="추천 버튼, 스크랩하시려면 눌러주세요"
         style="cursor: pointer" onclick="recommend()"> 
         <% Statement totalrec = con.createStatement();
            ResultSet totalrs = totalrec.executeQuery("SELECT count(recommend) AS countREC FROM test.boardfunction WHERE recommend=1 and board_num='"+ pairid + "'");
            while (totalrs.next()) {
               int count = totalrs.getInt("countREC");
      
               HttpSession session6 = request.getSession();
               session.setAttribute("count", count); 
               
            out.println(session.getAttribute("count"));
            }   %>
      <img src="img/bm.png" width="30px" height="30px" alt="북마크" style="cursor: pointer" onclick="bookmark()" alt="북마크 버튼, 스크랩하시려면 눌러주세요">
      <% Statement bm = con.createStatement();
            ResultSet bmrs = totalrec.executeQuery("SELECT count(bookmark) AS countBM FROM test.boardfunction WHERE bookmark=1 and board_num='"+ pairid + "'");
            while (bmrs.next()) {
               int bookmark = bmrs.getInt("countBM");
      
               HttpSession session7 = request.getSession();
               session.setAttribute("bookmark", bookmark); 
               
            out.println(session.getAttribute("bookmark"));
            }   %>
      <br /><br />
         <form action ="8.jsp?pairid=<%=pairid%>">
            <%
            
            Statement viewstmt = null;
            viewstmt = con.createStatement();
            ResultSet viewrs = viewstmt.executeQuery("SELECT userid FROM test.pair WHERE id='"+ pairid + "'" );

            while (viewrs.next()) {
               out.println("&nbsp;&nbsp;&nbsp;");
               out.println(viewrs.getString("userid"));
               out.println(" 님의 게시글입니다.");
            }
            %>
         <input type="submit" value="팔로우" onclick="return follow()"/>
         </form>
     <%
      try {
         Statement ss = con.createStatement();
         ResultSet rsrs = ss.executeQuery("SELECT * FROM test.boardfunction WHERE userID='" + session.getAttribute("id") +"' and board_num='" + pair +"'");
         if (rsrs.next()) {
               String sql = "UPDATE test.boardfunction SET count= " + Counter.getCount((String)session.getAttribute("id"),pair) +" WHERE userID='" + session.getAttribute("id") +"' and board_num='"+ pairid + "'" ;
               PreparedStatement ps = con.prepareStatement(sql);
               ps.executeUpdate();
         } else{
            String sqlst = ("INSERT INTO test.boardfunction values(?,?,?,?,?)");
            PreparedStatement pstmt = null;
            pstmt = con.prepareStatement(sqlst);
            pstmt.setString(1, pairid);
            pstmt.setString(2, (String) session.getAttribute("id"));
            pstmt.setInt(3, 0);
            pstmt.setInt(4, 0);
            pstmt.setInt(5, 1);
         
            pstmt.executeUpdate();
         
            String sql = "UPDATE test.boardfunction SET count=" + Counter.getCount((String)session.getAttribute("id"),pair) +" WHERE userID='" + session.getAttribute("id") +"' and board_num='" + pairid + "'";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.executeUpdate();
         }
      } catch (SQLException e) {
         e.printStackTrace();
      }
%>
   </div>
   <br /> <br /><br /><br /><br />
   <hr>
   <h2 class="comment">댓글</h2>
   <form action = "commentView.jsp?pairid=<%=pairid%>">
      <table class="comment_box">
         <tr>
            <td style="color:#ffbf00">닉네임:</td>
            <td style="color:#ffbf00">
               <%
                  String nick = (String) session.getAttribute("nickname");
                  out.println(nick);
               %>
            </td>
            <td>&nbsp; &nbsp; &nbsp; 내용</td>

            <td><input type="text" name="content" style="width: 300px; height:25px;"
               placeholder="한줄평을 작성해주세요."></td>
            <td><input type="submit" name="cmd" style="height: 35px;"
               value="확인" /></td>
         </tr>
      </table>
      <br> <br>

   </form>
   <div class="comment_view">
      <%
         String content = request.getParameter("content");
         Connection conn = null;
         Statement stmt = null;

         try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT *FROM test.commentdb where board_num='"+pairid+"'");

            while (rs.next()) {
               String dbcontent = rs.getString("content");
               String dbnick = rs.getString("name");
               out.println(dbnick + "    |    " + dbcontent + "&nbsp;" + rs.getTimestamp("wdate") + "<br>");
            }
         } finally {
            try {
               stmt.close();
            } catch (Exception ignored) {
            }
            try {
               conn.close();
            } catch (Exception ignored) {
            }
         }
      %>
         <br/><br/>
   </div>

</body>
</html>