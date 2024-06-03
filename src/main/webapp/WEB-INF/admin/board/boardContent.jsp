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
  <title>adminContent.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <style type="text/css">
  	.container-fluid{margin-top:40px;}
		.content .row{border-bottom:1px solid #ddd; }
		.content .row.noline{border-bottom:0px; }
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
 		
 		// 신고시 '기타'항목 선택시에 textarea 보여주기
    function etcShow() {
    	$("#complaintTxt").show();
    }
 		
 		// 신고화면 선택후 신고사항 전송하기
    function complaintCheck() {
    	if (!$("input[type=radio][name=complaint]:checked").is(':checked')) {
    		alert("신고항목을 선택하세요");
    		return false;
    	}
    	//if($("input[type=radio][id=complaint7]:checked") && $("#complaintTxt").val() == "")
    	if($("input[type=radio]:checked").val() == '기타' && $("#complaintTxt").val() == "") {
    		alert("기타 사유를 입력해 주세요.");
    		return false;
    	}
    	
    	let cpContent = modalForm.complaint.value;
    	if(cpContent == '기타') cpContent += '/' + $("#complaintTxt").val();
    	
    	//alert("신고내용 : " + cpContent);
    	let query = {
    			bName   : '${bName}',
    			boardIdx: ${vo.idx},
    			cpMid  : '${sMid}',
    			cpContent : cpContent
    	}
    	
    	$.ajax({
    		url  : "BoardComplaintInput.bo",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("신고 되었습니다.");
    				location.reload();
    			}
    			else alert("신고 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
   		});
    }
 		
 		// 댓글달기
    function replyCheck() {
    	let content = $("#content").val();
    	if(content.trim() == "") {
    		alert("댓글을 입력하세요");
    		return false;
    	}
    	let query = {
  			bName			: '${bName}',
  			boardIdx 	: ${vo.idx},
  			mid				: '${sMid}',
  			nickName	: '${sNickName}',
  			hostIp    : '${pageContext.request.remoteAddr}',
  			content		: content
    	}
    	
    	$.ajax({
    		url  : "BoardReplyInput.bo",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("댓글이 입력되었습니다.");
    				location.reload();
    			}
    			else alert("댓글 입력 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
    	});
    }
 		// 댓글 삭제하기
    function replyDelete(idx) {
    	let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "BoardReplyDelete.bo",
    		type : "post",
    		data : {idx : idx},
    		success:function(res) {
    			if(res != "0") {
    				alert("댓글이 삭제되었습니다.");
    				location.reload();
    			}
    			else alert("삭제 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
    	});
    }
 		
 		// 댓글 수정박스 보이게(중복불허!)
 		function replyUpdateBoxOpen(replyVoIdx){
 			let boxdisplay = window.getComputedStyle(document.getElementById('replyUpdateBox'+replyVoIdx)).display;
 			// console.log(boxdisplay);
 			if(boxdisplay=='none'){ // 중복을 피하기 위해 다 닫고 누른것만 보이게 해준다.
 				$(".replyUpdateBox").hide();
	 			$("#replyUpdateBox"+replyVoIdx).show();
 			}
 			else{ // 같은 수정 버튼을 두번 눌렀을때
 				$("#replyUpdateBox"+replyVoIdx).toggle();
 			}
 		}
 		
 		// 댓글수정
    function replyCheck2(replyVoidx) {
    	let content = $("#content"+replyVoidx).val();
    	if(content.trim() == "") {
    		alert("댓글을 입력하세요");
    		return false;
    	}
    	let query = {
    		idx				: replyVoidx,
  			hostIp    : '${pageContext.request.remoteAddr}',
  			content		: content
    	}
    	
    	$.ajax({
    		url  : "BoardReplyUpdate.bo",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("댓글이 수정되었습니다.");
    				location.reload();
    			}
    			else alert("댓글 수정 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
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
      <div class="col-lg-8 mb-5">
        <div class="bg-light p-30 content">
				  <!-- 게시글 -->
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
        	<!-- 게시글 END -->
        	<!-- 버튼영역 -->
        	<div class="row noline text-center mt-3">
        		<div class="col-sm-3 text-left"><input type="button" value="목록보기" onclick="location.href='BoardList.ad?bName=${bName}';" class="btn btn-success" /></div>
		        <%-- <div class="col-sm-9 text-right">
	        		<c:if test="${sNickName == vo.nickName || sLevel == 0}">
				        <input type="button" value="수정" onclick="location.href='BoardUpdate.bo?bName=${bName}&idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary" />
				        <input type="button" value="삭제" onclick="boardDelete()" class="btn btn-danger text-right" />
			        </c:if>
	        		<c:if test="${report == 'OK'}"><a class="btn btn-dark" onclick="javascript:alert('신고가 접수되어 관리자가 처리중입니다.');"><i class="fa-solid fa-flag mr-1"></i>신고접수중</a></c:if>
	        		<c:if test="${report != 'OK' && sNickName != vo.nickName && sNickName!=null}"><input type="button" value="✔ 신고하기" data-toggle="modal" data-target="#myModal" class="btn btn-dark text-right" /></c:if>
		        </div> --%>
        	</div>
        	<!-- 버튼영역 END -->
        	
				</div>
			</div>
			<!-- 리스트 이미지 -->
      <div class="col-lg-4 mb-5">
        <div class="bg-light p-30 mb-30">
          <img class="img-fluid w-100" src="${ctp}/images/board/${vo.listImgfSName}" alt="${curScrStartNo}번글 리스트 이미지">
        </div>
      </div>
      <!-- 리스트 이미지 END -->
		</div>
	</div>
						
</body>
</html>