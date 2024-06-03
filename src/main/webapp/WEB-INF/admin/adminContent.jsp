<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>adminContent.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <style type="text/css">
  	.container-fluid{margin-top:40px;}
  </style>
</head>
<body>
<!-- Breadcrumb Start -->
	<div class="container-fluid">
	    <div class="row px-xl-5">
	        <div class="col-12">
	            <nav class="breadcrumb bg-light">
	                <a class="breadcrumb-item text-dark" href="AdminMain.ad" target="_top">관리자페이지</a>
	                <span class="breadcrumb-item active">관리자메인</span>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	
	<!-- Contact Start -->
  <div class="container-fluid">
    <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">관리자 메인</span></h2>
    <div class="row px-xl-5">
      <div class="col-lg-12 mb-5">
        <div class="bg-light p-30">
				  <!-- 
				    - 방명록은 최근 1주일안에 작성된글의 개수를 보여준다.
				    - 게시판은....__________
				    - 신규등록건수 출력
				    - 탈퇴신청회원 건수 출력 
				  -->
				  <p>신규등록회원 : <a href="MemberList.ad?level=1"><b>${mCount}</b></a>건</p>
				  <p>탈퇴신청회원 : <a href="MemberList.ad?level=99"><b>${m99Count}</b></a>건</p>
				  <p>신고글 : <a href="ComplaintList.ad" target="adminContent"><b>${complaintCnt}</b></a>건</p>
				  <!-- <p>게시글 새글 : ???</p>
				  <p>댓글 새글 : ???</p>
				  <p>방명록 새글 : ???</p> -->
				</div>
			</div>
		</div>
	</div>
						
</body>
</html>