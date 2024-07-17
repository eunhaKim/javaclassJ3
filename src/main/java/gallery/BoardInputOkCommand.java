package gallery;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.SecurityUtil;

public class BoardInputOkCommand implements GalleryInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/gallery");
		int maxSize = 1024 * 1024 * 30;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		Enumeration fileNames = multipartRequest.getFileNames();
		
		String file = "";
		String oFileName = "";
		String fSName = "";
		
		while(fileNames.hasMoreElements()) {
			file = (String) fileNames.nextElement();
			
			if(multipartRequest.getFilesystemName(file) != null) {
				oFileName += multipartRequest.getOriginalFileName(file) + "/";
				fSName += multipartRequest.getFilesystemName(file) + "/";
			}
		}
		oFileName = oFileName.substring(0, oFileName.lastIndexOf("/"));
		fSName = fSName.substring(0, fSName.lastIndexOf("/"));
		
		// 업로드시킨 파일을 DB에 저장시키기 위해서 전송된 폼의 내용들을 모두 변수에 담아준다.
		String mid = multipartRequest.getParameter("mid")==null ? "" : multipartRequest.getParameter("mid");
		String nickName = multipartRequest.getParameter("nickName")==null ? "" : multipartRequest.getParameter("nickName");
		int fSize = multipartRequest.getParameter("fSize")==null ? 0 : Integer.parseInt(multipartRequest.getParameter("fSize"));
		String title = multipartRequest.getParameter("title")==null ? "" : multipartRequest.getParameter("title");
		String part = multipartRequest.getParameter("part")==null ? "" : multipartRequest.getParameter("part");
		String openSw = multipartRequest.getParameter("openSw")==null ? "" : multipartRequest.getParameter("openSw");
		String pwd = multipartRequest.getParameter("pwd")==null ? "" : multipartRequest.getParameter("pwd");
		String hostIp = multipartRequest.getParameter("hostIp")==null ? "" : multipartRequest.getParameter("hostIp");
		String content = multipartRequest.getParameter("content")==null ? "" : multipartRequest.getParameter("content");
		
		// 비밀번호 암호화(SHA256) - salt 적용처리하지 않음
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		// 가공처리된 모든 자료들을 VO에 담아서 DB에 저장한다.
		GalleryVO vo = new GalleryVO();
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setfName(oFileName);
		vo.setfSName(fSName);
		vo.setfSize(fSize);
		vo.setTitle(title);
		vo.setPart(part);
		vo.setOpenSw(openSw);
		vo.setPwd(pwd);
		vo.setHostIp(hostIp);
		vo.setContent(content);
		
		GalleryDAO dao = new GalleryDAO();
		int res = dao.setGalleryInputOk(vo);
		
		if(res != 0) {
			request.setAttribute("message", "갤러리에 자료가 업로드 되었습니다.");
			request.setAttribute("url", "BoardList.gal");
		}
		else {
			request.setAttribute("message", "자료실에 자료 업로드 실패~~");
			request.setAttribute("url", "BoardInput.gal");
		}
	}

}
