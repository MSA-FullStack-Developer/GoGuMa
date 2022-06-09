<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
    <meta charset="UTF-8">
    <title>관심 마켓 추가하기</title>

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
  		
  		.card-img-top {
			width: 200px;
			height: 200px;
			object-fit: cover;
			border-radius: 50%;
		}
    </style>
</head>

<body>
	<%@ include file="../market/marketHeader.jsp" %>
    <div class="w-100" style="min-width: 1400px;">
        <section id="main-section" class="container-xxl pb-5">
            <div style="margin-bottom: 25px;">
                <h3>${memberName}님, 관심있는 마켓을 팔로우해보세요</h3>
            </div>

            <div class="d-flex" style="width: 100%; height: 260px; overflow-x: scroll; overflow-y: hidden; white-space: nowrap;">
            	<c:forEach items="${unfollowedList}" var="market">
                	<div class="card mt-2 container col-sm-3" >
                 		<a href="${contextPath}/market/show.do?marketNum=${market.marketId}" class="goguma-link" style="width: 200px;">
                      		<img class="card-img-top container-img" src="${market.marketThumbnail}" alt="${myMarket.marketThumbnail}">
                     		<p class="card-text" style="margin-top: 10px;">${market.marketName}</p>
                     	</a>
                 	</div>
                </c:forEach>
           	</div>
        </section>
    </div>
</body>
</html>