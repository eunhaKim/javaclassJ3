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
	                <span class="breadcrumb-item active">방명록등록</span>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	
	<!-- Contact Start -->
  <div class="container-fluid">
    <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">방명록등록</span></h2>
    <div class="row px-xl-5">
      <div class="col-lg-6 mb-5">
        <div class="bg-light p-30">
        	<p><i class="fa-solid fa-volume-high mr-2 text-primary"></i>방문해주셔서 감사합니다. 방명록은 수정, 삭제가 안되니 신중하게 입력해주세요.</p>
        	<hr/>
          <form name="myform" method="post" action="GuestInputOk.gu" class="was-validated">
				    <div class="form-group">
				      <label for="name">성명</label>
				      <input type="text" class="form-control" id="name" value="${sNickName}" placeholder="Enter username" name="name" required />
				      <div class="valid-feedback">Ok!!!</div>
				      <div class="invalid-feedback">성명을 입력해 주세요.</div>
				    </div>
				    <div class="form-group">
				      <label for="email">E-mail</label>
				      <input type="text" class="form-control" id="email" placeholder="Enter email" name="email" />
				    </div>
				    <div class="form-group">
				      <label for="homePage">Homepage</label>
				      <input type="text" class="form-control" id="homePage" placeholder="Enter Homepage" name="homePage" value="https://" />
				    </div>
				    <div class="form-group">
				      <label for="content">방문소감</label>
				      <textarea rows="5" name="content" id="content" required class="form-control"></textarea>
				      <div class="valid-feedback">Ok!!!</div>
				      <div class="invalid-feedback">방문소감을 입력해 주세요.</div>
				    </div>
				    <div class="form-group text-center">
				    	<button type="submit" class="btn btn-primary mr-3">방명록 등록</button>
				    	<button type="reset" class="btn btn-secondary mr-3">방명록 다시입력</button>
				    </div>
				    <%-- <input type="hidden" name="hostIp" value="<%=request.getRemoteAddr()%>"/> --%>
				    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
				  </form>
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