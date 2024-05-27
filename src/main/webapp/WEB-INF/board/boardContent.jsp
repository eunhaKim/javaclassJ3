<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert</title>
	<%@ include file = "/include/bs4.jsp" %>
	<style>
	.content .row{border-bottom:1px solid #ddd; }
	.content .row div{padding:10px;}
	.content .row .field{background: #f9f9f9;}
	</style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<!-- Breadcrumb Start -->
	<div class="container-fluid">
	    <div class="row px-xl-5">
	        <div class="col-12">
	            <nav class="breadcrumb bg-light mb-30">
	                <a class="breadcrumb-item text-dark" href="${ctp}/Main">Home</a>
	                <a class="breadcrumb-item text-dark">Community</a>
	                <span class="breadcrumb-item active">영화추천</span>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	<!-- Contact Start -->
  <div class="container-fluid">
    <h2 class="section-title position-relative mx-xl-5 mb-4"><span class="bg-secondary pr-3">게시글보기</span></h2>
    <div class="row px-xl-5">
      <div class="col-lg-7 mb-5">
        <div class="bg-light p-30 content">
        	<div class="row">
        		<div class="col-sm-12 text-right"><a href="javascript:goodCheck()">❤</a> 좋아요 : ${vo.good}</div>
        	</div>
        	<div class="row">
        		<div class="col-sm-3 field">제목 : </div>
        		<div class="col-sm-9">${vo.title}</div>
        	</div>
        	<div class="row">
        		<div class="col-sm-3 field">글쓴이 : </div>
        		<div class="col-sm-3">${vo.nickName}</div>
        		<div class="col-sm-3 field">조회수 : </div>
        		<div class="col-sm-3">${vo.readNum}</div>
        	</div>
        	<div class="row">
        		<div class="col-sm-3 field">글쓴날짜 : </div>
        		<div class="col-sm-3">${fn:substring(vo.wDate, 0, 16)}</div>
        		<div class="col-sm-3 field">접속IP : </div>
        		<div class="col-sm-3">${vo.hostIp}</div>
        	</div>
        	<div class="row">
        		<div class="col-sm-3 field">내용 : </div>
        		<div class="col-sm-9">${fn:replace(vo.content, newLine, "<br/>")}</div>
        	</div>
        	
        </div>
      </div>
      <div class="col-lg-5 mb-5">
          <div class="bg-light p-30 mb-30">
              <img class="img-fluid h-100" src="${ctp}/images/board/${vo.listImgfSName}" alt="${curScrStartNo}번글 리스트 이미지">
          </div>
      </div>
    </div>
  </div>
  <!-- Contact End -->
<jsp:include page="/include/footer.jsp" />
</body>
</html>