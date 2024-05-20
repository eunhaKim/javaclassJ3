<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberPwdDeleteCheck.jsp</title>
	<%@ include file = "/include/bs4.jsp" %>
	<script>
    'use strict';
    
    function pwdDeleteCheck() {
    	let pwd = $("#pwd").val().trim();
    	if(pwd == "") {
    		alert("현재 비밀번호를 입력하세요!");
    		$("#pwd").focus();
    		// return false;
    	}
    	else {
    		let ans = confirm("회원 탈퇴신청 하시겠습니까?");
    		if(ans) {
    			ans = confirm("회원 탈퇴하시면 1개월간 같은 아이디로 가입하실수 없습니다.\n계속 진행하시겠습니까?");
    			if(ans) myform.submit();
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
	                <span class="breadcrumb-item active">회원탈퇴</span>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	
	<!-- Contact Start -->
  <div class="container-fluid">
      <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">회원탈퇴</span></h2>
      <form name="myform" method="post" action="MemberDeleteCheckOk.mem">
	      <div class="row px-xl-5">
	          <div class="col-lg-6 mb-5">
	              <div class="bg-light p-30">
							      <p><i class="fa-solid fa-comment-dots text-primary"></i> 회원 탈퇴를 하기위해 현재 비밀번호를 확인합니다.</p>
	                  <input type="password" name="pwd" id="pwd" class="form-control" autofocus required />
	              </div>
	              <div class="bg-light mt-3  p-30">
	                  <input type="button" value="비밀번호확인" onclick="pwdDeleteCheck()" class="btn btn-primary mr-2"/>
					          <input type="reset" value="다시입력" class="btn btn-secondary mr-2"/>
					          <input type="button" value="돌아가기" onclick="location.href='MemberMain.mem';" class="btn btn-secondary"/>
	              </div>
	          </div>
	          <div class="col-lg-6 mb-5">
	              <div class="bg-light p-30 mb-30">
	                  네이버 카카오톡 구글 로그인...
	              </div>
	          </div>
	      </div>
      </form>
  </div>
  <!-- Contact End -->
	
	<%@ include file = "/include/footer.jsp" %>
</body>
</html>