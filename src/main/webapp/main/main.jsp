<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
  <title>main.jsp</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <%@ include file = "/include/bs4.jsp" %>
  <style>
	  /*** testimonial Start ***/
		.testimonial .owl-carousel.testimonial-carousel {
		    position: relative;
		}
		
		.testimonial .owl-carousel.testimonial-carousel .testimonial-item .testimonial-content {
		    position: relative;
		    border-radius: 10px;
		    background: #fff;
		    box-shadow: 0 -10px 10px #ddd;
		}
		
		.testimonial .owl-carousel.testimonial-carousel .testimonial-item .testimonial-content::after {
		    position: absolute;
		    content: "";
		    width: 45px;
		    height: 45px;
		    bottom: -20px;
		    left: 30px;
		    transform: rotate(45deg);
		    background: #fff;
		    z-index: -1;
		    box-shadow: 0 0 10px #ddd;
		}
		
		.testimonial .owl-carousel.testimonial-carousel .owl-nav {
		    position: absolute;
		    top: -60px;
		    right: 0;
		    display: flex;
		    font-size: 40px;
		    color: #003A66;
		}
		
		.testimonial .owl-carousel.testimonial-carousel .owl-nav .owl-prev {
		    margin-right: 40px;
		}
		
		.testimonial .owl-carousel.testimonial-carousel .owl-nav .owl-prev,
		.testimonial .owl-carousel.testimonial-carousel .owl-nav .owl-next {
		    transition: 0.5s;
		}
		
		.testimonial .owl-carousel.testimonial-carousel .owl-nav .owl-prev:hover,
		.testimonial .owl-carousel.testimonial-carousel .owl-nav .owl-next:hover {
		    color: #E02454;
		}
		/*** testimonial end ***/
  </style>
</head>
<body>


<%@ include file = "/include/header.jsp" %>

<!-- 메뉴바(Nav) -->
<%@ include file = "/include/nav.jsp" %>

<!-- Breadcrumb Start -->
<div class="container-fluid wow fadeInUp" data-wow-delay = "0.2s" data-wow-duration="2s">
    <div class="row px-xl-5">
        <div class="col-12">
            <nav class="breadcrumb bg-light mb-30">
                <a class="breadcrumb-item text-dark" href="${ctp}/Main">Home</a>
                <span class="breadcrumb-item active">Main</span>
            </nav>
        </div>
    </div>
</div>
<!-- Breadcrumb End -->
<!-- Carousel Start -->
<div class="container-fluid mb-3 wow pulse" data-wow-delay = "1s" data-wow-duration="2s">
  <div class="row px-xl-5">
    <div class="col-lg-12">
      <div id="header-carousel" class="carousel slide carousel-fade mb-30 mb-lg-0" data-ride="carousel">
        <ol class="carousel-indicators">
          <li data-target="#header-carousel" data-slide-to="0" class="active"></li>
          <li data-target="#header-carousel" data-slide-to="1"></li>
          <li data-target="#header-carousel" data-slide-to="2"></li>
          <li data-target="#header-carousel" data-slide-to="3"></li>
          <li data-target="#header-carousel" data-slide-to="4"></li>
        </ol>
        <div class="carousel-inner">
	        <c:forEach var="vo" items="${mVos}" varStatus="st" begin="0" end="4">
	        	<c:if test="${st.index==0}"><div class="carousel-item position-relative active" style="height: 530px;"></c:if>
	        	<c:if test="${st.index!=0}"><div class="carousel-item position-relative" style="height: 530px;"></c:if>
	            <img class="position-absolute w-100 h-100" src="https://image.tmdb.org/t/p/original${vo.movie_backdrop_path}" alt="${vo.movie_title} 포스터 이미지" style="object-fit: cover;">
	            <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
	              <div class="p-3" style="max-width: 700px;">
	                <h1 class="display-4 text-white mb-3 animate__animated animate__fadeInDown">${vo.movie_title}</h1>
	                <p class="mx-md-5 px-5 animate__animated animate__bounceIn" style="word-break:keep-all">${fn:substring(vo.movie_overview,0,60)}..</p>
	                <a class="btn btn-outline-light py-2 px-4 mt-3 animate__animated animate__fadeInUp" href="MovieContent.mv?mName=upcoming&movie_id=${vo.movie_id}">More</a>
	              </div>
	            </div>
	          </div>
	        </c:forEach>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Carousel End -->
