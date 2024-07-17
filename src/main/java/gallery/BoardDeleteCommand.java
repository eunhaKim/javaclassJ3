package gallery;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardDeleteCommand implements GalleryInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String fSName1 = request.getParameter("fSName")==null? "" :request.getParameter("fSName");
		String[] fSNames = fSName1.split("/");
		// 서버에 존재하는 파일을 삭제한다.
		String realPath = request.getServletContext().getRealPath("/images/gallery/");
		for(String fSName : fSNames) {
			new File(realPath + fSName).delete();
		}
		
		// 서버의 파일을 삭제후 DB에서 자료를 삭제처리한다.
		GalleryDAO dao = new GalleryDAO();
		int res = dao.setGalleryDeleteCheck(idx);
		
		response.getWriter().write(res + "");
	}

}
