<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="_csrf" content="${_csrf.token}">
	<meta name="_csrf_header" content="${_csrf.headerName}">
	<title>Insert title here</title>
    <!-- bootstrap icon -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	<!-- bootstrap css -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
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
            width: 100%;
            height: 100%;
        }
        table {
            table-layout: fixed;
        }
        table tbody tr {
            line-height: 3rem;
            table-layout: fixed;
            word-break: keep-all;
        }
    </style>
</head>
<body>
	<%@ include file="../header.jsp" %>
	<div class="container mt-5" style="min-width: 1200px">
		<div class="row">
			<%@ include file="mypageMenu.jsp" %>
            <div class="col">
                <div class="d-flex flex-row justify-content-evenly border border-2 rounded p-3 mb-3">
                    <div class="d-flex flex-row align-items-center">
                        <div class="me-2">
                        	<a href="${contextPath}/mypage/membershipZone">
                        		<img src="https://image.hmall.com/p/img/mp/icon/ico-rating-gold.png" style="width: 50px; height: 50px; object-fit: contain;">
                        	</a>
                        </div>
                        <div class="lh-sm" align="center">
                            <div>
                                <a href="${contextPath}/mypage/confirmPassword/changeInfo" style="font-size: 20px">
                                	<b>${memberDTO.name}님</b>
                                </a>
                            </div>
                            <div>
                                <a href="${contextPath}/mypage/membershipZone" style="font-size: 16px">Gold</a>
                            </div>  
                        </div>
                    </div>
                    <a href="${contextPath}/mypage/pointHistory/all?page=1" class="d-flex flex-column align-items-center align-self-center lh-sm">
                    	<span>포인트</span>
                       	<span><fmt:formatNumber value="${memberPoint}"/>P</span>
                    </a>
                    <a href="${contextPath}/mypage/couponHistory/available?page=1" class="d-flex flex-column align-items-center align-self-center lh-sm">
                    	<span>쿠폰</span>
	                    <span>${couponCount}장</span>
                    </a>
                    <a href="${contextPath}/mypage/writeableReview" class="d-flex flex-column align-items-center align-self-center lh-sm">
                    	<span>작성 가능한 상품평</span>
	                    <span>${writeableCount}건</span>
                    </a>
                </div>
                <div>
                    <h5><b>멤버십 등급 안내</b></h5>
                </div>
                <table class="table">
                    <tbody class="table-group-divider">
                        <tr align="center">
                            <th class="col-2">멤버십 등급</th>
                            <td>Silver</td>
                            <td>Gold</td>
                            <td>Platinum</td>
                            <td>Diamond</td>
                        </tr>
                        <tr align="center">
                            <th class="col-2">등급 할인</th>
                            <td>0%</td>
                            <td>1%</td>
                            <td>2%</td>
                            <td>3%</td>
                        </tr>
                        <tr align="center">
                            <th class="col-2">적립 포인트</th>
                            <td>0%</td>
                            <td>1%</td>
                            <td>2%</td>
                            <td>5%</td>
                        </tr>
                        <tr class="lh-base" align="center">
                            <th class="col-2 align-middle">등급 기준</th>
                            <td class="align-middle">미주문</td>
                            <td class="align-middle">1회 이상 구매</td>
                            <td class="align-middle">
                                <div>
                                    5회 & 50만원
                                </div>
                                <div>
                                    이상 구매
                                </div>
                            </td>
                            <td class="align-middle">
                                <div>
                                    10회 & 100만원
                                </div>
                                <div>
                                    이상 구매
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <h5><b>멤버십 등급 선정 기준 안내</b></h5>
                </div>
                <table class="table border">
                    <tbody>
                        <tr>
                            <th class="col-2 table-active">반영 시기</th>
                            <td>매월 1일</td>
                        </tr>
                        <tr>
                            <th class="col-2 table-active">등급 기준</th>
                            <td>최근 1개월 고구마몰에서 주문한 횟수와 금액 기준</td>
                        </tr>
                        <tr>
                            <th class="col-2 table-active">대상 고객</th>
                            <td>고구마몰 모든 회원 (회원가입 필수)</td>
                        </tr>
                        <tr class="lh-base">
                            <th class="col-2 table-active align-middle">대상 주문</th>
                            <td>
                                고구마몰에서 주문한 모든 주문 건
                                <br>
                                단, 금융(보험) / 렌탈 / 모바일 쿠폰 등 일부 주문 및 취소 건 제외
                            </td>
                        </tr>
                        <tr class="lh-base">
                            <th class="col-2 table-active align-middle">유의사항</th>
                            <td>
                                <div>
                                    등급별 혜택은 고구마몰 가입 고객에 한해 누리실 수 있습니다.
                                </div>
                                <div>
                                    등급별 혜택은 고구마몰의 사정에 따라서 변경될 수 있습니다.
                                </div>
                                <div>
                                    부당한 방법(대리주문, 상업적 목적의 대량구매 등)에 의한 참여가 밝혀질 경우,
                                </div>
                                <div>
                                    심사 후 등급이 재조정될 수 있습니다.
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/dist/jquery.js' />"></script>
</html>