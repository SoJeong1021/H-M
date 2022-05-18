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
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class addSong
 */
@WebServlet("/addSong")
public class addSong extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addSong() {
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
		String userid = "SJ";
				//(String)session.getAttribute("id");
		
		response.setContentType("text/html; charset=UTF-8");
		response.setStatus(HttpServletResponse.SC_OK);
		
		int maxFileSize = 1024*1024*1024;
		String location = "C:\\WebProject\\WebContent";
		String encoding = "UTF-8"; 
		
		MultipartRequest multi = new MultipartRequest(
		request, location, maxFileSize, encoding, new DefaultFileRenamePolicy());
		
		// File �̿��� input ���� ���� ��
		Enumeration params=multi.getParameterNames();
		String songCateV = null;
		String songDescV = null;
		String songnameV = null;
		String imgDescV = null;
		
		
		while(params.hasMoreElements()){
			String name=(String)params.nextElement();//���۵Ǵ� �Ķ���� �̸�
			String value=multi.getParameter(name);//���۵Ǵ� �Ķ���� ��
			if (name.equals("songName")) {
				songnameV = value;
				System.out.println(name+"="+songnameV);}
			else if (name.equals("imgDesc")) {
				imgDescV = value;
				System.out.println(name+"="+imgDescV);}
			else if (name.equals("songDesc")) {
				songDescV = value;
				System.out.println(name+"="+songDescV);}
			else if (name.equals("songCate")) {
				songCateV = value;
				System.out.println(name+"="+songCateV);}
			else if (name.equals("songLoadDB")) {
				String path = location + "/" + multi.getFilesystemName("songLoadDB");
				System.out.println(path);
			}
		}
		
		//�ش� ��ġ�� ���� ����
		File songfile = multi.getFile("songLoadDB");
		FileInputStream songfin = new FileInputStream(songfile);
		
		//���� �̸� ���ϱ�	
		String songfilename = multi.getFilesystemName("songLoadDB");
		String songpath = "./song/" + songfilename;
		System.out.println(songfilename);
		System.out.println(songpath);
		
		//���� ���������� �˻��ߴ� �̹����� ���̵�� �̸� ��������
		String imgnameV = (String) session.getAttribute("imgKeyword");
		int imgId = (int) session.getAttribute("imgId");

		DBUtil.savesong(conn, songnameV, songpath, songCateV);
		
		int songId = DBUtil.callSongId(conn, songnameV);
		System.out.println(songId);
		
		DBUtil.savepair(conn, songnameV, songDescV, imgnameV, imgDescV, userid, imgId, songId);
			
		
		System.out.println(("Inserting Successfully!"));
		conn.close();
		
		// ù��° �������� ���ư�
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
