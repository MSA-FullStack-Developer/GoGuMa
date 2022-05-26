<%@ page session="false" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
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

<script type="text/javascript">
	$(document).ready(function() {

	});

	//주문내역 계산(총 상품 금액, 총 할인 금액, 총 주문 금액)
	function calculateSellPrice() {

		var totalNormalPrice = 0 //총 상품 금액
		var totalDcPrice = 0 //총 할인 금액
		var totalPayPrice = 0 //총 주문 금액
		var selectedItemCount = 0;
		var checkedLength = $("input:checkbox[name=itemSelect]:checked").length;

		console.log("선택한 체크 수: " + checkedLength);
		$("input:checkbox[name=itemSelect]:checked").each(
				function(idx) {
					selectedItemCount += 1;
					//선택된 상품 계산
					var itemObj = $(this).parents("tr");
					var ordQty = Number($(itemObj).find("input[name='ordQty']")
							.val());
					if (!isNaN(ordQty)) {
						//총 상품금액 계산(정상금액)
						if (!isNaN(Number($(itemObj).find(
								"input[name='nrmOriPrc']").val()))) {
							totalNormalPrice += Number($(itemObj).find(
									"input[name='nrmOriPrc']").val())
									* ordQty;
						}
						//총 할인금액 계산
						if (!isNaN(Number($(itemObj).find(
								"input[name='disOriPrc']").val()))) {
							totalDcPrice += Number($(itemObj).find(
									"input[name='disOriPrc']").val())
									* ordQty;
						}
						//총 결제예상 금액
						if (!isNaN(Number($(itemObj).find(
								"input[name='totOriPrc']").val()))) {
							totalPayPrice += Number($(itemObj).find(
									"input[name='totOriPrc']").val())
									* ordQty;
						}
					}
				});
		console.log("총 상품 정상 금액: " + totalNormalPrice);
		$("#emPriceFTotNrmlprice").text(numFormatComma(totalNormalPrice));
		$("#emPriceFTotDcAmt").text(numFormatComma(totalDcPrice));
		$("#emPriceFTotPayAmt").text(numFormatComma(totalPayPrice));
		$("#emTotalItemCnt").text(numFormatComma(selectedItemCount));
	};

	// 변경된 상품 가격 할인금액, 합계 화면에서 보여주는 계산
	function calculateItemSellPrice(itemObj, obj) {
		var ordQty = Number($("input[name=ordQty]", $(itemObj)).val());
		//상품 정상 금액
		var nOP = Number($("input[name=nrmOriPrc]", $(itemObj)).val());
		//상품 할인 금액
		var dOP = Number($("input[name=disOriPrc]", $(itemObj)).val());
		//상품 할인된 금액
		var tOP = Number($("input[name=totOriPrc]", $(itemObj)).val());

		$(itemObj).find(".cart-product-price span").text(
				numFormatComma(nOP * ordQty));
		$(itemObj).find(".cart-product-discount em").text(
				numFormatComma(dOP * ordQty));
		$(itemObj).find(".cart-total-price span").text(
				numFormatComma(tOP * ordQty));
	};

	// 상품 선택 & 선택된 총상품가격 총할인가격, 총 주문 금액 계산
	function bindCartList() {
		if ($("input:checkbox[name=allItemSelect]")) {
			$("input:checkbox[name=allItemSelect]").click(
					function(e) {
						var isChecked = $(this).is(":checked");
						$("input:checkbox[name=itemSelect]").prop("checked",
								isChecked);
						//가격 재계산
						calculateSellPrice();
						//주문이 가능한 상태인지 체크

					});
		}
		if ($("input:checkbox[name=itemSelect]")) {
			$("input:checkbox[name=itemSelect]").click(
					function(e) {
						//상품 선택 해제 시 전체선택 체크박스 해제
						if (!$(this).is(":checked")
								&& $("input:checkbox[name=allItemSelect]").is(
										":checked")) {
							$("input:checkbox[name=allItemSelect]").prop(
									"checked", false);
						}
						//모든 상품이 체크 된 경우 전체 선택 체크박스 선택 (하나라도 체크가 안되어 있다면 false)
						var isAllCheck = true;
						$("input:checkbox[name=itemSelect]").each(function() {
							if (!$(this).is(":checked")) {
								isAllCheck = false;
								return;
							}
						});
						if (isAllCheck) {
							$("input:checkbox[name=allItemSelect]").prop(
									"checked", true);
						}
						//가격 재계산
						calculateSellPrice();
						//주문 가능한 상태인지 체크
					});
		}
	};

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
	}
