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
	<style>
    /* 파일 입력 요소 숨기기 */
    #file {
      display: none;
    }
    h4 small, h5 small{position:relative; bottom:3px; font-size: 12px; margin-left:5px; color:#333; background: #eee; border-radius:5px; padding:3px 5px;}
    h4 small a, h5 small a{font-weight:bold}
  </style>
  <script>
 		// 파일 업로드 체크 & 선택된 그림 미리보기 
    function imgCheck(e) {
			let fName = document.getElementById("file").value;
			
			let maxSize = 1024 * 1024 * 2;	// 기본 단위 : Byte,   1024 * 1024 * 2 = 2MByte 허용
			let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
			
			let fileSize = document.getElementById("file").files[0].size;
			if(fileSize > maxSize) {
				alert("업로드할 파일의 최대용량은 2MByte입니다.");
				document.getElementById("file").value="";
				return false;
			}
			else if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
				alert("업로드 가능한 파일은 'jpg/gif/png'만 가능합니다.");
				document.getElementById("file").value="";
				return false;
			}
			else{
	    	if(e.files && e.files[0]) {
	    		let reader = new FileReader();
	    		reader.onload = function(e) {
	    			document.getElementById("memberImg").src = e.target.result;
	    		}
	    		reader.readAsDataURL(e.files[0]);
	    	}
			}
    }
 		
 		// 변경적용..파일 ajax로 전송..
 		function fCheck(){
 			const fileInput = document.getElementById("file");
 			if(fileInput.value === ""){
 				alert("사진변경을 원하시면 사진 변경하기로 먼저 변경해주시요.");
 				return false;
 			}
 			
 			// 파일데이터는 바이너리 형식으로 전송해야 해서 FormData 객체를 생성 후 값을 넘겨준다. 
 			// fName으로 보내지 않는 이유는 fName은 파일의 데이터가 있는 게 아니라 파일 이름만 있기 때문에 파일을 전송할 수 없다.
 			const formData = new FormData();
      formData.append("fName", fileInput.files[0]);
 			
 			// processData는 데이터가 쿼리 문자열로 처리될지 여부를 결정
 			// 기본값은 true이고 파일 데이터는 문자열로 변환될수 없기 때문에 false로 지정해 주어야 함
 			// contentType은 서버로 전송되는 데이터의 타입을 지정
 			// 파일 업로드시에는 multipart/form-data가 필요하지만 기본값이 jQuery가 알아서 하도록 하는 값이기 때문에 false로 지정해서 변경해 주어야 함
 			$.ajax({
        url: "MemberPhotoChange.mem",
        type: "post",
        data: formData,
        contentType: false,
        processData: false,
        success: function(res) {
	        if (res != "0") {
            alert("사진변경완료!");
						location.reload();
	 				}
	 				else alert("사진변경실패!");
 				},
 				error : function(){
 					alert("전송오류!");
 				} 				
 			});
 		}
  </script>
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
          <span class="breadcrumb-item active">회원정보</span>
        </nav>
      </div>
    </div>
	</div>
	<!-- Breadcrumb End -->
	
	<!-- Contact Start -->
  <div class="container-fluid">
    <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4"><span class="bg-secondary pr-3">${mVo.nickName}님 회원정보</span></h2>
    <div class="row px-xl-5">
      <div class="col-xl-4 col-lg-6 col-md-6 mb-5">
        <div class="bg-light p-30 wow fadeInUp" data-wow-delay = "0.2s" data-wow-duration="1.5s">
          <div class="card" >
          	<form name="myform" action="MemberPhotoChange.mem" method="post" enctype="multipart/form-data">
					    <img id="memberImg" class="card-img-top" src="${ctp}/images/member/${mVo.photo}" alt="Card image" style="width:100%">
					    <div class="row p-0 m-0">
				        <div class="col p-0 m-0" >
				        	<label for="file" class="btn btn-primary form-control">사진변경하기</label>
				        	<input type="file" id="file" name="file" accept="image/*" onchange="imgCheck(this)">
				        </div>
				        <div class="col p-0 m-0" ><input type="button" value="변경적용하기" onclick="fCheck()" class="btn btn-warning form-control"></div>
					    </div>
				    </form>
				    <div class="card-body">
				      <h4 class="card-title">ID : ${mVo.mid} <span class="badge badge-dark" style="vertical-align:top">Level : ${mVo.level}</span></h4>
				      <p class="card-text">${mVo.name}님 입니다. 최초 가입일은 ${fn:substring(mVo.startDate,0,10)}이고, 총 방문횟수는 ${mVo.visitCnt}번, 오늘 방문횟수는 ${mVo.todayCnt}번 입니다.</p>
				      <p class="card-text"><i class="fa fa-envelope text-primary mr-3"></i>${mVo.email}</p>
				      <%-- <p class="card-text"><i class="fa fa-phone-alt text-primary mr-3"></i>${mVo.tel}</p> --%>
				      <p class="card-text"><i class="fa-solid fa-coins text-primary mr-3"></i>${mVo.point} point</p>
				    </div>
				  </div>
        </div>
      </div>
      <div class="col-xl-8 col-lg-6 col-md-6 mb-5 wow fadeInUp mb-3" data-wow-delay = "1s" data-wow-duration="1.5s">
        <!-- 내가쓴 게시물 리스트 -->
	      <div class="bg-light p-30 content">
	      	<h4 class="mb-3 border-bottom pb-2">내가 쓴 게시물</h4>
	      	<h5 class="mb-3">영화 소식<small>총 <a href="BoardSearchList.bo?bName=movieNews&search=mid&searchString=${sMid}" class="text-success">${fn:length(bVos1)}</a>개</small></h5>
	      	<c:if test="${empty bVos1}">
	      		<p class="">😢 작성하신 게시물이 없습니다.</p>
	      	</c:if>
	      	<c:forEach var="vo" items="${bVos1}" varStatus="st" begin="0" end="2">
	      		<div class="mb-2">
		      		<i class="fa-solid fa-circle-chevron-right text-primary mr-2"></i> <a href="BoardContent.bo?bName=movieNews&idx=${vo.idx}" class="text-dark">${fn:substring(vo.title,0,30)}</a>
		      		<c:if test="${fn:length(vo.title) >= 30 }">..</c:if>
		      		<small class="ml-3">- <i>${fn:substring(vo.wDate,0,10)}</i></small>
		      	</div>
	      	</c:forEach>
	      	<h5 class="mb-3 mt-3">영화 추천<small>총 <a href="BoardSearchList.bo?bName=movieRecommend&search=mid&searchString=${sMid}" class="text-success">${fn:length(bVos2)}</a>개</small></h5>
	      	<c:if test="${empty bVos2}">
	      		<p class="">😢 작성하신 게시물이 없습니다.</p>
	      	</c:if>
	      	<c:forEach var="vo" items="${bVos2}" varStatus="st" begin="0" end="2">
	      		<div class="mb-2">
		      		<i class="fa-solid fa-circle-chevron-right text-primary mr-2"></i> <a href="BoardContent.bo?bName=movieRecommend&idx=${vo.idx}" class="text-dark">${fn:substring(vo.title,0,30)}</a>
		      		<c:if test="${fn:length(vo.title) >= 30 }">..</c:if>
		      		<small class="ml-3">- <i>${fn:substring(vo.wDate,0,10)}</i></small>
		      	</div>
	      	</c:forEach>
	      	<h5 class="mb-3 mt-3">같이 영화보러가요<small>총 <a href="BoardSearchList.bo?bName=movieTogether&search=mid&searchString=${sMid}" class="text-success">${fn:length(bVos3)}</a>개</small></h5>
	      	<c:if test="${empty bVos3}">
	      		<p class="">😢 작성하신 게시물이 없습니다.</p>
	      	</c:if>
	      	<c:forEach var="vo" items="${bVos3}" varStatus="st" begin="0" end="2">
	      		<div class="mb-2">
		      		<i class="fa-solid fa-circle-chevron-right text-primary mr-2"></i> <a href="BoardContent.bo?bName=movieTogether&idx=${vo.idx}" class="text-dark">${fn:substring(vo.title,0,30)}</a>
		      		<c:if test="${fn:length(vo.title) >= 30 }">..</c:if>
		      		<small class="ml-3">- <i>${fn:substring(vo.wDate,0,10)}</i></small>
		      	</div>
	      	</c:forEach>
	      </div>
        <!-- 내가쓴 게시물 리스트 END -->
        <!-- 내가쓴 댓글 리스트 -->
	      <div class="bg-light p-30 content">
	      	<h4 class="mb-3 border-bottom pb-2">내가 쓴 댓글<small>총 <a href="#" onclick="javascript:alert('아직 준비중입니다. \n죄송합니다.')" class="text-success">${fn:length(bVos4)}</a>개</small></h4>
	      	<c:if test="${empty bVos4}">
	      		<p class="">😢 작성하신 댓글이 없습니다.</p>
	      	</c:if>
	      	<c:forEach var="vo" items="${bVos4}" varStatus="st" begin="0" end="2">
	      		<div class="mb-2">
		      		<i class="fa-solid fa-circle-chevron-right text-primary mr-2"></i> <a href="BoardContent.bo?bName=${vo.bName}&idx=${vo.boardIdx}" class="text-dark">${fn:substring(vo.content,0,30)}</a>
		      		<c:if test="${fn:length(vo.content) >= 30 }">..</c:if>
		      		<small class="ml-3">- <i>${fn:substring(vo.wDate,0,10)}</i></small>
		      	</div>
	      	</c:forEach>
	      </div>
        <!-- 내가쓴 댓글 리스트 END -->
        <!-- 내가쓴 방명록 리스트 -->
	      <div class="bg-light p-30 content">
	      	<h4 class="mb-3 border-bottom pb-2">내가 쓴 방명록<small>총 <a href="#" onclick="javascript:alert('아직 준비중입니다. \n죄송합니다.')" class="text-success">${fn:length(gVos)}</a>개</small></h4>
	      	<c:if test="${empty gVos}">
	      		<p class="">😢 작성하신 댓글이 없습니다.</p>
	      	</c:if>
	      	<c:forEach var="vo" items="${gVos}" varStatus="st">
	      		<div class="mb-2">
		      		<i class="fa-solid fa-circle-chevron-right text-primary mr-2"></i> <a href="GuestContent.gu?idx=${vo.idx}" class="text-dark">${fn:substring(vo.content,0,30)}</a>
		      		<c:if test="${fn:length(vo.content) >= 30 }">..</c:if>
		      		<small class="ml-3">- <i>${fn:substring(vo.visitDate,0,10)}</i></small>
		      	</div>
	      	</c:forEach>
	      </div>
        <!-- 내가쓴 방명록 리스트 END -->
      </div>
    </div>
  </div>
  <!-- Contact End -->
	
	<%@ include file = "/include/footer.jsp" %>
</body>
</html>