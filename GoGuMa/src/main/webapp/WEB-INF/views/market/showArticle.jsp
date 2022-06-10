<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 작성 - 고구마</title>

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
		.profile-img {
			width: 100px;
		    height: 100px;
		    object-fit: cover;
		    margin-right: 10px;
		    border-radius: 50%;
		    margin-left: 25px;
		}
	</style>
</head>

<body>
	<%@ include file="../market/marketHeader.jsp" %>
    <section class="container">
        <div class="w-50 m-auto" style="min-width: 970px;">
            <h1>${article.articleTitle}</h1>
            <p>
            	<strong>${article.market.marketName}</strong> 
            	<span class="ms-1 text-secondary"><fmt:formatDate value="${article.regDate}" pattern="yyyy-MM-dd HH:mm"/></span>
            </p>
            <div class="badge" style="background-color: #FF493C;">${article.market.category.categoryName}</div>
            <div id="article-area">
                <div class="accordion mb-3 mt-3" id="accordionSelectedProducts">
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingOne">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                상품 목록
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne"
                            data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <ul id="selectedProducts" class="list-group">
                                   <c:forEach items="${article.products}" var="product">
                                   		<li class="list-group-item list-group-item-action">
                                 			<a href="${contextPath}/category/1/${product.categoryId}/detail/${product.parentId}" class="text-decoration-none text-dark">
                        					<div class="row">
                            					<div class="col-2" style="padding-right: 0px;">
                                					<img src="${product.prodImgUrl}" class="w-100 h-100" />
                            					</div>
					                            <div class="col" style="margin-top: 12px; margin-left: 10px;">
					                                <p>${product.productName}</p>
					                                <p class="text-secondary">${product.optionName}</p>
					                                <p class="text-text-secondary"><fmt:formatNumber value="${product.productPrice}"/>원</p>
					                            </div>
					                        </div>
					                        </a>
					                    </li>
                                   </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="content-area" style="padding: 10px;">
                   ${article.articleContent}
                </div>
            </div>
            <div id="market-info-area" class="row mt-2">
                <div class="col-2">
                	<a href="${contextPath}/market/show.do?marketNum=${article.market.marketId}" class="h4 text-decoration-none text-dark">
                    	<img class="border border-secondary rounded-circle profile-img" src="${article.market.marketThumbnail}" />
                    </a>
                </div>
                <div class="col d-flex flex-column justify-content-center">
                   <a href="${contextPath}/market/show.do?marketNum=${article.market.marketId}" class="h4 text-decoration-none text-dark">${article.market.marketName}</a>
                   <p class="text-secondary mt-1">${article.market.marketDetail}</p>
                </div>
            </div>
        </div>
    </section>
</body>
</html>