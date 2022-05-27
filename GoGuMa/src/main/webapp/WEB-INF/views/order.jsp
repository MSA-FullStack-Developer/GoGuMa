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
		$("button[class='btn-change-address']").click(function() {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");

			$.ajax({
				type : "POST",
				url : "${contextPath}/mypage",
				data : "data",
				dataType : "dataType",
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(response) {

				}
			});
		});
	});
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
							<span> ${memberDTO.name } </span>고객님의 혜택 정보 회원등급: <span>
								${memberDTO.grade.name } </span> 적립금: <span> 100000 </span>
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
											<c:forEach var="i" items="${list }" begin="0" step="1"
												varStatus="status">
												<tr class="order-product">
													<td class="order-product_box">
														<div class="product-image">
															<a href="이동할 링크" class="moveProduct"> <img
																src="${i.prodImgUrl }" width="78" height="78"
																class="product-img" alt="">
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
								<button type="button" class="btn text-white btn-change-address"
									id="btn-change-address" data-toggle="modal"
									data-target="#myModal">배송지변경</button>
								<button class="accordion-button" type="button"
									data-bs-toggle="collapse"
									data-bs-target="#panelsStayOpen-collapseThree"
									aria-expanded="true"
									aria-controls="panelsStayOpen-collapseThree">받는사람정보</button>
							</h3>
							<!-- 회원가입 확인 Modal-->
							<!-- Modal -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="exampleModalLabel">모달 제목</h4>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<div class="delivery-All-address">
												<c:forEach var="i" items="${addressList }" begin="0"
													step="1" varStatus="status">
													<div class="row">
														<div class="row">
															<div class="col-md-4 delivery-address-th">이름</div>
															<div class="col-md-8 delivery-address-td">
																<span class="delivery-address-name">${i.recipient }</span>
															</div>
															<c:if test="${i.isDefault == 1}">
																<div class="col-md-4">
																	<span class="delivery-address-alias">기본배송지</span>
																</div>
															</c:if>
														</div>
														<div class="row">
															<div class="col-md-4 delivery-address-th">배송지이름</div>
															<div class="col-md-8 delivery-address-td">
																<span class="delivery-address-nickname">${i.nickName }</span>
															</div>
														</div>
														<div class="row">
															<div class="col-md-4 delivery-address-th">배송주소</div>
															<div class="col-md-8 delivery-address-td">${i.address }</div>
														</div>
														<div class="row">
															<div
																class="col-md-4 delivery-address-th delivery-phone-num-th">연락처</div>
															<div
																class="col-md-8 delivery-address-td delivery-phone-num-td">${i.contact }</div>
														</div>
													</div>
												</c:forEach>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-dismiss="modal">Close</button>
											<button type="button" class="btn btn-primary">Save
												changes</button>
										</div>
									</div>
								</div>
							</div>

							<script>
								$('#btn-change-address').click(function(e) {
									e.preventDefault();
									$('#myModal').modal("show");
								});
							</script>
							<div id="panelsStayOpen-collapseThree"
								class="accordion-collapse collapse show"
								aria-labelledby="panelsStayOpen-headingThree">
								<div class="accordion-body address-info">
									<table class="delivery-address">
										<tbody>
											<tr>
												<th class="delivery-address-th">이름</th>
												<td class="delivery-address-td"><span
													class="delivery-address-name">${defaultAddress.recipient }</span>
													<c:if test="${defaultAddress.isDefault == 1}">
														<span class="delivery-address-alias">기본배송지</span>
													</c:if></td>
											</tr>
											<tr>
												<th class="delivery-address-th">배송지이름</th>
												<td class="delivery-address-td"><span
													class="delivery-address-nickname">${defaultAddress.nickName }</span>
												</td>
											</tr>
											<tr>
												<th class="delivery-address-th">배송주소</th>
												<td class="delivery-address-td">
													${defaultAddress.address }</td>
											</tr>
											<tr>
												<th class="delivery-address-th delivery-phone-num-th">연락처</th>
												<td class="delivery-address-td delivery-phone-num-td">
													${defaultAddress.contact }</td>
											</tr>
										</tbody>
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