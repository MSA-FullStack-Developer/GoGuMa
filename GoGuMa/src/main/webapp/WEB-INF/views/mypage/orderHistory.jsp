<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
	<div class="container mt-5" style="min-width: 1200px">
		<div class="row">
			<div class="col-3">
                <div class="mb-4">
                    <h3><b>마이페이지</b></h3>
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
                <div class="d-flex flex-row justify-content-evenly border border-2 rounded mb-3">
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

                <div class="col border border-2 rounded p-4 mb-3">
                    <div class="d-flex flex-row">
                        <div class="col">
                            <h5><b>2022. 5. 26</b></h5>
                        </div>
                        <div class="d-flex flex-column">
                            주문 상세보기
                        </div>
                    </div>
                    <div class="border border-1 rounded">
                        <table>
                            <tbody>
                                <!--여기부터 forEach-->
                                <tr class="border-bottom">
                                    <td class="p-3">
                                        <img src="img\핫브레이크미니.jpg">
                                    </td>
                                    <td class="border-end">
                                        <div class="col">
                                            <div class="d-flex flex-row">
                                                핫브레이크 초코바, 50g, 10개입
                                            </div>
                                            <div class="d-flex flex-row">
                                                7,700원, 1개
                                            </div>
                                        </div>
                                    </td>
                                    <td >
                                        <div class="col">
                                            <div class="d-flex flex-row justify-content-center">
                                                <h5><b>주문 완료</b></h5>
                                            </div>
                                            <div class="d-flex flex-row justify-content-center mb-2">
                                                <button type="button" class="btn btn-sm btn-outline-dark">구매확정</button>
                                            </div>
                                            <div class="d-flex flex-row justify-content-center mt-2">
                                                <button type="button" class="btn btn-sm btn-outline-dark">주문취소</button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--여기까지 forEach-->
                                <tr>
                                    <td class="col-2 p-3">
                                        <img src="img\아몬드세트.jpg">
                                    </td>
                                    <td class="border-end">
                                        <div class="col">
                                            <div class="d-flex flex-row">
                                                와사비맛 아몬드, 210g, 1개
                                            </div>
                                            <div class="d-flex flex-row">
                                                4,560원, 1개
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col">
                                            <div class="d-flex flex-row justify-content-center">
                                                <h5><b>구매 완료</b></h5>
                                            </div>
                                            <div class="d-flex flex-row justify-content-center mb-2">
                                                <button type="button" class="btn btn-sm btn-outline-dark">상품평 쓰기</button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--여기까지 forEach-->
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col border border-2 rounded p-4 mb-3">
                    <div class="d-flex flex-row">
                        <div class="col">
                            <h5><b>2022. 5. 26</b></h5>
                        </div>
                        <div class="d-flex flex-column">
                            주문 상세보기
                        </div>
                    </div>
                    <div class="border border-1 rounded">
                        <table>
                            <tbody>
                                <!--여기부터 forEach-->
                                <tr class="border-bottom">
                                    <td class="p-3">
                                        <img src="img\핫브레이크미니.jpg">
                                    </td>
                                    <td class="border-end">
                                        <div class="col">
                                            <div class="d-flex flex-row">
                                                핫브레이크 초코바, 50g, 10개입
                                            </div>
                                            <div class="d-flex flex-row">
                                                7,700원, 1개
                                            </div>
                                        </div>
                                    </td>
                                    <td >
                                        <div class="col">
                                            <div class="d-flex flex-row justify-content-center">
                                                <h5><b>주문 취소</b></h5>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--여기까지 forEach-->
                                <tr>
                                    <td class="col-2 p-3">
                                        <img src="img\아몬드세트.jpg">
                                    </td>
                                    <td class="border-end">
                                        <div class="col">
                                            <div class="d-flex flex-row">
                                                와사비맛 아몬드, 210g, 1개
                                            </div>
                                            <div class="d-flex flex-row">
                                                4,560원, 1개
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col">
                                            <div class="d-flex flex-row justify-content-center">
                                                <h5><b>주문 완료</b></h5>
                                            </div>
                                            <div class="d-flex flex-row justify-content-center mb-2">
                                                <button type="button" class="btn btn-sm btn-outline-dark">구매확정</button>
                                            </div>
                                            <div class="d-flex flex-row justify-content-center mt-2">
                                                <button type="button" class="btn btn-sm btn-outline-dark">주문취소</button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--여기까지 forEach-->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</html>