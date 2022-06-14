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
		<a class="backG" href="${contextPath}/"><i class="fa-solid fa-circle-chevron-left" style="margin-right: 5px;"></i>고구마몰로 돌아가기</a>
	</div>
	
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
		<a class="menuB" href="${contextPath}/mypage/"><i class="fa-solid fa-circle-user" style="margin-right: 5px;"></i>마이페이지</a>
		<a class="menuB" href="${contextPath}/serviceclient/"><i class="fa-solid fa-comments" style="margin-right: 5px;"></i>고객센터</a>
	</div>
</div>

<div class="header">
	<div class="market-main">
		<a id="market-goguma" href="${contextPath}/market/main.do">
			<img src="https://hd-goguma.s3.ap-northeast-2.amazonaws.com/upload/1655184559434%E1%84%80%E1%85%A9%E1%84%80%E1%85%AE%E1%84%86%E1%85%A1%E1%84%86%E1%85%A1%E1%84%8F%E1%85%A6%E1%86%BA.png" style="width: 350px;">
		</a>
	</div>
</div>