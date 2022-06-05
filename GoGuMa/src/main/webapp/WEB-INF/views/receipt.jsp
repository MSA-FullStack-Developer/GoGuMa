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
	$(document)
			.ready(
					function() {
						bindCartList();
						calculateSellPrice();
						checkOrderable();

						
	
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
<style>
	<%@ include file="/resources/css/header.css" %>
</style>
<div class="container">
	<%@ include file="header.jsp" %>
	
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
					<div class="all-cart-total-price">
						<div class="all-price-area">
							<strong>고구마 쇼핑몰을 이용해주셔서 감사합니다.</strong> 
							<p>주문하신 내역은 마이페이지 > 나의 쇼핑내역 > 주문/배송조회에서 확인하실 수 있습니다.</p>
							<strong>주문번호: </strong>1223123123
						</div>
					</div>

					<div class="order-buttons">
						<button type="button" class="btn text-black continue">쇼핑 계속하기</button>
						<button type="submit" id="orderBtn" class="btn text-white btn-default purchase">나의 쇼핑 내역</button>
					</div>
			</div>
		</div>
	</div>

</div>

<%@ include file="./footer.jsp" %>