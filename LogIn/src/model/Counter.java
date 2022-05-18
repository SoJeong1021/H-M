package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Counter {
   private static int dbcount;

   public static synchronized int getCount(String sessionid, String sessionpair) {
      
   try {
      
      Connection con =  DriverManager.getConnection("jdbc:mysql://localhost:3306/test?serverTimezone=UTC", "root", "04090118aa");   
      
      Statement st = con.createStatement();
      ResultSet rs = st.executeQuery("SELECT * FROM test.boardfunction WHERE userID='" + sessionid +"' and board_num='" + sessionpair +"'");
      while(rs.next()) {
         dbcount = rs.getInt("count");
         dbcount++;
         }
   }catch(SQLException e) {
      e.printStackTrace();
   }
   return dbcount;
   }
}