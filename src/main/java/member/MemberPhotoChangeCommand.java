package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.SecurityUtil;

public class MemberPhotoChangeCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String photo = "";
		// 파일 업로드
		String realPath = request.getServletContext().getRealPath("/images/member");
		int maxSize = 1024 * 1024 * 2;	// 서버에 저장시킬 파일의 최대용량 : 2MByte로 제한(1회저장용량)
		String encoding = "UTF-8";
		
		// 파일 업로드 처리...(객체 생성시 파일이 자동으로 업로드 된다.)
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		if(multipartRequest.getOriginalFileName("fName")!=null) {
			// 업로드된 파일의 정보를 추출해본다.
			String originalFileName = multipartRequest.getOriginalFileName("fName");
			String filesystemName = multipartRequest.getFilesystemName("fName");
			
			System.out.println("원본 파일명 : " + originalFileName);
			System.out.println("서버에 저장된 파일명 : " + filesystemName);
			System.out.println("서버에 저장된 파일경로 : " + realPath);
			
			// BackEnd 파일체크
			if(originalFileName != null && !originalFileName.equals("")) {
				System.out.println("파일 전송완료!!");
			}
			else {
				System.out.println("파일 전송실패~~~");
			}
			photo = filesystemName;
		} 
		else photo = "noimage.jpg";
		
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		MemberDAO dao = new MemberDAO();
		int res = dao.updateMemberPhoto(mid, photo);
		
  	
		
		response.getWriter().write(res+"");
	}

}
