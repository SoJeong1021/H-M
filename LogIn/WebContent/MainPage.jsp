<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
   content="width=device-width, minimum-scale=0.4 initial-scale=1.0">
<title>듣는 미술관</title>
</head>
<style>
a {
   color: #FFBF00;
   text-decoration: none;
}

a:hover {
   color: #FFBF00;
   text-decoration: underline;
}

body {
   background-color: #2a365c;
}

.blind1 {
   position: absolute;
   margin: -1px;
   left: 85%;
}

.blind {
   position: absolute;
   margin: -1px;
   right: 10%;
}

.geul {
   margin: 1% 0px 0px 0px;
   text-align: right;
   width: 100%;
}

.category {
   margin: 0 auto;
   margin-left: 30%;
}

.f_best {
   position: absolute;
   left: 10%;
   top: 40%;
}

.f_pnginf {
   position: absolute;
   left: 18%;
   top: 83%;
}

.f_musicinf {
   position: absolute;
   left: 19%;
   top: 86%;
}

.month_best {
   position: absolute;
   left: 10%;
   top: 108%;
}
.f_img {
   position: absolute;
   top: 40%;
   margin: 5% 5% 5% 15%;
}
.month_img {
   position: absolute;
   top: 105%;
   margin: 5% 5% 5% 15%;
}

.new {
   position: absolute;
   left: 10%;
   top: 175%;
}



.center {
   float: center;
}
</style>
<body>
   <a href="MainPage.jsp"><h1 align="center">듣는 미술관</h1></a>
   <br />
   <div style="float:left">
<div>
<a onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'카테고리':'카테고리';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none'" 
   style="color:#ffffff" href="#">카테고리</a><div style="DISPLAY: none;">

<div>
    <ul>
        <li class="menu">
            <a onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'이미지':'이미지';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none'" 
               style="color:#ffffff"  href="#">이미지</a><div style="DISPLAY: none;"> 
            <ul class="hide">
               <a href="category_img1.jsp" style="color:#ffffff"><li>자연</li></a> 
               <a href="category_img2.jsp" style="color:#ffffff"><li>사물</li></a> 
               <a href="category_img3.jsp" style="color:#ffffff"><li>인물</li></a> 
            </ul>
            </div>
        </li>
             <li class="menu">
            <a onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'음악':'음악';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none'" 
               style="color:#ffffff" href="#">음악</a><div style="DISPLAY: none;">
            <ul class="hide">
                <a href="category_music1.jsp" style="color:#ffffff"><li>EDM</li></a> 
               <a href="category_music2.jsp" style="color:#ffffff"><li>Unknown</li></a> 
               <a href="category_music3.jsp" style="color:#ffffff"><li>가요</li></a> 
            </ul>
            </div>
        </li>
       </ul>
   </div> 
</div>
</div>
</div>


   <nav class="category">
      <select style="height: 35px;">
         <option value="">전체</option>
         <option value="">이미지</option>
         <option value="">음악</option>
      </select> <input type="text" style="width: 400px; height: 30px;"
         placeholder="검색어를 입력해 주세요.">
      <button class="search_button" style="height: 35px;">검색</button>

   </nav>

   <nav class="geul">
      <h5 style="color: #FFBF00">
         <%=session.getAttribute("nickname")%>
         님
      </h5>
      <a href="logout.jsp"><font size="2px" color="white">로그아웃</font></a> 
      <a href="myPage.jsp"><font size="2px" color="white">마이페이지</font></a> 
      <a onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'글쓰기':'글쓰기';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none'" 
        style="color:#ffffff" href="#"><font size="2px">글 쓰기</font></a><div style="DISPLAY: none;">
                 <a href="new_write.html"><li><font size="2px" color="white">새 글 작성</font></li></a> 
               <a href="select.html"><li><font size="2px" color="white">기존 글 작성</font></li></a>
      </div>
   </nav>
   <br>
   <br>
   <br>
   <h3 class="f_best" style="color: #FFBF00" >자주 본 게시글</h3>
   <div  style="float: left; margin-left: 10%; margin-top:5%" class="f_img">
      
      <br> <%!String[] imgName = new String[30];
   String[] songName = new String[30];
   String[] imgpath = new String[30];
   int [] pairid = new int[30];
   int i;%>
         <%
            try {
               Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
               String sqlSt = "SELECT pair.id, imgName,songName,(SELECT imgpath FROM imgg WHERE imgid=id) as imgpath "
                     + "FROM pair WHERE id IN (SELECT board_num FROM (select board_num from boardfunction WHERE userID='"
                     + session.getAttribute("id") + "'order by count desc limit 0,3) AS ccc)";
               Statement s = con.createStatement();
               ResultSet rs = s.executeQuery(sqlSt);
               i = 0;
               while (rs.next()) {
                  imgName[i] = rs.getString("imgName");
                  songName[i] = rs.getString("songName");
                  imgpath[i] = rs.getString("imgpath");
                  pairid[i] = rs.getInt("pair.id");
                  i++;
               }
            } catch (SQLException e) {
               e.printStackTrace();
            }
         %>

         <%
         for(int k = 0; k < a; k++){
         %>
         <div style="float: left; color: #ffffff; text-align:center; margin:0px 15px 0px 0px">
            <a href="view.jsp?pairid=<%=pairid[i-1]%>"><img src="<%=imgpath[i - 1]%>" style="width: 300px; height: 40%"></img></a>
            <br /> IMG - <label><%=imgName[i - 1]%></label> <br /> 
            SONG - <label><%=songName[i - 1]%></label><br />
         </div>
         <%
            }
         a=0;
         %>


      

      </div>
      <br />
      <div>
      <h3 class="month_best" style="color: #FFBF00">이달의 베스트</h3>
      <br/> <br/>
      
      <div style="float: left; margin-left: 10%; margin-top:5%" class="month_img">
            <%!String[] bestimgName = new String[30];
   String[] bestsongName = new String[30];
   String[] bestimgpath = new String[30];
   String[] bestpairid = new String[30];
   int a;%>
         <%
            try {
               Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
               String sqlSt = "SELECT pair.id, imgName, songName, (select imgpath from imgg where imgid=id) as imgpath FROM pair WHERE id IN" +
                        "(select board_num from (select board_num from boardfunction where recommend=1 group by board_num order by count(recommend) asc) as best)";
               Statement st = con.createStatement();
               ResultSet rst = st.executeQuery(sqlSt);
               a = 0;
               while (rst.next()) {
                  bestimgName[a] = rst.getString("imgName");
                  bestsongName[a] = rst.getString("songName");
                  bestimgpath[a] = rst.getString("imgpath");
                  bestpairid[a] = rst.getString("pair.id");
                  a++;
               }
            } catch (SQLException e) {
               e.printStackTrace();
            }
         %>

         <%
         
         for(int k = 0; k < a; k++) {
         %>
         <div style="float: left; color: #ffffff; text-align:center; margin:0px 15px 0px 0px" >
            <a href="view.jsp?pairid=<%=bestpairid[k]%>"><img src="<%=bestimgpath[k]%>" style="width: 300px; height: 40%"></img></a>
            <br /> IMG - <label><%=bestimgName[k]%></label> <br /> 
            SONG - <label><%=bestsongName[k]%></label><br />
         </div>
         <%
            }
         a=0;
         %>
         
</div>
         </div>
</body>
</html>