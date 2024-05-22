package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class Visitor {
	public static void visitorCount(HttpServletRequest request) throws ServletException, IOException {
		String visitIp = request.getRemoteAddr();
		
		AdminDAO dao = new AdminDAO();
		int res = 0;
		VisitorVO vo = dao.getSearchVisitIp(visitIp); // 오늘 같은 방문ip로 접속한적 있는지 체크
		// 오늘 처음 방문이면 카운터 증가 & db에 저장
		if(vo.getVisitIp() == null) { 
			res = dao.setVisitorInsert(visitIp);
		}
		
		// 방문자수를 가져와서 session에 저장처리한다.
		int visitCount = dao.getTotalVisitors();
		int todayVisitCount = dao.getTodayVisitors();
		
		HttpSession session = request.getSession();
		session.setAttribute("sVisitCount", visitCount);
		session.setAttribute("sTodayVisitCount", todayVisitCount);
	}
}
