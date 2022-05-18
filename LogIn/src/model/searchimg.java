package model;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class searchimg
 */
@WebServlet("/searchimgDo")
public class searchimg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public searchimg() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			response.setStatus(HttpServletResponse.SC_OK);
			
			String imgKeyword = request.getParameter("imgkeyword");
			int imgId = 0;
		
			ServletContext sc = getServletContext();
			Connection conn= (Connection) sc.getAttribute("DBconnection");
			PrintWriter out = response.getWriter();
			HttpSession session = request.getSession();
			
			String sqlSt = "SELECT * FROM imgg WHERE FILENAME='"+ imgKeyword + "'";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sqlSt);
			
			while(rs.next())
				imgId = rs.getInt("id");
			System.out.println(imgKeyword + " " + imgId);
			
			//다음 서블릿에서 사용하기 위해 전달
			session.setAttribute("imgKeyword", imgKeyword);
			session.setAttribute("imgId", imgId);
			
			RequestDispatcher view = request.getRequestDispatcher("addSong.jsp");
			view.forward(request, response);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
