<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="totalDiscount" value="${receiptDTO.membershipDiscount + receiptDTO.couponDiscount + receiptDTO.usagePoint}" />
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
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
	<!-- bootstrap js -->
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
            line-height: 2rem;
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
                    <h5><b>👨‍💻 송진호님</b></h5>
                </div>
                <div class="d-flex flex-row justify-content-evenly border border-2 rounded mb-3">
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
                    <h5><b>주문상세</b></h5>
                </div>
                <div class="col border border-2 rounded p-4 mb-3">
                    <div class="d-flex flex-row">
                        <div class="col">
                            <h5><b><fmt:formatDate pattern="yyyy-MM-dd" value="${receiptDTO.orderDate}" /></b></h5>
                        </div>
                    </div>
                    <div class="border border-1 rounded">
                        <table>
                            <tbody>
                            	<c:forEach var="orderDTO" items="${receiptDTO.orderList}">
	                                <!--여기부터 forEach-->
	                                <tr class="border-bottom">
	                                    <td class="col-1 p-3">
	                                        <img src="${orderDTO.image}" style="width:100px; height:100px">
	                                    </td>
	                                    <td class="col-5 border-end">
	                                        ${orderDTO.name}
	                                    </td>
	                                    <td class="border-end">
	                                        <div class="col" align="center">
	                                            <div>
	                                            	<c:set var="orderPrice" value="${orderDTO.price * orderDTO.count}" />
	                                            	<fmt:formatNumber value="${orderPrice}" />원
	                                            </div>
	                                            <div>
	                                                (${orderDTO.count}개)
	                                            </div>
	                                        </div>
	                                    </td>
	                                    <td>
	                                        <div class="col" align="center">
	                                        	<c:choose>
	                                        		<c:when test="${orderDTO.status eq 'N'}">
		                                        		<div>
			                                                <h5><b>주문 완료</b></h5>
			                                            </div>
			                                            <div class="mb-2">
			                                                <button type="button" class="btn btn-sm btn-outline-dark" onclick="configBtn(${orderDTO.orderId})">구매확정</button>
			                                            </div>
			                                            <div class="mt-2">
			                                                <button type="button" class="btn btn-sm btn-outline-dark" onclick="cancelBtn(${orderDTO.orderId})">주문취소</button>
			                                            </div>
	                                        		</c:when>
	                                        		<c:when test="${orderDTO.status eq 'F'}">
	                                        			<div>
			                                                <h5><b>구매 완료</b></h5>
			                                            </div>
			                                            <div class="mb-2">
			                                                <button type="button" class="btn btn-sm btn-outline-dark">상품평 쓰기</button>
			                                            </div>
	                                        		</c:when>
	                                        		<c:otherwise>
	                                        			<div>
			                                                <h5><b>취소 완료</b></h5>
			                                            </div>
	                                        		</c:otherwise>
	                                        	</c:choose>
	                                        </div>
	                                    </td>
                                    </tr>
	                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div>
                    <h5><b>배송지 정보</b></h5>
                </div>
                <table class="table mb-3" style="margin: auto;">
                    <tbody class="table-group-divider">
                        <tr>
                            <th>배송지 별칭</th>
                            <td>${receiptDTO.rcptNickname}</td>
                        </tr>
                        <tr>
                            <th>수령인</th>
                            <td>${receiptDTO.recipient}</td>
                        </tr>
                        <tr>
                            <th>연락처</th>
                            <td>${receiptDTO.rcptContact}</td>
                        </tr>
                        <tr>
                            <th>배송지 주소</th>
                            <td>${receiptDTO.rcptAddress}</td>
                        </tr>
                        <tr>
                            <th>배송시 요청사항</th>
                            <td>${receiptDTO.requirement}</td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <h5><b>할인 정보</b></h5>
                </div>
                <table class="table mb-3" style="margin: auto;">
                    <tbody class="table-group-divider">
                        <tr>
                            <th>멤버십 등급 할인</th>
                            <td>-<fmt:formatNumber value="${receiptDTO.membershipDiscount}" />원</td>                           
                        </tr>
                         <tr>
                            <th>쿠폰 할인</th>
                            <td>-<fmt:formatNumber value="${receiptDTO.couponDiscount}" />원</td>
                        </tr>
                        <tr>
                            <th>포인트 할인</th>
                            <td>-<fmt:formatNumber value="${receiptDTO.usagePoint}" />원</td>
                        </tr>
                        <tr>
                            <th>할인 합계</th>
                            <td><b>-<fmt:formatNumber value="${totalDiscount}" />원</b></td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <h5><b>결제 정보</b></h5>
                </div>
                <table class="table mb-3" style="margin: auto;">
                    <tbody class="table-group-divider">
                        <tr>
                            <th>상품 합계</th>
                            <td><fmt:formatNumber value="${receiptDTO.originalPrice}" />원</td>                           
                        </tr>
                        <tr>
                            <th>할인 합계</th>
                            <td>-<fmt:formatNumber value="${totalDiscount}" />원</td>
                        </tr>
                        <tr>
                            <th>예상 적립 포인트</th>
                            <td>+<fmt:formatNumber value="${pointDTO.pointValue}" />P</td>
                        </tr>
                        <tr>
                            <th>최종 결제금액</th>
                            <td><b><fmt:formatNumber value="${receiptDTO.totalPrice}" />원</b></td>
                        </tr>
                        <tr>
                            <th>결제수단</th>
                            <td>우리카드 일시불</td>
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
<script type="text/javascript">
	function configBtn(orderId) {
		if(confirm("구매확정 하시겠습니까?")) {
			let token = $("meta[name='_csrf']").attr("content");
		    let header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "${contextPath}/mypage/orderHistory/updateOrderStatus",
				type : "POST",
				data : {
					orderId : orderId,
					status : 'F'
				},
				beforeSend : function(xhr) {
		            xhr.setRequestHeader(header, token);
	            },
				success:function(result) {
					if(result==1) {
						window.location.href = "${contextPath}/mypage/orderHistory/${receiptDTO.receiptId}";
					} else {
						alert('구매확정 오류');
					}
				}
			})
		}
	}
	function cancelBtn(orderId) {
		if(confirm("주문을 취소하시겠습니까?")) {
			let token = $("meta[name='_csrf']").attr("content");
		    let header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "${contextPath}/mypage/orderHistory/updateOrderStatus",
				type : "POST",
				data : {
					orderId : orderId,
					status : 'C'
				},
				beforeSend : function(xhr) {
		            xhr.setRequestHeader(header, token);
	            },
				success:function(result) {
					if(result==1) {
						window.location.href = "${contextPath}/mypage/orderHistory/${receiptDTO.receiptId}";
					} else {
						alert('주문취소 오류');
					}
				}
			})
		}
	}
</script>
</html>