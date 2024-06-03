<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>adminLeft.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <style>
  	body{background:#333;}
  	#logo{margin:85px 0; font-size: 24px;}
  	.btn{border-top:1px solid #333; border-right:1px solid #333;}
  </style>
</head>
<body>
<div class="text-center">
	<div class="" id="logo">
    <a href="${ctp}/Main" target="_top" class="text-decoration-none text-white">
      <span><i class="fa-solid fa-video text-primary mr-2"></i>Movie Review</span>
    </a>
  </div>
  <div>
    <a class="btn btn-dark form-control" href="${ctp}/Main" target="_top">홈으로</a>
  </div>
  <div>
    <a class="btn btn-warning form-control" href="AdminMain.ad" target="_top">관리자메인</a>
  </div>
  <div>
    <button type="button" class="btn btn-primary form-control" data-toggle="collapse" data-target="#member">회원관리</button>
    <div id="member" class="collapse" >
    	<a href="MemberList.ad" target="adminContent" class="form-control btn btn-secondary">회원리스트</a>
    </div>
  </div>
  <div>
    <button type="button" class="btn btn-primary form-control" data-toggle="collapse" data-target="#board">게시판</button>
    <div id="board" class="collapse" >
    	<a href="BoardList.ad?bName=movieNews" target="adminContent" class="form-control btn btn-secondary">영화소식</a>
    	<a href="BoardList.ad?bName=movieRecommend" target="adminContent" class="form-control btn btn-secondary">영화추천</a>
    	<a href="BoardList.ad?bName=movieTogether" target="adminContent" class="form-control btn btn-secondary">영화같이보러가요</a>
    	<a href="ComplaintList.ad" target="adminContent" class="form-control btn btn-secondary">신고리스트</a>
    </div>
  </div>
  <%-- <div>
    <button type="button" class="btn btn-primary form-control" data-toggle="collapse" data-target="#reply">댓글</button>
    <div id="reply" class="collapse" >
    	<a href="${ctp}/GuestList" target="adminContent" class="form-control btn btn-secondary">댓글리스트</a>
    </div>
  </div>
  <div>
    <button type="button" class="btn btn-primary form-control" data-toggle="collapse" data-target="#guest">방명록</button>
    <div id="guest" class="collapse" >
    	<a href="${ctp}/GuestList" target="adminContent" class="form-control btn btn-secondary">방명록리스트</a>
    </div>
  </div> --%>
</div>
<p><br/></p>
</body>
</html>