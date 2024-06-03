package admin.complaint;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminDAO;
import admin.AdminInterface;

public class ComplaintCheckCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String bName = request.getParameter("bName")==null? "" : request.getParameter("bName");
		int boardIdx = request.getParameter("boardIdx")==null? 0 : Integer.parseInt(request.getParameter("boardIdx"));
		String complaint = request.getParameter("complaint")==null? "" : request.getParameter("complaint");
		
		AdminDAO dao = new AdminDAO();
		
		dao.setComplaintCheck(bName, boardIdx, complaint);
	}

}
