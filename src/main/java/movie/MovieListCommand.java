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
		MovieDAO dao = new MovieDAO();
		ArrayList<MovieVO> vos = dao.getMovieList("upcoming", "1");
		
		request.setAttribute("vos", vos);
	}

}
