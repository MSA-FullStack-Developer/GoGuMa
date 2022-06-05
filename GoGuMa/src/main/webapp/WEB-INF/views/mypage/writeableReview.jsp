<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<head>
	<meta charset="utf-8">
	<title>WriteableReview</title>
    <!-- bootstrap icon -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	<!-- bootstrap css -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
	<!-- bootstrap js -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
	<style>
		<%@ include file="/resources/css/myreview.css" %>
		
        a {
            text-decoration: none;
        }
        a:link {
            color: black;
        }
        a:visited {
            color: black;
        }
	    .bundle {
	        width: 25%;
	        height: 25%;
	    }
	</style>
</head>
<body>
	<%@ include file="../header.jsp" %>
	
	<div class="container mt-5" style="min-width: 1200px;">
		<div class="row">
			<%@ include file="mypageMenu.jsp" %>
            <div class="col" style="width: 900px;">
                <div class="col">
                    <h5><b>👨‍💻 ${memberDTO.name}님</b></h5>
                </div>
                <div class="d-flex flex-row justify-content-evenly border border-2 rounded mb-2">
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            회원등급
                        </div>
                        <div>
                            💎
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            포인트
                        </div>
                        <div>
                            1,000P
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            예치금
                        </div>
                        <div>
                            10,000원
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            쿠폰
                        </div>
                        <div>
                            3장
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            작성 가능한 상품평
                        </div>
                        <div>
                            ${writeableCount}건
                        </div>
                    </div>
                </div>
                <div class="col mt-3">
                    <h5><b>작성 가능한 상품평</b></h5>
                </div>
                <div class="d-flex flex-wrap">
                    <c:forEach items="${writeableList}" var="product">
                    <div class="myReview-writeable">
	                    <div style="width: 100%; margin-bottom: 10px;">
               		 		<div class="myReviewTop">
	               		 		<a class="productlink" href="${contextPath}/category/1/${product.categoryID}/detail/${product.parentPID}">
									<img class="myReviewImg" src="${product.prodimgurl}" alt="${product.prodimgurl}">
		                            <span class="myReviewProduct" style="font-size: 14pt; font-weight: bold;">${product.productName}</span><br>
		                            <span class="myReviewProduct">${product.optionName}</span>
	               		 		</a>
               		 		</div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
            </div>
		</div>
	</div>
     <%@ include file="../footer.jsp" %>
</body>
</html>