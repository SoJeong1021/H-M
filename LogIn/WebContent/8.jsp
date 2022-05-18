<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관</title>
</head>
<body>

	<%
	String pairid = (String)request.getParameter("pairid"); 
	String pair = (String) session.getAttribute("pairid");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root",
				"04090118aa");
		Statement viewstmt = null;
		viewstmt = con.createStatement();
		//게시글 작성자의 아이디를 받아옴
		ResultSet viewrs = viewstmt.executeQuery("SELECT userid FROM test.pair WHERE id="+pair);

		while (viewrs.next()) {
			String id = viewrs.getString("userid");
	%>
	<%
	//본인 아이디 가져옴
		String follow = (String) session.getAttribute("id");
	%>
	<%
	String back = "view.jsp?pairid="+pair;
	%>
	<%
		int cc = 0;
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=utf-8");
			PreparedStatement pstmt = null;
			String sql = null;
			ResultSet rs = null;

			try {
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC",
						"root", "04090118aa");

				sql = "select userID from test.follow where follow_user=?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, follow);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					if (rs.getString("userID").equals(id)) {
						out.print("<script>");
						out.print("alert('이미 팔로우 하셨습니다.');");
						out.print("location.href='"+back+"'");
						out.print("</script>");
						out.flush();
						cc = 1;
					}

				}
			} catch (Exception e) {
				e.printStackTrace();
			}
	%>

	<%
		request.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=utf-8");
			if (cc == 0) {
				try {

					Connection conn = DriverManager.getConnection(
							"jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");

					sql = "INSERT INTO test.follow (userID, follow_user) values (?,?)";

					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setString(2, follow);
					pstmt.executeUpdate();
					out.print("<script>");
					out.print("alert('팔로우 하시겠습니까?');");
					out.print("location.href='"+back+"'");
					out.print("</script>");
					conn.close();

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	%>
</body>
</html>