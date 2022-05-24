<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<c:set var="contextPath" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 - 고구마</title>

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

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function() {
			var valid = false;
			var form = $("#updatePwdForm");
			var passwordValidCheck = $("#password-repeat-valid");
			
			$("#password-repeat").keyup(function(){
				
				var value = $(this).val();
				console.log(value)
				var password = $("#password").val();
				console.log("password",password);
				
				if(value !== password) {
					valid = false;
					passwordValidCheck.removeClass();
					passwordValidCheck.addClass("text-danger");
					passwordValidCheck.text("비밀번호가 일치하지 않습니다.");
				} else {
					valid = true;
					passwordValidCheck.removeClass();
					passwordValidCheck.addClass("text-success");
					passwordValidCheck.text("비밀번호가 일치합니다.");
				}
			});
			
			$("#submit-btn").click(function(e){
				e.preventDefault();
				console.log(valid);
				if(!valid) {
					alert("비밀번호가 일치하는지 확인해주세요.");
				} else {
					form.submit();
				}
			});
		});
	</script>
	<section class="container">
        <div class="d-flex align-items-center min-vh-100">
            <div class="w-50 m-auto p-5" style="min-width: 650px;">
                <h1>고구마 회원 비밀번호 재설정</h1>
                <p class="text-secondary mt-2">비밀번호를 재설정을 해주세요.</p>
                <form id="updatePwdForm" class="mt-3" method="post" action="${contextPath}/member/findPwd/rewrite.do" >
                	
                	<input type="hidden" name="${_csrf.parameterName}"  value="${_csrf.token}" />
                	<input type="hidden" name="memberId" value="${memberId}"/>
                	<div>
                    <label for="password" class="form-label">
                        비밀번호
                    </label>
                    <input id="password" name="password" type="password" class="form-control" placeholder="새로 설정할 비밀번호를 입력해주세요." required/>
                    </div>
                    <div>
                    <label for="password-repeat" class="form-label mt-2">
                        비밀번호 확인
                    </label>
                    <input id="password-repeat" type="password" class="form-control" placeholder="비밀번호를 다시 확인해주세요."/>
                    <span id="password-repeat-valid"></span>
                    </div>
                    <button id="submit-btn" type="submit" class="w-100 btn mt-3 btn-lg" style="background-color: #6426DD; color: white;">비밀번호 변경</button>
                </form>
             
            </div>
        </div>
    </section>
</body>
</html>