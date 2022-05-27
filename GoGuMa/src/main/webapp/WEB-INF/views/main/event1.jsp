<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}">
	<meta name="_csrf_header" content="${_csrf.headerName}">
    <title>고구마 - 고객과 구성하는 마켓</title>

    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
        crossorigin="anonymous"></script>

   	<!-- jquery -->
	<script type="text/javascript" src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.min.js"></script>

    <!-- bootstrap icon -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
</head>

<body>
	<script type="text/javascript">
		$(document).ready(function() {
			
			var message = "${message}";
			if(message) {
				alert(message);
			} 
			
			$(".coupon").click(function(){
				var form = $(this).find("form");
				form.submit();
			})
			
		})
	</script>
    <style>
        .coupon {
            width: 400px;
            height: 300px;
            cursor: pointer;
        }
    </style>
    <%@ include file="../header.jsp" %>
    <section class="mt-5">
    <div class="h-50 container-fluid" style="background-color: #3831C9;">
        <img src="${contextPath}/resources/img/web_banner_001.png" alt="이벤트1 배너" />
    </div>

    <div class="h-50 container mt-2 p-3">
        <div class="w-100 h-100 p-3 border rounded d-flex align-items-center">
            <div class="w-100 d-flex justify-content-around">
                <div class="coupon border border-info">
                	<form class="w-100 h-100" method="post" action="${contextPath}/coupon/create.do/1?redirectUrl=event/event1.do">
                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <div class="w-100 h-75 d-flex justify-content-center align-items-center">
                        <h3>10,000원 할인</h3>
                    </div>
                    <div class="w-100 h-25 d-flex justify-content-center align-items-center"
                        style="background-color: #0dcaf0; color: white;">
                        <h4>쿠폰 받기</h4>
                        <div class="ms-2">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                                class="bi bi-download" viewBox="0 0 16 16">
                                <path
                                    d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5z" />
                                <path
                                    d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3z" />
                            </svg>
                        </div>
                    </div>
                    </form>
                </div>

                <div class="coupon border border-dark">
                	<form class="w-100 h-100" method="post" action="${contextPath}/coupon/create.do/2?redirectUrl=event/event1.do">
                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <div class="w-100 h-75 d-flex justify-content-center align-items-center">
                        <h3>5,000원 할인</h3>
                    </div>
                    <div class="w-100 h-25 d-flex justify-content-center align-items-center"
                        style="background-color: #212529; color: white;">
                        <h4>쿠폰 받기</h4>
                        <div class="ms-2">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                                class="bi bi-download" viewBox="0 0 16 16">
                                <path
                                    d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5z" />
                                <path
                                    d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3z" />
                            </svg>
                        </div>
                    </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
    </section>
    
    <%@ include file="../footer.jsp" %>
</body>

</html>