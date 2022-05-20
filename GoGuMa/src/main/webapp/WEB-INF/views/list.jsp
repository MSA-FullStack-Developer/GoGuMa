<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://kit.fontawesome.com/a4f59ea730.js" crossorigin="anonymous"></script>

<head>
    <title>List</title>
    <style>
	    <%@ include file="/resources/css/style.css" %>

        img {
            width: 220px;
            height: 220px;
            margin-left: 17.5px;
            margin-right: 17.5px;
        }

        .product {
            position: relative;
            width: 265px;
            height: 380px;
            margin: auto;
            float: left;
        }
    </style>
    <script>
        $(document).ready(function () {
            $('#searchBtn').click(function () {
                var keyword = $("#keyword").val();
                // 검색 키워드가 존재하지 않는다면 '검색할 상품명을 입력하세요' alert창 띄워주기
                if (keyword != '') {
                    // 검색 동작 코드 작성하기
                    alert(keyword);
                } else {
                    alert('검색할 상품명을 입력하세요.');
                }
                // 검색 input box "" 초기화하기
            });
        });
    </script>
</head>

<body>
	<div class="header">
	    <div class="search">
	        <input type="text" id="keyword" placeholder="상품명을 검색하세요" autocomplete="off">
	        <button type="button" class="searchBtn" id="searchBtn"></button>
	    </div>
	</div>
	<div class="prodlist">
		<div id="menu">
		    <ul class="main1">
		        <li><i class="fa-solid fa-bars"></i>카테고리
		            <ul class="main2">
		            <c:forEach items="${parentCategory}" var="parentCategory"><li>
		                    ${parentCategory.categoryName}
		                    <ul class="main3">
	                    	<c:forEach items="${parentCategory.categoryList}" var="category">
		                        <li><a href="${contextPath}/category/list/${category.categoryID}/">${category.categoryName}</a></li>
		                    </c:forEach>
		                    </ul>
		                </li>
		            </c:forEach>
		            </ul>
		        </li>
		    </ul>
		</div>

        <h2 style="text-align: center">${categoryName}</h2>

        <hr>

        <h4>총 ${count}개</h4>
		
        <div>
        	<c:forEach items="${list}" var="product">
            <div class="product">
                <a href="${contextPath}/category/list/${product.categoryID}/detail/${product.productID}"><img src="${product.prodimgurl}" /></a>
                <h4>${product.productName}</h4>
                <h3><fmt:formatNumber value="${product.price}" pattern="#,###" />원</h3>
            </div>
            </c:forEach>
        </div>
    </div>
</body>

</html>