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
<head>
	<meta charset="utf-8">
	<title>고구마 - 고객과 구성하는 마켓</title>
    <!-- bootstrap icon -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	<!-- bootstrap css -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
	<!-- bootstrap js -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
	<style>
		<%@ include file="/resources/css/myreview.css" %>
		
        a {
            text-decoration: none;
        }
        a:link {
            color: black;
        }
        a:visited {
            color: black;
        }
	    .bundle {
	        width: 25%;
	        height: 25%;
	    }
	</style>
	<script>
		$(document).ready(function () {
			function show () {
				document.querySelector(".modal-background").className = "modal-background show";
			}
	
			function close () { 
				document.querySelector(".modal-background").className = "modal-background";
			}
			
            $(document).on("click", "#show", function(){
                var productID = $(this).data("productid"); // 구매한 상품 번호
				var thumbnailImg = $(this).data("imgurl"); // 상품 썸네일 이미지
				$("#productID").val(productID);
				$("#thumbnailImg").val(thumbnailImg);
			    show();
            });
			
			document.querySelector(".cancelBtn").addEventListener('click', close); // 모달창 닫기
			
			$('#finishBtn').on("click", function() { // 상품평 작성하기
            	var token = $("meta[name='_csrf']").attr("content");
        		var header = $("meta[name='_csrf_header']").attr("content");
        		
            	var productID = $("#productID").val(); // 구매한 상품 번호
                var memberID = $("#memberID").val(); // 로그인한 회원 번호
               	var content = $(".write-review-content").val(); // 상품평 내용
               	var prodThumbNail = $("#thumbnailImg").val(); // 상품 썸네일 이미지
               	var list = new Array();
               	
               	if (content != "") {
               		$(".uploadResult ul li").each(function(i, obj) {
            			var jobj = $(obj);
            			
            			var attachDTO = new Object();
            			attachDTO.imageName = jobj.data("imagename");
            			attachDTO.imagePath = jobj.data("imagepath");
            			list.push(attachDTO);
            		});
                   	
            		var data = {
            			productID : productID,
            			memberID : memberID,
            			content : content,
            			prodThumbNail : prodThumbNail,
            			attachList : list
            		};
            		
            		$.ajax({
    		            url: "${contextPath}/category/1/api/insertReview",
    		            type: "POST",
    		            contentType: 'application/json; charset=utf-8',
    		            data: JSON.stringify(data),
    		            beforeSend : function(xhr) {
            				xhr.setRequestHeader(header, token);
            			},
    		            success : function(result){
    		            	if (result == 1) {
    			                $(".modal").hide();
    			                alert("상품평이 등록되었습니다.");
    			                location.reload();
    		            	} else {
    		            		alert("상품평 등록 실패");
    		            	}
    		            },error : function(xhr, status, error) {
            				var errorResponse = JSON.parse(xhr.responseText);
            				var errorCode = errorResponse.code;
            				var message = errorResponse.message;
            				alert(message);
            			}
    		        });
               	} else {
               		alert("상품평을 작성해주세요.");
               	}
        	});
            
			$(".uploadResult").on("click", "button", function(e) {
            	var token = $("meta[name='_csrf']").attr("content");
        		var header = $("meta[name='_csrf_header']").attr("content");
        		
        		console.log("delete file");
        		var targetFile = $(this).data("imagename");
        		var targetLi = $(this).closest("li");
        		
        		var data = {
        			imageName : targetFile
        		};
        		
        		$.ajax({
        			url: '${contextPath}/category/1/deleteFile',
        			data: data,
        			type: 'POST',
        			beforeSend : function(xhr) {
        				xhr.setRequestHeader(header, token);
        			},
       				success: function(result) {
       					alert("이미지가 삭제되었습니다.");
       					$("#file").val(""); // 초기화
       					targetLi.remove();
       				},error : function(xhr, status, error) {
        				var errorResponse = JSON.parse(xhr.responseText);
        				var errorCode = errorResponse.code;
        				var message = errorResponse.message;
        				alert(message);
        			}
        		});
        	});
        	
        	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        	var maxSize = 5242880;
        	
        	function checkExtension(fileName, fileSize){
        		if(fileSize >= maxSize){
        			alert("파일 사이즈 초과");
        			return false;
        		}
        		if(regex.test(fileName)){
        			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
        			return false;
        		}
        		return true;
        	}
        	
        	function showUploadResult(uploadResultArr) {
        		if(!uploadResultArr || uploadResultArr.length == 0) {return;}
        		
        		var uploadUL = $(".uploadResult ul");
        		
        		var str="";
        		
        		$(uploadResultArr).each(function(i, obj){
        			str += "<li data-imagepath='"+obj.imagePath+"'";
    				str += " data-imagename='"+obj.imageName+"' ><div>";
    				str += "<span>"+obj.imageName+"</span>";
    				str += "<button class='imgDeleteBtn' type='button' data-imagename='"+obj.imageName+"'>X</button><br>";
    				str += "<img src='" + obj.imagePath + "'>";
    				str += "</div>";
    				str += "</li>";
        		}); 
        		
        		uploadUL.append(str);
        	}
        	
        	$("input[type='file']").change(function(e){
        		var token = $("meta[name='_csrf']").attr("content");
        		var header = $("meta[name='_csrf_header']").attr("content");
        		
        		var formData = new FormData();
        		var inputFile = $("input[name='uploadFile']");
        		var files = inputFile[0].files;
        		console.log(files);
        		
        		for(var i = 0; i < files.length ; i++){
        			if(!checkExtension(files[i].imageName, files[i].size)){
        				return false;
        			}
        			formData.append("uploadFile", files[i]);
        		}
        	
        		$.ajax({
        			url: '${contextPath}/category/1/uploadAjaxAction',
        			processData: false,
        			contentType: false,
        			data: formData,
        			beforeSend : function(xhr) {
        				xhr.setRequestHeader(header, token);
        			},
        			type: 'POST',
        			dataType: 'json',
       				success: function(result){
       					console.log(result);
        				
       					attachList = result;
       					
        				showUploadResult(result);
        			}, error : function(xhr, status, error) {
        				var errorResponse = JSON.parse(xhr.responseText);
        				var errorCode = errorResponse.code;
        				var message = errorResponse.message;
        				alert(message);
        			}
        		});
        	});
		});
	</script>
