package admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.complaint.ComplaintVO;

public class AdminContentCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDAO dao = new AdminDAO();
		
		int mCount = dao.getNewMemberListCount(1);
		int m99Count = dao.getNewMemberListCount(99);
		
		request.setAttribute("mCount", mCount);
		request.setAttribute("m99Count", m99Count);
		
		
		ArrayList<ComplaintVO> vos1 = dao.ComplaintList("movieNews");
		ArrayList<ComplaintVO> vos2 = dao.ComplaintList("movieRecommend");
		ArrayList<ComplaintVO> vos3 = dao.ComplaintList("movieTogether");
		
		request.setAttribute("vos1", vos1);
		request.setAttribute("vos2", vos2);
		request.setAttribute("vos3", vos3);
		request.setAttribute("complaintCnt", vos1.size()+vos2.size()+vos3.size());
	}

}
