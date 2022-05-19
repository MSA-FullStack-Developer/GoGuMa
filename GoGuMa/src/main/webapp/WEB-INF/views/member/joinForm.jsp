<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - 고구마</title>

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

<!-- jquery -->
<script type="text/javascript"
	src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
</head>
<body>

<style>
#submit-btn {
	background-color: #8540f5;
	color: white;
}

.btn {
	width: 45%;
}

.modal-body {
	max-height: 300px;
}

.modal-body p {
	white-space: pre-line;
}
</style>
	<section class="container">
		<div class="w-50 m-auto p-5" style="min-width: 970x;">
			<h1>고구마 회원가입</h1>
			<p class="text-secondary">아래 회원 정보를 기입해주세요.</p>

			<form id="joinForm">
				<label for="memberEmail" class="form-label"> 사용할 이메일 아이디 </label> 
				<input id="memberEmail" type="email" class="form-control"placeholder="example@example.com" /> 
				<label for="memberPwd" class="form-label mt-3"> 비밀번호 </label> 
				<input id="memberPwd" type="password" class="form-control" /> 
				<label for="memberPwd-repeat" class="form-label mt-3"> 비밀번호 확인 </label> 
				<input id="memberPwd-repeat" type="password" class="form-control" /> 
				<label for="memberName" class="form-label mt-3"> 이름 </label> 
				<input id="memberName" type="text" class="form-control" readonly /> 
				<label for="memberPhone" class="form-label mt-3"> 전화번호 </label> 
				<input id="memberPhone" type="text" class="form-control" readonly />

				<div name="contract-area" class="w-100  mt-3">

					<!-- 서비스 이용 약관 확인 -->
					<div class="form-check">
						<input class="form-check-input" type="checkbox" value="1"
							id="agreement-service"> <label
							class="form-check-label d-flex justify-content-between"
							for="agreement-service"> <span>서비스 이용약관 동의 (필수)</span>
							<button type="button" class="btn btn-outline-info btn-sm"
								style="width: 100px;" data-bs-toggle="modal"
								data-bs-target="#agreement-service-modal">자세히 보기</button> <!-- Modal -->
							<div class="modal fade" id="agreement-service-modal"
								tabindex="-1" aria-labelledby="agreement-service-modal-label"
								aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="agreement-service-modal-label">서비스 이용약관</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body overflow-scroll">
											<p>
												<!-- 불러온 약관 내용 -->
											</p>
										</div>

									</div>
								</div>
							</div>
						</label>
					</div>

					<!-- 개인정보 수집 및 이용 동의 확인 -->
					<div class="form-check mt-2">
						<input class="form-check-input" type="checkbox" value="2"
							id="agreement-policy"> <label
							class="form-check-label d-flex justify-content-between"
							for="agreement-policy"> <span>개인정보 수집 및 이용 동의 (필수)</span>
							<button type="button" class="btn btn-outline-info btn-sm"
								style="width: 100px;" data-bs-toggle="modal"
								data-bs-target="#agreement-policy-modal">자세히 보기</button> <!-- Modal -->
							<div class="modal fade" id="agreement-policy-modal" tabindex="-1"
								aria-labelledby="agreement-policy-modal-label"
								aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="agreement-policy-modal-label">개인정보 수집 및 이용 동의</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body overflow-scroll">
											<p>
												<!--  불러온 약관 내용 -->
											</p>
										</div>

									</div>
								</div>
							</div>
						</label>
					</div>

					<!-- 나이 정책 확인 -->
					<div class="form-check mt-3">
						<input class="form-check-input" type="checkbox" value="3"
							id="agreement-age"> <label
							class="form-check-label d-flex justify-content-between"
							for="agreement-age"> <span>만 14세 이상입니다.(필수)</span>
						</label>
					</div>

					<!-- 마켓팅 이용 동의 확인 -->
					<div class="form-check mt-3">
						<input class="form-check-input" type="checkbox" value="4"
							id="agreement-marketing"> <label
							class="form-check-label d-flex justify-content-between"
							for="agreement-marketing"> <span>광고성 정보 수신 동의 (필수)</span>
							<button type="button" class="btn btn-outline-info btn-sm"
								style="width: 100px;" data-bs-toggle="modal"
								data-bs-target="#agreement-marketing-modal">자세히 보기</button> <!-- Modal -->
							<div class="modal fade" id="agreement-marketing-modal"
								tabindex="-1" aria-labelledby="agreement-marketing-modal-label"
								aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="agreement-marketing-modal-label">광고성 정보 수신 동의</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body overflow-scroll">
											<p>
												<!-- 불러온 약관 내용 -->
											</p>
										</div>

									</div>
								</div>
							</div>
						</label>
					</div>
				</div>
				<button id="submit-btn" type="submit" class="w-100 btn mt-3 btn-lg">회원가입</button>
			</form>
		</div>
	</section>
</body>
</html>