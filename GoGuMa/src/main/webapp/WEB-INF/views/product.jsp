<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://kit.fontawesome.com/985c0d22bf.js" crossorigin="anonymous"></script>

<head>
    <title>List</title>
    <style>
    	<%@ include file="/resources/css/style.css" %>
    </style>
    <script>
        $(document).ready(function () {
            $('#searchBtn').click(function () {
                var keyword = $("#keyword").val();
                // 검색 키워드가 존재하지 않는다면 '검색할 상품명을 입력하세요' alert창 띄워주기
                if (keyword != '') {
                    // 검색 동작 코드 작성하기
                    alert(keyword);
                } else {
                    alert('검색할 상품명을 입력하세요.');
                }
                // 검색 input box "" 초기화하기
            });

            $("#plus").click(function () {
                var num = $("#numBox").val();
                var plusNum = Number(num) + 1;
                $("#numBox").val(plusNum);

                //   if(plusNum >= ${view.gdsStock}) {
                //      $(".numBox").val(num);
                //   } else {
                //      $(".numBox").val(plusNum);          
                //   }
            });

            $("#minus").click(function () {
                var num = $("#numBox").val();
                var minusNum = Number(num) - 1;

                if (minusNum <= 0) {
                    $("#numBox").val(num);
                } else {
                    $("#numBox").val(minusNum);
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
        });
    </script>
</head>

<body>
	<div class="header">
	    <div class="search">
	        <input type="text" id="keyword" placeholder="상품명을 검색하세요" autocomplete="off">
	        <button type="button" class="searchBtn" id="searchBtn"></button>
	    </div>
	</div>
	<div class="prodlist">
		<div id="menu">
		    <ul class="main1">
		        <li><a href="#" class="category"><i class="fa-solid fa-bars"></i>카테고리</a> 
		            <ul class="main2">
		            <c:forEach items="${parentCategory}" var="parentCategory"><li>
		                    ${parentCategory.categoryName}
		                    <ul class="main3">
	                    	<c:forEach items="${parentCategory.categoryList}" var="category">
		                        <li><a href="#">${category.categoryName}</a></li>
		                    </c:forEach>
		                    </ul>
		                </li>
		            </c:forEach>
		            </ul>
		        </li>
		    </ul>
		</div>

        <h2 style="text-align: center">카테고리ID</h2>

        <hr>

        <div class="prodInfo">
            <img class="thumbnailImg" src="https://image.hmall.com/static/0/6/89/33/2133896030_0.jpg?RS=400x400&AR=0"
                style="float: left;" />
            <div class="product_detail">
                <table>
                    <td colspan='2'>
                        <h1>칼라 라인 가디건</h1>
                    </td>
                    <tr>
                        <td>가격</td>
                        <td>
                            <h2>158,940원</h2>
                        </td>
                    </tr>
                    <tr>
                        <td>적립금</td>
                        <td>3%</td>
                    </tr>
                    <tr>
                        <td>옵션</td>
                        <td>
                            <select name="상품 옵션">
                                <option value="">상품ID</option>
                                <option value="">상품ID</option>
                                <option value="">상품ID</option>
                                <option value="">상품ID</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>구입 수량</span>
                        <td>
                            <p class="cartStock">
                                <button type="button" class="calc" id="minus">-</button>
                                <input type="number" id="numBox" min="1" max="${view.gdsStock}" value="1"
                                    readonly="readonly" />
                                <button type="button" class="calc" id="plus">+</button>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td>총 상품금액</td>
                        <td class="total_price">
                            <h1>158,940원</h1>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button class="cartBtn" id="cartBtn"><i class="fa-solid fa-cart-plus"
                                    style="color: black"></i></button>
                        </td>
                        <td>
                            <button class="buyBtn" id="buyBtn">바로구매</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="tab">
            <ul class="tabnav">
                <li class="bottom-menu"><a href="#tab01">상품상세</a></li>
                <li class="bottom-menu"><a href="#tab02">상품평</a></li>
            </ul>
            <div class="tabcontent">
                <div id="tab01">
                    상품상세
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
                                    <img src="https://image.hmall.com/static/0/6/89/33/2133896030_0.jpg?RS=400x400&AR=0"
                                        alt="모달할 이미지">
                                </div>
                                <div class="imgC">
                                    <img src="https://image.hmall.com/static/0/6/89/33/2133896030_0.jpg?RS=400x400&AR=0"
                                        alt="모달할 이미지">
                                </div>
                                <div class="imgC">
                                    <img src="https://image.hmall.com/static/0/6/89/33/2133896030_0.jpg?RS=400x400&AR=0"
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