package admin.complaint;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminDAO;
import admin.AdminInterface;

public class ComplaintDeleteCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String bName = request.getParameter("bName")==null? "" : request.getParameter("bName");
		int boardIdx = request.getParameter("boardIdx")==null? 0 : Integer.parseInt(request.getParameter("boardIdx"));
		int idx = request.getParameter("idx")==null? 0 : Integer.parseInt(request.getParameter("idx"));
		AdminDAO dao = new AdminDAO();
		
		int res = dao.complaintBoardDelete(bName, boardIdx, idx);
		System.out.println(res);
		
		if(res==1) response.getWriter().write("1");
		else response.getWriter().write("0");
	}

}
