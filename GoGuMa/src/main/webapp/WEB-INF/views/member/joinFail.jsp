<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고구마 - 고객과 구성하는 마켓</title>

<!-- bootstrap css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous">

<!-- bootstrap js -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
	crossorigin="anonymous"></script>

<!-- bootstrap icon -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
</head>

<style>
    #go-login-btn {
        background-color: #6426DD;
        color: white;
    }

    .btn {
        width: 45%;
    }
</style>
<body>
	<section class="container p-5">
        <h1>회원 가입 실패</h1>
        <p class="text-secondary">대단히 죄송합니다. 회원 가입 중 문제가 발생하였습니다.</p>
        <div class="d-flex justify-content-center w-100">
            <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
            <lottie-player src="https://assets9.lottiefiles.com/private_files/lf30_inwrfbdo.json"  background="transparent"  speed="1"  style="width: 50%; height: 50%;"  loop  autoplay></lottie-player>
        </div>
        <div class="d-flex justify-content-center mt-5">
            <a id="go-login-btn" class="btn btn-lg" role="button" href="${contextPath}/member/join/start.do">회원 가입 화면으로 이동</a>
        </div>
    </section>
</body>
</html>