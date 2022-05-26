<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - 고구마</title>

<!-- bootstrap css -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

<!-- bootstrap js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

<!-- bootstrap icon -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<!-- jquery -->
<script type="text/javascript" src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
</head>
<body>
<style>
	#go-login-btn {
		background-color: #6426DD;
		color: white;
	}

	.btn {
		width: 45%;
	}
</style>
	<section class="container">
		<div class="d-flex align-items-center min-vh-100">
			<div class="w-50 m-auto p-5" style="min-width: 650px;">
				<h1>고구마 회원가입</h1>
				<h4 class="mt-5">이미 가입된 회원입니다.</h4>
				<p class="text-secondary">아래 회원 정보를 확인해주세요.</p>
				<div name="memberInfo"
					class="w-100 p-4 border border-dark rounded-4 mt-3"
					style="min-height: 100px;">
					<h4 class="border-bottom pb-3">고구마 회원</h4>
					<div name="member-name" class="row mt-4">
						<div class="col-2">
							<span class="text-secondary">이름</span>
						</div>
						<div class="col">
							<span>${name}</span>
						</div>
					</div>
					<div name="member-email" class="row mt-3">
						<div class="col-2">
							<span class="text-secondary">아이디</span>
						</div>
						<div class="col">
							<span>${email}</span>
						</div>
					</div>
					<div name="member-regdate" class="row mt-3">
						<div class="col-2">
							<span class="text-secondary">가입일</span>
						</div>
						<div class="col">
							<span>
								<fmt:formatDate value="${joinDate}" pattern="yyyy.MM.dd"/>
							</span>
						</div>
					</div>
				</div>
				<div class="d-flex justify-content-between mt-5">
					<a id="find-pw-btn" type="button"
						class="btn btn-outline-dark btn-lg" href="${contextPath}/member/findPwd/start.do">비밀번호 찾기</a>
					<a id="go-login-btn" type="button" class="btn btn-lg" href="${contextPath}/member/login.do">로그인하기</a>
				</div>

			</div>
		</div>
	</section>
</body>
</html>