package movie;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.BoardReplyDeleteCommand;
import board.BoardReplyInputCommand;
import board.BoardReplyUpdateCommand;

@WebServlet("*.mv")
public class MovieController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MovieInterface command = null;
		String viewPage = "/WEB-INF/movie";

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		String mName = request.getParameter("mName")==null ? "" : request.getParameter("mName");
		String mTextName = "";
		if(mName.equals("upcoming")) mTextName = "개봉예정영화";
		else if(mName.equals("now_playing")) mTextName="현재상영작";
		else if(mName.equals("popular")) mTextName="영화인기순";
		else if(mName.equals("top_rated")) mTextName="영화평점순";
		else mTextName="Movie Title";
		request.setAttribute("mTextName", mTextName);
		
		// 인증....처리.....
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
		
		if(com.equals("/MovieList")) {
			command = new MovieListCommand();
			command.execute(request, response);
			viewPage += "/movieList.jsp";
		}
		else if(com.equals("/MovieContent")) {
			command = new MovieContentCommand();
			command.execute(request, response);
			viewPage += "/movieContent.jsp";
		}
		else if(level > 4) {
			request.setAttribute("message", "로그인후 사용하세요");
			request.setAttribute("url", request.getContextPath()+"/MemberLogin.mem");
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/MovieReplyInput")) {
			command = new MovieReplyInputCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/MovieReplyUpdate")) {
			command = new MovieReplyUpdateCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/MovieReplyDelete")) {
			command = new MovieReplyDeleteCommand();
			command.execute(request, response);
			return;
		}
		
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);		
	}
	
}
