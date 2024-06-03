package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.GetConn;

public class BoardDAO {
	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	private BoardVO vo = null;
	
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

	// 전체 게시글 보기
	public ArrayList<BoardVO> getBoardList(int startIndexNo, int pageSize, String contentsShow, String bName, String search, String searchString) {
		ArrayList<BoardVO> vos = new ArrayList<BoardVO>();
		try {
			if(search == null || search.equals("")) {
				if(contentsShow.equals("adminOK")) {
				  sql = "select *, datediff(wDate, now()) as date_diff, "
				  		+ "timestampdiff(hour, wDate, now()) as hour_diff, "
				  		+ "(select count(*) from boardReply where boardIdx = b.idx and bName = '"+bName+"') as replyCnt "
				  		+ "from "+ bName +" b order by idx desc limit ?,?";
				  pstmt = conn.prepareStatement(sql);
				  pstmt.setInt(1, startIndexNo);
				  pstmt.setInt(2, pageSize);
				}
				else {
					sql = "select *, datediff(wDate, now()) as date_diff, "
							+ "timestampdiff(hour, wDate, now()) as hour_diff, "
							+ "(select count(*) from boardReply where boardIdx = b.idx) as replyCnt "
							+ "from "+ bName +" b where openSW = 'OK' and complaint = 'NO' union "
							+ "select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff, "
							+ "(select count(*) from boardReply where boardIdx = b.idx and bName = '"+bName+"') as replyCnt "
							+ "from "+ bName +" b "
							+ "where mid = ? order by idx desc limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, contentsShow);
					pstmt.setInt(2, startIndexNo);
					pstmt.setInt(3, pageSize);
				}
			}
			else {
				if(contentsShow.equals("adminOK")) {
				  sql = "select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff, "
				  		+ "(select count(*) from boardReply where boardIdx = b.idx and bName = '"+bName+"') as replyCnt "
				  		+ "from "+ bName +" b where "+search+" like ? order by idx desc limit ?,?";
				  pstmt = conn.prepareStatement(sql);
				  pstmt.setString(1, "%"+searchString+"%");
				  pstmt.setInt(2, startIndexNo);
				  pstmt.setInt(3, pageSize);
				}
				else {
					sql = "select *, datediff(wDate, now()) as date_diff, "
							+ "timestampdiff(hour, wDate, now()) as hour_diff, "
							+ "(select count(*) from boardReply where boardIdx = b.idx) as replyCnt "
							+ "from "+ bName +" b where openSW = 'OK' and complaint = 'NO' and "+search+" like ? union "
							+ "select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff, "
							+ "(select count(*) from boardReply where boardIdx = b.idx and bName = '"+bName+"') as replyCnt "
							+ "from "+ bName +" b "
							+ "where mid = ? and "+search+" like ? order by idx desc limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%"+searchString+"%");
					pstmt.setString(2, contentsShow);
					pstmt.setString(3, "%"+searchString+"%");
					pstmt.setInt(4, startIndexNo);
					pstmt.setInt(5, pageSize);
				}
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setwDate(rs.getString("wDate"));
				vo.setGood(rs.getInt("good"));
				vo.setComplaint(rs.getString("complaint"));
				
				vo.setListImg(rs.getString("listImg"));
				vo.setListImgfSName(rs.getString("listImgfSName"));
				vo.setfName(rs.getString("fName"));
				vo.setfSName(rs.getString("fSName"));
				
				vo.setHour_diff(rs.getInt("hour_diff"));
				vo.setDate_diff(rs.getInt("date_diff"));
				
				vo.setReplyCnt(rs.getInt("replyCnt"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류.. : " + e.getMessage());
			e.printStackTrace();
		} finally {
			rsClose();			
		}
		return vos;
	}

	// 게시글 등록하기
	public int setBoardInput(String bName, BoardVO vo) {
		int res = 0;
		try {
			sql = "insert into "+ bName +" values (default,?,?,?,?,default,?,default,default,default,?,?,default,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getNickName());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getHostIp());
			pstmt.setString(6, vo.getListImg());
			pstmt.setString(7, vo.getListImgfSName());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}

	// 게시글 내용보기
	public BoardVO getBoardContent(String bName, int idx) {
		BoardVO vo = new BoardVO();
		try {
			sql = "select * from "+ bName +" where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setwDate(rs.getString("wDate"));
				vo.setGood(rs.getInt("good"));
				vo.setListImg(rs.getString("listImg"));
				vo.setListImgfSName(rs.getString("listImgfSName"));
				vo.setOpenSw(rs.getString("openSw"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return vo;
	}

	// 조회수 증가처리
	public void setBoardReadNumPlus(String bName, int idx) {
		try {
			sql = "update "+ bName +" set readNum = readNum + 1 where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
	}

	// 게시글 삭제하기
	public int setBoardDelete(String bName, int idx) {
		int res = 0;
		try {
			sql = "delete from "+ bName +" where idx = ?";
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
	
  // 게시물 총 레코드 건수 
	public int getTotRecCnt(String contentsShow, String bName, String search, String searchString) {
		int totRecCnt = 0;
		try {
			if(search == null || search.equals("")) {
				if(contentsShow.equals("adminOK")) {
				  sql = "select count(*) as cnt from " + bName;
				  pstmt = conn.prepareStatement(sql);
				}
				else {
					sql = "select sum(a.cnt) as cnt from (select count(*) as cnt from "+ bName +" where complaint = 'NO' union select count(*) as cnt from "+ bName +" where mid = ? and complaint = 'OK') as a";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, contentsShow);
				}
			}
			else {
				if(contentsShow.equals("adminOK")) {
				  sql = "select count(*) as cnt from "+ bName +" where "+search+" like ?";
				  pstmt = conn.prepareStatement(sql);
				  pstmt.setString(1, "%"+searchString+"%");
				}
				else {
					sql = "select sum(a.cnt) as cnt from (select count(*) as cnt from board where complaint = 'NO' and "+search+" like ? union select count(*) as cnt from "+ bName +" where mid = ? and complaint = 'OK' and "+search+" like ?) as a";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%"+searchString+"%");
					pstmt.setString(2, contentsShow);
					pstmt.setString(3, "%"+searchString+"%");
				}
			}
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL 오류!! : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return totRecCnt;
	}

	// 이전글/다음글 idx,title가져오기
	public BoardVO getPreNextSearch(String bName, int idx, String str) {
		BoardVO vo = new BoardVO();
		try {
			if(str.equals("preVo")) sql = "select idx, title from "+ bName +" where idx < ? order by idx desc limit 1";
			else sql = "select idx, title from "+ bName +" where idx > ? order by idx limit 1";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setTitle(rs.getString("title"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return vo;
	}

	// 좋아요수 증가처리
	public int setBoardGoodCheck(String bName, int idx) {
		int res = 0;
		try {
			sql = "update "+ bName +" set good = good + 1 where idx = ?";
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

	// 좋아요수 증가/감소 처리
	public void setBoardGoodCheckPlusMinus(int idx, int goodCnt) {
		try {
			sql = "update board set good = good + ? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, goodCnt);
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
	}

	// 게시글 수정하기
	public int setBoardUpdateOk(String bName, BoardVO vo) {
		int res = 0;
		try {
			sql = "update "+ bName +" set title=?, content=?, openSw=?, hostIp=?, wDate=now(), listImg=?, listImgfSName=? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getOpenSw());
			pstmt.setString(4, vo.getHostIp());
			pstmt.setString(5, vo.getListImg());
			pstmt.setString(6, vo.getListImgfSName());
			pstmt.setInt(7, vo.getIdx());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}

	// 작성된 댓글 가져오기
	public ArrayList<BoardReplyVO> getBoardReply(String bName, int boardIdx) {
		ArrayList<BoardReplyVO> replyVos = new ArrayList<>();
		try {
			sql = "select * from boardReply where bName=? and boardIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bName);
			pstmt.setInt(2, boardIdx);
			rs = pstmt.executeQuery();
			
			BoardReplyVO vo = null;
			while(rs.next()) {
				vo = new BoardReplyVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setbName(rs.getString("bName"));
				vo.setBoardIdx(rs.getInt("boardIdx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setwDate(rs.getString("wDate"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setContent(rs.getString("content"));
				
				replyVos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return replyVos;
	}

	// 댓글 저장하기
	public int setReplyInput(BoardReplyVO vo) {
		int res = 0;
		try {
			sql = "insert into boardReply values (default,?,?,?,?,default,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getbName());
			pstmt.setInt(2, vo.getBoardIdx());
			pstmt.setString(3, vo.getMid());
			pstmt.setString(4, vo.getNickName());
			pstmt.setString(5, vo.getHostIp());
			pstmt.setString(6, vo.getContent());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}

	// 댓글 삭제처리
	public int setBoardReplyDelete(int idx) {
		int res = 0;
		try {
			sql = "delete from boardReply where idx = ?";
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

	//신고내역 저장하기
	public int setBoardComplaintInput(ComplaintVO vo) {
	int res = 0;
	try {
		sql = "insert into complaint values (default, ?, ?, ?, ?, default)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, vo.getbName());
		pstmt.setInt(2, vo.getBoardIdx());
		pstmt.setString(3, vo.getCpMid());
		pstmt.setString(4, vo.getCpContent());
		res = pstmt.executeUpdate();
	} catch (SQLException e) {
		System.out.println("SQL 오류 : " + e.getMessage());
	} finally {
		pstmtClose();			
	}
		return res;
	}

	
//신고글 유무 체크하기
	public String getReport(String bName, int boardIdx) {
		String report = "NO";
		try {
			sql = "select * from complaint where bName = ? and boardIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bName);
			pstmt.setInt(2, boardIdx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) report = "OK";
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return report;
	}

	// 댓글 수정
	public int setReplyUpdate(BoardReplyVO vo) {
		int res = 0;
		try {
			sql = "update boardReply set content = ?, hostIp=? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getContent());
			pstmt.setString(2, vo.getHostIp());
			pstmt.setInt(3, vo.getIdx());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}

	// mid가 쓴 최근 게시물 3개만 가져오기
	public ArrayList<BoardVO> getMemberBoardSearch(String bName, String mid) {
		ArrayList<BoardVO> vos = new ArrayList<BoardVO>();
		try {
			sql = "select * from "+ bName +" where mid = ? order by wDate desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardVO vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setwDate(rs.getString("wDate"));
				vo.setGood(rs.getInt("good"));
				vo.setListImg(rs.getString("listImg"));
				vo.setListImgfSName(rs.getString("listImgfSName"));
				vo.setOpenSw(rs.getString("openSw"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return vos;
	}

	// 내가 쓴 댓글리스트
	public ArrayList<BoardReplyVO> getBoardReplySearch(String mid) {
		ArrayList<BoardReplyVO> replyVos = new ArrayList<>();
		try {
			sql = "select * from boardReply where mid=? order by wDate desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			BoardReplyVO vo = null;
			while(rs.next()) {
				vo = new BoardReplyVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setbName(rs.getString("bName"));
				vo.setBoardIdx(rs.getInt("boardIdx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setwDate(rs.getString("wDate"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setContent(rs.getString("content"));
				
				replyVos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return replyVos;
	}

}
