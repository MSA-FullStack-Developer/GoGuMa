<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://kit.fontawesome.com/985c0d22bf.js" crossorigin="anonymous"></script>

<head>
    <title>Product</title>
    
    <style>
    	<%@ include file="/resources/css/style.css" %>
    </style>
    
    <script>
 		// 가격 format() 함수
 		Number.prototype.format = function() {
	 		if(this==0) return 0;     
 			var reg = /(^[+-]?\d+)(\d{3})/;    
 			var n = (this + '');
 			
 			while (reg.test(n))
 				n = n.replace(reg, '$1' + ',' + '$2');     
 				
			return n;
		};
    
	    function selectOption(option) { // 옵션을 변경한 경우 구매 수량 초기화
	    	document.getElementById("numBox").value = 1;

	    	var optionName = $("#option option:selected").text(); // 옵션 상품 이름
	    	var optionID = $("#option option:selected").data("id"); // 옵션 상품 번호
	    	var optionPrice = $("#option option:selected").data("price"); // 옵션 상품 가격
	    	
	    	$('.selectedOption').text(optionName);
	    	$('.total_price').text(optionPrice.format() + "원"); // 초기화
	    }
	    
        $(document).ready(function () {
			var searchForm = $("#searchForm");
        	
        	$('#searchBtn').on("click", function() {
        		if(!searchForm.find("#keyword").val()){
        			alert("검색 내용을 입력하세요.");
        		}
        		
        		e.preventDefault();
        		searchForm.submit();
        	});
        	
            $("#plus").click(function () {
                var num = $("#numBox").val();
                var plusNum = Number(num) + 1;
                
    	    	var optionName = $("#option option:selected").text(); // 옵션 상품 이름
                var stock = $("#option option:selected").val(); // 선택한 옵션의 최대 수량까지 증가 가능
                var optionPrice = $("#option option:selected").data("price"); // 옵션 상품 가격
                
                if (optionName != "선택 없음") {
	                if(plusNum > stock) {
	                	$("#numBox").val(num);
	                	$('.total_price').text((optionPrice * num).format() + "원");
	                } else {
	                	$("#numBox").val(plusNum);        
	                	$('.total_price').text((optionPrice * plusNum).format() + "원");
	                }
                }
            });

            $("#minus").click(function () {
                var num = $("#numBox").val();
                var minusNum = Number(num) - 1;

    	    	var optionName = $("#option option:selected").text(); // 옵션 상품 이름
            	var optionPrice = $("#option option:selected").data("price"); // 옵션 상품 가격
				
            	if (optionName != "선택 없음") {
            		if (minusNum <= 0) {
                        $("#numBox").val(num);
                        $('.total_price').text((optionPrice * num).format() + "원");
                    } else {
                        $("#numBox").val(minusNum);
                        $('.total_price').text((optionPrice * minusNum).format() + "원");
                    }
            	}
            });

            $(function () {
                $('.tabcontent > div').hide();
                $('.tabnav a').click(function () {
                    $('.tabcontent > div').hide().filter(this.hash).fadeIn();
                    $('.tabnav a').removeClass('active');
                    $(this).addClass('active');
                    return false;
                }).filter(':eq(0)').click();
            });

            $(function () {
                // 이미지 클릭시 해당 이미지 모달
                $(".imgC").click(function () {
                    $(".modal").show();
                    // 해당 이미지 가겨오기
                    var imgSrc = $(this).children("img").attr("src");
                    var imgAlt = $(this).children("img").attr("alt");
                    $(".modalBox img").attr("src", imgSrc);
                    $(".modalBox img").attr("alt", imgAlt);

                    // 해당 이미지 텍스트 가져오기
                    var imgTit = $(this).children("p").text();
                    $(".modalBox p").text(imgTit);

                    // 해당 이미지에 alt값을 가져와 제목으로
                    // $(".modalBox p").text(imgAlt);
                });

                $(".write-modal").hide();

                // .modal안에 button을 클릭하면 .modal닫기
                $(".modal button").click(function () {
                    $(".modal").hide();
                });

                // .modal밖에 클릭시 닫힘
                $(".modal").click(function (e) {
                    if (e.target.className != "modal") {
                        return false;
                    } else {
                        $(".modal").hide();
                    }
                });

                $(".writeBtn").click(function () {
                    $(".write-modal").show();
                });

                // .modal안에 button을 클릭하면 .modal닫기
                $(".write-modal button").click(function () {
                    $(".write-modal").hide();
                });

                // .modal밖에 클릭시 닫힘
                $(".write-modal").click(function (e) {
                    if (e.target.className != "write-modal") {
                        return false;
                    } else {
                        $(".write-modal").hide();
                    }
                });
            });
            
            $('#cartBtn').on("click", function() {
            	var optionName = $("#option option:selected").text(); // 옵션 상품 이름
            	
            	if (optionName != "선택 없음") {
	            	var token = $("meta[name='_csrf']").attr("content");
	        		var header = $("meta[name='_csrf_header']").attr("content");
	
	                var optionID = $("#option option:selected").data("id");
	                var cartAmount = $("#numBox").val();
	                
	        		var data = {
	        			"productId" : optionID,
	        			"cartAmount" : cartAmount
	        		};
	        		$.ajax({
	        			type : "POST",
	        			url : "${contextPath}/cart/insertCart",
	        			data : data,
	        			beforeSend : function(xhr) {
	        				xhr.setRequestHeader(header, token);
	        			},
	        			success : function(result) {
	        				if(result){
	        					alert("장바구니에 상품이 담겼습니다.");
	        				}else{
	        					alert("로그인 후 이용가능합니다.")
	        				}
	        				
	        			},
	        			error : function(xhr, status, error) {
	        				var errorResponse = JSON.parse(xhr.responseText);
	        				var errorCode = errorResponse.code;
	        				var message = errorResponse.message;
	
	        				alert(message);
	        			}
	        		});
            	}
        	});
            
            $('#buyBtn').on("click", function() {
            	alert("바로구매 버튼");
            });
        });
    </script>
