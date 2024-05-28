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
	.content .row:last-child{border-bottom:0px; }
	.content .row div{padding:10px;}
	.content .row .field{background: #f9f9f9;}
	</style>
	<script>
    'use strict';
    
    function boardDelete() {
    	let ans = confirm("현재 게시글을 삭제 하시겠습니까?");
    	if(ans) location.href = "BoardDelete.bo?bName=${bName}&idx=${vo.idx}";
    }
    
 		// 좋아요 처리(중복불허)
    function goodCheck() {
    	$.ajax({
    		url  : "BoardGoodCheck.bo",
    		type : "post",
    		data : {
    			bName : '${bName}',
    			idx : ${vo.idx}
    		},
    		success:function(res) {
    			if(res != "0") location.reload();
    			else alert("이미 좋아요 버튼을 클릭하셨습니다.");
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
    }
 		
  </script>
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
	                <a href="BoardList.bo?bName=${bName}" class="breadcrumb-item active">영화추천</a>
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
        		<div class="col-sm-12 text-right">
        			<c:if test="${sLevel > 4 || sLevel==null}"><span class="text-danger" title="로그인하시면 좋아요를 클릭하실 수 있습니다.">❤</span> 좋아요 : ${vo.good}</c:if>
        			<c:if test="${sLevel <= 4}"><a href="javascript:goodCheck()" class="text-danger">❤</a> 좋아요 : ${vo.good}</c:if>
        		</div>
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
        		<div class="col-sm-9" style="min-height:157px">${fn:replace(vo.content, newLine, "<br/>")}</div>
        	</div>
        	<div class="row text-center mt-3">
        		<div class="col text-left"><input type="button" value="돌아가기" onclick="location.href='BoardList.bo?bName=${bName}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-warning" /></div>
        		<c:if test="${sNickName == vo.nickName || sLevel == 0}">
			        <div class="col text-right">
		        		<c:if test="${report == 'OK'}"><font color='red'><b>현재 이글은 신고중입니다.</b></font></c:if>
				        <input type="button" value="수정" onclick="location.href='BoardUpdate.bo?bName=${bName}&idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary" />
				        <input type="button" value="삭제" onclick="boardDelete()" class="btn btn-danger text-right" />
			        </div>
		        </c:if>
		        <c:if test="${sNickName != vo.nickName}">
			        <div class="col text-right">
			          <c:if test="${report == 'OK'}"><font color='red'><b>현재 이글은 신고중입니다.</b></font></c:if>
				        <c:if test="${report != 'OK'}"><input type="button" value="신고하기" data-toggle="modal" data-target="#myModal" class="btn btn-danger text-right" /></c:if>
			        </div>
		        </c:if>
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