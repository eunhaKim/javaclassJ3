package movie;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MovieContentCommand implements MovieInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mName = request.getParameter("mName")==null ? "" : request.getParameter("mName");
		String movie_id = request.getParameter("movie_id")==null ? "" : request.getParameter("movie_id");
		
		MovieDAO dao = new MovieDAO();
		MovieVO vo = dao.getMovieDetails(movie_id);
		
		// 해당영화의 리뷰 가져오기
		ArrayList<MovieReplyVO> replyVos = dao.getMovieReplyList(movie_id);
		
		// 별점 평균 구하기
		int reviewTot = 0;
		for(MovieReplyVO r : replyVos) {
			reviewTot += r.getStar();
		}
		double reviewAvg = 0.0;
		if(replyVos.size() != 0) reviewAvg = (double) reviewTot / replyVos.size();
		
		request.setAttribute("vo", vo);
		request.setAttribute("replyVos", replyVos);
		request.setAttribute("reviewAvg", reviewAvg);
		request.setAttribute("mName", mName);
	}

}
