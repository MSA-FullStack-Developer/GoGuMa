<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="_csrf" content="${_csrf.token}">
	<meta name="_csrf_header" content="${_csrf.headerName}">
	<title>고구마 - 고객과 구성하는 마켓</title>
    <!-- bootstrap icon -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	<!-- bootstrap css -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <style>
        a {
            text-decoration: none;
        }
        a:link {
            color: black;
        }
        a:visited {
            color: black;
        }
        table {
            table-layout: fixed;
        }
        table tbody tr {
            line-height: 2rem;
            table-layout: fixed;
            word-break: keep-all;
        }
    </style>
</head>
<body>
	<%@ include file="../header.jsp" %>
	<div class="container mt-5" style="min-width: 1200px">
		<div class="row">
			<%@ include file="mypageMenu.jsp" %>
            <div class="col">
                <%@ include file="quickMenu.jsp" %>
                <div class="d-flex flex-column border border-2 rounded mb-2" style="padding: 150px" align="center">
                    <form action="${contextPath}/mypage/confirmPassword/${type}" method="POST">
                        <h5 style="width: 400px"><b>고객님의 소중한 개인정보를 보호하기 위해 비밀번호를 다시 한번 확인합니다.</b></h5>
                        <input type="password" class="form-control mb-2" name="userPassword" style="width: 400px"/>
                        <button type="submit" class="btn btn-primary" style="width: 400px">확인</button>
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>