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
							<span> ㅇㅇ </span>고객님의 혜택 정보 회원등급: <span> 실버 </span> 적립금: <span>
								100000 </span>
						</div>
					</div>

					<div class="accordion accordion-flush">
						<div class="accordion-item">
							<h3 class="accordion-header order-selected" id="flush-headingOne">
								<button class="accordion-button" type="button"
									data-bs-toggle="collapse" data-bs-target="#flush-collapseOne"
									aria-expanded="false" aria-controls="flush-collapseOne">
									상품정보</button>
							</h3>
							<div id="flush-collapseOne"
								class="accordion-collapse collapse show"
								aria-labelledby="flush-headingOne">
								<div class="accordion-body">
									<ul>
										<li name="orderItem">
											아아
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>

				</div>
				<div class="all-cart-total-price">
					<div class="all-price-area">
						총 상품가격 <em class="final-product-price" id="emPriceFTotNrmlprice">0</em>원
						<i class="bi bi-dash-square"></i> 총 할인가격 <em
							class="final-product-discount" id="emPriceFTotDcAmt">0</em>원 <i
							class="bi bi-arrow-right-square"></i> 총 주문금액 <em
							class="final-order-price" id="emPriceFTotPayAmt">0</em>원
					</div>
				</div>
				<div class="order-buttons">
					<button type="button" class="btn text-black continue"
						style="background-color: #FFFFFF;">쇼핑 계속하기</button>
					<button type="button" class="btn text-white purchase"
						style="background-color: #FF493C">구매하기</button>
				</div>
			</div>

		</div>
	</div>

</div>