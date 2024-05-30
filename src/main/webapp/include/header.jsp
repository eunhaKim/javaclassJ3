<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />

<!-- Topbar Start -->
<div class="container-fluid">
    <div class="row bg-light align-items-center py-3 px-xl-5 d-none d-lg-flex">
        <div class="col-lg-4" id="logo">
            <a href="http://192.168.50.70:9090${ctp}" class="text-decoration-none">
                <span class="h1 text-primary px-2"><i class="fa-solid fa-video"></i></span>
                <span class="h1 text-dark px-2">Movie</span>
                <span class="h1 text-dark px-2 ml-n1">Review</span>
            </a>
        </div>
        <div class="col-lg-4 col-6 text-left">
            <form action="">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for movie">
                    <div class="input-group-append">
                        <span class="input-group-text bg-transparent text-primary">
                            <i class="fa fa-search"></i>
                        </span>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-lg-4 col-6 text-right">
        	<c:if test="${sNickName == null}">
            <p class="m-0">Customer Service</p>
            <h5 class="m-0">010-2622-0194</h5>
          </c:if>
          <c:if test="${sNickName != null}">
          	<p class="m-0">😋 nickName</p>
          	<h5 class="m-0">${sNickName}</h5>
          </c:if>
        </div>
    </div>
</div>
<!-- Topbar End -->