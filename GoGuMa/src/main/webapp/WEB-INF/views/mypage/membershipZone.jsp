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
	<title>고구마 - 고객과 구성하는 마켓</title>
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
                <div>
                    <h4><b>멤버십존</b></h4>
                </div>
                <%@ include file="../mypage/quickMenu.jsp" %>
                <div class="d-flex flex-row justify-content-evenly align-items-center border border-2 rounded p-5 mb-3">
                    <div class="d-flex flex-column align-self-center">
                    	<span style="font-size: 18pt">다음달 예상 등급 : <b>${expectedGrade.name}</b></span>
                    	<c:choose>
                    		<c:when test="${expectedGrade.name eq '다이아몬드'}">
                    			<span style="font-size: 10pt">축하합니다! 다음달에 다이아몬드 등급 혜택을 받으실 수 있습니다!</span>
                    			<span style="font-size: 10pt">상품을 구매하실 때마다 <b>${expectedGrade.discountPercent}%</b>의 할인 및 <b>${expectedGrade.pointPercent}%</b>의 포인트 적립이 적용됩니다.</span>
                    		</c:when>
                    		<c:otherwise>
                    			<c:choose>
                    				<c:when test="${memberDTO.grade.name eq '다이아몬드'}">
                    					<c:if test="${memberDTO.grade.orderCriteria > orderPerformanceDTO.orderCount && memberDTO.grade.priceCriteria > orderPerformanceDTO.orderAmount}">
                   							<span style="font-size: 10pt">다음달에 <b>${memberDTO.grade.name}</b> 등급을 유지하려면,</span>
                 							<span style="font-size: 10pt">이번달에 <b>${memberDTO.grade.orderCriteria - orderPerformanceDTO.orderCount}회</b> & <b>${memberDTO.grade.priceCriteria - orderPerformanceDTO.orderAmount}원</b> 이상의 구매실적이 필요합니다.</span>
                   						</c:if>
                   						<c:if test="${membdrDTO.grade.orderCriteria > orderPerformanceDTO.orderCount && memberDTO.grade.priceCriteria <= orderPerformanceDTO.orderAmount}">
                   							<span style="font-size: 10pt">다음달에 <b>${memberDTO.grade.name}</b> 등급을 유지하려면,</span>
                   							<span style="font-size: 10pt">이번달에 <b>${memberDTO.grade.orderCriteria - orderPerformanceDTO.orderCount}회</b> 이상의 구매실적이 필요합니다.</span>
                   						</c:if>
                   						<c:if test="${membdrDTO.grade.orderCriteria <= orderPerformanceDTO.orderCount && memberDTO.grade.priceCriteria > orderPerformanceDTO.orderAmount}">
                   							<span style="font-size: 10pt">다음달에 <b>${memberDTO.grade.name}</b> 등급을 유지하려면,</span>
                   							<span style="font-size: 10pt">이번달에 <b>${memberDTO.grade.priceCriteria - orderPerformanceDTO.orderAmount}원</b> 이상의 구매실적이 필요합니다.</span>
                   						</c:if>
                    				</c:when>
                    				<c:otherwise>
                    					<c:if test="${targetGrade.orderCriteria > orderPerformanceDTO.orderCount && targetGrade.priceCriteria > orderPerformanceDTO.orderAmount}">
                    						<span style="font-size: 10pt">다음달에 <b>${targetGrade.name}</b> 등급이 되시려면,</span>
	                        				<span style="font-size: 10pt">이번달에 <b>${targetGrade.orderCriteria - orderPerformanceDTO.orderCount}회</b> & <b>${targetGrade.priceCriteria - orderPerformanceDTO.orderAmount}원</b> 이상의 구매실적이 필요합니다.</span>
                    					</c:if>
                    					<c:if test="${targetGrade.orderCriteria > orderPerformanceDTO.orderCount && targetGrade.priceCriteria <= orderPerformanceDTO.orderAmount}">
                    						<span style="font-size: 10pt">다음달에 <b>${targetGrade.name}</b> 등급이 되시려면,</span>
	                        				<span style="font-size: 10pt">이번달에 <b>${targetGrade.orderCriteria - orderPerformanceDTO.orderCount}회</b> 이상의 구매실적이 필요합니다.</span>
                    					</c:if>
                    					<c:if test="${targetGrade.orderCriteria <= orderPerformanceDTO.orderCount && targetGrade.priceCriteria > orderPerformanceDTO.orderAmount}">
                    						<span style="font-size: 10pt">다음달에 <b>${targetGrade.name}</b> 등급이 되시려면,</span>
	                        				<span style="font-size: 10pt">이번달에 <b>${targetGrade.priceCriteria - orderPerformanceDTO.orderAmount}원</b> 이상의 구매실적이 필요합니다.</span>
                    					</c:if>
                    				</c:otherwise>
                    			</c:choose>
                    		</c:otherwise>
                    	</c:choose>
                    </div>
                    <div class="d-flex flex-column align-self-center">
                        <div>
                            <span>1년 간 나의 구매 금액 :</span>
                        </div>
                        <div>
                            <span>1년 간 내가 받은 할인 :</span>
                        </div>
                        <div>
                            <span>1년 간 내가 적립한 포인트 :</span>
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-end align-self-center">
                        <div>
                            <span><b><fmt:formatNumber value="${purchaseAmount - discountAmount}" /></b>원</span>
                        </div>
                        <div>
                            <span><b><fmt:formatNumber value="${discountAmount}" /></b>원</span>
                        </div>
                        <div>
                            <span><b><fmt:formatNumber value="${earnedPoint}" /></b>P</span>
                        </div>
                    </div>
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
                            <td>매월 마지막 날짜</td>
                        </tr>
                        <tr>
                            <th class="col-2 table-active">등급 기준</th>
                            <td>1개월 간 고구마몰에서 주문한 횟수와 금액 기준</td>
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
</html>