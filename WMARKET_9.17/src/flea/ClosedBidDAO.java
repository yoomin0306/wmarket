package flea;

import java.sql.*;
import java.util.ArrayList;

public class ClosedBidDAO {
	
	private Connection conn;
    private ResultSet rs;

    //기본 생성자
    public ClosedBidDAO() { //DB연결 초기화
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
    
	public ClosedBidVO getList(int pNumber){
        String sql = "select * from closedbid where pNumber='"+pNumber+"'";
        ClosedBidVO closedBidVO = new ClosedBidVO();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                closedBidVO.setpNumber(rs.getInt(1));
                closedBidVO.setBidMaxID(rs.getString(2));
                closedBidVO.setBidMaxPrice(rs.getInt(3));
                closedBidVO.setTakeProfit(rs.getInt(4));
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return closedBidVO;
    }
	
	public int takeProfit(int pNumber) {	// 낙찰가 수령
		String sql = "update closedbid set takeProfit=1 where pNumber='"+pNumber+"'";	// takeProfit을 1로 수정
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			return stmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //db 오류
	}
}
