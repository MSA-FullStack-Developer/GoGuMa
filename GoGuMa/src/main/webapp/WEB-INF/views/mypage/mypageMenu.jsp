<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<style>
	a:hover {
		color: #FF493C;
	}
</style>
<div class="col-3">
    <div class="col mb-4">
        <h3><a href="${contextPath}/mypage?page=1"><b>마이페이지</b></a></h3>
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
            <a href="${contextPath}/mypage/pointHistory/all?page=1">포인트</a>
        </div>
        <div>
            <a href="${contextPath}/mypage/couponHistory/available?page=1">쿠폰</a>
        </div>
    </div>
    <div class="col mb-4">
        <h5><b>MY 활동</b></h5>
        <div>
            <a href="${contextPath}/mypage/myReview">내가 작성한 상품평</a>
        </div>
        <div>
            <a href="${contextPath}/mypage/writeableReview">작성 가능한 상품평</a>
        </div>
    </div>
    <div class="col">
        <h5><b>MY 정보</b></h5>
        <div>
            <a href="${contextPath}/mypage/confirmPassword/changeInfo">회원정보변경</a>
        </div>
        <div>
            <a href="${contextPath}/mypage/confirmPassword/changePassword">비밀번호변경</a>
        </div>
	    <div>
	 		<a href="${contextPath}/mypage/manageAddress">배송지관리</a>
	    </div>
        <div>
            <a href="${contextPath}/mypage/resignMember">회원탈퇴</a>
        </div>
    </div>
</div>