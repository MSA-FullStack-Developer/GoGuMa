<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<script src="https://kit.fontawesome.com/a4f59ea730.js" crossorigin="anonymous"></script>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<style>
	<%@ include file="/resources/css/header.css" %>

	.main {
		width: auto;
		height: auto;
		float: left;
		margin-top: 50px;
	}
	
	.menu {
		width: 350px;
		float: right;
		margin-top: 35px;
	}
	
	.menuA {
		margin-right: 20px;
		margin-top: 20px;
	}
	
	.menuA:hover {
		color: #FF493C;
	}
</style>
<script>
    $(document).ready(function () {
    	var searchForm = $("#searchForm");
    	
    	$('#searchBtn').on("click", function() {
    		if (!searchForm.find("#keyword").val()) {
    			alert("검색할 상품을 입력하세요.");
    		} else {
        		e.preventDefault();
        		searchForm.submit();
    		}
    	});
    });
</script>
<div class="header">
	<div class="main">
		<a class="menuA" href="${contextPath}/">
			<i class="fa-solid fa-g"></i>
			<i class="fa-solid fa-o"></i>
			<i class="fa-solid fa-g"></i>
			<i class="fa-solid fa-u"></i>
			<i class="fa-solid fa-m"></i>
			<i class="fa-solid fa-a"></i>
			🍠
		</a>
	</div>
		
   	<div class="search">
    	<form id="searchForm" action="${contextPath}/category/1/search/" autocomplete="off">
			<input type="text" id="keyword" name="keyword" placeholder="상품명을 검색하세요" autocomplete="off" value="${keyword}"></input>
			<button type="submit" class="searchBtn" id="searchBtn"></button>
		</form>
    </div>
    
	<div class="menu">
		<sec:authorize access="isAnonymous()">
			<a class="menuA" href="${contextPath}/member/login.do"><i class="fa-solid fa-right-to-bracket"></i>로그인</a>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
		 	<a class="menuA" href="javascript: document.logout.submit()"><i class="fa-solid fa-right-to-bracket"></i>로그아웃</a>
			<form name="logout" action="${contextPath}/logout.do" method="post" hidden="true">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="submit" value="로그아웃" hidden="true"/>
			</form>
		</sec:authorize>
		
		<a class="menuA" href="${contextPath}/cart/"><i class="fa-solid fa-cart-shopping"></i>장바구니</a>
		<a class="menuA" href="${contextPath}/mypage/"><i class="fa-solid fa-circle-user"></i>마이페이지</a>
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
	</div>
</div>