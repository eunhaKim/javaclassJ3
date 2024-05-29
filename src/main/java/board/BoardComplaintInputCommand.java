package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardComplaintInputCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String bName = request.getParameter("bName")==null ? "" : request.getParameter("bName");
		int boardIdx = request.getParameter("boardIdx")==null ? 0 : Integer.parseInt(request.getParameter("boardIdx"));
		String cpMid = request.getParameter("cpMid")==null ? "" : request.getParameter("cpMid");
		String cpContent = request.getParameter("cpContent")==null ? "" : request.getParameter("cpContent");
		
		BoardDAO dao = new BoardDAO();
		ComplaintVO vo = new ComplaintVO();
		
		vo.setbName(bName);
		vo.setBoardIdx(boardIdx);
		vo.setCpMid(cpMid);
		vo.setCpContent(cpContent);
		
		int res = dao.setBoardComplaintInput(vo);
		
		response.getWriter().write(res + "");
	}

}
