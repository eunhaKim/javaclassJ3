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
	                <span class="breadcrumb-item active">회원리스트</span>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	
	<!-- Contact Start -->
  <div class="container-fluid">
      <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">회원리스트</span></h2>
      <div class="row px-xl-5">
          <div class="col-lg-6 mb-5">
              <div class="bg-light p-30">
                  <ul class="list-group list-group-flush">
                  	<c:forEach var="vo" items="${vos}" varStatus="st">
                  		<li class="list-group-item d-flex justify-content-between align-items-center list-group-item-action">
                  			${vo.idx} / ${vo.mid} / ${vo.nickName} / 가입일: ${fn:substring(vo.startDate,0,10)} / 레벨: ${vo.level}
                  			<a href="MemberMain.mem?mid=${vo.mid}" class="btn btn-sm btn-primary">상세정보</a>
                  		</li>
                  	</c:forEach>
                  </ul>
              </div>
          </div>
          <div class="col-lg-6 mb-5">
              <div class="bg-light p-30 mb-30">
                  회원검색기능
              </div>
          </div>
      </div>
  </div>
  <!-- Contact End -->
	
	<%@ include file = "/include/footer.jsp" %>
</body>
</html>