</head>
<body>
	<%@ include file="../header.jsp" %>
	
	<div class="container mt-5" style="min-width: 1200px;">
		<div class="row">
			<%@ include file="mypageMenu.jsp" %>
            <div class="col" style="width: 900px;">
                <div class="d-flex flex-row justify-content-evenly border border-2 rounded p-3 mb-3">
                    <div class="d-flex flex-row align-items-center">
                        <div class="me-2">
                        	<a href="${contextPath}/mypage/membershipZone">
                        		<img src="https://image.hmall.com/p/img/mp/icon/ico-rating-gold.png" style="width: 50px; height: 50px; object-fit: contain;">
                        	</a>
                        </div>
                        <div class="lh-sm" align="center">
                            <div>
                                <a href="${contextPath}/mypage/confirmPassword/changeInfo" style="font-size: 20px">
                                	<b>${memberDTO.name}님</b>
                                </a>
                            </div>
                            <div>
                                <a href="${contextPath}/mypage/membershipZone" style="font-size: 16px">Gold</a>
                            </div>  
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center align-self-center lh-sm">
                        <div>
                            <a href="${contextPath}/mypage/pointHistory/all?page=1">포인트</a>
                        </div>
                        <div>
                            <a href="${contextPath}/mypage/pointHistory/all?page=1">
                            	<fmt:formatNumber value="${memberPoint}"/>P
                            </a>
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center align-self-center lh-sm">
                        <div>
                            <a href="${contextPath}/mypage/couponHistory/available?page=1">쿠폰</a>
                        </div>
                        <div>
                            <a href="${contextPath}/mypage/couponHistory/available?page=1">${couponCount}장</a>
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center align-self-center lh-sm">
                        <div>
                            <a href="${contextPath}/mypage/writeableReview">작성 가능한 상품평</a>
                        </div>
                        <div>
                            <a href="${contextPath}/mypage/writeableReview">${writeableCount}건</a>
                        </div>
                    </div>
                </div>
                <div class="col mt-3">
                    <h5><b>작성 가능한 상품평</b></h5>
                </div>
                <div class="d-flex flex-wrap">
                	<c:if test='${writeableList.size() < 1}'>
   						<div style="text-align: center; margin: 0 auto;">
	   						<img class="no-review-img" src="https://image.hmall.com/p/img/co/icon/ico-nodata-type12-1x.svg" />
	   						<h5 class="no_result">작성 가능한 상품평이 없습니다.</h5>
	   						<span style="font-size: 11pt; color: #ccc;">[마이페이지 > 주문내역]에서 구매확정시 작성하실 수 있습니다.</span>
   						</div>
					</c:if>
                
                    <c:forEach items="${writeableList}" var="product">
                    <div class="myReview-writeable">
	                    <div style="width: 100%; margin-bottom: 10px;">
               		 		<div class="myReviewTop">
               		 			<div class="text-truncate" style="width: 370px;">
		               		 		<a class="productlink" href="${contextPath}/category/1/${product.categoryID}/detail/${product.parentPID}">
										<img class="myReviewImg" src="${product.prodimgurl}" alt="${product.prodimgurl}">
			                            <span class="myReviewProduct" style="font-size: 14pt; font-weight: bold;">${product.productName}</span>
			                            <br>
			                            <span class="myReviewProduct">${product.optionName}</span>
		               		 		</a>
	               		 		</div>
	               		 		<button class="show" id="show" data-productid="${product.productID}" data-imgurl="${product.prodimgurl}">작성</button>
               		 		</div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
				<div class="modal-background">
					<div class="modal-window">
						<div class="popup">
	                        <h4 class="membername"><i class="fa-solid fa-heart" style="color: FF493C"></i>
	                        	<b>${memberDTO.name}</b>님, 이번 상품은 어떠셨나요?
	                        	<input type="hidden" id="productID" value="">
	                        	<input type="hidden" id="thumbnailImg" value="">
	                       	</h4>
	                       	<textarea cols="34" rows="5" type="text" class="write-review-content" placeholder="상품평을 작성해주세요. (최대 2,000자)"></textarea>
	                       	<input type="file" class="form-control form-control-sm" id="file" name='uploadFile' style="margin-left: 30px; width: 20%;" multiple>
	                       	<div class='uploadResult'>
								<ul>
								</ul>
							</div>	
                       		<div class="review-buttons">
	                            <button type="button" class="cancelBtn" id="cancelBtn">취소</button>
	                            <button type="button" class="finishBtn" id="finishBtn">작성 완료</button>
                           </div>
						</div>
					</div>
				</div>
			</div>
 	 	</div>
	 </div>
     <%@ include file="../footer.jsp" %>
</body>
</html>