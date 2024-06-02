package movie;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MovieListCommand implements MovieInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mName = request.getParameter("mName")==null ? "" : request.getParameter("mName");
		String page = request.getParameter("page")==null ? "" : request.getParameter("page");
		
		MovieDAO dao = new MovieDAO();
		ArrayList<MovieVO> vos = dao.getMovieList(mName, page);
		
		request.setAttribute("vos", vos);
		request.setAttribute("mName", mName);
	}

}
