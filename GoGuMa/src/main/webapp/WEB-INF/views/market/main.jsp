<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
    <meta charset="UTF-8">
    <title>고구마 - 고객과 구성하는 마켓</title>
    
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
        crossorigin="anonymous"></script>

    <!-- bootstrap icon -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	
    <!-- jquery -->
    <script type="text/javascript" src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
    
    <style>
  		<%@ include file="/resources/css/market.css" %>
  		
		.card-img-top {
			width: 200px;
			height: 200px;
			object-fit: cover;
			border-radius: 50%;
		}
		
		.card-img-bottom {
			width: 286px;
			height: 286px;
			object-fit: cover;
		}
	</style>
</head>

<body>
	<%@ include file="../market/marketHeader.jsp" %>
    <div class="w-100" style="min-width: 1400px;">
    	<c:if test="${member != null}">
	        <section id="main-section" class="container-xxl pb-5">
	            <div style="margin-bottom: 25px;">
	                <h3>${memberName}님이 팔로우한 마켓
	                	<c:if test="${myMarketID == null}">
	                		<a class="createMarketBtn" href="${contextPath}/market/write.do">마켓 생성하기</a>
	                	</c:if>
	                	<c:if test="${myMarketID != null}">
	                		<a class="createMarketBtn" href="${contextPath}/market/show.do?marketNum=${myMarketID}">나의 마켓</a>
	                	</c:if>
	                </h3>
	            </div>
	            
                <div class="d-flex" style="width: 100%; height: 260px; overflow-x: scroll; overflow-y: hidden; white-space: nowrap;">
                	<c:forEach items="${followedList}" var="market">
	                    <div class="card mt-2 container col-sm-3" >
	                    	<a href="${contextPath}/market/show.do?marketNum=${market.marketId}" class="goguma-link" style="width: 200px;">
		                        <img class="card-img-top container-img" src="${market.marketThumbnail}" alt="${myMarket.marketThumbnail}">
	                        	<p class="card-text" style="margin-top: 10px;">${market.marketName}</p>
	                        </a>
	                    </div>
                    </c:forEach>
                    <c:set value="https://hd-goguma.s3.ap-northeast-2.amazonaws.com/profile/1654751887576%E1%84%83%E1%85%A5%E1%84%87%E1%85%A9%E1%84%80%E1%85%B5.png"
	                   				var="otherImg" />
					<div class="card mt-2 container col-sm-3">
                   		<input type="hidden" value="${followCount}">
                    	<a href="${contextPath}/market/unFollowMarket.do" class="goguma-link">
	                        <img class="card-img-top container-img" src="${otherImg}">
	                        <p class="card-text" style="margin-top: 10px;">더보기</p>
                        </a>
                   	</div>
                </div>
	        </section>
        </c:if>
        
        <section id="main-section" class="container-xxl pb-5">
            <div>
                <h3>최근 마켓 게시글 모아보기️️</h3>
            </div>
            
            <div class="d-flex flex-wrap">
            	<c:forEach items="${recentArticleList}" var="article" varStatus="articleStatus">
	            	<c:if test="${articleStatus.index % 4 == 0}">
	            	<div class="card border border-dark mt-2" style="width: 18rem;">
	            	</c:if>
					<c:if test="${articleStatus.index % 4 != 0}">
	                <div class="card border border-dark mt-2 ms-5" style="width: 18rem;">
	                </c:if>
	                    <a href="${contextPath}/market/article/${article.articleId}/show.do"
	                        class="text-decoration-none text-dark">
	                        <img src="${article.thumbnail.imagePath}"
	                            class="card-img-bottom" alt="...">
	                        <div class="card-body">
	                            <p class="card-text text-truncate">${article.articleTitle}</p>
	                        </div>
	                    </a>
	                    <div class="card-footer bg-dark">
							<!-- carouselProducts 아이디 교유하게 하기 -->
	                        <div id="carouselProducts${articleStatus.index}" class="carousel slide" data-bs-touch="false"
	                            data-bs-interval="false">
	                            <div class="carousel-inner">
	                            	<c:forEach items="${article.products}" var="product" varStatus="status">
	                            	<c:if test="${status.first}">
	                                	<div class="carousel-item active">
	                                </c:if>
	                                <c:if test="${not status.first}">
	                                	<div class="carousel-item">
	                                </c:if>
	                                    <a class="text-decoration-none text-light" href="${contextPath}/category/1/${product.categoryId}/detail/${product.parentId}">
	                                        <div class="row d-flex align-items-center">
	                                            <div name="prod-thumb" class="col">
	                                                <img class="w-100 rounded" src="${product.prodImgUrl}" />
	                                            </div>
	                                            <div name="prod-name" class="col-8">
	                                                <p class="text-truncate mb-0">${product.productName}</p>
	                                                <p class="text-secondary text-truncate mb-0" style="font-size: 13px;">${product.optionName}</p>
	                                                <span  style="font-size: 10px;"><fmt:formatNumber value="${product.productPrice}"/>원</span>
	                                            </div>
	                                        </div>
	                                    </a>
	                            		</div>
	                                </c:forEach>
	                            </div>
	                         
	                          	<c:if test="${article.products.size() > 1}">
	                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselProducts${articleStatus.index}"
	                                data-bs-slide="prev">
	                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	                                <span class="visually-hidden">Previous</span>
	                            </button>
	                            <button class="carousel-control-next" type="button" data-bs-target="#carouselProducts${articleStatus.index}"
	                                data-bs-slide="next">
	                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
	                                <span class="visually-hidden">Next</span>
	                            </button>
	                            </c:if>
	                        </div> <!--carouselProducts 끝-->
	                    </div> <!-- card footer 끝-->
	                </div> <!--card 영역 끝-->
                </c:forEach>
            </div>
        </section>
	</div>
  	<%@ include file="../market/marketFooter.jsp" %>
</body>
</html>