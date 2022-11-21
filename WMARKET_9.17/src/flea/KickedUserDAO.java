package flea;

import java.sql.*;

public class KickedUserDAO {
	
	private Connection conn;
    private ResultSet rs;

    //기본 생성자
    public KickedUserDAO() { //DB연결 초기화
        try {
            String dbURL = "jdbc:mysql://192.168.55.162:3306/FleaMarket";
            String dbID = "root";
            String dbPassword = "1234";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // 이용정지
    public int kickUser(String id, String reason) {
    	String sql = "insert into kickedUser values (?, ?)";
    	try {
    		PreparedStatement stmt = conn.prepareStatement(sql);
    		stmt.setString(1, id);
    		stmt.setString(2, reason);
    		return stmt.executeUpdate();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return -1;	// db오류
    }
    
    // id조회
    public boolean findID(String id) {
    	try {
    		Statement stmt = conn.createStatement();
    		rs = stmt.executeQuery("select * from kickedUser where id='"+id+"'");
    				
    		if(rs.next()) {
    			return true;
    		} else {
    			return false;
    		}
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return false;
    }
    
    // 정지해제
    public int kickOff(String id) {
    	String sql = "delete from kickedUser where id='"+id+"'";
    	try {
    		PreparedStatement stmt = conn.prepareStatement(sql);
    		return stmt.executeUpdate();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return -1;	// db오류
    }
    
	public String getReason(String id) {
		String sql = "select reason from kickedUser where id='"+id+"'";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //db 오류
	}
}
