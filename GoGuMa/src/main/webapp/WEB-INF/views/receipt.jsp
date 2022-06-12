<%@ page session="false" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>고구마 - 고객과 구성하는 마켓</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
	crossorigin="anonymous"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<link rel="stylesheet"
	href="${contextPath}/resources/css/cart/cartOrder.css">

<link rel="stylesheet"
	href="${contextPath}/webjars/jquery-ui/1.13.0/jquery-ui.css">
<script type="text/javascript"
	src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.js"></script>
<script type="text/javascript"
	src="${contextPath}/webjars/jquery-ui/1.13.0/jquery-ui.js"></script>
<script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
 	  var token = $("meta[name='_csrf']").attr("content");
	  var header = $("meta[name='_csrf_header']").attr("content");
	  console.log("${resp.payMethod}");
	});

	 //  unix time stamp to Date
	  function UnixTimeToDate(UnixTime){
	  var origin = new Date(UnixTime);
	  
	  var year = origin.getFullYear();
	  var month = ('0' + (origin.getMonth() + 1)).slice(-2);
	  var day = ('0' + origin.getDate()).slice(-2);
	  
	  var hours = ('0' + origin.getHours()).slice(-2); 
	  var minutes = ('0' + origin.getMinutes()).slice(-2);
	  var seconds = ('0' + origin.getSeconds()).slice(-2);
	   
	  var val_time = year+"-"+month+"-"+day + " " + hours + ":"+minutes + ":" + seconds;
	  
	  return val_time;
	  }
	 
	function numFormatComma(nNumber, nDetail) {
		if (nNumber == null)
			return "";
		if (nDetail == null)
			nDetail = 0;

		nNumber = parseFloat(nNumber);
		nNumber = Math.round(nNumber, nDetail);

		var minusFlag = false;
		if (nNumber < 0) {
			nNumber = nNumber * -1;
			minusFlag = true;
		}

		var strNumber = new String(nNumber);
		var arrNumber = strNumber.split(".");
		var strFormatNum = "";
		var j = 0;

		for (var i = arrNumber[0].length - 1; i >= 0; i--) {
			if (i != strNumber.length && j == 3) {
				strFormatNum = arrNumber[0].charAt(i) + "," + strFormatNum;
				j = 0;
			} else {
				strFormatNum = arrNumber[0].charAt(i) + strFormatNum;
			}
			j++;
		}

		if (arrNumber.length > 1)
			strFormatNum = strFormatNum + "." + arrNumber[1];

		if (minusFlag)
			strFormatNum = '-' + strFormatNum;

		return strFormatNum;
	};
	
</script>

<style>
	<%@ include file="/resources/css/header.css" %>
</style>

