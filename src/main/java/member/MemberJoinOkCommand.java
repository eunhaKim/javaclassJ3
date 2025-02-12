package member;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.SecurityUtil;

public class MemberJoinOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String photo = "";
		// 파일 업로드
		String realPath = request.getServletContext().getRealPath("/images/member");
		int maxSize = 1024 * 1024 * 10;	// 서버에 저장시킬 파일의 최대용량 : 10MByte로 제한(1회저장용량)
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
			
			// 닉네임 받아서 찍어보기
			// String nickName = request.getParameter("nickName");
			// String nickName = multipartRequest.getParameter("nickName");
			// System.out.println("nickName : " + nickName);
			
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
		
		String mid = multipartRequest.getParameter("mid")==null? "" : multipartRequest.getParameter("mid");
		String pwd = multipartRequest.getParameter("pwd")==null? "" : multipartRequest.getParameter("pwd");
		String nickName = multipartRequest.getParameter("nickName")==null? "" : multipartRequest.getParameter("nickName");
		String name = multipartRequest.getParameter("name")==null? "" : multipartRequest.getParameter("name");
		String gender = multipartRequest.getParameter("gender")==null? "" : multipartRequest.getParameter("gender");
		String birthday = multipartRequest.getParameter("birthday")==null? "" : multipartRequest.getParameter("birthday");
		String tel = multipartRequest.getParameter("tel")==null? "" : multipartRequest.getParameter("tel");
		String address = multipartRequest.getParameter("address")==null? "" : multipartRequest.getParameter("address");
		String email = multipartRequest.getParameter("email")==null? "" : multipartRequest.getParameter("email");
		String homePage = multipartRequest.getParameter("homePage")==null? "" : multipartRequest.getParameter("homePage");
		String job = multipartRequest.getParameter("job")==null? "" : multipartRequest.getParameter("job");
		//String hobby = request.getParameter("hobby")==null? "" : request.getParameter("hobby");
		
		String content = multipartRequest.getParameter("content")==null? "" : multipartRequest.getParameter("content");
		String userInfor = multipartRequest.getParameter("userInfor")==null? "" : multipartRequest.getParameter("userInfor");
		
		String[] hobbys = multipartRequest.getParameterValues("hobby");
		String hobby = "";
		if(hobbys.length != 0) {
			for(String h : hobbys) {
				hobby += h + "/";
			}
		}
		hobby = hobby.substring(0, hobby.lastIndexOf("/"));
		
		// DB에 저장시킨자료중 not null 데이터는 Back End 체크시켜준다.
		
		// 아이디/닉네임 중복체크....
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberIdCheck(mid);
		if(vo.getMid() != null) {
			request.setAttribute("message", "이미 사용중인 아이디 입니다.");
			request.setAttribute("url", "MemberJoin.mem");
			return;
		}
		
		vo = dao.getMemberNickCheck(nickName);
		if(vo.getNickName() != null) {
			request.setAttribute("msg", "이미 사용중인 닉네임 입니다.");
			request.setAttribute("url", "MemberJoin.mem");
			return;
		}
		
		
		
		// 비밀번호 암호화(sha256) - salt키를 만든후 암호화 시켜준다.(uuid코드중 앞자리 8자리 같이 병행처리후 암호화시킨다.)
		// uuid를 통한 salt키 만들기(앞에서 8자리를 가져왔다.)
		String salt = UUID.randomUUID().toString().substring(0,8);
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt + pwd);
		
		pwd = salt + pwd;
		
		// 모든 체크가 끝난 자료는 vo에 담아서 DB에 저장처리한다.
		vo = new MemberVO();
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setNickName(nickName);
		vo.setName(name);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setEmail(email);
		vo.setHomePage(homePage);
		vo.setJob(job);
		vo.setHobby(hobby);
		vo.setPhoto(photo);
		vo.setContent(content);
		vo.setUserInfor(userInfor);
		
		int res = dao.setMemberJoinOk(vo);
		
		if(res != 0) {
			request.setAttribute("message", "회원 가입되셨습니다.\\n다시 로그인해 주세요.");
			request.setAttribute("url", "MemberLogin.mem");
		}
		else {
			request.setAttribute("message", "회원 가입 실패~~");
			request.setAttribute("url", "MemberJoin.mem");
		}
	}
}
