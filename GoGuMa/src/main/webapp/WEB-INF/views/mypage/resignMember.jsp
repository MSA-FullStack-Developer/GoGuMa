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
                            <a href="${contextPath}/mypage/pointHistory/all?page=1">
                            	<fmt:formatNumber value="${memberPoint}"/>P
                            </a>
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
                    <h5><b>회원탈퇴 안내</b></h5>
                </div>
                <div class="border border-2 rounded p-3 mb-3">
                    <div>
                        고객님의 거래내역은 전자상거래 등에서의 소비자보호에 관한 법률 제 6조 및 동법 시행령 제 6조에 의거, 
                    </div>
                    <div>
                        ① 표시 및 광고에 관한 기록은 6월
                    </div>
                    <div>
                        ② 계약 또는 청약 철회 등에 관한 기록은 5년 
                    </div>
                    <div>
                        ③ 재화 공급 등의 공급에 관한 기록은 5년
                    </div>
                    <div>
                        ④ 소비자 불만 또는 분쟁처리에 관한 기록은 3년간 기록됩니다. 
                    </div>
                </div>
                <div>
                    <h5><b>회원탈퇴 사유</b></h5>
                </div>
                <form action="${contextPath}/mypage/resignMember" method="POST">
	                <table class="table">
	                    <tbody class="table-group-divider">
	                        <tr>
	                            <th class="col-2 table-active align-middle" style="text-align: center">탈퇴 사유</th>
	                            <td class="p-3"><textarea class="d-flex lh-sm" name="resignDetail" style="width: 100%; height: 150px; resize: none;"></textarea></td>
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
	                            <td><input type="password" class="ms-2" name="userPassword" maxlength="16" style="width:200px; height:25px"/></td>
	                        </tr>
	                    </tbody>
	                </table>
	                <div align="center">
	                    <button type="submit" class="btn btn-dark">회원탈퇴</button>
	                    <button type="button" class="btn btn-secondary">돌아가기</button>
	                </div>
	                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                </form>
            </div>
        </div>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/dist/jquery.js' />"></script>
</html>