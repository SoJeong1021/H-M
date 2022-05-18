package model;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.multipart.*;
import com.oreilly.servlet.*;


/**
 * Servlet implementation class imggg
 */
@WebServlet("/writeNewDo")
public class writeNewDo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public writeNewDo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
		//DB 연결
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		HttpSession session = request.getSession();
		String userid = (String)session.getAttribute("id");
		
		response.setContentType("text/html; charset=UTF-8");
		response.setStatus(HttpServletResponse.SC_OK);
		
		//크기, 위치, 형식 지정
		int maxFileSize = 1024*1024*512; //최대 파일 크기
		String location = "C:\\웹정보시스템\\WebContent\\song"; //파일을 저장할 폴더 위치
		String encoding = "UTF-8"; //인코딩 형식
		
		//파일 저장을 위한 객체
		MultipartRequest multi = new MultipartRequest(
		request, location, maxFileSize, encoding, new DefaultFileRenamePolicy());
		
		// File 이외의 input 값을 받을 곳
		Enumeration params=multi.getParameterNames();
		String songCateV = null;
		String imgnameV = null;
		String songDescV = null;
		String imgCateV = null;
		String songnameV = null;
		String imgDescV = null;
		
		while(params.hasMoreElements()){
			String name=(String)params.nextElement();//전송되는 파라미터 이름
			String value=multi.getParameter(name);//그 파라미터 값
			if (name.equals("imgName")) {
				imgnameV = value;
				System.out.println(name+"="+imgnameV);}
			else if (name.equals("songName")) {
				songnameV = value;
				System.out.println(name+"="+songnameV);}
			else if (name.equals("imgDesc")) {
				imgDescV = value;
				System.out.println(name+"="+imgDescV);}
			else if (name.equals("songDesc")) {
				songDescV = value;
				System.out.println(name+"="+songDescV);}
			else if (name.equals("imgCate")) {
				imgCateV = value;
				System.out.println(name+"="+imgCateV);}
			else if (name.equals("songCate")) {
				songCateV = value;
				System.out.println(name+"="+songCateV);}
		}
		
		//해당 위치에 이미지 파일 저장
		File imgfile = multi.getFile("imgLoadDB");
		FileInputStream imgfin = new FileInputStream(imgfile);
		
		//해당 위치에 음악 파일 저장
		File songfile = multi.getFile("songLoadDB");
		FileInputStream songfin = new FileInputStream(songfile);
		
		//이미지파일 이름과 경로 구하기
		String imgfilename = multi.getFilesystemName("imgLoadDB");
		String imgpath = "./song/" + imgfilename;
		System.out.println(imgfilename);
		System.out.println(imgpath);
		
		//음악파일 이름과 경로 구하기
		String songfilename = multi.getFilesystemName("songLoadDB");
		String songpath = "./song/" + songfilename;
		System.out.println(songfilename);
		System.out.println(songpath);
		
		// 각각 디비에  파일과 경로 저장
		DBUtil.saveimg(conn, imgnameV, imgpath, imgfin, imgCateV);
		DBUtil.savesong(conn, songnameV, songpath, songCateV);
		// 저장 후 고유 번호를 받아옴
		int imgId = DBUtil.callImgId(conn, imgnameV);
		int songId = DBUtil.callSongId(conn, songnameV);
		// 고유번호와 함께 게시물의 설명, 작성한 사람의 ID를 게시글 디비에 저장
		DBUtil.savepair(conn, songnameV, songDescV, imgnameV, imgDescV, userid, imgId, songId);
		
		System.out.println(("Inserting Successfully!"));
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
		}
		RequestDispatcher view = request.getRequestDispatcher("MainPage.jsp");
		 view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
