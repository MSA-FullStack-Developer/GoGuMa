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
        table {
            table-layout: fixed;
        }
        table tbody tr {
            line-height: 2rem;
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
                <div class="d-flex flex-row justify-content-evenly border border-2 rounded mb-4">
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
                <div>
                    <h5><b>주문상세</b></h5>
                </div>
                <div class="col border border-2 rounded p-4 mb-4">
                    <div class="d-flex flex-row">
                        <div class="col">
                            <h5><b>2022. 5. 26</b></h5>
                        </div>
                    </div>
                    <div class="border border-1 rounded">
                        <table>
                            <tbody>
                                <!--여기부터 forEach-->
                                <tr class="border-bottom">
                                    <td class="col-1 p-3">
                                        <img src="img\핫브레이크미니.jpg" style="width:100px; height:100px">
                                    </td>
                                    <td class="col-5 border-end">
                                        캐시미어 100% 리버시블 삼각 숄
                                    </td>
                                    <td class="border-end">
                                        <div class="col" align="center">
                                            <div>
                                                7,700원
                                            </div>
                                            <div>
                                                (1개)
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col" align="center">
                                            <div>
                                                <h5><b>주문 완료</b></h5>
                                            </div>
                                            <div class="mb-2">
                                                <button type="button" class="btn btn-sm btn-outline-dark">구매확정</button>
                                            </div>
                                            <div class="mt-2">
                                                <button type="button" class="btn btn-sm btn-outline-dark">주문취소</button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <!--여기까지 forEach-->
                                <tr class="border-bottom">
                                    <td class="col-1 p-3">
                                        <img src="img\아몬드세트.jpg" style="width:100px; height:100px">
                                    </td>
                                    <td class="col-5 border-end">
                                        와사비맛 아몬드, 210g, 1개
                                    </td>
                                    <td class="border-end">
                                        <div class="col" align="center">
                                            <div>
                                                4,560원
                                            </div>
                                            <div>
                                                (1개)
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col" align="center">
                                            <div>
                                                <h5><b>구매 완료</b></h5>
                                            </div>
                                            <div class="mb-2">
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
                <div>
                    <h5><b>배송지 정보</b></h5>
                </div>
                <table class="table mb-4" style="margin: auto;">
                    <tbody class="table-group-divider">
                        <tr>
                            <th>배송지 별칭</th>
                            <td>집</td>
                        </tr>
                        <tr>
                            <th>수령인</th>
                            <td>송진호</td>
                        </tr>
                        <tr>
                            <th>연락처</th>
                            <td>010-4474-8813</td>
                        </tr>
                        <tr>
                            <th>배송지 주소</th>
                            <td>경기도 광주시 오포읍 수레안길41번길 32-6</td>
                        </tr>
                        <tr>
                            <th>배송시 요청사항</th>
                            <td>초인종을 누르지 말아주세요.</td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <h5><b>할인 정보</b></h5>
                </div>
                <table class="table mb-4" style="margin: auto;">
                    <tbody class="table-group-divider">
                        <tr>
                            <th>멤버십 등급 할인</th>
                            <td>-10,000원</td>                           
                        </tr>
                         <tr>
                            <th>포인트 할인</th>
                            <td>-1,100원</td>
                        </tr>
                        <tr>
                            <th>쿠폰 할인</th>
                            <td>-5.000원</td>
                        </tr>

                        <tr>
                            <th>할인 합계</th>
                            <td><b>-16,000원</b></td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <h5><b>결제 정보</b></h5>
                </div>
                <table class="table mb-4" style="margin: auto;">
                    <tbody class="table-group-divider">
                        <tr>
                            <th>상품 합계</th>
                            <td>22,600원</td>                           
                        </tr>
                        <tr>
                            <th>할인 합계</th>
                            <td>-16,000원</td>
                        </tr>
                        <tr>
                            <th>예상 적립 포인트</th>
                            <td>122P</td>
                        </tr>
                        <tr>
                            <th>최종 결제금액</th>
                            <td><b>16,600원</b></td>
                        </tr>
                        <tr>
                            <th>결제수단</th>
                            <td>우리카드 일시불</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</html>