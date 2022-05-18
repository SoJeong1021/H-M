package model;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {
	public static ResultSet findUser(Connection con, String uid) {
		String sqlSt = "SELECT passwd FROM user WHERE id=";

		Statement st;
		try {
			st = con.createStatement();

			if (st.execute(sqlSt + "'" + uid + "'")) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	   public static String findNick(Connection con, String uid) {
	         String sqlSt = "SELECT nickname FROM user WHERE id='" + uid + "'";
	         Statement st;
	         String nickname = null;
	         try {
	            st = con.createStatement();
	            ResultSet rs = st.executeQuery(sqlSt);
	            while (rs.next()) {
	            nickname = rs.getString("nickname");
	         
	            }         
	         } catch (SQLException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	         }
	         return nickname;      
	   }
	   public static String findNumber(Connection con, String uid) {
	         String sqlSt = "SELECT phone_number FROM user WHERE id='" + uid + "'";
	         Statement st;
	         String phone_number = null;
	         try {
	            st = con.createStatement();
	            ResultSet rs = st.executeQuery(sqlSt);
	            while (rs.next()) {
	            phone_number = rs.getString("phone_number");
	         
	            }         
	         } catch (SQLException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	         }
	         return phone_number;      
	   }
	   public static String findName(Connection con, String uid) {
	         String sqlSt = "SELECT name FROM user WHERE id='" + uid + "'";
	         Statement st;
	         String name = null;
	         try {
	            st = con.createStatement();
	            ResultSet rs = st.executeQuery(sqlSt);
	            while (rs.next()) {
	            name = rs.getString("name");
	         
	            }         
	         } catch (SQLException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	         }
	         return name;      
	   }
	public static ResultSet checkID(Connection con, String uid) {
		String sqlSt = "SELECT passwd FROM user WHERE id=";

		Statement st;
		try {
			st = con.createStatement();

			if (st.execute(sqlSt + "'" + uid + "'")) {
				return st.getResultSet();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	 public static String checkfindID(Connection con, String uname) {
         String sqlSt = "SELECT phone_number FROM user WHERE name='" + uname + "'";
         Statement st;         
         
         String dbphone = null;
         try {
        	 st = con.createStatement();
        	 ResultSet rs = st.executeQuery(sqlSt);
        	 while (rs.next()) {
            	dbphone = rs.getString("phone_number");
            }       
        	
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
         return dbphone;
   }
	//이미지디비에 이미지 파일 저장
		public static void saveimg(Connection conn, String imgnameV, String path, FileInputStream fin, String imgCateV) throws SQLException {
			PreparedStatement imgpre = conn.prepareStatement("insert into imgg (FILENAME,imgpath, FILE, imgCate) VALUES (?,?,?,?)");
			imgpre.setString(1,imgnameV);
			imgpre.setString(2, path);
			imgpre.setBlob(3,fin);
			imgpre.setString(4,imgCateV);
			imgpre.executeUpdate();
			imgpre.close();
		}
		
		//음악디비에 음악 파일 저장
		public static void savesong(Connection conn, String songnameV, String path, String songCateV) throws SQLException {
			//검색에서 파일 찾기
			PreparedStatement songpre = conn.prepareStatement("insert into songg (FILENAME, songpath ,songCate) VALUES (?,?,?)");
			songpre.setString(1,songnameV);
			songpre.setString(2,path);
			songpre.setString(3,songCateV);
			songpre.executeUpdate();
			songpre.close();
		}
		//게시글디비에 음악,이미지,작성자 정보 저장
		public static void savepair(Connection conn, String songname, String songDesc, String imgname, String imgDesc, String userid, int imgid, int songid) throws SQLException {
			//검색에서 파일 찾기
			PreparedStatement pairpre = conn.prepareStatement("insert into pair (userid, imgid, imgName, imgDesc, songid, songName, songDesc) VALUES (?,?,?,?,?,?,?)");
			pairpre.setString(1,userid);
			pairpre.setInt(2, imgid);
			pairpre.setString(3,imgname);
			pairpre.setString(4, imgDesc);
			pairpre.setInt(5, songid);
			pairpre.setString(6,songname);
			pairpre.setString(7, songDesc);
			pairpre.executeUpdate();
			pairpre.close();
		}
		//이미지 고유 아이디 호출
		public static int callImgId(Connection conn, String filename) throws SQLException {
			int imgId = 0;
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("select * from imgg where FILENAME = '" + filename + "'");
			while(rs.next())
				imgId = rs.getInt("id");
			return imgId;
		}
		//음악 고유 아이디 호출
		public static int callSongId(Connection conn, String filename) throws SQLException {
			int songId = 0;
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("select * from songg where FILENAME = '" + filename + "'");
			while(rs.next())
				songId = rs.getInt("id");
			System.out.println(songId);
			return songId;
		}

}