</head>

<body>
	<%@ include file="header.jsp" %>
	
	<div class="prodlist">
        <h1 style="text-align: center">${categoryName}</h1>

        <hr>

        <div class="prodInfo">
            <img class="thumbnailImg" src="${productInfo.prodimgurl}" style="float: left;" />
            <div class="product_detail">
                <table>
                	<tr>
	                    <td colspan='2'>
	                        <h1>${productInfo.productName}</h1>
	                    </td>
                    </tr>
                    <tr>
                    	<td width="30%">가격</td>
                    	<td width="70%">
                            <h2><fmt:formatNumber value="${productInfo.productPrice}" pattern="#,###" />원</h2>
                        </td>
                    </tr>
                    <tr>
                        <td>제조회사</td>
                        <td>${productInfo.company}</td>
                    </tr>
                    <c:if test="${optionCount > 0}">
	                    <tr>
	                        <td>옵션</td>
	                        <td>
	                        	<div class="selectbox">
		                            <select class="option" id="option" name="option" style="float: left;" onchange="javascript:selectOption(this.options[this.selectedIndex].value);">
		                            	<option value="" data-price="${productInfo.productPrice}">선택 없음</option>
		                            	<c:forEach items="${option}" var="option">
		                                	<option value="${option.stock}" 
		                                			data-id="${option.productID}" 
		                                			data-price="${option.productPrice}">
		                                			${option.productName}
                                			</option>
		                                </c:forEach>
		                            </select>
	                            </div>
	                        </td>
	                    </tr>
                    </c:if>
                    <tr>
                    	<td><strong>상품금액 합계</strong></td>
                    	<td>
                    		<h1 class="total_price">
                    			<fmt:formatNumber value="${productInfo.productPrice}" pattern="#,###" />원
                   			</h1>
                    	</td>
                    </tr>
                </table>
                
                <div class="selectedInfo">
                	<h5 class="selectedOption">선택 없음</h5>
                	<p class="cartStock">
                        <button type="button" class="calc" id="minus">-</button>
                        <span style="text-align: center;">
                        	<input type="number" id="numBox" min="1" max="${productInfo.stock}" value="1" readonly="readonly" />
                        </span>
                        <button type="button" class="calc" id="plus">+</button>
                     </p>
                </div>
                
                <div class="btnDiv">
                	<button class="cartBtn" id="cartBtn">장바구니</button>
                       <button class="buyBtn" id="buyBtn">바로구매</button>
                </div>
            </div>
        </div>
        
        <div class="tab">
        	<div class="tabBtns">
	            <ul class="tabnav">
	                <li class="bottom-menu"><a href="#tab01">상품상세</a></li>
	                <li class="bottom-menu"><a href="#tab02">상품평</a></li>
	            </ul>
            </div>
            <div class="tabcontent">
                <div id="tab01">
                    <img class="productDetail" src="${productInfo.productDetail}">
                </div>
                <div id="tab02">
                    <!-- 상품평 -->
                    <div>
                        <button class="writeBtn" id="writeBtn">상품평 작성하기</button>
                    </div>
                    
                    <div class="write-modal">
                        <h4 class="membername">회원 이름</h4>
                        <p><input class="review-content" placeholder="상품평을 입력하세요.">
                            <button class="finishBtn" id="finishBtn">작성 완료</button>
                            <button class="cancleBtn" id="cancleBtn" style="color: black">취소</button>
                    </div>
                    
                    <div class="review" id="review">
                        <div>
                            <p>
                            <h4>회원 이름<i style="font-size: 8pt; margin-left: 10px;">작성일</i></h4>
                            <h5>[부모상품ID] 상품ID</h5>
                            <h3>상품평 내용</h3>
                            <div class="imgList">
                                <div class="imgC">
                                    <img class="reviewImg" src="https://image.hmall.com/static/0/6/89/33/2133896030_0.jpg?RS=400x400&AR=0"
                                        alt="모달할 이미지">
                                </div>
                                <div class="imgC">
                                    <img class="reviewImg" src="https://image.hmall.com/static/0/6/89/33/2133896030_0.jpg?RS=400x400&AR=0"
                                        alt="모달할 이미지">
                                </div>
                                <div class="imgC">
                                    <img class="reviewImg" src="https://image.hmall.com/static/0/6/89/33/2133896030_0.jpg?RS=400x400&AR=0"
                                        alt="모달할 이미지">
                                </div>
                            </div>

                            <!-- 팝업 될 곳 -->
                            <div class="modal">
                                <button>&times;</button>
                                <div class="modalBox">
                                    <img src="" alt="">
                                </div>
                            </div>
                        </div>
                        <hr>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>