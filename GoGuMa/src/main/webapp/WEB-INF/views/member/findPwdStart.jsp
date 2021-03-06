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

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- 아임포트 js 라이브러리 -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function() {
			var code = "${code}";
			var merchantUid = "${merchantUid}";
			
			var error = "${error}";
			
			if(error) {
				alert(error);
			}
			
			 $("#certificate-btn").click(function() {
				
				IMP.init(code);
				IMP.certification({
					merchant_uid: merchantUid
				}, function(rsp) {
					if(rsp.success) {
						
						var certificateForm = $("#certificate");
						certificateForm.find("input[name='impUid']").val(rsp.imp_uid);
						
						certificateForm.submit();
					} else {
						alert("휴대폰 인증에 실패 하였습니다.");
					}
				}); // end of IMP.certification 
			});  // end of click    
			
			/* $("#certificate-btn").click(function() {
				
				var certificateForm = $("#certificate");
				certificateForm.find("input[name='impUid']").val("imp_247190538574");
				
				certificateForm.submit();
			});  */
		})
	
	</script>
	<section class="container">
        <div class="d-flex align-items-center min-vh-100">
            <div class="w-50 m-auto p-5" style="min-width: 650px;">
                <h1>고구마 회원 비밀번호 찾기</h1>
                <h4 class="mt-5">비밀번호 찾기를 위해 본인 인증을 진행해주세요.</h4>
                <form id="certificate" class="mt-3" method="post" action="${contextPath}/member/findPwd/temp.do">
                    <label for="email" class="form-label">
                        이메일 아이디
                    </label>
                    <input id="email" name="email" type="email" class="form-control" placeholder="아이디를 입력해 주세요." />
                    <input type="hidden" name="impUid" />
					<input type="hidden" name="${_csrf.parameterName}"  value="${_csrf.token}" />
                </form>
                <div id="certificate-btn" class="w-100 p-5 border border-dark rounded-4 mt-3" style="min-height: 100px; cursor: pointer;">
                    <div class="row flex align-items-center">
                        <div class="col-2">
                            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-phone" viewBox="0 0 16 16">
                                <path d="M11 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h6zM5 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H5z"/>
                                <path d="M8 14a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
                              </svg>
                        </div>
                        <div class="col">
                            <span>휴대폰으로 본인 인증을 진행해주세요.</span>
                        </div>
                       
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>