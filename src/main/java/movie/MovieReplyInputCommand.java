package movie;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MovieReplyInputCommand implements MovieInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String movie_id = request.getParameter("movie_id")==null ? "" : request.getParameter("movie_id");
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		int star = request.getParameter("star")==null ? 0 : Integer.parseInt(request.getParameter("star"));
		String hostIp = request.getParameter("hostIp")==null ? "" : request.getParameter("hostIp");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		
		MovieReplyVO vo = new MovieReplyVO();
		
		vo.setMovie_id(movie_id);
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setStar(star);
		vo.setHostIp(hostIp);
		vo.setContent(content);
		// System.out.println(vo);
		
		MovieDAO dao = new MovieDAO();
		int res = dao.setMovieReplyInput(vo);
		
		response.getWriter().write(res + "");
	}

}