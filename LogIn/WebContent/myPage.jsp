<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.SQLException" %>
    
    <%String id = (String) session.getAttribute("id"); %>
    <%String nickname = (String) session.getAttribute("nickname"); %>
    
       <%      
      int content=0;
        Connection con = null;
      PreparedStatement pstm = null;
      ResultSet res = null;
      
      try{
      con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
      String sql = "select * from pair where userid=?";
      pstm = con.prepareStatement(sql);
      pstm.setString(1, id);
      res = pstm.executeQuery();
      while(res.next()) {
         content = content +1;
         }   }   catch(SQLException e){
            e.printStackTrace();
            }
          finally{
            System.out.close();
         }
      %>
      
    <%      
      int following=0;
        Connection c = null;
      PreparedStatement pst = null;
      ResultSet rs2 = null;
      
      try{
      c =DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
      String sql = "select * from follow where follow_user=?";
      pst = c.prepareStatement(sql);
      pst.setString(1, id);
      rs2 = pst.executeQuery();
      while(rs2.next()) {
         following = following +1;
         }   }   catch(SQLException e){
            e.printStackTrace();
            }
          finally{
            System.out.close();
         }
      %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1" />
<title>듣는 미술관</title>
</head>

<script>

function level_view(){
   var url = "level.jsp?=";
   window.open(url, "get", "height=400, width=600");
}

function information(){
   var url = "changeInformation.jsp?=";
   window.open(url, "get", "height=500, width=500");   
}

</script>
<style>
.geul{
  text-align: right;
  }
#body {
   overflow: scroll;
}

.blind1 {
   position: absolute;
   margin: -1px;
   margin-right:5%;
}

.blind {
   position: absolute;
   margin: -1px;
   margin-right:5%;
}

