package web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/DBUpdate2")
public class DBUpdate2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DBUpdate2() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		String uid = request.getParameter("uid");
		String passwd = request.getParameter("passwd");
		String name = request.getParameter("uname");
		String phone = request.getParameter("phone");
		String nickname = request.getParameter("nickname");
		
		
		PreparedStatement pstmt = null;
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");


try {
	
	//String sql ="UPDATE `test`.`user` SET `phone_number` = '01087341554' WHERE (`id` = '87@34.com')";
	pstmt = conn.prepareStatement("select * from user where id=?");
	pstmt.setString(1, uid);
	ResultSet rs=pstmt.executeQuery();
	
	if(rs.next()) {
		        pstmt.close();
		        pstmt = null;
				pstmt =conn.prepareStatement("UPDATE user SET id=?, passwd=?, name=?, phone_number=?, nickname=? where id=? ");
				pstmt.setString(1, uid);
				pstmt.setString(2, passwd);
				pstmt.setString(3, name);
				pstmt.setString(4, phone);
				pstmt.setString(5, nickname);
				pstmt.setString(6, uid);
				pstmt.executeUpdate();
			
				
	}
				

	
		
}
	catch(SQLException e) {
		e.printStackTrace();
	
	}
}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
