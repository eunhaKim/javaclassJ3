package common;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movie.MovieDAO;
import movie.MovieReplyVO;
import movie.MovieVO;

@SuppressWarnings("serial")
@WebServlet("/Main")
public class Main extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String viewPage = "/main/main.jsp";
		
		// 개봉예정 영화 가져오기(메인 상단 롤링 영화 카루셀)
		MovieDAO dao = new MovieDAO();
		ArrayList<MovieVO> mVos = dao.getMovieList("upcoming", "1");
		
		request.setAttribute("mVos", mVos);
		
		// 영화의 최신리뷰 가져오기
		ArrayList<MovieReplyVO> replyVos = dao.getMovieReplyList();

		request.setAttribute("replyVos", replyVos);
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);;
	}
}