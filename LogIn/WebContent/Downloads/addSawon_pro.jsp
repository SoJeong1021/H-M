<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	
		//addSawon.jsp페이지에서 전달받은 request객체영역의 데이터 한글처리
		request.setCharacterEncoding("UTF-8");
	
		//작성한 회원 정보를 request영역에서 꺼내와서 변수에 저장
		String s_id = request.getParameter("s_id");
		String s_name = request.getParameter("s_name");
		String s_pw = request.getParameter("s_pw");
		String s_age = request.getParameter("s_age");
		String s_addr = request.getParameter("s_addr");
		String s_extension = request.getParameter("s_extension");
		String s_dept = request.getParameter("s_dept");
		
		//데이터베이스에 전달할 SQL 명령어 준비
		//insert
		
		String SQL = "insert into tblSawon(id,name,pass,age,addr,extension,dept)" + 
				"values('"+ s_id + "','" + s_name + "','" + s_pw + "','" + s_age + "','" + s_addr + "','" + s_extension + "','" + s_dept + "');";
				
		/*DB작업을 위한 java.sql패키지에 있는 삼총사 객체중 2개(Connection , Statement)*/
		//DB연결 정보를 객체를 저장할 인터페이스 타입의 변수 선언
		Connection con = null;
		
		//DB연결후 DB에 sql쿼리문 전달 및 sql쿼리문 실행할 객체를 저장할 변수 선언
		Statement st = null;
		
		//연결할 DB주소, DB접속id, DB접속pw
		String url = "jdbc:mysql://localhost:3306/jspbeginner";
		String id = "jspid", pass = "jsppass";
		
		try{
			
			//1단계 jdbc 드라이버 로딩
			//오라클회사에서 제공해주는 Mysql용 DB연결 드라이버를 jsp프로젝트에 로딩
			Class.forName("com.mysql.jdbc.Driver");
			
			//2단계 DB 접속
			con = DriverManager.getConnection(url, id, pass);
			
			//3단계 DB에 SQL쿼리문 실행할 Statement객체 리턴받아옴
			st = con.createStatement();
			
			//4단계 DB에 SQL변수에있는 SQL문 실행하고 끝냄
			st.executeUpdate(SQL);
	%>
	
		<h2>직원 정보가 추가되었습니다.</h2>
		<a href="addSawon.jsp">직원추가화면으로</a>
		<a href="index.jsp">메인화면으로</a>
	
	<%		
			
		}catch(Exception err){
			System.out.println("addSawon_pro.jsp에서 오류:"+err);
		}finally{
			//자원해제
			if(st != null){
				st.close();
			}
			if(con !=null){
				con.close();
			}
		}
		
	%>
</body>
</html>