package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//import admin.complaint.ComplaintVO;
//import admin.review.ReviewVO;
import common.GetConn;

public class AdminDAO {
	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {}
		}
	}
	
	public void rsClose() {
		if(rs != null) {
			try {
				rs.close();
			} catch (Exception e) {} 
			finally {
				pstmtClose();
			}
		}
	}

	// 오늘 접속아이피 저장 되었는지 확인(같은 ip는 한번만 저장&count 하기 위한부분)
	public VisitorVO getSearchVisitIp(String visitIp) {
		VisitorVO vo = new VisitorVO();
		try {
			sql = "select * from visitors where visitIp = ? and visitTime = date_format(now(),'%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, visitIp);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setVisitTime(rs.getString("visitTime"));
				vo.setVisitIp(rs.getString("visitIp"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			rsClose();
		}
		
		return vo;
	}

	// 오늘 처음 방문이면 count하고 db에 저장하기
	public int setVisitorInsert(String visitIp) {
		int res = 0;
		try {
			sql = "insert into visitors values (default, date_format(now(),'%Y-%m-%d'), ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, visitIp);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 총 방문자수
	public int getTotalVisitors() {
		int count = 0;
		try {
			sql = "select count(*) as count from visitors";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			count = rs.getInt("count");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			rsClose();
		}
		return count;
	}
	
	// 총 방문자수
	public int getTodayVisitors() {
		int count = 0;
		try {
			sql = "select count(*) as count from visitors where visitTime = date_format(now(),'%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			count = rs.getInt("count");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			rsClose();
		}
		return count;
	}
	
	
}