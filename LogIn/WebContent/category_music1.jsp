<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관</title>
<style>
a {color:#FFBF00; text-decoration: none;} 
 a:hover {color: #FFBF00; text-decoration: underline;} 

body{
background-color:#2a365c;
}
.blind1 {
    position:absolute;
    margin: -1px;
    left:85%;
}    
    
.blind {
    position:absolute;
    margin: -1px;
    left:90%;
}

.category{
 position:absolute;
     left:10%;
     top:15%;

}
.geul{
  text-align: right;
  }
.img_in{
 position:absolute;
     left:10%;
     top:25%;

}
.music1{
     position:absolute;
     left:10%;
     top:35%;

}
</style>
</head>
<body>
<a href="MainPage.jsp" ><h1 align="center">듣는 미술관</h1></a>
<div style="float:left">
<div>
<a onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'카테고리':'카테고리';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none'" 
	style="color:#ffffff" href="#" ;>카테고리</a><div style="DISPLAY: none;">
<div>
    <ul>
        <li class="menu">
            <a onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'이미지':'이미지';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none'" 
            	style="color:#ffffff"   href="#">이미지</a><div style="DISPLAY: none;"> 
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
               <a href="category_music2.jsp" style="color:#ffffff"><li>클래식</li></a> 
               <a href="category_music3.jsp" style="color:#ffffff"><li>가요</li></a> 
            </ul>
            </div>
        </li>
       </ul>
   </div> 
</div>
</div>
</div>
<div class="geul">
	<h5 style="color:#FFBF00"> <%= session.getAttribute("nickname") %> 님 </h5>
	<a href="logout.jsp"><font size="2px" color="white">로그아웃</font></a>
     <a href="myPage.jsp"><font size="2px" color="white">마이페이지</font></a>
     <a onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'글쓰기':'글쓰기';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none'" 
    	 style="color:#ffffff"    href="#"><font size="2px">글 쓰기</font></a><div style="DISPLAY: none;">
                 <a href="writeNew.html"><li><font size="2px" color="white">새 글 작성</font></li></a> 
               <a href="select.html"><li><font size="2px" color="white">기존 글 작성</font></li></a>
   </div>
   </div>

<h3 class="category" style="color:#FFBF00"><ins>EDM</ins></h3>

<%!
	String [] imgName = new String[30];
	String [] songName = new String[30];
	String [] songpath = new String[30];
	int [] pairid = new int[30];
	int i;
%>
<%
try {
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
		String sqlSt = "SELECT pair.imgName, pair.songName, pair.id, (SELECT songpath FROM songg WHERE songid = id) AS songpath FROM pair JOIN songg WHERE songid in (SELECT id FROM test.songg WHERE songCate = 'EDM') GROUP By songid;";
		Statement s = con.createStatement();
		ResultSet rs = s.executeQuery(sqlSt);
		i=0;
		while (rs.next()) {
			imgName[i] = rs.getString("imgName");
			songName[i] = rs.getString("songName");
			songpath[i] = rs.getString("songpath");
			pairid[i] = rs.getInt("pair.id");
			i++;
		}
	}catch(SQLException e) {
		e.printStackTrace();
	}
%>
	
<%
for(int k = 0; k < i; k++){ %>
<div  style="float: left; margin-left: 10%; margin-top:5%">
<h6 style="color:white"><label> IMG - <%=imgName[k]%></label><br/>
<a href = "view.jsp?pairid=<%=pairid[k]%>"><label style="color:white"> SONG - <%=songName[k]%></label><br/></h6></a>
<audio src = "<%=songpath[k]%>" controls = "controls"></audio>
</div>
<%
}
i=0;
%>
</body>
</html>