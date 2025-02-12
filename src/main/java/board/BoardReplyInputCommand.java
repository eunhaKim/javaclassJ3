package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardReplyInputCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String bName = request.getParameter("bName")==null ? "" : request.getParameter("bName");
		int boardIdx = request.getParameter("boardIdx")==null ? 0 : Integer.parseInt(request.getParameter("boardIdx"));
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String hostIp = request.getParameter("hostIp")==null ? "" : request.getParameter("hostIp");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		
		BoardReplyVO vo = new BoardReplyVO();
		
		vo.setBoardIdx(boardIdx);
		vo.setbName(bName);
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setHostIp(hostIp);
		vo.setContent(content);
		
		BoardDAO dao = new BoardDAO();
		
		int res = dao.setReplyInput(vo);
		
		response.getWriter().write(res + "");
	}

}
