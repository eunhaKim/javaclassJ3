<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>방명록리스트</title>
	<%@ include file = "/include/bs4.jsp" %>
	<style>
		.card-body {min-height:100px; padding-top:40px}
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
	                <span class="breadcrumb-item active">방명록리스트</span>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	
	<!-- Contact Start -->
  <div class="container-fluid">
      <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">방명록리스트</span></h2>
      
      <div class="row mx-xl-5 mb-4">
          <div class="col-12 text-right">
          	<a href="GuestInput.gu" class="btn btn-primary">방명록 글쓰기</a>
          </div> 
      </div>
      
      <div class="row px-xl-5">
        <c:forEach var="vo" items="${vos}" varStatus="st">
        	<div class="col-xl-3 col-lg-4 col-sm-6 mb-5">
        		<div class="card bg-light ">
	        		<div class="card-header d-flex align-items-center justify-content-between">
	        			<div><i class="fa-solid fa-user text-primary mr-2"></i>${vo.name}</div>
	        			<div><a href="GuestContent.gu?idx=${vo.idx}" class="btn btn-sm btn-dark ml-auto">상세보기</a></div>
	        		</div>
	        		<div class="card-body text-center"><i class="fa-regular fa-comments mr-2"></i>
	        			<c:if test="${fn:length(vo.content) <= 20}">${vo.content}</c:if>
	        			<c:if test="${fn:length(vo.content) > 20}">${fn:substring(vo.content,0,20)}..</c:if>
	        		</div>
	        	</div>
	        </div>
        </c:forEach>
	    </div>
	    
	    <!-- 블록페이지 시작 -->       
			<div class="text-center mt-5 mb-5">
			  <c:if test="${pag > 1}"><a href="GuestList.gu?pag=1&pageSize=${pageSize}" class="btn btn-sm btn-light border">첫페이지</a></c:if>
			  <c:if test="${curBlock > 0}"><a href="GuestList.gu?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}" class="btn btn-light btn-sm border"><</a></c:if>
			  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
			    <c:if test="${i <= totPage}">
			    	<c:if test="${pag==i}"><a href="GuestList.gu?pag=${i}&pageSize=${pageSize}" class="btn btn-primary btn-sm border">${i}</a></c:if>
			  		<c:if test="${pag!=i}"><a href="GuestList.gu?pag=${i}&pageSize=${pageSize}" class="btn btn-light btn-sm border">${i}</a></c:if>
			  	</c:if>
			  </c:forEach>
			  <c:if test="${curBlock < lastBlock}"><a href="GuestList.gu?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}" class="btn btn-light btn-sm border">></a></c:if>
			  <c:if test="${pag < totPage}"><a href="GuestList.gu?pag=${totPage}&pageSize=${pageSize}" class="btn btn-sm btn-light border">마지막페이지</a></c:if>
			  
			</div>
			<!-- 블록페이지 끝 -->
      
  </div>
  <!-- Contact End -->
	
	<%@ include file = "/include/footer.jsp" %>
</body>
</html>