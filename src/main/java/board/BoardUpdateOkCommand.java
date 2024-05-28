package board;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardUpdateOkCommand implements BoardInterface {

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
			oFileName = multipartRequest.getParameter("oFileName")==null ? "" : multipartRequest.getParameter("oFileName");
			fSName = multipartRequest.getParameter("fSName")==null ? "" : multipartRequest.getParameter("fSName");
		}
		
		// 업로드시킨 파일을 DB에 저장시키기 위해서 전송된 폼의 내용들을 모두 변수에 담아준다.
		String bName = multipartRequest.getParameter("bName")==null ? "" : multipartRequest.getParameter("bName");
		int idx = multipartRequest.getParameter("idx")==null ? 0 : Integer.parseInt(multipartRequest.getParameter("idx"));
		String title = multipartRequest.getParameter("title")==null ? "" : multipartRequest.getParameter("title");
		String content = multipartRequest.getParameter("content")==null ? "" : multipartRequest.getParameter("content");
		String hostIp = multipartRequest.getParameter("hostIp")==null ? "" : multipartRequest.getParameter("hostIp");
		String openSw = multipartRequest.getParameter("openSw")==null ? "OK" : multipartRequest.getParameter("openSw");
		
		int pag = multipartRequest.getParameter("pag")==null ? 0 : Integer.parseInt(multipartRequest.getParameter("pag"));
		int pageSize = multipartRequest.getParameter("pageSize")==null ? 0 : Integer.parseInt(multipartRequest.getParameter("pageSize"));
		
		
		BoardVO vo = new BoardVO();
		
		vo.setIdx(idx);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setOpenSw(openSw);
		vo.setHostIp(hostIp);
		vo.setListImg(oFileName==""?"noimage.jpg":oFileName);
		vo.setListImgfSName(fSName==""?"noimage.jpg":fSName);

		BoardDAO dao = new BoardDAO();
		
		int res = dao.setBoardUpdateOk(bName,vo);
		
		if(res != 0) request.setAttribute("message", "게시글이 수정되었습니다.");
		else request.setAttribute("message", "게시글이 수정실패~~~");
		
		request.setAttribute("url", "BoardContent.bo?bName="+bName+"&idx="+idx+"&pag="+pag+"&pageSize="+pageSize);
	}

}
