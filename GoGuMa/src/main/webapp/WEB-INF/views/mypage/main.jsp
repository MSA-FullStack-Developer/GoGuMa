<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
    <!-- bootstrap icon -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	<!-- bootstrap css -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
	<!-- bootstrap js -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
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
			<%@ include file="mypageMenu.jsp" %>
            <div class="col">
                <div class="col">
                    <h4><b>${memberDTO.name}님</b></h4>
                </div>
                <div class="d-flex flex-row justify-content-evenly border rounded mb-3">
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            회원등급
                        </div>
                        <div>
                            💎
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            포인트
                        </div>
                        <div>
                            1,000P
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            예치금
                        </div>
                        <div>
                            10,000원
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            쿠폰
                        </div>
                        <div>
                            3장
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            작성 가능한 상품평
                        </div>
                        <div>
                            5건
                        </div>
                    </div>
                </div>
                <div>
                    <h5><b>최근 본 상품</b></h5>
                </div>
                <div>
                    <div class="row mb-3">
                        <div class="col-3">
                            <div class="border mb-1 p-3">
                                <img src="https://image.hmall.com/static/3/0/19/38/2138190316_0.jpg?RS=660x660&AR=0" style="width: 100%; height: 100%">
                            </div>
                            <div class="text-truncate">
                                핫브레이크 핫브레이크
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="border mb-1 p-3">
                                <img src="https://image.hmall.com/static/9/6/76/31/2131766991_0.jpg?RS=520x520&AR=0" style="width: 100%; height: 100%">
                            </div>
                            <div class="text-truncate">
                                핫브레이크 핫브레이크 핫브레이크 핫브레이크 핫브레이크 핫브레이크 핫브레이크 핫브레이크
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="border mb-1 p-3">
                                <img src="https://image.hmall.com/static/9/6/76/31/2131766991_0.jpg?RS=520x520&AR=0" style="width: 100%; height: 100%">
                            </div>
                            <div class="text-truncate">
                                핫브레이크 핫브레이크
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="border mb-1 p-3">
                                <img src="https://image.hmall.com/static/9/6/76/31/2131766991_0.jpg?RS=520x520&AR=0" style="width: 100%; height: 100%">
                            </div>
                            <div class="text-truncate">
                                핫브레이크 핫브레이크
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-3">
                            <div class="border mb-1 p-3">
                                <img src="https://image.hmall.com/static/3/0/19/38/2138190316_0.jpg?RS=660x660&AR=0" style="width: 100%; height: 100%">
                            </div>
                            <div class="text-truncate">
                                허니버터아몬드 허니버터아몬 허니버터아몬드 허니버터아몬 허니버터아몬드 허니버터아몬
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="border mb-1 p-3">
                                <img src="https://image.hmall.com/static/9/6/76/31/2131766991_0.jpg?RS=520x520&AR=0" style="width: 100%; height: 100%">
                            </div>
                            <div class="text-truncate">
                                허니버터아몬드 허니버터아몬 허니버터아몬드 허니버터아몬 허니버터아몬드 허니버터아몬
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="border mb-1 p-3">
                                <img src="https://image.hmall.com/static/9/6/76/31/2131766991_0.jpg?RS=520x520&AR=0" style="width: 100%; height: 100%">
                            </div>
                            <div class="text-truncate">
                                허니버터아몬드 허니버터아몬 허니버터아몬드 허니버터아몬 허니버터아몬드 허니버터아몬
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="border mb-1 p-3">
                                <img src="https://image.hmall.com/static/9/6/76/31/2131766991_0.jpg?RS=520x520&AR=0" style="width: 100%; height: 100%">
                            </div>
                            <div class="text-truncate">
                                허니버터아몬드 허니버터아몬 허니버터아몬드 허니버터아몬 허니버터아몬드 허니버터아몬
                            </div>
                        </div>
                    </div>
                </div>
            </div>
		</div>
	</div>
	<%@ include file="../footer.jsp" %>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/dist/jquery.js' />"></script>
<script type="text/javascript">
	let arr = JSON.parse(sessionStorage.getItem('latelySeenProductList'));
	arr.forEach((item, index, array) => {
		console.log(item.productID);
		console.log(item.categoryID);
		console.log(item.productName);
		console.log(item.productImgUrl);
	});
</script>
</html>