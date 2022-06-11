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
            line-height: 2rem;
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
                    <h4><b>${memberDTO.name}님</b></h4>
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
                            <a href="${contextPath}/mypage/pointHistory/all?page=1">1,000P</a>
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            <a href="${contextPath}/mypage/couponHistory/available?page=1">쿠폰</a>
                        </div>
                        <div>
                            <a href="${contextPath}/mypage/couponHistory/available?page=1">${couponCount}장</a>
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            <a href="${contextPath}/mypage/writeableReview">작성 가능한 상품평</a>
                        </div>
                        <div>
                            <a href="${contextPath}/mypage/writeableReview">${writeableCount}건</a>
                        </div>
                    </div>
                </div>
                <div>
                    <h5><b>쿠폰</b></h5>
                </div>
                <div class="d-flex flex-row border">
                	<c:choose>
                		<c:when test="${type eq 'available'}">
	                		<a href="${contextPath}/mypage/couponHistory/available?page=1" class="col p-2" style="text-align: center; background-color: #A0A0A0;">사용가능</a>
	                    	<a href="${contextPath}/mypage/couponHistory/unavailable?page=1" class="col p-2" style="text-align: center">사용완료 & 기간만료</a>
                		</c:when>
                		<c:otherwise>
                			<a href="${contextPath}/mypage/couponHistory/available?page=1" class="col p-2" style="text-align: center">사용가능</a>
	                    	<a href="${contextPath}/mypage/couponHistory/unavailable?page=1" class="col p-2" style="text-align: center; background-color: #A0A0A0;">사용완료 & 기간만료</a>
                		</c:otherwise>
                	</c:choose>
                </div>
                <c:choose>
                	<c:when test="${type eq 'available'}">
	                	<!-- 사용가능 쿠폰 -->
		                <table class="table mb-3" style="margin: auto; text-align: center; vertical-align: middle;">
		                    <thead class="table-secondary">
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
		                    <thead class="table-secondary">
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
                				<li class="page-item">
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
    <%@ include file="../footer.jsp" %>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/dist/jquery.js' />"></script>
<script type="text/javascript">

</script>
</html>