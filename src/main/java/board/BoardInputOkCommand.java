package board;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardInputOkCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/board");
		int maxSize = 1024 * 1024 * 3;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		Enumeration fileNames = multipartRequest.getFileNames();
		
		String file = "";
		String oFileName = "";
		String fSName = "";
		if(multipartRequest.getOriginalFileName("listImg")!=null) {
			while(fileNames.hasMoreElements()) {
				file = (String) fileNames.nextElement();
				
				if(multipartRequest.getFilesystemName(file) != null) {
					oFileName += multipartRequest.getOriginalFileName(file) + "/";
					fSName += multipartRequest.getFilesystemName(file) + "/";
				}
			}
			oFileName = oFileName.substring(0, oFileName.lastIndexOf("/"));
			fSName = fSName.substring(0, fSName.lastIndexOf("/"));
		}
		else {
			oFileName = "noimage.jpg";
			fSName = "noimage.jpg";
		}
		
		// 업로드시킨 파일을 DB에 저장시키기 위해서 전송된 폼의 내용들을 모두 변수에 담아준다.
		String bName = multipartRequest.getParameter("bName")==null ? "" : multipartRequest.getParameter("bName");
		String mid = multipartRequest.getParameter("mid")==null ? "" : multipartRequest.getParameter("mid");
		String nickName = multipartRequest.getParameter("nickName")==null ? "" : multipartRequest.getParameter("nickName");
		String title = multipartRequest.getParameter("title")==null ? "" : multipartRequest.getParameter("title");
		String content = multipartRequest.getParameter("content")==null ? "" : multipartRequest.getParameter("content");
		String hostIp = multipartRequest.getParameter("hostIp")==null ? "" : multipartRequest.getParameter("hostIp");
		
		// 가공처리된 모든 자료들을 VO에 담아서 DB에 저장한다.
		BoardVO vo = new BoardVO();
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setListImg(oFileName==""?"noimage.jpg":oFileName);
		vo.setListImgfSName(fSName==""?"noimage.jpg":fSName);
		vo.setHostIp(hostIp);
		System.out.println(vo);
		
		BoardDAO dao = new BoardDAO();
		int res = dao.setBoardInput(bName,vo);
		
		if(res != 0) {
			request.setAttribute("message", "게시글이 등록되었습니다.");
			request.setAttribute("url", "BoardList.bo?bName="+bName);
		}
		else {
			request.setAttribute("message", "게시글 등록실패~");
			request.setAttribute("url", "BoardInput.bo?bName="+bName);
		}
	}

}