.num {
   position: absolute;
   margin: -1px;
   font-size: 20px;
   left:30%;
}
.edit{
   float:right;
   text-align:right;
   margin-top:8%;
   margin-right:5%;
}
.name{
   position: absolute;
   margin-left:20%;
   top: 55%;
}
.tab_content {
   position: absolute;
   text-align:center;
   margin: -1;
   top: 70%;
   left: 15%;
}
input[type="radio"] {
   width: 480px;
   display:none;
}
input[type="radio"] + label {
   display:inline-block;
   width: 480px;
   padding: 20px;
   background:#ccc;
   color: #2a365c;
   cursor:pointer;
}
input[type="radio"]:checked + label {
   background: #ffbf00;
   color: #ffffff;
}
.conbox {
   height:auto;
   weight:autox;
   margin:0 20px;
   display:none;
   text-align:center;
   font-size:12px;
   padding:20px;
   box-sizing:border-box;
}
input[id="tab01"]:checked ~ .con1 {
   display:block;
}
input[id="tab02"]:checked ~ .con2  {
   display:block;
}
a {color:#ffffff; text-decoration: none;} 
a:hover {color: #ffffff; text-decoration: underline;} 
</style>
<script>

</script>
<body style="background-color:#2a365c; color:#ffffff">
<%      int commentcount=0;
        Connection conn = null;
      PreparedStatement ps = null;
      ResultSet rst = null;
      
      try{
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
      String sql = "select * from commentdb where userID=?";
      ps = conn.prepareStatement(sql);
      ps.setString(1, id);
      rst = ps.executeQuery();
      while(rst.next()) {
         commentcount = commentcount +1;
         }   }   catch(SQLException e){
            e.printStackTrace();
            }
          finally{
            System.out.close();
         }
      %>
      
      <%      
      int follow=0;
        Connection con2 = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      try{
      con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
      String sql = "select * from follow where userID=?";
      pstmt = con2.prepareStatement(sql);
      pstmt.setString(1, id);
      rs = pstmt.executeQuery();
      while(rs.next()) {
         follow = follow +1;
         }   }   catch(SQLException e){
            e.printStackTrace();
            }
          finally{
            System.out.close();
         }
      %>
      
      
	<br /><a href="MainPage.jsp"> <h1 align="center" style="color:#FFBF00">듣는 미술관</h1></a><br />
  <div class="geul">
   <h5 style="color:#FFBF00"> <%= session.getAttribute("nickname") %> 님 </h5>
   <a href="logout.jsp"><font size="2px" color="white">로그아웃</font></a>
     <a href="myPage.jsp"><font size="2px" color="white">마이페이지</font></a>
     <a onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'글쓰기':'글쓰기';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none'" 
        style="color:#ffffff" href="#"><font size="2px">글 쓰기</font></a><div style="DISPLAY: none;">
                 <a href="writeNew.html"><li><font size="2px" color="white">새 글 작성</font></li></a> 
               <a href="select.html"><li><font size="2px" color="white">기존 글 작성</font></li></a>
   </div>
   <br>
   <br>

   <div class="num">
      <table>
      <tr align="center">
         <td width="auto">&nbsp;&nbsp;<%=content%>&nbsp;&nbsp;</td>
          <% session.setAttribute("content", content); %>
         <td width="auto">&nbsp;&nbsp;<%=commentcount%>&nbsp;&nbsp;</td>
          <% session.setAttribute("commentcount", commentcount); %>
         <td width="auto">&nbsp;&nbsp;<%=follow%>&nbsp;&nbsp;</td>
            <% session.setAttribute("follow", follow); %>
         <td width="auto">&nbsp;&nbsp;<%=following %>&nbsp;&nbsp;</td>
        <% session.setAttribute("following", following); %>
      </tr>
      <br/>
      <tr align="center">
         <td width="auto">&nbsp;&nbsp;게시글 &nbsp;&nbsp;</td>
         <td width="auto">&nbsp;&nbsp;댓글&nbsp;&nbsp;</td>   
         <td width="auto"><a href="follow.jsp">&nbsp;&nbsp;팔로워&nbsp;&nbsp;</a></td>
         <td width="auto"><a href="following.jsp">&nbsp;&nbsp;팔로잉&nbsp;&nbsp;</a></td>
      </tr>
      </table>
   </div>
   <br> <br>
   <div>
      <div class="name">
         <a>
         <h3>환영합니다.<%=nickname%>님!  &nbsp;
         <%if(commentcount<20 && content<10){%>
         <img name="image" src="img/lev1.png" width="30px" height="30px" alt="현재 레벨을  보시려면   눌 러 주 세 요." onclick="level_view();">
 
        <%} 
         else if(20<=commentcount && commentcount<50 && content >=10 && content<20){ %>
         <img src="img/lev2.png" width="30px" height="30px" alt="현재 레벨을  보시려면   눌 러 주 세 요." onclick="level_view();">
         <%
         } else if(50<=commentcount && commentcount<100 && content>=20 && content <30) { %>
            <img src="img/lev3.png" width="30px" height="30px" alt="현재 레벨을  보시려면   눌 러 주 세 요." onclick="level_view();">
         <%
         } else if(commentcount>=100 && content>=100) {%>
         <img src="img/lev4.png" width="30px" height="30px" alt="현재 레벨을  보시려면   눌 러 주 세 요." onclick="level_view();">
         <%}
        %>
         </h3></a>
      </div>
      <div class="edit" style="float:right">
      <a href="changeInformation.jsp">내 정보 수정</a>
      <a href="getOut.jsp" style="color:gray">회원탈퇴</a>
      </div>
   </div>
   <div class="tab_content">
      <input type="radio" name="tabmenu" id="tab01" checked>
      <label for="tab01">게시물</label>
      <input type="radio" name="tabmenu" id="tab02">
      <label for="tab02">북마크</label>
      
      <div class="conbox con1">
      
			  <%!String[] imgName = new String[30];
	String[] songName = new String[30];
	String[] imgpath = new String[30];
	int i;%>
			<%
				try {

					String sqlSt = "SELECT imgName, songName, (SELECT imgpath FROM imgg WHERE imgid = id) AS imgpath FROM pair where userID='" + session.getAttribute("id") + "'";
					Statement s = con.createStatement();
					ResultSet wrs = s.executeQuery(sqlSt);
					i = 0;
					while (wrs.next()) {
						imgName[i] = wrs.getString("imgName");
						songName[i] = wrs.getString("songName");
						imgpath[i] = wrs.getString("imgpath");
						i++;
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			%>

			<%
				while (i > 0) {
			%>
			<div style="float: left; color: #ffffff; margin-right:1%; margin-top:1%">
				<img src="<%=imgpath[i - 1]%>" style="width: 300px; height: 40%"></img>
				<br /> IMG - <label><%=imgName[i - 1]%></label> <br /> 
				SONG - <label><%=songName[i - 1]%></label><br />
			</div>
			<%
				i -= 1;
				}
			%>
			</body>
</html>
      
      
      
      </div>
      <div class= "conbox con2"> 
     <%!String[] bmimgName = new String[30];
	String[] bmsongName = new String[30];
	String[] bmimgpath = new String[30];
	int a;%>
			<%
				try {
					String sqlSt = "SELECT imgName, songName, (SELECT imgpath FROM imgg WHERE imgid = id) AS imgpath FROM pair where id IN (select board_num from boardfunction where bookmark=1 and userID='" + session.getAttribute("id") + "')";
					Statement s = con.createStatement();
					ResultSet bookrs = s.executeQuery(sqlSt);
					a = 0;
					while (bookrs.next()) {
						bmimgName[a] = bookrs.getString("imgName");
						bmsongName[a] = bookrs.getString("songName");
						bmimgpath[a] = bookrs.getString("imgpath");
						a++;
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			%>

			<%
				while (a > 0) {
			%>
			<div style="float: left; color: #ffffff; margin-right:1%; margin-top:1%">
				<img src="<%=bmimgpath[a - 1]%>" style="width: 300px; height: 40%"></img>
				<br /> IMG - <label><%=bmimgName[a - 1]%></label> <br /> 
				SONG - <label><%=bmsongName[a - 1]%></label><br />
			</div>
			<%
				a -= 1;
				}
			%>
      
      
      </div>
      
   </div> 

</body>
</html>