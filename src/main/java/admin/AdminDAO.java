package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import admin.complaint.ComplaintVO;
//import admin.complaint.ComplaintVO;
//import admin.review.ReviewVO;
import common.GetConn;
import member.MemberVO;

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

	//회원 전체/부분 리스트
	public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize, int level) {
		ArrayList<MemberVO> vos = new ArrayList<MemberVO>();
		try {
			if(level == 999) {
				sql = "select *, timestampdiff(day, lastDate, now()) as deleteDiff from member order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			else {
				sql = "select *, timestampdiff(day, lastDate, now()) as deleteDiff  from member where level = ? order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, level);
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			rs = pstmt.executeQuery();
			
			MemberVO vo = null;
			while(rs.next()) {
				vo = new MemberVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setNickName(rs.getString("nickName"));
				vo.setName(rs.getString("name"));
				vo.setGender(rs.getString("gender"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setTel(rs.getString("tel"));
				vo.setAddress(rs.getString("address"));
				vo.setEmail(rs.getString("email"));
				vo.setHomePage(rs.getString("homePage"));
				vo.setJob(rs.getString("job"));
				vo.setHobby(rs.getString("hobby"));
				vo.setPhoto(rs.getString("photo"));
				vo.setContent(rs.getString("content"));
				vo.setUserInfor(rs.getString("userInfor"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setPoint(rs.getInt("point"));
				vo.setLevel(rs.getInt("level"));
				vo.setVisitCnt(rs.getInt("visitCnt"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));
				vo.setTodayCnt(rs.getInt("todayCnt"));
				
				vo.setDeleteDiff(rs.getInt("deleteDiff"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return vos;
	}

	// 회원 등급 변경처리
	public int setMemberLevelChange(int idx, int level) {
		int res = 0;
		try {
			if(level == 99) {
				sql = "update member set level = ?, lastDate=now(), userDel='OK' where idx = ?";
			}
			else {
				sql = "update member set level = ?, userDel='NO' where idx = ?";				
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, level);
			pstmt.setInt(2, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}

	// 회원 DB에서 삭제처리하기
	public int MemberDeleteOk(int idx) {
		int res = 0;
		try {
			sql = "delete from member where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}

	// 레벨별 회원 건수
	public int getNewMemberListCount(int level) {
		int mCount = 0;
		try {
			sql = "select count(idx) as cnt from member where level = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, level);
			rs = pstmt.executeQuery();
			
			rs.next();
			mCount = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return mCount;
	}

	// 각 레벨별 건수 구하기
	public int getTotRecCnt(int level) {
		int totRecCnt = 0;
		try {
			if(level == 999) {
				sql = "select count(*) as cnt from member";
				pstmt = conn.prepareStatement(sql);
			}
			else {
				sql = "select count(*) as cnt  from member where level = ? order by idx desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, level);
			}
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return totRecCnt;
	}

	
	//신고 전체 목록
	public ArrayList<ComplaintVO> ComplaintList(String bName) {
		ArrayList<ComplaintVO> vos = new ArrayList<ComplaintVO>();
		try {
			sql = "select date_format(c.cpDate, '%Y-%m-%d %H:%i') as cpDate, c.*, b.title as title, b.nickName as nickName, b.mid as mid, b.content as content, b.complaint as complaint "
					+ "from complaint c, "+ bName +" b where c.bName = '"+ bName +"' and c.boardIdx = b.idx order by idx desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			ComplaintVO vo = null;
			while(rs.next()) {
				vo = new ComplaintVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setbName(rs.getString("bName"));
				vo.setBoardIdx(rs.getInt("boardIdx"));
				vo.setCpMid(rs.getString("cpMid"));
				vo.setCpContent(rs.getString("cpContent"));
				vo.setCpDate(rs.getString("cpDate"));
				
				vo.setTitle(rs.getString("title"));
				vo.setNickName(rs.getString("nickName"));
				vo.setMid(rs.getString("mid"));
				vo.setComplaint(rs.getString("complaint"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return vos;
	}

	// 게시물 표시 여부 변경
	public void setComplaintCheck(String bName, int boardIdx, String complaint) {
		try {
			if(complaint.equals("NO")) {
				sql = "update "+ bName +" set complaint = 'OK' where idx = ?";
			}
			else {
				sql = "update "+ bName +" set complaint = 'NO' where idx = ?";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
	}
	
	//신고된 게시물 삭제처리하기
	public int complaintBoardDelete(String bName, int boardIdx, int idx) {
		int res = 0, res1 = 0, res2 = 0;
		try {
			// 트랜잭설정 : false를 인자값으로 설정하여 수동커밋으로 지정한다.
			conn.setAutoCommit(false);
			sql = "delete from "+ bName +" where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			res1 = pstmt.executeUpdate();
			
			sql = "delete from complaint where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res2 = pstmt.executeUpdate();
			if(res1==1 & res2==1) {
				// 정상적으로 트랜잭션작업단위가 종료된후에 트랜잭션을 커밋시킨다.
				res = 1;
				conn.commit();
			}
			else {
				conn.rollback();
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}
	
}