package movie;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("*.mv")
public class MovieController extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MovieInterface command = null;
		String viewPage = "/WEB-INF/movie";

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		String bName = request.getParameter("bName")==null ? "" : request.getParameter("bName");
		String bTextName = "";
		if(bName.equals("movieRecommend")) bTextName = "영화추천";
		else if(bName.equals("movieNews")) bTextName="영화소식";
		else if(bName.equals("movieTogether")) bTextName="같이 영화보러가요";
		else bTextName="Board Title";
		request.setAttribute("bTextName", bTextName);
		
		// 인증....처리.....
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
		
		if(com.equals("/MovieList")) {
			command = new MovieListCommand();
			command.execute(request, response);
			viewPage += "/movieList.jsp";
		}
		else if(level > 4) {
			request.setAttribute("message", "로그인후 사용하세요");
			request.setAttribute("url", request.getContextPath()+"/MemberLogin.mem");
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/MovieGoodCheck")) {
			command = new MovieGoodCheckCommand();
			command.execute(request, response);
			return;
		}
		
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);		
	}
	
}
