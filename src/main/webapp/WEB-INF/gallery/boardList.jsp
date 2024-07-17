<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>boardList.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
    'use strict';
    
    function pageSizeCheck() {
    	let pageSize = $("#pageSize").val();
    	location.href = "BoardList.gal?pageSize="+pageSize;
    }
    
  	function modalCheck(idx, hostIp, mid, nickName) {
  		$("#myModal #modalTitle").text(nickName+"님의 프로필");
  		$("#myModal #modalHostIp").text(hostIp);
  		$("#myModal #modalMid").text(mid);
  		$("#myModal #modalNickName").text(nickName);
  		$("#myModal #modalIdx").text(idx);
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
<div class="container-fluid">
	<h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">갤러리</span></h2>
	<div class="row px-xl-5">
    <!-- List Start -->
    <div class="col-lg-12 col-md-12">
      <div class="row pb-3">
        <div class="col-12 pb-1">
          <div class="d-flex align-items-center justify-content-between mb-4">
	          <div>
	            <c:if test="${sLevel < 4}"><a href="BoardInput.gal?pag=${pag}&pageSize=${pageSize}" class="btn btn-success btn-sm">글쓰기</a></c:if>
	          </div>
		        <div class="ml-2">
			        <select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
			          <option ${pageSize==4  ? "selected" : ""}>4</option>
			          <option ${pageSize==8 ? "selected" : ""}>8</option>
			          <option ${pageSize==12 ? "selected" : ""}>12</option>
			          <option ${pageSize==16 ? "selected" : ""}>16</option>
			          <option ${pageSize==20 ? "selected" : ""}>20</option>
			        </select>
	          </div>
	        </div>
	      </div>
      
      	<c:set var="curScrStartNo" value="${curScrStartNo}" />
    		<c:forEach var="vo" items="${vos}" varStatus="st">
		    <div class="col-lg-3 col-md-4 col-sm-6 pb-1 wow pulse" data-wow-delay = "${0.4*st.count}s">
		      <div class="product-item bg-light mb-4">
	          <div class="product-img position-relative overflow-hidden text-center" style="height:240px;background:#e9e9e9">
	          	<c:set var="fNames" value="${fn:split(vo.fName,'/')}"/>
          		<c:set var="fSNames" value="${fn:split(vo.fSName,'/')}"/>
              <img class="img-fluid h-100" src="${ctp}/images/gallery/${fSNames[0]}" alt="${curScrStartNo}번글 리스트 이미지">
              <div class="product-action">
                <a class="btn btn-outline-dark btn-square" href="BoardContent.gal?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}" title="게시글번호 : ${curScrStartNo}">${curScrStartNo}</a>
                <a class="btn btn-outline-dark btn-square" href="BoardContent.gal?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}" title="게시글보기"><i class="fa-regular fa-eye"></i></a>
              </div>
	          </div>
	          <div class="text-center py-4">
              <a href="BoardContent.gal?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}" class="h5 text-decoration-none text-truncate" title="${vo.title}">${fn:substring(vo.title,0,10)}</a>
              <c:if test="${fn:length(vo.title) >= 10 }">..</c:if>
			        <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif" /></c:if>  
              <div class="d-flex align-items-center justify-content-center mt-2">
                <h6><i class="fa-solid fa-user text-primary mr-2"></i>${vo.nickName}</h6>
                <c:if test="${sLevel == 0}">
				          <a href="#" onclick="modalCheck('${vo.idx}','${vo.hostIp}','${vo.mid}','${vo.nickName}')" data-toggle="modal" data-target="#myModal" class="badge badge-success ml-2 mb-2">more</a>
				        </c:if>
              </div>
              <div class="d-flex align-items-center justify-content-center mb-1">
                <!-- 1일(24시간) 이내는 시간만 표시(10:43), 이후는 날짜와 시간을 표시 : 2024-05-14 10:43 -->
                <small>${vo.date_diff == 0 ? fn:substring(vo.fDate,11,19) : fn:substring(vo.fDate,0,10)}</small>
                <small class="ml-2">(다운수: ${vo.downNum})</small>
              </div>
	          </div>	
		      </div>
		    </div>
			  <c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
			  </c:forEach>
		  </div>
		  
		  <!-- 블록페이지 시작 -->
			<div class="text-center col-12">
			  <ul class="pagination justify-content-center">
				  <c:if test="${pag > 1}"><li class="page-item"><a class="page-link text-dark" href="${ctp}/BoardList.gal?pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
				  <c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-dark" href="${ctp}/BoardList.gal?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}">이전블록</a></li></c:if>
				  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
				    <c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link bg-primary border-secondary text-dark" href="${ctp}/BoardList.gal?pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
				    <c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-dark" href="${ctp}/BoardList.gal?pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
				  </c:forEach>
				  <c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-dark" href="${ctp}/BoardList.gal?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}">다음블록</a></li></c:if>
				  <c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-dark" href="${ctp}/BoardList.gal?pag=${totPage}&pageSize=${pageSize}">마지막페이지</a></li></c:if>
			  </ul>
			</div>
			<!-- 블록페이지 끝 -->
			
		  
		</div>
	  <!-- Sidebar Start -->
	  <!-- <div class="col-lg-3 col-md-4">
	    Start
	    <div class="bg-light p-4 mb-30">
	    </div>
	  </div> -->
	  <!-- Sidebar End -->
  </div>
</div>

<!-- 모달에 회원정보 출력하기 -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title" id="modalTitle"></h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
        고유번호 : <span id="modalIdx"></span><br/>
        아이디 : <span id="modalMid"></span><br/>
        호스트IP : <span id="modalHostIp"></span><br/>
        닉네임 : <span id="modalNickName"></span><br/>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<jsp:include page="/include/footer.jsp" />
</body>
</html>