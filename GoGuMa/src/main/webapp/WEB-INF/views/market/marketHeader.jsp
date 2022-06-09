<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<script src="https://kit.fontawesome.com/a4f59ea730.js" crossorigin="anonymous"></script>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<style>
	<%@ include file="/resources/css/header.css" %>
</style>
<div class="header-top">
	<div class="back">
		<a class="backG" href="${contextPath}/"><i class="fa-solid fa-circle-chevron-left"></i>고구마몰로 돌아가기</a>
	</div>
	
	<div class="menu">
		<sec:authorize access="isAnonymous()">
			<a class="menuB" href="${contextPath}/member/login.do"><i class="fa-solid fa-right-to-bracket"></i>로그인</a>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
		 	<a class="menuB" href="javascript: document.logout.submit()"><i class="fa-solid fa-right-to-bracket"></i>로그아웃</a>
			<form name="logout" action="${contextPath}/logout.do" method="post" hidden="true">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="submit" value="로그아웃" hidden="true"/>
			</form>
		</sec:authorize>
		
		<a class="menuB" href="${contextPath}/cart/"><i class="fa-solid fa-cart-shopping"></i>장바구니</a>
		<a class="menuB" href="${contextPath}/mypage/"><i class="fa-solid fa-circle-user"></i>마이페이지</a>
	</div>
</div>
<div class="header">
	<div class="main">
		<a id="market-goguma" href="${contextPath}/market/main.do">
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
</div>