package flea;

import java.sql.*;
import java.util.*;

public class ReportDAO {
	private Connection conn;
    private ResultSet rs;
    
    
    //기본 생성자
    public ReportDAO() { //DB연결 초기화
        try {
            String dbURL = "jdbc:mysql://localhost:3306/FleaMarket";
            String dbID = "root";
            String dbPassword = "1234";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public ArrayList<ReportVO> getReportList() {
    	String sql = "select * from report";
    	ArrayList<ReportVO> list = new ArrayList<ReportVO>();
    	try {
    		PreparedStatement stmt = conn.prepareStatement(sql);
    		rs = stmt.executeQuery();
    		while(rs.next()) {
    			ReportVO vo = new ReportVO();
    			vo.setpNumber(rs.getInt(1));
    			vo.setReporter(rs.getString(2));
    			vo.setCategory(rs.getString(3));
    			vo.setReason(rs.getString(4));
    			list.add(vo);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return list;
    }
    
    public int report(int pNumber, String reporter, String category, String reason) {
    	String sql = "insert into report values (?, ?, ?, ?)";
    	try {
    		PreparedStatement stmt = conn.prepareStatement(sql);
    		stmt.setInt(1, pNumber);
    		stmt.setString(2, reporter);
    		stmt.setString(3, category);
    		stmt.setString(4, reason);
    		return stmt.executeUpdate();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return -1;	// db오류
    }
}
