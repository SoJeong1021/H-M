package web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DBUtil;

/**
 * Servlet implementation class DoLogIn
 */
@WebServlet("/doLogIn") //dd에 들어가는 서블릿과 id 매핑
public class DoLogIn extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DoLogIn() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String uid = request.getParameter("uid");
		String passwd = request.getParameter("passwd");
		
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection"); //context에 attribute값이 있다고 가정
		//deployment에서 값 넘어옴
		
		ResultSet rs = DBUtil.findUser(conn, uid); //request의 파라미터
		String nickname = DBUtil.findNick(conn, uid);
		String name = DBUtil.findName(conn, uid);
		String phone = DBUtil.findNumber(conn, uid);
		
		PrintWriter out = response.getWriter();
	
	
		if (rs != null) {
			try {
				if(rs.next()) { // existing user select password from user
					String checkpw = rs.getString(1); 
					
					
					if (checkpw.equals(passwd)){
						// valid user and passwd
					
						HttpSession session = request.getSession();
						session.setAttribute("nickname", nickname);
						
						HttpSession session2 = request.getSession();
						session.setAttribute("id", uid);
						
						HttpSession session3 = request.getSession();
						session.setAttribute("passwd", passwd);
						
						HttpSession session4 = request.getSession();
						session.setAttribute("name", name);
						
						HttpSession session5 = request.getSession();
						session.setAttribute("phone", phone);
					     
					 	RequestDispatcher view = request.getRequestDispatcher("MainPage.jsp");
						view.forward(request, response);
					}
					else {
						// wrong passwd
						out.println("<h2>Wrong Passwd!!<h2>");
					}
				}
				else {  //resultset은 왔는데 결과 튜플이 없는 경우 -> user 등록 X
					// invalid user
					out.println("<h2>Invalid User Name!!<h2>");
				}			
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
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
