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
	<script type="text/javascript">
		
	</script>
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
	<script type="text/javascript">
	
		$(document).ready(function() {
			var error = "${error}";
			if(error) {
				alert("필수 입력값을 넣어주세요.");
			}
		})
	</script>
	<section class="container" style="min-width: 970px;">
		<div class="w-50 m-auto p-5">
			<h1>고구마 회원가입</h1>
			<p class="text-secondary">아래 회원 정보를 기입해주세요.</p>

			<form id="joinForm" method="post" action="${contextPath}/member/join/create.do">
				<input type="hidden" name="_csrf" value="${_csrf.token}" />
				<label for="email" class="form-label"> 사용할 이메일 아이디 </label> 
				<input name="email" type="email" class="form-control" placeholder="example@example.com" required/>
				<label for="password" class="form-label mt-3" > 비밀번호 </label> 
				<input name="password" type="password" class="form-control" required/> 
				<label for="password-repeat" class="form-label mt-3" > 비밀번호 확인 </label> 
				<input name="password-repeat" type="password" class="form-control" required/> 
				<label for="name" class="form-label mt-3"> 이름 </label> 
				<input name="name" type="text" class="form-control" value="${member.name}" readonly />
				<label for="phone" class="form-label mt-3"> 전화번호 </label> 
				<input name="phone" type="text" class="form-control" value="${member.phone}" readonly /> 
				<input name="age" type="hidden" value="${member.age}" />
				<div name="contract-area" class="w-100  mt-3">

					<!-- 서비스 이용 약관 확인 -->

					<c:forEach items="${contracts}" var="item">
						<div class="form-check mb-3">
							<c:if test="${item.required == true}">
								<input class="form-check-input" type="checkbox" name="agreement" value="${item.id}" required /> 
							</c:if>
							<c:if test="${item.required == false}">
								<input class="form-check-input" type="checkbox" name="agreement" value="${item.id}" /> 
							</c:if>
							
							<label class="form-check-label d-flex justify-content-between"> 
								<span>${item.title} <c:if test="${item.required == true}">(필수)</c:if> <c:if test="${item.required == false}">(선택)</c:if> </span>
								<c:if test="${item.content != null}"> 
									<button type="button" class="btn btn-outline-info btn-sm"
										style="width: 100px;" data-bs-toggle="modal"
										data-bs-target="#agreement-${item.id}-modal">
											자세히 보기
									</button> 
								</c:if>
								<c:if test="${item.content != null}"> 
								<!-- Modal -->
								<div class="modal fade" id="agreement-${item.id}-modal"
									tabindex="-1" aria-labelledby="agreement-${item.id}-modal-label"
									aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="agreement-${item.id}-modal-label">
													${item.title}
												</h5>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body overflow-scroll">
												<p>
													<!-- 불러온 약관 내용 -->
													${item.content}
												</p>
											</div>

										</div>
									</div>
								</div>
								</c:if>
							</label>
						</div>
					</c:forEach>
				</div>
				<button id="submit-btn" type="submit" class="w-100 btn mt-3 btn-lg">회원가입</button>
			</form>
		</div>
	</section>
</body>
</html>