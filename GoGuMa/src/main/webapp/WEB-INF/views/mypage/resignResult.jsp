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
    </style>
</head>
<body>
	<%@ include file="../header.jsp" %>
	<div class="container mt-5" style="min-width: 1200px">
		<div class="row">
            <div class="col" align="center">
                <div class="d-flex flex-column justify-content-center border border-2 rounded mb-2" style="padding: 200px">
                    <div class="mb-2">
                        <h5><b>고구마몰 회원탈퇴가 완료되었습니다.</b></h5>
                        고구마몰을 이용해주신 ${memberDTO.name} 고객님께 감사드립니다.
                        <br>
                        고객님의 소중한 의견을 통해 더욱 좋은 서비스와
                        <br>
                        품질로 보답하는 고구마몰이 되겠습니다.
                        <br>
                        감사합니다.
                    </div>
                    <div>
                        <button type="button" class="btn btn-sm btn-dark" onclick="location.href='${contextPath}/main.do'">메인으로 이동</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>