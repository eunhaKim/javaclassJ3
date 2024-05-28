package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoardGoodCheckCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String bName = request.getParameter("bName")==null ? "" : request.getParameter("bName");
		
		BoardDAO dao = new BoardDAO();
		
		// 좋아요수 증가처리(중복 불허)
		String sw = "0";
		HttpSession session = request.getSession();
		ArrayList<String> contentGood = (ArrayList<String>) session.getAttribute("sContentGood");
		if(contentGood == null) contentGood = new ArrayList<String>();
		String imsiContentGood = "boardGood" + idx;
		if(!contentGood.contains(imsiContentGood)) {
			dao.setBoardGoodCheck(bName, idx);
			contentGood.add(imsiContentGood);
			sw = "1";
		}
		session.setAttribute("sContentGood", contentGood);
		
		response.getWriter().write(sw);
	
	}

}
