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
        table tbody tr {
            line-height: 2rem;
            table-layout: fixed;
            word-break: keep-all;
        }
    </style>
</head>
<body>
	<%@ include file="../header.jsp" %>
	<div class="container mt-5" style="min-width: 1200px">
		<div class="row">
			<%@ include file="mypageMenu.jsp" %>
            <div class="col">
                <div>
                    <h4><b>${memberDTO.name}님</b></h4>
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
                            <a href="${contextPath}/mypage/pointHistory/all?page=1">
                            	<fmt:formatNumber value="${memberPoint}"/>P
                            </a>
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            <a href="${contextPath}/mypage/couponHistory/available?page=1">쿠폰</a>
                        </div>
                        <div>
                            <a href="${contextPath}/mypage/couponHistory/available?page=1">${couponCount}장</a>
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center mt-3 mb-3">
                        <div>
                            <a href="${contextPath}/mypage/writeableReview">작성 가능한 상품평</a>
                        </div>
                        <div>
                            <a href="${contextPath}/mypage/writeableReview">${writeableCount}건</a>
                        </div>
                    </div>
                </div>
                <div class="mb-2">
                    <h5><b>배송지 관리</b></h5>
                </div>
                <div>
                    <h5>기본 배송지</h5>
                </div>
                <table class="table mb-3" style="margin: auto; text-align: center">
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
	                            <td>${defaultAddress.address} ${defaultAddress.detail}</td>
	                            <td>${defaultAddress.contact}</td>
	                            <td><button type="button" id="${defaultAddress.addressId}" class="btn btn-outline-danger btn-sm" onClick="cancelDefault(this.id)">기본 배송지 해지</button></td>
	                        </tr>
	                    </tbody>
                    </c:if>
                </table>
                <div>
                    <h5>배송지 목록</h5>
                </div>
                <table class="table mb-2" style="margin: auto; text-align: center">
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
                    			<td>${addressDTO.address} ${addressDTO.detail}</td>
                    			<td>${addressDTO.contact}</td>
                    			<td>
	                                <button type="button" class="btn btn-outline-dark btn-sm" data-bs-toggle="modal" data-bs-target="#modal-${addressDTO.addressId}">수정</button>
	                                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="deleteAddress(${addressDTO.addressId})">삭제</button>
	                            </td>
                    		</tr>
                    	</tbody>
                    	<div class="modal fade" id="modal-${addressDTO.addressId}" tabindex="-1">
					        <div class="modal-dialog modal-dialog-centered">
					            <div class="modal-content">
					                <div class="modal-header">
					                    <h5 class="modal-title"><b>배송지 수정</b></h5>
					                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					                </div>
					                <div class="modal-body" id="addressBody-${addressDTO.addressId}">
					                	<form>
						                	<div class="mb-1">
						                		<label for="nickName-${addressDTO.addressId}" class="col-form-label">배송지 별칭</label>
						                		<input type="text" class="form-control" id="nickName-${addressDTO.addressId}" value="${addressDTO.nickName}">
						               		</div>
						               		<div class="mb-1">
						               			<label for="recipient-${addressDTO.addressId}" class="col-form-label">받는 분</label>
						               			<input type="text" class="form-control" id="recipient-${addressDTO.addressId}" value="${addressDTO.recipient}">
						              		</div>
						             		<div class="mb-1">
						              			<div class="d-flex flex-row align-items-center mb-1">
						              				<label for="address" class="col-form-label me-1">배송지 주소</label>
						              				<button type="button" class="btn btn-sm btn-warning" onclick="updateAddressByFindingPostCode(${addressDTO.addressId})">우편번호 찾기</button>
						              			</div>
						              		</div>
						             		<div>
						              			<input type="text" class="form-control mb-1" id="postCode-${addressDTO.addressId}" placeholder="우편번호" value="${addressDTO.postCode}" disabled>
						              			<input type="text" class="form-control mb-1" id="address-${addressDTO.addressId}" placeholder="주소" value="${addressDTO.address}" disabled>
					              				<input type="text" class="form-control mb-1" id="detail-${addressDTO.addressId}" placeholder="상세주소" value="${addressDTO.detail}">
						             		</div>
						             		<div class="mb-3">
						             			<label for="contact" class="col-form-label">연락처</label>
						             			<input type="text" class="form-control" id="contact-${addressDTO.addressId}" value="${addressDTO.contact}">
						            		</div>
						            	</form>
					                </div>
					                <div class="modal-footer">
					                	<div class="col">
					            			<label for="checkDefault" class="col-form-label">기본 배송지 설정</label>
					            			<c:choose>
					            				<c:when test="${addressDTO.isDefault eq 1 }">
					            					<input type="checkbox" id="isDefault-${addressDTO.addressId}" checked>
					            				</c:when>
					            				<c:otherwise>
					            					<input type="checkbox" id="isDefault-${addressDTO.addressId}">
				            					</c:otherwise>
					            			</c:choose>
					            		</div>
					                    <button type="button" class="btn btn-dark" onclick="updateAddress(${addressDTO.addressId})">수정</button>
					                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
					                </div>
					            </div>
					        </div>
					    </div>
                    </c:forEach>
                </table>
                <div class="row">
                	<div class="col" align="left">
                		<button type="button" class="btn btn-primary btn-sm" onclick="setDefaultAddress()">기본 배송지 설정</button>
                	</div>
                	<div class="col" align="right">
	                    <button type="button" class="btn btn-dark btn-sm" data-bs-toggle="modal" data-bs-target="#deliveryAddressModal">배송지 등록</button>
	                    <button type="button" class="btn btn-danger btn-sm" onclick="optionalDeletion()">선택 삭제</button>
	                </div>
                </div>
            </div>
		</div>
	</div>
    <div class="modal fade" id="deliveryAddressModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><b>배송지 등록</b></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="addressBody">
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
	              			<div class="d-flex flex-row align-items-center mb-1">
	              				<label for="address" class="col-form-label me-1">배송지 주소</label>
	              				<button type="button" class="btn btn-sm btn-warning" onclick="getAddressByFindingPostCode()">우편번호 찾기</button>
	              			</div>
	              		</div>
	              		<div>
	              			<input type="text" class="form-control mb-1" id="postCode" placeholder="우편번호" disabled>
	              			<input type="text" class="form-control mb-1" id="address" placeholder="주소" disabled>
              				<input type="text" class="form-control mb-1" id="detail" placeholder="상세주소">
	             		</div>
	             		<div class="mb-1">
	             			<label for="contact" class="col-form-label">연락처</label>
	             			<input type="text" class="form-control" id="contact" maxlength="13" oninput="autoHyphen(this)">
	            		</div>
	            	</form>
                </div>
                <div class="modal-footer">
                	<div class="col">
	                	<label for="isDefault" class="col-form-label">기본 배송지 설정</label>
	           			<input type="checkbox" id="isDefault">
                	</div>
                    <button type="button" class="btn btn-dark" onclick="addAddress()">확인</button>
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/dist/jquery.js' />"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	const autoHyphen = (target) => {
		target.value = target.value
		   .replace(/[^0-9]/g, '')
		   .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	}
	
	function getAddressByFindingPostCode() {
		new daum.Postcode({
			oncomplete: function(data) {
				// 각 주소의 노출 규칙에 따라서 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우에는 공백('')을 값으로 가진다.
				let addr = ""; // 주소 변수
				let extra = ""; // 참고 항목
				
				// 사용자가 도로명 주소를 선택한 경우
				if(data.userSelectedType === 'R') {
					addr = data.roadAddress;
				}
				// 사용자가 지번 주소를 선택한 경우
				else {
					addr = data.jibunAddress;
				}
				
				document.getElementById("postCode").value = data.zonecode;
				document.getElementById("address").value = addr;
				document.getElementById("detail").focus();
			}
		}).open();
	}
	
	function updateAddressByFindingPostCode(addressId) {
		new daum.Postcode({
			oncomplete: function(data) {
				// 각 주소의 노출 규칙에 따라서 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우에는 공백('')을 값으로 가진다.
				let addr = ""; // 주소 변수
				let extra = ""; // 참고 항목
				
				// 사용자가 도로명 주소를 선택한 경우
				if(data.userSelectedType === 'R') {
					addr = data.roadAddress;
				}
				// 사용자가 지번 주소를 선택한 경우
				else {
					addr = data.jibunAddress;
				}
				
				document.getElementById("postCode-"+addressId).value = data.zonecode;
				document.getElementById("address-"+addressId).value = addr;
				$("#detail-"+addressId).empty();
				document.getElementById("detail-"+addressId).focus();
			}
		}).open();
	}
	
	// 배송지 등록 버튼 이벤트
	function addAddress() {
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
	        		alert('배송지를 추가했습니다.');
	        		window.location.href = "${contextPath}/mypage/manageAddress";
	        	} else {
					alert('배송지를 추가하는 과정에서 오류가 발생했습니다.');
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

	// 수정 버튼 이벤트
	function updateAddress(addressId) {
		let isDefault = 0;
		if($('#isDefault-'+addressId).prop('checked')) {
			isDefault = 1;
		}

		let token = $("meta[name='_csrf']").attr("content");
	    let header = $("meta[name='_csrf_header']").attr("content");
	    let data = {
	    	addressId : addressId,
    		nickName : $('#nickName-'+addressId).val(),
			recipient : $('#recipient-'+addressId).val(),
			postCode : $('#postCode-'+addressId).val(),
			address : $('#address-'+addressId).val(),
			detail : $('#detail-'+addressId).val(),
			contact : $('#contact-'+addressId).val(),
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
	        		alert('배송지 정보를 수정했습니다.');
	        		window.location.href = "${contextPath}/mypage/manageAddress";
	        	} else {
					alert('배송지 정보를 수정하는 과정에서 오류가 발생했습니다.');
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
	function deleteAddress(addressId) {
		if(confirm("배송지를 삭제하시겠습니까?")) {
			let arr = new Array();
			arr.push(addressId);
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
						alert('배송지가 삭제되었습니다.');
						window.location.href = "${contextPath}/mypage/manageAddress";
					} else {
						alert('배송지를 삭제하는 과정에서 오류가 발생했습니다.');
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
	}
	
	// 선택 삭제 이벤트
	function optionalDeletion() {
		let checkBoxArray = new Array();
		for(let i=0; i<$('input[name=check]').length; i++) {
			if($('input[name=check]').eq(i).prop('checked')) {
				checkBoxArray.push(Number($('input[name=check]').eq(i).val()));
			}
		}
		
		if(checkBoxArray.length<1) alert('삭제하려는 배송지를 선택해주세요.');
		else {
			if(confirm("배송지를 삭제하시겠습니까?")) {
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
							alert('배송지가 삭제되었습니다.');
							window.location.href = "${contextPath}/mypage/manageAddress";
						} else {
							alert('배송지를 삭제하는 과정에서 오류가 발생했습니다.');
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
		}
	}
	
	// 기본 배송지 설정 이벤트
	function setDefaultAddress() {
		let checked = 0;
		let checkBoxArray = new Array();
		for(let i=0; i<$('input[name=check]').length; i++) {
			if($('input[name=check]').eq(i).prop('checked')) checked++;
		}
		if(checked==0) alert('기본 배송지로 설정할 배송지를 체크해주세요.');
		else if(checked>=2) alert('기본 배송지는 하나만 설정할 수 있습니다.');
		else {
			$("input[name=check]:checked").each(function() {
				if(confirm("기본 배송지를 설정하시겠습니까?")) {
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
				        		alert('기본 배송지를 설정했습니다.');
				        		window.location.href = "${contextPath}/mypage/manageAddress";
				        	} else {
								alert('기본 배송지를 설정하는 과정에서 오류가 발생했습니다.');
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
		}
	}
	
	// 기본 배송지 해지 버튼 이벤트
	function cancelDefault(addressId) {
		if(confirm("기본 배송지를 해지하시겠습니까?")) {
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
						alert('기본 배송지를 해지했습니다.');
						window.location.href = "${contextPath}/mypage/manageAddress";
					} else {
						alert('기본 배송지를 해지하는 과정에서 오류가 발생했습니다.');
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
	}
	
	
	$(document).ready(function() {
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