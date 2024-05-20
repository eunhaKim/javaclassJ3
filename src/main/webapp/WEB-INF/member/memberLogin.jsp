<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%
	// 로그인창에 아이디 체크 유무에 대한 처리
	// 쿠키를 검색해서 cMid가 있을때 가져와서 아이디입력창에 뿌릴수 있게 한다.
	Cookie[] cookies = request.getCookies();

	if(cookies != null) {
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				pageContext.setAttribute("mid", cookies[i].getValue());
				break;
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberLogin.jsp</title>
	<%@ include file = "/include/bs4.jsp" %>
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
	                <span class="breadcrumb-item active">로그인</span>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	
	<!-- Contact Start -->
  <div class="container-fluid">
      <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">Login</span></h2>
      <div class="row px-xl-5">
          <div class="col-lg-6 mb-5">
              <div class="bg-light p-30">
                  <div id="success"></div>
                  <form name="myform" id="myform method="post" action="MemberLoginOk.mem" novalidate="novalidate">
                      <div class="control-group">
                          <input type="text" class="form-control" id="mid" name="mid" placeholder="Your Id" value="${mid}"
                              required="required" data-validation-required-message="Please enter your id" />
                          <p class="help-block text-danger"></p>
                      </div>
                      <div class="control-group">
                          <input type="password" class="form-control" id="pwd" name="pwd" placeholder="Your Password"
                              value="1234" required="required" data-validation-required-message="Please enter your password" />
                          <p class="help-block text-danger"></p>
                      </div>
                      
                      <div>
                          <div class="custom-control custom-switch">
	                          <input type="checkbox" name="idSave"  id="switch1" class="custom-control-input" checked />
	                          <label class="custom-control-label" for="switch1">아이디 저장</label>
	                        </div> 
                          <button class="btn btn-primary py-2 px-4 mt-2 form-control" type="submit" id="sendMessageButton">로그인</button>
                      </div>
                  </form>
              </div>
              <div class="bg-light mt-3  p-30">
                  <a href="MemberJoin.mem"><i class="fa-solid fa-user text-primary mr-3"></i>회원가입</a> 
                  <i class="fa-solid fa-magnifying-glass text-primary mr-3 ml-3"></i>아이디 / 패스워드 찾기
              </div>
          </div>
          <div class="col-lg-6 mb-5">
              <div class="bg-light p-30 mb-30">
                  네이버 카카오톡 구글 로그인...
              </div>
          </div>
      </div>
  </div>
  <!-- Contact End -->
	
	<%@ include file = "/include/footer.jsp" %>
</body>
</html>