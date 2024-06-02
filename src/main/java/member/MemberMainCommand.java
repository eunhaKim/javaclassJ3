package member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.BoardDAO;
import board.BoardReplyVO;
import board.BoardVO;
import guest.GuestDAO;
import guest.GuestVO;

public class MemberMainCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = request.getParameter("mid")==null ? (String) session.getAttribute("sMid") : request.getParameter("mid");
		
		MemberDAO mDao = new MemberDAO();
		MemberVO mVo = mDao.getMemberIdCheck(mid);
		
		BoardDAO bDao = new BoardDAO();
		ArrayList<BoardVO> bVos1 = bDao.getMemberBoardSearch("movieNews",mid);
		ArrayList<BoardVO> bVos2 = bDao.getMemberBoardSearch("movieRecommend",mid);
		ArrayList<BoardVO> bVos3 = bDao.getMemberBoardSearch("movieTogether",mid);
		ArrayList<BoardReplyVO> bVos4 = bDao.getBoardReplySearch(mid); 

		GuestDAO gDao = new GuestDAO();
		ArrayList<GuestVO> gVos = gDao.getMemberGuestSearch(mid, mVo.getName(), mVo.getNickName());
		
		request.setAttribute("mVo", mVo);
		request.setAttribute("bVos1", bVos1);
		request.setAttribute("bVos2", bVos2);
		request.setAttribute("bVos3", bVos3);
		request.setAttribute("bVos4", bVos4);
		request.setAttribute("gVos", gVos);
		request.setAttribute("guestCnt", gVos.size());
	}

}
