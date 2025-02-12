<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberJoin.jsp</title>
	<%@ include file = "/include/bs4.jsp" %>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
    'use strict';
    
    let idCheckSw = 0;
    let nickCheckSw = 0;
    
    function fCheck() {
    	// 유효성 검사.....
    	// 아이디,닉네임,성명,이메일,홈페이지,전화번호,비밀번호 등등....
    	
    	// 정규식을 이용한 유효성검사처리.....
    	let regMid = /^[a-zA-Z0-9_]{4,20}$/;	// 아이디는 4~20의 영문 대/소문자와 숫자와 밑줄 가능
      let regNickName = /^[가-힣]+$/;					// 닉네임은 한글만 가능
      let regName = /^[가-힣a-zA-Z]+$/;				// 이름은 한글/영문 가능
    	
    	
    	// 검사를 끝내고 필요한 내역들을 변수에 담아 회원가입처리한다.
    	let mid = myform.mid.value.trim();
    	let pwd = myform.pwd.value.trim();
    	let nickName = myform.nickName.value;
    	let name = myform.name.value;
    	
    	let email1 = myform.email1.value.trim();
    	let email2 = myform.email2.value;
    	let email = email1 + "@" + email2;
    	
    	let tel1 = myform.tel1.value;
    	let tel2 = myform.tel2.value.trim();
    	let tel3 = myform.tel3.value.trim();
    	let tel = tel1 + "-" + tel2 + "-" + tel3;
    	
    	let postcode = myform.postcode.value + " ";
    	let roadAddress = myform.roadAddress.value + " ";
    	let detailAddress = myform.detailAddress.value + " ";
    	let extraAddress = myform.extraAddress.value + " ";
    	let address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
    	
    	if(!regMid.test(mid)) {
    		alert("아이디는 4~20자리의 영문 소/대문자와 숫자, 언더바(_)만 사용가능합니다.");
    		myform.mid.focus();
    		return false;
    	}
    	else if(pwd.length < 4 && pwd.length > 20) {
        alert("비밀번호는 4~20 자리로 작성해주세요.");
        myform.pwd.focus();
        return false;
      }
      else if(!regNickName.test(nickName)) {
        alert("닉네임은 한글만 사용가능합니다.");
        myform.nickName.focus();
        return false;
      }
      else if(!regName.test(name)) {
        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
        myform.name.focus();
        return false;
      }
			// 이메일 주소형식체크
			
			// 홈페이지 주소형식체크
			
			// 전화번호 형식 체크
			if(tel2 != "" && tel != ""){
				// 전화번호 정규화 체크
			}
			else{
				tel2 = " ";
				tel3 = " ";
				tel = tel1 + "-" + tel2 + "-" + tel3;
			}
			
	    	
    	if(idCheckSw == 0) {
    		alert("아이디 중복체크버튼을 눌러주세요");
    		document.getElementById("midBtn").focus();
    	}
    	else if(nickCheckSw == 0) {
    		alert("닉네임 중복체크버튼을 눌러주세요");
    		document.getElementById("nickNameBtn").focus();
    	}
    	else {
    		myform.email.value = email;
    		myform.tel.value = tel;
    		myform.address.value = address;
    		
    		myform.submit();
    	}
    }
    
    // 아이디 중복체크
    function idCheck() {
    	let mid = myform.mid.value;
    	
    	if(mid.trim() == "") {
    		alert("아이디를 입력하세요!");
    		myform.mid.focus();
    	}
    	else {
    		idCheckSw = 1;
    		
    		$.ajax({
    			url  : "${ctp}/MemberIdCheck.mem",
    			type : "get",
    			data : {mid : mid},
    			success:function(res) {
    				if(res != '0') {
    					alert("이미 사용중인 아이디 입니다. 다시 입력하세요.");
    					myform.mid.focus();
    				}
    				else alert("사용 가능한 아이디 입니다.");
    			},
    			error : function() {
    				alert("전송 오류!");
    			}
    		});
    	}
    }
    
    // 닉네임 중복체크
    function nickCheck() {
    	let nickName = myform.nickName.value;
    	
    	if(nickName.trim() == "") {
    		alert("닉네임을 입력하세요!");
    		myform.nickName.focus();
    	}
    	else {
    		nickCheckSw = 1;
    		
    		$.ajax({
    			url  : "${ctp}/MemberNickCheck.mem",
    			type : "get",
    			data : {nickName : nickName},
    			success:function(res) {
    				if(res != '0') {
    					alert("이미 사용중인 닉네임 입니다. 다시 입력하세요.");
    					myform.nickName.focus();
    				}
    				else alert("사용 가능한 닉네임 입니다.");
    			},
    			error : function() {
    				alert("전송 오류!");
    			}
    		});
    	}
    }
    
    
    $(function(){
    	$("#mid").on("blur", () => {
    		idCheckSw = 0;
    	});
    	
    	$("#nickName").on("blur", () => {
    		nickCheckSw = 0;
    	});
    	
    });
    
 		// 파일 업로드 체크 & 선택된 그림 미리보기 
    function imgCheck(e) {
			let fName = document.getElementById("file").value;
			
			let maxSize = 1024 * 1024 * 2;	// 기본 단위 : Byte,   1024 * 1024 * 10 = 10MByte 허용
			let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
			
			let fileSize = document.getElementById("file").files[0].size;
			if(fileSize > maxSize) {
				alert("업로드할 파일의 최대용량은 2MByte입니다.");
				document.getElementById("file").value="";
				return false;
			}
			else if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
				alert("업로드 가능한 파일은 'jpg/gif/png'만 가능합니다.");
				document.getElementById("file").value="";
				return false;
			}
			else{
	    	if(e.files && e.files[0]) {
	    		let reader = new FileReader();
	    		reader.onload = function(e) {
	    			document.getElementById("demoImg").src = e.target.result;
	    		}
	    		reader.readAsDataURL(e.files[0]);
	    	}
			}
    }
  </script>
