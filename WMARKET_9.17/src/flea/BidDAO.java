package flea;

import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;

public class BidDAO {

	private Connection conn;
    private ResultSet rs;

    //기본 생성자
    public BidDAO() {
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
    
	public int getNext() {
		String sql = "select pNumber from product order by pNumber desc";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물인 경우
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 	//데이터베이스 오류
	}
    
    public int bid(String id, int pNumber, String bidPrice) {
    	String sql = "insert into bid values(?, ?, ?, ?)";
    	try {
    		PreparedStatement stmt = conn.prepareStatement(sql);
    		stmt.setString(1, id);
    		stmt.setInt(2, pNumber);
    		stmt.setString(3, bidPrice);
    		stmt.setInt(4, 0);
    		return stmt.executeUpdate();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return -1; //db오류
    }
    
    public int delBid(String id, int pNumber) {		//id랑 pNumber가 같은 행 삭제
    	String sql = "delete from bid where id='"+id+"' and pNumber="+pNumber+"";
    	try {
    		PreparedStatement stmt = conn.prepareStatement(sql);
    		return stmt.executeUpdate();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return -1; //db오류
    }
    
    
    public String bidMaxPrice(String id, int pNumber) {		//id랑 pNumber가 같은 행 중 최댓값 select
    	String bidMaxPrice = "";
    	String sql = "select max(bidPrice) from bid where id='"+id+"' and pNumber="+pNumber+"";
    	try {	
    		PreparedStatement stmt = conn.prepareStatement(sql);
    		rs = stmt.executeQuery();
    		if(rs.next()) {
    			bidMaxPrice = rs.getString(1);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return bidMaxPrice;		//최댓값 반환
    }
    
    
    public String bidMaxPrice(int pNumber) {
        String bidMaxPrice = "";
        String sql = "select pNumber, IFNULL(Max(bidPrice),'0') as Max_bidPrice from bid where pNumber = "+pNumber+"";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            if(rs.next()) {
                bidMaxPrice = rs.getString("Max_bidPrice");

                if(bidMaxPrice.equals("0")) {
                    ResultSet rs2 = stmt.executeQuery("select price from product where pNumber = "+pNumber+"");
                    if(rs2.next()) {
                        bidMaxPrice = rs2.getString("price");
                    }
                }
            }

        } catch (Exception e) {
            bidMaxPrice = "실패";
            e.printStackTrace();

        }
        return bidMaxPrice;
    }
    
    
    public int countBid(int pNumber) {
    	int count = 0;
    	String sql = "select count(*) from bid where pNumber='"+pNumber+"'";
    	try {
    		PreparedStatement stmt = conn.prepareStatement(sql);
    		rs = stmt.executeQuery();
    		if(rs.next()) {
    			count = rs.getInt(1);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return count;
    }
    
    
    public boolean bidCheck(String id, int pNumber) {
    	String sql = "select * from bid where id = '"+id+"' and pNumber = "+pNumber+"";
    	try {
    		PreparedStatement stmt = conn.prepareStatement(sql);
    		rs = stmt.executeQuery();
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
    
    
    public int refCheck(String id, int pNumber) {
    	int result = 0;
    	String sql = "select refund from bid where id = '"+id+"' and pNumber = "+pNumber+"";
    	try {
    		PreparedStatement stmt = conn.prepareStatement(sql);
    		rs = stmt.executeQuery();
    		if(rs.next()) {
    			result = rs.getInt(1);
    		}
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return result;
    }
    
	public int refund(String id, int pNumber) {	// 입찰가 환불
		String sql = "update bid set refund=1 where id = '"+id+"' and pNumber='"+pNumber+"'";	// refund를 1로 수정
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			return stmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //db 오류
	}
	
	//입찰 조회
	public ArrayList<BidVO> getList(int pNumber) {
		String sql = "select * from bid where pNumber = '"+pNumber+"'";
		ArrayList<BidVO> list = new ArrayList<BidVO>();
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				BidVO vo = new BidVO();
				vo.setId(rs.getString(1));
				vo.setpNumber(rs.getInt(2));
				vo.setBidPrice(rs.getString(3));
				vo.setRefund(rs.getInt(4));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
