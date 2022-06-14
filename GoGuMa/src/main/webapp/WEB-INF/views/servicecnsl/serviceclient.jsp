<%@ page session="false" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>고구마 - 고객과 구성하는 마켓</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<link rel="stylesheet" href="${contextPath}/resources/css/serviceclient.css">

<link rel="stylesheet" href="${contextPath}/webjars/jquery-ui/1.13.0/jquery-ui.css">
<script type="text/javascript" src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.js"></script>
<script type="text/javascript" src="${contextPath}/webjars/jquery-ui/1.13.0/jquery-ui.js"></script>

<%@ include file="../header.jsp"%>
<script>
  function openCnslPup() {
    if (`${memberDTO}`) {
      //로그인 한 경우
      window.open("oneCnslPup", "popup01", "width=800, height=700");
    } else {
      location.href = "${contextPath}/member/login.do";
    }
  }

  $(document).ready(function() {

  });
</script>
	<main class="cmain customer" role="main" id="mainContents">
		<div class="container">
	    	<!-- .side-menu-list -->
       		<div class="side-content">
	            <h2 class="side-menu-title" onclick='javascript:location.href="${contextPath}/serviceclient/"' style="cursor:pointer;">고객센터</h2>
	            <div class="side-menu-list">
	                   <ul>
	                       <li><a href="${contextPath}/serviceclient/faqList/1">자주 묻는 질문</a></li>
	                       <li><a href="#" onclick="openCnslPup(); return false;">1:1 문의하기</a></li>
	                       <li><a href="${contextPath}/serviceclient/myService/1">내 상담내역 조회</a></li>
	                       <li><a href="https://www.hmall.com/p/ccb/noticeList.do">공지사항</a></li>
	                   </ul>
	               </div>
	         </div>
		 	<div class="contents">
				<!--search : 자주 묻는 질문-->
				<div class="cus-wrap">
					<h3>자주 묻는 질문</h3>
					<div class="search-area">
						<form id="searchForm" action="${contextPath}/serviceclient/faqList/1" method="get">
							<div class="inputbox">
								<label class="inplabel icon-find"><input type="text" name="keyword" placeholder="질문을 검색해보세요" title="검색어 입력" value=""></label>
								<button type="submit" class="btn btn-find searchBtn" style="height: auto;"></button>
							</div>
						</form>
					</div>
				</div>
			<!--//search : 자주 묻는 질문-->
			<!--베스트 FAQ 10-->
			<div class="cus-wrap">
				<div class="tit-wrap">
					<h3>베스트 FAQ 5</h3>
				</div>
				<div class="accordion accordion-flush" id="accordionFlushFAQ">
					<div class="accordion-item">
						<h3 class="accordion-header order-products" id="flush-heading1">
							<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse1" aria-expanded="false" aria-controls="flush-collapse1">
								<i class="fa-solid fa-q"></i><strong>주문 내용 변경, 취소, AS 등은 어떻게 하나요?</strong>
							</button>
						</h3>
						<div id="flush-collapse1" class="accordion-collapse collapse" aria-labelledby="flush-heading1" data-bs-parent="#accordionFlushFAQ">
							<div class="accordion-body">
								<div class="txt-wrap">
									<p>
										<strong><span style="COLOR: #cc3d3d"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">▷&nbsp;색상/사이즈&nbsp;및 배송지 변경</span><br></span></strong><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">결제완료 단계일때 마이페이지에서 직접 수정하실 수 있습니다. </span><br></span><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">주문이 상품준비중 단계로 변경된&nbsp;이후에는 1:1 고객상담을 통해 변경 신청 하실 수 있습니다. </span><br>
										<br></span><strong><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">▷</span></strong><strong><span style="COLOR: #cc3d3d"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">&nbsp;주문 취소</span><br></span></strong><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">마이페이지 주문상세 내역에서 즉시 취소가 가능한 단계는 아래와 같습니다.&nbsp;</span><br></span><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">- 신용카드 주문 : 결제완료, 상품준비중 (주문제작/설치 등 일부 상품 제외)</span><br></span><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">- 현금, 상품권 주문 : 주문접수</span><br></span><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">즉시 취소가 가능한 주문은 위 단계일때 [주문취소] 버튼이
											표시되므로, 직접 취소 하실 수 있습니다. </span><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">단, 위에 해당되지 않는 단계로 넘어간 주문에 대해서는 1:1 고객상담을 통해 주문취소 신청하실 수 있습니다.&nbsp;</span></span><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535"><br></span><br></span><strong><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">▷</span></strong><strong><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">&nbsp;AS신청</span></strong><span style="COLOR: #cc3d3d"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d"> </span><br></span><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">AS는 마이페이지에서 직접 신청이 불가합니다. </span><span style="COLOR: #000000"><span
											style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535"
										>1:1상담신청 혹은 현대홈쇼핑 고객센터(1600-0000)로 전화 주시어 AS 문의를 남겨 주신다면 안내 도와 드리겠습니다.</span><br></span><br>
										<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">주문 진행상태에 따라 신청 가능한 항목은 다음과 같습니다.</span>
									</p>
								</div>
							</div>
						</div>
						<div class="accordion-item border-top">
							<h3 class="accordion-header order-products" id="flush-heading2">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse2" aria-expanded="false" aria-controls="#flush-collapse2">
									<i class="fa-solid fa-q"></i><strong>취소/반품 완료 후 환불 언제 되나요?</strong>
								</button>
							</h3>
							<div id="flush-collapse2" class="accordion-collapse collapse" aria-labelledby="flush-heading2" data-bs-parent="#accordionFlushFAQ">
								<div class="accordion-body">
									<p>
										<span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">취소 또는 반품에 대한 환불 처리는 취소, 반품 접수 후 24시간 이내 해드립니다. 환불 처리는 주문 결제 수단과 동일하게 함을 원칙으로 하며, 환불 받을 금액을 예치 해두고 다음에 사용하고자 한다면 고객센터를 통해 환불 금액의 예치금 전환을 신청해 주시기 바랍니다.</span><br></span><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">※ Hmall 상품의 반품에 대한 환불 처리는 상품 입고하여 검품 완료 후 환불처리 되므로 대략 4~7일 정도의 시간이 소요됩니다. </span><br></span><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">※ 주말 또는 휴일처럼 금융업무가 비정상적인 경우 그 다음 근무 일에 처리됩니다.</span><br>
										<br></span><span style="COLOR: #cc3d3d"><strong><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">▷ 신용카드<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535"></span></span><br></strong></span><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif">주문취소 시 카드매출 취소는 즉시 접수 되지만, 카드사 매입 취소까지 보통 3~7일 정도 소요될 수 있습니다. </span><br></span><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif">※ 매입 전 카드 주문은 당일 취소됩니다.</span><br></span><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #000000">※ 각 카드사마다 취소 처리 기간이 다르기 때문에 카드사를 통하여 확인하실 수 있습니다. </span><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif">만약에 대금이 결제되었다 하더라도 해당 금액만큼 해당 카드사에서 다음달 결제 대금에서 제외됩니다.</span><br>
										<br></span><span style="COLOR: #cc3d3d"><strong><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">▷ 체크카드</span><br></strong></span><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">당사 취소 청구 후 7일 이내 카드사에서 계좌로 입금됩니다.</span><br></span><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">※ 은행에 따라 소요일 달라질 수 있습니다.</span><br>
										<br></span><span style="COLOR: #cc3d3d"><strong><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">▷ 무통장입금/ 실시간계좌이체</span><br></strong></span><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">환불요청 후 익일 (영업일 기준<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535"></span>) 입력하신 계좌로 입금됩니다.
										</span><br></span><span style="COLOR: #cc3d3d"><strong><br>
											<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">▷ 휴대폰 결제</span><br></strong></span><span style="COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif">환불요청 후 3~5일 소요됩니다.</span><br>
										<br></span><span style="COLOR: #cc3d3d"><strong><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">▷ 상품권 결제</span><br></strong></span><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">환불 요청 후 익일 (영업일 기준) 예치금 환불로 처리됩니다.</span>
									</p>
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h3 class="accordion-header order-products" id="flush-heading3">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse3" aria-expanded="false" aria-controls="#flush-collapse3">
									<i class="fa-solid fa-q"></i><strong>환불은 어떻게 받나요?</strong>
								</button>
							</h3>
							<div id="flush-collapse3" class="accordion-collapse collapse" aria-labelledby="flush-heading3" data-bs-parent="#accordionFlushFAQ">
								<div class="accordion-body">
									<p>
										<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">취소 또는 반품에 대한 환불처리는 취소, 반품 접수 후 24시간 이내 해드립니다.&nbsp; </span><br>
										<br>
										<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">단, Hmall 상품의 반품에 대한 환불처리는 상품 입고하여 검품 완료 후 환불처리 되므로 대략 4~7일 정도의 시간이 소요됩니다. </span><br>
										<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">다만, 주말 또는 휴일처럼 금융업무가 비정상적인 경우 그 다음 근무일에 처리됩니다.</span><br>
										<br>
										<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">참고로, 환불처리는 주문결제 수단과 동일하게 함을 원칙으로 하며, 환불 받을 금액을 예치해두고 다음에 사용하고자 한다면 고객센터를 통해 환불금액의 예치금 전환을 신청해 주시기 바랍니다.</span>
									</p>
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h3 class="accordion-header order-products" id="flush-heading4">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse4" aria-expanded="false" aria-controls="#flush-collapse4">
									<i class="fa-solid fa-q"></i><strong>회원 탈퇴는 어떻게 하나요?</strong>
								</button>
							</h3>
							<div id="flush-collapse4" class="accordion-collapse collapse" aria-labelledby="flush-heading4" data-bs-parent="#accordionFlushFAQ">
								<div class="accordion-body">
									<p style="LINE-HEIGHT: 1.5">
										<span style="COLOR: #cc3d3d"><strong><span style="FONT-SIZE: 10pt; COLOR: #123456"><span style="COLOR: #cc3d3d"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">▷PC </span></span></span></strong></span><br>
										<span style="FONT-SIZE: 10pt; COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">화면 상단에 있는 [마이페이지 &gt;&nbsp;회원정보 &gt; 회원탈퇴]를 선택하시면 회원탈퇴를 하실 수 있습니다.</span><br>
										<br></span><strong><span style="FONT-SIZE: 10pt; COLOR: #123456"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">▷모바일</span><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">&nbsp;</span></span><br></strong><span style="FONT-SIZE: 10pt; COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">화면 하단에 있는 [마이페이지 &gt; 최하단 ‘㈜현대홈쇼핑’ &gt; 회원탈퇴]를 선택하시면 회원탈퇴를 하실 수 있습니다.</span><br>
										<br></span><span style="COLOR: #cc3d3d"><span><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">※ </span><strong><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">유의사항</span></strong><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d"> </span></span></span><br>
										<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">1. 배송 진행 중, 반품진행중인 주문 건이 &nbsp;있을 경우에는 탈퇴처리가 되지 않습니다.</span><br>
										<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">2. 재가입하셔도 개인정보가 복원되지 않습니다. </span><br>
										<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">3. Hmall에 가지고 계신 적립금, 예치금, 할인쿠폰 등의 혜택이 자동삭제 되며, 재가입하실 경우에도 복원되지 않습니다.</span><br>
										<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">4.&nbsp;재가입시, 기존에 사용하셨던 ID는 재가입 시 사용하실 수 없습니다. </span>
									</p>
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h3 class="accordion-header order-products" id="flush-heading5">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse5" aria-expanded="false" aria-controls="#flush-collapse5">
									<i class="fa-solid fa-q"></i><strong>고구마 마켓은 뭔가요?</strong>
								</button>
							</h3>
							<div id="flush-collapse5" class="accordion-collapse collapse" aria-labelledby="flush-heading5" data-bs-parent="#accordionFlushFAQ">
								<div class="accordion-body">
									<p style="LINE-HEIGHT: 1.5">
										<span style="COLOR: #cc3d3d"> <strong> <span style="FONT-SIZE: 10pt; COLOR: #123456"><span style="COLOR: #cc3d3d"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">▷고구마 마켓 </span></span></span></strong></span><br>
										<span style="FONT-SIZE: 10pt; COLOR: #000000"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">상품을 구매한 고객들이 구성한 자신만의 새로운 마켓입니다.</span></span><br><br>
										<span style="COLOR: #cc3d3d"> <strong> <span style="FONT-SIZE: 10pt; COLOR: #123456"><span style="COLOR: #cc3d3d"><span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #cc3d3d">▷고구마 마켓을 왜 사용하나요? </span></span></span></strong></span><br>
								
										<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">1. 단순히 구매만으로 만족하지 않고 내가 산 상품을 사람들과 공유함으로써 자신만의 마켓을 가꿔나가 보세요.</span><br>
										<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">2. 나만이 마켓을 꾸미고 사람들과 소통할 수 있어요. </span><br>
										<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">3. 일반 리뷰보다 더 자세한 반응을 확인하실 수 있어요.</span><br>
										<span style="FONT-SIZE: 10pt; FONT-FAMILY: Gulim, 굴림, AppleGothic, sans-serif; COLOR: #353535">4. 내가 보고 싶은 상품만 볼 수 있어요. </span>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--//베스트 FAQ 10-->

				<!--1:1문의하기 / 공지사항-->
				<div class="cus-wrap noti">

					<!--공지사항-->
					<div class="noti-wrap">
						<div class="tit-wrap">
							<h3>공지사항</h3>
							<p>
								<a href="https://www.hmall.com/p/ccb/noticeList.do">전체보기</a>
								<i class="fas fa-angle-right"></i>
							</p>
						</div>
						<!--tblwrap tbl-list-->
						<div class="tblwrap tbl-list">
							<table>
								<colgroup>
									<col style="width: 400px">
									<col style="width: 75px">
								</colgroup>
								<tbody>
									<tr>
										<td class="nowrap">
											<a href="https://www.hmall.com/p/ccb/noticeView.do?ancmId=53744&page=1&topFixYn=N">현대홈쇼핑 멤버십 제도 개편 안내</a>
										</td>
										<td class="txt-center">
											<span class="date">2022.05.02</span>
										</td>
									</tr>

									<tr>
										<td class="nowrap">
											<a href="https://www.hmall.com/p/ccb/noticeView.do?ancmId=53740&page=1&topFixYn=N">현대홈쇼핑 상시채용 안내</a>
										</td>
										<td class="txt-center">
											<span class="date">2022.04.15</span>
										</td>
									</tr>

									<tr>
										<td class="nowrap">
											<a href="https://www.hmall.com/p/ccb/noticeView.do?ancmId=53722&page=1&topFixYn=N">개인정보처리방침 변경 안내(01/27)</a>
										</td>
										<td class="txt-center">
											<span class="date">2022.01.27</span>
										</td>
									</tr>

									<tr>
										<td class="nowrap">
											<a href="https://www.hmall.com/p/ccb/noticeView.do?ancmId=53597&page=1&topFixYn=N">현대홈쇼핑 금융소비자보호 내부통제기준 및 금융소비자보호기준</a>
										</td>
										<td class="txt-center">
											<span class="date">2021.09.24</span>
										</td>
									</tr>

									<tr>
										<td class="nowrap">
											<a href="https://www.hmall.com/p/ccb/noticeView.do?ancmId=53596&page=1&topFixYn=N">현대홈쇼핑 보험대리점등록증</a>
										</td>
										<td class="txt-center">
											<span class="date">2021.09.24</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--//tblwrap tbl-list-->
					</div>
					<!--//공지사항-->
					
					<!--1:1 문의하기-->
					<div class="question-wrap" onclick="openCnslPup(); return false;">
						<div class="q-cont">
							<strong>1:1 문의하기 </strong><i class="fas fa-angle-right"></i>
							<div id="cont-txt">쇼핑을 하다가 생긴 궁금증 언제든지 물어보세요.</div>
						</div>
					</div>
					<!--//1:1 문의하기-->
					<!-- 내 상담내역 조회-->
					<div class="question-wrap" onclick="location.href='${contextPath}/serviceclient/myService/1'">
						<div class="sel-cont">
							<strong>내 상담내역 조회 </strong><i class="fas fa-angle-right"></i>
							<div id="cont-txt">문의사항에 대한 답변을 확인하실 수 있습니다.</div>
						</div>
					</div>
					<!--//내 상담내역 조회-->
				</div>
				<!--//1:1문의하기 / 공지사항-->
			</div>
			<!-- // .contents -->
		</div>
	</div>
		<!-- //.container -->
</main>
<!-- CLOUDTURING -->
<script>
  window.dyc = {
    chatbotUid : "e38640306adb39e9"
  };
</script>
<script async src="https://cloudturing.chat/v1.0/chat.js"></script>
<!-- End CLOUDTURING -->

<%@ include file="../footer.jsp"%>