<!-- Community Start -->
<div class="container-fluid pt-5">
  <h2 class="section-title position-relative text-uppercase mx-xl-5 mb-4 wow fadeInUp" data-wow-delay = "0.1s" data-wow-duration="2s"><span class="bg-secondary pr-3">Community</span></h2>
  <div class="row px-xl-5 pb-3">
    <div class="col-lg-4 col-md-6 col-sm-12 pb-1 wow fadeInUp" data-wow-delay = "0.2s" data-wow-duration="2s">
      <a class="text-decoration-none" href="BoardList.bo?bName=movieNews">
        <div class="d-flex align-items-center bg-light mb-4" style="padding: 30px;">
          <h1 class="fa-solid fa-film text-primary m-0 mr-3"></h1>
          <h5 class="font-weight-semi-bold m-0">영화소식</h5>
        </div>
      </a>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12 pb-1 wow fadeInUp" data-wow-delay = "1s" data-wow-duration="2s">
      <a class="text-decoration-none" href="BoardList.bo?bName=movieRecommend">
        <div class="d-flex align-items-center bg-light mb-4" style="padding: 30px;">
          <h1 class="fa-solid fa-video text-primary m-0 mr-3"></h1>
          <h5 class="font-weight-semi-bold m-0">영화추천</h5>
        </div>
      </a>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12 pb-1 wow fadeInUp" data-wow-delay = "1.8s" data-wow-duration="2s">
      <a class="text-decoration-none" href="BoardList.bo?bName=movieTogether">
        <div class="d-flex align-items-center bg-light mb-4" style="padding: 30px;">
          <h1 class="fa-solid fa-ticket text-primary m-0 mr-3"></h1>
          <h5 class="font-weight-semi-bold m-0">영화같이보러가요</h5>
        </div>
      </a>
    </div>
  </div>
</div>
<!-- Community END -->
<!-- Testimonial Start -->
<div class="container-fluid testimonial overflow-hidden py-5">
  <div class="row px-xl-5">
    <div class="text-center mb-5 wow fadeInUp col-12" data-wow-delay="2s">
      <div class="sub-style">
        <h5 class="sub-title text-primary px-3">회원 리뷰가 궁금해?</h5>
      </div>
      <h1 class="display-5 mb-4">What Our Clients Say</h1>
      <p class="mb-2">최근 올라온 따끈한 회원님들의 영화 리뷰~</p>
    </div>
    <div class="owl-carousel testimonial-carousel wow zoomInDown col-12" data-wow-delay="0.2s">
    	<c:if test="${empty replyVos}">
    		<p class="text-center pt-2 wow zoomInDown" data-wow-delay="0.2s">😢 등록된 리뷰가 없습니다.</p>
    	</c:if>
    	<div class="row">
	    	<c:if test="${!empty replyVos}">
		      <c:forEach var="vo" items="${replyVos}" varStatus="st" begin="0" end="5">
			      <div class="testimonial-item mb-5 col-lg-4 col-md-6 wow fadeInUp" data-wow-delay = "${st.count*0.2}s" data-wow-duration="2s">
			        <div class="testimonial-content p-4 mb-5">
			          <div class="d-flex">
					        <a href="MovieContent.mv?mName=&movie_id=${vo.movie_id}"><img class="rounded mr-4" src="https://image.tmdb.org/t/p/w300${vo.movie_poster_path}" alt="${vo.movie_title} 이미지" style="width:100px" ></a>
			            <div>
						        <h6 class="fs-5 mt-2">${vo.movie_title}</h6>
				            <div class="text-primary mr-2">
					          	<c:forEach var="i" begin="1" end="${vo.star}" varStatus="iSt">
						        	  <small class="fas fa-star"></small>
						        	</c:forEach>
						        	<c:forEach var="i" begin="1" end="${5 - vo.star}" varStatus="iSt">
						        		<small class="far fa-star"></small>
						        	</c:forEach>
					          </div>
				          	<small class="pt-1">(입력한평점 : ${vo.star*2})</small>
						        <p class="fs-5 mt-3 text-dark">${fn:substring(vo.content,0,20)}..</p>
						      </div>
				        </div>
			        </div>
			        <div class="d-flex">
			          <div class="rounded-circle me-4 mr-3" style="width: 100px; height: 100px;">
			            <img class="img-fluid rounded-circle" src="${ctp}/images/member/${vo.photo}" alt="${vo.nickName}님 프로필 이미지">
			          </div>
			          <div class="my-auto">
			            <h5>${vo.nickName}</h5>
			            <p class="mb-0">${fn:substring(vo.rDate,0,16)}</p>
			          </div>
			        </div>
			      </div>
			    </c:forEach>
			  </c:if>
		  </div>
    </div>
  </div>
</div>
<!-- Testimonial End -->

<%@ include file = "/include/footer.jsp" %>
</body>
</html>
