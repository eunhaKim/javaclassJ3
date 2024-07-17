package movie;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MovieSearchListCommand implements MovieInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchString = request.getParameter("searchString")==null ? "" : request.getParameter("searchString");
		String page = request.getParameter("page")==null ? "" : request.getParameter("page");
		
		MovieDAO dao = new MovieDAO();
		ArrayList<MovieVO> vos = dao.getMovieSearchList(searchString, page);
		
		request.setAttribute("vos", vos);
		request.setAttribute("searchString", searchString);
	}

}