<%@ include file="header.jsp" %>
<div class="container mt-5" style="min-width: 1200px">
	<!-- 바디 전체-->
	<div class="cbody">
		<div class="contents">
			<div class="csection">
					<div class="cart-area">
						<div class="cart-head">
							<div class="cart-top">
								<div class="cart-all">
									<strong>주문 완료</strong>
								</div>
								<ol class="cart-list-num">
									<li><strong>01</strong> <span>장바구니</span></li>
									<li><strong>02</strong> <span>주문서작성</span></li>
									<li class="active"><strong>03</strong> <span>주문완료</span></li>
								</ol>
							</div>
						</div>
					<div class="all-fin">
						<div class="all-fin-ment">
							<div class="lotti-cart">
								<lottie-player src="https://assets9.lottiefiles.com/packages/lf20_47pyyfcf.json"  background="transparent"  speed="1"  style="width: 300px; height: 300px;"  loop  autoplay></lottie-player>
							</div>
							<div class="fin-txt-div">
								<strong class="fin-txt">주문이 성공적으로 <em id="finTT">완료</em>되었습니다.</strong>
							</div>
							<p>고구마몰을 이용해주셔서 감사합니다.</p>
							<p>주문하신 내역은 마이페이지 > 나의 쇼핑내역 > 주문/배송조회에서 확인하실 수 있습니다.</p>
							<strong>주문번호: </strong>${uid}
						</div>
					</div>
					
					<strong class="fin-ord-title">구매자 정보</strong>
					<div class="payman-info">
						<div class="row">
							<div class="col-md-4">구매자 이름</div>
							<div class="col-md-8" id="bname">${resp.buyerName}</div>
						</div>
						<div class="row">
							<div class="col-md-4">구매자 이메일</div>
							<div class="col-md-8" id="bemail">${resp.buyerEmail}</div>
						</div>
						<div class="row">
							<div class="col-md-4">구매자 주소</div>
							<div class="col-md-8" id="baddress">${resp.buyerAddr}</div>
						</div>
						<div class="row">
							<div class="col-md-4">구매자 연락처</div>
							<div class="col-md-8" id="bphone">${resp.buyerTel}</div>
						</div>
					</div>	
					
					<strong class="fin-ord-title">결제 내역</strong>
					<div class="pay-info">
						<div class="row">
							<div class="col-md-4">결제 금액</div>
							<div class="col-md-8">
								<span id="pamount">
									<strong><fmt:formatNumber value="${resp.amount}" type="currency" currencySymbol="" />원</strong>
								</span>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">결제 상품명</div>
							<div class="col-md-8" id="pname">${resp.name}</div>
						</div>
						<div class="row">
							<div class="col-md-4">결제 방법</div>
							<!-- vbank인 경우 -->
							<c:if test="${resp.payMethod =='vbank'}">
								<div class="col-md-8" id="ptype">무통장 입금</div>
							</c:if>
							<!-- /vbank인 경우 -->
							<!-- 카카오페이인 경우 -->
							<c:if test="${resp.payMethod =='kakopay'}">
								<div class="col-md-8" id="ptype">카카오페이</div>
							</c:if>
							<!-- /카카오페이인 경우 -->
							<!-- 카드인 경우 -->
							<c:if test="${resp.payMethod =='card'}">
								<div class="col-md-8" id="ptype">카드결제</div>
							</c:if>
							<!-- /카드인 경우 -->
						</div>
						<!-- 무통장 입금인 경우 -->
						<c:if test="${resp.payMethod =='vbank'}">
							<div class="row">
								<div class="col-md-4">수취인</div>
								<div class="col-md-8" id="vbankholder">${resp.vbankHolder}</div>
							</div>
							<div class="row">
								<div class="col-md-4">은행이름</div>
								<div class="col-md-8" id="vbankname">${resp.vbankName}</div>
							</div>
							<div class="row">
								<div class="col-md-4">은행계좌</div>
								<div class="col-md-8" id="vbanknum">${resp.vbankNum} <em id="duedate">(<fmt:formatDate value="${resp.vbankDate}" pattern="yyyy-MM-dd hh:mm"/>분 까지)</em></div>
							</div>
						</c:if>
						<!-- /무통장 입금인 경우 -->
						<div class="row">
							<div class="col-md-4">결제상태</div>
							<!-- 결제 상태 입금 대기 중 -->
							<c:if test="${resp.status =='ready'}">
								<div class="col-md-8" id="vbankstatus">결제 진행중</div>
							</c:if>
							<!-- /결제 상태 입금 대기 중 -->
							<!-- 결제 상태 완료 -->
							<c:if test="${resp.status =='paid'}">
								<div class="col-md-8" id="vbankstatus">결제 완료</div>
							</c:if>
							<!-- /결제 상태 완료 -->
						</div>
					</div>		
					<div class="order-buttons">
						<button type="button" id="orderBtn" class="btn text-white btn-default purchase" onclick="location.href='${contextPath}/mypage/orderHistory'">나의 쇼핑 내역</button>
						<button type="button" id="receipt_url" class="btn text-black print-receipt" onclick="window.open('${resp.receiptUrl}', 'window_name', 'width=430, height=500, location=no, status=no, scrollbars=yes');">주문내역 인쇄</button>
						<button type="button" class="btn text-white btn-default continue" onclick="location.href='${contextPath}'">쇼핑 계속하기</button>
					</div>
			</div>
		</div>
	</div>
</div>
</div>

<%@ include file="./footer.jsp" %>