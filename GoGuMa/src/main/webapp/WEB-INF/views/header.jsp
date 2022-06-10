<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<script type="text/javascript" src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.js"></script>
<script src="https://kit.fontawesome.com/a4f59ea730.js" crossorigin="anonymous"></script>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<style>
	<%@ include file="/resources/css/header.css" %>
</style>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/dist/jquery.js' />"></script>
<script src="https://kit.fontawesome.com/a4f59ea730.js" crossorigin="anonymous"></script>
<script type="text/javascript">
    $(document).ready(function () {
    	var searchForm = $("#searchForm");
    	
    	$('#searchBtn').on("click", function() {
    		if (!searchForm.find("#keyword").val()) {
    			alert("검색할 상품을 입력하세요.");
    			searchForm.attr("onsubmit", false);
    		} else {
        		searchForm.submit();
    		}
    	});
    });
</script>
<div class="header-top">
	<div class="menu">
		<sec:authorize access="isAnonymous()">
			<a class="menuB" href="${contextPath}/member/login.do"><i class="fa-solid fa-right-to-bracket" style="margin-right: 5px;"></i>로그인</a>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
		 	<a class="menuB" href="javascript: document.logout.submit()"><i class="fa-solid fa-right-to-bracket" style="margin-right: 5px;"></i>로그아웃</a>
			<form name="logout" action="${contextPath}/logout.do" method="post" hidden="true">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="submit" value="로그아웃" hidden="true"/>
			</form>
		</sec:authorize>
		
		<a class="menuB" href="${contextPath}/cart/"><i class="fa-solid fa-cart-shopping" style="margin-right: 5px;"></i>장바구니</a>
		<a class="menuB" href="${contextPath}/mypage?page=1"><i class="fa-solid fa-circle-user" style="margin-right: 5px;"></i>마이페이지</a>
	</div>
</div>
<div class="header">
	<div class="main">
		<a class="menuA" href="${contextPath}/">
			<i class="fa-solid fa-g"></i>
			<i class="fa-solid fa-o"></i>
			<i class="fa-solid fa-g"></i>
			<i class="fa-solid fa-u"></i>
			<i class="fa-solid fa-m"></i>
			<i class="fa-solid fa-a"></i>
			<i class="fa-solid fa-m"></i>
			<i class="fa-solid fa-a"></i>
			<i class="fa-solid fa-l"></i>
			<i class="fa-solid fa-l"></i>
		</a>
	</div>	
		
	<div style="margin-top: 40px;">
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
		
		<div class="gotoGGM">
			<a id="goguma" href="${contextPath}/market/main.do">
				<i class="fa-solid fa-g"></i>
				<i class="fa-solid fa-o"></i>
				<i class="fa-solid fa-g"></i>
				<i class="fa-solid fa-u"></i>
				<i class="fa-solid fa-m"></i>
				<i class="fa-solid fa-a"></i><br>
				<i class="fa-solid fa-m"></i>&nbsp;&nbsp;
				<i class="fa-solid fa-a"></i>&nbsp;&nbsp;
				<i class="fa-solid fa-r"></i>&nbsp;&nbsp;
				<i class="fa-solid fa-k"></i>&nbsp;&nbsp;
				<i class="fa-solid fa-e"></i>&nbsp;&nbsp;
				<i class="fa-solid fa-t"></i>
			</a>
		</div>
	
	    <div class="search">
	    	<form id="searchForm" action="${contextPath}/category/1/search/" autocomplete="off">
				<input type="text" id="keyword" name="keyword" placeholder="상품명을 검색하세요" autocomplete="off" value="${keyword}"></input>
				<button type="button" class="searchBtn" id="searchBtn"></button>
			</form>
		</div>
	</div>
</div>