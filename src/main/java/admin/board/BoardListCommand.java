package admin.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.AdminInterface;
import board.BoardDAO;
import board.BoardVO;

public class BoardListCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 관리자는 모든글 보여주고, 관리자외에는 숨긴글과 차단글(신고글)은 보여주지않게한다. 단, 자신이 작성한글은 볼수 있게한다.
		// 이것을 view에서(boardList.jsp)에서 처리하면 한페이지분량이 맞지않기에 sql문에서 처리해서 넘겨주도록 한다.
		// recordShow변수 : 관리자는 'adminOK'로, 일반사용자는 자신의 아이디로 부여한다. (즉, recordShow='adminOK'는 모든글보기, 일반 아이디는 숨긴글(openSW='NO')과 차단글(complaint='OK')은 보여주지않기(즉, 자신만 보기)
		HttpSession session = request.getSession();
		int level = (int) session.getAttribute("sLevel");
		String contentsShow = "";
		if(level == 0) contentsShow = "adminOK";
		else contentsShow = (String) session.getAttribute("sMid");
		String bName = request.getParameter("bName")==null ? "" : request.getParameter("bName");
		
		BoardDAO dao = new BoardDAO();
		
		// 페이징 처리 시작
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
		int totRecCnt = dao.getTotRecCnt(contentsShow, bName, "", "");
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		if(pag > totPage) pag = 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		// 페이징 처리 끝
		
		List<BoardVO> vos = dao.getBoardList(startIndexNo, pageSize, contentsShow, bName, "", "");
		
		request.setAttribute("vos", vos);
		request.setAttribute("bName", bName);
		
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totRecCnt", totRecCnt);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
	}

}
