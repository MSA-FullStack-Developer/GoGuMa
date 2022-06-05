<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<head>
    <title>List</title>
    
    <style>
	    <%@ include file="/resources/css/product.css" %>
    </style>
     <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
        crossorigin="anonymous"></script>
    
    <script>
        function sortList(sort) {
        	if (${isSearch == false}) {
        		location.href="${contextPath}/category/1/${categoryID}/?sortType="+sort;
        	} else if (${isSearch == true}) { // list.jsp가 검색 화면에서 사용된 경우
        		location.href="${contextPath}/category/1/search/?keyword=${keyword}&sortType="+sort;
        	}
        }
    </script>
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<div class="prodlist">
		<c:if test="${isSearch == true}">
			<h1 style="text-align: center;">"<strong>${keyword}</strong>" 검색결과</h1>
		</c:if>
		<c:if test="${isSearch == false}">
        	<h1 style="text-align: center;">${categoryName}</h1>
		</c:if>

        <hr>

		<c:if test="${recordCount != 0}">
	        <p class="h4Class">
	        	총 <span style="color: #FF493C;"><b>${recordCount}</b></span>개
		        <select class="select-sortType" name="sortType" onchange="javascript:sortList(this.options[this.selectedIndex].value);"
		        	style="width: auto; margin-right: 15px; float: right; padding-right: 15px">
		        	<option value="recent" <c:if test="${sortType eq 'recent'}">selected</c:if>>최신순</option>
		        	<option value="expensive" <c:if test="${sortType eq 'expensive'}">selected</c:if>>높은 가격순</option>
		        	<option value="cheap" <c:if test="${sortType eq 'cheap'}">selected</c:if>>낮은 가격순</option>
	        	</select>
	        </p>
        </c:if>
		
        <div class="listBox">
        	<c:forEach items="${list}" var="product">
        	<c:set var="categoryID" value="${product.categoryID}"/>
            <div class="product">
                <a href="${contextPath}/category/${pg}/${product.categoryID}/detail/${product.productID}"><img class="listImg" src="${product.prodimgurl}" /></a>
                <p class="product-name">
                	${product.productName}
               	</p>
                <h3><fmt:formatNumber value="${product.productPrice}" pattern="#,###" />원</h3>
            </div>
            </c:forEach>
        </div>
        
        <c:if test="${isSearch == true && recordCount == 0}">
        	<h3 class="no_result">해당하는 상품이 없습니다.</h3>
        </c:if>
        
		<c:if test="${isSearch == false}">
	        <div class="list_number">
			    <div>
			    	<div class="list_n_menu">
			        	<c:if test="${startPage != 1}">
							<a href="${contextPath}/category/${startPage-1}/${categoryID}/?sortType=${sortType}"><i class="fa-solid fa-caret-left"></i>이전</a>
						</c:if>
				        <c:forEach begin="${startPage}" end="${endPage}" var="p">
							<c:if test="${p == pg}"><span class="current">${p}</span></c:if>
							<c:if test="${p != pg}"><a href="${contextPath}/category/${p}/${categoryID}?sortType=${sortType}">${p}</a></c:if>
						</c:forEach>
						<c:if test="${endPage != pageCount}">
							<a href="${contextPath}/category/${endPage+1}/${categoryID}/?sortType=${sortType}">다음<i class="fa-solid fa-caret-right"></i></a>
						</c:if>
			        </div>
			    </div>
			</div>
		</c:if>
		<div class="fa-solid" style="width: 100%"></div>
    </div>
    
    <%@ include file="footer.jsp" %>
</body>
</html>