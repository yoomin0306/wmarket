package flea;
import java.security.CryptoPrimitive;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.*;

public class UserDAO {
	
	private Connection conn;
    private ResultSet rs;
	
	public UserDAO() {
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
	
	public void insert(String id, String pw, String name, String address, String phone) throws NoSuchAlgorithmException {
		
		Sha256 sha256 = new Sha256();
		String cryptogram = sha256.encrypt(pw);
		
		try{
			Statement stmt = conn.createStatement();
			stmt.executeUpdate("insert into user (id, pw, name, address, phone) values ('"+id+"','"+cryptogram+"', '"+name+"', '"+address+"', '"+phone+"')");
			
			stmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public boolean login(String id, String pw) throws NoSuchAlgorithmException {
		
		Sha256 sha256 = new Sha256();
		String cryptogram = sha256.encrypt(pw);
		
		try{
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from user where id = '"+id+"' and pw = '"+cryptogram+"'");
			
			if(rs.next()) {
                return true;
            } else {
            	return false;
            }
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
	public ArrayList<UserVO> getUserList() {
		String sql = "select * from user";
		ArrayList<UserVO> list = new ArrayList<UserVO>();
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				UserVO vo = new UserVO();
				vo.setId(rs.getString(1));
				vo.setPw(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setAddress(rs.getString(4));
				vo.setPhone(rs.getString(5));
				vo.setAccount(rs.getString(6));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//이름 조회
	public String getName(String id) {
		String sql = "select name from user where id='"+id+"'";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				return rs.getString(1);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //db오류
	}
	
	public String getIdByName(String name) {
		String sql = "select id from user where name='"+name+"'";
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				return rs.getString(1);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //db오류
	}
	
	
	//회원정보수정
		public void update(String id, String pw, String name, String address, String phone) throws NoSuchAlgorithmException {
			
			Sha256 sha256 = new Sha256();
			String cryptogram = sha256.encrypt(pw);
			
			try{
				Statement stmt = conn.createStatement();
				stmt.executeUpdate("update user set pw='"+cryptogram+"', name='"+name+"', address='"+address+"', phone='"+phone+"' where id='"+id+"'");
				
				stmt.close();
				conn.close();
				
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		public String account(String id) {
			String sql = "select account from user where id='"+id+"'";
			try {
				PreparedStatement stmt = conn.prepareStatement(sql);
				rs = stmt.executeQuery(sql);
				if(rs.next()) {
					return rs.getString(1);
				}
				
			}catch (Exception e) {
				e.printStackTrace();
			}
			return ""; //db오류
		}
		
		public int inOut(String id, String account) {
			
			String sql = "update user set account='"+account+"' where id='"+id+"'";
			try {
				PreparedStatement stmt = conn.prepareStatement(sql);
				return stmt.executeUpdate();
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //db 오류
		}
}
