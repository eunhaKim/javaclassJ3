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
    
    function complaintCheck(bName, boardIdx, complaint) {
    	$.ajax({
    		url  : "ComplaintCheck.ad",
    		type : "post",
    		data : {
    			bName     : bName,
    			boardIdx  : boardIdx,
    			complaint:complaint
    		},
    		success:function() {
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
  	
  	function complaintDelete(bName, boardIdx, idx) {
  		let ans = confirm("현 게시물을 삭제하시겠습니까?");
  		if(!ans){
  			return false;
  		}
  		$.ajax({
  			url : "ComplaintDelete.ad",
  			type : "post",
  			data : {
  				bName : bName,
  				boardIdx : boardIdx,
  				idx : idx
  			},
  			success : function(res){
  				if(res != "0") {
  					alert("삭제성공")
  					location.reload();
  				}
    			else alert("삭제실패");
  			},
  			error : function(){
  				alert("전송오류");
  			}
  		});
  	}
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
	                <a href="ComplaintList.ad" class="breadcrumb-item text-success">신고리스트</a>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	
	<!-- Contact Start -->
  <div class="container-fluid">
    <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">신고리스트</span></h2>
    <div class="row px-xl-5">
      <div class="col-lg-12 mb-5">
        <div class="bg-light p-30">
        	<div class="nav nav-tabs mb-4">
            <a class="nav-item nav-link text-dark active" data-toggle="tab" href="#tab-pane-1">영화소식 (총 : ${fn:length(vos1)}개)</a>
            <a class="nav-item nav-link text-dark" data-toggle="tab" href="#tab-pane-2">영화추천 (총 : ${fn:length(vos2)}개)</a>
            <a class="nav-item nav-link text-dark" data-toggle="tab" href="#tab-pane-3">영화 같이보러가요 (총 : ${fn:length(vos3)}개)</a>
          </div>
          <div class="tab-content">
            <div class="tab-pane fade show active" id="tab-pane-1">
              <h4 class="mt-5 mb-3">영화소식</h4>
              <table class="table table-hover text-center">
						    <tr class="table-dark text-dark">
						      <th>번호</th>
						      <th>게시판</th>
						      <th>글제목</th>
						      <th>글쓴이</th>
						      <th>신고자</th>
						      <th>신고내역</th>
						      <th>신고날짜</th>
						      <th>표시여부</th>
						    </tr>
						    <c:set var="complaintCnt" value="${complaintCnt}" />
						    <c:forEach var="vo" items="${vos1}" varStatus="st">
							    <tr>
							      <td>${complaintCnt}</td>
							      <td><a href="BoardList.bo?bName=${vo.bName}" class="text-dark" target="_top">${vo.bName}</a></td>
							      <td>
							        <a href="BoardContent.bo?bName=${vo.bName}&idx=${vo.boardIdx}" class="text-dark" target="_top">${fn:substring(vo.title,0,10)}..</a>
							      </td>
							      <td>${vo.nickName}</td>
							      <td>${vo.cpMid}</td>
							      <td>${vo.cpContent}</td>
							      <td>${vo.cpDate}</td>
							      <td>
							        <a href="javascript:complaintCheck('${vo.bName}','${vo.boardIdx}','${vo.complaint}')" class="badge badge-warning">${vo.complaint == 'NO' ? '표시중' : '<font color=white>감춰짐</font>'}</a><br/>
							        <a href="javascript:complaintDelete('${vo.bName}',${vo.boardIdx},${vo.idx})" class="badge badge-danger">삭제</a>
							      </td>
								    <c:set var="complaintCnt" value="${complaintCnt - 1}" />
								  </tr>
						    </c:forEach>
						    <tr><td colspan="8" class="m-0 p-0"></td></tr>
						  </table>
            </div>
            <div class="tab-pane fade" id="tab-pane-2">
              <h4 class="mt-5 mb-3">영화추천</h4>
              <table class="table table-hover text-center">
						    <tr class="table-dark text-dark">
						      <th>번호</th>
						      <th>게시판</th>
						      <th>글제목</th>
						      <th>글쓴이</th>
						      <th>신고자</th>
						      <th>신고내역</th>
						      <th>신고날짜</th>
						      <th>표시여부</th>
						    </tr>
						    <c:set var="complaintCnt" value="${complaintCnt}" />
						    <c:forEach var="vo" items="${vos2}" varStatus="st">
							    <tr>
							      <td>${complaintCnt}</td>
							      <td><a href="BoardList.bo?bName=${vo.bName}" class="text-dark" target="_top">${vo.bName}</a></td>
							      <td>
							        <a href="BoardContent.bo?bName=${vo.bName}&idx=${vo.boardIdx}" class="text-dark" target="_top">${fn:substring(vo.title,0,10)}..</a>
							      </td>
							      <td>${vo.nickName}</td>
							      <td>${vo.cpMid}</td>
							      <td>${vo.cpContent}</td>
							      <td>${vo.cpDate}</td>
							      <td>
							        <a href="javascript:complaintCheck('${vo.bName}','${vo.boardIdx}','${vo.complaint}')" class="badge badge-warning">${vo.complaint == 'NO' ? '표시중' : '<font color=white>감춰짐</font>'}</a><br/>
							        <a href="javascript:complaintDelete('${vo.bName}',${vo.boardIdx},${vo.idx})" class="badge badge-danger">삭제</a>
							      </td>
								    <c:set var="complaintCnt" value="${complaintCnt - 1}" />
								  </tr>
						    </c:forEach>
						    <tr><td colspan="8" class="m-0 p-0"></td></tr>
						  </table>
            </div>
            <div class="tab-pane fade" id="tab-pane-3">
              <h4 class="mt-5 mb-3">영화같이보러가요</h4>
              <table class="table table-hover text-center">
						    <tr class="table-dark text-dark">
						      <th>번호</th>
						      <th>게시판</th>
						      <th>글제목</th>
						      <th>글쓴이</th>
						      <th>신고자</th>
						      <th>신고내역</th>
						      <th>신고날짜</th>
						      <th>표시여부</th>
						    </tr>
						    <c:set var="complaintCnt" value="${complaintCnt}" />
						    <c:forEach var="vo" items="${vos3}" varStatus="st">
							    <tr>
							      <td>${complaintCnt}</td>
							      <td><a href="BoardList.bo?bName=${vo.bName}" class="text-dark" target="_top">${vo.bName}</a></td>
							      <td>
							        <a href="BoardContent.bo?bName=${vo.bName}&idx=${vo.boardIdx}" class="text-dark" target="_top">${fn:substring(vo.title,0,10)}..</a>
							      </td>
							      <td>${vo.nickName}</td>
							      <td>${vo.cpMid}</td>
							      <td>${vo.cpContent}</td>
							      <td>${vo.cpDate}</td>
							      <td>
							        <a href="javascript:complaintCheck('${vo.bName}','${vo.boardIdx}','${vo.complaint}')" class="badge badge-warning">${vo.complaint == 'NO' ? '표시중' : '<font color=white>감춰짐</font>'}</a><br/>
							        <a href="javascript:complaintDelete('${vo.bName}',${vo.boardIdx},${vo.idx})" class="badge badge-danger">삭제</a>
							      </td>
								    <c:set var="complaintCnt" value="${complaintCnt - 1}" />
								  </tr>
						    </c:forEach>
						    <tr><td colspan="8" class="m-0 p-0"></td></tr>
						  </table>
            </div>
          </div>
                  
					
				</div>
			</div>
		</div>
	</div>
					
</body>
</html>