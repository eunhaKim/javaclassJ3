<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert</title>
	<%@ include file = "/include/bs4.jsp" %>
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
        <a class="breadcrumb-item text-dark">Movie</a>
        <a href="MovieList.mv?mName=${mName}&page=${param.page}" class="breadcrumb-item active">${mTextName}</a>
      </nav>
    </div>
  </div>
</div>
<!-- Breadcrumb End -->
<!-- 영화리스트 -->
<div class="container-fluid">
	<h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">${mTextName}</span></h2>
	<div class="row px-xl-5">
		<c:forEach var="vo" items="${vos}" varStatus="st">
	    <div class="col-lg-3 col-md-6 wow flash" data-wow-delay = "${0.1*st.count}s">
	        <div class="product-offer mb-30" style="height: 300px;">
	            <img class="img-fluid" src="https://image.tmdb.org/t/p/w500${vo.movie_backdrop_path}" alt="${vo.movie_title} 포스터 이미지">
	            <div class="offer-text">
	                <h3 class="text-white">
	                	${fn:substring(vo.movie_title,0,10)}
	                	<c:if test="${fn:length(vo.movie_title) >= 10 }">..</c:if>
	                </h3>
	                <h6 class="text-white text-uppercase  mb-3">( 평점 : ${vo.movie_vote_average} )</h6>
	                <a href="MovieContent.mv?mName=${mName}&movie_id=${vo.movie_id}&page=${param.page}" class="btn btn-primary">상세보기</a>
	            </div>
	        </div>
	    </div>
	  </c:forEach>
	</div>
</div>
<!-- 영화리스트 END -->

<!-- Pagination -->
<ul class="pagination justify-content-center my-5">
	<!-- <li class="page-item"><a class="page-link" href="#">Previous</a></li> -->
	<c:forEach var="i" begin="1" end="10" step="1" varStatus="st">
	  <li class="page-item ${param.page==i ? 'active' : ''}"><a class="page-link" href="MovieList.mv?mName=${mName}&page=${i}">${i}</a></li>
  </c:forEach>
	<!-- <li class="page-item"><a class="page-link" href="#">Next</a></li> -->
</ul>
<!-- Pagination END -->

<jsp:include page="/include/footer.jsp" />
</body>
</html>