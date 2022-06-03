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
	    img {
	        width: 70%;
	        height: 70%;
	        margin-top: 15%;
	        margin-bottom: 15%;
	    }
	    .bundle {
	        width: 25%;
	        height: 25%;
	    }
</style>
</head>
<body>
	<div class="container mt-5" style="min-width: 1200px">
		<div class="row">
			<div class="col-3">
                <div class="col mb-4">
                    <h3><a href="${contextPath}/mypage"><b>마이페이지</b></a></h3>
                </div>
                <div class="col mb-4">
                    <div>
                        <h5><b>MY 쇼핑</b></h5>
                    </div>
                    <div>
                        <a href="${contextPath}/mypage/orderHistory">주문내역</a>
                    </div>
                </div>
                <div class="col mb-4">
                    <div>
                        <h5><b>MY 혜택</b></h5>
                    </div>
                    <div>
                        <a href="${contextPath}/mypage/pointHistory/all">포인트</a>
                    </div>
                    <div >
                        예치금
                    </div>
                    <div>
                        쿠폰
                    </div>
                </div>
                <div class="col mb-4">
                    <h5><b>MY 활동</b></h5>
                    <div>
                        내가 작성한 상품후기
                    </div>
                    <div>
                        작성 가능한 상품후기
                    </div>
                </div>
                <div class="col">
                    <h5><b>MY 정보</b></h5>
                    <div>
                        회원정보변경
                    </div>
                    <div>
                        비밀번호변경
                    </div>
                    <div>
                        <a href="${contextPath}/mypage/manageAddress">배송지관리</a>
                    </div>
                    <div>
                        회원탈퇴
                    </div>
                </div>
			</div>
            <div class="col">
                <div class="col">
                    <h5><b>👨‍💻 송진호님</b></h5>
                </div>
                <div class="d-flex flex-row justify-content-evenly border border-2 rounded mb-2">
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
                            <a href="${contextPath}/mypage/pointHistory">포인트</a>
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
                <div class="col mt-3">
                    <h5><b>최근 주문내역</b></h5>
                </div>
                <div class="d-flex flex-row mb-2">
                    <div class="bundle">
                        <div class="d-flex flex-column align-items-center border rounded">
                            <img src="resources\img\아몬드세트.jpg">
                        </div>
                        <div class="d-flex flex-column align-items-center">
                            허니버터아몬드 허니버터아몬드 허니버터아몬드
                        </div>
                    </div>
                    <div class="bundle">
                        <div class="d-flex flex-column align-items-center border rounded">
                            <img src="resources\img\아몬드세트.jpg">
                        </div>
                        <div class="d-flex flex-column align-items-center">
                            허니버터아몬드 허니버터아몬드 허니버터아몬드
                        </div>
                    </div>
                </div>
                <div class="col mt-3">
                    <h5><b>내가 작성한 후기</b></h5>
                </div>
                <div class="d-flex flex-row mb-2">
                    <div class="bundle">
                        <div class="d-flex flex-column align-items-center border rounded">
                            <img src="resources\img\핫브레이크미니.jpg">
                        </div>
                        <div class="d-flex flex-column align-items-center">
                            핫 브레이크 핫 브레이크 핫 브레이크 핫 브레이크
                        </div>
                    </div>
                    <div class="bundle">
                        <div class="d-flex flex-column align-items-center border rounded">
                            <img src="resources\img\핫브레이크미니.jpg">
                        </div>
                        <div class="d-flex flex-column align-items-center">
                            핫 브레이크 핫 브레이크 핫 브레이크 핫 브레이크
                        </div>
                    </div>
                </div>
            </div>
		</div>
	</div>
</body>
</html>