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
    <title>Category</title>
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
                <li><a href="#" class="category"><i class="fa-solid fa-bars"></i>카테고리</a>
                    <ul class="main2">
                        <li>
                            패션
                            <ul class="main3">
                                <li><a href="#">여성의류</a></li>
                                <li><a href="#">남성의류</a></li>
                                <li><a href="#">유아동</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>

        <h2 style="text-align: center">카테고리ID</h2>

        <hr>

        <h4>총 4개</h4>
		
        <div>
        	<%-- <c:forEach items="${list}" var="product"> --%>
            <div class="product">
                <p><img src="https://image.hmall.com/static/0/6/89/33/2133896030_0.jpg?RS=400x400&AR=0" /></p>
                <h4>${product.productname}</h4>
                <h3>${product.price}</h3>
            </div>
            <div class="product">
                <p><img src="https://image.hmall.com/static/2/8/91/31/2131918228_0.jpg?RS=400x400&AR=0" /></p>
                <h4>트위드 니트 플레어 스커트 [블랙]</h4>
                <h3>159,030원</h3>
            </div>
            <div class="product">
                <p><img src="https://image.hmall.com/static/8/8/27/31/2131278853_0.jpg?RS=400x400&AR=0" /></p>
                <h4>데님 숏 점프수트</h4>
                <h3>227,430원</h3>
            </div>
            <div class="product">
                <p><img src="https://image.hmall.com/static/2/8/91/31/2131918220_0.jpg?RS=400x400&AR=0" /></p>
                <h4>트위드 니트 플레어 스커트 [아이보리]</h4>
                <h3>159,030원</h3>
            </div>
            <%-- </c:forEach> --%>
        </div>
    </div>
</body>

</html>