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
		//DB ����
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		HttpSession session = request.getSession();
		String userid = (String)session.getAttribute("id");
		
		response.setContentType("text/html; charset=UTF-8");
		response.setStatus(HttpServletResponse.SC_OK);
		
		//ũ��, ��ġ, ���� ����
		int maxFileSize = 1024*1024*512; //�ִ� ���� ũ��
		String location = "C:\\�������ý���\\WebContent\\song"; //������ ������ ���� ��ġ
		String encoding = "UTF-8"; //���ڵ� ����
		
		//���� ������ ���� ��ü
		MultipartRequest multi = new MultipartRequest(
		request, location, maxFileSize, encoding, new DefaultFileRenamePolicy());
		
		// File �̿��� input ���� ���� ��
		Enumeration params=multi.getParameterNames();
		String songCateV = null;
		String imgnameV = null;
		String songDescV = null;
		String imgCateV = null;
		String songnameV = null;
		String imgDescV = null;
		
		while(params.hasMoreElements()){
			String name=(String)params.nextElement();//���۵Ǵ� �Ķ���� �̸�
			String value=multi.getParameter(name);//�� �Ķ���� ��
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
		
		//�ش� ��ġ�� �̹��� ���� ����
		File imgfile = multi.getFile("imgLoadDB");
		FileInputStream imgfin = new FileInputStream(imgfile);
		
		//�ش� ��ġ�� ���� ���� ����
		File songfile = multi.getFile("songLoadDB");
		FileInputStream songfin = new FileInputStream(songfile);
		
		//�̹������� �̸��� ��� ���ϱ�
		String imgfilename = multi.getFilesystemName("imgLoadDB");
		String imgpath = "./song/" + imgfilename;
		System.out.println(imgfilename);
		System.out.println(imgpath);
		
		//�������� �̸��� ��� ���ϱ�
		String songfilename = multi.getFilesystemName("songLoadDB");
		String songpath = "./song/" + songfilename;
		System.out.println(songfilename);
		System.out.println(songpath);
		
		// ���� ���  ���ϰ� ��� ����
		DBUtil.saveimg(conn, imgnameV, imgpath, imgfin, imgCateV);
		DBUtil.savesong(conn, songnameV, songpath, songCateV);
		// ���� �� ���� ��ȣ�� �޾ƿ�
		int imgId = DBUtil.callImgId(conn, imgnameV);
		int songId = DBUtil.callSongId(conn, songnameV);
		// ������ȣ�� �Բ� �Խù��� ����, �ۼ��� ����� ID�� �Խñ� ��� ����
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
