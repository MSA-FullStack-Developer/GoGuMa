<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>고구마 - 고객과 구성하는 마켓</title>
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
	<style>
	<%@ include file="/resources/css/myreview.css" %>
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
                    <h5><b>최근 본 상품</b></h5>
                </div>
                <div>
                    <div class="row g-3 mb-3">
                    	<c:if test="${productList.size() < 1}">
                    		<div style="text-align: center; ">
	   							<img class="no-review-img" src="https://image.hmall.com/p/img/co/icon/ico-nodata-type12-1x.svg" />
	   							<h5 class="no_result" style="margin-top: 0px;">최근 본 상품이 없습니다.</h5>
   							</div>
                    	</c:if>
                    	<c:forEach var="productDTO" items="${productList}">
                    		<div class="col-3">
	                            <div class="border mb-1 p-3">
	                            	<a href="${contextPath}/category/1/${productDTO.categoryID}/detail/${productDTO.productID}">
	                                	<img src="${productDTO.prodimgurl}" style="width: 100%; height: 100%">
                                	</a>
	                            </div>
	                            <div class="text-truncate" align="center">
	                            	<a href="${contextPath}/category/1/${productDTO.categoryID}/detail/${productDTO.productID}">
	                            		${productDTO.productName}
	                            	</a>
	                            </div>
	                        </div>
                    	</c:forEach>
                    </div>
                </div>
                <ul class="pagination justify-content-center">
                	<c:if test="${startPage ne 1}">
                		<li class="page-item">
                			<a class="page-link" href="${contextPath}/mypage?page=${startPage-1}" aria-label="Previous">
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
                					<a class="page-link" href="${contextPath}/mypage?page=${pageNum}">
                						${pageNum}
                					</a>
                				</li>
                			</c:otherwise>
                		</c:choose>
                	</c:forEach>
                	<c:if test="${endPage ne pageCount}">
                		<li class="page-item">
                			<a class="page-link" href="${contextPath}/mypage?page=${endPage+1}" aria-label="Next">
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