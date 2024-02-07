package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn;
	//private PreparedStatement pstmt;
	//PreparedStatement은 각 함수내에 선언하는게 좋다.
	//각각의 SQL쿼리를 독립적으로 관리.
	private ResultSet rs;
	
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mariadb://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "root";
			//driver는 mariaDB에 접속할 수 있도록 매개체 역할을 함.
			Class.forName("org.mariadb.jdbc.Driver");
			//접속이 완료되면 conn객체안에 접속정보가 담기게 된다.
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String sql = "SELECT NOW()"; //CURDATE()는 현재 날짜 반환함.
		try {
			//SQL문장을 실행 준비단계로 만들어줌.
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);//현재 날짜 반환
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	
	
	public int getNext() {
		String sql = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; //CURDATE()는 현재 날짜 반환함.
		try {
			//SQL문장을 실행 준비단계로 만들어줌.
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //첫번째 게시물인 경우.
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String sql = "INSERT INTO BBS VALUES (?,?,?,?,?,?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1); //bbsAvailable 1 넣음.
			//insert는 executeUpdate
			
			return pstmt.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	
	//페이지에 맞게 list를 보여줌
	public ArrayList<Bbs> getList(int pageNumber){
		String sql = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			//SQL문장을 실행 준비단계로 만들어줌.
			PreparedStatement pstmt = conn.prepareStatement(sql);
			//setInt(파라미터인덱스,int x); : 인덱스에 x를 set해준다.
			pstmt.setInt(1,getNext()-(pageNumber - 1)*10 );
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return list; //데이터베이스 오류
	}
	
	//페이징 처리를 위한 다음페이지 유무
	public boolean nextPage(int pageNumber) {
		String sql = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		try {
			//SQL문장을 실행 준비단계로 만들어줌.
			PreparedStatement pstmt = conn.prepareStatement(sql);
			//setInt(파라미터인덱스,int x); : 인덱스에 x를 set해준다.
			pstmt.setInt(1,getNext()-(pageNumber - 1)*10 );
			rs = pstmt.executeQuery();
			//결과가 하나라도 존재한다면 true를 반환
			if(rs.next()) {
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return false; 
	}
	
	//특정 ID에 해당하는 게시글을 가져오는 함수
	public Bbs getBbs(int bbsID) {
		String sql = "SELECT * FROM BBS WHERE bbsID =?";
		try {
			//SQL문장을 실행 준비단계로 만들어줌.
			PreparedStatement pstmt = conn.prepareStatement(sql);
			//setInt(파라미터인덱스,int x); : 인덱스에 x를 set해준다. 
			pstmt.setInt(1,bbsID);
			rs = pstmt.executeQuery();
			//bbs객체를 만들어서 data들을 set해주고 bbs를 반환
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		//게시글이 없으면 null반환
		return null; 
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String sql = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID=?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID); 
			
			return pstmt.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int delete(int bbsID) {
		String sql = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID=?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			
			return pstmt.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}
