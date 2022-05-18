<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.DriverManager"%>
    <%@page import="java.sql.Connection"%>
    <%@page import="java.sql.PreparedStatement" %>
    <%@page import="java.sql.ResultSet" %>
    <%@page import="java.sql.Statement" %>
    <%@page import="java.sql.SQLException" %>
    <%String nickname=(String) session.getAttribute("nickname"); %>
   <%int follow = (int)session.getAttribute("follow"); %>
   <%String id = (String) session.getAttribute("id"); %>
   <% String [] follow_user = new String[follow];
        Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String following_user=null;
		int i=0;
		try{
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
		String sql = "select follow_user from follow where userID=?";
		ps = con.prepareStatement(sql);
		ps.setString(1, id);
		rs = ps.executeQuery();
		%> 
		<br> <br> <br>
		<div class="center" >
		<fieldset style="width:40%; height:auto; margin:0 auto; border-radius:30px">
		<legend align="center"><h2 style="color:#ffbf00"><%=nickname%></h2> 팔로워 목록 </legend>

		<br/> 
		<table style="text-align:center; margin:0 auto">
		<%
		while(rs.next()) { 
			if(follow<i){
				break;
			}
			follow_user[i]=rs.getString("follow_user");
			%>
			<tr>
			<td><hr/></td>
			<td><%=follow_user[i]%><td/>
			</tr>
			<% 
			i++;
		}	%>
			</table>
			</fieldset>
			</div>
		<% }catch(SQLException e){
				e.printStackTrace();
				}
			 finally{
		System.out.close();
			}

%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관</title>
</head>

<body style="background-color:#2a365c; color:#ffffff">
</body>
</html>