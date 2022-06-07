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
                    <h4><b>${memberDTO.name}님</b></h4>
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
                            <a href="${contextPath}/mypage/pointHistory/all?page=1">포인트</a>
                        </div>
                        <div>
                            <a href="${contextPath}/mypage/pointHistory/all?page=1">1,000P</a>
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
                            <a href="${contextPath}/mypage/couponHistory/available?page=1">3장</a>
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
                    <h5><b>회원정보변경</b></h5>
                </div>
                <table class="table">
                    <tbody class="table-group-divider">
                        <tr>
                            <th class="col-2">아이디(이메일)</th>
                            <td>${memberDTO.email}</td>
                        </tr>
                        <tr>
                            <th class="col-2">이름</th>
                            <td>${memberDTO.name}</td>
                        </tr>
                        <tr>
                            <th class="col-2">성별</th>
                            <td>
                            	<c:if test="${memberDTO.gender eq 'M'}">
                           			<label><input type="radio" name="gender" value="male" checked>&nbsp;남</label>
                                	&nbsp;
                                	<label><input type="radio" name="gender" value="female">&nbsp;여</label>
                            	</c:if>
                            	<c:if test="${memberDTO.gender eq 'F'}">
                            		<label><input type="radio" name="gender" value="male">&nbsp;남</label>
                                	&nbsp;
                                	<label><input type="radio" name="gender" value="female">&nbsp;여</label>
                            	</c:if>
                            </td>
                        </tr>
                        <tr>
                            <th class="col-2">생년월일</th>
                            <td>
                                <select id="years">
                                	<c:forEach var="year" begin="1960" end="2030">
                                		<c:choose>
                                			<c:when test="${birthYear eq year}">
                                				<option value="${birthYear}" selected>${birthYear}</option>
                                			</c:when>
                                			<c:otherwise>
                                				<option value="${year}">${year}</option>
                                			</c:otherwise>
                                		</c:choose>
                                	</c:forEach>
                                </select>
                                <select id="months">
                                	<c:forEach var="month" begin="1" end="12">
                                		<c:choose>
                                			<c:when test="${birthMonth eq month}">
                                				<option value="${birthMonth}" selected>${birthMonth}</option>
                                			</c:when>
                                			<c:otherwise>
                                				<c:choose>
                                					<c:when test="${month < 10}">
                                						<option value="0${month}">0${month}</option>
                                					</c:when>
                                					<c:otherwise>
                                						<option value="${month}">${month}</option>
                                					</c:otherwise>
                                				</c:choose>
                                			</c:otherwise>
                                		</c:choose>
                                	</c:forEach>
                                </select>
                                <select id="days">
                                	<c:forEach var="day" begin="1" end="31">
                                		<c:choose>
                                			<c:when test="${birthDay eq day}">
                                				<option value="${birthDay}" selected>${birthDay}</option>
                                			</c:when>
                                			<c:otherwise>
                                				<c:choose>
                                					<c:when test="${day < 10}">
                                						<option value="0${day}">0${day}</option>
                                					</c:when>
                                					<c:otherwise>
                                						<option value="${day}">${day}</option>
                                					</c:otherwise>
                                				</c:choose>
                                			</c:otherwise>
                                		</c:choose>
                                	</c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th class="col-2">휴대폰 번호</th>
                            <td>${phoneNum}</td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <h5><b>비밀번호확인</b></h5>
                </div>
                <table class="table">
                    <tbody class="table-group-divider">
                        <tr>
                            <th class="col-2 table-active" style="text-align: center;">비밀번호확인</th>
                            <td><input type="password" class="ms-3" id="userPassword" maxlength="16" style="width:200px; height:25px"/></td>
                        </tr>
                    </tbody>
                </table>
                <div align="center">
                    <button type="button" class="btn btn-dark" onclick="changeInfo()">변경</button>
                    <button type="button" class="btn btn-secondary">취소</button>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/dist/jquery.js' />"></script>
<script type="text/javascript">
	function changeInfo() {
		
	}
</script>
</html>