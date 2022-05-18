<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.DriverManager"%>
    <%@page import="java.sql.Connection"%>
    <%@page import="java.sql.PreparedStatement" %>
    <%@page import="java.sql.ResultSet" %>
    <%@page import="java.sql.Statement" %>
    <%@page import="java.sql.SQLException" %>
    <%String nickname=(String) session.getAttribute("nickname"); %>
   <%int following = (int)session.getAttribute("following"); %>
   <%String id = (String) session.getAttribute("id"); %>
 
   
<!DOCTYPE html>
<html>
<head>
 <style>
 
a {color:#ffffff; text-decoration: none;} 
a:hover {color: #ffffff; text-decoration: underline;} 
   .center{
   position:absoulte;
   	left: 37%;
    }
   </style>
<meta charset="UTF-8">
<title>듣는 미술관</title>
</head>

<body style="background-color:#2a365c; color:#ffffff">
<% String [] following_user = new String[following];
        Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			int i = 0;
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
		String sql = "select * from follow where follow_user=?";
		ps = con.prepareStatement(sql);
		ps.setString(1, id);
		rs = ps.executeQuery();
		%>
		<br> <br> <br>
		<div class="center" >
		<fieldset style="width:40%; height:auto; margin:0 auto; border-radius:30px">
		<legend align="center"><h2 style="color:#ffbf00"><%=nickname%></h2> 팔로잉 목록 </legend>
		<table style="text-align:center; margin:0 auto">
		<br/> 
		<%
		while(rs.next()) { 
			if(following<i){
				break;
			}
			following_user[i]=rs.getString("userID");
			%>
			<tr>
			<td><hr/></td>
			<td><a href="followview.jsp"><%=following_user[i]%></a><td/>
			</tr>
			<% 
			i++;
		}	%>
			</table>
			</fieldset>
			</div>
		<% }	catch(SQLException e){
				e.printStackTrace();
				}
			 finally{
				System.out.close();
			}

%>
</body>
</html>