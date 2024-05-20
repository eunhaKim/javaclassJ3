<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<% pageContext.setAttribute("newLine", "\n"); %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>방명록리스트</title>
	<%@ include file = "/include/bs4.jsp" %>
	<style>
	.list-group li:nth-child(2) {min-height:200px;}
	</style>
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
	                <a class="breadcrumb-item text-dark">방명록</a>
	                <span class="breadcrumb-item active">방명록상세보기</span>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	
	<!-- Contact Start -->
  <div class="container-fluid">
      <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">방명록상세보기</span></h2>
      <div class="row px-xl-5">
          <div class="col-lg-6 mb-5">
              <div class="bg-light p-30">
                  <ul class="list-group list-group-flush">
                  	<li class="list-group-item list-group-item-light"><i class="fa-solid fa-user text-primary mr-2"></i>작성자 : ${vo.name}</li>
                  	<li class="list-group-item">${fn:replace(vo.content, newLine, "<br/>")}</li>
                  	<c:if test="${vo.email != ''}"><li class="list-group-item"><i class="fa-regular fa-envelope text-primary mr-2"></i>이메일 : ${vo.email}</li></c:if>
                  	<c:if test="${vo.homePage != 'https://'}"><li class="list-group-item"><i class="fa-solid fa-house text-primary mr-2"></i>홈페이지 : ${vo.homePage}</li></c:if>
                  	<%-- <li class="list-group-item">접속IP : ${vo.hostIp}</li> --%>
                  	<li class="list-group-item"><i class="fa-regular fa-calendar text-primary mr-2"></i>작성일 : ${fn:substring(vo.visitDate,0,19)}</li>
                  </ul>
              </div>
              <div class="mt-3 text-right">
				          <a href="GuestList.gu" class="btn btn-primary">목록보기</a> 
				      </div>
          </div>
          <div class="col-lg-6 mb-5">
              <div class="bg-light p-30 mb-30">
                  방명록 등록 이미지
              </div>
          </div>
      </div>
  </div>
  <!-- Contact End -->
	
	<%@ include file = "/include/footer.jsp" %>
</body>
</html>