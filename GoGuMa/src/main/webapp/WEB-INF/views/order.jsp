<%@ page session="false" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<link rel="stylesheet" href="${contextPath}/resources/css/cart/cartOrder.css">
<link rel="stylesheet" href="${contextPath}/webjars/jquery-ui/1.13.0/jquery-ui.css">
<script type="text/javascript" src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.js"></script>
<script type="text/javascript" src="${contextPath}/webjars/jquery-ui/1.13.0/jquery-ui.js"></script>

 <!-- iamport.payment.js -->
 <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
 
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 <style>
 	.col-md-4 {
	    padding: 0px 0px;
	    background-color: #FFF;
	}
	
	.orderPageBtn {
		background-color: #6426DD;
	    border-radius: 5pt;
	    height: 38px;
	    width: auto;
	    color: white;
	    border: none;
	    padding-left: 10px;
	    padding-right: 10px;
	}
	
	.orderPageBtn:hover {
		background-color: #FF493C;
	}
 </style>
 <script type="text/javascript">
 	const autoHyphen = (target) => {
		target.value = target.value
		   .replace(/[^0-9]/g, '')
		   .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	}
  //?????? ?????? ?????? ???????????????
  $(document).on('click', '.coupon-list-box', function() {
    var coupon_discount = $(this).find(".coupon-benefit").text();
    var coupon_name = $(this).find(".coupon-name").text();
    
    var coupon_id = $(this).find("#coupon-id").val();
    
    var totalAmount = $('#lastStlAmtDd1').text();
    // ?????? ????????? ?????? ?????? ???????????? ?????? ????????? ??? ??????.
    console.log(totalAmount);
    console.log(coupon_discount);
    if(parseInt(coupon_discount) > parseInt(totalAmount)){
      alert("?????? ?????? ???????????? ??? ??????????????? ????????? ??? ????????????.");
      return;
    }
    $('#use-coupon-id').attr('value', parseInt(coupon_id));
    $('.dis-coupon-prc').text(numFormatComma(coupon_discount));
    $('#coupon-discount').text(numFormatComma(coupon_discount));
    $('#couponDiscount').attr('value', parseInt(coupon_discount));
    $('#couponModal').modal('hide');
    
    calDisPrice();
    alert(coupon_name + " ????????? ?????????????????????.");
  });
  $(document).ready(function() {
    //??? ?????? ??????, ??? ????????? ??????, ???????????? G.Point
    console.log("???????????? ?????????: " + $('#pregp').val());
    var gp = parseInt($('#pregp').val());
    $('#pre-gp').text(numFormatComma(gp));
    
    var total = $('#total').val();
    $('#total-price').text(numFormatComma(total));
    
    var membershipDiscount = parseInt($('#membershipDiscount').val());
    $('#membership-discount').text(numFormatComma(membershipDiscount));
    
    $('#all-discount').text(numFormatComma(membershipDiscount));
    
    $('#lastStlAmtDd').text(numFormatComma(total-membershipDiscount));
    $('#lastStlAmtDd1').text(total-membershipDiscount);
    //?????? ?????? ??????
    $('#getCoupon-btn').on('click', function() {
      let token = $("meta[name='_csrf']").attr("content");
      let header = $("meta[name='_csrf_header']").attr("content");
      $.ajax({
      url : '${contextPath}/order/api/getMemberCoupon',
      type : 'POST',
      contentType : 'application/json; charset=utf-8;',
      beforeSend : function(xhr) {
        xhr.setRequestHeader(header, token);
      },
      success : function(result) {
        if (result.length > 0) {
          $('#coupon-all *').remove();
          for (var i = 0; i < result.length; i++) {
            console.log("?????? ??????: " + result[i].couponName);
            str = "<div class='coupon-list-box'>";
            str += "<div class='row coupon'>";
            str += "<input type='hidden' id='coupon-id' value='"+ result[i].couponId +"'>";
            str += "<div class='coupon-benefit-th'><span class='coupon-benefit'>" + result[i].benefit + "</span>???</div>";
            str += "<div class='coupon-name-th'><span class='coupon-name'>" + result[i].couponName + "</span></div>";
            str += "<div>";
            str += "<div class='row coupon'>";
            str += "<div class='coupon-expiration-th'><span class='coupon-expiration'> ???????????? ~" + result[i].expiration + "</span></div>";
            str += "<div class='img-coupon'>";
            str += "<img class='coupon-picture' src='${contextPath}/resources/img/ggmCoupon.png' alt=''>";
            str += "</div>";
            str += "</div>";
            str += "</div>";
            $('#coupon-all').append(str);
          }
        } else {
          console.log("????????? ????????? ????????????.");
          $('#coupon-all *').remove();
          str = "<div class='noCoupon'>";
		  str += "<span>????????? ????????? ????????????.</span>";
          str += "</div>";
          $('#coupon-all').append(str);
        }
      }
      });
    });
    // ?????? ????????? ?????? ?????????
    $('#addAddressBtn').on('click', function() {
      let isDefault = 0;
  		if($('#isDefault').prop('checked')) {
  			isDefault = 1;
  		}
  		
  		let token = $("meta[name='_csrf']").attr("content");
  	    let header = $("meta[name='_csrf_header']").attr("content");
  	    let data = {
      		nickName : $('#addressBody').find('#nickName').val(),
  			recipient : $('#addressBody').find('#recipient').val(),
  			postCode : $('#addressBody').find('#postCode').val(),
  			address : $('#addressBody').find('#address').val(),
  			detail : $('#addressBody').find('#detail').val(),
  			contact : $('#addressBody').find('#contact').val(),
  			isDefault : isDefault
  	    }
  	    
  	    if(checkEmpty(data) != 'empty') {
	  		$.ajax({
	  			url : '${contextPath}/mypage/manageAddress/addAddress',
	  			type : 'POST',
	  			data : JSON.stringify(data),
	  			contentType : 'application/json; charset=utf-8;',
	  			beforeSend : function(xhr) {
	  	            xhr.setRequestHeader(header, token);
	  	        },
	  	        success:function(result) {
	  	        	if(result==1) {
	  	        		alert('???????????? ??????????????????.');
	  	        		location.reload();
	  	        	} else {
	  					alert('???????????? ???????????? ???????????? ????????? ??????????????????.');
	  				}
	  	        },
	  			error:function(xhr, status, error) {
	  				var errorResponse = JSON.parse(xhr.responseText);
	  				var errorCode = errorResponse.code;
	  				var message = errorResponse.message;
	  				alert(message);
	  			}
	  		});
  	    }
    });
    // ????????? ?????? ?????????
    $('.address-list-box').click(function() {
      if ($(".tbody-on").css('display') == 'none') {
        $(".no-show-first").hide();
        $('.tbody-on').show();
      }
      
      var name = $(this).find('.delivery-address-name').text();
      var addressNickName = $(this).find('.delivery-address-nickname').text();
      var addressAlias = $(this).find('.delivery-address-alias').text();
      var addressPostNum = $(this).find('.address-post-num').text();
      var addressPer = $(this).find('.delivery-address-per').text();
      var addressDetail = $(this).find('.delivery-address-detail').text();
      var phonenumber = $(this).find('.delivery-phone-num-td').text();
      
      if (addressAlias == "") {
        console.log("?????????????????? ??????");
        $('#addressAlias').hide();
      } else {
        console.log(addressAlias);
        $('#addressAlias').show();
      }
      $('#name').text(name);
      $('#addressNickName').text(addressNickName);
      $('#addressPostcode').text(addressPostNum);
      $('#addressName').text(addressPer);
      $('#addressDetail').text(addressDetail);
      $('#phonenumber').text(phonenumber);
      $('#myModal').modal('hide');
      alert("???????????? ?????????????????????.");
    });
    // ?????? ?????? ?????????
    $('#pay-onclick').click(function(){
      var radioVal = $('input[name="card-type"]:checked').val();
      var addressInfo = $('#addressName').text();
      
      //?????? ????????? ????????? ??????????????? ??????
      var chkPayType = $('input[name=card-type]').is(":checked");
      console.log(chkPayType);
      if(addressInfo == ""){
        alert("????????? ????????? ?????????");
        return;
      }
      if(!chkPayType){
        alert("?????? ????????? ????????? ?????????");
        return;
      }
      if(radioVal == "nobank"){
        console.log("?????????");
        nobankbookiamport();
      }else{
        console.log("????????????");
        iamport(radioVal);
      }
    });
    $("#g-point").change(function(){
    	var point = parseInt($('#g-point').val());
    	var limitpoint = Number($('#member-point').val());
    	console.log(limitpoint);
    	console.log("??????: " + numFormatComma(point));
    	var totalAmount = $('#lastStlAmtDd1').text();
    	//??? ?????? ??????
    	var total = parseInt($('#total').val());
    	//????????? ?????? ??????
    	var membershipDiscount = parseInt($('#membershipDiscount').val());
    	//?????? ?????? ??????
    	var coupon_discount = $("#couponDiscount").val();
    	if (isNaN(coupon_discount)){
    	  coupon_discount = 0;
    	}
    	//?????? ????????? ?????? ?????????(?????? ?????? ??????)
    	var bound = total - membershipDiscount - coupon_discount;
    	if(numFormatComma(point) != "NaN"){
    	  	if (point < 0){
    	  	  $('#g-point').val(0);
    	  	  $('#point-discount').text(0);
	      	  $('#GPoint').attr('value', 0);
	      	  calDisPrice();
	      	  alert("???????????? 0 ?????? ???????????? ?????????.");
    	  	}
    	  	//?????? ??????????????? ?????? ??????????????? ??????
  	    	else if(point > limitpoint){
  	  	  	  $('#g-point').val(limitpoint);
  	      	  $('#point-discount').text(numFormatComma(limitpoint));
  	      	  $('#GPoint').attr('value', parseInt(limitpoint));
  	      	  calDisPrice();
  	      	  alert("?????? ???????????? ?????? ??? ????????????. ?????? ???????????? ???????????????.");
  	  	  	}
	    	//???????????? ?????? ?????? ???????????? ?????? ??????????????? ??????
	    	else if (point > bound){
	    	  console.log("?????? ???????????? ?????? ????????? ??? ??????");
	    	  $('#g-point').val(bound);
	      	  $('#point-discount').text(numFormatComma(bound));
	      	  $('#GPoint').attr('value', parseInt(bound));
	      	  calDisPrice();
	      	  alert("?????? ???????????? ?????? ????????? ??? ????????????.");
	      	}
	    	else{
	    	  $('#g-point').val(point);
	      	  $('#point-discount').text(numFormatComma(point));
	      	  $('#GPoint').attr('value', parseInt(point));
	      	  calDisPrice();
	      	}
    	}else{
    	  console.log("??????");
    	  $('#g-point').val(0);
    	  $('#point-discount').text(0);
    	  $('#GPoint').attr('value', 0);
    	  calDisPrice();
    	}
    });
    
    $('#point-cancel').click(function(){
      $('#g-point').val(0);
      $('#point-discount').text(0);
      $('#GPoint').attr('value', 0);
      calDisPrice();
    });
    
    $('select[name=comment]').change(function(){
      var selText = $("select[name=comment] option:selected").val()
      
      console.log(selText);
      if(selText == "write"){
        $('.commentbox').css("display", "");
        $('#requirement').attr('value', "");
      }else{
        $('.commentbox').css("display", "none");
        $('#requirement').attr('value', selText);
        console.log("????????????: " + $('#requirement').val());
      }
    });
  });
  
	//?????? ??????
	function iamport(radioVal){
		//????????? ????????????
		IMP.init('imp37623879');
		IMP.request_pay({
		    pg : radioVal,
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : $('#pay-name').val(), //??????????????? ????????? ??????
		    amount : $('#lastStlAmtDd1').text(), //?????? ???????????? ??????
		    buyer_email : "${memberDTO.email}",
		    buyer_name : $('#name').text(),
		    buyer_tel : $('#phonenumber').text(),
		    buyer_addr : $('#addressName').text() + " " + $('#addressDetail').text(),
		    buyer_postcode : $('#addressPostcode').text(),
		}, function(rsp) {
			  console.log("?????? ?????? ??? ?????? : " + rsp);
		      //???????????? ????????????
		      var token = $("meta[name='_csrf']").attr("content");
			  var header = $("meta[name='_csrf_header']").attr("content");
			  
		      $.ajax({
		        type: "POST",
		        url: "${contextPath}/order/api/verifyIamport/" + rsp.imp_uid,
		        beforeSend : function(xhr) {
							xhr.setRequestHeader(header,token);
						},
		      }).done(function(data){
		        console.log("done Data : " + data);
		        if(rsp.paid_amount == data.response.amount){
		         	console.log("?????? ??? ??????????????????");
		          	console.log(rsp);
		          	console.log(data);
		          	console.log("?????? status : " + data.response.status);
		        	paytransaction (data.response.impUid, data.response.status);
		        	console.log("uid?????? : " + $('#ipUid').val());
		        	console.log("?????? ?????????");
		        	$('#ipUid').val(data.response.impUid);
		        	$('#finOrder').submit();
	        	} else {
	        		alert("?????? ??????");
	        		//????????? ????????? ??????????????? ????????? ?????? ???????????? ????????????
	        	}
		      });
		    
		});
	}
	//????????? ??????
	function nobankbookiamport(){
	//????????? ????????????
	IMP.init('imp37623879');
	IMP.request_pay({
	    pg : 'html5_inicis',
	    pay_method : 'vbank',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : $('#pay-name').val(), //??????????????? ????????? ??????
	    amount : $('#lastStlAmtDd1').text(), //?????? ???????????? ??????
	    buyer_email : "${memberDTO.email}",
	    buyer_name : $('#name').text(),
	    buyer_tel : $('#phonenumber').text(),
	    buyer_addr : $('#addressName').text() + " " + $('#addressDetail').text(),
	    buyer_postcode : $('#addressPostcode').text(),
	}, function(rsp) {
	  	console.log("?????? ?????? ??? ?????? : ");
		  console.log(rsp);
	      //???????????? ????????????
	      var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
	      $.ajax({
	        type: "POST",
	        url: "${contextPath}/order/api/verifyIamport/" + rsp.imp_uid,
	        beforeSend : function(xhr) {
						xhr.setRequestHeader(header,token);
					},
	      }).done(function(data){
	        console.log(data);
	        if(rsp.paid_amount == data.response.amount){
	          if(rsp.pay_method == "vbank"){
		        console.log("????????? status : " + rsp.status);
		        paytransaction (rsp.imp_uid, rsp.status);
		        $('#ipUid').val(rsp.imp_uid);
	        	$('#finOrder').submit();
		      }
		    
	      	} else {
	      		alert("?????? ??????");
	      		//????????? ????????? ??????????????? ????????? ?????? ????????????
	      	}
	      });
		  
	});
}
	 //  unix time stamp to Date
	  function UnixTimeToDate(UnixTime){
		  var origin = new Date(UnixTime);
		  var year = origin.getFullYear();
		  var month = ('0' + (origin.getMonth() + 1)).slice(-2);
		  var day = ('0' + origin.getDate()).slice(-2);
		  var hours = ('0' + today.getHours()).slice(-2); 
		  var minutes = ('0' + today.getMinutes()).slice(-2);
		  var seconds = ('0' + today.getSeconds()).slice(-2);
		  var val_time = year+"-"+month+"-"+day + " " + hours + ":"+minutes + ":" + seconds;
		  return val_time;
		}
	//????????? ?????? ??? ??? ??????????????????
	function paytransaction(impUid, status){
	  	var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var parr = [];
		
		$('#nrmProd').find(".order-product").each(function(index, item){
		  var cartId = $(item).find("input[name=cartId]").val();
		  var productId = $(item).find("input[name=productId]").val();
		  var ordQty = $(item).find("input[name=cartAmount]").val();
		  parr.push({cartId, productId, ordQty});
		});
		
		var addr = {
		    nickName: $('#addressNickName').text(),
			recipient: $('#name').text(),
			address: $('#addressName').text() + " " + $('#addressDetail').text(),
			contact: $('#phonenumber').text()
		  };
		var req = $('#requirement').val();
		var oriprc = $('#total').val();
		var memDc = parseInt($('#membershipDiscount').val());
		var ucI = $('#use-coupon-id').val();
		var couponDis = $('#couponDiscount').val();
		var usePoint = $('#GPoint').val();
		var totprc = parseInt($('#finalPrice').val());
		
		var data = {
		    impUid: impUid,
		    status: status,
		    products: parr,
		    address: addr,
		    requirement: req,
		    originalPrice: oriprc,
		    membershipDiscount: memDc,
		    couponId: ucI,
		    couponDiscount: couponDis,
		    usagePoint: usePoint,
		    totalPrice: totprc
		};
		console.log(data);
 		$.ajax({
		  type : "POST",
			url : "${contextPath}/order/api/paytransaction",
			contentType: "application/json; charset=UTF-8",
			data : JSON.stringify(data),
			async: false,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success : function(result) {
			  console.log("?????? ajax ??????");
			  return;
			},
			error : function(xhr, error) {
				var errorResponse = JSON.parse(xhr.responseText);
				var errorCode = errorResponse.code;
				var message = errorResponse.message;
				alert(message);
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
	
	//??? ?????? ??????, ??? ?????? ????????????
	function calDisPrice(){
	    var totalDC = parseInt($('#membershipDiscount').val());
	    if(!isNaN($('#GPoint').val())){
	      totalDC += parseInt($('#GPoint').val());
	    }
	    if(!isNaN($('#couponDiscount').val())){
	      totalDC += parseInt($('#couponDiscount').val())
	    }
	    $('#all-discount').text(numFormatComma(totalDC));
	    
	    var totalPrice = parseInt($('#total').val());
	    var totalPayPrice = totalPrice - totalDC;
	    
	    $('#lastStlAmtDd').text(numFormatComma(totalPayPrice));
	    $('#lastStlAmtDd1').text(totalPayPrice);
	    $('#finalPrice').attr('value', totalPayPrice);
	    console.log(totalPayPrice);
	}
	//????????? ?????? ?????? ??????
	function clearCoupon(){
	    $('#use-coupon-id').val(0);
	    $('.dis-coupon-prc').text("?????? ??????");
	    $('#coupon-discount').text(0);
	    
	    $('#couponDiscount').val(0);
	    $('#couponModal').modal('hide');
	    calDisPrice();
	    alert("?????? ????????? ??????????????????.");
	}
	//???????????? ?????? ??? ??????
	function checkBytes(e, mcount){
	  let content = $(e).val();
	  if (content.length > mcount) {
	    $(e).val($(e).val().substring(0, mcount));
	    alert("???????????? 100?????? ?????? ??? ????????????.");
	    } 
	  else {
	    	$('#requirement').attr('value', $('.commentarea').val());
	    	console.log("???????????? ?????? : " + $('#requirement').val())
	    	$('#cntnLen').text(content.length);
	    }
	}
	// ?????? ????????? ??????
	function getAddressByFindingPostCode() {
		new daum.Postcode({
			oncomplete: function(data) {
				// ??? ????????? ?????? ????????? ????????? ????????? ????????????.
				// ???????????? ????????? ?????? ?????? ???????????? ??????('')??? ????????? ?????????.
				let addr = ""; // ?????? ??????
				let extra = ""; // ?????? ??????
				
				// ???????????? ????????? ????????? ????????? ??????
				if(data.userSelectedType === 'R') {
					addr = data.roadAddress;
				}
				// ???????????? ?????? ????????? ????????? ??????
				else {
					addr = data.jibunAddress;
				}
				
				document.getElementById("postCode").value = data.zonecode;
				document.getElementById("address").value = addr;
				document.getElementById("detail").focus();
			}
		}).open();
	}
	
	// ?????? ???????????? ???????????? ??????
	function checkEmpty(data) {
		if(data.nickName == '') {
			alert('????????? ????????? ??????????????????.');
			return 'empty';
		}
		else if(data.recipient == '') {
			alert('?????? ?????? ??????????????????.');
			return 'empty';
		}
		else if(data.postCode == '') {
			alert('???????????? ????????? ???????????? ??????????????????.');
			return 'emtpy';
		}
		else if(data.detail == '') {
			alert('??????????????? ??????????????????.');
			return 'empty';
		}
		else if(data.contact == '') {
			alert('???????????? ??????????????????.');
			return 'empty';
		}
	}
</script>

<%@ include file="header.jsp" %>
<div class="container mt-5" style="min-width: 1200px">
	<!-- ?????? ??????-->
	<div class="cbody">
		<div class="contents">
			<div class="util-option sticky">
					<div class="sticky-inner">
						<h4 class=st-title>??? ?????? ??????</h4>
						<ul class="payment-list">
							<li>
								<div id="orderAmt">
									<span class="tit">??? ?????? ??????</span> <span class="txt"><strong id="total-price">0</strong>???</span>
								</div>
								<div id="membershipDcAmtDiv">
									<span class="tit">????????? ??????</span> <span class="txt">-<strong id="membership-discount">0</strong>???</span>
								</div>
								<div id="copnDcAmtDiv">
									<span class="tit">?????? ??????</span> <span class="txt">-<strong id="coupon-discount">0</strong>???</span>
								</div>
								<div id="pointDcAmtDiv">
									<span class="tit">G.Point</span> <span class="txt">-<strong id="point-discount">0</strong>???</span>
								</div>
								<div id="totDcAmtDiv">
									<span class="tit">?????? ????????????</span> <span class="txt">-<strong id="all-discount">0</strong>???</span>
								</div>
							</li>
							<li>
								<div class="total">
									<span class="tit">?????? ????????????</span> <span class="txt"><strong id="lastStlAmtDd">0</strong>???</span>
									<input type="hidden" id="lastStlAmtDd1" value=""/>
								</div>
							</li>
							<li>
								<div id="calculateList_upoint" class="hpoint">
									<span class="tit">???????????? G.Point</span> <span class="txt pre-gpoint"><em id="pre-gp">0</em>p</span>
								</div>
							</li>
						</ul>
						<div class="btngroup agreeCheck">
							<button type="button" id="pay-onclick" class="orderPageBtn medium">
								<span>??????</span>
							</button>
						</div>
					</div>
				</div>
			<div class="csection">

				<div class="order-content">
					<div class="cart-head">
						<div class="cart-top">
							<div class="cart-all">
								<strong>????????? ??????</strong>
							</div>
							<ol class="cart-list-num">
								<li><strong>01</strong> <span>????????????</span></li>
								<li class="active"><strong>02</strong> <span>???????????????</span></li>
								<li><strong>03</strong> <span>????????????</span></li>
							</ol>
						</div>
						<input type="hidden" id="member-point" value=${point }>
					</div>

					<div class="accordion accordion-flush">
						<div class="accordion-item">
							<h3 class="accordion-header order-products" id="panelsStayOpen-headingOne">
								<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne"><strong>?????? ????????????</strong></button>
							</h3>
							<div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne">
								<div class="accordion-body">
									<table class="table" id="nrmProd">
										<thead>
											<tr class="head">
												<th scope="col" id="th-product-name">????????????</th>
												<th scope="col" id="th-product-count">??????</th>
												<th scope="col" id="th-product-price">????????????</th>
												<th scope="col" id="th-discount-price">????????????</th>
												<th scope="col" id="th-total-price">??????</th>
											</tr>
											<c:set var = "total" value = "0" />
											<c:set var = "membershipDiscount" value = "0" />
											<c:set var = "preGPoint" value="0" />
											<c:forEach var="i" items="${list }" begin="0" step="1" varStatus="status">
												<tr class="order-product">
													<td class="order-product_box">
														<div class="product-image">
															<a href="????????? ??????" class="moveProduct">
																<img src="${i.prodImgUrl }" width="78" height="78" class="product-img" alt="">
															</a>
														</div>
														<div class="order-product-name">
															<input type="hidden" name="cartId" value="${i.cartId }"/>
															<input type="hidden" name="productId" value="${i.productId }"/>
															<input type="hidden" name="cartAmount" value="${i.cartAmount }"/>
															<a href="????????? ??????" class="pProductName">${i.parentProductName }</a>
														</div>
														<div class="product-option">
															 ??????: <span class="product-option-name">${i.productName } </span>
														</div>
													</td>
													<td class="cart-product-count">
														<div class="cart-count">
															<span class="c" readonly name="ordQty">${i.cartAmount }</span>
														</div>
													</td>
													<td class="cart-price">
														<div class="cart-product-price">
															<c:set var="proPrice" value="${dtoList[status.index].nrmOriPrc * dtoList[status.index].ordQty}"></c:set>
															<strong><em><fmt:formatNumber value="${proPrice}" type="currency" currencySymbol="" /></em></strong>???
															<c:set var= "total" value="${total + proPrice}"/>
															<c:set var= "preGPoint" value="${preGPoint + (proPrice * (memberDTO.grade.pointPercent / 100)) }"/>
														</div>
													</td>
													<td class="cart-discount">
														<div class="cart-product-discount">
															<c:set var="disPrice" value="${dtoList[status.index].disOriPrc * dtoList[status.index].ordQty}"></c:set>
															<strong>-<em><fmt:formatNumber value="${disPrice}" type="currency" currencySymbol="" /></em></strong>???
															<c:set var = "membershipDiscount" value = "${membershipDiscount + disPrice }" />
														</div>
													</td>
													<td class="cart-total">
														<div class="cart-total-price">
															<c:set var="totPrice" value="${dtoList[status.index].totOriPrc * dtoList[status.index].ordQty}"></c:set>
															<strong><em><fmt:formatNumber value="${totPrice}" type="currency" currencySymbol="" /></em></strong>???
														</div>
													</td>
												</tr>
											</c:forEach>
										</thead>
									</table>
									<input type="hidden" id="pregp" value="${preGPoint }" />
									<input type="hidden" id="total" value="${total }"/>
									<input type="hidden" id="membershipDiscount" value="${membershipDiscount }"/>
									<input type="hidden" id="use-coupon-id" value="0" />
									<input type="hidden" id="couponDiscount" value="0" />
									<input type="hidden" id="GPoint" value="0"/>
									<input type="hidden" id="finalPrice" value="${total - membershipDiscount }" />
									<input type="hidden" id="requirement" class="requirement-in" value="" />
									<c:if test="${fn:length(list) > 1}">
										<input id="pay-name" type="hidden" value="${list[0].parentProductName }(${list[0].productName }) ???${fn:length(list)}">
									</c:if>
									<c:if test="${fn:length(list) == 1}">
										<input id="pay-name" type="hidden" value="${list[0].parentProductName }(${list[0].productName })">
									</c:if>
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h3 class="accordion-header discount-info" id="panelsStayOpen-headingTwo">
								<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="true" aria-controls="panelsStayOpen-collapseTwo"><strong>?????? ?????? ??????</strong></button>
							</h3>
							<!-- ?????? ?????? Modal -->
							<div class="modal fade" id="couponModal" aria-labelledby="couponModalLabel" tabindex="-1">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="couponModalLabel">?????? ??????</h4>
											<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
												<i class="bi bi-x-lg"></i>
											</button>
										</div>
										<div class="modal-body">
											<div class="mycoupon-body">
												<!-- ????????? ?????? -->
												<div class="coupon-all" id="coupon-all">
													
												</div>
											</div>
											
										</div>
										<div class="modal-footer">
											<button class="btn btn-secondary" onclick="clearCoupon()">?????? ??????</button>
										</div>
									</div>
								</div>
							</div>
							<div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingTwo">
								<div class="accordion-body">
									<div class="coupon-point">
										<div class="row" style="padding: 10px;">
											<div class="col-md-2">?????? ??????</div>
											<div class="col-md-2 dis-coupon">
												<span class="dis-coupon-prc">?????? ??????</span>
											</div>
											<div class="col-md-4">
												<button class="orderPageBtn" id="getCoupon-btn" data-bs-toggle="modal" data-bs-target="#couponModal">??????/??????</button>
											</div>
										</div>
										<div class="row" style="padding: 10px;">
											<div class="col-md-2">?????? G.Point</div>
											<div class="col-md-2">
												<div class="input-group mb-3">
													<input type="number" class="form-control use-point" id="g-point" placeholder="G.Point" aria-describedby="basic-addon1" value=0>
												</div>
											</div>
										
											<div class="col-md-4" style="width: 90px;">
												<button class="orderPageBtn" id="point-cancel">????????????</button>
											</div>
											<div class="col-md-4 bp">
												[?????? G.Point: <fmt:formatNumber value="${point}" type="currency" currencySymbol="" />p]
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h3 class="accordion-header member-info" id="panelsStayOpen-headingThree">
								<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="true" aria-controls="panelsStayOpen-collapseThree"><strong>??????????????????</strong></button>
							</h3>
							<!-- ???????????? ?????? Modal -->
							<div class="modal fade" id="myModal" aria-labelledby="ModalLabel1" tabindex="-1">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="ModalLabel1">????????? ??????</h4>
											<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<div class="delivery-All-address">
												<c:if test="${empty addressList }">
													????????? ???????????? ????????????.
												</c:if>
												<c:forEach var="i" items="${addressList }" begin="0" step="1" varStatus="status">
													<div class="address-list-box">
														<div class="row">
															<div class="col-md-4 delivery-address-th">??????</div>
															<div class="col-md-4 delivery-address-td">
																<span class="delivery-address-name">${i.recipient }</span>
															</div>
															<c:if test="${i.isDefault == 1}">
																<div class="col-md-4">
																	<span class="delivery-address-alias">?????? ?????????</span>
																</div>
															</c:if>
														</div>
														<div class="row">
															<div class="col-md-4 delivery-address-th">????????? ??????</div>
															<div class="col-md-8 delivery-address-td">
																<span class="delivery-address-nickname">${i.nickName }</span>
															</div>
														</div>
														<div class="row">
															<div class="col-md-4 delivery-address-th">????????????</div>
															<div class="col-md-8 delivery-address-td address-post-num">${i.postCode }</div>
														</div>
														<div class="row">
															<div class="col-md-4 delivery-address-th">????????? ??????</div>
															<div class="col-md-8 delivery-address-td delivery-address-per">${i.address }</div>
														</div>
														<div class="row">
															<div class="col-md-4 delivery-address-th">?????? ??????</div>
															<div class="col-md-8 delivery-address-td delivery-address-detail">${i.detail }</div>
														</div>
														<div class="row">
															<div class="col-md-4 delivery-address-th delivery-phone-num-th">?????????</div>
															<div class="col-md-8 delivery-address-td delivery-phone-num-td">${i.contact }</div>
														</div>
													</div>
												</c:forEach>
											</div>
										</div>
										<div class="modal-footer">
											<button class="btn btn-secondary" data-bs-target="#deliveryAddressModal" data-bs-toggle="modal" data-bs-dismiss="modal">????????? ??????</button>
										</div>
									</div>
								</div>
							</div>
							
							<div class="modal fade" id="deliveryAddressModal" tabindex="-1">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
						                <div class="modal-header">
						                    <h5 class="modal-title"><b>????????? ??????</b></h5>
						                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						                </div>
						                <div class="modal-body" id="addressBody">
						                	<form>
							               		<div class="mb-1">
							               			<label for="recipient" class="col-form-label">?????? ???</label>
							               			<input type="text" class="form-control" id="recipient">
							              		</div>
							              		<div class="mb-1">
							                		<label for="nickName" class="col-form-label">????????? ??????</label>
							                		<input type="text" class="form-control" id="nickName">
							               		</div>
							              		<div class="mb-1">
							              			<div class="d-flex flex-row align-items-center mb-1">
							              				<label for="address" class="col-form-label me-1">????????? ??????</label>
							              				<button type="button" class="btn btn-sm btn-warning" onclick="getAddressByFindingPostCode()">???????????? ??????</button>
							              			</div>
							              		</div>
							              		<div>
							              			<input type="text" class="form-control mb-1" id="postCode" placeholder="????????????" disabled>
							              			<input type="text" class="form-control mb-1" id="address" placeholder="??????" disabled>
						              				<input type="text" class="form-control mb-1" id="detail" placeholder="????????????">
							             		</div>
							             		<div class="mb-1">
							             			<label for="contact" class="col-form-label">?????????</label>
							             			<input type="text" class="form-control" id="contact" maxlength="13" oninput="autoHyphen(this)">
							            		</div>
							            	</form>
						                </div>
						                <div class="modal-footer">
						                	<div class="col">
							                	<label for="isDefault" class="col-form-label">?????? ????????? ??????</label>
							           			<input type="checkbox" id="isDefault">
						                	</div>
						                    <button type="button" class="btn btn-dark" id="addAddressBtn">??????</button>
						                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">??????</button>
						                </div>
						            </div>
								</div>
							</div>
							<!-- /???????????? ?????? Modal -->
							
							<div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingThree">
								<div class="accordion-body address-info">
									<table class="delivery-address">
										<!-- ??????????????? ????????? ?????? ?????? -->
										<c:if test="${empty defaultAddress }">
											<div class="no-show-first">????????? ?????? ???????????? ????????????.</div>
											<tbody class="tbody-on" style="display:none">
												<tr>
													<th class="delivery-address-th" width="30%">??????</th>
													<td class="delivery-address-td">
														<span class="delivery-address-name" id="name">${defaultAddress.recipient }</span>
														<!-- ?????? ???????????? ?????? ???????????? ?????? -->
														<c:if test="${defaultAddress.isDefault == 0}">
															<span class="delivery-address-alias" id="addressAlias">???????????????</span>
														</c:if>
														<!-- /?????? ???????????? ?????? ???????????? ?????? -->
													</td>
												</tr>
												<tr>
													<th class="delivery-address-th">????????? ??????</th>
													<td class="delivery-address-td">
														<span class="delivery-address-nickname" id="addressNickName">${defaultAddress.nickName }</span>
													</td>
												</tr>
												<tr>
													<th class="delivery-address-th">????????????</th>
													<td class="delivery-address-td">
														<span class="delivery-address-postcode" id="addressPostcode">${defaultAddress.postCode }</span>
													</td>
												</tr>
												<tr>
													<th class="delivery-address-th">????????? ??????</th>
													<td class="delivery-address-td delivery-address-per" id="addressName">${defaultAddress.address }</td>
												</tr>
												<tr>
													<th class="delivery-address-th">?????? ??????</th>
													<td class="delivery-address-td delivery-address-detail" id="addressDetail">${defaultAddress.detail }</td>
												</tr>
												<tr>
													<th class="delivery-address-th delivery-phone-num-th">?????????</th>
													<td class="delivery-address-td delivery-phone-num-td" id="phonenumber">${defaultAddress.contact }</td>
												</tr>
												<!-- <tr>
													<th class="delivery-address-th delivery-requirement-th">????????????</th>
													<td class="delivery-address-td delivery-requirement-td" id="requirement"><input class="requirement-in" type="text" value="" id="requirement"></td>
												</tr> -->
												<tr>
													<td colspan="2">
														<div class="all-comment-box">
															<div class="custom-selectbox">
																<select class="form-select fs" name="comment">
																	<option value="">?????? ???????????? ??????????????????. (??????)</option>
																    <option value="?????? ??? ???????????? ???????????????.">?????? ??? ???????????? ???????????????.</option>
																    <option value="?????? ??? ???????????????.">?????? ??? ???????????????.</option>
																    <option value="?????? ??? ???????????????.">?????? ??? ???????????????.</option>
																    <option value="write">?????? ??????</option>
																</select>
															</div>
															<!-- ???????????? ????????? ?????? -->
						                                    <div class="commentbox" id="floatingTextcomment" style="display:none;">
						                                        
						                                        <textarea class="form-control commentarea" rows="5" placeholder="?????? ????????????" onkeyup="checkBytes(this, 100);"></textarea>
						                                        <div class="tc" style="margin-top: 8px;">
						                                        <span class="txtcount"><em id="cntnLen">0</em>/<b>100</b></span>
						                                        </div>
						                                    </div>
						                                    <!-- // ???????????? ????????? ?????? -->
				                                    	</div>
													</td>
												</tr>
											</tbody>
										</c:if>
										<!-- ?????????????????? ????????? ????????? ?????? ?????????/????????? ?????????????????? ????????? ?????? -->
										<c:if test="${not empty defaultAddress }">
											<tbody class="tbody-off">
												<tr>
													<th class="delivery-address-th" width="30%">??????</th>
													<td class="delivery-address-td">
														<span class="delivery-address-name" id="name">${defaultAddress.recipient }</span>
														<!-- ?????? ???????????? ?????? ???????????? ?????? -->
														<c:if test="${defaultAddress.isDefault == 0}">
															<span class="delivery-address-alias" id="addressAlias">???????????????</span>
														</c:if>
														<!-- /?????? ???????????? ?????? ???????????? ?????? -->
													</td>
												</tr>
												<tr>
													<th class="delivery-address-th">????????? ??????</th>
													<td class="delivery-address-td">
														<span class="delivery-address-nickname" id="addressNickName">${defaultAddress.nickName }</span>
													</td>
												</tr>
												<tr>
													<th class="delivery-address-th">????????????</th>
													<td class="delivery-address-td">
														<span class="delivery-address-postcode" id="addressPostcode">${defaultAddress.postCode }</span>
													</td>
												</tr>
												<tr>
													<th class="delivery-address-th">????????? ??????</th>
													<td class="delivery-address-td delivery-address-per" id="addressName">${defaultAddress.address }</td>
												</tr>
												<tr>
													<th class="delivery-address-th">?????? ??????</th>
													<td class="delivery-address-td delivery-address-detail" id="addressDetail">${defaultAddress.detail }</td>
												</tr>
												<tr>
													<th class="delivery-address-th delivery-phone-num-th">?????????</th>
													<td class="delivery-address-td delivery-phone-num-td" id="phonenumber">${defaultAddress.contact }</td>
												</tr>
												<tr>
													<td colspan="2">
														<div class="all-comment-box">
															<div class="custom-selectbox">
																<select class="form-select fs" name="comment">
																	<option value="">?????? ???????????? ??????????????????. (??????)</option>
																    <option value="?????? ??? ???????????? ???????????????.">?????? ??? ???????????? ???????????????.</option>
																    <option value="?????? ??? ???????????????.">?????? ??? ???????????????.</option>
																    <option value="?????? ??? ???????????????.">?????? ??? ???????????????.</option>
																    <option value="write">?????? ??????</option>
																</select>
															</div>
															<!-- ???????????? ????????? ?????? -->
						                                    <div class="commentbox" id="floatingTextcomment" style="display:none;">
						                                        
						                                        <textarea class="form-control commentarea" rows="5" placeholder="?????? ????????????" onkeyup="checkBytes(this, 100);"></textarea>
						                                        <div class="tc" style="margin-top: 8px;">
						                                        <span class="txtcount"><em id="cntnLen">0</em>/<b>100</b></span>
						                                        </div>
						                                    </div>
						                                    <!-- // ???????????? ????????? ?????? -->
				                                    	</div>
													</td>
												</tr>
											</tbody>
											
										</c:if>
									</table>
									
								</div>
							</div>
							<button type="button" class="btn-change-address orderPageBtn" id="btn-change-address" data-bs-toggle="modal" data-bs-target="#myModal">???????????????</button>
						</div>
						<div class="accordion-item">
							<h3 class="accordion-header select-pay-info" id="panelsStayOpen-headine">
								<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseFour" aria-expanded="true" aria-controls="panelsStayOpen-collapseFour"><strong>?????? ?????? ??????</strong></button>
							</h3>
							<div id="panelsStayOpen-collapseFour" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingFour">
								<div class="accordion-body">
									<table>
										<tr>
											<td class="pay-type">
												<div id="select-pay-type">
													<input type='radio' name='card-type' value='html5_inicis' id="cardRadio">
													<div style="display: inline-block;">
														<label for="cardRadio" class="insertImgCardRadio"></label>
														<div class="pt-txt" style="margin-bottom: 20px;">??????</div>
													</div>
													<input type='radio' name='card-type' value='kakaopay'id="kakaoRadio"/>
													<div style="display: inline-block;">
														<label for="kakaoRadio" class="insertImgKakaoRadio"></label>
														<div class="pt-txt" style="margin-bottom: 20px;">????????? ??????</div>
													</div>
													<input type='radio' name='card-type' value='nobank' id="vbankRadio"/>
													<div style="display: inline-block;">
														<label for="vbankRadio" class="insertImgVbankRadio"></label>
														<div class="pt-txt" style="margin-bottom: 20px;">????????? ??????</div>
													</div>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
						<form id="finOrder" action="${contextPath}/order/receipt" method="POST">
							<input type="hidden" id="csrfToken" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="hidden" id="ipUid" name="ipUid" value=""/>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="./footer.jsp" %>