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
	<title>movieContent.jsp</title>
	<%@ include file = "/include/bs4.jsp" %>
	<style>
	.star-rating {
    display: flex;
    direction: row;
	}
	
	.star {
    width: 24px;
    height: 24px;
    background-color: transparent;
    border: 1px solid #ccc;
    clip-path: polygon(50% 0%, 61% 35%, 98% 35%, 68% 57%, 79% 91%, 50% 70%, 21% 91%, 32% 57%, 2% 35%, 39% 35%);
    position: relative;
	}
	
	.star.full {
    background-color: gold;
	}
	
	.star.half::after {
    content: '';
    width: 50%;
    height: 100%;
    background-color: gold;
    position: absolute;
    left: 0;
    top: 0;
    clip-path: polygon(50% 0%, 100% 0%, 100% 100%, 50% 100%);
	}
	
  /* 별점 스타일 설정하기 */
  .starForm fieldset {
    direction: rtl;
  }
  .starForm input[type=radio] {
    display: none;
  }
  .starForm label {
    font-size: 1.6em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
  }
  .starForm label:hover {
    text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
  }
  .starForm label:hover ~ label {
    text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
  }
  .starForm input[type=radio]:checked ~ label {
    text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
  }
  
	</style>
	<script>
		'use strict';
		
		// TMDB 별점 추가
		function createStar(className) {
	    const star = document.createElement('small');
	    star.className = className;
	    return star;
		}
	
		function renderStars(starRating, rating) {
	    const starRatingElement = document.getElementById(starRating);
	    starRatingElement.innerHTML = ''; // Clear previous stars
	
	    const fullStars = Math.floor(rating / 2);
	    const halfStar = (rating % 2) >= 1 ? 1 : 0;
	    const emptyStars = 5 - fullStars - halfStar;
	
	    for (let i = 0; i < fullStars; i++) {
	      starRatingElement.appendChild(createStar('fas fa-star'));
	    }
	
	    if (halfStar) {
	      starRatingElement.appendChild(createStar('fas fa-star-half-alt'));
	    }
	
	    for (let i = 0; i < emptyStars; i++) {
	      starRatingElement.appendChild(createStar('far fa-star'));
	    }
		}
		
		// Cannot set properties of null (setting 'innerHTML') 에러 대처
		// JavaScript가 실행될 때 해당 요소가 아직 DOM에 존재하지 않기 때문에 발생할 수 있습니다.
		// 이를 해결하기 위해, renderStars 함수를 DOM이 완전히 로드된 후에 호출해야 합니다. 이를 위해 DOMContentLoaded 이벤트를 사용할 수 있습니다.
		document.addEventListener('DOMContentLoaded', function() {
			renderStars('starRating1',${vo.movie_vote_average});
			renderStars('starRating2',${reviewAvg*2});
		});
		
		// 별점/리뷰평가 등록하기
	  function reviewCheck() {
	  	let star = starForm.star.value;
	  	let review = $("#review").val();
	  	
	  	if(star == "") {
	  		alert("별점을 부여해 주세요");
	  		return false;
	  	}
	  	else if(review.trim() == "") {
	  		alert("리뷰를 입력해 주세요");
	  		starForm.review.focus();
	  		return false;
	  	}
	  	
	  	let query = {
	  			movie_id: '${vo.movie_id}',
	  			mid    	: '${sMid}',
	  			nickName: '${sNickName}',
	  			star   	: star,
	  			content	: review,
	  			hostIp	:	'${pageContext.request.remoteAddr}'
	  	}
	  	
	  	$.ajax({
	  		url  : "MovieReplyInput.mv",
	  		type : "post",
	  		data : query,
	  		success:function(res) {
	  			alert("리뷰를 입력해 주셔서 감사합니다.");
	  			location.reload();
	  		},
	  		error : function() {
	  			alert("전송오류!");
	  		}
	  	});
	  }
		// 리뷰 삭제하기
    function replyDelete(idx) {
    	let ans = confirm("선택한 리뷰를 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "MovieReplyDelete.mv",
    		type : "post",
    		data : {idx : idx},
    		success:function(res) {
    			if(res != "0") {
    				alert("리뷰가 삭제되었습니다.");
    				location.reload();
    			}
    			else alert("삭제 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
    	});
    }
 		
 		// 리뷰 수정박스 보이게(중복불허!)
 		function replyUpdateBoxOpen(replyVoIdx){
 			let boxdisplay = window.getComputedStyle(document.getElementById('replyUpdateBox'+replyVoIdx)).display;
 			if(boxdisplay=='flex'){ // 같은 수정 버튼을 두번 눌렀을때
	 			$("#replyUpdateBox"+replyVoIdx).toggle();
 			}
 			else{ // 중복을 피하기 위해 다 닫고 누른것만 보이게 해준다.
	 			$(".replyUpdateBox").hide();
	 			$("#replyUpdateBox"+replyVoIdx).show();
 			}
 		}
 		
 		// 리뷰수정
    function replyCheck2(replyVoidx) {
    	let content = $("#content"+replyVoidx).val();
    	const stars = document.getElementsByName('star'+replyVoidx);
    	let starValue;
    	
    	for(const star of stars){
    		if(star.checked){
    			starValue = star.value;
    			break;
    		}
    	}
    	
    	if(starValue == null) {
    		alert("별점을 다시 입력해주세요.");
    		return false;
    	}
    	else if(content.trim() == "") {
    		alert("수정하실 리뷰 내용을 입력해주세요.");
    		return false;
    	}
    	
    	let query = {
    		idx				: replyVoidx,
  			hostIp    : '${pageContext.request.remoteAddr}',
  			star			: starValue,
  			content		: content
    	}
    	
    	$.ajax({
    		url  : "MovieReplyUpdate.mv",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("리뷰가 수정되었습니다.");
    				location.reload();
    			}
    			else alert("리뷰 수정 실패~~");
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
        <a href="MovieList.mv?mName=${mName}&page=${param.page}" class="breadcrumb-item active">${mTextName}</a>
      </nav>
    </div>
  </div>
</div>
<!-- Breadcrumb End -->
<!-- Content Start -->
<div class="container-fluid pb-5">
  <h2 class="section-title position-relative mx-xl-5 mb-4"><span class="bg-secondary pr-3">${vo.movie_title}</span></h2>
  <div class="row px-xl-5">
    <!-- 영화상세이미지 -->
    <div class="col-lg-5 mb-5">
      <div class="bg-light p-30 wow fadeInUp" data-wow-delay = "0.2s" data-wow-duration="1.5s">
        <img class="img-fluid w-100" src="https://image.tmdb.org/t/p/w500${vo.movie_poster_path}" alt="${vo.movie_title} 이미지" >
      </div>
    </div>
    <!-- 영화상세이미지 END -->
    
    <!-- 영화상세정보 우측박스 -->
    <div class="col-lg-7 mb-5">
    	
	    <!-- 영화상세정보 -->
      <div class="bg-light p-30 content wow fadeInUp bg-breadcrumb" data-wow-delay = "1s" data-wow-duration="1.5s">
      	<p><i class="fa-regular fa-calendar"></i> 개봉일 : ${vo.movie_date}</p>
      	<h3>${vo.movie_title}</h3>
      	
      	<div class="d-flex mb-3">
          <div class="text-primary mr-2" id="starRating1">
          	<small class="fas fa-star"></small>
          </div>
          <small class="pt-1">(TMDB 제공 : ${vo.movie_vote_count} Reviews, 평점평균 : ${vo.movie_vote_average})</small>
        </div>
      	
        <h4 class="font-weight-semi-bold mb-3 mt-5">${vo.movie_tagline}</h4>
        <p class="mb-4">${vo.movie_overview}</p>
      </div>
    	<!-- 영화상세정보 END -->
      
    	<!-- 리뷰 리스트 -->
      <div class="bg-light p-30 mt-3 content wow fadeInUp" data-wow-delay = "1.2s" data-wow-duration="1.5s">
      	<h4 class="mb-3">${vo.movie_title} 리뷰</h4>
      	<c:if test="${empty replyVos}">
      		<p class="border-top pt-2">😢 등록된 리뷰가 없습니다.</p>
      	</c:if>
      	<c:if test="${!empty replyVos}">
	      	<div class="d-flex mb-3 border-top pt-2 mb-5">
	          <div class="text-primary mr-2" id="starRating2">
	          	<small class="fas fa-star"></small>
	          </div>
	          <small class="pt-1">(회원리뷰평점 : <fmt:formatNumber value="${reviewAvg*2}" pattern="#,##0.0" />)</small>
	        </div>
	      </c:if>
        <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
	        <div class="media mb-4">
	          <img src="${ctp}/images/member/${replyVo.photo}" alt="${replyVo.nickName}님 프로필 이미지" class="img-fluid mr-3 border border-secondary" style="width: 45px;">
	          <div class="media-body">
	            <h6>${replyVo.nickName}<small> - <i>${fn:substring(replyVo.rDate,0,16)}</i></small></h6>
		          <div class="d-flex">
		            <div class="text-primary mr-2">
			          	<c:forEach var="i" begin="1" end="${replyVo.star}" varStatus="iSt">
				        	  <small class="fas fa-star"></small>
				        	</c:forEach>
				        	<c:forEach var="i" begin="1" end="${5 - replyVo.star}" varStatus="iSt">
				        		<small class="far fa-star"></small>
				        	</c:forEach>
			          </div>
			          <small class="pt-1">(입력한평점 : ${replyVo.star*2})</small>
			        </div>
	            <p>${fn:replace(replyVo.content, newLine,"<br/>")}</p>
	            
	            <c:if test="${sMid == replyVo.mid || sLevel == 0}">
			          <a href="javascript:replyUpdateBoxOpen(${replyVo.idx})" title="리뷰수정"><i class="fa-solid fa-pen"></i></a>
			          <a href="javascript:replyDelete(${replyVo.idx})" title="리뷰삭제"><i class="fa-solid fa-trash-can text-danger"></i></a>
			        </c:if>
			        <div class="row noline replyUpdateBox border-top border-bottom mt-3 pb-3" id="replyUpdateBox${replyVo.idx}" style="display:none;">
			        	<form name="starForm${replyVo.idx}">
				        	<div class="col-md-12">
					        	<div class="d-flex starForm">
						          <fieldset style="border:0px;">
								        <div class="text-left viewPoint m-0 b-0">
								          <input type="radio" name="star${replyVo.idx}" value="5" id="${replyVo.idx}star1"><label for="${replyVo.idx}star1">★</label>
								          <input type="radio" name="star${replyVo.idx}" value="4" id="${replyVo.idx}star2"><label for="${replyVo.idx}star2">★</label>
								          <input type="radio" name="star${replyVo.idx}" value="3" id="${replyVo.idx}star3"><label for="${replyVo.idx}star3">★</label>
								          <input type="radio" name="star${replyVo.idx}" value="2" id="${replyVo.idx}star4"><label for="${replyVo.idx}star4">★</label>
								          <input type="radio" name="star${replyVo.idx}" value="1" id="${replyVo.idx}star5"><label for="${replyVo.idx}star5">★</label>
								          : ${sNickName} 별점수정 <i class="fa-solid fa-user text-success mr-2"></i>
								        </div>
								      </fieldset>
						        </div>
						      </div>
					      </form>
		        		<div class="col-md-9"><textarea rows="2" name="content${replyVo.idx}" id="content${replyVo.idx}" class="form-control">${replyVo.content}</textarea></div>
		        		<div class="col-md-3"><input type="button" value="수정" onclick="replyCheck2(${replyVo.idx})" class="btn btn-success h-100 w-100"/></div>
	        		</div>
	          </div>
	        </div>
        </c:forEach>
      </div>
      <!-- 리뷰 리스트 END -->
      
    	<!-- 리뷰쓰기 -->
      <div class="bg-light p-30 mt-3 content wow fadeInUp" data-wow-duration="1.5s">
    		<h4 class="mb-3">Leave a review</h4>
        <c:if test="${sLevel==null || sLevel > 4}">
        	<p class="border-top pt-2">😆 당신의 소중한 리뷰를 달아주세요~<br/>리뷰는 <a href="MemberLogin.mem" class="badge badge-success">로그인</a>이 필요합니다.</p>
        </c:if>
        <c:if test="${sLevel < 4}">
        <p class="border-top pt-2">😆 당신의 소중한 리뷰를 달아주세요~</p>
        <form name="starForm" id="starForm">
          <div class="form-group">
            <div class="d-flex starForm">
		          <fieldset style="border:0px;">
				        <div class="text-left viewPoint m-0 b-0">
				          <input type="radio" name="star" value="5" id="star1"><label for="star1">★</label>
				          <input type="radio" name="star" value="4" id="star2"><label for="star2">★</label>
				          <input type="radio" name="star" value="3" id="star3"><label for="star3">★</label>
				          <input type="radio" name="star" value="2" id="star4"><label for="star4">★</label>
				          <input type="radio" name="star" value="1" id="star5"><label for="star5">★</label>
				          : ${sNickName} 별점입력 <i class="fa-solid fa-user text-primary mr-2"></i>
				        </div>
				      </fieldset>
		        </div>
            <textarea name="review" id="review" rows="3" class="form-control"></textarea>
            
          </div>
          <div class="form-group mb-0">
            <input type="button" onclick="reviewCheck()" value="리뷰등록" class="btn btn-primary px-3">
          </div>
        </form>
        </c:if>
      </div>
      <!-- 리뷰쓰기 END -->
      
    </div>
  </div>
</div>
<!-- Content End -->

<jsp:include page="/include/footer.jsp" />
</body>
</html>