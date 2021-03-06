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

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						bindCartList();
						calculateSellPrice();
						checkOrderable();

						// 카트 수량 증가 버튼을 클릭한 경우 실행되는 함수
						$("button[name='countUp']").click(function(e) {
											e.preventDefault();
											var type = $(this).attr('count_range');

											var token = $("meta[name='_csrf']").attr("content");
											var header = $("meta[name='_csrf_header']").attr("content");

											var itemObj = $(this).parents("tr");
											var cartId = Number(itemObj.find("input:hidden[id=cartId]").val());
											console.log("증가하려는 카트아이디:", cartId);
											var data1 = {
												"cartId" : cartId
											};
											console.log(data1);

											//현재 카트 수량 체크를 위한 변수
											var $count = $(this).parent().children('input.ccount');
											var count_val = parseInt($count.val());

											//현재 재고 변수
											var $stock = $(this).parent().children('input.prodStock');
											var stock_val = parseInt($stock.val());
											console.log("증가 버튼 누름 현재 수량"
													+ count_val + "현재 재고: "
													+ stock_val);

											//현재 수량이 재고보다 작다면 증가시킬 수 있다.
											if (count_val < stock_val) {
												$count.val(parseInt(count_val) + 1);
												count_val = parseInt($count.val());
											} else {
												alert("상품 재고가 부족합니다.");
												return;
											}
											var cartId = Number(itemObj
													.find(
															"input:checkbox[class=selectCheck]")
													.val());
											if (count_val >= 1 && count_val <= stock_val) {
												$.ajax({
															type : "POST",
															url : "${contextPath}/cart/api/addCartCount",
															data : data1,
															beforeSend : function(xhr) {
																xhr.setRequestHeader(header,token);
															},
															success : function(response) {
																console.log("onclick ajax카트수량증가");
																//현재 가격 계산
																calculateItemSellPrice(itemObj, this);
																calculateSellPrice();
															},
															error : function(xhr,status,error) {
																var errorResponse = JSON.parse(xhr.responseText);
															}
														});
											} else {
												alert("수량이 올바르지 않습니다.");
											}
										});
						// 카트 수량 감소 버튼을 클릭한 경우 실행되는 함수
						$("button[name='countDown']")
								.click(
										function() {
											var token = $("meta[name='_csrf']")
													.attr("content");
											var header = $(
													"meta[name='_csrf_header']")
													.attr("content");

											var itemObj = $(this).parents("tr");
											var cartId = Number(itemObj.find("input:hidden[id=cartId]").val());
											console.log("감소하려는 카트아이디:", cartId);
											var data1 = {
												"cartId" : cartId
											};
											console.log(data1);

											//현재 카트 수량 체크를 위한 변수
											var $count = $(this).parent()
													.children('input.ccount');
											var count_val = parseInt($count
													.val());

											//현재 재고 변수
											var $stock = $(this)
													.parent()
													.children('input.prodStock');
											var stock_val = parseInt($stock
													.val());
											console.log("감소 버튼 누름 현재 수량"
													+ count_val + "현재 재고: "
													+ stock_val);

											//현재 수량이 1보다 크다면 감소시킬 수 있다.
											if (count_val > 1) {
												$count
														.val(parseInt(count_val) - 1);
												count_val = parseInt($count
														.val());
											} else {
												alert("상품이 최소 1개 이상 존재해야합니다.");
												return;
											}
											if (count_val >= 1 && count_val <= stock_val) {
												$.ajax({
															type : "POST",
															url : "${contextPath}/cart/api/minusCartCount",
															data : data1,
															beforeSend : function(xhr) {
																xhr.setRequestHeader(header,token);
															},
															success : function(response) {
																console.log("onclick ajax카트수량감소");
																calculateItemSellPrice(itemObj,this);
																calculateSellPrice();
															},
															error : function(
																	xhr,
																	status,
																	error) {
																var errorResponse = JSON
																		.parse(xhr.responseText);
															}/* ,
																																																																																																																																																																																																																																						complete: function(xht, status){
																																																																																																																																																																																																																																							$(this).removeAttr("disabled");
																																																																																																																																																																																																																																						} */
														});
											} else {
												alert("수량이 올바르지 않습니다.");
											}
										});
					});
	
	/* POST 요청 */
	
	/*상품 삭제()*/
	function cartDel(obj) {
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		var itemObj = $(obj).parents("tr");
		var cartId = Number(itemObj.find("input:hidden[id=cartId]").val());

		var data = {
			"cartId" : cartId
		};
		$.ajax({
			type : "POST",
			url : "${contextPath}/cart/api/delete",
			data : data,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(result) {
				location.reload();
			},
			error : function(xhr, status, error) {
				var errorResponse = JSON.parse(xhr.responseText);
				var errorCode = errorResponse.code;
				var message = errorResponse.message;

				alert(message);
			}
		});
	}

	// 선택한 장바구니를 삭제하기 위한 함수 (다중)
	function selectedCartDel() {
		var cartIds = $("#nrmProd").find(
				"input:checkbox[class=selectCheck]:checked");
		console.log(cartIds);
		if (cartIds.length == 0) {
			alert("선택된 장바구니가 없습니다.");
			return;
		}
		var deleted = confirm("선택한 장바구니를 모두 삭제하겠습니까?");

		if (deleted) {
			cartIds.each(function() {
				var cartId = $(this).val();
				console.log(cartId);
				//단일 장바구니 삭제 함수 호출
				cartDel(this);
			});
			alert("장바구니를 삭제했습니다.");
		}
	}
	// 단일 장바구니 삭제를 위한 함수
	function oneCartDel(obj) {
		var deleted = confirm("장바구니를 삭제하겠습니까?");

		if (deleted) {
			//단일 장바구니 삭제 함수 호출
			cartDel(obj);
			alert("장바구니를 삭제했습니다.");
		}
	}
	// 주문내역 계산(총 상품 금액, 총 할인 금액, 총 주문 금액)
	function calculateSellPrice() {

		var totalNormalPrice = 0 //총 상품 금액
		var totalDcPrice = 0 //총 할인 금액
		var totalPayPrice = 0 //총 주문 금액
		var selectedItemCount = 0;
		var checkedLength = $("input:checkbox[class=selectCheck]:checked").length;

		console.log("선택한 체크 수: " + checkedLength);
		$("input:checkbox[class=selectCheck]:checked").each(
				function(idx) {
					selectedItemCount += 1;
					//선택된 상품 계산
					var itemObj = $(this).parents("tr");
					var ordQty = Number($(itemObj).find("input[id='ordQty']")
							.val());
					if (!isNaN(ordQty)) {
						//총 상품금액 계산(정상금액)
						if (!isNaN(Number($(itemObj).find(
								"input[id='nrmOriPrc']").val()))) {
							totalNormalPrice += Number($(itemObj).find(
									"input[id='nrmOriPrc']").val())
									* ordQty;
						}
						//총 할인금액 계산
						if (!isNaN(Number($(itemObj).find(
								"input[id='disOriPrc']").val()))) {
							totalDcPrice += Number($(itemObj).find(
									"input[id='disOriPrc']").val())
									* ordQty;
						}
						//총 결제예상 금액
						if (!isNaN(Number($(itemObj).find(
								"input[id='totOriPrc']").val()))) {
							totalPayPrice += Number($(itemObj).find(
									"input[id='totOriPrc']").val())
									* ordQty;
						}
					}
				});
		console.log("총 상품 정상 금액: " + totalNormalPrice);
		$("#emPriceFTotNrmlprice").text(numFormatComma(totalNormalPrice));
		// 총 원가 히든값 삽입
		document.getElementById("totalNrmPrice").value = totalNormalPrice;
		
		$("#emPriceFTotDcAmt").text(numFormatComma(totalDcPrice));
		// 총 할인가 히든값 삽입
		document.getElementById("totalDisPrice").value = totalDcPrice;
		
		$("#emPriceFTotPayAmt").text(numFormatComma(totalPayPrice));
		// 총 할인된 주문액 히든값 삽입
		document.getElementById("totalOrdPrice").value = totalPayPrice;
		
		$("#emTotalItemCnt").text(numFormatComma(selectedItemCount));
	};

	// 변경된 상품 가격 할인금액, 합계 화면에서 보여주는 계산
	function calculateItemSellPrice(itemObj, obj) {
		
		var ordQty = Number($("input[id=ordQty]", $(itemObj)).val());
		//상품 정상 금액
		var nOP = Number($("input[id=nrmOriPrc]", $(itemObj)).val());
		//상품 할인 금액
		var dOP = Number($("input[id=disOriPrc]", $(itemObj)).val());
		//상품 할인된 금액
		var tOP = Number($("input[id=totOriPrc]", $(itemObj)).val());
		
		console.log(nOP, dOP, tOP);
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
						$("input:checkbox[class=selectCheck]").prop("checked",
								isChecked);
						//가격 재계산
						calculateSellPrice();
						//주문이 가능한 상태인지 체크
						checkOrderable();

					});
		}
		if ($("input:checkbox[class=selectCheck]")) {
			$("input:checkbox[class=selectCheck]").click(
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
						$("input:checkbox[class=selectCheck]").each(function() {
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
						checkOrderable();

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
	};
	//현재 주문 가능하게 선택했는지 확인(장바구니에 상품이 하나 이상 담겨있는지)
	function checkOrderable() {
		var selectedItemCount = $("input:checkbox[class=selectCheck]:checked").length;
		var orderBtn = $("#orderBtn");
		console.log("체크함수 실행: " + selectedItemCount);
		if (selectedItemCount > 0) {
			orderBtn.removeAttr("disabled");
		} else {
			orderBtn.attr("disabled", "disabled");
		}
	};
	
</script>

<%@ include file="header.jsp" %>
<div class="container mt-5" style="min-width: 1200px">
	<!-- 바디 전체-->
	<div class="cbody">
		<div class="contents">
			<div class="csection">
				<form id="frmCartInfo" action="${contextPath}/order/" method="POST">
					<div class="cart-area">
						<input type="hidden" id="csrfToken" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<div class="cart-head">
							<div class="cart-top">
								<div class="cart-all">
									<strong>장바구니</strong> <span>(<em class="cart-count">${listCount }</em>)
									</span>
								</div>
								<ol class="cart-list-num">
									<li class="active"><strong>01</strong> <span>장바구니</span></li>
									<li><strong>02</strong> <span>주문서작성</span></li>
									<li><strong>03</strong> <span>주문완료</span></li>
								</ol>
							</div>
							<div class="cart-bottom">
								${memberDTO.name } 고객님의 회원등급:
								<c:if test="${memberDTO.grade.name == '실버'}"><span style="color: #495e78"> ${memberDTO.grade.name }</span></c:if>
								<c:if test="${memberDTO.grade.name == '골드'}"><span style="color: #E3A950"> ${memberDTO.grade.name }</span></c:if>
								<c:if test="${memberDTO.grade.name == '플래티넘'}"><span style="color: #27E2A4"> ${memberDTO.grade.name }</span></c:if>
								<c:if test="${memberDTO.grade.name == '다이아몬드'}"><span style="color: #56B2F6"> ${memberDTO.grade.name }</span></c:if>
								G.Point: <span><fmt:formatNumber value="${point}"
																type="currency" currencySymbol="" /></span>원
								<div class="btngroup">
									<button type="button" class="btn btn-cart-del"
										name="allCartDelete" onclick="selectedCartDel()">
										<i class="bi bi-cart-x"></i> <span>장바구니 비우기</span>
									</button>
								</div>
							</div>
						</div>
						<!--장바구니에 담긴 상품이 있는 경우-->
						<c:if test="${fn:length(list) != 0}">
							<div class="cart-body">
								<table class="table" id="nrmProd">
									<thead>
										<tr class="head">
											<th scope="col" class="all-select-event"><input
												id="allSel" title="모든 상품 전체결제 설정" type="checkbox"
												checked="checked" class="all-deal-select"
												name="allItemSelect" /> <label for="allSel"><span>전체선택</span></label>
											</th>
											<th scope="col" id="th-product-name">상품정보</th>
											<th scope="col" id="th-product-count">수량</th>
											<th scope="col" id="th-product-price">상품가격</th>
											<th scope="col" id="th-discount-price">할인금액</th>
											<th scope="col" id="th-total-price">합계</th>
											<th scope="col" id="th-order-delete">삭제</th>
										</tr>
										<c:forEach var="i" items="${list}" begin="0" step="1"
											varStatus="status">
											<tr height="200" class="cart-product">
												<td class="product-select-event">
												<input type="hidden" name="cartOrderListDTO[${status.index}].cartId" id="cartId" value="${i.cartId}" />
												 
												<input id="oneSel${status.count}" type="checkbox"
													class="selectCheck" name="cartOrderListDTO[${status.index}].itemSelect" checked="checked"
													value="${i.cartId}"> 
													
													<label for="oneSel${status.count}"></label></td>
												<td class="cart-product-box">
													
													
													<div class="product-image">
														<a href="${contextPath}/category/1/${i.categoryId}/detail/${i.parentProductId}" class="productImg">
															<img src="${i.prodImgUrl}" width="100" height="100"
															class="product-img" alt="">
														</a>
													</div>
													<div class="product-name">
														<a href="${contextPath}/category/1/${i.categoryId}/detail/${i.parentProductId}" class="moveProduct">${i.parentProductName}</a>
													</div>
													<div class="product-option">
														<span class="product-option-name"> 옵션:
															${i.productName} </span>
													</div>
													
												</td>
												<td class="cart-product-count">
													<div class="cart-count">
														<button value="-" count_range="m" type="button" class="calcdown"
															name="countDown">-</button>
														<input class="ccount" id="ordQty" value="${i.cartAmount }" readonly
															name="cartOrderListDTO[${status.index}].ordQty">
														<button value="+" count_range="p" type="button" class="calcdown"
															name="countUp">+</button>
														<input class="prodStock" type=hidden name="cartOrderListDTO[${status.index}].productStock"
															value="${i.stock}" />
													</div>
												</td>
												<td class="cart-price">
													<div class="cart-product-price">
														<input type=hidden id="nrmOriPrc" name="cartOrderListDTO[${status.index}].nrmOriPrc"
															value="${i.cartPrice }" />
														<!-- 처음 불러올때 보이는 금액 -->
														<c:set var="proPrice"
															value="${i.cartPrice * i.cartAmount}" />
														<fmt:formatNumber var="pp" value="${proPrice}"
															type="currency" currencySymbol="" />
														<strong><span>${pp }</span></strong>원
													</div>
												</td>
												<td class="cart-discount">
													<div class="cart-product-discount">
														<input type=hidden id="disOriPrc" name="cartOrderListDTO[${status.index}].disOriPrc"
															value="${i.cartPrice * i.discountPercent / 100}" />
														<c:set var="disPrice"
															value="${proPrice  * i.discountPercent / 100 }" />
														-<strong><em><fmt:formatNumber value="${disPrice}"
																type="currency" currencySymbol="" /></em></strong>원
													</div>
												</td>
												<td class="cart-total">
													<div class="cart-total-price">
														<input type=hidden id="totOriPrc" name="cartOrderListDTO[${status.index}].totOriPrc"
															value="${i.cartPrice - (i.cartPrice * i.discountPercent / 100)}" />
														<!-- 처음 불러올때 보이는 할인률, 할인 금액 -->
														<c:set var="totPrice" value="${proPrice - disPrice}" />
														<strong><span><fmt:formatNumber value="${totPrice}"
																type="currency" currencySymbol="" /></span></strong>원
													</div>
												</td>
												<td class="cart-purchase-delete">
													<div class="cart-pur-del">
														<button type="button" class="btn text-black btn-delete"
															onclick="oneCartDel(this)"><i class="fa-solid fa-trash-can" style="margin: 0 auto;"></i></button>
													</div>

												</td>

											</tr>
										</c:forEach>
									</thead>
								</table>
							</div>
						</c:if>
						<!-- 장바구니에 담긴 상품이 없는 경우-->
						<c:if test="${list == null or fn:length(list) == 0}">
							<div class="nodata">
								<span class="bgcircle"> <i class="icon nodata-type"></i>
								</span>
								<p>
									<span>장바구니에 담긴 상품이 없습니다.</span>
								</p>
							</div>
						</c:if>
					</div>
					<div class="all-cart-total-price">
						<div class="all-price-area">
							총 상품가격 <em class="final-product-price" id="emPriceFTotNrmlprice">0</em>원
							<i class="bi bi-dash-square"></i> 총 할인가격 <em
								class="final-product-discount" id="emPriceFTotDcAmt">0</em>원 <i
								class="bi bi-arrow-right-square"></i> 총 주문금액 <em
								class="final-order-price" id="emPriceFTotPayAmt">0</em>원 <input
								type="hidden" id="totalNrmPrice" value="" name="TNP"> <input
								type="hidden" id="totalDisPrice" value="" name="TDP"> <input
								type="hidden" id="totalOrdPrice" value="" name="TOP">
						</div>
					</div>
					<div class="order-buttons">
						<button type="button" class="btn text-black continue" style="background: white; border: 1px solid #eee;" onClick="location.href='${contextPath}'">쇼핑 계속하기</button>
						<button type="submit" id="orderBtn" class="btn text-white btn-default purchase">구매하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- cfoot-->
	<div class="cfoot">
		<div class="cfoot-info">
			<div class="cart-info">
				<h3 class="major-headings">장바구니 이용안내</h3>
				<div class="cart-infocnt" role="region" aria-label="장바구니 이용안내">
					<h4 class="subheadings">장바구니 보관 안내</h4>
					<ul class="dotlist">
						<li>장바구니에 담긴 상품은 1달 동안 보관됩니다.</li>
					</ul>
					<h4 class="subheadings">무이자 할부 이용 안내</h4>
					<ul class="dotlist">
						<li>상품상세 페이지나 장바구니에 기재된 무이자할부 개월수는 해당상품을 단독 구매할 경우 적용되는
							조건입니다.</li>
						<li>여러종류의 상품을 함께 구매 할 경우, 보다 낮은 개월 수 의 무이자 할부가 적용됩니다.</li>
						<li>무이자할부 대상이 아닌 상품을 함께 구매 할 경우, 무이자 할부가 적용되지 않습니다.</li>
						<li>일부 특가상품은 무이자 할부 대상에서 제외되며 또한 각 상품별로 무이자 할부 개월수가 상이하오니, 최종
							결제 페이지에서 무이자 할부 개월수를 다시 한번 확인하시기 바랍니다.</li>
						<li>상품별로 무이자할부 혜택을 받고 싶으시다면, 개별 주문 부탁드립니다.</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="./footer.jsp" %>