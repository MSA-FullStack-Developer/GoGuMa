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
                <div class="d-flex flex-row justify-content-evenly border border-2 rounded p-3 mb-3">
                    <div class="d-flex flex-row align-items-center">
                        <div class="me-2">
                        	<a href="${contextPath}/mypage/membershipZone" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-custom-class="custom-tooltip" data-bs-offset="0,10" title="${memberDTO.grade.name}">
                        		<c:choose>
                        			<c:when test="${memberDTO.grade.name eq '실버'}">
                        				<img src="https://image.hmall.com/p/img/mp/icon/ico-rating-silver.png" style="width: 50px; height: 50px; object-fit: contain;">
                        			</c:when>
                        			<c:when test="${memberDTO.grade.name eq '골드'}">
                        				<img src="https://image.hmall.com/p/img/mp/icon/ico-rating-gold.png" style="width: 50px; height: 50px; object-fit: contain;">
                        			</c:when>
                        			<c:when test="${memberDTO.grade.name eq '플래티넘'}">
                        				<img src="https://image.hmall.com/p/img/mp/icon/ico-rating-platinum.png" style="width: 50px; height: 50px; object-fit: contain;">
                        			</c:when>
                        			<c:when test="${memberDTO.grade.name eq '다이아몬드'}">
                        				<img src="https://image.hmall.com/p/img/mp/icon/ico-rating-diamond.png" style="width: 50px; height: 50px; object-fit: contain;">
                        			</c:when>
                        		</c:choose>
                        	</a>
                        </div>
                        <div class="lh-sm" align="center">
                            <div>
                                <a href="${contextPath}/mypage/confirmPassword/changeInfo" style="font-size: 20px">
                                	<b>${memberDTO.name}님</b>
                                </a>
                            </div>
                            <a href="${contextPath}/mypage/membershipZone" class="btn btn-sm border" style="font-size: 10pt; padding:1px 8px 1px 8px">혜택보기</a>
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
		                    <c:if test="${couponList.size() < 1}">
                   			<tr>
		                		<td style="text-align: center;" colspan="3">
			   						<img class="no-review-img" src="https://image.hmall.com/p/img/co/icon/ico-nodata-type12-1x.svg" />
			   						<h5 class="no_result" style="margin-top: 0px;">조회 내역이 없습니다.</h5>
		   						</td>
		   					</tr>
                			</c:if>
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
			                    <c:if test="${couponList.size() < 1}">
		                   			<tr>
				                		<td style="text-align: center;" colspan="4">
					   						<img class="no-review-img" src="https://image.hmall.com/p/img/co/icon/ico-nodata-type12-1x.svg" />
					   						<h5 class="no_result" style="margin-top: 0px;">조회 내역이 없습니다.</h5>
				   						</td>
				   					</tr>
	                			</c:if>
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
    <%@ include file="../footer.jsp" %>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/dist/jquery.js' />"></script>
<script type="text/javascript">
	const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
	const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
</script>
</html>