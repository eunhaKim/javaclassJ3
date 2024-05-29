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
 		
 		// 댓글 수정박스 보이게
 		function replyUpdateBoxOpen(replyVoidx){
 			$("#replyUpdateBox"+replyVoidx).toggle();
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
        		<div class="col-sm-3 text-left"><input type="button" value="목록보기" onclick="location.href='BoardList.bo?bName=${bName}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-success" /></div>
		        <div class="col-sm-9 text-right">
	        		<c:if test="${sNickName == vo.nickName || sLevel == 0}">
				        <input type="button" value="수정" onclick="location.href='BoardUpdate.bo?bName=${bName}&idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary" />
				        <input type="button" value="삭제" onclick="boardDelete()" class="btn btn-danger text-right" />
			        </c:if>
	        		<c:if test="${report == 'OK'}"><a class="btn btn-dark" onclick="javascript:alert('신고가 접수되어 관리자가 처리중입니다.');"><i class="fa-solid fa-flag mr-1"></i>신고접수중</a></c:if>
	        		<c:if test="${report != 'OK' && sNickName != vo.nickName && sNickName!=null}"><input type="button" value="✔ 신고하기" data-toggle="modal" data-target="#myModal" class="btn btn-dark text-right" /></c:if>
		        </div>
        	</div>
        	<!-- 버튼영역 END -->
        	<!-- 이전글 다음글 -->
        	<div class="mt-5 mb-5">
	        	<c:if test="${!empty nextVo.title}">
		          <i class="fa-regular fa-file-lines text-success mr-2"></i><a href="BoardContent.bo?bName=${bName}&idx=${nextVo.idx}" class="h6 text-decoration-none text-truncate">다음글 : ${nextVo.title}</a><br/>
		        </c:if>
		        <c:if test="${!empty preVo.title}">
		        	<i class="fa-regular fa-file-lines text-success mr-2"></i><a href="BoardContent.bo?bName=${bName}&idx=${preVo.idx}" class="h6 text-decoration-none text-truncate">이전글 : ${preVo.title}</a><br/>
		        </c:if>
		      </div>
        	<!-- 이전글 다음글 END -->
        	<!-- 댓글 리스트 -->
        	<div class="row mt-5 mb-3"><h6><i class="fa-solid fa-pen-to-square mr-2 text-muted"></i>댓글목록</h6></div>
        	<c:if test="${empty replyVos}">😢 등록된 댓글이 없습니다.</c:if>
					<c:forEach var="replyVo" items="${replyVos}" varStatus="st">
						<div>
							<div class="row noline">
								<div class="col-md-8"><i class="fa-solid fa-user text-primary mr-2"></i>${replyVo.nickName}<small class="ml-2">${fn:substring(replyVo.wDate, 0, 10)}</small></div>
								<div class="col-md-4 text-right">
									<c:if test="${sMid == replyVo.mid || sLevel == 0}">
					          <a href="javascript:replyUpdateBoxOpen(${replyVo.idx})" title="댓글수정"><i class="fa-solid fa-pen"></i></a>
					          <a href="javascript:replyDelete(${replyVo.idx})" title="댓글삭제"><i class="fa-solid fa-trash-can text-danger"></i></a>
					        </c:if>
								</div>
							</div>
	        		<div class="row noline bg-secondary p-2 pl-3 mb-2">
	        			${fn:replace(replyVo.content, newLine,"<br/>")}
	        		</div>
	        	</div>
	        	<div class="row noline border" id="replyUpdateBox${replyVo.idx}" style="display:none;">
	        		<div class="col-md-10"><textarea rows="2" name="content${replyVo.idx}" id="content${replyVo.idx}" class="form-control">${fn:replace(replyVo.content, newLine,"<br/>")}</textarea></div>
	        		<div class="col-md-2"><input type="button" value="댓글수정" onclick="replyCheck2(${replyVo.idx})" class="btn btn-success h-100 w-100"/></div>
        		</div>
	        </c:forEach>
        	<!-- 댓글 리스트 END -->
        	<!-- 댓글 입력창 -->
					<form name="replyForm">
						<div class="row mt-5 mb-3"><h6><i class="fa-solid fa-pen-to-square mr-2 text-muted"></i>댓글작성</h6></div>
						<c:if test="${sLevel==null || sLevel > 4}">😘 댓글을 입력하시려면 <a href="MemberLogin.mem" class="badge badge-success">로그인</a> 해주세요.</c:if>
						<c:if test="${sLevel < 4}">
							<div><i class="fa-solid fa-user text-primary mr-2"></i>${sNickName}</div>
							<div class="row noline">
		        		<div class="col-md-10"><textarea rows="2" name="content" id="content" class="form-control" placeholder="권리침해, 욕설, 비하, 명예훼손, 혐오, 불법촬영물 등의 내용을 게시하면 운영정책 및 관련법률에 의해 제재될 수 있습니다."></textarea></div>
								<div class="col-md-2"><input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-primary h-100 w-100"/></div>
		        	</div>
						</c:if>
					</form>
					<!-- 댓글 입력창 END -->
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
  <!-- Contact End -->
  <!-- 신고하기 폼 모달창 -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">현재 게시글을 신고합니다.</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <b>신고사유 선택</b>
          <hr/>
          <form name="modalForm">
            <div><input type="radio" name="complaint" id="complaint1" value="광고,홍보,영리목적"/> 광고,홍보,영리목적</div>
            <div><input type="radio" name="complaint" id="complaint2" value="욕설,비방,차별,혐오"/> 설,비방,차별,혐오</div>
            <div><input type="radio" name="complaint" id="complaint3" value="불법정보"/> 불법정보</div>
            <div><input type="radio" name="complaint" id="complaint4" value="음란,청소년유해"/> 음란,청소년유해</div>
            <div><input type="radio" name="complaint" id="complaint5" value="개인정보노출,유포,거래"/> 개인정보노출,유포,거래</div>
            <div><input type="radio" name="complaint" id="complaint6" value="도배,스팸"/> 도배,스팸</div>
            <div><input type="radio" name="complaint" id="complaint7" value="기타" onclick="etcShow()"/> 기타</div>
            <div id="etc"><textarea rows="2" id="complaintTxt" class="form-control" style="display:none"></textarea></div>
            <hr/>
            <input type="button" value="확인" onclick="complaintCheck()" class="btn btn-success form-control" />
          </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  <!-- 신고하기 폼 모달창 END -->
<jsp:include page="/include/footer.jsp" />
</body>
</html>