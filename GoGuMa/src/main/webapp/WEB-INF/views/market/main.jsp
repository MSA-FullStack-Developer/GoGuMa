<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
    <meta charset="UTF-8">
    <title>고구마 - 고객과 구성하는 마켓</title>

    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
        crossorigin="anonymous"></script>

    <!-- bootstrap icon -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
    <style>
  		<%@ include file="/resources/css/market.css" %>
    </style>
    <script>
    	
    </script>
</head>

<body>
    <div class="w-100" style="min-width: 1400px;">
        <section id="main-section" class="container-xxl pt-5 pb-5">
            <div>
                <h3>☀️ ${memberName}님이 팔로우한 마켓 ☀️</h3>
            </div>

            <div class="w-100 mt-4">
                <div class="d-flex justify-content-between align-content-between flex-wrap">
                	<c:forEach items="${myMarketList}" var="myMarket" end="3">
	                    <div class="card mt-3 container">
	                    	<a href="${contextPath}/market/show.do?marketNum=${myMarket.marketId}">
		                        <img class="card-img-top container-img" src="${myMarket.marketThumbnail}" alt="${myMarket.marketThumbnail}">
	                        </a>
	                        <div class="card-body centered">
	                            <p class="card-text">${myMarket.marketName}</p>
	                        </div>
	                    </div>
                    </c:forEach>
                    <c:forEach var="i" begin="0" end="${marketCount-1}">
                    	<c:set value="https://hd-goguma.s3.ap-northeast-2.amazonaws.com/upload/1654654467726%E1%84%83%E1%85%A1%E1%84%85%E1%85%B3%E1%86%AB%E1%84%86%E1%85%A1%E1%84%8F%E1%85%A6%E1%86%BA%E1%84%91%E1%85%A1%E1%86%AF%E1%84%85%E1%85%A9%E1%84%8B%E1%85%AE%E1%84%92%E1%85%A1%E1%84%80%E1%85%B5.png"
                    				var="otherImg" />
						<div class="card mt-3 container">
                    		<input type="hidden" value="${marketCount}">
	                    	<a href="${contextPath}/market/unFollowMarket.do">
		                        <img class="card-img-top container-img" src="${otherImg}">
	                        </a>
                    	</div>
					</c:forEach>
                </div>
            </div>
        </section>
    </div>
</body>
</html>