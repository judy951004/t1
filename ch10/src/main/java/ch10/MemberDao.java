package ch10;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.sql.*;
import javax.naming.*;
import javax.security.auth.message.callback.PrivateKeyCallback.Request;

public class MemberDao {
	//singleton
	private static MemberDao instance = new MemberDao();
	private MemberDao() {} //외부에서 객체 생성 금지
	public static MemberDao getInstance() {
		return instance;
	}
	// DB연결
	private Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		}catch(Exception e) {
			System.out.println("연결에러 : "+e.getMessage());
		}
		return conn;
	}
	public int confirm(String id) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// 중복체크 할 때는 같은 아이디가 있으면 안되므로 del을 체크할 필요가 없다 
		String sql = "select id from member2 where id=?";
		Connection conn = getConnection(); //getConnection()을 불러와라 
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); 
			if(rs.next()) result = 1; //성공 : 해당하는 id를 읽었다 
			else result = 0; //실패 : 해당하는 id가 없다 
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {}
		}
		return result;
	}
	public int insert(Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		// 초기에는 전부 다 삭제 안된 상태 (del='n')
		String sql = "insert into member2 values(?,?,?,?,?,sysdate,'n')";
		Connection conn = getConnection(); //getConnection()을 불러와라 
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getAddress());
			pstmt.setString(5, member.getTel());
			result = pstmt.executeUpdate(); 
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {}
		}
		return result;
	}
	public int loginChk(String id, String password) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// 삭제된 사용자는 로그인 할 수 없다 
		String sql = "select password from member2 where id=? and del != 'y'";
		Connection conn = getConnection(); //getConnection()을 불러와라 
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				String dbPass = rs.getString("password");
				if(password.equals(dbPass)) result = 1; //암호, id 일치
				else result = 0; //id는 있으나 틀린 암호
			}
			else result = -1; //없는 id
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {}
		}
		return result;
	}
	public Member select(String id) {
		Member member = new Member();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// 삭제된 아이디는 조회되지 않도록 한다
		String sql = "select * from member2 where id=? and del != 'y'";
		Connection conn = getConnection(); //getConnection()을 불러와라 
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				member.setId(rs.getString("id"));
				member.setPassword(rs.getString("password"));
				member.setName(rs.getString("name"));
				member.setAddress(rs.getString("address"));
				member.setTel(rs.getString("tel"));
				member.setReg_date(rs.getDate("reg_date"));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {}
		}
		return member;
	}
	public int update(Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = "update member2 set password=?, name=?, address=?, tel=? where id=?";
		Connection conn = getConnection(); //getConnection()을 불러와라 
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(5, member.getId());
			pstmt.setString(1, member.getPassword());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getAddress());
			pstmt.setString(4, member.getTel());
			result = pstmt.executeUpdate(); 
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {}
		}
		return result;
	}
	public int delete(String id) {
		int result = 0;
		PreparedStatement pstmt = null;
//		String sql = "delete from member2 where id=?";
		String sql = "update member2 set del='y' where id=?";
		Connection conn = getConnection(); //getConnection()을 불러와라 
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);		
			result = pstmt.executeUpdate(); 
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {}
		}
		return result;
	}
	public List<Member> list() {
		List<Member> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// 삭제된 아이디는 조회되지 않도록 한다
		String sql = "select * from member2 order by reg_date desc";
		Connection conn = getConnection(); //getConnection()을 불러와라 
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			while(rs.next()) {
				Member member = new Member();
				member.setId(rs.getString("id"));
				member.setPassword(rs.getString("password"));
				member.setName(rs.getString("name"));
				member.setAddress(rs.getString("address"));
				member.setTel(rs.getString("tel"));
				member.setReg_date(rs.getDate("reg_date"));
				member.setDel(rs.getString("del"));
				
				list.add(member);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {}
		}
		return list;
	}
}
