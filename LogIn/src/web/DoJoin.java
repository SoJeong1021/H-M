package web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DBUtil;


@WebServlet("/DoJoin")
public class DoJoin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DoJoin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String Joinid = request.getParameter("Joinid");
		String Joinpasswd = request.getParameter("Joinpasswd");
		String name = request.getParameter("Joiname");
		String phone = request.getParameter("Jointel");
		String pwch = request.getParameter("Joinchpw");
		String gender = request.getParameter("gender");
		String nickname = request.getParameter("JoinNick");
		
		

		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		PreparedStatement pstmt = null;
		
		try {
			String sql="insert into test.user values(?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Joinid);
			pstmt.setString(2, Joinpasswd);
			pstmt.setString(3, name);
			pstmt.setString(4, phone);
			pstmt.setString(5, nickname);
			pstmt.setString(6, gender);
			RequestDispatcher view = request.getRequestDispatcher("index.jsp");
			 view.forward(request, response);
			pstmt.executeUpdate();
			
		
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		try {
			String sqlql2="insert into test.commentdb (name, userID) value(?,?)";
			pstmt = conn.prepareStatement(sqlql2);
			pstmt.setString(1, nickname);
			pstmt.setString(2, Joinid);
			 pstmt.executeUpdate();		
		} catch(SQLException e) {
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
