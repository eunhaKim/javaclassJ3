<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert</title>
	<%@ include file = "/include/bs4.jsp" %>
	<style>
	.row{margin-bottom:10px;}
	.input-group-addon.fhead {display:inline-block; width:120px; line-height:38px; margin-bottom:0;}
	</style>
	<script>
		'use strict';
		// 리스트이미지 파일 업로드 체크 & 선택된 그림 미리보기 
    function imgCheck(e) {
    	//let fName = document.getElementById("file").value;
			let fName = $(e).val();
			
			let maxSize = 1024 * 1024 * 3;	// 기본 단위 : Byte,   1024 * 1024 * 3 = 1MByte 허용
			let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
			
			let fileSize = document.getElementById("listImg").files[0].size;
			if(fileSize > maxSize) {
				alert("업로드할 파일의 최대용량은 3MByte입니다.");
				document.getElementById("listImg").value="";
				return false;
			}
			else if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
				alert("업로드 가능한 파일은 'jpg/gif/png'만 가능합니다.");
				document.getElementById("listImg").value="";
				return false;
			}
			else{
	    	if(e.files && e.files[0]) {
	    		let reader = new FileReader();
	    		reader.onload = function(e) {
	    			$("#demoImg1").html("<span class='input-group-addon fhead'>업로드이미지</span><img src='"+e.target.result+"' alt='uploaded Image' height='80px' class='mt-2'/>");
	    		}
	    		reader.readAsDataURL(e.files[0]);
	    	}
			}
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
	                <a class="breadcrumb-item text-dark">Community</a>
	                <span class="breadcrumb-item active">영화추천</span>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	<!-- Contact Start -->
  <div class="container-fluid">
    <h2 class="section-title position-relative mx-xl-5 mb-4"><span class="bg-secondary pr-3">게시판 글쓰기(${bName})</span></h2>
    <div class="row px-xl-5">
      <div class="col-lg-7 mb-5">
        <div class="bg-light p-30">
        	<form name="myform" method="post" action="BoardInputOk.bo?bName=${bName}" enctype="multipart/form-data" class="was-validated">
        		<div class="row">
        			<div class="input-group col-xs-12">
	        			<label for="nickName" class="input-group-addon fhead">글쓴이</label>
	        			<input type="text" class="form-control" name="nickName" id="nickName" value="${sNickName}" readonly/>
        			</div>
        		</div>
        		<div class="row">
        			<div class="input-group col-xs-12">
	        			<label for="title" class="input-group-addon fhead">제목</label>
              	<input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요"  
              	required="required" data-validation-required-message="제목을 입력하세요" />
              	<p class="help-block text-danger"></p>
              </div>
            </div>
            <div class="row">
        			<div class="input-group col-xs-12">
	        			<label for="content" class="input-group-addon fhead">글내용</label>
			        	<textarea name="content" id="content" rows="6" class="form-control"></textarea>
			        </div>
			      </div>
			      <div class="row">
			      	<label for="listImg" class="input-group-addon fhead">리스트이미지</label>
						  <input type="file" id="listImg" name="listImg" onchange="imgCheck(this)" class="pt-1" />
			      </div>
						<div class="row border-bottom pb-2" id="demoImg1"></div>
						<div class="pt-5 text-center">
			      	<button type="submit" class="btn btn-primary">글쓰기</button> &nbsp;
					    <button type="reset" class="btn btn-secondary">다시작성</button> &nbsp;
					    <button type="button" class="btn btn-secondary" onclick="location.href='BoardList.bo?bName=${bName}';">목록보기</button>
			      </div>
			      <input type="hidden" name="mid" value="${sMid}"/>
    				<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
        	</form>
        </div>
      </div>
      <div class="col-lg-5 mb-5">
          <div class="bg-light p-30 mb-30">
              뭐 넣을까?? ㅎㅎ
          </div>
      </div>
    </div>
  </div>
  <!-- Contact End -->
	
	<%@ include file = "/include/footer.jsp" %>
</body>
</html>