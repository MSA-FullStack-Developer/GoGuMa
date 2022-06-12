<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/dist/jquery.js' />"></script>
<script type="text/javascript">
	const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
	const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
</script>