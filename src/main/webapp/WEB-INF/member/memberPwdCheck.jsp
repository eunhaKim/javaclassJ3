<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberPwdCheck.jsp</title>
	<%@ include file = "/include/bs4.jsp" %>
	<script>
    'use strict';
    
    $(function(){
    	$("#pwdDemo").hide();
    });
    
    function pwdReCheck() {
    	let pwd = $("#pwd").val().trim();
    	if(pwd == "") {
    		alert("현재 비밀번호를 입력하세요!");
    		$("#pwd").focus();
    		return false;
    	}
    	
    	$.ajax({
    		url  : "MemberPwdCheckAjax.mem",
    		type : "post",
    		data : {pwd : pwd},
    		success:function(res) {
    			if(res != "0") $("#pwdDemo").show();
    			else alert("비밀번호가 틀립니다. 확인해주세요");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    function pwdChangeCheck() {
    	let pwdCheck = $("#pwdCheck").val();
    	let pwdCheckRe = $("#pwdCheckRe").val();
    	
    	if(pwdCheck.trim() == "" || pwdCheckRe.trim() == "") {
    		alert("변경할 비밀번호를 입력하세요");
    		$("#pwdCheck").focus();
    		return false;
    	}
    	else if(pwdCheck.trim() != pwdCheckRe.trim()) {
    		alert("새로 입력한 비밀번호가 틀립니다. 확인하세요");
    		$("#pwdCheck").focus();
    		return false;
    	}
    	else {
    		pwdForm.submit();
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
	                <span class="breadcrumb-item active">비밀번호확인</span>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	
	<!-- Contact Start -->
  <div class="container-fluid">
      <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">비밀번호확인</span></h2>
	      <div class="row px-xl-5">
          <div class="col-lg-6 mb-5">
			      <form name="myform" method="post" action="MemberPwdCheckOk.mem">
	            <div class="bg-light p-30">
						    <p><i class="fa-solid fa-comment-dots text-primary"></i> 회원정보수정을 하기위해 현재 비밀번호를 확인합니다.</p>
	              <input type="password" name="pwd" id="pwd" class="form-control mb-3" autofocus required />
	              <input type="button" value="비밀번호변경" onclick="pwdReCheck()" class="btn btn-primary mr-2"/>
			          <input type="submit" value="회원정보변경" class="btn btn-primary mr-2"/>
			          <input type="reset" value="다시입력" class="btn btn-secondary mr-2"/>
	            </div>
            </form>
            <div class="bg-light mt-3  p-30" id="pwdDemo">
	            <form name="pwdForm" method="post" action="MemberPwdChangeCheck.mem">
						    <p><i class="fa-solid fa-comment-dots text-primary"></i> 변경할 비밀번호를 입력하세요.</p>
	              <input type="password" name="pwdCheck" id="pwdCheck" class="form-control"/>
						    <p><i class="fa-solid fa-comment-dots text-primary mt-4"></i> 비밀번호 확인 : </p>
	              <input type="password" name="pwdCheckRe" id="pwdCheckRe" class="form-control"/>
	              
	              <input type="button" value="비밀번호변경하기" onclick="pwdChangeCheck()" class="btn btn-primary form-control mt-3"/>
	            </form>
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