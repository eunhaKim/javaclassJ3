package movie;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class MovieDAO {
	// tmdb 접근 , json 추출하는 메서드
	// params - setSubject : "now_playing" , "popular" , "top_rated" , "upcoming"
	// 					pageNum : 공백이 들어가도 작동되기 때문에 String 타입으로 설정했다. 1~?? 
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
		
		List<HashMap<String, Object>> movieList = null;
		
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
}
