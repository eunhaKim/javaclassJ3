package movie;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import board.BoardReplyVO;
import board.BoardVO;
import common.GetConn;

public class MovieDAO {
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
	
	
	
	// tmdb 접근 , json 추출하는 메서드
	// params - setSubject : "now_playing" , "popular" , "top_rated" , "upcoming"
	// 					pageNum : 공백이 들어가도 작동되기 때문에 String 타입으로 설정했다. 1~?? 
	// 영화 리스트 가져오기
	public ArrayList<MovieVO> getMovieList(String setSubject, String pageNum) {
		ArrayList<MovieVO> vos = new ArrayList<MovieVO>();
		
		// URL에 순서대로 들어가면 된다
		String base_url = "https://api.themoviedb.org/3/movie/";					// 영화 검색 기본 url
		String subject = setSubject;																// 주제 ( 인기있는 , 탑레이팅 , 업커밍 등 )
		String api_key = "?api_key=bbba5ebfd151ae4575f0ef194876edf1";	// api 키
		String language = "&language=ko-kr";												// 언어 옵션
		String page = "&page="+ pageNum;													// 페이지 옵션 ( 안넣으면 디폴트 1 )
		
		String completed_url = base_url+subject+api_key+language+page;
		
		// System.out.println("callRestApi 호출");
		
		
		try {
			
			URL url = new URL(completed_url);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setDoOutput(true); // 서버로 받는 값이 있다
			
			// 데이터 읽기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			StringBuilder sb = new StringBuilder();
			String line = null;
			
			// 읽을 수 있을 때 까지
			while((line = br.readLine()) != null) {
				sb.append(line);
			}
			
			JSONParser parser = new JSONParser();
			JSONObject obj = (JSONObject) parser.parse(sb.toString());
			
			JSONArray objArray = (JSONArray) obj.get("results");
			
			for(int i=0; i<objArray.size(); i++) {
				// System.out.println(objArray.get(i));
				JSONObject rs = (JSONObject) objArray.get(i);
				
				// 오버뷰가 "" 이 아닌경우만 담기
				if(!rs.get("overview").equals("")) {
					
					MovieVO vo = new MovieVO();
					vo.setMovie_id(Integer.parseInt((String.valueOf(rs.get("id")))));
					vo.setMovie_title((String) rs.get("title"));
					vo.setMovie_overview((String) rs.get("overview"));
					vo.setMovie_popularity((double) rs.get("popularity"));
					vo.setMovie_vote_average((double) rs.get("vote_average"));
					vo.setMovie_vote_count(Integer.parseInt((String.valueOf(rs.get("vote_count")))));
					vo.setMovie_poster_path((String) rs.get("poster_path"));
					vo.setMovie_backdrop_path((String) rs.get("backdrop_path"));
					vo.setMovie_adult((String) rs.get("movie_adult"));
					vo.setMovie_date((String) rs.get("release_date"));
					vo.setMovie_subject(setSubject);
					// System.out.println(vo);
					
					vos.add(vo);
				}
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
			System.out.println("URL이 잘못되었습니다.");
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("Input 또는 Ouput 오류");
		} catch (ParseException e) {
			e.printStackTrace();
			System.out.println("제이슨 파싱 실패");
		}
		
		return vos;
	}
	
	// 영화 상세페이지 정보 가져오기
	public MovieVO getMovieDetails(String movie_id) {
		MovieVO vo = new MovieVO();
		
		// URL에 순서대로 들어가면 된다
		String base_url = "https://api.themoviedb.org/3/movie/";		// 영화 검색 기본 url
		String language = "?language=ko-kr";												// 언어 옵션	
		String api_key = "&api_key=bbba5ebfd151ae4575f0ef194876edf1";				// api 키
		String completed_url = base_url + movie_id + language + api_key;
		
		try {
			
			URL url = new URL(completed_url);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setDoOutput(true); // 서버로 받는 값이 있다
			
			// 데이터 읽기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			StringBuilder sb = new StringBuilder();
			String line = null;
			
			// 읽을 수 있을 때 까지
			while((line = br.readLine()) != null) {
				sb.append(line);
			}
			br.close();
			
			// JSON 파싱
			JSONParser parser = new JSONParser();
			JSONObject obj = (JSONObject) parser.parse(sb.toString());
			// System.out.println(obj);
			
			vo.setMovie_id(Integer.parseInt((String.valueOf(obj.get("id")))));
			vo.setMovie_title((String) obj.get("title"));
			vo.setMovie_overview((String) obj.get("overview"));
			vo.setMovie_popularity((double) obj.get("popularity"));
			vo.setMovie_vote_average((double) obj.get("vote_average"));
			vo.setMovie_vote_count(Integer.parseInt((String.valueOf(obj.get("vote_count")))));
			vo.setMovie_poster_path((String) obj.get("poster_path"));
			vo.setMovie_backdrop_path((String) obj.get("backdrop_path"));
			vo.setMovie_adult((String) obj.get("movie_adult"));
			vo.setMovie_date((String) obj.get("release_date"));
			vo.setMovie_tagline((String) obj.get("tagline"));
			// System.out.println(vo);
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
			System.out.println("URL이 잘못되었습니다.");
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("Input 또는 Ouput 오류");
		} catch (ParseException e) {
			e.printStackTrace();
			System.out.println("제이슨 파싱 실패");
		}

		return vo;
	}

	
	
	//작성된 리뷰리스트 가져오기
	public ArrayList<MovieReplyVO> getMovieReplyList(String movie_id) {
		ArrayList<MovieReplyVO> replyVos = new ArrayList<>();
		try {
			sql = "select movieReply.*, member.photo from movieReply left join member on movieReply.mid = member.mid where movieReply.movie_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movie_id);
			rs = pstmt.executeQuery();
			
			MovieReplyVO vo = null;
			while(rs.next()) {
				vo = new MovieReplyVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMovie_id(rs.getString("movie_id"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setStar(rs.getInt("star"));
				vo.setrDate(rs.getString("rDate"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setContent(rs.getString("content"));
				vo.setPhoto(rs.getString("photo"));
				
				replyVos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return replyVos;
	}
	
	//영화의 최신 리뷰리스트 가져오기
	public ArrayList<MovieReplyVO> getMovieReplyList() {
		ArrayList<MovieReplyVO> replyVos = new ArrayList<>();
		try {
			sql = "select movieReply.*, member.photo from movieReply left join member on movieReply.mid = member.mid order by idx desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			MovieReplyVO vo = null;
			while(rs.next()) {
				vo = new MovieReplyVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMovie_id(rs.getString("movie_id"));
				vo.setMovie_title(rs.getString("movie_title"));
				vo.setMovie_poster_path(rs.getString("movie_poster_path"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setStar(rs.getInt("star"));
				vo.setrDate(rs.getString("rDate"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setContent(rs.getString("content"));
				vo.setPhoto(rs.getString("photo"));
				
				replyVos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();			
		}
		return replyVos;
	}
	
	//영화리뷰등록
	public int setMovieReplyInput(MovieReplyVO vo) {
		int res = 0;
		try {
			sql = "insert into movieReply values (default,?,?,?,?,?,?,default,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMovie_id());
			pstmt.setString(2, vo.getMovie_title());
			pstmt.setString(3, vo.getMovie_poster_path());
			pstmt.setString(4, vo.getMid());
			pstmt.setString(5, vo.getNickName());
			pstmt.setInt(6, vo.getStar());
			pstmt.setString(7, vo.getHostIp());
			pstmt.setString(8, vo.getContent());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}

	// 리뷰 삭제처리
	public int setMovieReplyDelete(int idx) {
		int res = 0;
		try {
			sql = "delete from movieReply where idx = ?";
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

	// 리뷰 수정하기
	public int setReplyUpdate(MovieReplyVO vo) {
		int res = 0;
		try {
			sql = "update movieReply set content = ?, hostIp=?, star=? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getContent());
			pstmt.setString(2, vo.getHostIp());
			pstmt.setInt(3, vo.getStar());
			pstmt.setInt(4, vo.getIdx());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();			
		}
		return res;
	}
	
}
