<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    <h3><a href="../"><b>마이페이지</b></a></h3>
                </div>
                <div class="mb-4">
                    <div>
                        <h5><b>MY 쇼핑</b></h5>
                    </div>
                    <div>
                        주문내역
                    </div>
                </div>
                <div class="mb-4">
                    <div>
                        <h5><b>MY 혜택</b></h5>
                    </div>
                    <div>
                        포인트
                    </div>
                    <div >
                        예치금
                    </div>
                    <div>
                        쿠폰
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
                        배송지관리
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
                <div class="d-flex flex-row justify-content-evenly border rounded">
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
                <div class="mt-3" >
                    <h5><b>배송지 관리</b></h5>
                </div>
                <div class="mt-2">
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
                    <tbody>
                        <tr>
                            <td>${defaultAddress.nickName}</td>
                            <td>${defaultAddress.recipient}</td>
                            <td>${defaultAddress.address}</td>
                            <td>${defaultAddress.contact}</td>
                            <td><button type="button" class="btn btn-outline-danger btn-sm">기본 배송지 해지</button></td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <h5>배송지 목록</h5>
                </div>
                <table class="table table-hover mb-2" style="margin: auto; text-align: center">
                    <thead class="table-secondary table-group-divider">
                        <tr>
                            <th><input type="checkbox"></th>
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
	                                <button type="button" class="btn btn-outline-dark btn-sm">수정</button>
	                                <button type="button" id="${addressDTO.addressId}" class="btn btn-outline-dark btn-sm" onClick="deleteAddress(this.id)">삭제</button>
	                            </td>
                    		</tr>
                    	</tbody>
                    </c:forEach>
                </table>
                <div align="right">
                    <button type="button" class="btn btn-dark btn-sm" data-bs-toggle="modal" data-bs-target="#addAddressModal">배송지 등록</button>
                    <button type="button" id="deleteBtn" class="btn btn-danger btn-sm">선택 삭제</button>
                </div>
            </div>
		</div>
	</div>
    <div class="modal fade" id="addAddressModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel"><b>배송지 등록</b></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="" method="POST">
                        <div class="mb-1">
                            <label for="nickName" class="col-form-label">배송지 별칭</label>
                            <input type="text" class="form-control" id="nickName">
                        </div>
                        <div class="mb-1">
                            <label for="recipient" class="col-form-label">받는 분</label>
                            <input type="text" class="form-control" id="recipient">
                        </div>
                        <div class="mb-1">
                            <label for="deliveryAddress" class="col-form-label">배송지 주소</label>
                            <input type="text" class="form-control" id="deliveryAddress">
                        </div>
                        <div class="mb-1">
                            <label for="deliveryContact" class="col-form-label">연락처</label>
                            <input type="text" class="form-control" id="deliveryContact">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-dark">확인</button>
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
	function deleteAddress(addressId) {
		let arr = new Array();
		arr.push(Number(addressId));
		let token = $("meta[name='_csrf']").attr("content");
	    let header = $("meta[name='_csrf_header']").attr("content");
		$.ajax({ // checked된 checkbox의 value만 배열에 넣어서 전송
			url : '',
			type : 'POST',
			data : JSON.stringify(arr),
			contentType : "application/json; charset=utf-8;",
			beforeSend : function(xhr) {
	            xhr.setRequestHeader(header, token);
	        },
			success:function(result) {
				if(result==1) {
					alert('배송지 삭제 완료');
					window.location.href = "./1/";
				} else {
					alert('삭제 오류');
				}
			}
		});
	}
	$(document).ready(function() {
		$('#deleteBtn').on('click', function() {
			let checkBoxArray = new Array();
			for(let i=0; i<$('input[name=check]').length; i++) {
				if($('input[name=check]').eq(i).prop('checked')) {
					checkBoxArray.push(Number($('input[name=check]').eq(i).val()));
				}
			}
			
			let token = $("meta[name='_csrf']").attr("content");
		    let header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({ // checked된 checkbox의 value만 배열에 넣어서 전송
				url : '',
				type : 'POST',
				data : JSON.stringify(checkBoxArray),
				contentType : "application/json; charset=utf-8;",
				beforeSend : function(xhr) {
		            xhr.setRequestHeader(header, token);
	            },
				success:function(result) {
					if(result==1) {
						alert('배송지 삭제 완료');
						window.location.href = "../1/";
					} else {
						alert('삭제 오류');
					}
				}
			});
		});
	});
</script>
</html>
    