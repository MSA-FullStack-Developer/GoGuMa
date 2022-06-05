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
    <!-- bootstrap datepicker -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.standalone.min.css">
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
                    <h5><b>포인트 내역 조회</b></h5>
                </div>
                <div class="d-flex flex-row align-items-center border border-2 p-3 mb-2">
                    <b>조회기간 설정</b>
                	<form id="inquirePeriodForm" method="GET" action="${contextPath}/mypage/pointHistory/${type}">
	                    <input type="text" name="startDate" class="ms-2 me-1" /> ~ <input type="text" name="endDate" class="ms-1" />
	                    <button type="button" class="btn btn-sm btn-secondary ms-2" onclick="inquireHistory()">조회</button>
	                    <input type="hidden" name="page" value="1" />
                	</form>
                </div>
                
                <div class="d-flex flex-row mb-2">
                    <div class="d-flex flex-column me-2">
                        <a href="${contextPath}/mypage/pointHistory/all?page=1"><b>전체내역</b></a>
                    </div>
                    <div class="d-flex flex-column me-2">
                        |
                    </div>
                    <div class="d-flex flex-column me-2">
                        <a href="${contextPath}/mypage/pointHistory/earn?page=1"><b>적립내역</b></a>
                    </div>
                    <div class="d-flex flex-column me-2">
                        |
                    </div>
                    <div class="d-flex flex-column me-2">
                        <a href="${contextPath}/mypage/pointHistory/usage?page=1"><b>사용내역</b></a>
                    </div>
                    <div class="d-flex flex-column me-2">
                        |
                    </div>
                    <div class="d-flex flex-column me-2">
                        <a href="${contextPath}/mypage/pointHistory/refund?page=1"><b>환급내역</b></a>
                    </div>
                </div>
                <table class="table mb-3" style="margin: auto; text-align: center">
                    <thead class="table-secondary table-group-divider">
                        <tr>
                            <th>생성일자</th>
                            <th>주문번호</th>
                            <th>내용</th>
                            <th>포인트</th>
                            <th>유형</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <c:forEach var="pointDTO" items="${pointHistory}">
	                    	<tr>
	                    		<td>
	                    			<fmt:formatDate pattern="yyyy-MM-dd" value="${pointDTO.pointCreatedDate}" />
                    			</td>
	                    		<td>
	                    			<a href="${contextPath}/mypage/orderHistory/${pointDTO.receiptId}">${pointDTO.receiptId}</a>
                    			</td>
	                    		<td>
	                    			<c:choose>
	                    				<c:when test="${pointDTO.pointType eq 'earn'}">
	                    					상품 구매확정
	                    				</c:when>
	                    				<c:when test="${pointDTO.pointType eq 'usage'}">
	                    					상품 주문
	                    				</c:when>
	                    				<c:otherwise>
	                    					주문 취소
	                    				</c:otherwise>
	                    			</c:choose>
                    			</td>
	                    		<td>
	                    			<c:choose>
	                    				<c:when test="${pointDTO.pointType eq 'earn'}">
	                    					+${pointDTO.pointValue}P
	                    				</c:when>
	                    				<c:when test="${pointDTO.pointType eq 'usage'}">
	                    					-${pointDTO.pointValue}P
	                    				</c:when>
	                    				<c:otherwise>
	                    					+${pointDTO.pointValue}P
	                    				</c:otherwise>
	                    			</c:choose>
	                    		</td>
	                    		<td>
	                    			<c:choose>
	                    				<c:when test="${pointDTO.pointType eq 'earn'}">
	                    					포인트 적립
	                    				</c:when>
	                    				<c:when test="${pointDTO.pointType eq 'usage'}">
	                    					포인트 사용
	                    				</c:when>
	                    				<c:otherwise>
	                    					포인트 환급
	                    				</c:otherwise>
	                    			</c:choose>
	                    		</td>
	                    	</tr>
	                    </c:forEach>
	                </tbody>
                </table>
                <ul class="pagination justify-content-center">
                	<c:if test="${startPage ne 1}">
                		<li class="page-item">
	                		<c:choose>
	                			<c:when test="${startDate eq null || endDate eq null}">
	                				<a class="page-link" href="${contextPath}/mypage/pointHistory/${type}?page=${startPage-1}" aria-label="Previous">
			                			<span aria-hidden="true">&laquo;</span>
			                		</a>
	                			</c:when>
	                			<c:otherwise>
	                				<a class="page-link" href="${contextPath}/mypage/pointHistory/${type}?startDate=${startDate}&endDate=${endDate}&page=${startPage-1}" aria-label="Previous">
			                			<span aria-hidden="true">&laquo;</span>
			                		</a>
	                			</c:otherwise>
							</c:choose>
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
                					<c:choose>
                						<c:when test="${startDate eq null || endDate eq null}">
                							<a class="page-link" href="${contextPath}/mypage/pointHistory/${type}?page=${pageNum}">
		                						${pageNum}
		                					</a>
                						</c:when>
                						<c:otherwise>
	                						<a class="page-link" href="${contextPath}/mypage/pointHistory/${type}?startDate=${startDate}&endDate=${endDate}&page=${pageNum}">
		                						${pageNum}
		                					</a>
                						</c:otherwise>
                					</c:choose>
                				</li>
                			</c:otherwise>
                		</c:choose>
                	</c:forEach>
                	<c:if test="${endPage ne pageCount}">
                		<li class="page-item">
	                		<c:choose>
	                			<c:when test="${startDate eq null || endDate eq null}">
	                				<a class="page-link" href="${contextPath}/mypage/pointHistory/${type}?page=${endPage+1}" aria-label="Next">
							    		<span aria-hidden="true">&raquo;</span>
							    	</a>
	                			</c:when>
	                			<c:otherwise>
	                				<a class="page-link" href="${contextPath}/mypage/pointHistory/${type}?startDate=${startDate}&endDate=${endDate}&page=${endPage+1}" aria-label="Next">
							    		<span aria-hidden="true">&raquo;</span>
							    	</a>
	                			</c:otherwise>
	                		</c:choose>
					    </li>
                	</c:if>
				</ul>
            </div>
        </div>
    </div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/dist/jquery.js' />"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.kr.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('input[name=startDate]').datepicker({
			format: 'yyyy-mm-dd',
			language: 'kr',
			autoclose: true,
			todayHighlight: true
		}).on('changeDate', function(selected) {
			let startDate = new Date(selected.date.valueOf());
			$('input[name=endDate]').datepicker('setStartDate', startDate);
		}).on('clearDate', function(selected) {
			$('input[name=endDate]').datepicker('setStartDate', null);
		});
		$('input[name=endDate]').datepicker({
			format: 'yyyy-mm-dd',
			language: 'kr',
			autoclose: true,
			todayHighlight: true
		}).on('changeDate', function(selected) {
			let endDate = new Date(selected.date.valueOf());
			$('input[name=startDate]').datepicker('setEndDate', endDate);
		}).on('clearDate', function(selected) {
			$('input[name=startDate]').datepicker('setEndDate', null);
		});
	});
	
    function inquireHistory() {
    	if($('input[name=startDate]').val()=='' || $('input[name=endDate]').val()=='') {
    		alert('조회하려는 날짜를 선택해주세요.');
    	} else {
    		$('#inquirePeriodForm').submit();
    	}
    };
</script>
</html>