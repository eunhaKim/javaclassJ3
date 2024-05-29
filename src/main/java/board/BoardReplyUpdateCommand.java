package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardReplyUpdateCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String hostIp = request.getParameter("hostIp")==null ? "" : request.getParameter("hostIp");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		
		BoardReplyVO vo = new BoardReplyVO();
		
		vo.setIdx(idx);
		vo.setHostIp(hostIp);
		vo.setContent(content);
		
		BoardDAO dao = new BoardDAO();
		
		int res = dao.setReplyUpdate(vo);
		
		response.getWriter().write(res + "");
	}

}
