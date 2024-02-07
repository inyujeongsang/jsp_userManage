package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
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
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			//1.PreparedStatement에 정해진 SQL문장을 DB에 삽입해준다.
			//2.SQLinjection을 방어한다. userID가 존재하면 (1) userID를 ?자리에 넣어준다.
			//3.실행한 결과를 rs에 담아준다.
			//4.결과가 존재한다면 if문 안에 구문이 실행됨.
			//5.결과로 나온 userPassword를 받아서 접속을 시도한 userPassword와 동일한지 확인
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공을 반환.
				}
				else
					return 0; //비밀번호 불일치.
			}
			return -1; //id가 없음을 반환함.
		}catch(Exception e){
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}
	
	public int join(User user) {
		String sql = "INSERT INTO USER VALUES(?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			
			int result = pstmt.executeUpdate();
			if(result == 1) {
				return 0;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}
