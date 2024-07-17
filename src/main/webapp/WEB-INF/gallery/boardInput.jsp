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
    let cnt = 1;
    
    function fCheck() {
    	let fName1 = document.getElementById("fName1").value;
    	let maxSize = 1024 * 1024 * 30;	// 기본 단위 : Byte,   1024 * 1024 * 30 = 30MByte 허용
    	let title = $("#title").val();
    	
    	if(fName1.trim() == "") {
    		alert("업로드할 파일을 선택하세요");
    		return false;
    	}
    	else if(title.trim() == "") {
    		alert("업로드할 파일을 선택하세요");
    		return false;
    	}
    	
    	// 파일사이즈와 확장자 체크하기
    	let fileSize = 0;
    	for(let i=1; i<=cnt; i++) {
    		let imsiName = 'fName' + i;
    		if(isNaN(document.getElementById(imsiName))) {
    			let fName = document.getElementById(imsiName).value;
    			if(fName != "") {
    				fileSize += document.getElementById(imsiName).files[0].size;
			    	let ext1 = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
	    	    if(ext1 != 'jpg' && ext1 != 'gif' && ext1 != 'png' && ext1 != 'zip' && ext1 != 'hwp' && ext1 != 'ppt' && ext1 != 'pptx' && ext1 != 'doc' && ext1 != 'pdf' && ext1 != 'xlsx' && ext1 != 'txt') {
	    		    alert("업로드 가능한 파일은 'jpg/gif/png/zip/hwp/ppt/pptx/doc/pdf/xlsx/txt'만 가능합니다.");
	    		    return false;
	    	    }
    			}
    		}
    	}
    		
    	if(fileSize > maxSize) {
    		alert("업로드할 파일의 최대용량은 30MByte입니다.");
    		return false;
    	}
    	else {
    		myform.fSize.value = fileSize;
    		//alert("파일 총 사이즈 : " + fileSize);
    		myform.submit();
    	}
    }
    
    // 파일 박스 추가하기
    function fileBoxAppend() {
    	cnt++;
    	let fileBox = '';
    	fileBox += '<div id="fBox'+cnt+'" class="d-flex">';
    	fileBox += '<input type="file" name="fName'+cnt+'" id="fName'+cnt+'" class="form-control-file border mb-2" />';
    	fileBox += '<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn btn-danger btn-sm mb-2 ml-2" />';
    	fileBox += '</div>';
    	$("#fileBox").append(fileBox);		// html(), text(), append()
    }
    
    // 파일 박스 삭제
    function deleteBox(cnt) {
    	$("#fBox"+cnt).remove();
    	cnt--;
    }
    
    function pwdCheck1() {
    	$("#pwdDemo").hide();
    	$("#pwd").var("");
    }
    
    function pwdCheck2() {
    	$("#pwdDemo").show();
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
	                <a href="BoardList.gal" class="breadcrumb-item active">갤러리</a>
	            </nav>
	        </div>
	    </div>
	</div>
	<!-- Breadcrumb End -->
	<!-- Contact Start -->
  <div class="container-fluid">
    <h2 class="section-title position-relative mx-xl-5 mb-4"><span class="bg-secondary pr-3">갤러리 글쓰기</span></h2>
    <div class="row px-xl-5">
      <div class="col-lg-7 mb-5">
        <div class="bg-light p-30">
        	<form name="myform" method="post" action="BoardInputOk.gal" enctype="multipart/form-data" class="was-validated">
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
				      <div class="input-group col-xs-12">
				      	<input type="button" value="파일박스추가" onclick="fileBoxAppend()" class="form-control btn btn-primary mb-2" />
				    		<input type="file" name="fName1" id="fName1" class="form-control-file border mb-2" />
				    		<div id="fileBox"></div>
				    	</div>
				    </div>
			      <div class="row">
				      <div class="input-group col-xs-12">
				      	<label for="part" class="input-group-addon fhead">분류</label>
								<select name="part" id="part" class="form-control">
					        <option ${part=="영화" ? "selected" : ""}>영화</option>
					        <option ${part=="여행" ? "selected" : ""}>여행</option>
					        <option ${part=="음식" ? "selected" : ""}>음식</option>
					        <option ${part=="기타" ? "selected" : ""}>기타</option>
					      </select>
					    </div>
			      </div>
			      <div class="row">
				      <div class="input-group col-xs-12">
				      	<label for="openSw" class="input-group-addon fhead">공개여부</label>
				      	<div class="custom-control custom-radio custom-control-inline mt-2">
                  <input type="radio" class="custom-control-input" id="openSw-1" name="openSw" value="공개" onchange="pwdCheck1()">
                  <label class="custom-control-label" for="openSw-1">공개</label>
                </div>
				      	<div class="custom-control custom-radio custom-control-inline mt-2">
                  <input type="radio" class="custom-control-input" id="openSw-2" name="openSw" value="비공개" onchange="pwdCheck2()">
                  <label class="custom-control-label" for="openSw-2">비공개</label>
                </div>
					      <div id="pwdDemo" style="display:none"><input type="password" name="pwd" id="pwd" value="1234"  class="form-control"/></div>
				      </div>
				    </div>
						<div class="row border-bottom pb-2" id="demoImg1"></div>
						<div class="pt-5 text-center">
			      	<button type="button" class="btn btn-primary" onclick="fCheck()">글쓰기</button> &nbsp;
					    <button type="reset" class="btn btn-secondary">다시작성</button> &nbsp;
					    <button type="button" class="btn btn-secondary" onclick="location.href='BoardList.bo?bName=${bName}';">목록보기</button>
			      </div>
			      <input type="hidden" name="mid" value="${sMid}"/>
    				<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
    				<input type="hidden" name="fSize" />
        	</form>
        </div>
      </div>
      <div class="col-lg-5 mb-5">
          <div class="bg-light p-30 mb-30">
              <iframe src='https://tv.naver.com/embed/48465456' frameborder='no' scrolling='no' marginwidth='0' marginheight='0' WIDTH='100%' HEIGHT='400' allowfullscreen></iframe>
          </div>
      </div>
    </div>
  </div>
  <!-- Contact End -->
	
	<%@ include file = "/include/footer.jsp" %>
</body>
</html>