</head>
<body>
	<%@ include file = "/include/header.jsp" %>
	<%@ include file = "/include/nav.jsp" %>
	
	<!-- Breadcrumb Start -->
	<div class="container-fluid">
	    <div class="row px-xl-5">
	        <div class="col-12">
	            <nav class="breadcrumb bg-light mb-30">
	                <a class="breadcrumb-item text-dark" href="${ctp}/Main">Home</a>
	                <a class="breadcrumb-item text-dark">My Account</a>
	                <span class="breadcrumb-item active">회원가입</span>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	
	<!-- Contact Start -->
  <div class="container-fluid">
      <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">회원가입</span></h2>
      <div class="row px-xl-5">
          <div class="col-lg-8 mb-5">
              <div class="bg-light p-30">
                  <form name="myform" method="post" action="${ctp}/MemberJoinOk.mem" class="was-validated" enctype="multipart/form-data">
								    <div class="form-group">
								      <label for="mid">아이디 : &nbsp; &nbsp;<input type="button" value="아이디 중복체크" id="midBtn" class="btn btn-primary btn-sm" onclick="idCheck()"/></label>
								      <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." required autofocus/>
								    </div>
								    <div class="form-group">
								      <label for="pwd">비밀번호 :</label>
								      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required />
								    </div>
								    <div class="form-group">
								      <label for="nickName">닉네임 : &nbsp; &nbsp;<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="btn btn-primary btn-sm" onclick="nickCheck()"/></label>
								      <input type="text" class="form-control" id="nickName" placeholder="별명을 입력하세요." name="nickName" required />
								    </div>
								    <div class="form-group">
								      <label for="name">성명 :</label>
								      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required />
								    </div>
								    <div class="form-group">
								      <label for="email1">Email address:</label>
								        <div class="input-group mb-3">
								          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
								          <div class="input-group-append">
								            <select name="email2" class="custom-select">
								              <option value="naver.com" selected>naver.com</option>
								              <option value="hanmail.net">hanmail.net</option>
								              <option value="hotmail.com">hotmail.com</option>
								              <option value="gmail.com">gmail.com</option>
								              <option value="nate.com">nate.com</option>
								              <option value="yahoo.com">yahoo.com</option>
								            </select>
								          </div>
								        </div>
								    </div>
								    <div class="form-group">
								        <label for="gender" class="mb-0">성별 :</label>
								        <div class="custom-control custom-radio custom-control-inline ml-3">
											    <input type="radio" class="custom-control-input" id="gender1" name="gender" value="남자" checked>
											    <label class="custom-control-label" for="gender1">남자</label>
											  </div>
											  <div class="custom-control custom-radio custom-control-inline">
											    <input type="radio" class="custom-control-input" id="gender2" name="gender" value="여자">
											    <label class="custom-control-label" for="gender2">여자</label>
											  </div>
										</div>
								    <div class="form-group">
								      <label for="birthday">생일</label>
								      <input type="date" name="birthday" value="<%=java.time.LocalDate.now() %>" class="form-control"/>
								    </div>
								    <div class="form-group">
								      <div class="input-group mb-3">
								        <div class="input-group-prepend">
								          <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
								            <select name="tel1" class="custom-select">
								              <option value="010" selected>010</option>
								              <option value="02">서울</option>
								              <option value="031">경기</option>
								              <option value="032">인천</option>
								              <option value="041">충남</option>
								              <option value="042">대전</option>
								              <option value="043">충북</option>
								              <option value="051">부산</option>
								              <option value="052">울산</option>
								              <option value="061">전북</option>
								              <option value="062">광주</option>
								            </select>-
								        </div>
								        <input type="text" name="tel2" size=4 maxlength=4 class="form-control"/>-
								        <input type="text" name="tel3" size=4 maxlength=4 class="form-control"/>
								      </div>
								    </div>
								    <div class="form-group">
								      <label for="address">주소</label>
								      <div class="input-group mb-1">
								        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
								        <div class="input-group-append">
								          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
								        </div>
								      </div>
								      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
								      <div class="input-group mb-1">
								        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
								        <div class="input-group-append">
								          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
								        </div>
								      </div>
								    </div>
								    <div class="form-group">
								      <label for="homepage">Homepage address:</label>
								      <input type="text" class="form-control" name="homePage" value="http://" placeholder="홈페이지를 입력하세요." id="homePage"/>
								    </div>
								    <div class="form-group">
								      <label for="name">직업</label>
								      <select class="form-control" id="job" name="job">
								        <!-- <option value="">직업선택</option> -->
								        <option>학생</option>
								        <option>회사원</option>
								        <option>공무원</option>
								        <option>군인</option>
								        <option>의사</option>
								        <option>법조인</option>
								        <option>세무인</option>
								        <option>자영업</option>
								        <option selected>기타</option>
								      </select>
								    </div>
								    <div class="form-group">
								      <div class="form-check-inline">
								        <span class="input-group-text">취미</span> &nbsp; &nbsp;
								        <label class="form-check-label">
								          <input type="checkbox" class="form-check-input" value="등산" name="hobby"/>등산
								        </label>
								      </div>
								      <div class="form-check-inline">
								        <label class="form-check-label">
								          <input type="checkbox" class="form-check-input" value="낚시" name="hobby"/>낚시
								        </label>
								      </div>
								      <div class="form-check-inline">
								        <label class="form-check-label">
								          <input type="checkbox" class="form-check-input" value="수영" name="hobby"/>수영
								        </label>
								      </div>
								      <div class="form-check-inline">
								        <label class="form-check-label">
								          <input type="checkbox" class="form-check-input" value="독서" name="hobby"/>독서
								        </label>
								      </div>
								      <div class="form-check-inline">
								        <label class="form-check-label">
								          <input type="checkbox" class="form-check-input" value="영화감상" name="hobby"/>영화감상
								        </label>
								      </div>
								      <div class="form-check-inline">
								        <label class="form-check-label">
								          <input type="checkbox" class="form-check-input" value="바둑" name="hobby"/>바둑
								        </label>
								      </div>
								      <div class="form-check-inline">
								        <label class="form-check-label">
								          <input type="checkbox" class="form-check-input" value="축구" name="hobby"/>축구
								        </label>
								      </div>
								      <div class="form-check-inline">
								        <label class="form-check-label">
								          <input type="checkbox" class="form-check-input" value="기타" name="hobby" checked/>기타
								        </label>
								      </div>
								    </div>
								    <div class="form-group">
								      <label for="content">자기소개</label>
								      <textarea rows="5" class="form-control" id="content" name="content" placeholder="자기소개를 입력하세요."></textarea>
								    </div>
								    <div class="form-group">
								      <div class="form-check-inline">
								        <span class="input-group-text">정보공개</span>  &nbsp; &nbsp;
								        <label class="form-check-label">
								          <input type="radio" class="form-check-input" name="userInfor" value="공개" checked/>공개
								        </label>
								      </div>
								      <div class="form-check-inline">
								        <label class="form-check-label">
								          <input type="radio" class="form-check-input" name="userInfor" value="비공개"/>비공개
								        </label>
								      </div>
								    </div>
								    <div  class="form-group">
								      회원 사진(파일용량:2MByte이내) :
								      <input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control-file border" />
								       <img id="demoImg" width="200px"/>
								    </div>
								    <button type="button" class="btn btn-secondary" onclick="fCheck()">회원가입</button> &nbsp;
								    <button type="reset" class="btn btn-secondary">다시작성</button> &nbsp;
								    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/MemberLogin.mem';">돌아가기</button>
								    
								    <input type="hidden" name="email" />
								    <input type="hidden" name="tel" />
								    <input type="hidden" name="address" />
								  </form>
              </div>
          </div>
          <div class="col-lg-4 mb-5">
              <div class="bg-light p-30 mb-30">
                  <iframe src='https://tv.naver.com/embed/51146218' frameborder='no' scrolling='no' marginwidth='0' marginheight='0' WIDTH='100%' HEIGHT='400' allowfullscreen></iframe>
              </div>
          </div>
      </div>
  </div>
  <!-- Contact End -->
	
	<%@ include file = "/include/footer.jsp" %>
</body>
</html>