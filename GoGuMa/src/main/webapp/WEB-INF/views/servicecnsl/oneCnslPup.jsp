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
    showPage(1);
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
    $('#confirmOrder').click(function(){
      $("#popup_layer").hide();
      $("#find-order-txt").show();
      var radioChk = $('input[name=flexRadioDefault]:checked').parent().parent();
      var impId = radioChk.find(".imp-num").text();
      var prodName = radioChk.find(".product-name").text();
      var receiptId = parseInt(radioChk.find(".receipt-id").val());
      console.log(radioChk);
      console.log(impId);
      console.log(prodName);
      console.log(receiptId);
      $('#imp-em').text(impId);
      $('#prod-em').text(prodName);
      $('#find-imp').attr('value', impId);
      $('#receiptID').attr('value', receiptId);
    });
    $("#cnslSel").change(function(){
  		$("#csCategory").val($(this).val());
  	});
    
    $("#FormControlTextarea1").on("input", function() {
      var currentVal = $(this).val();
      $('#qna-content').val(currentVal);
      console.log($('#qna-content').val());
  	});
  });
  //제출 전 검증후 post
  function chkConfirm(){
    console.log("클릭");
    var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var data = $('#frmScInfo').serialize();
	$.ajax({
	  	url : "${contextPath}/serviceclient/api/inquiry",
  		type: "POST",
  		data : data,
  		beforeSend : function(xhr) {
			xhr.setRequestHeader(header,token);
		},
		success : function(response) {
		  	alert("고객님의 소중한 문의가 등록되었습니다.");
		  	window.close();
		},
		error : function(xhr,status,error) {
			var errorResponse = JSON.parse(xhr.responseText);
		}
	});
  }
  //주문 내역 조회수 불러오는 페이지 (초기 1페이지)
  function showPage(pg){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var data = {
		  pages : pg
		};
		$.ajax({
		 	url : "./api/oneCnslPup",
		  	type: "POST",
		  	data : data,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header,token);
			},
			success : function(response) {
			  str = "";
			  for(var i = 0; i<response.length; i++){
				    var iUid = response[i].impUid;
				    console.log(response[i]);
				    if(response[i].impUid){
				      iUid = iUid.substring(4);
				    }else{
				      iUid = "결제오류";
				    }
			    	str += "<tr class='sel'>";
					str +=	"<td class='receipt-select'>";
					str +=		"<input class='form-check-input' type='radio' name='flexRadioDefault' id='flexRadioDefault1'>";
					str +=	"</td>";
					str +=  "<td class='imp-num-td'>";
					str +=		"<div class='imp-num'>";
					str +=			iUid;
					str +=		"</div>";
					str +=  	"<input type='hidden' class='receipt-id' value='"+ response[i].receiptId +"'/>";
					str +=	"</td>";
					str +=	"<td class='product-name-td'>";
					str +=		"<div class='product-name text-truncate'>";
					 				for(var j = 0; j<response[i].orderList.length; j++){
					str +=				response[i].orderList[j].pname + "(" + response[i].orderList[j].cname + ")";
					 				}
					str +=		"</div>";
					str +=	"</td>";
					str +=	"<td class='imp-price-td'>";
					str +=		"<div class='imp-price'>";
					str +=			numFormatComma(response[i].totalPrice) + "원";
					str +=		"</div>";
					str +=	"</td>";
					str += "</tr>";
			  }
			  $('.sel-item').html(str);
				
			},
			error : function(xhr,status,error) {
				var errorResponse = JSON.parse(xhr.responseText);
			}												
		});
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

<body id="popWin">
	<div class="popup-win cus-consult">
		<!--pop-wrap-->
		<div class="pop-wrap">
			<!--pop-content-wrap-->
			<div class="pop-content-wrap">
				<strong class="pop-title">1:1 문의하기</strong>
				<!--pop-content-->
				<div class="pop-content">
					<p class="desc">문의하고자 하시는 내용을 작성해주세요. 빠른 답변 드리겠습니다.</p>
					<div>고객센터 > 내 상담내역 조회에서 확인하실 수 있습니다.</div>
					<form id="frmScInfo">
						<input type="hidden" id="csrfToken" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="content">
						<div class="row pop-row">
							<div class="col-md-4 col-head">문의 유형 선택</div>
							<div class="col-md-8 col-content" id="bname">
								<!--상담유형선택-->
								<select name="cnslSel" class="form-select" id="cnslSel">
									<option value=0>상담 분야 선택</option>
									<c:forEach var="i" items="${scDtoList }" begin="0" step="1" varStatus="status">
										<option value="${i.categoryId}">${i.categoryName}</option>
									</c:forEach>
								</select>
								<input type="hidden" id="csCategory" name="categoryID" value=0>
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
													</thead>
													<tbody class="sel-item">

													</tbody>
												</table>
												<div>
													<nav aria-label="Page navigation example">
														<ul class="pagination">
															<li class="page-item"><a class="page-link" href="#" aria-label="Previous">
																	<span aria-hidden="true">&laquo;</span>
																</a></li>
															<c:forEach var="i" begin="1" step="1" end="${maxPages}" varStatus="status">
																<li class="page-item"><button type="button" class="page-link" onclick="showPage(${i})">${i }</button></li>
															</c:forEach>
															<li class="page-item"><a class="page-link" href="#" aria-label="Next">
																	<span aria-hidden="true">&raquo;</span>
																</a></li>
														</ul>
													</nav>
												</div>
											</div>
											<!--팝업 버튼 영역-->
											<div class="popup_btn" style="float: bottom;">
												<button type="button" class="btn btn-primary" id="closeFindOrder">닫기</button>
												<button type="button" class="btn btn-primary" id="confirmOrder">확인</button>
											</div>
										</div>
									</div>
								</div>
								<div class="show-sc text-truncate">
									<!-- 주문내역에서 찾는 경우 -->
									<span id="find-order-txt" style="display: none"> 주문번호: <em id="imp-em"></em> 상품명: <em id="prod-em"></em>
									</span>
									<input type="hidden" id="find-imp" name="receiptID">
								</div>
							</div>
						</div>
						<div class="row pop-row">
							<div class="col-md-4 col-head">제목</div>
							<div class="col-md-8 col-content" id="baddress">
								<input class="form-control" type="text" name="qnaTitle" placeholder="제목을 입력해주세요." value="">
							</div>
						</div>
						<div class="row pop-row">
							<div class="col-md-4 col-head">문의 내용</div>
							<div class="col-md-8 col-content" id="bcont">
								<textarea class="form-control" placeholder="문의 내용을 입력하세요." id="FormControlTextarea1" rows="3"></textarea>
							</div>
							<input type="hidden" id="qna-content" name="qnaContent" value="">
						</div>
						<div class="row pop-row">
							<div class="col-md-4 col-head">연락처</div>
							<div class="col-md-8 col-content">
								<input type="text" name="phone" id="bphone" class="form-control" maxlength="13" oninput="inputPhoneNumber(this);" value="">
							</div>
						</div>
						<div class="row pop-row">
							<div class="col-md-4 col-head">이메일</div>
							<div class="col-md-8 col-content" id="email">${memberDTO.email}</div>
							<input type="hidden" name="email" value="${memberDTO.email}">
						</div>
						<div class="btnGroup">
							<button type="button" class="btn btn-primary" onclick="chkConfirm()">문의하기</button>
							<button type="button" class="btn btn-secondary">취소</button>
						</div>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>