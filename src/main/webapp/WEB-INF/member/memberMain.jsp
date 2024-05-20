<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberMain.jsp</title>
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
	                <span class="breadcrumb-item active">회원정보</span>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	
	<!-- Contact Start -->
  <div class="container-fluid">
      <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">${mVo.nickName}님 회원정보</span></h2>
      <div class="row px-xl-5">
          <div class="col-xl-4 col-lg-6 col-md-6 mb-5">
              <div class="bg-light p-30">
                  <div class="card" >
								    <img class="card-img-top" src="${ctp}/images/member/${mVo.photo}" alt="Card image" style="width:100%">
								    <div class="card-body">
								      <h4 class="card-title">ID : ${mVo.mid} <span class="badge badge-primary" style="vertical-align:top">Level : ${mVo.level}</span></h4>
								      <p class="card-text">${mVo.name}님 입니다. 최초 가입일은 ${fn:substring(mVo.startDate,0,10)}이고, 총 방문횟수는 ${mVo.visitCnt}번, 오늘 방문횟수는 ${mVo.todayCnt}번 입니다.</p>
								      <p class="card-text"><i class="fa fa-envelope text-primary mr-3"></i>${mVo.email}</p>
								      <%-- <p class="card-text"><i class="fa fa-phone-alt text-primary mr-3"></i>${mVo.tel}</p> --%>
								      <p class="card-text"><i class="fa-solid fa-coins text-primary mr-3"></i>${mVo.point} point</p>
								    </div>
								  </div>
              </div>
          </div>
          <div class="col-xl-8 col-lg-6 col-md-6 mb-5">
              <div class="bg-light p-30 mb-30">
                  <p>회원정보..내가쓴글..댓글..좋아요..총방문수...</p>
              </div>
          </div>
      </div>
  </div>
  <!-- Contact End -->
	
	<%@ include file = "/include/footer.jsp" %>
</body>
</html>