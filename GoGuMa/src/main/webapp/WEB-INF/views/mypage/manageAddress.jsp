<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="_csrf" content="${_csrf.token}">
	<meta name="_csrf_header" content="${_csrf.headerName}">
	<title>Insert title here</title>
    <!-- bootstrap icon -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	<!-- bootstrap css -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
	<!-- bootstrap js -->
	<style>
        a {
            text-decoration: none;
        }
        a:link {
            color: black;
        }
        a:visited {
            color: black;
        }
        img {
            width: 70%;
            height: 70%;
            margin-top: 15%;
            margin-bottom: 15%;
        }
        .bundle {
            width: 25%;
            height: 25%;
        }
    </style>
</head>
<body>
	<div class="container mt-5" style="min-width: 1200px">
		<div class="row">
			<div class="col-3">
                <div class="mb-4">
                    <h3><a href="${contextPath}/mypage"><b>마이페이지</b></a></h3>
                </div>
                <div class="mb-4">
                    <div>
                        <h5><b>MY 쇼핑</b></h5>
                    </div>
                    <div>
                        <a href="${contextPath}/mypage/orderHistory">주문내역</a>
                    </div>
                </div>
                <div class="mb-4">
                    <div>
                        <h5><b>MY 혜택</b></h5>
                    </div>
                    <div>
                        <a href="${contextPath}/mypage/pointHistory/all?page=1">포인트</a>
                    </div>
                    <div >
                        예치금
                    </div>
                    <div>
                        <a href="${contextPath}/mypage/couponHistory">쿠폰</a>
                    </div>
                </div>
                <div class="mb-4">
                    <h5><b>MY 활동</b></h5>
                    <div>
                        내가 작성한 상품후기
                    </div>
                    <div>
                        작성 가능한 상품후기
                    </div>
                </div>
                <div>
                    <h5><b>MY 정보</b></h5>
                    <div>
                        회원정보변경
                    </div>
                    <div>
                        비밀번호변경
                    </div>
                    <div>
                        <a href="${contextPath}/mypage/manageAddress">배송지관리</a>
                    </div>
                    <div>
                        회원탈퇴
                    </div>
                </div>
			</div>
            <div class="col">
                <div>
                    <h5><b>👨‍💻 송진호님</b></h5>
                </div>
                <div class="d-flex flex-row justify-content-evenly border border-2 mb-3 rounded">
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
                            <a href="${contextPath}/mypage/pointHistory/all?page=1">포인트</a>
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
                            <a href="${contextPath}/mypage/couponHistory">쿠폰</a>
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
                <div class="mb-2">
                    <h5><b>배송지 관리</b></h5>
                </div>
                <div>
                    <h5>기본 배송지</h5>
                </div>
                <table class="table table-hover mb-3" style="margin: auto; text-align: center">
                    <thead class="table-secondary table-group-divider">
                        <tr>
                            <th>배송지 별칭</th>
                            <th>받는 분</th>
                            <th>배송지 주소</th>
                            <th>연락처</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <c:if test="${defaultAddress ne null}">
	                    <tbody>
	                        <tr>
	                            <td>${defaultAddress.nickName}</td>
	                            <td>${defaultAddress.recipient}</td>
	                            <td>${defaultAddress.address}</td>
	                            <td>${defaultAddress.contact}</td>
	                            <td><button type="button" id="${defaultAddress.addressId}" class="btn btn-outline-danger btn-sm" onClick="cancelDefault(this.id)">기본 배송지 해지</button></td>
	                        </tr>
	                    </tbody>
                    </c:if>
                </table>
                <div>
                    <h5>배송지 목록</h5>
                </div>
                <table class="table table-hover mb-2" style="margin: auto; text-align: center">
                    <thead class="table-secondary table-group-divider">
                        <tr>
                            <th><input type="checkbox" id="checkAll"></th>
                            <th>배송지 별칭</th>
                            <th>받는 분</th>
                            <th>배송지 주소</th>
                            <th>연락처</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <c:forEach var="addressDTO" items="${addressList}">
                    	<tbody>
                    		<tr>
                    			<td><input type="checkbox" name="check" value="${addressDTO.addressId}"></td>
                    			<td>${addressDTO.nickName}</td>
                    			<td>${addressDTO.recipient}</td>
                    			<td>${addressDTO.address}</td>
                    			<td>${addressDTO.contact}</td>
                    			<td>
	                                <button type="button" class="btn btn-outline-dark btn-sm" data-bs-toggle="modal" data-bs-target="#modal${addressDTO.addressId}">수정</button>
	                                <button type="button" class="btn btn-outline-dark btn-sm" onclick="deleteAddress(this)">삭제</button>
	                                <input type="hidden" value="${addressDTO.addressId}" />
	                            </td>
                    		</tr>
                    	</tbody>
                    	<div class="modal fade" id="modal${addressDTO.addressId}" tabindex="-1">
					        <div class="modal-dialog modal-dialog-centered">
					            <div class="modal-content">
					                <div class="modal-header">
					                    <h5 class="modal-title" id="exampleModalLabel"><b>배송지 수정</b></h5>
					                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					                </div>
					                <div class="modal-body" id="body${addressDTO.addressId}">
					                	<form>
						                	<div class="mb-1">
						                		<label for="nickName" class="col-form-label">배송지 별칭</label>
						                		<input type="text" class="form-control" id="nickName${addressDTO.addressId}" value="${addressDTO.nickName}">
						               		</div>
						               		<div class="mb-1">
						               			<label for="recipient" class="col-form-label">받는 분</label>
						               			<input type="text" class="form-control" id="recipient${addressDTO.addressId}" value="${addressDTO.recipient}">
						              		</div>
						              		<div class="mb-1">
						              			<label for="address" class="col-form-label">배송지 주소</label>
						              			<input type="text" class="form-control" id="address${addressDTO.addressId}" value="${addressDTO.address}">
						             		</div>
						             		<div class="mb-3">
						             			<label for="contact" class="col-form-label">연락처</label>
						             			<input type="text" class="form-control" id="contact${addressDTO.addressId}" value="${addressDTO.contact}">
						            		</div>
						            		<div class="">
						            			<label for="checkDefault" class="col-form-label">기본 배송지 설정</label>
						            			<c:choose>
						            				<c:when test="${addressDTO.isDefault eq 1 }">
						            					<input type="checkbox" id="isDefault${addressDTO.addressId}" checked>
						            				</c:when>
						            				<c:otherwise>
						            					<input type="checkbox" id="isDefault${addressDTO.addressId}">
					            					</c:otherwise>
						            			</c:choose>
						            		</div>
						            	</form>
					                </div>
					                <div class="modal-footer">
					                    <button type="button" class="btn btn-dark" onclick="updateAddress(this)">확인</button>
					                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
					                    <input type="hidden" value="${addressDTO.addressId}" />
					                </div>
					            </div>
					        </div>
					    </div>
                    </c:forEach>
                </table>
                <div class="row">
                	<div class="col" align="left">
                		<button type="button" id="setDefaultBtn" class="btn btn-primary btn-sm">기본 배송지 설정</button>
                	</div>
                	<div class="col" align="right">
	                    <button type="button" class="btn btn-dark btn-sm" data-bs-toggle="modal" data-bs-target="#deliveryAddressModal">배송지 등록</button>
	                    <button type="button" id="deleteAddressBtn" class="btn btn-danger btn-sm">선택 삭제</button>
	                </div>
                </div>
            </div>
		</div>
	</div>
    <div class="modal fade" id="deliveryAddressModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel"><b>배송지 등록</b></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div id="addressBody" class="modal-body">
                	<form>
	                	<div class="mb-1">
	                		<label for="nickName" class="col-form-label">배송지 별칭</label>
	                		<input type="text" class="form-control" id="nickName">
	               		</div>
	               		<div class="mb-1">
	               			<label for="recipient" class="col-form-label">받는 분</label>
	               			<input type="text" class="form-control" id="recipient">
	              		</div>
	              		<div class="mb-1">
	              			<label for="address" class="col-form-label">배송지 주소</label>
	              			<input type="text" class="form-control" id="address">
	             		</div>
	             		<div class="mb-3">
	             			<label for="contact" class="col-form-label">연락처</label>
	             			<input type="text" class="form-control" id="contact">
	            		</div>
	            		<div class="">
	            			<label for="checkDefault" class="col-form-label">기본 배송지 설정</label>
	            			<input type="checkbox" id="isDefault">
	            		</div>
	            	</form>
                </div>
                <div class="modal-footer">
                    <button type="button" id="addAddressBtn" class="btn btn-dark">확인</button>
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/dist/jquery.js' />"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	// 수정 버튼 이벤트
	function updateAddress(event) {
		let isDefault = 0;
		let addressId = $(event).siblings('input').val();
		if($('#isDefault'+addressId).prop('checked')) {
			isDefault = 1;
		}

		let token = $("meta[name='_csrf']").attr("content");
	    let header = $("meta[name='_csrf_header']").attr("content");
	    let data = {
	    	addressId : addressId,
    		nickName : $('#nickName'+addressId).val(),
			recipient : $('#recipient'+addressId).val(),
			address : $('#address'+addressId).val(),
			contact : $('#contact'+addressId).val(),
			isDefault : isDefault
	    }
	    
	    $.ajax({
	    	url : '${contextPath}/mypage/manageAddress/updateAddress',
	    	type : 'POST',
	    	data : JSON.stringify(data),
			contentType : 'application/json; charset=utf-8;',
			beforeSend : function(xhr) {
	            xhr.setRequestHeader(header, token);
	        },
	        success:function(result) {
	        	if(result==1) {
	        		alert('배송지 수정 완료');
	        		window.location.href = "${contextPath}/mypage/manageAddress";
	        	} else {
					alert('배송지 수정 오류');
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
	
	// 삭제 버튼 이벤트
	function deleteAddress(event) {
		let arr = new Array();
		arr.push(Number($(event).siblings('input').val()));
		let token = $("meta[name='_csrf']").attr("content");
	    let header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			url : '${contextPath}/mypage/manageAddress/deleteAddress',
			type : 'POST',
			data : JSON.stringify(arr),
			contentType : "application/json; charset=utf-8;",
			beforeSend : function(xhr) {
	            xhr.setRequestHeader(header, token);
	        },
			success:function(result) {
				if(result==1) {
					alert('배송지 삭제 완료');
					window.location.href = "${contextPath}/mypage/manageAddress";
				} else {
					alert('삭제 오류');
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
	
	// 기본 배송지 해지 버튼 이벤트
	function cancelDefault(addressId) {
		let token = $("meta[name='_csrf']").attr("content");
	    let header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({
			url : '${contextPath}/mypage/manageAddress/cancelDefault',
			type : 'POST',
			data : {
				addressId : addressId
			},
			beforeSend : function(xhr) {
	            xhr.setRequestHeader(header, token);
	        },
	        success:function(result) {
				if(result==1) {
					alert('기본배송지 해지 완료');
					window.location.href = "${contextPath}/mypage/manageAddress";
				} else {
					alert('기본배송지 해지 오류');
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
	
	$(document).ready(function() {
		// 기본 배송지 설정 이벤트
		$('#setDefaultBtn').on('click', function() {
			let checked = 0;
			let checkBoxArray = new Array();
			for(let i=0; i<$('input[name=check]').length; i++) {
				if($('input[name=check]').eq(i).prop('checked')) checked++;
			}
			if(checked==0) alert('기본 배송지로 설정할 배송지를 체크해주세요.');
			else if(checked>=2) alert('기본 배송지는 하나만 설정할 수 있습니다.');
			else {
				$("input[name=check]:checked").each(function() {
					let token = $("meta[name='_csrf']").attr("content");
				    let header = $("meta[name='_csrf_header']").attr("content");
					$.ajax({
						url : '${contextPath}/mypage/manageAddress/setDefault',
						type : 'POST',
						data : {
							addressId : $(this).val()
						},
						beforeSend : function(xhr) {
				            xhr.setRequestHeader(header, token);
				        },
				        success:function(result) {
				        	if(result==1) {
				        		alert('기본 배송지 설정 완료');
				        		window.location.href = "${contextPath}/mypage/manageAddress";
				        	} else {
								alert('삭제 오류');
							}
				        },
						error:function(xhr, status, error) {
		    				var errorResponse = JSON.parse(xhr.responseText);
		    				var errorCode = errorResponse.code;
		    				var message = errorResponse.message;
		    				alert(message);
		    			}
					});
				});
			}
		});
		
		// 배송지 등록 이벤트
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
				address : $('#addressBody').find('#address').val(),
				contact : $('#addressBody').find('#contact').val(),
				isDefault : isDefault
		    }
		    
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
		        		alert('배송지 추가 완료');
		        		window.location.href = "${contextPath}/mypage/manageAddress";
		        	} else {
						alert('배송지 추가 오류');
					}
		        },
				error:function(xhr, status, error) {
    				var errorResponse = JSON.parse(xhr.responseText);
    				var errorCode = errorResponse.code;
    				var message = errorResponse.message;
    				alert(message);
    			}
			});
		});
		
		// 선택 삭제 이벤트
		$('#deleteAddressBtn').on('click', function() {
			let checkBoxArray = new Array();
			for(let i=0; i<$('input[name=check]').length; i++) {
				if($('input[name=check]').eq(i).prop('checked')) {
					checkBoxArray.push(Number($('input[name=check]').eq(i).val()));
				}
			}
			
			if(checkBoxArray.length<1) alert('삭제하려는 배송지를 선택해주세요.');
			else {
				let token = $("meta[name='_csrf']").attr("content");
			    let header = $("meta[name='_csrf_header']").attr("content");
				$.ajax({ // checked된 checkbox의 value만 배열에 넣어서 전송
					url : '${contextPath}/mypage/manageAddress/deleteAddress',
					type : 'POST',
					data : JSON.stringify(checkBoxArray),
					contentType : "application/json; charset=utf-8;",
					beforeSend : function(xhr) {
			            xhr.setRequestHeader(header, token);
		            },
					success:function(result) {
						if(result==1) {
							alert('배송지 삭제 완료');
							window.location.href = "${contextPath}/mypage/manageAddress";
						} else {
							alert('삭제 오류');
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
		
		// 체크박스 전체 선택/해제 기능
		$('#checkAll').on('click', function() {
			if($('#checkAll').prop('checked')) $('input[name=check]').prop('checked', true);
			else $('input[name=check]').prop('checked', false);
		});
		
		// 모달 창 내용 초기화
		$('.modal').on('hidden.bs.modal', function(e) {
			$(this).find('form')[0].reset();
		});
	});
</script>
</html>