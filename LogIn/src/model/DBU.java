package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class DBU {
	public int idcheck(String uid) {
		int rst = 0;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
	   con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
			
		String sql = "select * from user where id=?";
		ps = con.prepareStatement(sql);
		ps.setString(1, uid);
		rs = ps.executeQuery();
		if(rs.next()) {
			rst = 1;
			}
		}catch(Exception e) {
		e.printStackTrace();
		}finally { System.out.close();}
		return rst;
		}
	public int nickanamecheck(String nickname) {
		int rst = 0;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		try {
	   con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");
			
	   //String sqlSt = "select nickname from user where id=?";
	   String sqlSt = "select * from user where nickname=?";
	   ps = con.prepareStatement(sqlSt);
		ps.setString(1, nickname);
		rs = ps.executeQuery();
        while (rs.next()) {
        	rst=1;
        }   
		}catch(Exception e) {
		e.printStackTrace();
		}finally { System.out.close();}
		return rst;
		}
		}
		
