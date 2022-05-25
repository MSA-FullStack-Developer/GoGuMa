<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<script type="text/javascript"
	src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
</head>
<body>
	<h1>
		Hello world!
		<sec:authorize access="isAnonymous()">
			<a href="${contextPath}/member/login.do">로그인</a>
		</sec:authorize>

		<sec:authorize access="isAuthenticated()">
			<form action="${contextPath}/logout.do" method="post">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
				<button type="submit">로그아웃</button>
			</form>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<h2>어드민입니다.</h2>
		</sec:authorize>
	</h1>


</body>
</html>