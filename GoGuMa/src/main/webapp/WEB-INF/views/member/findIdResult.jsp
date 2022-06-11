<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고구마 - 고객과 구성하는 마켓</title>
<!-- bootstrap css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous">

<!-- bootstrap js -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
	crossorigin="anonymous"></script>

<!-- bootstrap icon -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
</head>
<body>
	
	<section class="container">
        <div class="d-flex align-items-center min-vh-100">
            <div class="w-50 m-auto p-5" style="min-width: 650px;">
                <h1>아이디 찾기</h1>
                <h4 class="mt-5">아이디 찾기 결과</h4>
                <p class="text-secondary">아래 회원 정보를 확인해주세요.</p>
                <div id="memberInfo" class="w-100 p-4 border border-dark rounded-4 mt-3" style="min-height: 100px;">
                	<c:if test="${not notFound}">
                		<c:if test="${not disabled}">
	                    	<h4 class="border-bottom pb-3">고구마 회원</h4>
	                    </c:if>
	                    <c:if test="${disabled}">
	                    	<h4 class="border-bottom pb-3">탈퇴 진행중인 계정</h4>
	                    </c:if>
	                    <div id="member-name" class="row mt-4">
	                        <div class="col-2">
	                            <span class="text-secondary">이름</span>
	                        </div>
	                        <div class="col">
	                            <span>${name}</span>
	                        </div>
	                    </div>
	                    <div id="member-email" class="row mt-3">
	                        <div class="col-2">
	                            <span class="text-secondary">아이디</span>
	                        </div>
	                        <div class="col">
	                            <span>${email}</span>
	                        </div>
	                    </div>
	                    <div id="member-regdate" class="row mt-3">
	                        <div class="col-2">
	                            <span class="text-secondary">가입일</span>
	                        </div>
	                        <div class="col">
	                            <span>
	                            	<fmt:formatDate value="${joinDate}" pattern="yyyy.MM.dd"/>
	                            </span>
	                        </div>
	                    </div>
	                    <c:if test="${disabled}">
		                    <div id="member-reSignDate" class="row mt-3">
		                        <div class="col-2">
		                            <span class="text-secondary">탈퇴일</span>
		                        </div>
		                        <div class="col">
		                            <span>
		                            	<fmt:formatDate value="${resignDate}" pattern="yyyy.MM.dd"/>
		                            </span>
		                        </div>
		                    </div>
	                    </c:if>
                    </c:if>
                    <c:if test="${notFound}">
                    	<div class="w-100 d-flex flex-column align-items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" fill="currentColor" class="bi bi-person-x-fill" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm6.146-2.854a.5.5 0 0 1 .708 0L14 6.293l1.146-1.147a.5.5 0 0 1 .708.708L14.707 7l1.147 1.146a.5.5 0 0 1-.708.708L14 7.707l-1.146 1.147a.5.5 0 0 1-.708-.708L13.293 7l-1.147-1.146a.5.5 0 0 1 0-.708z"/>
                          </svg>
                          <h4 class="mt-4">존재하지 않는 회원입니다.</h4>
                    </div>
                    </c:if>
                </div>
                <div class="d-flex justify-content-between mt-5">
                	<c:if test="${not notFound}">
                    	<a role="button" class="btn btn-outline-dark btn-lg" style="width: 45%;"  href="${contextPath}/member/findPwd/start.do">비밀번호 찾기</a>
                    	<a role="button" class="btn btn-lg" style="width: 45%; background-color: #6426DD; color: white;" href="${contextPath}/member/login.do">로그인하기</a>
                	</c:if>
                	<c:if test="${notFound}">
                		<a role="button" class="btn btn-outline-dark btn-lg"  href="${contextPath}/member/login.do">로그인 화면으로</a>
                    	<a role="button" class="btn btn-lg" style="background-color: #6426DD; color: white;" href="${contextPath}/member/join/start.do">회원가입</a>
					</c:if>                
                </div>
               
            </div>
        </div>
    </section>
</body>
</html>