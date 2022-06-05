<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            line-height: 2rem;
            table-layout: fixed;
        	word-break: keep-all;
        }
    </style>
</head>
<body>
	<div class="container mt-5" style="min-width: 1200px">
		<div class="row">
			<div class="col-3">
                <div class="mb-4">
                    <h3><a href="${contextPath}/mypage"><b>마이페이지</b></a></h3>
                </div>
                <div class="mb-4">
                    <div>
                        <h5><b>MY 쇼핑</b></h5>
                    </div>
                    <div>
                        <a href="${contextPath}/mypage/orderHistory">주문내역</a>
                    </div>
                </div>
                <div class="mb-4">
                    <div>
                        <h5><b>MY 혜택</b></h5>
                    </div>
                    <div>
                        <a href="${contextPath}/mypage/pointHistory/all?page=1">포인트</a>
                    </div>
                    <div >
                        예치금
                    </div>
                    <div>
                        <a href="${contextPath}/mypage/couponHistory/available?page=1">쿠폰</a>
                    </div>
                </div>
                <div class="mb-4">
                    <h5><b>MY 활동</b></h5>
                    <div>
                        내가 작성한 상품후기
                    </div>
                    <div>
                        작성 가능한 상품후기
                    </div>
                </div>
                <div>
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
                <div>
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
                            <a href="${contextPath}/mypage/pointHistory/all?page=1">포인트</a>
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
                            <a href="${contextPath}/mypage/couponHistory/available?page=1">쿠폰</a>
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
                    <h5><b>쿠폰</b></h5>
                </div>
                <div class="d-flex flex-row border border-2 mb-3">
                    <a href="${contextPath}/mypage/couponHistory/available?page=1" class="col p-2 active" style="text-align: center; background-color: rgb(187, 184, 184);">사용가능</a>
                    <a href="${contextPath}/mypage/couponHistory/unavailable?page=1" class="col p-2" style="text-align: center;">사용완료 & 기간만료</a>
                </div>
                <c:choose>
                	<c:when test="${type eq 'available'}">
	                	<!-- 사용가능 쿠폰 -->
		                <table class="table mb-3 active" style="margin: auto; text-align: center; vertical-align: middle;">
		                    <thead class="table-secondary table-group-divider">
		                        <tr>
		                            <th>쿠폰명</th>
		                            <th>혜택</th>
		                            <!-- <th>사용조건</th> -->
		                            <th>유효기간</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                    	<c:forEach var="couponDTO" items="${couponList}">
			                        <tr>
			                            <td>${couponDTO.couponName}</td>
			                            <td><fmt:formatNumber value="${couponDTO.benefit}" />원 할인</td>
			                            <!-- <td><fmt:formatNumber value="${couponDTO.restriction}" />원 이상 구매시</td> -->
			                            <td>~ <fmt:formatDate pattern="yyyy-MM-dd" value="${couponDTO.expirationDate}" /></td>
			                        </tr>
			                    </c:forEach>
		                    </tbody>
		                </table>
                	</c:when>
                	<c:otherwise>
	                	<!-- 사용완료 & 기간만료 쿠폰 -->
		                <table class="table mb-3" style="margin: auto; text-align: center; vertical-align: middle;">
		                    <thead class="table-secondary table-group-divider">
		                        <tr>
		                            <th>쿠폰명</th>
		                            <th>혜택</th>
		                            <!-- <th>사용조건</th> -->
		                            <th>유효기간</th>
		                            <th>상태</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                    	<c:forEach var="couponDTO" items="${couponList}">
		                    		<tr>
		                    			<td>${couponDTO.couponName}</td>
		                    			<td><fmt:formatNumber value="${couponDTO.benefit}" />원 할인</td>
		                    			<!-- <td><fmt:formatNumber value="${couponDTO.restriction}" />원 이상 구매시</td> -->
		                    			<td>~ <fmt:formatDate pattern="yyyy-MM-dd" value="${couponDTO.expirationDate}" /></td>
		                    			<td>
		                    				<c:choose>
		                    					<c:when test="${couponDTO.used eq 1}">
		                    						사용완료
		                    					</c:when>
		                    					<c:otherwise>
		                    						기간만료
		                    					</c:otherwise>
		                    				</c:choose>
		                    			</td>
		                    		</tr>
		                    	</c:forEach>
		                    </tbody>
		                </table>
                	</c:otherwise>
                </c:choose>
                <ul class="pagination justify-content-center">
                	<c:if test="${startPage ne 1}">
                		<li class="page-item">
                			<a class="page-link" href="${contextPath}/mypage/couponHistory/${type}?page=${startPage-1}" aria-label="Previous">
	                			<span aria-hidden="true">&laquo;</span>
	                		</a>
                		</li>
                	</c:if>
                	<c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                		<c:choose>
                			<c:when test="${page == pageNum}">
                				<li class="page-item active">
                					<p class="page-link">${pageNum}</p>
                				</li>
                			</c:when>
                			<c:otherwise>
                				<li class="page-item">
                					<a class="page-link" href="${contextPath}/mypage/couponHistory/${type}?page=${pageNum}">
                						${pageNum}
                					</a>
                				</li>
                			</c:otherwise>
                		</c:choose>
                	</c:forEach>
                	<c:if test="${endPage ne pageCount}">
                		<li class="page-item">
                			<a class="page-link" href="${contextPath}/mypage/couponHistory/${type}?page=${endPage+1}" aria-label="Next">
					    		<span aria-hidden="true">&raquo;</span>
					    	</a>
                		</li>
                	</c:if>
                </ul>
            </div>
        </div>
    </div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/dist/jquery.js' />"></script>
<script type="text/javascript">

</script>
</html>