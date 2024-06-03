<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
  	.table.table-borderless thead tr, .table.table-borderless tbody tr:not(:last-child) {border-bottom:0;}
  </style>
  <script>
    'use strict';
    
  </script>
</head>
<body>
<!-- Breadcrumb Start -->
	<div class="container-fluid">
	    <div class="row px-xl-5">
	        <div class="col-12">
	            <nav class="breadcrumb bg-light">
	                <a class="breadcrumb-item text-dark" href="AdminMain.ad" target="_top">관리자페이지</a>
	                <a class="breadcrumb-item text-dark" href="#">게시판</a>
	                <a href="BoardList.ad?bName=${bName}" class="breadcrumb-item text-success">${bTextName}</a>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	
	<!-- Contact Start -->
  <div class="container-fluid">
    <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">${bTextName}</span></h2>
    <div class="row px-xl-5">
      <div class="col-lg-12 mb-5">
        <div class="bg-light p-30">
					<table class="table table-borderless m-0 p-0">
				    <tr>
				      <td colspan="2"><h2 class="text-center">${bTextName}</h2></td>
				    </tr>
				    <tr>
				      <td colspan="2" class="text-right">
				        <select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
				          <option ${pageSize==5  ? "selected" : ""}>5</option>
				          <option ${pageSize==10 ? "selected" : ""}>10</option>
				          <option ${pageSize==15 ? "selected" : ""}>15</option>
				          <option ${pageSize==20 ? "selected" : ""}>20</option>
				          <option ${pageSize==30 ? "selected" : ""}>30</option>
				        </select>
				      </td>
				    </tr>
				  </table>
				  <table class="table table-hover m-0 p-0 text-center">
				    <tr class="table-dark text-dark">
				      <th>글번호</th>
				      <th>글제목</th>
				      <th>글쓴이</th>
				      <th>글쓴날짜</th>
				      <th>조회수(좋아요)</th>
				    </tr>
				    <c:forEach var="vo" items="${vos}" varStatus="st">
				      <c:if test="${vo.openSw == 'OK' || sLevel == 0 || sNickName == vo.nickName}">
						    <tr>
						      <td>${vo.idx}</td>
						      <td class="text-left">
						        <a href="BoardContent.ad?bName=${bName}&idx=${vo.idx}&pag=${totPage}&pageSize=${pageSize}" class="text-dark">${vo.title}</a>
						        <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif" /></c:if>  
						      </td>
						      <td>${vo.nickName}</td>
						      <td>
						        <!-- 1일(24시간) 이내는 시간만 표시(10:43), 이후는 날짜와 시간을 표시 : 2024-05-14 10:43 -->
						        ${vo.date_diff == 0 ? fn:substring(vo.wDate,11,19) : fn:substring(vo.wDate,0,10)}
						      </td>
						      <td>${vo.readNum}(${vo.good})</td>
						    </tr>
					    </c:if>
					  </c:forEach>
					  <tr><td colspan="5" class="m-0 p-0"></td></tr>
				  </table>
				  <br/>
					<!-- 블록페이지 시작 -->
					<div class="text-center">
					  <ul class="pagination justify-content-center">
						  <c:if test="${pag > 1}"><li class="page-item"><a class="page-link text-dark" href="${ctp}/BoardList.ad?bName=${bName}&pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
						  <c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-dark" href="${ctp}/BoardList.ad?bName=${bName}&pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}">이전블록</a></li></c:if>
						  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
						    <c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link bg-primary text-dark border-secondary" href="${ctp}/BoardList.ad?bName=${bName}&pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
						    <c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-dark" href="${ctp}/BoardList.ad?bName=${bName}&pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
						  </c:forEach>
						  <c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-dark" href="${ctp}/BoardList.ad?bName=${bName}&pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}">다음블록</a></li></c:if>
						  <c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-dark" href="${ctp}/BoardList.ad?bName=${bName}&pag=${totPage}&pageSize=${pageSize}">마지막페이지</a></li></c:if>
					  </ul>
					</div>
					<!-- 블록페이지 끝 -->
				</div>
			</div>
		</div>
	</div>
						
</body>
</html>