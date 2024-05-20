package guest;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GuestInputOkCommand implements GuestInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		String homePage = request.getParameter("homePage")==null ? "" : request.getParameter("homePage");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		String hostIp = request.getParameter("hostIp")==null ? "" : request.getParameter("hostIp");
		
		name = name.replace("<", "&lt;").replace(">", "&gt;");
		email = email.replace("<", "&lt;").replace(">", "&gt;");
		homePage = homePage.replace("<", "&lt;").replace(">", "&gt;");
		content = content.replace("<", "&lt;").replace(">", "&gt;");
		
		GuestVO vo = new GuestVO();
		
		vo.setName(name);
		vo.setEmail(email);
		vo.setHomePage(homePage);
		vo.setContent(content);
		vo.setHostIp(hostIp);
		
		GuestDAO dao = new GuestDAO();
		
		int res = dao.setGuestInput(vo);
		
		PrintWriter out = response.getWriter();
		
		if(res != 0) {
			request.setAttribute("message", "방명록에 글이 등록되었습니다.");
			request.setAttribute("url", "GuestList.gu");
		}
		else {
			request.setAttribute("message", "방명록에 글등록 실패ㅜㅜ");
			request.setAttribute("url", "GuestInput.gu");
		}
	}

}
