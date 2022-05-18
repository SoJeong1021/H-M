package model;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class addImg
 */
@WebServlet("/addImg")
public class addImg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addImg() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			ServletContext sc = getServletContext();
			Connection conn= (Connection) sc.getAttribute("DBconnection");
			PrintWriter out = response.getWriter();
			HttpSession session = request.getSession();
			String userid = (String)session.getAttribute("id");
		
			response.setContentType("text/html; charset=UTF-8");
			response.setStatus(HttpServletResponse.SC_OK);
			
			int maxFileSize = 1024*1024*1024; //최대 파일 크기
			String location = "C:\\files"; //파일을 저장할 폴더 위치
			String encoding = "UTF-8"; //인코딩 형식
			//파일 저장
			MultipartRequest multi = new MultipartRequest(
				request, location, maxFileSize, encoding, new DefaultFileRenamePolicy());
		
			// File 이외의 input 값 받아오기
			Enumeration params=multi.getParameterNames();
			String imgCateV = null;
			String songDescV = null;
			String imgnameV = null;
			String imgDescV = null;
		
		
			while(params.hasMoreElements()){
				String name=(String)params.nextElement();//전송되는 파라미터 이름
				String value=multi.getParameter(name);//전송되는 파라미터 값
				if (name.equals("imgName")) {
					imgnameV = value;
					System.out.println(name+"="+imgnameV);}
				else if (name.equals("imgDesc")) {
					imgDescV = value;
					System.out.println(name+"="+imgDescV);}
				else if (name.equals("songDesc")) {
					songDescV = value;
					System.out.println(name+"="+songDescV);}
				else if (name.equals("imgCate")) {
					imgCateV = value;
					System.out.println(name+"="+imgCateV);}
			}
			// 이미지 파일 저장
			File imgfile = multi.getFile("imgLoadDB");		
			FileInputStream imgfin = new FileInputStream(imgfile);
			
			//이미지파일 이름과 경로 구하기
			String imgfilename = multi.getFilesystemName("imgLoadDB");
			String imgpath = "./song/" + imgfilename;
			System.out.println(imgfilename);
			System.out.println(imgpath);
			
			// 이전 페이지에서 검색했던 음악의 아이디와 이름 가져오기
			String songnameV = (String) session.getAttribute("songKeyword");
			int songId = (int) session.getAttribute("songId");
		
			DBUtil.saveimg(conn, imgnameV, imgpath, imgfin, imgCateV);
			int imgId = DBUtil.callImgId(conn, imgnameV);
		
			System.out.print(imgId);
			DBUtil.savepair(conn, songnameV, songDescV, imgnameV, imgDescV, userid, imgId, songId);
			
		
			System.out.println(("Inserting Successfully!"));
			conn.close();
		
			// 첫번째 페이지로 돌아감
			out.println("<script>");
			out.println("alert('SUCCESS');");
			out.println("location.href='select.html';");
			out.println("</script>");
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
