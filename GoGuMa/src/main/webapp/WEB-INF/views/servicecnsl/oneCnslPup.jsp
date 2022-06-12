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

<link rel="stylesheet" href="${contextPath}/resources/css/oneCnslPup.css">

<script type="text/javascript" src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.js"></script>

<script type="text/javascript">

const inputPhoneNumber = (target) => {
  target.value = target.value
    .replace(/[^0-9]/g, '')
   .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
 }

  $(document).ready(function() {
    var phone = "${memberDTO.phone}".replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
    console.log("${receiptHistory }");
    $('#bphone').attr('value', phone);
    console.log("${memberDTO}");
    
    $('#findReceitpBtn').click(function(e){
      if ($("#popup_layer").css('display') == 'none') {
      	$("#popup_layer").show();
      }
    });
    $('#closeFindOrder').click(function() {
      $('#popup_layer').hide();
    });
  });
  
  //주문 내역 조회수 불러오는 페이지 (초기 1페이지)
  function showPage(pg){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		
		$.ajax({
		  type: "POST",
		  
		});
  }
</script>

<body id="popWin">
	<div class="popup-win cus-consult">
		<!--pop-wrap-->
		<div class="pop-wrap" style="margin: 45px;">
			<!--pop-content-wrap-->
			<div class="pop-content-wrap">
				<strong class="pop-title">1:1 문의하기</strong>
				<!--pop-content-->
				<div class="pop-content">
					<p class="desc">문의하고자 하시는 내용을 작성해주세요. 빠른 답변 드리겠습니다.</p>
					<div>고객센터 > 내 상담내역 조회에서 확인하실 수 있습니다.</div>
						<div class="content">
							<div class="row pop-row">
								<div class="col-md-4 col-head">문의 유형 선택</div>
								<div class="col-md-8 col-content" id="bname">
									<!--상담유형선택-->
									<select name="cnslSel" class="form-select" id="cnslSel">
										<option value="">상담 분야 선택</option>
										<c:forEach var="i" items="${scDtoList }" begin="0" step="1" varStatus="status">
											<option value="${i.categoryName}">${i.categoryName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="row pop-row">
								<div class="col-md-4 col-head">문의 상품 정보</div>
								<div class="col-md-8 col-content" id="bemail">
									<div>
										<button type="button" class="btn btn-primary" id="findReceitpBtn">주문내역에서 찾기</button>
										<!-- 주문내역 조회 레이어 팝업 (주문내역 찾을 시 보이는 팝업)-->
										<div class="popup_layer" id="popup_layer" style="display: none;">
											<div class="popup_box">
												<!--팝업 컨텐츠 영역-->
												<div class="popup_cont">
													<h5>주문내역 조회</h5>
													<table class="table" id="nrmProd">
														<thead>
															<tr class="head">
																<th scope="col" class="select-event">선택</th>
																<th scope="col" id="th-product-name">주문번호</th>
																<th scope="col" id="th-product-count">상품명</th>
																<th scope="col" id="th-product-price">결제금액</th>
															</tr>
															<tbody class="sel-item">
																<c:forEach var="i" items="${receiptHistory }" begin="0" step="1" end="10" varStatus="status">
																<tr class="sel">
																	<td class="receipt-select">
																		<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
																	</td>
																	<td class="imp-num-td">
																		<div class="imp-num">
																			${i.impUid }
																		</div>
																	</td>
																	<td class="product-name-td">
																		<div class="product-name text-truncate" >
																			<c:forEach var="prod" items="${i.orderList }" begin="0" step="1" varStatus="status">
																				${prod.pname}(${prod.cname }).
																			</c:forEach>
																		</div>
																	</td>
																	<td class="imp-price-td">
																		<div class="imp-price">
																			${i.totalPrice}
																		</div>
																	</td>
																</tr>
																</c:forEach>
															</tbody>
														</thead>
													</table>
													<div>
														<nav aria-label="Page navigation example">
														  <ul class="pagination">
														    <li class="page-item">
														      <a class="page-link" href="#" aria-label="Previous">
														        <span aria-hidden="true">&laquo;</span>
														      </a>
														    </li>
														    <c:forEach var="i" begin="1" step="1" end="${maxPages}" varStatus="status">
														    <li class="page-item"><a class="page-link" href="./oneCnslPup/1">${i }</a></li>
														    </c:forEach>
														    <li class="page-item">
														      <a class="page-link" href="#" aria-label="Next">
														        <span aria-hidden="true">&raquo;</span>
														      </a>
														    </li>
														  </ul>
														</nav>
													</div>
												</div>
												<!--팝업 버튼 영역-->
												<div class="popup_btn" style="float: bottom;">
													<button class="btn btn-primary" id="closeFindOrder">닫기</button>
													<button class="btn btn-primary">확인</button>
												</div>
											</div>
										</div>
									</div>
									<div>
										<!-- 주문내역에서 찾는 경우 -->
										<span style="display: none">주문번호: 123123 상품명: 케시미어 100% 옷</span>
									</div>
								</div>
							</div>
							<div class="row pop-row">
								<div class="col-md-4 col-head">제목</div>
								<div class="col-md-8 col-content" id="baddress">
									<input class="form-control" type="text" placeholder="제목을 입력해주세요.">
								</div>
							</div>
							<div class="row pop-row">
								<div class="col-md-4 col-head">문의 내용</div>
								<div class="col-md-8 col-content" id="bcont">
									<textarea class="form-control" placeholder="문의 내용을 입력하세요." id="exampleFormControlTextarea1" rows="3"></textarea>
								</div>
							</div>
							<div class="row pop-row">
								<div class="col-md-4 col-head">연락처</div>
								<div class="col-md-8 col-content">
									<input type="text" id="bphone" class="form-control" maxlength="13" oninput="inputPhoneNumber(this);" value="">
								</div>
							</div>
							<div class="row pop-row">
								<div class="col-md-4 col-head">이메일</div>
								<div class="col-md-8 col-content" id="email">${memberDTO.email}</div>
							</div>
						</div>
					<div class="btnGroup" style="margin-top: 20px;">
						<button class="btn btn-primary">문의하기</button>
						<button class="btn btn-secondary">취소</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>