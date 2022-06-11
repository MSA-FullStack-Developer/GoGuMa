<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  
    <title>고구마 - 고객과 구성하는 마켓</title>

    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
        crossorigin="anonymous"></script>

    <!-- bootstrap icon -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    
    <!-- jquery -->
	<script type="text/javascript" src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function() {
			var error = "${error}";
			if(error) {
				alert(error);
			}
		})
	</script>
	
	<%@ include file="../header.jsp" %>
	
    <section class="container"> 
        <div class="align-items-center min-vh-100">
            <div class="w-50 m-auto p-5" style="min-width: 650px;">
                <h1 style="margin-top: 45px">LOGIN</h1>
                <form id="login-form" method="post" action="${contextPath}/login" class="mt-3">
                
                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <label for="username" class="form-label">
                        이메일 아이디
                    </label>
                    <input id="username" name="username" type="email" class="form-control" placeholder="example@example.com" required/>
                    <label for="password" class="form-label mt-3">
                        비밀번호
                    </label>
                    <input id="password" name="password" type="password" class="form-control" required/>
                    <div class="form-check mt-3">
                        <input class="form-check-input" type="checkbox"  id="remember-me" name="remember-me">
                        <label class="form-check-label" for="remember-me">
                          로그인 유지하기
                        </label>
                      </div>
                    <button type="submit" class="w-100 btn btn-lg mt-3" style="background-color: #6426DD; color: white;">로그인하기</button>
                </form>
                <a class="w-100 btn btn-outline-dark btn-lg mt-3" role="button" href="${contextPath}/member/join/start.do">회원가입하기</a>
                <div class="w-100 d-flex justify-content-around mt-3">
                    <a class="text-secondary text-decoration-none pe-auto" href="${contextPath}/member/findId/start.do">아이디찾기</a>
                    <a class="text-secondary text-decoration-none pe-auto" href="${contextPath}/member/findPwd/start.do">비밀번호 찾기</a>
                </div>
            </div>
        </div>
    </section>
    
    <%@ include file="../footer.jsp" %>
</body>
</html>