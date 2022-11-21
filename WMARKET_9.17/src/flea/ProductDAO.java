package flea;
import java.sql.*;
import java.util.*;

public class ProductDAO {
	
	private Connection conn;
    private ResultSet rs;

    //기본 생성자
    public ProductDAO() { //DB연결 초기화
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
	
	public String getDate_a() {
		String sql = "select now()";
		try{
			PreparedStatement stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				return rs.getString(1);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";	//데이터베이스 오류
	}
	
	public String getDate_b(String date_b) {
        String sql = "select date_add(now(), interval "+date_b+")";
        try{
            PreparedStatement stmt = conn.prepareStatement(sql);
            System.out.println(sql);
            rs = stmt.executeQuery(sql);
            if(rs.next()) {
                return rs.getString(1);
            }

        }catch(Exception e){
            e.printStackTrace();
        }
        return "";    //데이터베이스 오류
    }
	
	public int getDateDiff(String date_b) {
		String sql = "select timestampdiff(second, '"+getDate_a()+"', '"+date_b+"')";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				return rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0; //db 오류
	}
	
	public String getPeriod(String date_b) {
		
		int second = getDateDiff(date_b);
		int minute = second/60;
		int hour = minute/60;
		int day = hour/24;
		int restHour = hour%24;
		int restMin = minute%60;
		int restSec = second%60;
		String period = "";
		
		if (hour < 1) {
			period = Integer.toString(restMin) + "분 " + Integer.toString(restSec) + "초 ";
		}else if (day < 1) {
		period = Integer.toString(restHour) + "시간 " + Integer.toString(restMin) + "분 ";
		}else {
			period = Integer.toString(day) + "일 " + Integer.toString(restHour) + "시간 ";
		}
		
		return period;
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
	
	public int upload(String id, String pName, String image, String pExplain, String pCondition, String price, String date_b) {
		String sql = "insert into product values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, getNext());
			stmt.setString(2, id);
			stmt.setString(3, getDate_a());
			stmt.setString(4, pName);
			stmt.setString(5, image);
			stmt.setString(6, pExplain);
			stmt.setString(7, pCondition);
			stmt.setString(8, price);
			stmt.setString(9, getDate_b(date_b));
			stmt.setInt(10, 1); //글의 유효번호
			return stmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	// 상품조회 (마감상품 제외)
	public ArrayList<ProductVO> getList(){
        String sql = "select * from product where pNumber < ? and available = 1 order by pNumber desc";
        ArrayList<ProductVO> list = new ArrayList<ProductVO>();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, getNext());
            rs = stmt.executeQuery();
            while(rs.next()) {
                ProductVO vo = new ProductVO();
                vo.setpNumber(rs.getInt(1));
                vo.setId(rs.getString(2));
                vo.setDate_a(rs.getString(3));
                vo.setpName(rs.getString(4));
                vo.setImage(rs.getString(5));
                vo.setpExplain(rs.getString(6));
                vo.setpCondition(rs.getString(7));
                vo.setPrice(rs.getString(8));
                vo.setDate_b(rs.getString(9));
                list.add(vo);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
	
	// 마감상품조회
	public ArrayList<ProductVO> getFinishedList(){
        String sql = "select * from product where pNumber < ? and available = 0 order by pNumber desc";
        ArrayList<ProductVO> list = new ArrayList<ProductVO>();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, getNext());
            rs = stmt.executeQuery();
            while(rs.next()) {
                ProductVO vo = new ProductVO();
                vo.setpNumber(rs.getInt(1));
                vo.setId(rs.getString(2));
                vo.setDate_a(rs.getString(3));
                vo.setpName(rs.getString(4));
                vo.setImage(rs.getString(5));
                vo.setpExplain(rs.getString(6));
                vo.setpCondition(rs.getString(7));
                vo.setPrice(rs.getString(8));
                vo.setDate_b(rs.getString(9));
                list.add(vo);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
	
	public ArrayList<ProductVO> getList(String id){
        String sql = "select * from product where pNumber < ? and id ='"+id+"'and available = 1 order by pNumber desc";
        ArrayList<ProductVO> list = new ArrayList<ProductVO>();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, getNext());
            rs = stmt.executeQuery();
            while(rs.next()) {
                ProductVO vo = new ProductVO();
                vo.setpNumber(rs.getInt(1));
                vo.setId(rs.getString(2));
                vo.setDate_a(rs.getString(3));
                vo.setpName(rs.getString(4));
                vo.setImage(rs.getString(5));
                vo.setpExplain(rs.getString(6));
                vo.setpCondition(rs.getString(7));
                vo.setPrice(rs.getString(8));
                vo.setDate_b(rs.getString(9));
                list.add(vo);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
	
	public ArrayList<ProductVO> getClosedList(String id){
        String sql = "select * from product where pNumber < ? and id ='"+id+"'and available = 0 order by pNumber desc";
        ArrayList<ProductVO> list = new ArrayList<ProductVO>();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, getNext());
            rs = stmt.executeQuery();
            while(rs.next()) {
                ProductVO vo = new ProductVO();
                vo.setpNumber(rs.getInt(1));
                vo.setId(rs.getString(2));
                vo.setDate_a(rs.getString(3));
                vo.setpName(rs.getString(4));
                vo.setImage(rs.getString(5));
                vo.setpExplain(rs.getString(6));
                vo.setpCondition(rs.getString(7));
                vo.setPrice(rs.getString(8));
                vo.setDate_b(rs.getString(9));
                list.add(vo);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
	
	public ArrayList<ProductVO> getBidList(String id){
        String sql = "select b.pNumber, p.id, pName, image, pExplain, pCondition, price, Max(bidPrice) as bidPrice, date_a, date_b " + 
        		"from product p left join bid b " + 
        		"on p.pNumber = b.pNumber " + 
        		"where b.pNumber < ? and b.id = '"+id+"' and available = 1 Group by pNumber";
        ArrayList<ProductVO> list = new ArrayList<ProductVO>();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, getNext());
            rs = stmt.executeQuery();
            while(rs.next()) {
                ProductVO vo = new ProductVO();
                vo.setpNumber(rs.getInt(1));
                vo.setId(rs.getString(2));
                vo.setpName(rs.getString(3));
                vo.setImage(rs.getString(4));
                vo.setpExplain(rs.getString(5));
                vo.setpCondition(rs.getString(6));
                vo.setPrice(rs.getString(7));
                vo.setBidPrice(rs.getString(8));
                vo.setDate_a(rs.getString(9));
                vo.setDate_b(rs.getString(10));
                list.add(vo);
            }
        }catch (Exception e) {
            e.printStackTrace();
            
        }
        return list;
    }
	//마감된 상품(available = 0)도 볼 수 있게함
	public ArrayList<ProductVO> getClosedBidList(String id){
        String sql = "select b.pNumber, p.id, pName, image, pExplain, pCondition, price, Max(bidPrice) as bidPrice, date_a, date_b " + 
        		"from product p left join bid b " + 
        		"on p.pNumber = b.pNumber " + 
        		"where b.pNumber < ? and b.id = '"+id+"' and available = 0 Group by pNumber";
        ArrayList<ProductVO> list = new ArrayList<ProductVO>();
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, getNext());
            rs = stmt.executeQuery();
            while(rs.next()) {
                ProductVO vo = new ProductVO();
                vo.setpNumber(rs.getInt(1));
                vo.setId(rs.getString(2));
                vo.setpName(rs.getString(3));
                vo.setImage(rs.getString(4));
                vo.setpExplain(rs.getString(5));
                vo.setpCondition(rs.getString(6));
                vo.setPrice(rs.getString(7));
                vo.setBidPrice(rs.getString(8));
                vo.setDate_a(rs.getString(9));
                vo.setDate_b(rs.getString(10));
                list.add(vo);
            }
        }catch (Exception e) {
            e.printStackTrace();
            
        }
        return list;
    }
	
	//하나의 게시글을 보는 메소드
	public ProductVO getProduct(int pNumber) {
		String sql = "select * from product where pNumber = ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, pNumber);
			rs = stmt.executeQuery();
			if(rs.next()) {
				ProductVO vo = new ProductVO();
				vo.setpNumber(rs.getInt(1));
                vo.setId(rs.getString(2));
                vo.setDate_a(rs.getString(3));
                vo.setpName(rs.getString(4));
                vo.setImage(rs.getString(5));
                vo.setpExplain(rs.getString(6));
                vo.setpCondition(rs.getString(7));
                vo.setPrice(rs.getString(8));
                vo.setDate_b(rs.getString(9));
				return vo;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//상품 삭제 메소드
	public int delProduct(int pNumber) {
		//product 삭제
		String sql = "delete from product where pNumber = ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, pNumber);
			return stmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delBid(int pNumber) {
		//bid 삭제
		String sql = "delete from bid where pNumber = ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, pNumber);
			return stmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//상품 삭제 메소드 (id)
	public int delProduct(String id) {
		//product 삭제
		String sql = "delete from product where id = ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			return stmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}