<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
		.content .row.noline{border-bottom:0px; }
		.content .row div{padding:10px;}
		.content .row .field{background: #f9f9f9;}
	</style>
	<script>
    'use strict';
    
 		// 다운로드수 증가시키기
    function downNumCheck(idx) {
    	$.ajax({
    		url  : "GalleryDownNumCheck.gal",
    		type : "post",
    		data : {idx : idx},
    		success:function() {
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
 		
 		// 자료 내용 삭제(자료 + Data)
    function boardDelete(idx, fSName) {
    	let ans = confirm("선택하신자료를 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "BoardDelete.gal",
    		type : "post",
    		data : {
    			idx  : idx,
    			fSName : fSName
    		},
    		success:function(res) {
    			if(res != 0) {
    				alert("자료가 삭제되었습니다.");
    				location.href="BoardList.gal?pag=${pag}&pageSize=${pageSize}";
    			}
    			else alert("삭제 실패~");
    		},
    		error : function() {
    			alert("전송오류!");
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
	                <a href="BoardList.gal" class="breadcrumb-item active">갤러리</a>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	<!-- Content Start -->
  <div class="container-fluid">
    <h2 class="section-title position-relative mx-xl-5 mb-4"><span class="bg-secondary pr-3">갤러리 게시글보기</span></h2>
    <div class="row px-xl-5">
      <div class="col-lg-8 mb-5">
        <div class="bg-light p-30 content">
        	<!-- 게시글 -->
        	<div class="row border-top">
        		<div class="col-sm-3 field">제목 : </div>
        		<div class="col-sm-9">${vo.title}</div>
        	</div>
        	<div class="row">
        		<div class="col-sm-3 field">글쓴이 : </div>
        		<div class="col-sm-3">${vo.nickName}</div>
        		<div class="col-sm-3 field">다운횟수 : </div>
        		<div class="col-sm-3">${vo.downNum}</div>
        	</div>
        	<div class="row">
        		<div class="col-sm-3 field">글쓴날짜 : </div>
        		<div class="col-sm-3">${fn:substring(vo.fDate, 0, 16)}</div>
        		<div class="col-sm-3 field">분류 : </div>
        		<div class="col-sm-3">${vo.part}</div>
        	</div>
        	<div class="row">
        		<div class="col-sm-3 field">내용 : </div>
        		<div class="col-sm-9" style="min-height:157px">${fn:replace(vo.content, newLine, "<br/>")}</div>
        	</div>
        	<div class="row">
        		<div class="col-sm-3 field">파일명 : </div>
        		<div class="col-sm-9">
        			<c:set var="fNames" value="${fn:split(vo.fName,'/')}"/>
			        <c:set var="fSNames" value="${fn:split(vo.fSName,'/')}"/>
			        <c:forEach var="fName" items="${fNames}" varStatus="st">
			          <a href="${ctp}/images/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})" class="text-dark">${fName}</a><br/>
			        </c:forEach>
			        <p class="mt-3 mb-0">(총 파일크기 : <fmt:formatNumber value="${vo.fSize/1024}" pattern="#,##0" />KByte)</p>
        		</div>
        	</div>
        	<!-- 게시글 END -->
        	<!-- 버튼영역 -->
        	<div class="row noline text-center mt-3">
        		<div class="col-sm-3 text-left"><input type="button" value="목록보기" onclick="location.href='BoardList.gal?pag=${pag}&pageSize=${pageSize}';" class="btn btn-success" /></div>
		        <div class="col-sm-9 text-right">
	        		<c:if test="${sNickName == vo.nickName || sLevel == 0}">
				        <input type="button" value="수정" onclick="alert('서비스준비중입니다.')" class="btn btn-primary" />
				        <input type="button" value="삭제" onclick="boardDelete('${vo.idx}','${vo.fSName}')" class="btn btn-danger text-right" />
			        </c:if>
		        </div>
        	</div>
        	<!-- 버튼영역 END -->
        </div>
      </div>
      <!-- 리스트 이미지 -->
      <div class="col-lg-4 mb-5">
        <div class="bg-light p-30 mb-30">
        	<!-- 자료실에 등록된 자료가 사진이라면, 아래쪽에 모두 보여주기 -->
        	<c:forEach var="fSName" items="${fSNames}" varStatus="st">
						<c:set var="len" value="${fn:length(fSName)}"/>
					  <c:set var="ext" value="${fn:substring(fSName, len-3, len)}"/>
					  <c:set var="extLower" value="${fn:toLowerCase(ext)}"/>
						<c:if test="${extLower == 'jpg' || extLower == 'gif' || extLower == 'png'}">
			        <img src="${ctp}/images/gallery/${fSName}" width="100%" alt="${vo.title} 이미지"/>
			      </c:if>
						<p class="text-center mt-2 mb-1">${fNames[st.index]}</p>
			      <hr/>
			    </c:forEach>
        </div>
      </div>
      <!-- 리스트 이미지 END -->
    </div>
  </div>
  <!-- Content End -->
<jsp:include page="/include/footer.jsp" />
</body>
</html>