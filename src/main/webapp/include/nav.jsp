<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%
  int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
  pageContext.setAttribute("level", level);
%>

<!-- Navbar Start -->
<div class="container-fluid bg-dark mb-30 sticky-top">
  <div class="row px-xl-5">
    <div class="col-lg-3 d-none d-lg-block">
      <a class="btn d-flex align-items-center justify-content-between bg-primary w-100" data-toggle="collapse" href="#navbar-vertical" style="height: 65px; padding: 0 30px;">
        <h6 class="text-dark m-0"><i class="fa fa-bars mr-2"></i>Movies Categories</h6>
        <i class="fa fa-angle-down text-dark"></i>
      </a>
      <nav class="collapse position-absolute navbar navbar-vertical navbar-light align-items-start p-0 bg-light" id="navbar-vertical" style="width: calc(100% - 30px); z-index: 999;">
        <div class="navbar-nav w-100">
          <a href="MovieList.mv?mName=upcoming&page=1" class="nav-item nav-link">개봉예정작</a>
          <a href="MovieList.mv?mName=now_playing&page=1" class="nav-item nav-link">현재상영작</a>
          <a href="MovieList.mv?mName=popular&page=1" class="nav-item nav-link">영화인기순</a>
          <a href="MovieList.mv?mName=top_rated&page=1" class="nav-item nav-link">영화평점순</a>
        </div>
      </nav>
    </div>
    <div class="col-lg-9">
      <nav class="navbar navbar-expand-lg bg-dark navbar-dark py-3 py-lg-0 px-0">
        <a href="${ctp}/Main" class="text-decoration-none d-block d-lg-none">
          <span class="h1 text-uppercase text-dark bg-light px-2">Movie</span>
          <span class="h1 text-uppercase text-light bg-primary px-2 ml-n1">Review</span>
        </a>
        <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
          <div class="navbar-nav mr-auto py-0">
            <a href="${ctp}/Main" class="nav-item nav-link">Home</a>
            <div class="nav-item dropdown d-block d-lg-none">
              <a href="BoardMain.bo" class="nav-link dropdown-toggle" data-toggle="dropdown">Movies Categories<i class="fa fa-angle-down mt-1"></i></a>
              <div class="dropdown-menu bg-primary rounded-0 border-0 m-0">
                <a href="MovieList.mv?mName=upcoming&page=1" class="dropdown-item">개봉예정작</a>
                <a href="MovieList.mv?mName=now_playing&page=1" class="dropdown-item">현재상영작</a>
                <a href="MovieList.mv?mName=popular&page=1" class="dropdown-item">영화인기순</a>
                <a href="MovieList.mv?mName=top_rated&page=1" class="dropdown-item">영화평점순</a>
              </div>
            </div>
            <div class="nav-item dropdown">
              <a href="BoardMain.bo" class="nav-link dropdown-toggle" data-toggle="dropdown">Community <i class="fa fa-angle-down mt-1"></i></a>
              <div class="dropdown-menu bg-primary rounded-0 border-0 m-0">
                <a href="BoardList.bo?bName=movieNews" class="dropdown-item">영화 소식</a>
                <a href="BoardList.bo?bName=movieRecommend" class="dropdown-item">영화 추천</a>
                <a href="BoardList.bo?bName=movieTogether" class="dropdown-item">같이 영화보러가요</a>
                <a href="BoardList.gal" class="dropdown-item">갤러리</a>
              </div>
            </div>
            
            <div class="nav-item dropdown">
            	<a href="GuestList.gu"  class="nav-link dropdown-toggle" data-toggle="dropdown">방명록 <i class="fa fa-angle-down mt-1"></i></a>
            	<div class="dropdown-menu bg-primary rounded-0 border-0 m-0">
                <a href="GuestList.gu" class="dropdown-item">방명록목록</a>
                <a href="GuestInput.gu" class="dropdown-item">방명록쓰기</a>
              </div>
            </div>
            
            <div class="nav-item dropdown">
              <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">My Account<i class="fa fa-angle-down mt-1"></i></a>
              <div class="dropdown-menu bg-primary rounded-0 border-0 m-0">
                <c:if test="${level > 4}">
                  <a href="MemberLogin.mem" class="dropdown-item">로그인</a>
                  <a href="MemberJoin.mem" class="dropdown-item">회원가입</a>
                </c:if>
                <c:if test="${level <= 4}">
                  <a href="MemberMain.mem" class="dropdown-item">회원정보</a>
                	<a href="MemberPwdCheck.mem" class="dropdown-item">회원정보수정</a>
                  <a href="MemberLogout.mem" class="dropdown-item">로그아웃</a>
                	<a href="MemberDelete.mem" class="dropdown-item">회원탈퇴</a>
                </c:if>
                <c:if test="${level == 0}">
                	<hr/>
                	<a href="MemberList.mem" class="dropdown-item">회원리스트</a>
          				<a href="AdminMain.ad" class="dropdown-item" target="_blank">관리자메뉴</a>
                </c:if>
              </div>
            </div>
          </div>
          <div class="navbar-nav ml-auto py-0 d-none d-lg-block">
            <a href="" class="btn px-0">
              <i class="fas fa-heart text-primary"></i> <span class="badge text-secondary" style="padding-bottom: 2px;">총방문수 : ${sVisitCount}</span> | 
              <i class="fa-regular fa-heart text-primary ml-2"></i> <span class="badge text-secondary" style="padding-bottom: 2px;">오늘방문수 : ${sTodayVisitCount}</span>
            </a>
            <!-- <a href="" class="btn px-0 ml-3">
                <i class="fas fa-shopping-cart text-primary"></i>
                <span class="badge text-secondary border border-secondary rounded-circle" style="padding-bottom: 2px;">0</span>
            </a> -->
          </div>
        </div>
      </nav>
    </div>
  </div>
</div>
<!-- Navbar End -->