</script>
<div class="container">
	<!-- 바디 전체-->
	<div class="cbody">
		<div class="contents">
			<div class="csection">
				<div class="util-option sticky">
					<div class="sticky-inner">
						<h4 class=st-title>총 결제 금액</h4>
						<ul class="payment-list">
							<li>
								<div id="orderAmt">
									<span class="tit">총 판매 금액</span> <span class="txt"><strong>151,730</strong>원</span>
								</div>
								<div id="copnDcAmtDiv">
									<span class="tit">쿠폰 할인</span> <span class="txt"><strong>-4,770</strong>원</span>
								</div>
								<div id="totDcAmtDiv">
									<span class="tit">할인 합계금액</span> <span class="txt"><strong>-4,770</strong>원</span>
								</div>
							</li>
							<li>
								<div class="total">
									<span class="tit">최종 결제금액</span> <span class="txt"
										id="lastStlAmtDd"><strong>146,960</strong>원</span>
								</div>
							</li>
							<li>
								<div id="calculateList_upoint" class="hpoint">
									<span class="tit">적립예정 H.Point</span> <span class="txt"><strong>0</strong>p</span>
								</div>
							</li>
						</ul>
						<div class="btngroup agreeCheck">
							<button type="button" class="btn btn-default medium">
								<span>결제</span>
							</button>
						</div>
					</div>
				</div>
				<div class="order-content">
					<div class="cart-head">
						<div class="cart-top">
							<div class="cart-all">
								<strong>주문서 작성</strong>
							</div>
							<ol class="cart-list-num">
								<li><strong>01</strong> <span>장바구니</span></li>
								<li class="active"><strong>02</strong> <span>주문서작성</span></li>
								<li><strong>03</strong> <span>주문완료</span></li>
							</ol>
						</div>
						<div class="cart-bottom">
							<span> ${memberDTO.name } </span>고객님의 혜택 정보 회원등급: <span> ${memberDTO.grade.name } </span> 적립금: <span>
								100000 </span>
						</div>
					</div>

					<div class="accordion accordion-flush">
						<div class="accordion-item">
							<h3 class="accordion-header order-products"
								id="panelsStayOpen-headingOne">
								<button class="accordion-button" type="button"
									data-bs-toggle="collapse"
									data-bs-target="#panelsStayOpen-collapseOne"
									aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
									주문 상품정보</button>
							</h3>
							<div id="panelsStayOpen-collapseOne"
								class="accordion-collapse collapse show"
								aria-labelledby="panelsStayOpen-headingOne">
								<div class="accordion-body">
									<table class="table table-bordered border-white" id="nrmProd">
										<thead>
											<tr class="head">
												<th scope="col" id="th-product-name">상품정보</th>
												<th scope="col" id="th-product-count">수량</th>
												<th scope="col" id="th-product-price">상품가격</th>
												<th scope="col" id="th-discount-price">할인금액</th>
												<th scope="col" id="th-total-price">합계</th>
											</tr>
											<c:forEach var="i" items="${list }" begin="0" step="1" varStatus="status">
											<tr class="order-product">
												<td class="order-product_box">
													<div class="product-image">
														<a href="이동할 링크" class="moveProduct"> 
														<img src="${i.prodImgUrl }" width="78" height="78" class="product-img" alt="">
														</a>
													</div>
													<div class="product-name">
														<a href="이동할 링크" class="moveProduct">${i.parentProductName }</a>
													</div>
													<div class="product-option">
														<span class="product-option-name"> 옵션:
															${i.productName } </span>
													</div>
												</td>
												<td class="cart-product-count">
													<div class="cart-count">
														<span class="c" readonly name="ordQty">${i.cartAmount }</span>
													</div>
												</td>
												<td class="cart-price">
													<div class="cart-product-price">
														<span>상품가격 ${dtoList[status.index].nrmOriPrc }</span>원
													</div>
												</td>
												<td class="cart-discount">
													<div class="cart-product-discount">
														<!-- 처음 불러올때 보이는 할인률, 할인 금액 -->
														<em>${dtoList[status.index].disOriPrc }</em>원
													</div>
												</td>
												<td class="cart-total">
													<div class="cart-total-price">
														<!-- 처음 불러올때 보이는 할인률, 할인 금액 -->
														<span>${dtoList[status.index].totOriPrc }</span>원
													</div>
												</td>
											</tr>
											</c:forEach>
										</thead>
									</table>
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h3 class="accordion-header discount-info"
								id="panelsStayOpen-headingTwo">
								<button class="accordion-button" type="button"
									data-bs-toggle="collapse"
									data-bs-target="#panelsStayOpen-collapseTwo"
									aria-expanded="true" aria-controls="panelsStayOpen-collapseTwo">
									할인 혜택 선택</button>
							</h3>
							<div id="panelsStayOpen-collapseTwo"
								class="accordion-collapse collapse show"
								aria-labelledby="panelsStayOpen-headingTwo">
								<div class="accordion-body">
									<table>
										<tr>
											<td class="cart-price">
												<div class="cart-product-price">아아아아아아</div>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h3 class="accordion-header member-info"
								id="panelsStayOpen-headingThree">
								<button class="accordion-button" type="button"
									data-bs-toggle="collapse"
									data-bs-target="#panelsStayOpen-collapseThree"
									aria-expanded="true"
									aria-controls="panelsStayOpen-collapseThree">주문고객 /
									배송지 정보 입력</button>
							</h3>
							<div id="panelsStayOpen-collapseThree"
								class="accordion-collapse collapse show"
								aria-labelledby="panelsStayOpen-headingThree">
								<div class="accordion-body">
									<table>
										<tr>
											<td class="cart-price">
												<div class="cart-product-price">아아아아아아</div>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h3 class="accordion-header pay-info" id="panelsStayOpen-headine">
								<button class="accordion-button" type="button"
									data-bs-toggle="collapse"
									data-bs-target="#panelsStayOpen-collapseFour"
									aria-expanded="true"
									aria-controls="panelsStayOpen-collapseFour">결제 정보 선택</button>
							</h3>
							<div id="panelsStayOpen-collapseFour"
								class="accordion-collapse collapse show"
								aria-labelledby="panelsStayOpen-headingFour">
								<div class="accordion-body">
									<table>
										<tr>
											<td class="cart-price">
												<div class="cart-product-price">아아아아아아</div>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>

				</div>




			</div>

		</div>
	</div>

</div>