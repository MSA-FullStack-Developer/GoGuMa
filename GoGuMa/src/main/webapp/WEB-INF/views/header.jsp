<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<style>
	<%@ include file="/resources/css/style.css" %>
</style>
<div class="header">
	<a href="${contextPath}/">GOGUMA</a>
   	<div class="search">
    	<form id="searchForm" action="${contextPath}/category/1/search/" autocomplete="off">
			<input type="text" id="keyword" name="keyword" placeholder="상품명을 검색하세요" autocomplete="off" value="${keyword}"></input>
			<button type="submit" class="searchBtn" id="searchBtn"></button>
		</form>
    </div>
    <div class="headerCategory">
	    <div id="menu">
		    <ul class="main1">
		        <li><i class="fa-solid fa-bars"></i>카테고리
		            <ul class="main2">
		            <c:forEach items="${parentCategory}" var="parentCategory"><li>
		                    ${parentCategory.categoryName}
		                    <ul class="main3">
	                    	<c:forEach items="${parentCategory.categoryList}" var="category">
		                        <li><a href="${contextPath}/category/1/${category.categoryID}/">${category.categoryName}</a></li>
		                    </c:forEach>
		                    </ul>
		                </li>
		            </c:forEach>
		            </ul>
		        </li>
		    </ul>
		</div>
		<a href="${contextPath}/cart/">장바구니</a>
	</div>
</div>