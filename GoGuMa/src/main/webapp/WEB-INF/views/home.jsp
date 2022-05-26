<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script type="text/javascript" src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>
<a href="${contextPath}/category/1/24/">'여성의류' 카테고리 보러가기</a>
<P>  The time on the server is ${serverTime}. </P>
</body>
</html>