package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoardContentCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String bName = request.getParameter("bName")==null ? "" : request.getParameter("bName");
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null ? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 0 : Integer.parseInt(request.getParameter("pageSize"));
		String flag = request.getParameter("flag")==null ? "" : request.getParameter("flag");
		String search = request.getParameter("search")==null ? "" : request.getParameter("search");
		String searchString = request.getParameter("searchString")==null ? "" : request.getParameter("searchString");
		
		BoardDAO dao = new BoardDAO();
		
		BoardVO vo = dao.getBoardContent(bName, idx);
		request.setAttribute("vo", vo);
		request.setAttribute("bName", bName);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);

		
		// 게시글 조회수 1씩 증가시키기(중복방지)
		HttpSession session = request.getSession();
		ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "board" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			dao.setBoardReadNumPlus(bName, idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);
		
		// 신고글 유무 처리하기
		String report = dao.getReport(bName, idx);
		
		request.setAttribute("report", report);
		request.setAttribute("flag", flag);
		request.setAttribute("search", search);
		request.setAttribute("searchString", searchString);
		
		// 이전글/다음글처리
		BoardVO preVo = dao.getPreNextSearch(bName, idx, "preVo");
		BoardVO nextVo = dao.getPreNextSearch(bName, idx, "nextVo");
		request.setAttribute("preVo", preVo);
		request.setAttribute("nextVo", nextVo);
		
		// 댓글 처리
		ArrayList<BoardReplyVO> replyVos = dao.getBoardReply(bName, idx);
		request.setAttribute("replyVos", replyVos);
	}

}
