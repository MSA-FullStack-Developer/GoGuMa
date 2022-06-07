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
	<title>My Review</title>
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
			$('#deleteBtn').on("click", function() { // 상품평 삭제
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				
				var reviewID = $("#reviewID").val(); // 삭제할 상품 번호
			    
				var data = {
					"reviewID" : reviewID
				};
				
				if (confirm("상품평을 삭제하시겠습니까?")) {
            		$.ajax({
        	            url: "${contextPath}/category/1/deleteReview",
        	            type: "POST",
        	            data: data,
        	            beforeSend : function(xhr) {
            				xhr.setRequestHeader(header, token);
            			},
        	            success : function(result){
        	            	if (result) {
        	            		alert("상품평이 삭제되었습니다.");
        		                location.reload();
        	            	}
        	            },error : function(xhr, status, error) {
            				var errorResponse = JSON.parse(xhr.responseText);
            				var errorCode = errorResponse.code;
            				var message = errorResponse.message;
            				alert(message);
            			}
        	        });	
        		} else {
        			return;
        		}
			});
		});
	</script>
</head>
<body>
	<%@ include file="../header.jsp" %>
	
	<div class="container mt-5" style="min-width: 1200px">
		<div class="row">
			<%@ include file="mypageMenu.jsp" %>
            <div class="col" style="width: 900px;">
                <div class="col">
                    <h5><b>👨‍💻 ${memberDTO.name}님</b></h5>
                </div>
                <div class="d-flex flex-row justify-content-evenly border border-2 rounded mb-2">
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            회원등급
                        </div>
                        <div>
                            💎
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            포인트
                        </div>
                        <div>
                            1,000P
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            예치금
                        </div>
                        <div>
                            10,000원
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            쿠폰
                        </div>
                        <div>
                            3장
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            작성 가능한 상품평
                        </div>
                        <div>
                            5건
                        </div>
                    </div>
                </div>
                <div class="col mt-3">
                    <h5><b>내가 작성한 상품평</b></h5>
                </div>
                <div class="d-flex flex-column">
                    <c:forEach items="${reviewList}" var="review">
                    <div class="myReview">
	                    <div style="width: 100%; margin-bottom: 10px;">
	               		 		<div class="myReviewTop">
		               		 		<a href="${contextPath}/category/1/${review.categoryID}/detail/${review.productID}">
		               		 			<input type="hidden" id="reviewID" name="${review.reviewID}" value="${review.reviewID}">
										<img class="myReviewImg" src="${review.prodThumbNail}" alt="${review.prodThumbNail}">
			                            <span class="myReviewProduct" style="font-size: 14pt; font-weight: bold;">${review.productName}</span><br>
			                            <span class="myReviewProduct">${review.optionName}</span>
		               		 		</a>
	               		 		</div>
	             		 	<hr>
	             		 		<div class="myReviewBottom">
		                            <h6 class="review-create-date">
		                            	<fmt:formatDate value="${review.createDate}" pattern="yyyy-MM-dd" />
		                            	<br>
	                            		<p class="review-content">${review.content}</p>
	                            	</h6>
	               		 			<button type="button" class="deleteBtn" id="deleteBtn"><i class="fa-solid fa-x"></i></button>
		                            <c:forEach items="${review.attachList}" var="attach" varStatus="i">
		                                <c:if test="${i.first}"><img class="myReviewMemeberImg" src="${attach.imagePath}" alt="${attach.imagePath}"></c:if>
		                            </c:forEach>
	                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
            </div>
		</div>
	</div>
     <%@ include file="../footer.jsp" %>
</body>
</html>